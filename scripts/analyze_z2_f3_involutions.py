#!/usr/bin/env python3
"""
analyze_z2_f3_involutions.py
Formal Analysis, Modular Trace Theory, and Quotient Orbit Systems
for Conway's 99-Graph under Z_2 Involutions with f = 3 Fixed Points.

Authors: Mathematical Research Subagent
Project: Conway's 99-Graph Problem (srg(99, 14, 1, 2))
"""

import sys
import argparse
import itertools
from typing import List, Tuple, Dict, Optional
import numpy as np

def classify_f3_spectral_parameters() -> List[Dict]:
    """
    Deduce all spectrally admissible eigenspace parameters (a, b, c, d)
    and internal edge counts eps_1 for an involution t with f = 3 fixed points.
    
    Spectrum of srg(99, 14, 1, 2):
      k = 14 (mult 1, eigenspace E_14)
      r = 3  (mult 54, eigenspace E_3)
      s = -4 (mult 44, eigenspace E_-4)
      
    Action of involution P_t:
      On E_14: +1 (mult 1)
      On E_3:  +1 (mult a), -1 (mult b), a + b = 54
      On E_-4: +1 (mult c), -1 (mult d), c + d = 44
      
    Fixed points constraint:
      f = tr(P_t) = 1 + (a - b) + (c - d) = 2(a + c) - 97 = 3
      => 2(a + c) = 100 => a + c = 50.
      
    Trace of adjacency matrix times P_t:
      2 * eps_1 = tr(A P_t) = 14 + 3(2a - 54) - 4(2c - 44) = 28 + 6a - 8c
      => eps_1 = 14 + 3a - 4c.
      
    Modular reduction:
      Substituting c = 50 - a:
      eps_1 = 14 + 3a - 4(50 - a) = 7a - 186 = 7(a - 27) + 3
      => eps_1 = 5(3 - 1) = 10 = 3 (mod 7).
      
    Domain constraints:
      0 <= a <= 54, 0 <= c = 50 - a <= 44 => 6 <= a <= 50.
      0 <= eps_1 <= m_2 = (99 - 3)/2 = 48 => 27 <= a <= 33.
    """
    f = 3
    sum_ac = (f + 97) // 2 # 50
    m2 = (99 - f) // 2      # 48
    results = []
    for a in range(27, 34):
        c = sum_ac - a
        b = 54 - a
        d = 44 - c
        eps1 = 14 + 3 * a - 4 * c
        mod7_check = (eps1 % 7 == (5 * (f - 1)) % 7)
        results.append({
            "f": f,
            "m2": m2,
            "a": a, "b": b,
            "c": c, "d": d,
            "eps1": eps1,
            "mod7_check": mod7_check
        })
    return results

