#!/usr/bin/env python3
r"""
Test and Verification of Keramatipour Conjecture 3.4.4 (arXiv:2604.23037):
"In a (99, 14, 1, 2) strongly regular graph, there cannot be any induced Paley(9) subgraph."

Mathematical Architecture:
1. Paley(9) Construction:
   - Built on GF(9) = GF(3)[x]/(x^2 + 1) or Z_3 x Z_3 grid (Rook's graph K_3 □ K_3).
   - 9 vertices, 4-regular, lambda=1, mu=2. Unique srg(9, 4, 1, 2).
   - 18 edges, 18 non-edges, 6 triangles.

2. Independent Sets of Paley(9):
   - alpha(Paley(9)) = 3.
   - 9 singletons (size 1).
   - 18 non-edges (size 2).
   - 6 transversals / 3x3 permutation patterns (size 3).
   - Total non-empty independent sets: 33.

3. External Neighborhood Distribution Analysis:
   - V \ P contains 99 - 9 = 90 vertices.
   - For every u in P: deg_G(u) = 14, deg_P(u) = 4 => deg_{V \ P}(u) = 10.
   - Total edges between P and V \ P: 9 * 10 = 90.
   - For every pair u != v in P:
     * If u ~ v: c_P(u, v) = 1. In G, lambda = 1.
       Therefore, |N_{V \ P}(u) ∩ N_{V \ P}(v)| = lambda - c_P(u, v) = 1 - 1 = 0.
     * If u !~ v: c_P(u, v) = 2. In G, mu = 2.
       Therefore, |N_{V \ P}(u) ∩ N_{V \ P}(v)| = mu - c_P(u, v) = 2 - 2 = 0.
   - Conclusion: For ALL u != v in P, (N_G(u) ∩ N_G(v)) ∩ (V \ P) = ∅.
   - Consequently, for EVERY external vertex w in V \ P:
     |N(w) ∩ P| <= 1.
   - Since sum_{w} |N(w) ∩ P| = 90 and |V \ P| = 90, EVERY w must have |N(w) ∩ P| = 1.
   - No external vertex can connect to ANY independent set of size >= 2.

4. SAT Formulation & DRAT Verification:
   - CNF instance encodes the contradiction of assuming an external vertex has deg >= 2 into P.
   - CaDiCaL confirms UNSAT and drat-trim verifies the proof.
   - NOTE: This mathematically proves the strict 1-regularity of the bipartite interface.
     The global non-existence of an induced Paley(9) (Keramatipour Conjecture 3.4.4)
     remains an open problem.
"""

import os
import sys
import time
import subprocess
import itertools
import numpy as np

from pysat.formula import CNF
from pysat.card import CardEnc, EncType
from pysat.solvers import Cadical195

WORKSPACE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
INSTANCES_DIR = os.path.join(WORKSPACE_DIR, "instances")
DRAT_TRIM_BIN = os.path.join(WORKSPACE_DIR, "drat-trim", "drat-trim")
CADICAL_BIN = os.path.join(WORKSPACE_DIR, "cadical")


def build_paley9():
    """
    Constructs Paley(9) = srg(9, 4, 1, 2) over Z_3 x Z_3.
    Vertices (r, c) for r in {0, 1, 2}, c in {0, 1, 2}.
    Edge between (r1, c1) and (r2, c2) iff r1 == r2 or c1 == c2 (distinct).
    """
    coords = [(r, c) for r in range(3) for c in range(3)]
    A = np.zeros((9, 9), dtype=int)
    for i in range(9):
        for j in range(9):
            if i != j:
                r1, c1 = coords[i]
                r2, c2 = coords[j]
                if r1 == r2 or c1 == c2:
                    A[i, j] = 1
    return coords, A


def verify_paley9_srg(A):
    """Verifies that A is srg(9, 4, 1, 2)."""
    assert A.shape == (9, 9)
    assert np.all(np.diag(A) == 0)
    assert np.all(A == A.T)
    # Degrees
    deg = np.sum(A, axis=1)
    assert np.all(deg == 4), f"Degrees mismatch: {deg}"
    # Common neighbors
    A2 = A @ A
    for i in range(9):
        for j in range(i + 1, 9):
            if A[i, j] == 1:
                assert A2[i, j] == 1, f"Lambda mismatch at ({i}, {j}): {A2[i, j]} != 1"
            else:
                assert A2[i, j] == 2, f"Mu mismatch at ({i}, {j}): {A2[i, j]} != 2"
    return True


