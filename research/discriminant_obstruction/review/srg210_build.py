"""Build srg(210,99,48,45) via the Klin/S7 construction (Sage SRG_210_99_48_45),
then take the complement, switch to isolate a vertex, delete it -> srg(209,100,45,50)
descendant. Verify parameters at each step. No Sage/GAP dependency.
"""
import itertools, sys

def perm_oneline(t):
    # tuple -> permutation dict i -> t[i-1]
    return {i: t[i - 1] for i in range(1, 8)}

def perm_cycle(t):
    # tuple as cycle notation: t[i] -> t[i+1], last -> first; omitted points fixed
    g = {i: i for i in range(1, 8)}
    for i in range(len(t)):
        g[t[i]] = t[(i + 1) % len(t)]
    return g

def power(g, n):
    def apply(x):
        for _ in range(n):
            x = g[x]
        return x
    return {x: apply(x) for x in range(1, 8)}

def ekg(g):
    # arc set of the digraph on {1..7}: x->g(x), x->g^4(x), as frozenset of pairs
    g4 = power(g, 4)
    return frozenset([(x, g[x]) for x in range(1, 8)] + [(x, g4[x]) for x in range(1, 8)])

def act_arcset(arcset, p):
    return frozenset(sorted((p[a], p[b]) for (a, b) in arcset))

S7 = [dict(zip(range(1, 8), c)) for c in itertools.permutations(range(1, 8))]

kd0 = [(7, 1, 2, 3, 4, 5), (7, 1, 3, 4, 5, 6), (7, 3, 4, 5, 6, 2), (7, 1, 4, 3, 5, 6),
       (7, 3, 1, 4, 5, 6), (7, 2, 4, 3, 5, 6), (7, 3, 2, 4, 5, 1), (7, 2, 4, 3, 5, 1)]

def build(perm_fn):
    kd = [ekg(perm_fn(t)) for t in kd0]
    # orbit of kd[0] under S7 (setwise action on arc-sets)
    seen = {}
    O = []
    def canon(a):
        return a  # frozenset already hashable/canonical
    work = [kd[0]]
    seen[kd[0]] = 0
    O.append(kd[0])
    while work:
        a = work.pop()
        for p in S7:
            b = act_arcset(a, p)
            if b not in seen:
                seen[b] = len(O); O.append(b); work.append(b)
    return kd, O, seen

def try_build():
    for name, fn in [("oneline", perm_oneline), ("cycle", perm_cycle)]:
        kd, O, seen = build(fn)
        print(f"interp {name}: orbit size {len(O)}", flush=True)
        if len(O) == 210:
            print("USING", name)
            return kd, O, seen, name
    return None

res = try_build()
if res is None:
    sys.exit("no interpretation gives orbit 210")
kd, O, seen, interp = res

# edges: union over g in kd[1:] of the S7-orbit of pair (pos(kd0), pos(g)) under simultaneous action
pos = seen
v0 = pos[kd[0]]
edges = set()
for g in kd[1:]:
    gpos = pos[g]
    # orbit of unordered pair {v0,gpos} under S7
    for p in S7:
        # act on O indices: p sends element O[i] to its image; build index map lazily
        pass
# need action of S7 on the 210 elements: precompute image index of each element under each perm
# image index of O[i] under p = pos[ act_arcset(O[i],p) ] — expensive but ok: 5040*210*~14
print("building index action...", flush=True)
act = []
for p in S7:
    img = [0] * 210
    for i in range(210):
        img[i] = pos[act_arcset(O[i], p)]
    act.append(img)
print("action done", flush=True)

for g in kd[1:]:
    gpos = pos[g]
    for img in act:
        a, b = img[v0], img[gpos]
        edges.add((min(a, b), max(a, b)))

adj = [set() for _ in range(210)]
for a, b in edges:
    adj[a].add(b); adj[b].add(a)

def srg_params(adj):
    n = len(adj)
    degs = set(len(a) for a in adj)
    if len(degs) != 1:
        return ("irregular", degs)
    k = degs.pop()
    commons = set()
    for i in range(n):
        for j in range(i + 1, n):
            c = len(adj[i] & adj[j])
            commons.add((j in adj[i], c))
    adj_c = {c for (e, c) in commons if e}
    non_c = {c for (e, c) in commons if not e}
    return (n, k, adj_c if len(adj_c) == 1 else adj_c, non_c if len(non_c) == 1 else non_c)

print("edges:", len(edges), "params:", srg_params(adj), flush=True)

import json
json.dump([sorted(a) for a in adj], open("/tmp/srg210_99_48_45.json", "w"))
print("saved /tmp/srg210_99_48_45.json")
