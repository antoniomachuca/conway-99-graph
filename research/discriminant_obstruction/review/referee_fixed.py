#!/usr/bin/env python3
"""Independent referee implementation for the fixed-point section (thm:fix, lem:bigp,
cor:full) of discriminant_obstruction.tex.  Written from the note's statements; shares
only my own earlier referee.py primitives (lattice saturation, cyclotomic trace form).

Notation follows the note: v = pm + f; At = [[Q, a],[p a^T, A_F]] on Z^{m+f};
D = diag(pI_m, I_f); w = (p,...,p,1,...,1); N = (k-th)(At - th' I) - mu 1 w^T;
condition (F): det((k-th)(th I - A_F) + mu J_f) != 0 mod p.
"""
import itertools
import json
from math import gcd, isqrt

from sympy import Matrix
from flint import fmpz_mat

from referee import (primes_of, vval, legendre, eigen,
                     mul_matrix, mulmod, triangular, srg_params_ok)


def trace_form_val(u, w, p):
    """Tr_{K/Q}(u * conj(w)) on power-basis vectors (basis z^0..z^{p-2});
    conj(z^j) = z^{p-j}, and z^{p-1} = -(1+z+...+z^{p-2})."""
    d = p - 1
    cw = [0] * d
    for j in range(d):
        e = (p - j) % p            # exponent of conj(z^j)
        if e < d:
            cw[e] += w[j]
        else:                      # e == p-1 == d
            for i in range(d):
                cw[i] -= w[j]
    pr = mulmod(u, cw, p)
    return pr[0] * p - sum(pr)


# ------------------------------------------------------------- lattice helpers

def sat_basis(A, ncols):
    """Basis of the saturated integer kernel ker_Z(A) = Z^ncols cap ker_Q A.
    Via python-flint row HNF of A^T: U * A^T = H with U unimodular; the rows of
    U beyond the rank vanish on A^T, hence their transposes span ker_Z A."""
    At = fmpz_mat([[A[j][i] for j in range(len(A))] for i in range(ncols)])
    H, U = At.hnf(transform=True)
    r = sum(1 for i in range(H.nrows()) if any(int(H[i, j]) for j in range(H.ncols())))
    cols = []
    for i in range(r, U.nrows()):
        cols.append([int(U[i, j]) for j in range(ncols)])
    return cols