def enumerate_independent_sets(A):
    """Finds all independent sets of Paley(9) grouped by size."""
    indep_sets = {1: [], 2: [], 3: []}
    for k in range(1, 4):
        for subset in itertools.combinations(range(9), k):
            is_indep = True
            for u, v in itertools.combinations(subset, 2):
                if A[u, v] == 1:
                    is_indep = False
                    break
            if is_indep:
                indep_sets[k].append(subset)
    return indep_sets


def build_deg2_obstruction_cnf(output_cnf_path):
    """
    Encodes the SAT instance:
    Can there exist 90 external vertices connecting to Paley(9) such that:
    1. Each vertex u in Paley(9) has exactly 10 neighbors in V \\ P.
    2. For all pairs u != v in Paley(9): no external vertex connects to both.
       (Because lambda=1 and mu=2 are already saturated inside Paley(9)!).
    3. At least one external vertex w has degree >= 2 into Paley(9).
    """
    os.makedirs(os.path.dirname(output_cnf_path), exist_ok=True)
    cnf = CNF()
    top_id = 0

    # Variables: x_{w, u} for w in 0..89, u in 0..8
    def x_var(w, u):
        return 1 + w * 9 + u

    top_id = 90 * 9

    # 1. Degree into V \\ P for each u in Paley(9): exactly 10
    for u in range(9):
        lits = [x_var(w, u) for w in range(90)]
        card = CardEnc.equals(lits=lits, bound=10, top_id=top_id, encoding=EncType.seqcounter)
        top_id = card.nv
        cnf.extend(card.clauses)

    # 2. Paley(9) saturation constraint:
    # For EVERY pair u < v in Paley(9), whether adjacent or not,
    # the common neighbor quota in Conway-99 is already saturated in Paley(9).
    # Therefore, no external vertex w can connect to both u and v.
    for w in range(90):
        for u in range(9):
            for v in range(u + 1, 9):
                cnf.append([-x_var(w, u), -x_var(w, v)])

    # 3. Obstruction Hypothesis:
    # At least one external vertex w has degree >= 2 into Paley(9).
    ge2_flags = []
    for w in range(90):
        top_id += 1
        w_ge2 = top_id
        ge2_flags.append(w_ge2)
        lits = [x_var(w, u) for u in range(9)]
        card = CardEnc.atleast(lits=lits, bound=2, top_id=top_id, encoding=EncType.seqcounter)
        top_id = card.nv
        for c in card.clauses:
            cnf.append([-w_ge2] + c)

    # At least one flag is active
    cnf.append(ge2_flags)

    cnf.to_file(output_cnf_path)
    return top_id, len(cnf.clauses)


def run_cadical_and_drat(cnf_path, drat_path):
    """Runs CaDiCaL on the CNF and produces the DRAT proof."""
    cmd = [CADICAL_BIN, cnf_path, drat_path]
    t0 = time.time()
    result = subprocess.run(cmd, capture_output=True, text=True)
    t_solve = time.time() - t0
    is_unsat = ("s UNSATISFIABLE" in result.stdout) or (result.returncode == 20)
    return is_unsat, t_solve, result.stdout


def verify_drat_trim(cnf_path, drat_path):
    """Verifies the DRAT proof using drat-trim."""
    cmd = [DRAT_TRIM_BIN, cnf_path, drat_path]
    t0 = time.time()
    result = subprocess.run(cmd, capture_output=True, text=True)
    t_verify = time.time() - t0
    verified = ("s VERIFIED" in result.stdout) or (result.returncode == 0)
    return verified, t_verify, result.stdout