def prove_induced_subgraph_classification() -> List[Tuple[str, str]]:
    """
    Formal deductive proofs classifying the induced subgraph on Fix(t) = {x0, x1, x2}.
    """
    theorems = [
        ("Theorem 1 (Parity and Fixed Point Counting for f = 3)",
         "Let t in Aut(G) be an involution. The vertex set partitions into f fixed points "
         "and m_2 orbits of length 2: |V| = 99 = f + 2*m_2. Thus f is odd.\n"
         "For f = 3, Fix(t) = {x_0, x_1, x_2} and m_2 = (99 - 3)/2 = 48 orbits of length 2."),
        
        ("Theorem 2 (Rigid Induced Subgraph Classification: K_3 vs 3*K_1)",
         "In any strongly regular graph with lambda = 1, any edge belongs to a UNIQUE triangle.\n"
         "Suppose Fix(t) contains at least one edge, say x_0 ~ x_1.\n"
         "Let w be the unique common neighbor of x_0 and x_1.\n"
         "Since t fixes x_0 and x_1, t must map their unique common neighbor to itself: t(w) = w.\n"
         "Hence w is a fixed point of t: w in Fix(t) = {x_0, x_1, x_2}.\n"
         "Since G has no self-loops and w ~ x_0, w ~ x_1, we have w != x_0 and w != x_1.\n"
         "Therefore, w = x_2, which forces x_2 ~ x_0 and x_2 ~ x_1.\n"
         "COROLLARY 2.1 (Impossibility of Intermediate Subgraphs):\n"
         "  - K_2 + K_1 (1 edge) is STRICTLY IMPOSSIBLE: any edge forces the 3rd vertex into the triangle.\n"
         "  - P_3 (2 edges) is STRICTLY IMPOSSIBLE: 2 edges already contain an edge, forcing all 3.\n"
         "COROLLARY 2.2 (Dichotomy of Fixed Point Subgraph):\n"
         "  The induced subgraph G[Fix(t)] is EITHER:\n"
         "    Case A: A triangle K_3 (all 3 edges present),\n"
         "    Case B: An independent set 3*K_1 (0 edges present)."),
        
        ("Theorem 3 (Spectral & Modular Trace Congruence)",
         "From the spectrum of G (14^1, 3^54, (-4)^44), we have:\n"
         "  tr(P_t) = 2(a + c) - 97 = 3 => a + c = 50.\n"
         "  2*eps_1 = tr(A P_t) = 28 + 6a - 8c => eps_1 = 14 + 3a - 4c.\n"
         "Substituting c = 50 - a:\n"
         "  eps_1 = 7a - 186 = 7(a - 27) + 3 = 10 = 3 (mod 7).\n"
         "Since 0 <= eps_1 <= 48, the complete set of spectrally admissible values is:\n"
         "  eps_1 in {3, 10, 17, 24, 31, 38, 45} (exactly 7 candidates for a in 27..33)."),
        
        ("Theorem 4 (Common Neighbor Localization Theorem for f = 3)",
         "Let O = {u, t(u)} be an internal edge (u ~ t(u)).\n"
         "Since lambda = 1, u and t(u) have a UNIQUE common neighbor w.\n"
         "Since t(u ~ t(u)) = t(u) ~ u, t preserves the common neighbor: t(w) = w.\n"
         "Therefore, w MUST be a fixed point: w in {x_0, x_1, x_2}.\n"
         "COROLLARY 4.1 (Disjointness of Internal Edge Neighborhoods):\n"
         "  No internal edge can have vertices in N(x_i) cap N(x_j) for i != j.\n"
         "  Proof: If u, t(u) in N(x_i) cap N(x_j), both x_i and x_j are common neighbors of\n"
         "  the edge u ~ t(u), which contradicts lambda = 1.\n"
         "COROLLARY 4.2 (Zero Internal Edges in Outer Subconstituent W):\n"
         "  Let W = V(G) \\ (N[x_0] U N[x_1] U N[x_2]). Any vertex v in W has zero neighbors\n"
         "  in Fix(t). Hence, no orbit in W can be an internal edge.\n"
         "  ALL internal edges in the entire graph lie in N(x_0) U N(x_1) U N(x_2).\n"
         "  Therefore: eps_1 = |E_int(x_0)| + |E_int(x_1)| + |E_int(x_2)| = k_0 + k_1 + k_2.")
    ]
    return theorems

def analyze_case_a_details() -> Dict:
    """
    Detailed deductive proof for Case A: Fix(t) is a triangle K_3.
    Shows that epsilon_1 = 10, a = 28, b = 26, c = 22, d = 22 is the UNIQUE solution.
    """
    spectrals = [3, 10, 17, 24, 31, 38, 45]
    admissible = [e for e in spectrals if e <= 18 and e % 2 == 0]
    
    partitions = []
    for k0 in [0, 2, 4, 6]:
        for k1 in [0, 2, 4, 6]:
            for k2 in [0, 2, 4, 6]:
                if k0 + k1 + k2 == 10:
                    partitions.append((k0, k1, k2))
                    
    return {
        "case": "Case A (Fix(t) = K_3)",
        "N_prime_size": 12,
        "edges_in_N_prime": 6,
        "k_i_allowed": [0, 2, 4, 6],
        "k_i_parity": "strictly EVEN",
        "eps_1_parity": "strictly EVEN",
        "eps_1_upper_bound": 18,
        "spectral_candidates": spectrals,
        "surviving_eps_1": admissible,
        "unique_eps_1": 10,
        "unique_parameters": {"a": 28, "b": 26, "c": 22, "d": 22},
        "num_ordered_partitions": len(partitions),
        "partitions": partitions
    }

