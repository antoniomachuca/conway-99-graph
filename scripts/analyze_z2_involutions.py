#!/usr/bin/env python3
"""
analyze_z2_involutions.py
Formal Analysis and Quotient Orbit Matrix System for Conway's 99-Graph under Z_2 Involutions.

Authors: Mathematical Research Subagent
Project: Conway's 99-Graph Problem (srg(99, 14, 1, 2))
"""

import sys
import argparse
import itertools
from typing import List, Tuple, Dict, Optional
import numpy as np

def classify_z2_parameters(max_f: int = 15) -> Dict[int, List[Dict]]:
    """
    Classify the possible eigenspace multiplicities and internal edge counts
    for involutions t in Aut(G) with f fixed points (f odd, f <= max_f).
    
    Adjacency spectrum of srg(99, 14, 1, 2):
      k = 14 (mult 1)
      r = 3  (mult 54)
      s = -4 (mult 44)
    
    Permutation matrix P_t:
      On E_14: mult +1 = 1
      On E_3:  mult +1 = a, mult -1 = b, with a + b = 54
      On E_-4: mult +1 = c, mult -1 = d, with c + d = 44
    
    Fixed points:
      f = tr(P_t) = 1 + (a - b) + (c - d) = 2(a + c) - 97
      => 2(a + c) = f + 97
    
    Internal edges in length-2 orbits:
      2 * eps_1 = tr(A P_t) = 14 + 3(2a - 54) - 4(2c - 44) = 28 + 6a - 8c
      => eps_1 = 14 + 3a - 4c
      
    Congruence:
      eps_1 = 7a - 2f - 180 => eps_1 = 5(f - 1) (mod 7)
    """
    results = {}
    for f in range(1, max_f + 1, 2):
        total_orbits = (99 + f) // 2
        m2 = (99 - f) // 2
        sum_ac = (f + 97) // 2
        param_list = []
        for a in range(55):
            c = sum_ac - a
            if 0 <= c <= 44:
                b = 54 - a
                d = 44 - c
                eps1 = 14 + 3 * a - 4 * c
                if 0 <= eps1 <= m2:
                    param_list.append({
                        "f": f,
                        "total_orbits": total_orbits,
                        "m2": m2,
                        "a": a, "b": b,
                        "c": c, "d": d,
                        "eps1": eps1,
                        "mod7_check": eps1 % 7 == (5 * (f - 1)) % 7
                    })
        results[f] = param_list
    return results

def analyze_f1_structural_uniqueness():
    """
    Formal deductive proof for the f = 1 case:
    Shows that epsilon_1 = 7, k = 7, a = 27, c = 22 is the UNIQUE solution.
    """
    proof_steps = [
        ("Theorem 1 (Parity of Fixed Points)",
         "Any involution t in Aut(G) satisfies n = f + 2*m_2. Since n = 99 is odd, "
         "f = 99 - 2*m_2 is strictly odd. By Makhnev (2010), f in {1, 3, 5, ..., 15}."),
        
        ("Theorem 2 (Spectral Mod-7 Formula)",
         "From the spectrum 14^1, 3^54, (-4)^44, we have:\n"
         "  tr(P_t) = 2(a + c) - 97 = f => 2(a + c) = f + 97\n"
         "  2*eps_1 = tr(A P_t) = 28 + 6a - 8c => eps_1 = 14 + 3a - 4c\n"
         "Substituting c = (f + 97)/2 - a gives:\n"
         "  eps_1 = 7a - 2f - 180 = 7(a - 26) - 2(f - 1) = 5(f - 1) (mod 7).\n"
         "For f = 1: eps_1 = 7(a - 26) ≡ 0 (mod 7)."),
        
        ("Theorem 3 (Neighborhood 1-Factor Localization of Internal Edges)",
         "Let O = {u, t(u)} be any size-2 orbit with an internal edge (u ~ t(u)).\n"
         "In srg(99, 14, 1, 2), lambda = 1, so u and t(u) have a UNIQUE common neighbor w.\n"
         "Since t is an automorphism, t(w) is also a common neighbor of t(u) and t^2(u) = u.\n"
         "By uniqueness of common neighbor, t(w) = w, meaning w is a FIXED POINT of t.\n"
         "For f = 1, the ONLY fixed point in the entire graph is x_0.\n"
         "Therefore, w = x_0, which forces u ~ x_0 and t(u) ~ x_0.\n"
         "COROLLARY: ALL internal edges in the entire graph MUST lie inside N(x_0)!"),
        
        ("Theorem 4 (Action on 1-Factor in N(x_0))",
         "By Conway.Structural (conway_neighborhood_one_factor), N(x_0) induces 7 K_2.\n"
         "t preserves N(x_0) and has no fixed points on N(x_0) (since f = 1).\n"
         "t permutes the 7 edges e_1, ..., e_7 as an involution:\n"
         "  k fixed edges (t(e) = e => t swaps the two endpoints)\n"
         "  p transpositions (t swaps e with e')\n"
         "where k + 2p = 7 => k = 7 - 2p in {1, 3, 5, 7}.\n"
         "Each fixed edge is an orbit with an internal edge.\n"
         "Each transposed pair forms two orbits with NO internal edges.\n"
         "Thus, the total number of internal edges in N(x_0) is exactly k."),
        
        ("Theorem 5 (Uniqueness of Parameters for f = 1)",
         "By Theorem 3, eps_1 = k.\n"
         "By Theorem 4, k in {1, 3, 5, 7}.\n"
         "By Theorem 2, eps_1 = 7(a - 26) is a multiple of 7.\n"
         "The ONLY multiple of 7 in {1, 3, 5, 7} is 7!\n"
         "Therefore:\n"
         "  eps_1 = 7\n"
         "  k = 7  (all 7 edges of N(x_0) are fixed by t, p = 0)\n"
         "  a = 27 (multiplicity of +1 in E_3: 27 / 54, exactly half)\n"
         "  b = 27 (multiplicity of -1 in E_3: 27 / 54, exactly half)\n"
         "  c = 22 (multiplicity of +1 in E_-4: 22 / 44, exactly half)\n"
         "  d = 22 (multiplicity of -1 in E_-4: 22 / 44, exactly half)\n"
         "This establishes complete uniqueness of the f = 1 parameters!")
    ]
    return proof_steps

