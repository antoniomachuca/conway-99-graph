#!/usr/bin/env python3
"""Campaign A: scan of open parameter sets with the fixed-point extension (EXPLORED).
For each open (v,k,lam,mu) with integral eigenvalues and each prime p <= 19 (D test) the verdict of
test_params_general for each applicable th.  If the verdict is 'R' or 'D' for th, every automorphism of order p
has a fixed subgraph with det((k-th)(th I - A_F) + mu J_f) = 0 (mod p).  Fixed-point counts: f = v (mod p) and
f <= max(lam,mu) v/(k - r) (Behbahani-Lam, Thm 3.7).  f = 0 is excluded outright (det = 1); f = 1 is excluded
iff (k-th) th + mu != 0 (mod p).  A pair (set, p) is fully excluded if every admissible f is excluded."""
import json
import sys

from obstruction import eigen
from fixed_points import test_params_general
from scan_brouwer import rows

if __name__ == "__main__":
    open_sets = sorted({(v, k, lam, mu) for st, v, k, lam, mu in rows() if st and "?" in st})
    full, partial = [], []
    for (v, k, lam, mu) in open_sets:
        e = eigen(v, k, lam, mu)
        if e is None:
            continue
        r, s, fr, fs = e
        res = test_params_general(v, k, lam, mu)
        bound = max(lam, mu) * v / (k - r)
        by_p = {}
        for (p, th), verdict in res["tests"].items():
            if verdict in ("R", "D"):
                by_p.setdefault(p, []).append((th, verdict))
        for p, ths in by_p.items():
            fs_allowed = [f for f in range(v % p, int(bound) + 1, p)]
            status = {}
            for f in fs_allowed:
                if f == 0:
                    status[f] = "excluded"
                elif f == 1:
                    status[f] = "excluded" if any(((k - th) * th + mu) % p for th, _ in ths) else "open(f=1, det=0)"
                else:
                    status[f] = "needs fixed subgraph"
            rec = {"params": [v, k, lam, mu], "p": p, "th_verdicts": ths, "f_bound": round(bound, 2),
                   "f_status": status}
            if fs_allowed and all(x == "excluded" for x in status.values()):
                full.append(rec)
            elif any(x == "excluded" for x in status.values()):
                partial.append(rec)
    for rec in full:
        print("FULL", json.dumps(rec))
    print(json.dumps({"open_sets": len(open_sets), "full_exclusions": len(full), "partial": len(partial)}))
    with open("scan_fixed_partial.jsonl", "w") as fh:
        for rec in partial:
            fh.write(json.dumps(rec) + "\n")
