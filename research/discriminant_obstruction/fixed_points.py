#!/usr/bin/env python3
"""Campaign A, fixed-point extension (EXPLORED tooling, lead).

sigma of prime order p with fixed set F (f = |F|, adjacency A_F) and m regular orbits, v = pm + f.
Trivial isotypic part: At = [[Q, a], [p a^T, A_F]] on Z^(m+f), weighted form D = diag(p I_m, I_f),
J acts as 1 w^T with w = (p,...,p,1,...,1).  Nontrivial part: M = sum_b zeta^b A_b on the regular orbits.
For th in {r, s}, th2 the other one, c = (k-th)(th-th2), with p not dividing c, and condition
  (F)  det((k-th)(th I - A_F) + mu J_f) != 0 (mod p),
every vector of L = ker_Z(At - th) has fixed coordinates divisible by p, G = B^T D B = p Gt, and
  (a) a = a' (so p | f_th);  (b) dt = det Gt divides c^a, N(d') divides (th-th2)^(a(p-1)/2);
  (c) Legendre(dt/p) = N_{K+/Q}(d') mod p (p <= 19);
  (d) for primes l != p, l | v, l not dividing alpha (th-th2), alpha = v/gcd(v, k-th): v_l(dt) = v_l(v) mod 2.
Parameter-level consequence: if (a)-(d) are arithmetically impossible for (v,k,lam,mu,p,th), then every
automorphism of order p has a fixed subgraph with det((k-th)(th I - A_F) + mu J_f) = 0 (mod p); with f = 0
(determinant 1) this excludes fixed-point-free automorphisms of order p."""
import itertools
import json
import sys
import time
from math import gcd, isqrt

from obstruction import bareiss_det, eigen, int_kernel, legendre, primes_of, triangular, vval


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


def condition_F(k, mu, th, AF, p):
    f = len(AF)
    if f == 0:
        return 1
    Mt = [[(k - th) * ((th if i == j else 0) - AF[i][j]) + mu for j in range(f)] for i in range(f)]
    return det_mod_p(Mt, p)


