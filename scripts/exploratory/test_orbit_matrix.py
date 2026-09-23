import numpy as np
import z3

# Let's check if there exists an orbit matrix B of size 15x15
# satisfying:
# B_{i,j} in {0..14}
# n = [1] + [7]*14
# row sum: sum_j B_{i,j} = 14
# D B = B^T D => n_i B_{i,j} = n_j B_{j,i}
# B^2 + B - 12*I = 2 * (1 * n^T)
# B_{0,0} = 0, B_{0,1} = 7, B_{0,2} = 7, B_{0,j} = 0 for j >= 3
# B_{1,0} = 1, B_{2,0} = 1, B_{j,0} = 0 for j >= 3
# B_{1,1} = 0, B_{2,2} = 0, B_{1,2} = 1, B_{2,1} = 1
# B_{i,i} in {0, 2, 4, 6} for all i

solver = z3.Solver()

B = [[z3.Int(f"B_{i}_{j}") for j in range(15)] for i in range(15)]
n = [1] + [7]*14

for i in range(15):
    for j in range(15):
        solver.add(B[i][j] >= 0, B[i][j] <= 14)
        # Symmetry constraint
        solver.add(n[i] * B[i][j] == n[j] * B[j][i])

# Fixed row 0 and col 0
solver.add(B[0][0] == 0)
solver.add(B[0][1] == 7)
solver.add(B[0][2] == 7)
for j in range(3, 15):
    solver.add(B[0][j] == 0)

# Induced matching on N(0)
solver.add(B[1][1] == 0)
solver.add(B[2][2] == 0)
solver.add(B[1][2] == 1)

# Diagonal parity for Z_7 circulant
for i in range(1, 15):
    # circulant degrees on 7 vertices are even: 0, 2, 4, 6
    solver.add(z3.Or(B[i][i] == 0, B[i][i] == 2, B[i][i] == 4, B[i][i] == 6))

# Row sum
for i in range(15):
    solver.add(z3.Sum([B[i][j] for j in range(15)]) == 14)

# B^2 + B - 12*I = 2 * (1 * n^T)
# (B^2)_{i,j} + B_{i,j} - 12 * (1 if i==j else 0) == 2 * n[j]
for i in range(15):
    for j in range(15):
        b2_ij = z3.Sum([B[i][k] * B[k][j] for k in range(15)])
        target = 2 * n[j] + (12 if i == j else 0)
        solver.add(b2_ij + B[i][j] == target)

print("Solving for orbit quotient matrix B...")
res = solver.check()
print("Result:", res)
if res == z3.sat:
    m = solver.model()
    B_val = np.array([[m[B[i][j]].as_long() for j in range(15)] for i in range(15)])
    print("Found orbit matrix B:")
    print(B_val)
