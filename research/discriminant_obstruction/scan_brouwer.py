#!/usr/bin/env python3
"""Campaign A: run test_params on every open ('?') parameter set of Brouwer's srg table (snapshot in
Djematene's archive, data/brouwer/*.html, v <= 1300).  Output: one JSON line per (parameter set, p, th)
whose verdict is 'R' or 'D' (no fixed-point-free automorphism of order p), plus a summary."""
import glob
import html
import json
import re
import sys

from obstruction import test_params

SRC = sys.argv[1] if len(sys.argv) > 1 else "/tmp/lit/dj/amazing-source-strongly-regular-graphs-research-51ebed5/data/brouwer"


def rows():
    for path in sorted(glob.glob(f"{SRC}/srgtab*.html")):
        text = open(path, encoding="utf-8").read()
        status, v = None, None
        for tr in re.findall(r"<tr[^>]*>(.*?)</tr>", text, flags=re.S):
            tds = [html.unescape(re.sub(r"<[^>]+>", "", t)).strip().replace("\xa0", "") for t in re.findall(r"<td[^>]*>(.*?)</td>", tr, flags=re.S)]
            if len(tds) < 5:
                continue
            st, vv = tds[0], tds[1]
            if vv:
                status, v = st, vv
            elif st:
                status = st
            try:
                yield status, int(v), int(tds[2]), int(tds[3]), int(tds[4])
            except (TypeError, ValueError):
                continue


if __name__ == "__main__":
    open_sets, n_int, excl = set(), 0, []
    for st, v, k, lam, mu in rows():
        if st is None or "?" not in st:
            continue
        open_sets.add((v, k, lam, mu))
    for (v, k, lam, mu) in sorted(open_sets):
        res = test_params(v, k, lam, mu)
        if res is None:
            continue
        n_int += 1
        for (p, th), (verdict, why) in sorted(res["tests"].items()):
            if verdict in ("R", "D"):
                excl.append({"params": [v, k, lam, mu], "p": p, "th": th, "verdict": verdict, "why": why})
                print(json.dumps(excl[-1]))
    by = {}
    for e in excl:
        by.setdefault((tuple(e["params"]), e["p"]), set()).add(e["verdict"])
    onlyD = [k for k, vset in by.items() if vset == {"D"}]
    print(json.dumps({"open_parameter_sets": len(open_sets), "with_integral_eigenvalues": n_int,
                      "excluded_pairs_(params,p)": len(by), "excluded_only_by_D": len(onlyD),
                      "onlyD": [list(k[0]) + [k[1]] for k in sorted(onlyD)]}))
