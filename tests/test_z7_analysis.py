import numpy as np

# Orbit decomposition under Z_7:
# 15 orbits:
# Orbit 0: {0} (fixed point)
# Orbits 1..14: each of size 7
# Total vertices = 1 + 14 * 7 = 99

# Let B be the 15x15 orbit quotient matrix, where B_{i,j} is the number of neighbors
# a vertex in orbit i has in orbit j.
# Degree equation: sum_j B_{i,j} = 14 for all i.
# Orbit sizes: |O_0| = 1, |O_i| = 7 for i in 1..14.
# Intersection equation: |O_i| * B_{i,j} = |O_j| * B_{j,i} (number of edges between O_i and O_j)
# For i=0: B_{0,1} = 7, B_{0,2} = 7, B_{0,j} = 0 for j >= 3.
# By symmetry:
# B_{1,0} = 1, B_{2,0} = 1, B_{j,0} = 0 for j >= 3.

print("Starting Z_7 orbit quotient matrix analysis...")
