#!/usr/bin/env python3
"""Campaign A: parameter-level discriminant test on the BCN feasible intersection arrays (Brouwer's machine-readable
tables IA*, drg_data/), EXPLORED.  The tables carry no existence status.  For each array, each prime p <= 19 and
each integral eigenvalue theta != k with p not dividing c_theta = (k - theta) P_theta(theta): verdict R
(p does not divide the multiplicity) or D (Legendre/parity test fails).  Consequence of R or D: every automorphism of
order p has a fixed subgraph with det((k-th)(P(th) I - P(A_F)) + c J_f) = 0 mod p; f = 0 is impossible, and f = 1 is
impossible when (k - th)(P(th) - P(0)) + c != 0 mod p."""
import glob
import json
import os
import re
from fractions import Fraction

from general import PRIMES, drg_data, pdiv_linear, peval, test_theta

HERE = os.path.dirname(os.path.abspath(__file__))


def arrays():
    for path in sorted(glob.glob(os.path.join(HERE, "drg_data", "IA*"))):
        for line in open(path):
            mt = re.match(r"\s*i\(([\d,\s]+);([\d,\s]+)\)", line)
            if mt:
                b = [int(x) for x in mt.group(1).split(",")]
                c = [int(x) for x in mt.group(2).split(",")]
                yield os.path.basename(path), b, c


if __name__ == "__main__":
    out, n_arr, n_int = [], 0, 0
    for src, b, c in arrays():
        n_arr += 1
        dd = drg_data(b, c)
        if dd is None:
            continue
        v, k, H, cc = dd["v"], dd["k"], dd["H"], dd["c"]
        for p in PRIMES:
            res = {}
            for th in dd["roots"]:
                verdict, info = test_theta(v, k, H, cc, th, dd["mult"][th], p)
                if verdict in ("R", "D"):
                    P = pdiv_linear(H, th)
                    f1 = ((k - th) * (peval(P, th) - peval(P, 0)) + cc) % p != 0
                    res[th] = {"verdict": verdict, "f1_excluded": f1}
            if res:
                out.append({"src": src, "array": [b, c], "v": v, "k": k, "p": p, "v_mod_p": v % p,
                            "a1": dd["a1"], "c2": dd["c2"], "thetas": res})
    with open(os.path.join(HERE, "scan_drg.jsonl"), "w") as fh:
        for r in out:
            fh.write(json.dumps(r) + "\n")
    fpf_D = [r for r in out if r["v_mod_p"] == 0 and any(t["verdict"] == "D" for t in r["thetas"].values())]
    f1_D = [r for r in out if r["v_mod_p"] == 1 and any(t["verdict"] == "D" and t["f1_excluded"] for t in r["thetas"].values())]
    print(json.dumps({"arrays": n_arr, "records": len(out), "FPF_excluded_by_D": len(fpf_D), "f1_excluded_by_D": len(f1_D)}))
    for r in fpf_D + f1_D:
        print(r["src"], r["array"], "v=%d p=%d" % (r["v"], r["p"]), {th: t["verdict"] for th, t in r["thetas"].items()})