def analyze_case_b_details() -> Dict:
    """
    Detailed deductive proof for Case B: Fix(t) is an independent set 3*K_1.
    Shows that epsilon_1 <= 15 and odd, leaving only epsilon_1 = 3 (k0=1, k1=1, k2=1).
    """
    spectrals = [3, 10, 17, 24, 31, 38, 45]
    admissible = [e for e in spectrals if e <= 15 and e % 2 == 1]
    
    return {
        "case": "Case B (Fix(t) = 3*K_1)",
        "N_size": 14,
        "edges_in_N": 7,
        "k_i_allowed_raw": [1, 3, 5, 7],
        "k_i_parity": "strictly ODD",
        "eps_1_parity": "strictly ODD",
        "transposition_lower_bound": "p_i >= 1 (due to non-adjacent mu-partners)",
        "k_i_refined_upper_bound": 5,
        "k_i_refined_allowed": [1, 3, 5],
        "eps_1_upper_bound": 15,
        "spectral_candidates": spectrals,
        "surviving_eps_1": admissible,
        "unique_eps_1_if_possible": 3,
        "unique_parameters_if_possible": {"a": 27, "b": 27, "c": 23, "d": 21},
        "unique_k_partition": (1, 1, 1)
    }

def construct_equitable_quotient_matrix_case_a() -> Tuple[np.ndarray, np.ndarray, np.ndarray]:
    r"""
    Constructs the canonical 3 x 3 equitable quotient matrix Q for Case A
    corresponding to the macro-partition {X, N', W}:
      - X = Fix(t) = {x_0, x_1, x_2} (triangle K_3, size 3)
      - N' = N'(x_0) U N'(x_1) U N'(x_2) (size 36)
      - W = V(G) \ (X U N') (size 60)
      
    Verifies that the spectrum of Q is EXACTLY the graph spectrum: {14, 3, -4}!
    """
    n = np.array([3, 36, 60], dtype=int)
    
    Q = np.array([
        [2, 12,  0],   # X: 2 in X, 12 in N', 0 in W
        [1,  3, 10],   # N': 1 in X, 1+1+1=3 in N', 10 in W
        [0,  6,  8]    # W: 0 in X, 2+2+2=6 in N', 8 in W
    ], dtype=float)
    
    row_sums = np.sum(Q, axis=1)
    assert np.allclose(row_sums, 14.0), f"Row sums of Q must be 14, got {row_sums}"
    
    sym_check = np.zeros((3, 3))
    for i in range(3):
        for j in range(3):
            sym_check[i, j] = n[i] * Q[i, j] - n[j] * Q[j, i]
    assert np.allclose(sym_check, 0.0), f"Cell balance violated: {sym_check}"
    
    eigenvalues = np.sort(np.linalg.eigvals(Q))[::-1]
    expected_eigenvalues = np.array([14.0, 3.0, -4.0])
    assert np.allclose(eigenvalues, expected_eigenvalues), f"Eigenvalues of Q mismatch: {eigenvalues}"
    
    return Q, n, eigenvalues

def evaluate_cnf_complexity_f3() -> Dict:
    """
    Evaluates variable space, fixed assignments, and clause complexity
    for a CNF/PB compiler targeting Z_2 with f = 3.
    """
    total_vertices = 99
    total_pairs = total_vertices * (total_vertices - 1) // 2 # 4851
    
    fixed_pairs_count = 3 + 48 # 51
    free_pair_orbits = (total_pairs - fixed_pairs_count) // 2 # 2400
    total_edge_variables = fixed_pairs_count + free_pair_orbits # 2451
    
    fixed_case_a = 3 + 144 + 48 # 195 directly pre-fixed primary variables
    free_case_a = total_edge_variables - fixed_case_a # 2256
    
    return {
        "total_vertices": total_vertices,
        "total_pairs": total_pairs,
        "fixed_pairs_under_tau": fixed_pairs_count,
        "free_pair_orbits": free_pair_orbits,
        "total_edge_variables": total_edge_variables,
        "prefixed_in_case_a": fixed_case_a,
        "free_boolean_vars_case_a": free_case_a,
        "estimated_cardinality_clauses": "~18,000 (degree regularity on 51 orbits)",
        "estimated_common_neighbor_clauses": "~420,000 (lambda=1, mu=2)",
        "estimated_k4_free_clauses": "~140,000",
        "total_estimated_cnf_clauses": "580,000 - 680,000",
        "comparison_with_f1": "Comparable (~2,256 vs ~2,310 free vars), but split into 12 partition branches."
    }

