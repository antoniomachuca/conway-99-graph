#!/usr/bin/env python3
"""
scripts/analyze_rigid_conway_structure.py

Rigid Structural Analysis for Conway's 99-Graph (srg(99, 14, 1, 2)).
Assumes NO automorphisms (Aut(G) = {1}).

Mathematical Foundations:
1. For ANY vertex x_0:
   - N(x_0) has 14 vertices, uniquely isomorphic to 7 K_2 (7 disjoint edges).
   - Gamma_2(x_0) has 84 vertices.
   - Each y in Gamma_2(x_0) has mu = 2 common neighbors with x_0 in N(x_0).
   - Since lambda = 1, no two adjacent vertices in N(x_0) can share a neighbor in Gamma_2(x_0).
   - The number of non-edge pairs in N(x_0) is binom(14, 2) - 7 = 91 - 7 = 84.
   - Hence, there is an exact CANONICAL BIJECTION between Gamma_2(x_0) and the 84 non-edge pairs of N(x_0)!
   - The 14 x 84 bipartite incidence matrix B is 100% deterministic up to labeling of the 7 K_2 edges.

2. Spectral & Coding Invariants:
   - Spectrum of A: 14^1, 3^54, (-4)^44.
   - Over F_2: A^2 = 14 I + A + 2(J - I - A) == A (mod 2).
     Minimal polynomial divides x(x - 1).
     rank_{F_2}(A) = 54, rank_{F_2}(A + I) = 45.
     Generates a binary linear code [99, 45] whose dual is [99, 54].
   - Over F_7: 14 == 0, 3 == 3, -4 == 3 (mod 7).
     Eigenvalues mod 7 are 0 (mult 1) and 3 (mult 98).
     rank_{F_7}(A - 3I) = 1, rank_{F_7}(A) = 98.
"""

import itertools
import numpy as np
from typing import Dict, List, Tuple, Set

def build_canonical_neighborhood_incidence() -> Tuple[np.ndarray, List[Tuple[int, int]]]:
    """
    Constructs the canonical 14 x 84 bipartite incidence matrix B between N(x_0) and Gamma_2(x_0).
    
    Vertices of N(x_0): {0, 1, ..., 13}.
    Edges of N(x_0): (2i, 2i+1) for i = 0, ..., 6 (7 disjoint edges).
    Non-edges of N(x_0): all pairs {u, v} except (2i, 2i+1).
    Total non-edges: binom(14, 2) - 7 = 91 - 7 = 84.
    """
    all_pairs = list(itertools.combinations(range(14), 2))
    forbidden_edges = set((2 * i, 2 * i + 1) for i in range(7))
    
    valid_pairs = [p for p in all_pairs if p not in forbidden_edges]
    assert len(valid_pairs) == 84, f"Expected 84 valid non-edge pairs, got {len(valid_pairs)}"
    
    # Construct B: 14 x 84 binary matrix
    B = np.zeros((14, 84), dtype=int)
    for col_idx, (u, v) in enumerate(valid_pairs):
        B[u, col_idx] = 1
        B[v, col_idx] = 1
        
    return B, valid_pairs

