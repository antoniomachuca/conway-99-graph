#!/usr/bin/env python3
"""Campaign A, generalization to connected regular graphs (EXPLORED tooling, lead).

Gamma connected, k-regular, with Hoffman polynomial H(x) = prod_{theta != k distinct eigenvalue}(x - theta)
(integer coefficients), H(A) = c J with c = H(k)/v an integer.  For an integral eigenvalue theta != k put
P(x) = H(x)/(x - theta) (integer coefficients), c_th = (k - theta) P(theta).  For an automorphism sigma of prime
order p <= 19 with p not dividing c_th and condition
  (F)  det((k - theta)(P(theta) I - P(A_F)) + c J_f) != 0 (mod p),
the conclusions of thm:fix hold with (theta - theta') replaced by P(theta) and
alpha = v / gcd(v, P(k) - P(theta)).  This file: exact polynomial helpers, the parameter-level test from an
intersection array or a spectrum, and a checker on concrete graphs."""
import itertools
import json
import sys
import time
from fractions import Fraction
from math import gcd, isqrt

import numpy as np

from obstruction import bareiss_det, int_kernel, legendre, primes_of, vval
from fixed_points import cyclo_norm, det_mod_p

PRIMES = [3, 5, 7, 11, 13, 17, 19]


# ---------------------------------------------------------------- polynomials (lists, low degree first)
def pmul(a, b):
    out = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i + j] += x * y
    return out


def peval(a, x):
    s = 0
    for c in reversed(a):
        s = s * x + c
    return s


def pdiv_linear(a, r):
    """a(x)/(x - r), exact (r root)."""
    n = len(a) - 1
    q = [0] * n
    acc = a[n]
    q[n - 1] = acc
    for i in range(n - 1, 0, -1):
        acc = a[i] + acc * r
        q[i - 1] = acc
    assert a[0] + acc * r == 0, "not a root"
    return q


def charpoly_tridiag(b, c, k):
    """Characteristic polynomial (monic, integer) of the intersection matrix of i(b0..b_{d-1}; c1..c_d)."""
    d = len(c)
    a = [k - (b[i] if i < d else 0) - (c[i - 1] if i > 0 else 0) for i in range(d + 1)]
    # det(xI - L) for tridiagonal L with L[i][i]=a_i, L[i][i+1]=b_i, L[i+1][i]=c_{i+1}
    p_prev, p_cur = [1], [-a[0], 1]
    for i in range(1, d + 1):
        nxt = pmul([-a[i], 1], p_cur)
        sub = [b[i - 1] * c[i - 1] * t for t in p_prev]
        for j in range(len(sub)):
            nxt[j] -= sub[j]
        p_prev, p_cur = p_cur, nxt
    return p_cur, a


def int_roots(poly, bound):
    return [x for x in range(-bound, bound + 1) if peval(poly, x) == 0]


