#!/usr/bin/env python3
"""Campaign A: full-exclusion scan for p > max(lam, mu) (EXPLORED).

If p > max(lam, mu), two fixed vertices have no non-fixed common neighbour (its orbit of size p would consist of
common neighbours), so the fixed subgraph Gamma_F has exactly lam common neighbours inside F for adjacent pairs
and exactly mu for non-adjacent pairs.  With mu >= 1, Gamma_F (f >= 2) is connected, hence K_{lam+2} or an
srg(f, kF, lam, mu).  If moreover mu >= 2, a fixed vertex with all neighbours fixed forces every vertex to be fixed,
so each fixed vertex has >= p non-fixed neighbours and each non-fixed vertex has <= 1 fixed neighbour:
f <= v/(p+1).  For each admissible Gamma_F, condition (F) is det((k-th)(th I - A_F) + mu J_f) != 0 (mod p),
computed from the spectrum of the regular graph Gamma_F.  If for every admissible Gamma_F some th with verdict
R/D (test_params_general) has (F) satisfied, there is no automorphism of order p."""
import json
from math import isqrt

from obstruction import eigen
from fixed_points import test_params_general
from scan_brouwer import rows


def srg_types(f, lam, mu):
    """Admissible (kF, spectrum) for a connected graph on f >= 2 vertices with constant lam, mu (mu >= 1)."""
    out = []
    if f == lam + 2:
        out.append(("K", f - 1, [(f - 1, 1), (-1, f - 1)]))
    for kF in range(1, f - 1):
        if kF * (kF - lam - 1) != mu * (f - 1 - kF):
            continue
        disc = (lam - mu) ** 2 + 4 * (kF - mu)
        sq = isqrt(disc)
        if sq * sq == disc:
            if (lam - mu + sq) % 2:
                continue
            rF, sF = (lam - mu + sq) // 2, (lam - mu - sq) // 2
            num = -(kF + (f - 1) * sF)
            if rF == sF or num % (rF - sF):
                continue
            fr = num // (rF - sF)
            fs = f - 1 - fr
            if fr < 0 or fs < 0:
                continue
            out.append(("srg", kF, [(kF, 1), (rF, fr), (sF, fs)]))
        else:
            if (f - 1) % 2:
                continue
            g = (f - 1) // 2
            out.append(("conf", kF, [(kF, 1), ("quad", g)]))
    return out


def detF_mod_p(k, mu, th, f, kF, spec, lam, p):
    val = ((k - th) * (th - kF) + mu * f) % p
    for item in spec[1:]:
        if item[0] == "quad":
            g = item[1]
            # (th - rF)(th - sF) = th^2 - (lam - mu) th - (kF - mu)
            val = val * pow(((k - th) ** 2) * (th * th - (lam - mu) * th - (kF - mu)), g, p) % p
        else:
            eta, mult = item
            val = val * pow((k - th) * (th - eta), mult, p) % p
    return val


if __name__ == "__main__":
    open_sets = sorted({(v, k, lam, mu) for st, v, k, lam, mu in rows() if st and "?" in st})
    results = []
    for (v, k, lam, mu) in open_sets:
        if mu < 2 or eigen(v, k, lam, mu) is None:
            continue
        res = test_params_general(v, k, lam, mu)
        by_p = {}
        for (p, th), verdict in res["tests"].items():
            if verdict in ("R", "D"):
                by_p.setdefault(p, []).append((th, verdict))
        for p, ths in by_p.items():
            if p <= max(lam, mu):
                continue
            fs_allowed = [f for f in range(v % p, v // (p + 1) + 1, p)]
            detail, all_ex = {}, True
            for f in fs_allowed:
                if f == 0:
                    detail[f] = "excluded (f=0)"
                    continue
                if f == 1:
                    ok = [th for th, _ in ths if ((k - th) * th + mu) % p]
                    detail[f] = f"excluded via th={ok}" if ok else "open"
                    all_ex &= bool(ok)
                    continue
                types = srg_types(f, lam, mu)
                tdet = []
                for kind, kF, spec in types:
                    ok = [th for th, _ in ths if detF_mod_p(k, mu, th, f, kF, spec, lam, p)]
                    tdet.append((kind, kF, ok))
                    all_ex &= bool(ok)
                detail[f] = tdet if types else "no admissible fixed subgraph"
            results.append({"params": [v, k, lam, mu], "p": p, "ths": ths, "f_allowed": fs_allowed,
                            "detail": detail, "full": all_ex})
    full = [r for r in results if r["full"]]
    for r in full:
        kinds = sorted({vd for _, vd in r["ths"]})
        print("FULL", kinds, json.dumps(r))
    print(json.dumps({"pairs_checked": len(results), "full_exclusions": len(full),
                      "full_with_D": sum(1 for r in full if any(vd == "D" for _, vd in r["ths"]))}))