def cyclo_kernel_norm(Ab, m, p, th):
    """Independent a', N_{K+/Q}(d') for L' = ker_{O_K}(M - th I) via the regular
    representation on Z^{(p-1)m} and the trace form (det = p^{(p-2)a'} N(d')^2)."""
    d = p - 1

    def ent(U, V):
        coef = [0] * d
        for b in range(p):
            if Ab[b][U][V]:
                if b < d:
                    coef[b] += 1
                else:
                    for i in range(d):
                        coef[i] -= 1
        return coef

    R = [[0] * (d * m) for _ in range(d * m)]
    for U in range(m):
        for V in range(m):
            coef = ent(U, V)
            if U == V:
                coef[0] -= th
            blk = mul_matrix(coef, p)
            for i in range(d):
                for j in range(d):
                    R[d * U + i][d * V + j] = blk[i][j]
    Lp = sat_basis(R, d * m)
    assert len(Lp) % d == 0
    ap = len(Lp) // d
    def form(u, w):
        return sum(trace_form_val(u[d * U:d * U + d], w[d * U:d * U + d], p)
                   for U in range(m))

    Gram = Matrix(len(Lp), len(Lp), lambda i, j: form(Lp[i], Lp[j]))
    detZ = int(Gram.det())
    base = p ** ((p - 2) * ap)
    assert detZ % base == 0
    nd = isqrt(detZ // base)
    assert nd * nd == detZ // base
    return ap, nd


def det_mod_p(Mat, p):
    n = len(Mat)
    A = [[x % p for x in row] for row in Mat]
    det = 1
    for c in range(n):
        piv = next((r for r in range(c, n) if A[r][c]), None)
        if piv is None:
            return 0
        if piv != c:
            A[c], A[piv] = A[piv], A[c]
            det = -det
        det = det * A[c][c] % p
        inv = pow(A[c][c], p - 2, p)
        for r in range(c + 1, n):
            f = A[r][c] * inv % p
            if f:
                for cc in range(c, n):
                    A[r][cc] = (A[r][cc] - f * A[c][cc]) % p
    return det % p


def condF(k, mu, th, AF, p):
    f = len(AF)
    if f == 0:
        return 1
    return det_mod_p(
        [[(k - th) * ((th if i == j else 0) - AF[i][j]) + mu
          for j in range(f)] for i in range(f)], p)


# ------------------------------------------------------------- graph analysis

def analyze_fixed(n, adj, sigma, p):
    """All theorem quantities for (graph, sigma, p), both theta choices."""
    # orbit decomposition
    fixed = [x for x in range(n) if sigma[x] == x]
    seen = set(fixed)
    reps = []
    for x in range(n):
        if x not in seen:
            orb = [x]
            while sigma[orb[-1]] != x:
                orb.append(sigma[orb[-1]])
            assert len(orb) == p, "non-regular orbit"
            seen.update(orb)
            reps.append(x)
    m, f = len(reps), len(fixed)
    orb_of = {}
    for U, x in enumerate(reps):
        y = x
        for _ in range(p):
            orb_of[y] = U
            y = sigma[y]
    # blocks
    powr = {}
    for U, x in enumerate(reps):
        row = [x]
        for _ in range(p - 1):
            row.append(sigma[row[-1]])
        powr[x] = row
    Ab = [[[int(powr[reps[V]][b] in adj[reps[U]]) for V in range(m)]
           for U in range(m)] for b in range(p)]
    Q = [[sum(Ab[b][U][V] for b in range(p)) for V in range(m)] for U in range(m)]
    amat = [[int(t in adj[reps[U]]) for t in fixed] for U in range(m)]
    AF = [[int(t2 in adj[t1]) for t2 in fixed] for t1 in fixed]
    At = [Q[U] + amat[U] for U in range(m)] + \
         [[p * amat[U][i] for U in range(m)] + AF[i] for i in range(f)]
    wts = [p] * m + [1] * f

    k = len(adj[0])
    y = next(iter(adj[0]))
    lam = len(adj[0] & adj[y])
    nz = next(z for z in range(n) if z not in adj[0] and z != 0)
    mu = len(adj[0] & adj[nz])
    r, s, fr, fs = eigen(n, k, lam, mu)
    out = {"v": n, "k": k, "lam": lam, "mu": mu, "p": p, "m": m, "f": f,
           "r": r, "s": s, "fr": fr, "fs": fs}
    for th, th2, fth in ((r, s, fr), (s, r, fs)):
        rec = {}
        c = (k - th) * (th - th2)
        rec["applicable"] = c % p != 0
        rec["condF"] = condF(k, mu, th, AF, p)
        L = sat_basis([[At[i][j] - (th if i == j else 0) for j in range(m + f)]
                       for i in range(m + f)], m + f)
        a = len(L)
        G = Matrix(a, a, lambda i, j: sum(wts[t] * L[i][t] * L[j][t]
                                          for t in range(m + f)))
        detGD = int(G.det())
        rec["fixed_div"] = all(u[m + i] % p == 0 for u in L for i in range(f))
        rec["detGD"] = detGD
        dt = detGD // (p ** a) if detGD % (p ** a) == 0 else None
        rec["d_tilde"] = dt
        rec["a"] = a
        rec["f_th"] = fth
        ap, nd = cyclo_kernel_norm(Ab, m, p, th)
        rec["a_prime"] = ap
        rec["N_dprime"] = nd
        if rec["applicable"] and rec["condF"]:
            ok = {"fixed_div": rec["fixed_div"],
                  "p^a|detGD": detGD % (p ** a) == 0,
                  "rank_eq": a == ap,
                  "p|f_th": fth % p == 0}
            if dt:
                ok["dt|c^a"] = (abs(c) ** a) % dt == 0
                ok["Nd|"] = (abs(th - th2) ** (a * (p - 1) // 2)) % nd == 0
                nres = nd % p
                ok["legendre"] = legendre(dt, p) == \
                    (1 if nres == 1 else (-1 if nres == p - 1 else 99))
                g = gcd(n, k - th)
                alpha = n // g
                ok["parity"] = all(vval(dt, l) % 2 == vval(n, l) % 2
                                   for l in primes_of(n)
                                   if l != p and (alpha * (th - th2)) % l)
            rec["checks"] = ok
            rec["ALLOK"] = all(ok.values())
        out[f"th={th}"] = rec
    return out


# ------------------------------------------------------------- parameter test

def my_test_general(v, k, lam, mu, pmax=19):
    """Parameter-level consequence of thm:fix, written from the statement:
    for applicable (p,th), 'R' if p !| f_th; 'D' if (a)-(d) arithmetically
    impossible (Legendre-window empty or forced parity contradiction)."""
    e = eigen(v, k, lam, mu)
    if e is None:
        return None
    r, s, fr, fs = e
    out = {}
    for p in [q for q in range(3, pmax + 1) if all(q % t for t in range(2, q))]:
        for th, th2, fth in ((r, s, fr), (s, r, fs)):
            c = (k - th) * (th - th2)
            if c % p == 0:
                continue
            if fth % p:
                out[(p, th)] = "R"
                continue
            a = fth // p
            g = gcd(v, k - th)
            alpha = v // g
            S = set(primes_of(c))
            constrained = [l for l in primes_of(v)
                           if l != p and (alpha * (th - th2)) % l]
            forced = 1
            parity_fail = None
            for l in constrained:
                if l not in S or a == 0:
                    if vval(v, l) % 2:
                        parity_fail = l
                else:
                    forced *= legendre(l, p) ** vval(v, l)
            free_nonsq = (a > 0 and
                          any(legendre(l, p) == -1 for l in S
                              if l not in constrained))
            if parity_fail:
                out[(p, th)] = "D"
                continue
            chi_d = {1, -1} if free_nonsq else {forced}
            gens = [q % p for q in primes_of(th - th2)] if a > 0 else []
            reach, fr_ = {1}, [1]
            while fr_:
                x = fr_.pop()
                for q in gens:
                    y = x * q % p
                    if y not in reach:
                        reach.add(y)
                        fr_.append(y)
            chi_dp = {1 if x == 1 else -1 for x in reach if x in (1, p - 1)}
            out[(p, th)] = "D" if not (chi_d & chi_dp) else "ok"
    return {"r": r, "s": s, "tests": out}


# ------------------------------------------------------------- fixed subgraphs
# My own enumeration of admissible Gamma_F: joins of parts, where a part is a
# regular induced subgraph on a complement-connected component.  Part types:
#   K1;  edgeless E_n (requires mu = f - n);  union of >= 2 cliques aK... ;
#   primitive srg(n,d,li,mi) with li = lam-f+n, mi = mu-f+n >= 1.
# For f <= 7 also enumerated EXHAUSTIVELY over all 2^C(f,2) graphs as ground truth.

def srg_feasible_spectrum(n, d, l, m):
    """Return [(eig,mult),...] (with conference 'quad' marker) or None."""
    if not (0 < d < n - 1) or m < 1 or d * (d - l - 1) != m * (n - 1 - d):
        return None
    disc = (l - m) ** 2 + 4 * (d - m)
    sq = isqrt(disc)
    if sq * sq == disc:
        if (l - m + sq) % 2:
            return None
        r, s = (l - m + sq) // 2, (l - m - sq) // 2
        num = -(d + (n - 1) * s)
        if num % (r - s):
            return None
        fr = num // (r - s)
        fs = n - 1 - fr
        if fr <= 0 or fs <= 0:
            return None
        return [(d, 1), (r, fr), (s, fs)]
    if n == 4 * m + 1 and d == 2 * m and l == m - 1:
        return [(d, 1), ("quad", (n - 1) // 2)]
    return None


def my_part_types(f, lam, mu):
    parts = [{"n": 1, "d": 0, "kind": "K1", "li": 0, "mi": 0, "spec": [(0, 1)]}]
    for n in range(2, f + 1):
        if mu == f - n:
            parts.append({"n": n, "d": 0, "kind": f"E{n}",
                          "li": lam - f + n, "mi": mu - f + n,
                          "spec": [(0, n)]})
        li, mi = lam - f + n, mu - f + n
        if mi == 0 and li >= 0:          # union of cliques of size li+2
            a = li + 2
            if n % a == 0 and n // a >= 2:
                mm = n // a
                parts.append({"n": n, "d": a - 1, "kind": f"{mm}K{a}", "li": li,
                              "mi": mi,
                              "spec": [(a - 1, mm), (-1, mm * (a - 1))]})
        if mi >= 1 and li >= 0:
            for d in range(1, n - 1):
                sp = srg_feasible_spectrum(n, d, li, mi)
                if sp:
                    parts.append({"n": n, "d": d, "li": li, "mi": mi,
                                  "kind": f"srg({n},{d},{li},{mi})", "spec": sp})
    return parts


def my_fixed_subgraphs(f, lam, mu):
    """Admissible join decompositions of Gamma_F (f >= 2)."""
    if f < 2:
        return []
    types = my_part_types(f, lam, mu)
    res = []
    for t in types:
        if t["n"] == f and t["kind"].startswith("srg"):
            res.append([t])
    # t = 2: need (d1-n1)+(d2-n2) = lam - f, n1+n2 = f
    for i, t1 in enumerate(types):
        for t2 in types[i:]:
            if t1["n"] + t2["n"] == f and \
               (t1["d"] - t1["n"]) + (t2["d"] - t2["n"]) == lam - f:
                res.append([t1, t2])
    # t >= 3: all e_i = (lam-f)/2
    if (lam - f) % 2 == 0:
        e = (lam - f) // 2
        cands = [t for t in types if t["n"] < f and t["d"] - t["n"] == e]
        for r_ in range(3, f + 1):
            for combo in itertools.combinations_with_replacement(range(len(cands)), r_):
                if sum(cands[i]["n"] for i in combo) == f:
                    res.append([cands[i] for i in combo])
    return res


def exhaustive_graphs_f(f, lam, mu):
    """Ground truth for f <= 7: all graphs on f vertices satisfying the
    common-neighbour conditions (lambda on edges, mu off edges), returned as
    adjacency matrices."""
    if f < 2 or f > 7:
        return None
    edges = list(itertools.combinations(range(f), 2))
    out = []
    for mask in range(1 << len(edges)):
        A = [[0] * f for _ in range(f)]
        for i, (u, v) in enumerate(edges):
            if mask >> i & 1:
                A[u][v] = A[v][u] = 1
        ok = True
        for u, v in edges:
            c = sum(A[u][w] and A[v][w] for w in range(f))
            if c != (lam if A[u][v] else mu):
                ok = False
                break
        if ok:
            out.append(A)
    return out


def det_F_direct(AF, k, mu, th, p):
    return condF(k, mu, th, AF, p)


# ------------------------------------------------------------- constructions

def paley(q, char, e, prim_coeffs):
    """Paley graph on F_q = F_char[x]/(prim). prim_coeffs = lower coeffs of
    monic irreducible (poly = x^e + c_{e-1} x^{e-1} + ... + c_0)."""
    els = list(itertools.product(range(char), repeat=e))

    def add(x, y):
        return tuple((a + b) % char for a, b in zip(x, y))

    def mul(x, y):
        pr = [0] * (2 * e - 1)
        for i, a in enumerate(x):
            for j, b in enumerate(y):
                pr[i + j] = (pr[i + j] + a * b) % char
        for dg in range(2 * e - 2, e - 1, -1):
            c = pr[dg]
            if c:
                pr[dg] = 0
                for i, cc in enumerate(prim_coeffs):
                    pr[dg - e + i] = (pr[dg - e + i] - c * cc) % char
        return tuple(pr[:e])

    zero = (0,) * e
    sq = {mul(x, x) for x in els if x != zero}
    idx = {x: i for i, x in enumerate(els)}
    adj = [set() for _ in els]
    for x in els:
        for y in els:
            if x != y and add(x, tuple((-b) % char for b in y)) in sq:
                adj[idx[x]].add(idx[y])
    return els, idx, adj, mul, sq


def paley_sigma_order(q, char, e, prim_coeffs, order):
    els, idx, adj, mul, sq = paley(q, char, e, prim_coeffs)
    one = (1,) + (0,) * (e - 1)
    g = None
    for x in sq:
        if x == one:
            continue
        y, o = x, 1
        while y != one and o <= q:
            y = mul(y, x)
            o += 1
        if y == one and o == order:
            g = x
            break
    assert g is not None
    return len(els), adj, [idx[mul(g, x)] for x in els]


def tri_sigma_cycles(n, p, ncycles):
    perm = list(range(n))
    for c in range(ncycles):
        for t in range(p):
            perm[c * p + t] = c * p + (t + 1) % p
    pairs = list(itertools.combinations(range(n), 2))
    idx = {pr: i for i, pr in enumerate(pairs)}
    _, adj = triangular(n)
    sig = [idx[tuple(sorted((perm[a], perm[b])))] for a, b in pairs]
    return len(pairs), adj, sig


def complement(n, adj):
    return [set(range(n)) - adj[x] - {x} for x in range(n)]
