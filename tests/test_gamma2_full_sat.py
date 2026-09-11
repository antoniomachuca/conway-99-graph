import time
from pysat.solvers import Cadical195, Kissat404, Glucose42
from pysat.card import CardEnc, EncType
from pysat.formula import CNF

t0 = time.time()

def get_coords(p, t):
    if p in (0, 1, 2):
        d = p + 1
        i1 = (0 + t) % 7 + 1
        i2 = (d + t) % 7 + 1
        return {f"{i1}L", f"{i2}L"}
    elif p in (3, 4, 5):
        d = (p - 3) + 1
        i1 = (0 + t) % 7 + 1
        i2 = (d + t) % 7 + 1
        return {f"{i1}R", f"{i2}R"}
    else:
        d = (p - 6) + 1
        i1 = (0 + t) % 7 + 1
        i2 = (d + t) % 7 + 1
        return {f"{i1}L", f"{i2}R"}

coords = {}
for p in range(12):
    for t in range(7):
        coords[(p, t)] = get_coords(p, t)

all_coords = [f"{i}L" for i in range(1, 8)] + [f"{i}R" for i in range(1, 8)]

var_id = {}
top_id = 0
for p in range(12):
    for q in range(p, 12):
        if p == q:
            for d in range(1, 4):
                top_id += 1
                var_id[(p, p, d)] = top_id
        else:
            for d in range(7):
                top_id += 1
                var_id[(p, q, d)] = top_id

def get_adj_var(p1, t1, p2, t2):
    if p1 == p2:
        diff = (t2 - t1) % 7
        if diff == 0:
            return None
        d = min(diff, 7 - diff)
        return var_id[(p1, p1, d)]
    elif p1 < p2:
        diff = (t2 - t1) % 7
        return var_id[(p1, p2, diff)]
    else:
        diff = (t1 - t2) % 7
        return var_id[(p2, p1, diff)]

cnf = CNF()

# Coordinate constraints from Lemma 4.7
for p in range(12):
    v = (p, 0)
    c_v = coords[v]
    opp_v = {f"{c[:-1]}{'R' if c.endswith('L') else 'L'}" for c in c_v}
    
    for K in all_coords:
        lits = []
        for q in range(12):
            for t in range(7):
                if (q, t) == v:
                    continue
                if K in coords[(q, t)]:
                    adj = get_adj_var(p, 0, q, t)
                    assert adj is not None
                    lits.append(adj)
        
        bound = 1 if (K in c_v or K in opp_v) else 2
        card_cnf = CardEnc.equals(lits=lits, bound=bound, top_id=top_id, encoding=EncType.seqcounter)
        top_id = card_cnf.nv
        cnf.extend(card_cnf.clauses)

print(f"Coordinate constraints added: {len(cnf.clauses)} clauses, top_id={top_id}")

# Distinct pairs modulo Z_7
pairs = []
for p in range(12):
    for q in range(p, 12):
        if p == q:
            for dt in range(1, 4):
                pairs.append(((p, 0), (q, dt)))
        else:
            for dt in range(7):
                pairs.append(((p, 0), (q, dt)))

print(f"Pairs to constrain: {len(pairs)}")

# Helper to manage AND auxiliary variables: y <=> a and b
aux_and = {}
def get_and_var(a, b):
    if a > b:
        a, b = b, a
    k = (a, b)
    global top_id
    if k not in aux_and:
        top_id += 1
        y = top_id
        # y <=> a and b
        cnf.append([-y, a])
        cnf.append([-y, b])
        cnf.append([y, -a, -b])
        aux_and[k] = y
    return aux_and[k]

t_enc = time.time()
for idx, (u, v) in enumerate(pairs):
    c_uv = len(coords[u].intersection(coords[v]))
    target_bound = 2 - c_uv
    
    a_uv = get_adj_var(u[0], u[1], v[0], v[1])
    lits = [a_uv] if a_uv is not None else []
    
    for q in range(12):
        for t in range(7):
            w = (q, t)
            if w == u or w == v:
                continue
            a_uw = get_adj_var(u[0], u[1], w[0], w[1])
            a_vw = get_adj_var(v[0], v[1], w[0], w[1])
            if a_uw is not None and a_vw is not None:
                lits.append(get_and_var(a_uw, a_vw))
                
    card_cnf = CardEnc.equals(lits=lits, bound=target_bound, top_id=top_id, encoding=EncType.seqcounter)
    top_id = card_cnf.nv
    cnf.extend(card_cnf.clauses)
    if (idx + 1) % 100 == 0:
        print(f"  Processed {idx + 1}/{len(pairs)} pairs in {time.time() - t_enc:.2f}s, clauses={len(cnf.clauses)}, top_id={top_id}")

print(f"Full CNF built in {time.time() - t0:.2f}s. Total clauses: {len(cnf.clauses)}, Total variables: {top_id}")

print("Solving with Cadical195...")
t_solve = time.time()
solver = Cadical195(bootstrap_with=cnf.clauses)
sat_result = solver.solve()
print(f"Cadical195 result: {sat_result} in {time.time() - t_solve:.2f}s")