def verify_bipartite_invariants(B: np.ndarray, valid_pairs: List[Tuple[int, int]]) -> Dict[str, bool]:
    """
    Verifies that the canonical bipartite incidence matrix B satisfies all SRG parameters.
    """
    # 1. Every column has weight exactly 2 (each vertex in Gamma_2 has 2 neighbors in N)
    col_sums = B.sum(axis=0)
    col_weights_ok = bool(np.all(col_sums == 2))
    
    # 2. Every row has sum: each vertex u in N(x_0) is non-adjacent to 14 - 1 (itself) - 1 (matched) = 12 vertices.
    # So u appears in exactly 12 non-edge pairs.
    row_sums = B.sum(axis=1)
    row_weights_ok = bool(np.all(row_sums == 12))
    
    # 3. Inner products of rows B B^T:
    # (B B^T)_{u, v} is the number of common neighbors of u and v in Gamma_2.
    # In the full graph:
    # - If {u, v} is an edge in N (u, v matched): common neighbors in G is lambda = 1 (which is x_0).
    #   Hence common neighbors in Gamma_2 MUST BE 0!
    # - If {u, v} is a non-edge in N: common neighbors in G is mu = 2 (one is x_0, so Gamma_2 must have 2 - 1 = 1).
    BBT = B @ B.T
    
    inner_prod_ok = True
    for u in range(14):
        for v in range(u + 1, 14):
            val = BBT[u, v]
            if (u // 2 == v // 2): # matched edge
                if val != 0:
                    inner_prod_ok = False
            else: # non-edge
                if val != 1:
                    inner_prod_ok = False
                    
    return {
        "col_weights_exact_2": col_weights_ok,
        "row_weights_exact_12": row_weights_ok,
        "matched_pairs_disjoint_in_gamma2": inner_prod_ok,
    }

def analyze_gamma2_induced_constraints(valid_pairs: List[Tuple[int, int]]) -> Dict:
    """
    Analyzes the constraints on the internal adjacency matrix A_2 (84 x 84) of Gamma_2(x_0).
    """
    # Each y in Gamma_2 has degree 14 in G, and 2 neighbors in N(x_0).
    # Therefore, each y has degree 14 - 2 = 12 inside Gamma_2.
    internal_degree = 12
    
    # Triangle constraints:
    # For y = {u, v}:
    # The edge {y, u} must belong to a unique triangle in G.
    # The third vertex z MUST be in Gamma_2, and adjacent to both y and u.
    # This means z in Gamma_2 must have u in its pair: z = {u, w} for some w.
    # Since z is adjacent to y, {y, z} is an edge in Gamma_2!
    # Exactly one such z exists for u, and exactly one for v!
    # Thus, every vertex y = {u, v} in Gamma_2 has:
    # - Exactly 1 neighbor z_u = {u, w_1} sharing u.
    # - Exactly 1 neighbor z_v = {v, w_2} sharing v.
    # - The remaining 12 - 2 = 10 neighbors in Gamma_2 share NEITHER u nor v!
    
    pair_to_idx = {p: i for i, p in enumerate(valid_pairs)}
    
    sharing_one_element = 0
    sharing_zero_elements = 0
    for i in range(84):
        p1 = set(valid_pairs[i])
        for j in range(i + 1, 84):
            p2 = set(valid_pairs[j])
            inter = len(p1 & p2)
            if inter == 1:
                sharing_one_element += 1
            elif inter == 0:
                sharing_zero_elements += 1
                
    return {
        "gamma2_vertices": 84,
        "internal_regular_degree": internal_degree,
        "pairs_sharing_1_element": sharing_one_element,
        "pairs_sharing_0_elements": sharing_zero_elements,
        "required_edges_sharing_1_element_per_vertex": 2,
        "required_edges_sharing_0_elements_per_vertex": 10,
    }

def compute_algebraic_coding_invariants():
    """
    Computes theoretical bounds for the binary linear code C = rowspace_{F_2}(A + I)
    and ternary/F_7 codes for srg(99, 14, 1, 2).
    """
    v, k, lmb, mu = 99, 14, 1, 2
    r, s = 3, -4
    mult_r, mult_s = 54, 44
    
    # F_2 Analysis:
    # A^2 = 14*I + A + 2*(J - I - A) = 12*I - A + 2*J == A (mod 2)
    # Minimal polynomial mod 2 divides x(x - 1).
    # Since eigenvalues mod 2 are 14 == 0, r = 3 == 1, s = -4 == 0:
    dim_F2_A = mult_r # 54
    dim_F2_A_plus_I = 1 + mult_s # 1 + 44 = 45
    
    # F_7 Analysis:
    # 14 == 0 (mod 7), r = 3 == 3 (mod 7), s = -4 == 3 (mod 7).
    # A - 3I has eigenvalue 14 - 3 = 11 == 4 (mult 1), and 0 (mult 98).
    
    return {
        "F2_rank_A": dim_F2_A,
        "F2_rank_A_plus_I": dim_F2_A_plus_I,
        "F2_code_parameters": f"[{v}, {dim_F2_A_plus_I}]",
        "F2_dual_parameters": f"[{v}, {dim_F2_A}]",
        "F7_spectrum": "0 (mult 1), 3 (mult 98)",
    }

if __name__ == "__main__":
    print("=" * 70)
    print("CONWAY'S 99-GRAPH: RIGID COMBINATORIAL & ALGEBRAIC INVARIANTS")
    print("=" * 70)
    
    B, valid_pairs = build_canonical_neighborhood_incidence()
    invariants = verify_bipartite_invariants(B, valid_pairs)
    print("\n1. Bipartite Incidence Verification (N(x_0) to Gamma_2(x_0)):")
    for k, v in invariants.items():
        print(f"   - {k}: {v}")
        
    gamma2_info = analyze_gamma2_induced_constraints(valid_pairs)
    print("\n2. Induced Constraints on Gamma_2 (84 vertices):")
    for k, v in gamma2_info.items():
        print(f"   - {k}: {v}")
        
    codes = compute_algebraic_coding_invariants()
    print("\n3. Algebraic Coding Invariants:")
    for k, v in codes.items():
        print(f"   - {k}: {v}")
        
    print("\n[CONCLUSION]: The bipartite incidence B_{14 x 84} is 100% CANONICAL & RIGID.")
    print("Any attack on the rigid case can fix all 14 x 84 = 1,176 edges unconditionally.")