def construct_f1_design_matrix() -> Tuple[np.ndarray, np.ndarray]:
    """
    Construct the canonical 7 x 42 incidence matrix C = B_{1..7, 8..49}
    representing the connections between N(x_0) and Gamma_2(x_0).
    
    Properties:
      - 7 rows (orbits in N(x_0))
      - 42 columns (orbits in Gamma_2(x_0))
      - Each column has weight 2 (connections to N(x_0) = mu = 2)
      - Each pair {a, b} of {1..7} appears exactly twice: C C^T = 10 I_7 + 2 J_7
    """
    pairs = list(itertools.combinations(range(7), 2)) # 21 pairs
    assert len(pairs) == 21
    
    # Duplicate pairs to get 42 columns
    orbit_pairs = pairs + pairs
    assert len(orbit_pairs) == 42
    
    C = np.zeros((7, 42), dtype=int)
    for col_idx, (r1, r2) in enumerate(orbit_pairs):
        C[r1, col_idx] = 1
        C[r2, col_idx] = 1
        
    CCT = C @ C.T
    expected_CCT = 10 * np.eye(7, dtype=int) + 2 * np.ones((7, 7), dtype=int)
    assert np.array_equal(CCT, expected_CCT), "C C^T does not match 10 I + 2 J!"
    
    # CTC matrix of size 42 x 42
    CTC = C.T @ C
    return C, CTC

def evaluate_cnf_pb_complexity():
    """
    Evaluates variable space, fixed assignments, and clause requirements
    for a CNF/PB compiler targeting the f = 1 involution instance.
    """
    total_vertices = 99
    total_pairs = total_vertices * (total_vertices - 1) // 2 # 4851
    
    # Action of t:
    # 1 fixed point x_0 = 0
    # 49 orbits of size 2: (2i-1, 2i) for i in 1..49
    # Pairs fixed by t:
    # (u, v) fixed if t(u) = v and t(v) = u => the 49 size-2 orbits themselves!
    fixed_pairs_count = 49
    free_pair_orbits = (total_pairs - fixed_pairs_count) // 2 # 2401
    total_edge_variables = fixed_pairs_count + free_pair_orbits # 2450
    
    # Pre-fixed variables:
    # 1. From x_0 = 0:
    #    7 orbits to N(0): fixed to 1
    #    42 orbits to Gamma_2(0): fixed to 0
    fixed_from_x0 = 49
    
    # 2. Inside N(0) = {1..14}:
    #    7 internal edges: fixed to 1
    #    42 cross-orbit pairs: fixed to 0 (since N(0) is 7 K_2)
    fixed_in_N0 = 49
    
    # 3. Inside Gamma_2(0) = {15..98}:
    #    42 internal edges: fixed to 0 (no internal edges in Gamma_2(x_0))
    fixed_internal_gamma2 = 42
    
    total_prefixed = fixed_from_x0 + fixed_in_N0 + fixed_internal_gamma2 # 140
    free_boolean_vars = total_edge_variables - total_prefixed # 2310
    
    # Variable decomposition:
    # A. Edges between N(0) and Gamma_2(0):
    #    7 orbits in N(0) x 42 orbits in Gamma_2(0) x 2 (matchings) = 588 vars
    vars_N0_Gamma2 = 7 * 42 * 2
    
    # B. Edges within Gamma_2(0):
    #    binom(42, 2) orbit pairs x 2 matchings = 861 x 2 = 1722 vars
    vars_within_Gamma2 = 42 * 41 // 2 * 2
    
    assert vars_N0_Gamma2 + vars_within_Gamma2 == free_boolean_vars
    
    # Clause estimation:
    # Degree constraints (regularity k=14): 99 vertices
    # Each degree constraint on 14 neighbors among 98: Card networks ~ 99 * 150 clauses = 15,000 clauses
    #
    # Common neighbor constraints (lambda = 1 for adj, mu = 2 for non-adj):
    # For each pair (u, v):
    #   At most 1 common neighbor if adj
    #   At most 2 common neighbors if non-adj
    #   At least 1 if adj, at least 2 if non-adj
    # Card networks for 4851 pairs ~ 4851 * 80 clauses = 388,000 clauses
    #
    # Triangle / K_4-free cuts:
    # K_4 clauses: for each 4-set containing an edge, at most 3 edges => ~150,000 clauses
    #
    # Total CNF clauses: ~550,000 - 650,000 clauses
    
    return {
        "total_vertices": total_vertices,
        "total_pairs": total_pairs,
        "total_edge_variables": total_edge_variables,
        "prefixed_variables": total_prefixed,
        "free_boolean_vars": free_boolean_vars,
        "vars_N0_Gamma2": vars_N0_Gamma2,
        "vars_within_Gamma2": vars_within_Gamma2,
        "estimated_cnf_clauses": "550,000 - 650,000",
        "estimated_cnf_vars": free_boolean_vars + 45000, # with auxiliary Tseitin/Card variables
    }

