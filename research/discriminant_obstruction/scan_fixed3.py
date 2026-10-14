#!/usr/bin/env python3
"""Campaign A: full-exclusion scan for p > max(lam, mu), mu >= 2, with a complete list of fixed subgraphs
(EXPLORED).

Fixed subgraph Gamma_F (f >= 2): adjacent pairs have exactly lam, non-adjacent exactly mu common neighbours in F;
connected (mu >= 1).  Non-adjacent vertices have equal degree (count edges between N(x) and N(y)), so Gamma_F is
the join of the subgraphs induced on the connected components C_1..C_t of its complement; each part is d_i-regular.
Parts: a single vertex; an edgeless E_n (then mu = f - n); a union of m >= 2 cliques K_a (lam_i = a - 2,
mu_i = 0); or a primitive srg(n, d, lam_i, mu_i) with lam_i = lam - f + n, mu_i = mu - f + n >= 1.
Across parts i != j: lam = d_i + d_j + f - n_i - n_j.  t = 1 means Gamma_F is itself a primitive srg(f,kF,lam,mu).
Condition (F): det((k-th)(th I - A_F) + mu J_f) != 0 mod p, computed from the part spectra and the t x t quotient."""
import itertools
import json
from math import isqrt

from obstruction import eigen
from fixed_points import det_mod_p, test_params_general
from scan_brouwer import rows


def srg_spectrum(n, d, l, m):
    """Spectrum [(eta, mult)] of a primitive srg(n,d,l,m) if feasible (integral multiplicities), or a
    ('quad', g, l, m, d) marker for a conference graph; None if infeasible."""
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
        return [(d, 1), ("quad", (n - 1) // 2, l, m, d)]
    return None


def part_types(f, lam, mu):
    out = [{"n": 1, "d": 0, "kind": "K1", "spec": [(0, 1)]}]
    for n in range(2, f + 1):
        if mu == f - n:
            out.append({"n": n, "d": 0, "kind": f"E{n}", "spec": [(0, n)]})
        li, mi = lam - f + n, mu - f + n
        if mi == 0 and li >= 0:
            a = li + 2
            if n % a == 0 and n // a >= 2:
                mm = n // a
                out.append({"n": n, "d": a - 1, "kind": f"{mm}K{a}", "spec": [(a - 1, mm), (-1, mm * (a - 1))]})
        if mi >= 1 and li >= 0:
            for d in range(1, n - 1):
                sp = srg_spectrum(n, d, li, mi)
                if sp:
                    out.append({"n": n, "d": d, "kind": f"srg({n},{d},{li},{mi})", "spec": sp})
    return out


def fixed_subgraphs(f, lam, mu):
    """All admissible Gamma_F on f >= 2 vertices as lists of parts (join of parts)."""
    if f < 2:
        return []
    types = part_types(f, lam, mu)
    res = []
    for t in types:                      # t = 1: primitive srg on all f vertices
        if t["n"] == f and t["kind"].startswith("srg"):
            res.append([t])
    # t >= 2: multisets of parts with sum n = f and d_i + d_j + f - n_i - n_j = lam for all i != j
    by_e = {}
    for t in types:
        if t["n"] < f:
            by_e.setdefault(t["d"] - t["n"], []).append(t)
    # t = 2
    for i, t1 in enumerate(types):
        for t2 in types[i:]:
            if t1["n"] + t2["n"] == f and (t1["d"] - t1["n"]) + (t2["d"] - t2["n"]) == lam - f:
                res.append([t1, t2])
    # t >= 3: all e_i equal to (lam - f)/2
    if (lam - f) % 2 == 0:
        e = (lam - f) // 2
        cands = by_e.get(e, [])

        def rec(start, remaining, chosen):
            if remaining == 0 and len(chosen) >= 3:
                res.append(list(chosen))
                return
            for idx in range(start, len(cands)):
                c = cands[idx]
                if c["n"] <= remaining:
                    chosen.append(c)
                    rec(idx, remaining - c["n"], chosen)
                    chosen.pop()
        rec(0, f, [])
    return res


def det_F(parts, k, mu, th, p, f):
    """det((k-th)(th I - A_F) + mu J_f) mod p for a join of regular parts."""
    t = len(parts)
    val = 1
    for prt in parts:
        first = True
        for item in prt["spec"]:
            if item[0] == "quad":
                _, g, l, m, d = item
                val = val * pow(((k - th) ** 2) * (th * th - (l - m) * th - (d - m)), g, p) % p
                continue
            eta, mult = item
            if first and eta == prt["d"]:
                mult -= 1
                first = False
            val = val * pow((k - th) * (th - eta), mult, p) % p
    Bq = [[(prt_i["d"] if i == j else parts[j]["n"]) for j in range(t)] for i, prt_i in enumerate(parts)]
    Xq = [[(k - th) * ((th if i == j else 0) - Bq[i][j]) + mu * parts[j]["n"] for j in range(t)] for i in range(t)]
    return val * det_mod_p(Xq, p) % p


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
            fs_allowed = list(range(v % p, v // (p + 1) + 1, p))
            detail, all_ex, used = {}, True, set()
            for f in fs_allowed:
                if f == 0:
                    detail[f] = "excluded (f=0)"
                    used.update(vd for _, vd in ths)
                    continue
                if f == 1:
                    ok = [(th, vd) for th, vd in ths if ((k - th) * th + mu) % p]
                    detail[f] = f"excluded via {ok}" if ok else "OPEN"
                    all_ex &= bool(ok)
                    used.update(vd for _, vd in ok)
                    continue
                subs = fixed_subgraphs(f, lam, mu)
                lst = []
                for parts in subs:
                    ok = [(th, vd) for th, vd in ths if det_F(parts, k, mu, th, p, f)]
                    lst.append(("+".join(pp["kind"] for pp in parts), ok))
                    all_ex &= bool(ok)
                    used.update(vd for _, vd in ok)
                if lst:
                    detail[f] = lst
            results.append({"params": [v, k, lam, mu], "p": p, "ths": ths, "f_allowed": fs_allowed,
                            "detail": detail, "full": all_ex, "uses": sorted(used)})
    full = [r for r in results if r["full"]]
    for r in full:
        if "D" in r["uses"]:
            print("FULL-D", json.dumps(r))
    print(json.dumps({"pairs_checked": len(results), "full_exclusions": len(full),
                      "full_using_D": sum(1 for r in full if "D" in r["uses"]),
                      "full_R_only": sum(1 for r in full if r["uses"] == ["R"])}))
    with open("scan_fixed3_full.jsonl", "w") as fh:
        for r in full:
            fh.write(json.dumps(r) + "\n")
