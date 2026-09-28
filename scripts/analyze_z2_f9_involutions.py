#!/usr/bin/env python3
"""
analyze_z2_f9_involutions.py
Formal analyzer and refuter for involutions (Z_2) with f = 9 fixed points
on Conway's 99-graph srg(99, 14, 1, 2).

Theorems applied:
1. Spectral trace: eps_1 = 7a - 198 ≡ 5 (mod 7). Candidates in [0, 45]: {5, 12, 19, 26, 33, 40}.
2. Degree rigidity: d(u) = 1 for u ~ t(u) (lambda=1), d(u) in {0, 2} for u !~ t(u) (mu=2).
3. Universal identity: eps_1 = f*(8 - f) + sum_{z in Fix(t)} binom(deg_H(z), 2) = -9 + sum binom.
4. Common-neighbor rigidity: for every non-adjacent pair x, y in Fix(t), c_Fix(x, y) in {0, 2}.
"""

import sys
import z3

def main():
    print("=" * 75)
    print("EXHAUSTIVE ANALYSIS AND REFUTATION FOR f = 9 FIXED POINTS")
    print("=" * 75)
    
    f = 9
    spectral_mod = (5 * (f - 1)) % 7
    allowed_eps = [e for e in range(0, 46) if e % 7 == spectral_mod]
    print(f"Spectral trace requires: eps_1 ≡ {spectral_mod} (mod 7)")
    print(f"Admissible candidates in [0, 45]: {allowed_eps}")
    print(f"Internal-edge formula: eps_1 = -9 + sum_{{z in Fix(t)}} binom(deg_H(z), 2)")
    
    s = z3.Solver()
    A = [[z3.Int(f"a_{i}_{j}") for j in range(f)] for i in range(f)]
    for i in range(f):
        s.add(A[i][i] == 0)
        for j in range(f):
            if i != j:
                s.add(z3.Or(A[i][j] == 0, A[i][j] == 1))
        for j in range(i + 1, f):
            s.add(A[i][j] == A[j][i])
            
    C = {}
    for i in range(f):
        for j in range(i + 1, f):
            for k in range(f):
                if k != i and k != j:
                    c_ijk = z3.Int(f"c_{i}_{j}_{k}")
                    s.add(z3.Or(c_ijk == 0, c_ijk == 1))
                    s.add(c_ijk <= A[i][k])
                    s.add(c_ijk <= A[j][k])
                    s.add(c_ijk >= A[i][k] + A[j][k] - 1)
                    C[(i, j, k)] = c_ijk
                    
    for i in range(f):
        for j in range(i + 1, f):
            cn_ij = z3.Sum([C[(i, j, k)] for k in range(f) if k != i and k != j])
            # If edge: lambda = 1
            s.add(z3.Implies(A[i][j] == 1, cn_ij == 1))
            # If non-edge: mu in {0, 2} by parity!
            s.add(z3.Implies(A[i][j] == 0, z3.Or(cn_ij == 0, cn_ij == 2)))
            
    deg = [z3.Sum([A[i][j] for j in range(f) if j != i]) for i in range(f)]
    for i in range(f):
        s.add(deg[i] <= 14)
        
    binom_deg = []
    for i in range(f):
        b = z3.Int(f"b_{i}")
        s.add(b >= 0)
        s.add(z3.Implies(deg[i] == 0, b == 0))
        s.add(z3.Implies(deg[i] == 2, b == 1))
        s.add(z3.Implies(deg[i] == 4, b == 6))
        s.add(z3.Implies(deg[i] == 6, b == 15))
        s.add(z3.Implies(deg[i] == 8, b == 28))
        binom_deg.append(b)
        
    sum_binom = z3.Sum(binom_deg)
    eps_1 = z3.Int("eps_1")
    s.add(eps_1 == -9 + sum_binom)
    s.add(eps_1 >= 0, eps_1 <= (99 - f) // 2)
    s.add(z3.Or([eps_1 == val for val in allowed_eps]))
    
    print("\nRunning exhaustive Z3 check...")
    res = s.check()
    print(f"Z3 result for f = 9: {res}")
    if res == z3.unsat:
        print("\n" + "=" * 75)
        print("CONCLUSION:")
        print("NO LOCALLY LINEAR SUBGRAPH ON 9 VERTICES WITH c_Fix in {0, 2}")
        print("SATISFIES THE SPECTRAL CONGRUENCE eps_1 ≡ 5 (mod 7).")
        print("UNDER THESE CONSTRAINTS, CASE f = 9 IS REFUTED.")
        print("=" * 75)
    else:
        print(f"Model found: {res}")

if __name__ == "__main__":
    main()
