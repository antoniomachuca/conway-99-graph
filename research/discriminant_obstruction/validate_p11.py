import json, sys, time
from obstruction import tri_sigma, check_graph, test_params
for n, p in [(int(a), int(b)) for a, b in (x.split(":") for x in sys.argv[1:])]:
    t = time.time()
    nv, adj, sig = tri_sigma(n, p)
    comp = [set(range(nv)) - adj[x] - {x} for x in range(nv)]
    for name, A in ((f"T({n})", adj), (f"T({n})^c", comp)):
        res = check_graph(nv, A, sig, p)
        pt = test_params(nv, res["k"], res["lam"], res["mu"])
        res["test_params"] = {f"p={kk[0]},th={kk[1]}": vv[0] for kk, vv in pt["tests"].items() if kk[0] == p}
        res["graph"] = name; res["secs"] = round(time.time() - t, 1)
        print(json.dumps(res), flush=True)