def drg_data(b, c):
    k = b[0]
    d = len(c)
    ks = [1]
    for i in range(d):
        num = ks[-1] * b[i]
        if num % c[i]:
            return None
        ks.append(num // c[i])
    v = sum(ks)
    cp, a = charpoly_tridiag(b, c, k)
    if peval(cp, k) != 0:
        return None
    H = pdiv_linear(cp, k)
    roots = int_roots(H, k)
    # multiplicities m(theta) = v / sum_i k_i u_i(theta)^2
    mult = {}
    for th in roots:
        u = [Fraction(1), Fraction(th, k)]
        for i in range(1, d):
            u.append(((th - a[i]) * u[i] - c[i - 1] * u[i - 1]) / b[i])
        s = sum(ks[i] * u[i] ** 2 for i in range(d + 1))
        m = Fraction(v) / s
        mult[th] = m
    Hk = peval(H, k)
    if Hk % v:
        return None
    return {"v": v, "k": k, "H": H, "c": Hk // v, "roots": roots, "mult": mult, "a1": a[1] if d >= 1 else 0,
            "c2": c[1] if d >= 2 else None, "diam": d}


def test_theta(v, k, H, c, th, f_th, p):
    """'n/a', 'R', 'D' or 'ok' for one integral eigenvalue th."""
    P = pdiv_linear(H, th)
    Pth, Pk = peval(P, th), peval(P, k)
    cth = (k - th) * Pth
    if cth % p == 0:
        return "n/a", None
    if f_th.denominator != 1 or f_th.numerator % p:
        return "R", None
    a = f_th.numerator // p
    alpha = v // gcd(v, Pk - Pth)
    S = set(primes_of(cth))
    constrained = [l for l in primes_of(v) if l != p and (alpha * Pth) % l]
    forced, free_nonsq, parity_fail = 1, False, None
    for l in constrained:
        if l not in S or a == 0:
            if vval(v, l) % 2:
                parity_fail = l
        else:
            forced *= legendre(l, p) ** vval(v, l)
    if a > 0:
        free_nonsq = any(legendre(l, p) == -1 for l in S if l not in constrained)
    if parity_fail:
        return "D", {"parity_fail": parity_fail}
    chi_d = {1, -1} if free_nonsq else {forced}
    gens = [q % p for q in primes_of(Pth)] if a > 0 else []
    reach, fr = {1}, [1]
    while fr:
        x = fr.pop()
        for q in gens:
            y = x * q % p
            if y not in reach:
                reach.add(y)
                fr.append(y)
    chi_dp = {1 if x == 1 else -1 for x in reach if x in (1, p - 1)}
    return ("D" if not (chi_d & chi_dp) else "ok"), {"P_th": Pth, "P_k": Pk, "c_th": cth}


# ---------------------------------------------------------------- concrete graphs
def spectrum_int(adj):
    n = len(adj)
    A = np.zeros((n, n))
    for x in range(n):
        for y in adj[x]:
            A[x, y] = 1
    ev = np.linalg.eigvalsh(A)
    rnd = np.round(ev)
    assert np.max(np.abs(ev - rnd)) < 1e-6, "non-integral spectrum"
    vals, cnts = np.unique(rnd.astype(int), return_counts=True)
    return {int(v_): int(c_) for v_, c_ in zip(vals, cnts)}


def matpoly_apply(adj_list_mat, poly):
    """poly(Matrix) for small integer matrices given as list of lists."""
    n = len(adj_list_mat)
    Mx = np.array(adj_list_mat, dtype=object)
    res = np.zeros((n, n), dtype=object)
    Pw = np.identity(n, dtype=object)
    for coef in poly:
        res = res + coef * Pw
        Pw = Pw.dot(Mx)
    return res


def check_general(n, adj, sigma, p):
    spec = spectrum_int(adj)
    k = len(adj[0])
    assert all(len(adj[x]) == k for x in range(n))
    others = [t for t in spec if t != k]
    H = [1]
    for t in others:
        H = pmul(H, [-t, 1])
    c = peval(H, k) // n
    assert peval(H, k) % n == 0
    fixed = [x for x in range(n) if sigma[x] == x]
    reps, seen = [], set(fixed)
    for x in range(n):
        if x not in seen:
            orb = [x]
            while sigma[orb[-1]] != x:
                orb.append(sigma[orb[-1]])
            assert len(orb) == p
            seen.update(orb)
            reps.append(x)
    m, f = len(reps), len(fixed)
    powr = []
    for x in reps:
        row = [x]
        for _ in range(p - 1):
            row.append(sigma[row[-1]])
        powr.append(row)
    Ab = [[[int(powr[V][b] in adj[reps[U]]) for V in range(m)] for U in range(m)] for b in range(p)]
    Q = [[sum(Ab[b][U][V] for b in range(p)) for V in range(m)] for U in range(m)]
    amat = [[int(t in adj[reps[U]]) for t in fixed] for U in range(m)]
    AF = [[int(t2 in adj[t1]) for t2 in fixed] for t1 in fixed]
    At = [Q[U] + amat[U] for U in range(m)] + [[p * amat[U][i] for U in range(m)] + AF[i] for i in range(f)]
    wts = [p] * m + [1] * f
    out = {"v": n, "k": k, "spec": spec, "c": c, "p": p, "m": m, "f": f, "thetas": {}}
    for th in others:
        P = pdiv_linear(H, th)
        Pth, Pk = peval(P, th), peval(P, k)
        cth = (k - th) * Pth
        rec = {"applicable": cth % p != 0, "f_th": spec[th]}
        if f:
            PAF = matpoly_apply(AF, P)
            Xf = [[(k - th) * ((Pth if i == j else 0) - int(PAF[i][j])) + c for j in range(f)] for i in range(f)]
            rec["condF"] = det_mod_p(Xf, p)
        else:
            rec["condF"] = 1
        AtmI = [[At[i][j] - (th if i == j else 0) for j in range(m + f)] for i in range(m + f)]
        L = int_kernel(AtmI, m + f)
        a = len(L)
        G = [[sum(wts[t] * u[t] * w[t] for t in range(m + f)) for w in L] for u in L]
        d = bareiss_det(G)
        ap, nd = cyclo_norm(Ab, m, p, th)
        rec.update({"a": a, "a_prime": ap, "N_dprime": nd})
        if rec["applicable"] and rec["condF"]:
            ok = {"fixed_div": all(u[m + i] % p == 0 for u in L for i in range(f)),
                  "d_div_p^a": d % p ** a == 0, "rank_equal": a == ap, "p|f_th": spec[th] % p == 0}
            dt = d // p ** a if ok["d_div_p^a"] else None
            if dt:
                ok["dt|c_th^a"] = abs(cth) ** a % dt == 0
                ok["Nd|P^.."] = abs(Pth) ** (a * (p - 1) // 2) % nd == 0
                r_ = nd % p
                ok["legendre"] = legendre(dt, p) == (1 if r_ == 1 else (-1 if r_ == p - 1 else 99))
                alpha = n // gcd(n, Pk - Pth)
                ok["parity"] = all(vval(dt, l) % 2 == vval(n, l) % 2 for l in primes_of(n)
                                   if l != p and (alpha * Pth) % l)
            rec["checks"] = ok
            rec["ALLOK"] = all(ok.values())
        # parameter-level verdict
        verdict, _ = test_theta(n, k, H, c, th, Fraction(spec[th]), p)
        rec["param"] = verdict
        out["thetas"][th] = rec
    return out


# ------------------------------------------------------------ families of controls
def johnson(n, kk):
    S = list(itertools.combinations(range(n), kk))
    idx = {s: i for i, s in enumerate(S)}
    adj = [set() for _ in S]
    for i, s in enumerate(S):
        for j, t in enumerate(S):
            if len(set(s) & set(t)) == kk - 1:
                adj[i].add(j)
    return S, idx, adj


def kneser(n, kk):
    S = list(itertools.combinations(range(n), kk))
    adj = [set(j for j, t in enumerate(S) if not set(s) & set(t)) for s in S]
    return S, {s: i for i, s in enumerate(S)}, adj


def hamming(dd, q):
    W = list(itertools.product(range(q), repeat=dd))
    idx = {w: i for i, w in enumerate(W)}
    adj = [set(idx[w2] for w2 in W if sum(x != y for x, y in zip(w, w2)) == 1) for w in W]
    return W, idx, adj


def perm_cycles(npts, p, ncyc):
    perm = list(range(npts))
    for cc in range(ncyc):
        for t in range(p):
            perm[cc * p + t] = cc * p + (t + 1) % p
    return perm


if __name__ == "__main__":
    cases = []
    for (n, kk, p, ncyc) in [(9, 3, 7, 1), (10, 3, 7, 1), (11, 3, 5, 2), (12, 3, 5, 2), (11, 3, 11, 1), (13, 3, 13, 1),
                             (10, 4, 7, 1), (11, 4, 5, 2), (13, 3, 5, 2), (9, 3, 3, 3), (9, 4, 7, 1), (12, 3, 11, 1)]:
        S, idx, adj = johnson(n, kk)
        perm = perm_cycles(n, p, ncyc)
        sig = [idx[tuple(sorted(perm[x] for x in s))] for s in S]
        cases.append((f"J({n},{kk}) {ncyc}x{p}", adj, sig, p))
        S2, idx2, adj2 = kneser(n, kk)
        sig2 = [idx2[tuple(sorted(perm[x] for x in s))] for s in S2]
        cases.append((f"K({n},{kk}) {ncyc}x{p}", adj2, sig2, p))
    for (dd, q, p) in [(3, 5, 5), (3, 6, 5), (2, 7, 5), (3, 4, 3), (4, 3, 3), (2, 11, 7), (3, 7, 5)]:
        W, idx, adj = hamming(dd, q)
        symb = [(s + 1) % p if s < p else s for s in range(q)]          # p-cycle on the first p symbols
        sig = [idx[tuple(symb[x] for x in w)] for w in W]
        cases.append((f"H({dd},{q}) symb-{p}", adj, sig, p))
    for name, adj, sig, p in cases:
        t0 = time.time()
        nv = len(adj)
        assert all((sig[a] in adj[sig[b]]) == (a in adj[b]) for a in range(nv) for b in adj[a])
        try:
            res = check_general(nv, adj, sig, p)
        except AssertionError as e:
            print(json.dumps({"graph": name, "skip": str(e)}), flush=True)
            continue
        res["graph"] = name
        res["secs"] = round(time.time() - t0, 1)
        print(json.dumps(res, default=str), flush=True)