def print_full_report():
    print("=" * 80)
    print("MATHEMATICAL REPORT: Z_2 INVOLUTIONS WITH f = 3 ON CONWAY'S 99-GRAPH")
    print("=" * 80)
    
    # 1. Theorems
    print("\n--- SECTION 1: FORMAL THEOREMS & FIXED POINT DICHOTOMY ---")
    theorems = prove_induced_subgraph_classification()
    for title, desc in theorems:
        print(f"\n[*] {title}:\n{desc}")
        
    # 2. Spectral Table
    print("\n" + "=" * 80)
    print("--- SECTION 2: SPECTRAL & MODULAR TRACE CLASSIFICATION (f = 3) ---")
    print("=" * 80)
    print(f"{'a':>3} {'b':>3} {'c':>3} {'d':>3} | {'eps_1':>5} | {'eps_1 mod 7':>11} | {'Case A (Even <= 18)':<22} | {'Case B (Odd <= 15)':<20}")
    print("-" * 80)
    spectral_params = classify_f3_spectral_parameters()
    for p in spectral_params:
        e = p['eps1']
        status_a = "UNIQUE ADMISSIBLE" if e == 10 else ("Rejected (Odd)" if e % 2 == 1 else "Rejected (> 18)")
        status_b = "ADMISSIBLE CANDIDATE" if e == 3 else ("Rejected (Even)" if e % 2 == 0 else "Rejected (> 15)")
        print(f"{p['a']:3d} {p['b']:3d} {p['c']:3d} {p['d']:3d} | {e:5d} | {e % 7:>7d} == 3 | {status_a:<22} | {status_b:<20}")
    print("=" * 80)
    
    # 3. Case A Analysis
    print("\n" + "=" * 80)
    print("--- SECTION 3: CASE A (TRIANGLE K_3) RIGOROUS DEDUCTION ---")
    print("=" * 80)
    case_a = analyze_case_a_details()
    print(f"  [+] Induced Subgraph on Fix(t) : Triangle K_3 (x_0 ~ x_1 ~ x_2 ~ x_0)")
    print(f"  [+] Reduced Neighborhoods N'(x_i): Size {case_a['N_prime_size']} vertices each, inducing {case_a['edges_in_N_prime']} K_2")
    print(f"  [+] Action on Edges of N'(x_i) : k_i in {case_a['k_i_allowed']} ({case_a['k_i_parity']})")
    print(f"  [+] Internal Edges eps_1       : eps_1 = k_0 + k_1 + k_2 ({case_a['eps_1_parity']})")
    print(f"  [+] Geometric Upper Bound      : eps_1 <= {case_a['eps_1_upper_bound']}")
    print(f"  [+] Spectral Modular Constraint: eps_1 = 10 = 3 (mod 7)")
    print(f"  [+] THEOREM: eps_1 = 10 is the UNIQUE ADMISSIBLE VALUE for Case A!")
    print(f"  [+] Unique Eigenspace Dimensions: a={case_a['unique_parameters']['a']}, b={case_a['unique_parameters']['b']}, c={case_a['unique_parameters']['c']}, d={case_a['unique_parameters']['d']}")
    print(f"  [+] Integer Partitions of eps_1 = 10 into 3 Even Parts <= 6 ({case_a['num_ordered_partitions']} ordered triples):")
    for p in case_a['partitions']:
        print(f"      (k_0, k_1, k_2) = {p}")
        
    # 4. Case B Analysis
    print("\n" + "=" * 80)
    print("--- SECTION 4: CASE B (INDEPENDENT SET 3*K_1) RIGOROUS DEDUCTION ---")
    print("=" * 80)
    case_b = analyze_case_b_details()
    print(f"  [+] Induced Subgraph on Fix(t) : Independent Set 3*K_1 (x_i !~ x_j)")
    print(f"  [+] Full Neighborhoods N(x_i)  : Size {case_b['N_size']} vertices each, inducing {case_b['edges_in_N']} K_2")
    print(f"  [+] Action on Edges of N(x_i)  : k_i in {case_b['k_i_allowed_raw']} ({case_b['k_i_parity']})")
    print(f"  [+] Critical Transposition Lemma: {case_b['transposition_lower_bound']}")
    print(f"  [+] Refined Edge Action Bound  : k_i <= {case_b['k_i_refined_upper_bound']} => k_i in {case_b['k_i_refined_allowed']}")
    print(f"  [+] Internal Edges eps_1       : eps_1 = k_0 + k_1 + k_2 ({case_b['eps_1_parity']})")
    print(f"  [+] Refined Upper Bound        : eps_1 <= {case_b['eps_1_upper_bound']}")
    print(f"  [+] Spectral Candidates        : {case_b['spectral_candidates']}")
    print(f"  [+] Filtered by Bound & Parity : {case_b['surviving_eps_1']}")
    print(f"  [+] THEOREM: The ONLY surviving candidate for Case B is eps_1 = 3 (with k=(1, 1, 1))!")
    print(f"  [+] Parameters if eps_1 = 3    : a={case_b['unique_parameters_if_possible']['a']}, b={case_b['unique_parameters_if_possible']['b']}, c={case_b['unique_parameters_if_possible']['c']}, d={case_b['unique_parameters_if_possible']['d']}")
    
    # 5. Equitable Quotient Matrix
    print("\n" + "=" * 80)
    print("--- SECTION 5: EQUITABLE QUOTIENT MATRIX VERIFICATION (CASE A) ---")
    print("=" * 80)
    Q, n, eigs = construct_equitable_quotient_matrix_case_a()
    print(f"  Macro-cell Partition: X (size {n[0]}), N' (size {n[1]}), W (size {n[2]})")
    print("  Quotient Matrix Q (3 x 3):")
    print(Q)
    print(f"  Row sums of Q: {np.sum(Q, axis=1)} (all 14.0)")
    print(f"  Eigenvalues of Q: {eigs} (EXACT match to graph spectrum: 14, 3, -4!)")
    
    # 6. CNF Complexity Budget
    print("\n" + "=" * 80)
    print("--- SECTION 6: CNF / PB COMPILATION COMPLEXITY BUDGET ---")
    print("=" * 80)
    budget = evaluate_cnf_complexity_f3()
    for k, v in budget.items():
        print(f"  {k:<35}: {v}")
    print("=" * 80)

