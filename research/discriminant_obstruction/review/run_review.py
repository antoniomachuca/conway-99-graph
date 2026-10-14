#!/usr/bin/env python3
"""Referee driver: controls, new families, Brouwer rescan."""
import glob
import html
import itertools
import json
import re
import sys

sys.path.insert(0, "/Users/antoniomachuca/Documents/Conway's 99-Graph Problem/scratch/avenue2_20261011/campaign_A/review")
from referee import (analyze, my_test, srg_params_ok, triangular, tri_sigma,
                     petersen, gq33, circulant_search, primes_of, eigen)


def show(name, res):
    out = {"graph": name, "v": res["v"], "k": res["k"], "lam": res["lam"],
           "mu": res["mu"], "p": res["p"], "m": res["m"], "eig": [res["r"], res["s"]],
           "f": [res["fr"], res["fs"]], "c_b": res["c_b"]}
    for key in ("th=%d" % res["r"], "th=%d" % res["s"]):
        out[key] = res[key]
    print(json.dumps(out))


def complement(n, adj):
    return [set(range(n)) - adj[u] - {u} for u in range(n)]


def part2():
    # controls overlapping their list
    for n, p in [(11, 5), (13, 13), (14, 13)]:
        v, adj = triangular(n)
        sig = tri_sigma(n, p)
        for name, A in ((f"T({n})", adj), (f"T({n})^c", complement(v, adj))):
            show(name, analyze(v, A, sig, p))
    # Petersen p = 5 (new family: Kneser graph)
    n, adj, sig = petersen()
    assert srg_params_ok(n, adj, 3, 0, 1)
    show("Petersen", analyze(n, adj, sig, 5))
    # GQ(3,3) p = 5 (new family)
    n, adj, sig, B, pts, mul, powmod = gq33()
    assert srg_params_ok(n, adj, 12, 2, 4)
    assert all(sig[x] != x for x in range(n))
    show("GQ(3,3)", analyze(n, adj, sig, 5))
    # circulant search for additional new families with fpf prime-order automorphism
    for v in (26, 34, 38, 39, 46, 51, 57, 58):
        for k in range(2, v // 2 + 1):
            found = circulant_search(v, k)
            if found:
                adj, sig1 = found
                lam = len(adj[0] & adj[next(iter(adj[0]))])
                mu = len(adj[0] & adj[next(y for y in range(1, v) if y not in adj[0])])
                for p in primes_of(v):
                    t = v // p
                    sig = [(x + t) % v for x in range(v)]
                    if all(sig[x] != x for x in range(v)) and p > 2:
                        e = eigen(v, k, lam, mu)
                        appl = e and any(((k - th) * (th - th2)) % p for th, th2 in ((e[0], e[1]), (e[1], e[0])))
                        print(json.dumps({"circulant": [v, k, lam, mu], "p": p, "m": t,
                                          "eig": list(e[:2]) if e else None, "applicable": bool(appl)}))
                        if appl:
                            show(f"Circulant({v},{k})", analyze(v, adj, sig, p))
                break


def brouwer_rows():
    SRC = "/tmp/lit/dj/amazing-source-strongly-regular-graphs-research-51ebed5/data/brouwer"
    for path in sorted(glob.glob(f"{SRC}/srgtab*.html")):
        text = open(path, encoding="utf-8").read()
        status = v = None
        for tr in re.findall(r"<tr[^>]*>(.*?)</tr>", text, flags=re.S):
            cells = [html.unescape(re.sub(r"<[^>]+>", "", c)).strip().replace("\xa0", "").replace(" ", "")
                     for c in re.findall(r"<t[dh][^>]*>(.*?)</t[dh]>", tr, flags=re.S)]
            if len(cells) < 5:
                continue
            try:
                int(cells[1]) if cells[1] else 0
            except ValueError:
                continue
            st, vv = cells[0], cells[1]
            if vv:
                status, v = st, vv
            elif st:
                status = st
            if v is None or not cells[2] or not cells[3] or not cells[4]:
                continue
            try:
                yield status, int(v), int(cells[2]), int(cells[3]), int(cells[4])
            except ValueError:
                continue


def part3():
    open_sets = sorted({(v, k, l, m) for st, v, k, l, m in brouwer_rows() if st and "?" in st})
    excl, n_int = [], 0
    for (v, k, l, m) in open_sets:
        r = my_test(v, k, l, m)
        if r is None:
            continue
        n_int += 1
        for (p, th), (verd, why) in sorted(r.items()):
            if verd in ("R", "D"):
                excl.append({"params": [v, k, l, m], "p": p, "th": th, "verdict": verd, "why": why})
    by = {}
    for e in excl:
        by.setdefault((tuple(e["params"]), e["p"]), set()).add(e["verdict"])
    for e in excl:
        print(json.dumps(e))
    onlyD = sorted([list(k[0]) + [k[1]] for k, vset in by.items() if vset == {"D"}])
    print(json.dumps({"open": len(open_sets), "integral": n_int,
                      "excluded_pairs": len(by), "onlyD_count": len(onlyD), "onlyD": onlyD}))


if __name__ == "__main__":
    part = sys.argv[1] if len(sys.argv) > 1 else "all"
    if part in ("all", "2"):
        part2()
    if part in ("all", "3"):
        part3()
