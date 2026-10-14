#!/usr/bin/env python3
"""Numerical check of steps 1-5 of Djematene's order-3 argument (preuve_c3.tex, section 3), in the
general form for an srg(3m, k, lam, mu) with a fixed-point-free order-3 automorphism, on real graphs.
For eigenvalues r > s of the srg (roots of x^2 + (mu - lam) x - (k - mu)):
  L  = ker_Z(Q - rI),        d  = det(B^T B),       expected d  | ((k-r)(r-s))^rank
  L' = ker_Z[w](M - rI),     d' = det(B'^* B'),     expected d' | (r-s)^rank'
  if 3 does not divide (k-r)(r-s): rank = rank' and d = d' (mod 3)   (step 5)
The Z[w]-lattice is handled through Z^{2m} (coordinates a + b w) with the trace form
Tr(conj(x) y); for a free Z[w]-lattice with Hermitian Gram G', det_Z(trace form) = 3^rank' det(G')^2."""
import itertools
import json
import sys
from fractions import Fraction
from math import isqrt

sys.path.insert(0, "..")
from controls import gq24, paley9, srg_params, t6_complement, verify_fpf3  # noqa: E402


def int_kernel(A, ncols):
    """Z-basis of {x in Z^ncols : A x = 0} by unimodular column operations."""
    M = [row[:] for row in A]
    U = [[int(i == j) for j in range(ncols)] for i in range(ncols)]

    def col_sub(j, j0, q):
        for row in M:
            row[j] -= q * row[j0]
        for row in U:
            row[j] -= q * row[j0]

    def col_swap(a, b):
        for row in M:
            row[a], row[b] = row[b], row[a]
        for row in U:
            row[a], row[b] = row[b], row[a]

    piv = 0
    for i in range(len(M)):
        while True:
            nz = [j for j in range(piv, ncols) if M[i][j] != 0]
            if len(nz) <= 1:
                break
            j0 = min(nz, key=lambda j: abs(M[i][j]))
            for j in nz:
                if j != j0:
                    col_sub(j, j0, M[i][j] // M[i][j0])
        nz = [j for j in range(piv, ncols) if M[i][j] != 0]
        if nz:
            col_swap(nz[0], piv)
            piv += 1
    assert all(M[i][j] == 0 for i in range(len(M)) for j in range(piv, ncols))
    return [[U[i][j] for i in range(ncols)] for j in range(piv, ncols)]  # list of kernel vectors


def det(mat):
    n = len(mat)
    a = [[Fraction(x) for x in row] for row in mat]
    res = Fraction(1)
    for c in range(n):
        p = next((r for r in range(c, n) if a[r][c] != 0), None)
        if p is None:
            return 0
        if p != c:
            a[c], a[p] = a[p], a[c]
            res = -res
        res *= a[c][c]
        for r in range(c + 1, n):
            f = a[r][c] / a[c][c]
            for cc in range(c, n):
                a[r][cc] -= f * a[c][cc]
    assert res.denominator == 1
    return int(res)


def factor_small(n, primes=(2, 3, 5, 7, 11, 13)):
    out, m = {}, n
    for p in primes:
        while m % p == 0:
            out[p] = out.get(p, 0) + 1
            m //= p
    return out, m


def analyse(name, n, adj, g):
    v, k, lam, mu = srg_params(n, adj)
    verify_fpf3(n, adj, g)
    disc = (mu - lam) ** 2 + 4 * (k - mu)
    sq = isqrt(disc)
    assert sq * sq == disc
    r, s = (-(mu - lam) + sq) // 2, (-(mu - lam) - sq) // 2
    seen, reps = set(), []
    for x in range(n):
        if x not in seen:
            reps.append(x)
            seen.update([x, g[x], g[g[x]]])
    m = len(reps)
    gp = lambda x, b: x if b == 0 else gp(g[x], b - 1)  # noqa: E731
    Ab = [[[int(gp(reps[V], b) in adj[reps[U]]) for V in range(m)] for U in range(m)] for b in range(3)]
    Q = [[Ab[0][U][V] + Ab[1][U][V] + Ab[2][U][V] for V in range(m)] for U in range(m)]
    tau = sum(1 for U in range(m) if Q[U][U] == 2)
    # M = A0 + w A1 + w^2 A2 = (A0 - A2) + (A1 - A2) w ; entry z = x + y w
    X = [[Ab[0][U][V] - Ab[2][U][V] for V in range(m)] for U in range(m)]
    Y = [[Ab[1][U][V] - Ab[2][U][V] for V in range(m)] for U in range(m)]
    # Q side
    QmrI = [[Q[i][j] - (r if i == j else 0) for j in range(m)] for i in range(m)]
    L = int_kernel(QmrI, m)
    rank = len(L)
    G = [[sum(a * b for a, b in zip(u, w)) for w in L] for u in L]
    d = det(G)
    # M side, realified: vector (a_U, b_U) for a_U + b_U w; z (a + b w) = (xa - yb) + (xb + ya - yb) w
    R = [[0] * (2 * m) for _ in range(2 * m)]
    for U in range(m):
        for V in range(m):
            x, y = X[U][V] - (r if U == V else 0), Y[U][V]
            R[2 * U][2 * V], R[2 * U][2 * V + 1] = x, -y
            R[2 * U + 1][2 * V], R[2 * U + 1][2 * V + 1] = y, x - y
    Lp = int_kernel(R, 2 * m)
    assert len(Lp) % 2 == 0
    rankp = len(Lp) // 2

    def tr_form(u, w):
        return sum(2 * (u[2 * U] * w[2 * U] + u[2 * U + 1] * w[2 * U + 1]) - u[2 * U] * w[2 * U + 1]
                   - u[2 * U + 1] * w[2 * U] for U in range(m))

    detZ = det([[tr_form(u, w) for w in Lp] for u in Lp])
    assert detZ % (3 ** rankp) == 0
    dp2 = detZ // 3 ** rankp
    dp = isqrt(dp2)
    assert dp * dp == dp2, "trace-form determinant is not 3^r' times a square"
    res = {"graph": name, "params": [v, k, lam, mu], "r": r, "s": s, "m": m, "tau": tau,
           "rank_Q": rank, "rank_M": rankp, "d": d, "d_factors": factor_small(d)[0], "d_rest": factor_small(d)[1],
           "d_prime": dp, "d_prime_factors": factor_small(dp)[0], "d_prime_rest": factor_small(dp)[1],
           "d_mod3": d % 3, "d_prime_mod3": dp % 3,
           "d_divides": (((k - r) * (r - s)) ** rank) % d == 0, "d_prime_divides": ((r - s) ** rankp) % dp == 0,
           "step5_applicable": ((k - r) * (r - s)) % 3 != 0}
    if res["step5_applicable"]:
        res["step5_rank_equal"] = rank == rankp
        res["step5_d_equiv_dprime_mod3"] = d % 3 == dp % 3
    return res


if __name__ == "__main__":
    for name, data in [("paley9_row", paley9((1, 0))), ("paley9_diag", paley9((1, 1))),
                       ("srg15_6_1_3", t6_complement()), ("gq24_srg27_10_1_5", gq24())]:
        print(json.dumps(analyse(name, *data)))
