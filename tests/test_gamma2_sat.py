import time
from pysat.solvers import Cadical195, Glucose42
from pysat.card import CardEnc, EncType
from pysat.formula import CNF

print("Setting up Gamma_2 under Z_7...")
t0 = time.time()

# 12 orbits in Gamma_2:
# Orbits 0, 1, 2: (LL)_1, (LL)_2, (LL)_3
# Orbits 3, 4, 5: (RR)_1, (RR)_2, (RR)_3
# Orbits 6, 7, 8, 9, 10, 11: (LR)_1, ..., (LR)_6

# Vertices: 84 vertices, indexed (p, t) for p in 0..11, t in 0..6
# Coordinates of (p, t):
def get_coords(p, t):
    # returns set of 2 strings: e.g. {"1L", "2L"}
    # t is shift 0..6 (1-based indices in Z_7: (i + t) % 7 + 1)
    if p in (0, 1, 2):
        d = p + 1 # diff 1, 2, 3
        # pair is {i, i+d} with shift t
        i1 = (0 + t) % 7 + 1
        i2 = (d + t) % 7 + 1
        return {f"{i1}L", f"{i2}L"}
    elif p in (3, 4, 5):
        d = (p - 3) + 1 # diff 1, 2, 3
        i1 = (0 + t) % 7 + 1
        i2 = (d + t) % 7 + 1
        return {f"{i1}R", f"{i2}R"}
    else:
        d = (p - 6) + 1 # diff 1..6
        i1 = (0 + t) % 7 + 1
        i2 = (d + t) % 7 + 1
        return {f"{i1}L", f"{i2}R"}

# Let's verify coords for all 84 vertices
coords = {}
for p in range(12):
    for t in range(7):
        coords[(p, t)] = get_coords(p, t)

assert len(coords) == 84
# Check that all 84 non-edges are unique
all_pairs = [tuple(sorted(list(c))) for c in coords.values()]
assert len(set(all_pairs)) == 84
print("All 84 vertices uniquely and correctly mapped to Gamma_1 non-edges!")

# Circulant variables:
# x[(p, q, d)] for 0 <= p < q < 12, d in 0..6
# x[(p, p, d)] for 0 <= p < 12, d in 1..3
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

print(f"Total independent binary variables: {top_id}")

def get_adj_var(p1, t1, p2, t2):
    if p1 == p2:
        diff = (t2 - t1) % 7
        if diff == 0:
            return None # diagonal is 0
        d = min(diff, 7 - diff)
        return var_id[(p1, p1, d)]
    elif p1 < p2:
        diff = (t2 - t1) % 7
        return var_id[(p1, p2, diff)]
    else:
        diff = (t1 - t2) % 7
        return var_id[(p2, p1, diff)]

cnf = CNF()

# Constraint 1: Degree of every vertex in Gamma_2 is 12
for p in range(12):
    lits = []
    for q in range(12):
        for t in range(7):
            v = get_adj_var(p, 0, q, t)
            if v is not None:
                lits.append(v)
    assert len(lits) == 83
    card_cnf = CardEnc.equals(lits=lits, bound=12, top_id=top_id, encoding=EncType.seqcounter)
    top_id = card_cnf.nv
    cnf.extend(card_cnf.clauses)

print(f"Degree constraints added in {time.time() - t0:.2f}s. Clauses: {len(cnf.clauses)}, top_id: {top_id}")
