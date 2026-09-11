import time
from pysat.solvers import Cadical195, Glucose42
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
    # Opposite coords
    opp_v = set()
    for c in c_v:
        idx = c[:-1]
        side = 'R' if c.endswith('L') else 'L'
        opp_v.add(f"{idx}{side}")
    
    for K in all_coords:
        # Collect all w in Gamma_2 containing K
        lits = []
        for q in range(12):
            for t in range(7):
                if (q, t) == v:
                    continue
                if K in coords[(q, t)]:
                    adj = get_adj_var(p, 0, q, t)
                    assert adj is not None
                    lits.append(adj)
        
        if K in c_v or K in opp_v:
            bound = 1
        else:
            bound = 2
            
        card_cnf = CardEnc.equals(lits=lits, bound=bound, top_id=top_id, encoding=EncType.seqcounter)
        top_id = card_cnf.nv
        cnf.extend(card_cnf.clauses)

print(f"Coordinate constraints added in {time.time() - t0:.2f}s. Total clauses: {len(cnf.clauses)}, top_id: {top_id}")

# Test solver with just coordinate constraints
solver = Cadical195(bootstrap_with=cnf.clauses)
t_solve = time.time()
res = solver.solve()
print(f"Cadical solve result: {res} in {time.time() - t_solve:.2f}s")
