import time
import z3

print("Building Z_7 strongly regular graph model...")
t0 = time.time()

s = z3.Solver()
# Use sat logic if possible


vars_map = {}

# Define variables
for p in range(1, 15):
    for q in range(p, 15):
        if p == q:
            for d in range(1, 4):
                if p in (1, 2):
                    vars_map[(p, p, d)] = z3.BoolVal(False)
                else:
                    vars_map[(p, p, d)] = z3.Bool(f"x_{p}_{p}_{d}")
        else:
            for d in range(7):
                if (p, q) == (1, 2):
                    vars_map[(p, q, d)] = z3.BoolVal(d == 0)
                else:
                    vars_map[(p, q, d)] = z3.Bool(f"x_{p}_{q}_{d}")

def get_adj(p1, t1, p2, t2):
    if p1 == 0 and p2 == 0:
        return z3.BoolVal(False)
    if p1 == 0:
        if p2 in (1, 2):
            return z3.BoolVal(True)
        return z3.BoolVal(False)
    if p2 == 0:
        return get_adj(p2, t2, p1, t1)
    
    if p1 == p2:
        diff = (t2 - t1) % 7
        if diff == 0:
            return z3.BoolVal(False)
        d = min(diff, 7 - diff)
        return vars_map[(p1, p1, d)]
    elif p1 < p2:
        diff = (t2 - t1) % 7
        return vars_map[(p1, p2, diff)]
    else:
        diff = (t1 - t2) % 7
        return vars_map[(p2, p1, diff)]

# Vertex list
all_vertices = [(0, 0)]
for p in range(1, 15):
    for t in range(7):
        all_vertices.append((p, t))

print(f"Total vertices: {len(all_vertices)}")

# Degree of (p, 0) == 14
for p in range(1, 15):
    neighbors = [get_adj(p, 0, vp, vt) for (vp, vt) in all_vertices if not (vp == p and vt == 0)]
    s.add(z3.PbEq([(n, 1) for n in neighbors], 14))

# Common neighbors with 0
for p in range(3, 15):
    cns = [get_adj(p, 0, vp, vt) for (vp, vt) in all_vertices if vp in (1, 2)]
    s.add(z3.PbEq([(cn, 1) for cn in cns], 2))

# Now common neighbors between (p, 0) and (q, dt)
# Distinct pairs:
pairs = []
for p in range(1, 15):
    for q in range(p, 15):
        if p == q:
            for dt in range(1, 4):
                pairs.append(((p, 0), (q, dt)))
        else:
            for dt in range(7):
                pairs.append(((p, 0), (q, dt)))

print(f"Total pairs to constrain: {len(pairs)}")

# For each pair (u, v): sum_{w} (A_{uw} && A_{vw}) + A_{uv} == 2
# Let's introduce auxiliary variables for conjunctions that are not trivially false
aux_map = {}
def get_conj(a, b):
    if z3.is_false(a) or z3.is_false(b):
        return z3.BoolVal(False)
    if z3.is_true(a):
        return b
    if z3.is_true(b):
        return a
    if z3.eq(a, b):
        return a
    k = (a.get_id(), b.get_id()) if a.get_id() < b.get_id() else (b.get_id(), a.get_id())
    if k not in aux_map:
        v = z3.Bool(f"y_{k[0]}_{k[1]}")
        # v <=> a && b
        s.add(z3.Or(z3.Not(v), a))
        s.add(z3.Or(z3.Not(v), b))
        s.add(z3.Or(v, z3.Not(a), z3.Not(b)))
        aux_map[k] = v
    return aux_map[k]

t_c = time.time()
for idx, (u, v) in enumerate(pairs):
    terms = []
    a_uv = get_adj(u[0], u[1], v[0], v[1])
    if not z3.is_false(a_uv):
        terms.append((a_uv, 1))
    for w in all_vertices:
        if w == u or w == v:
            continue
        a_uw = get_adj(u[0], u[1], w[0], w[1])
        a_vw = get_adj(v[0], v[1], w[0], w[1])
        conj = get_conj(a_uw, a_vw)
        if not z3.is_false(conj):
            terms.append((conj, 1))
    s.add(z3.PbEq(terms, 2))
    if (idx + 1) % 100 == 0:
        print(f"  Processed {idx + 1}/{len(pairs)} pairs in {time.time() - t_c:.2f}s, aux vars: {len(aux_map)}")

print(f"Model constructed in {time.time() - t0:.2f}s. Total aux vars: {len(aux_map)}")
print("Solving with Z3...")
t_solve = time.time()
res = s.check()
print(f"Solve result: {res} in {time.time() - t_solve:.2f}s")
