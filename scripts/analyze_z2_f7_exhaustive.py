#!/usr/bin/env python3
"""
analyze_z2_f7_exhaustive.py
Exhaustive check, under the constraints listed below, of involutions
with f = 7 fixed points on Conway's 99-graph srg(99, 14, 1, 2).

Theorems applied:
1. Spectral trace: eps_1 = 7a - 194 ≡ 2 (mod 7).
2. Degree rigidity on internal edges: for every u ~ t(u), d(u) = 1 exactly (by lambda = 1).
3. Degree rigidity on transposed pairs: for every u !~ t(u), d(u) in {0, 2} (by mu = 2).
4. Universal counting identity:
   eps_1 = f*(8 - f) + sum_{z in Fix(t)} binom(deg_H(z), 2)
   For f = 7: eps_1 = 7 + sum_{z in Fix(t)} binom(deg_H(z), 2) ≡ sum binom(deg_H(z), 2) (mod 7).
5. Common-neighbor rigidity in Fix(t): for every non-adjacent pair x, y in Fix(t), c_Fix(x, y) in {0, 2}.
"""

from itertools import combinations

def main():
    print("=" * 75)
    print("EXHAUSTIVE NONEXISTENCE CHECK: INVOLUTIONS WITH f = 7")
    print("=" * 75)
    
    # Vertices of Fix(t)
    V = list(range(7))
    all_triangles = list(combinations(V, 3))
    
    # 1. Generate all collections of triangles where no two triangles share an edge (lambda = 1)
    valid_triangle_sets = [[]]
    
    def can_add(t_set, new_t):
        new_set = set(new_t)
        for t in t_set:
            if len(set(t) & new_set) >= 2:
                return False
        return True
        
    def search(idx, current):
        if idx == len(all_triangles):
            return
        search(idx + 1, current)
        if can_add(current, all_triangles[idx]):
            new_curr = current + [all_triangles[idx]]
            valid_triangle_sets.append(new_curr)
            search(idx + 1, new_curr)
            
    search(0, [])
    print(f"1. Total locally linear subgraphs possible on 7 vertices: {len(valid_triangle_sets)}")
    
    # 2. Filter by c_Fix(x, y) in {0, 2} for all non-edges (mu_Fix in {0, 2})
    admissible_graphs = []
    for t_set in valid_triangle_sets:
        adj = [[0]*7 for _ in range(7)]
        deg = [0]*7
        for u, v, w in t_set:
            adj[u][v] = adj[v][u] = 1
            adj[u][w] = adj[w][u] = 1
            adj[v][w] = adj[w][v] = 1
            deg[u] += 2
            deg[v] += 2
            deg[w] += 2
            
        valid = True
        for i in range(7):
            for j in range(i + 1, 7):
                if adj[i][j] == 0:
                    cn = sum(adj[i][k] * adj[j][k] for k in range(7))
                    if cn not in (0, 2):
                        valid = False
                        break
            if not valid:
                break
                
        if not valid:
            continue
            
        sum_binom = sum(d * (d - 1) // 2 for d in deg)
        eps_1 = 7 + sum_binom
        eps_mod7 = eps_1 % 7
        admissible_graphs.append((len(t_set), tuple(sorted(deg, reverse=True)), sum_binom, eps_1, eps_mod7))
        
    print(f"2. Admissible subgraphs respecting c_Fix in {{0, 2}}: {len(admissible_graphs)}")
    
    matches = [g for g in admissible_graphs if g[4] == 2]
    print(f"3. Subgraphs compatible with the spectral trace eps_1 ≡ 2 (mod 7): {len(matches)}")
    
    unique_classes = sorted(list(set(admissible_graphs)))
    print("\n--- COMPLETE TOPOLOGICAL CLASSIFICATION OF ADMISSIBLE SUBGRAPHS ---")
    for t_count, degs, sum_b, eps_1, mod7 in unique_classes:
        print(f"Triangles: {t_count} | Degrees: {degs} | sum binom: {sum_b:3d} | eps_1 = {eps_1:3d} | eps_1 mod 7 = {mod7}")
        
    print("\n" + "=" * 75)
    if len(matches) == 0:
        print("MATHEMATICAL CONCLUSION:")
        print("NO ADMISSIBLE SUBGRAPH OF Fix(t) HAS eps_1 ≡ 2 (mod 7).")
        print("UNDER THESE CONSTRAINTS, CASE f = 7 IS REFUTED.")
    else:
        print(f"ALERT: {len(matches)} candidates were found.")
    print("=" * 75)

if __name__ == "__main__":
    main()