def cyclo_norm(Ab, m, p, th):
    """rank a' and N_{K+/Q}(d') of L' = ker_{O_K}(M - th I), M = sum_b zeta^b A_b (m x m)."""
    D = p - 1

    def ent(U, V):
        coef = [0] * D
        for b in range(p):
            if Ab[b][U][V]:
                if b < p - 1:
                    coef[b] += 1
                else:
                    for i in range(D):
                        coef[i] -= 1
        return coef

    def mulmat(coef):
        cols = []
        for j in range(D):
            prod = [0] * p
            for i in range(D):
                prod[(i + j) % p] += coef[i]
            cols.append([prod[t] - prod[p - 1] for t in range(D)])
        return [[cols[j][i] for j in range(D)] for i in range(D)]

    R = [[0] * (D * m) for _ in range(D * m)]
    for U in range(m):
        for V in range(m):
            coef = ent(U, V)
            if U == V:
                coef[0] -= th
            blk = mulmat(coef)
            for i in range(D):
                for j in range(D):
                    R[D * U + i][D * V + j] = blk[i][j]
    Lp = int_kernel(R, D * m)
    assert len(Lp) % D == 0
    ap = len(Lp) // D
    trf = [[(p - 1) if i == j else -1 for j in range(D)] for i in range(D)]

    def form(u, w):
        return sum(u[D * U + i] * trf[i][j] * w[D * U + j] for U in range(m) for i in range(D) for j in range(D))

    detZ = bareiss_det([[form(u, w) for w in Lp] for u in Lp])
    base = p ** ((p - 2) * ap)
    assert detZ % base == 0
    nd = isqrt(detZ // base)
    assert nd * nd == detZ // base
    return ap, nd


def check_graph_general(n, adj, sigma, p):
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
    a_mat = [[int(t in adj[reps[U]]) for t in fixed] for U in range(m)]
    AF = [[int(t2 in adj[t1]) for t2 in fixed] for t1 in fixed]
    At = [Q[U] + a_mat[U] for U in range(m)] + [[p * a_mat[U][i] for U in range(m)] + AF[i] for i in range(f)]
    wts = [p] * m + [1] * f
    k = len(adj[0])
    y = next(iter(adj[0]))
    lam = len(adj[0] & adj[y])
    mu = len(adj[0] & adj[next(z for z in range(1, n) if z not in adj[0])])
    r, s, fr, fs = eigen(n, k, lam, mu)
    out = {"v": n, "k": k, "lam": lam, "mu": mu, "p": p, "m": m, "f": f}
    for th, th2, fth in ((r, s, fr), (s, r, fs)):
        rec = {}
        c = (k - th) * (th - th2)
        rec["applicable"] = c % p != 0
        rec["condF_det_mod_p"] = condition_F(k, mu, th, AF, p)
        AtmI = [[At[i][j] - (th if i == j else 0) for j in range(m + f)] for i in range(m + f)]
        L = int_kernel(AtmI, m + f)
        a = len(L)
        G = [[sum(wts[t] * u[t] * w[t] for t in range(m + f)) for w in L] for u in L]
        d = bareiss_det(G)
        rec["fixed_coords_div_p"] = all(u[m + i] % p == 0 for u in L for i in range(f))
        ap, nd = cyclo_norm(Ab, m, p, th)
        rec.update({"a": a, "a_prime": ap, "N_dprime": nd, "f_th": fth})
        if rec["applicable"] and rec["condF_det_mod_p"] != 0:
            ok = {}
            ok["fixed_div"] = rec["fixed_coords_div_p"]
            ok["d_div_p^a"] = d % (p ** a) == 0
            dt = d // (p ** a) if ok["d_div_p^a"] else None
            rec["d_tilde"] = dt
            ok["rank_equal"] = a == ap
            ok["p_divides_f_th"] = fth % p == 0
            if dt:
                ok["dt_divides_c^a"] = (abs(c) ** a) % dt == 0
                ok["Nd_divides"] = (abs(th - th2) ** (a * (p - 1) // 2)) % nd == 0
                nres = nd % p
                ok["legendre"] = legendre(dt, p) == (1 if nres == 1 else (-1 if nres == p - 1 else 99))
                g = gcd(n, k - th)
                alpha = n // g
                ok["parity"] = all(vval(dt, l) % 2 == vval(n, l) % 2 for l in primes_of(n) if l != p and (alpha * (th - th2)) % l)
            rec["checks"] = ok
            rec["ALLOK"] = all(ok.values())
        res_key = f"th={th}"
        out[res_key] = rec
    return out


def test_params_general(v, k, lam, mu, pmax=19):
    """Per prime p <= pmax and applicable th: True if conditions (a)-(d) are arithmetically impossible
    (then every order-p automorphism has det((k-th)(th I - A_F) + mu J_f) = 0 mod p).  Reasons: 'R' if p does
    not divide f_th; 'D' if the Legendre/parity test fails.  Uses v (valid for every f with f = v mod p)."""
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
            forced, free_nonsq, parity_fail = 1, False, None
            constrained = [l for l in primes_of(v) if l != p and (alpha * (th - th2)) % l]
            for l in constrained:
                if l not in S or a == 0:
                    if vval(v, l) % 2:
                        parity_fail = l
                else:
                    forced *= legendre(l, p) ** vval(v, l)
            if a > 0:
                free_nonsq = any(legendre(l, p) == -1 for l in S if l not in constrained)
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


# ------------------------------------------------------------------ controls

def tri_sigma_cycles(n, p, ncycles):
    perm = list(range(n))
    for c in range(ncycles):
        for t in range(p):
            perm[c * p + t] = c * p + (t + 1) % p
    pairs, idx, adj = triangular(n)
    sig = [idx[tuple(sorted((perm[a], perm[b])))] for a, b in pairs]
    return len(pairs), adj, sig


def gf_paley(q, p_char, e, prim_poly):
    """Paley graph on F_q, q = p_char^e, elements as tuples; returns adj and the element list + multiplication."""
    els = list(itertools.product(range(p_char), repeat=e))

    def add(x, y):
        return tuple((a + b) % p_char for a, b in zip(x, y))

    def mul(x, y):
        prod = [0] * (2 * e - 1)
        for i, a in enumerate(x):
            for j, b in enumerate(y):
                prod[i + j] = (prod[i + j] + a * b) % p_char
        for deg in range(2 * e - 2, e - 1, -1):
            cdeg = prod[deg]
            if cdeg:
                prod[deg] = 0
                for i, cc in enumerate(prim_poly[:e]):
                    prod[deg - e + i] = (prod[deg - e + i] - cdeg * cc) % p_char
        return tuple(prod[:e])

    zero = tuple([0] * e)
    sq = {mul(x, x) for x in els if x != zero}
    idx = {x: i for i, x in enumerate(els)}
    adj = [set() for _ in els]
    for x in els:
        for y in els:
            if x != y:
                diff = add(x, tuple((-b) % p_char for b in y))
                if diff in sq:
                    adj[idx[x]].add(idx[y])
    return els, idx, adj, mul, sq


def paley_mult_sigma(q, p_char, e, prim_poly, order):
    els, idx, adj, mul, sq = gf_paley(q, p_char, e, prim_poly)
    zero = tuple([0] * e)
    one = tuple([1] + [0] * (e - 1))
    g = next(x for x in sq if x != one and all(True for _ in [0]) and _order(x, mul, one) == order)
    sig = [idx[mul(g, x)] for x in els]
    return len(els), adj, sig


def _order(x, mul, one):
    y, o = x, 1
    while y != one:
        y = mul(y, x)
        o += 1
        if o > 10000:
            return -1
    return o


if __name__ == "__main__":
    cases = []
    # Paley graphs with multiplication by a square of prime order (fixes 0): x^2+x+2 irreducible mod 5? use known polys
    cases.append(("Paley(25)", paley_mult_sigma(25, 5, 2, [2, 1], 3), 3))      # x^2 + x + 2 over F5
    cases.append(("Paley(49)", paley_mult_sigma(49, 7, 2, [3, 1], 3), 3))      # x^2 + x + 3 over F7
    cases.append(("Paley(81)", paley_mult_sigma(81, 3, 4, [2, 0, 0, 1], 5), 5))  # x^4 + x^3 + 2 over F3
    for (n, p, nc) in [(10, 7, 1), (11, 5, 1), (12, 5, 2), (13, 3, 3), (11, 3, 3), (14, 3, 4), (12, 7, 1),
                       (16, 7, 2), (13, 5, 2), (17, 5, 3), (13, 11, 1), (15, 13, 1), (20, 17, 1), (21, 19, 1),
                       (17, 7, 2), (19, 5, 3)]:
        cases.append((f"T({n}) {nc}x{p}-cycle", tri_sigma_cycles(n, p, nc), p))
    def is_srg(nv, adj):
        degs = {len(adj[x]) for x in range(nv)}
        lams = {len(adj[x] & adj[y]) for x in range(nv) for y in adj[x]}
        mus = {len(adj[x] & adj[y]) for x in range(nv) for y in range(nv) if y != x and y not in adj[x]}
        return len(degs) == 1 and len(lams) == 1 and len(mus) == 1

    for name, (nv, adj, sig), p in cases:
        t0 = time.time()
        assert is_srg(nv, adj), name
        assert sorted(sig) == list(range(nv)) and any(sig[x] != x for x in range(nv)), name
        assert all((sig[a] in adj[sig[b]]) == (a in adj[b]) for a in range(nv) for b in range(nv)), name
        comp = [set(range(nv)) - adj[x] - {x} for x in range(nv)]
        for gname, A in ((name, adj), (name + "^c", comp)):
            res = check_graph_general(nv, A, sig, p)
            pt = test_params_general(nv, res["k"], res["lam"], res["mu"])
            res["param_test"] = {f"th={th}": vv for (pp, th), vv in pt["tests"].items() if pp == p}
            res["graph"] = gname
            res["secs"] = round(time.time() - t0, 1)
            print(json.dumps(res), flush=True)
