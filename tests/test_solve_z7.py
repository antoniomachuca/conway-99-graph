import time
import z3

print("Building Z_7 strongly regular graph model...")
t0 = time.time()

# Vertices: 0 is fixed, (p, t) for p in 1..14, t in 0..6
# Map pair (u, v) -> Bool variable or fixed value
s = z3.Solver()

# Independent variables:
# x[p][q][d] for 1 <= p < q <= 14, d in 0..6
# x[p][p][d] for 1 <= p <= 14, d in 1..3
# With x[1][2][0] = 1, x[1][2][d] = 0 for d >= 1
# x[1][1][d] = 0, x[2][2][d] = 0

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
        # p1 > p2
        diff = (t1 - t2) % 7
        return vars_map[(p2, p1, diff)]

print("Adding degree constraints...")
# Degree of (p, 0) == 14
for p in range(1, 15):
    neighbors = []
    # neighbor 0
    neighbors.append(get_adj(p, 0, 0, 0))
    # neighbors in same orbit
    for t in range(1, 7):
        neighbors.append(get_adj(p, 0, p, t))
    # neighbors in other orbits
    for q in range(1, 15):
        if q != p:
            for t in range(7):
                neighbors.append(get_adj(p, 0, q, t))
    s.add(z3.PbEq([(n, 1) for n in neighbors], 14))

print("Adding common neighbor constraints with vertex 0...")
for p in range(3, 15):
    # (p, 0) not adjacent to 0 => exactly 2 common neighbors
    # common neighbors can only be in N(0) = O_1 U O_2
    cns = []
    for q in (1, 2):
        for t in range(7):
            cns.append(get_adj(p, 0, q, t))
    s.add(z3.PbEq([(cn, 1) for cn in cns], 2))

# Lex-leader symmetry breaking between orbits 3..14:
# Orbits 3..14 can be permuted arbitrarily as long as order is preserved.
print(f"Base constraints added in {time.time() - t0:.2f}s. Solver assertions: {len(s.assertions())}")
