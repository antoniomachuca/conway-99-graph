"""Descendants of the two-graph containing complement(srg(210,99,48,45)):
for each vertex x, switch to isolate x, delete x -> srg(209,100,45,50) candidate.
Verify params; compute |Aut| and orbit-distinct descendants via pynauty;
search for order-11 automorphisms and their fixed points.
"""
import json, sys, itertools
import pynauty

adj210 = [set(a) for a in json.load(open("/tmp/srg210_99_48_45.json"))]
assert len(adj210) == 210
# complement
comp = [set(range(210)) - {i} - a for i, a in enumerate(adj210)]

def is_srg(adj, v, k, lam, mu):
    if len(adj) != v: return False
    if any(len(a) != k for a in adj): return False
    if any(i in a or i in adj[i] for i, a in enumerate(adj)): return False
    for i in range(v):
        for j in range(i + 1, v):
            c = len(adj[i] & adj[j])
            if j in adj[i] and c != lam: return False
            if j not in adj[i] and c != mu: return False
    return True

assert is_srg(comp, 210, 110, 55, 60), "complement params wrong"
print("complement srg(210,110,55,60) verified", flush=True)

def descendant(adj, x):
    # Seidel S = J-I-2A (S[i][j]=-1 iff i~j). Switch by d_y = S_xy to isolate x.
    n = len(adj)
    S = [[0]*n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            if i != j:
                S[i][j] = -1 if j in adj[i] else 1
    d = [S[x][y] if y != x else 1 for y in range(n)]
    # switched Seidel S'[i][j] = d_i S_ij d_j ; delete x
    idx = [y for y in range(n) if y != x]
    out = [set() for _ in range(n - 1)]
    for ii, i in enumerate(idx):
        for jj, j in enumerate(idx):
            if i != j and d[i] * S[i][j] * d[j] == -1:
                out[ii].add(jj)
    return out

desc = []
ok = 0
for x in range(210):
    g = descendant(comp, x)
    if is_srg(g, 209, 100, 45, 50):
        ok += 1
    desc.append(g)
print(f"descendants built: 210, verified srg(209,100,45,50): {ok}", flush=True)

# canonical forms + aut groups for all descendants; collect distinct
canon = {}
for x, g in enumerate(desc):
    G = pynauty.Graph(209, adjacency_dict={i: sorted(a) for i, a in enumerate(g)})
    cert = pynauty.certificate(G)
    canon.setdefault(cert, []).append(x)
print("distinct descendants:", len(canon), flush=True)

def cycles_of(perm, n):
    seen = [False]*n; lens = []
    for i in range(n):
        if not seen[i]:
            j, l = i, 0
            while not seen[j]:
                seen[j] = True; j = perm[j]; l += 1
            lens.append(l)
    return sorted(lens)

results = []
for cert, xs in canon.items():
    g = desc[xs[0]]
    G = pynauty.Graph(209, adjacency_dict={i: sorted(a) for i, a in enumerate(g)})
    gens, sz1, sz2, orbits, numorbits = pynauty.autgrp(G)
    results.append((xs, sz1 * (10 ** sz2) if sz2 else sz1, gens))
    print(f"desc at x={xs[0]} (class of {len(xs)}): |Aut| = {sz1} * 10^{sz2}", flush=True)

json.dump([[xs, r[1]] for xs, r in [(c[0], c) for c in results]], open("/tmp/desc_auts.json","w"))

# For groups whose order is divisible by 11, hunt for an order-11 element.
import random
random.seed(1)
def mul(a, b, n):
    return [a[b[i]] for i in range(n)]
def order_of(p, n, cap=500):
    e = list(range(n)); cur = p[:]; o = 1
    while cur != e and o <= cap:
        cur = mul(cur, p, n); o += 1
    return o if o <= cap else None

found = []
for xs, order, gens in results:
    # factor order: check divisibility by 11
    import sympy
    ordv = int(order)
    if ordv % 11 != 0:
        print(f"x={xs[0]}: |Aut|={ordv} not divisible by 11")
        continue
    print(f"x={xs[0]}: |Aut|={ordv} DIVISIBLE BY 11 — searching for element")
    n = 209
    for trial in range(20000):
        w = list(range(n))
        for _ in range(random.randint(1, 8)):
            g = random.choice(gens)
            w = mul(w, g, n)
        o = order_of(w, n)
        if o == 11:
            cyc = cycles_of(w, n)
            print(f"  FOUND order-11 element at x={xs[0]}: cycles {cyc}", flush=True)
            found.append((xs[0], w, cyc))
            break
    else:
        print("  no order-11 element found in 20000 random products", flush=True)

json.dump({"distinct": [[xs, str(order)] for xs, order, _ in results],
           "order11": [[x, cyc] for x, _, cyc in found]}, open("/tmp/desc_11.json", "w"))
print("DONE", flush=True)