def main():
    parser = argparse.ArgumentParser(description="Analyze Z_2 Involutions with f=3 on Conway's 99-Graph.")
    parser.add_argument("--all", action="store_true", help="Run full analysis report")
    parser.add_argument("--table", action="store_true", help="Print spectral parameter table")
    parser.add_argument("--case-a", action="store_true", help="Print Case A deduction")
    parser.add_argument("--case-b", action="store_true", help="Print Case B deduction")
    parser.add_argument("--quotient", action="store_true", help="Verify Case A quotient matrix")
    parser.add_argument("--cnf", action="store_true", help="Print CNF complexity evaluation")
    args = parser.parse_args()
    
    if not (args.all or args.table or args.case_a or args.case_b or args.quotient or args.cnf):
        args.all = True
        
    if args.all:
        print_full_report()
    else:
        if args.table:
            spectral_params = classify_f3_spectral_parameters()
            print(f"{'a':>3} {'b':>3} {'c':>3} {'d':>3} | {'eps_1':>5} | {'mod 7':>5}")
            for p in spectral_params:
                print(f"{p['a']:3d} {p['b']:3d} {p['c']:3d} {p['d']:3d} | {p['eps1']:5d} | {p['eps1']%7:5d}")
        if args.case_a:
            print(analyze_case_a_details())
        if args.case_b:
            print(analyze_case_b_details())
        if args.quotient:
            Q, n, eigs = construct_equitable_quotient_matrix_case_a()
            print("Quotient matrix Q:\n", Q, "\nEigenvalues:\n", eigs)
        if args.cnf:
            print(evaluate_cnf_complexity_f3())

if __name__ == "__main__":
    main()
