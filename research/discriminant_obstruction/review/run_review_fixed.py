#!/usr/bin/env python3
"""Referee driver for the fixed-point section. Mac only, light jobs.

Phase 1: numerical verification of thm:fix on graphs with fixed-point
automorphisms (Paley via independent GF arithmetic; T(n) families), compared
against fixed_points.out.
Phase 2: exhaustive small-f enumeration of admissible Gamma_F (ground truth for
f <= 7) + part-join enumeration for all admissible f in the cor:full items.
"""
import json
import sys
import time
from math import gcd

from referee import srg_params_ok
from referee_fixed import (analyze_fixed, my_test_general, my_fixed_subgraphs,
                           my_part_types, exhaustive_graphs_f, det_F_direct,
                           condF, paley_sigma_order, tri_sigma_cycles,
                           complement, det_mod_p)


def check_aut(n, adj, sig, p):
    assert sorted(sig) == list(range(n))
    s = sig[:]
    for _ in range(p - 1):
        s = [sig[s[x]] for x in range(n)]
    assert s == list(range(n)), "sigma order != p"
    assert any(sig[x] != x for x in range(n))
    assert all((sig[a] in adj[sig[b]]) == (a in adj[b])
               for a in range(n) for b in range(n))


def phase1():
    cases = []
    # Paley: my own irreducible polys (F25: x^2+2; F49: x^2+1; F81: x^4+x+2)
    cases.append(("Paley(25)", paley_sigma_order(25, 5, 2, [2, 0], 3), 3))
    cases.append(("Paley(49)", paley_sigma_order(49, 7, 2, [1, 0], 3), 3))
    cases.append(("Paley(81)", paley_sigma_order(81, 3, 4, [2, 1, 0, 0], 5), 5))
    for (n, p, nc) in [(10, 7, 1), (11, 5, 1), (12, 5, 2), (13, 3, 3), (11, 3, 3),
                       (14, 3, 4), (12, 7, 1), (16, 7, 2), (13, 5, 2), (17, 5, 3),
                       (13, 11, 1), (15, 13, 1), (20, 17, 1), (21, 19, 1),
                       (17, 7, 2), (19, 5, 3)]:
        cases.append((f"T({n}) {nc}x{p}-cycle", tri_sigma_cycles(n, p, nc), p))

    results = []
    for name, (nv, adj, sig), p in cases:
        t0 = time.time()
        e = None
        check_aut(nv, adj, sig, p)
        comp = complement(nv, adj)
        for gname, A in ((name, adj), (name + "^c", comp)):
            res = analyze_fixed(nv, A, sig, p)
            res["graph"] = gname
            res["secs"] = round(time.time() - t0, 1)
            print(json.dumps(res), flush=True)
            results.append(res)
    return results


def phase2():
    """cor:full items: admissible f, full Gamma_F list, (F) det for each."""
    items = [((88, 27, 6, 9), 11), ((99, 14, 1, 2), 3), ((342, 33, 4, 3), 7),
             ((364, 33, 2, 3), 5), ((561, 60, 9, 6), 11), ((650, 55, 0, 5), 11)]
    for (v, k, lam, mu), p in items:
        pt = my_test_general(v, k, lam, mu)
        ths = {th: vd for (pp, th), vd in pt["tests"].items() if pp == p}
        fs = [f for f in range(v % p, v // (p + 1) + 1, p)]
        print(f"\n=== srg({v},{k},{lam},{mu}) p={p}: test {ths}, "
              f"f in {fs} (f<={v//(p+1)}) ===")
        for f in fs:
            if f == 0:
                print(f"  f=0: fpf branch -> test verdicts {ths}")
                continue
            if f == 1:
                det = {th: (k - th) * th + mu for th in ths}
                print(f"  f=1: (k-th)th+mu = {det} mod {p}")
                continue
            subs = my_fixed_subgraphs(f, lam, mu)
            print(f"  f={f}: {len(subs)} join-decompositions:")
            for parts in subs:
                dets = {th: det_F_join(parts, k, mu, th, p) for th in ths}
                print(f"    {'+'.join(pp['kind'] for pp in parts)}: det(F)={dets}")
            ex = exhaustive_graphs_f(f, lam, mu)
            if ex is not None:
                print(f"    exhaustive: {len(ex)} graphs on {f} vertices "
                      f"satisfy lam={lam}/mu={mu} common-neighbour counts")
                for AF in ex:
                    dets = {th: condF(k, mu, th, AF, p) for th in ths}
                    print(f"      AF={AF} det(F)={dets}")


def det_F_join(parts, k, mu, th, p):
    """det((k-th)(th I - A_F) + mu J_f) mod p for a join of regular parts.

    Decompose R^f = (per-part mean-zero subspaces) + (part-constant t-dim
    space).  On the first, H = (k-th)(th - eta); on the second, H acts as
    X[i][j] = (k-th)(th*delta_ij - B[i][j]) + mu*n_j with B the join quotient
    B[i][j] = d_i if i==j else n_j.  For conference ('quad') part eigenvalues
    eta+/- the product over the Galois pair is ((k-th)^2 (th^2 - (li-mi) th -
    (d-mi)))^g.  Computed independently of scan_fixed3.det_F (though the
    formula is forced by the same spectral argument).
    """
    t = len(parts)
    val = 1
    for prt in parts:
        # all part eigenvalues except the degree (constant direction -> quotient)
        first = True
        for item in prt["spec"]:
            if item[0] == "quad":
                g = item[1]
                li = prt["li"]
                mi = prt["mi"]
                val = val * pow((k - th) ** 2 *
                                (th * th - (li - mi) * th - (prt["d"] - mi)),
                                g, p) % p
                continue
            eta, mult = item
            if first and eta == prt["d"]:
                mult -= 1
                first = False
            val = val * pow((k - th) * (th - eta), mult, p) % p
    Bq = [[(parts[i]["d"] if i == j else parts[j]["n"])
           for j in range(t)] for i in range(t)]
    Xq = [[(k - th) * ((th if i == j else 0) - Bq[i][j]) + mu * parts[j]["n"]
           for j in range(t)] for i in range(t)]
    return val * det_mod_p(Xq, p) % p


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "phase1":
        phase1()
    else:
        phase2()