def print_parameter_table(results: Dict[int, List[Dict]]):
    print("=" * 80)
    print("CLASSIFICATION OF INVOLUTIONS (Z_2) IN Aut(G) FOR srg(99, 14, 1, 2)")
    print("=" * 80)
    print(f"{'f':>3} | {'Orbits':>6} | {'m_2':>4} | {'a':>3} {'b':>3} {'c':>3} {'d':>3} | {'eps_1':>5} | {'eps_1 mod 7':>11} | {'Status':<15}")
    print("-" * 80)
    for f, tuples in results.items():
        for t in tuples:
            status = "DEDUCTIVELY UNIQUE" if f == 1 and t['eps1'] == 7 else "Admissible"
            mod_str = f"{t['eps1'] % 7} (exp {5*(f-1)%7})"
            print(f"{f:3d} | {t['total_orbits']:6d} | {t['m2']:4d} | {t['a']:3d} {t['b']:3d} {t['c']:3d} {t['d']:3d} | {t['eps1']:5d} | {mod_str:>11} | {status:<15}")
        if not tuples:
            print(f"{f:3d} | {'--':>6} | {'--':>4} | {'--':>3} {'--':>3} {'--':>3} {'--':>3} | {'--':>5} | {'--':>11} | {'EMPTY':<15}")
    print("=" * 80)

def main():
    parser = argparse.ArgumentParser(description="Analyze Z_2 Involutions on Conway's 99-Graph.")
    parser.add_argument("--all", action="store_true", help="Run full analysis")
    parser.add_argument("--table", action="store_true", help="Print parameter classification table")
    parser.add_argument("--f1", action="store_true", help="Print formal f=1 structural theorem")
    parser.add_argument("--cnf", action="store_true", help="Print CNF/PB complexity budget")
    args = parser.parse_args()
    
    if not (args.all or args.table or args.f1 or args.cnf):
        args.all = True
        
    print("=" * 80)
    print("CONWAY'S 99-GRAPH: Z_2 INVOLUTION & QUOTIENT ORBIT MATRIX ANALYSIS")
    print("=" * 80)
    
    results = classify_z2_parameters(15)
    
    if args.all or args.table:
        print_parameter_table(results)
        
    if args.all or args.f1:
        print("\n" + "=" * 80)
        print("FORMAL DEDUCTION: THE CASE f = 1 (UNIQUE PARAMETER COLLAPSE)")
        print("=" * 80)
        steps = analyze_f1_structural_uniqueness()
        for title, text in steps:
            print(f"\n[+] {title}:\n{text}")
            
        print("\n[+] Verification of 2-Design Matrix C (N(x_0) to Gamma_2(x_0)):")
        C, CTC = construct_f1_design_matrix()
        print(f"    Matrix C shape: {C.shape} (7 rows, 42 columns)")
        print(f"    Row sums: {np.sum(C, axis=1)} (all 12)")
        print(f"    Col sums: {np.sum(C, axis=0)[:6]}... (all 2)")
        print(f"    C C^T = 10 * I_7 + 2 * J_7 verified: TRUE")
        print(f"    Diagonal of CTC: {np.diag(CTC)[:6]}... (all 2)")
        
    if args.all or args.cnf:
        print("\n" + "=" * 80)
        print("CNF / PB COMPILATION COMPLEXITY EVALUATION (f = 1)")
        print("=" * 80)
        budget = evaluate_cnf_pb_complexity()
        for k, v in budget.items():
            print(f"  {k:<28}: {v}")
        print("\nComparison with other symmetry sectors:")
        print("  - Z_7 instance       : 342,558 clauses,  45,717 vars (tight cuts)")
        print("  - Z_3 (fixed-3)      : 1,555,332 clauses, 713,295 vars")
        print("  - Z_3 (fpf)          : 1,857,984 clauses, 851,103 vars")
        print("  - Z_2 (f=1 instance) : ~600,000 clauses,  ~47,000 vars")
        print("  -> Solvability Profile: ~2,310 primary free boolean variables, highly structured 2-design.")
    print("=" * 80)

if __name__ == "__main__":
    main()