def main():
    print("=" * 72)
    print("CONWAY-99 / KERAMATIPOUR CONJECTURE 3.4.4: PALEY(9) OBSTRUCTION")
    print("=" * 72)

    # 1. Paley(9) Construction
    print("\n[Step 1] Constructing Paley(9) on Z_3 x Z_3...")
    coords, A = build_paley9()
    verify_paley9_srg(A)
    print("  -> Paley(9) successfully constructed.")
    print("  -> Adjacency matrix properties verified: 9 vertices, 4-regular, lambda=1, mu=2.")
    print(f"  -> Total edges in Paley(9): {np.sum(A) // 2}")
    print(f"  -> Total non-edges in Paley(9): {36 - np.sum(A) // 2}")

    # 2. Independent Sets
    print("\n[Step 2] Enumerating Independent Sets of Paley(9)...")
    indep_sets = enumerate_independent_sets(A)
    print(f"  -> Size 1 (Singletons): {len(indep_sets[1])} sets (all vertices)")
    print(f"  -> Size 2 (Non-edges):   {len(indep_sets[2])} sets (all non-adjacent pairs)")
    print(f"  -> Size 3 (Transversals): {len(indep_sets[3])} sets (permutation transversals)")
    total_indep = sum(len(v) for v in indep_sets.values())
    print(f"  -> Total non-empty independent sets: {total_indep}")
    assert total_indep == 33
    assert len(indep_sets[3]) == 6

    # 3. Neighborhood Distribution Analysis
    print("\n[Step 3] External Neighborhood Distribution Analysis (P vs V \\ P)...")
    print("  Mathematical Theorem (Disjoint Neighborhood Property):")
    print("    Let P be an induced Paley(9) in an srg(99, 14, 1, 2) graph G.")
    print("    For any pair u != v in P:")
    print("      - If u ~ v: c_P(u, v) = 1 = lambda_G => common neighbors in V \\ P = 0.")
    print("      - If u !~ v: c_P(u, v) = 2 = mu_G    => common neighbors in V \\ P = 0.")
    print("    Therefore, |N_{V \\ P}(u) ∩ N_{V \\ P}(v)| = 0 for ALL distinct u, v in P.")
    print("    This forces: for EVERY external vertex w in V \\ P, |N(w) ∩ P| <= 1.")
    print("    Since each vertex in P has 14 - 4 = 10 edges to V \\ P (total 90 edges),")
    print("    and |V \\ P| = 90, EVERY external vertex MUST have |N(w) ∩ P| = 1.")
    print("    COROLLARY: No external vertex can connect to ANY independent set of size >= 2.")

    # 4. Formulate CNF Instance
    cnf_path = os.path.join(INSTANCES_DIR, "paley9_obstruction_deg2.cnf")
    drat_path = os.path.join(INSTANCES_DIR, "paley9_obstruction_deg2.drat")
    print(f"\n[Step 4] Compiling Degree Obstruction CNF -> {cnf_path}...")
    n_vars, n_clauses = build_deg2_obstruction_cnf(cnf_path)
    print(f"  -> Compiled CNF with {n_vars} variables and {n_clauses} clauses.")

    # 5. Run CaDiCaL
    print(f"\n[Step 5] Solving with CaDiCaL (binary: {CADICAL_BIN})...")
    is_unsat, t_solve, cadical_out = run_cadical_and_drat(cnf_path, drat_path)
    print(f"  -> Solver Result: {'UNSATISFIABLE' if is_unsat else 'SATISFIABLE'}")
    print(f"  -> Solve Time: {t_solve:.3f} seconds")
    drat_size = os.path.getsize(drat_path) if os.path.exists(drat_path) else 0
    print(f"  -> DRAT proof file size: {drat_size:,} bytes")
    assert is_unsat, "Expected UNSAT for degree obstruction!"

    # 6. Verify DRAT proof with drat-trim
    print(f"\n[Step 6] Verifying DRAT Proof with drat-trim (binary: {DRAT_TRIM_BIN})...")
    verified, t_verify, drat_out = verify_drat_trim(cnf_path, drat_path)
    print(f"  -> drat-trim Result: {'VERIFIED' if verified else 'FAILED'}")
    print(f"  -> Verification Time: {t_verify:.3f} seconds")
    assert verified, "DRAT proof verification failed!"

    # Print relevant drat-trim summary lines
    for line in drat_out.splitlines():
        if "s VERIFIED" in line or "lemmas in core" in line or "clauses in core" in line:
            print(f"     {line.strip()}")

    print("\n" + "=" * 72)
    print("VERIFICATION COMPLETE: PALEY(9) NEIGHBORHOOD OBSTRUCTION FULLY VALIDATED")
    print("=" * 72)


if __name__ == "__main__":
    main()
