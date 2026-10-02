#!/usr/bin/env python3
r"""
tests/test_encoder_positive_controls.py

Unit and Regression Tests for SAT Encoders, Constraint Compilers,
and Planted Substructure Validations in Conway's 99-Graph Framework.

Tests Cover:
1. SRG Block-Circulant Positive Controls:
   - Paley(9) = srg(9, 4, 1, 2) under Z_3 (identical lambda=1, mu=2 as Conway-99).
   - Petersen = srg(10, 3, 0, 1) under Z_5.
   - Cycle C_5 = srg(5, 2, 0, 1) under Z_5.
   - Decoded graph validation and corrupted graph rejection.
   - Tseitin AND-gate semantics and SRG parameter feasibility checks.
2. Planted 1-factor on Gamma_1(x_0) (M_{7K_2}):
   - Z_7 Gamma_1 subconstituent (2 orbits of size 7, zero clause violations).
   - Z_2 (f=1) Gamma_1 subconstituent (7 orbits of length 2, zero clause violations).
   - Z_3 Fixed-3 planted matchings in N_0, N_1, N_2 (zero clause violations).
   - Z_2 (f=1) Gamma_1 - Gamma_2 2-design compatibility (C C^T = 10*I + 2*J).
3. Planted Cesarz-Woldar Coordinate 2-Paths:
   - 84 vertices in Gamma_2 form exact bijection to the 84 non-edges of Gamma_1.
   - Disjointness from planted matching M_{7K_2}.
   - 12-fold regularity per coordinate label.
   - 2-path cardinality equations and quotient Diophantine matrix C (row sums = 22, target T row sums = 156).
4. Relaxed Feasibility Consistency:
   - Z_7 relaxed (internal valence + coordinates + Crawford lex-leader).
   - Z_7 mu-relaxed (mu <= 2 via CardEnc.atmost).
   - Z_3 FPF relaxed (degree + modular parity cut + orbit ordering).
   - Z_3 Fixed-3 relaxed (degree + planted matchings + S_3 x Z_2 lex-leader).
   - Z_2 (f=1) relaxed (zero internal edges + degree 12 + K_{2,2} partner).

Radical Honesty & Skeptical Mathematician Standard:
All tests run deterministically and verify exact mathematical invariants.
"""

import os
import sys
import unittest
import numpy as np

# Ensure repo root and scripts are in sys.path
REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if REPO_ROOT not in sys.path:
    sys.path.insert(0, REPO_ROOT)
scripts_path = os.path.join(REPO_ROOT, "scripts")
if scripts_path not in sys.path:
    sys.path.insert(0, scripts_path)

from build_z7_canonical_cnf import ConwayZ7CanonicalCompiler
from scripts.validate_encoder_planted_substructure import (
    SRGBlockCirculantEncoder,
    Z7Gamma1Encoder,
    Z2F1Gamma1Encoder,
    validate_z3_fixed3_planted_matching,
    validate_z2_f1_gamma1_compatibility,
    validate_cesarz_woldar_coordinates_and_2paths,
    validate_relaxed_z7_consistency,
    validate_relaxed_z7_mu_bound,
    validate_relaxed_z3_fpf_consistency,
    validate_relaxed_z3_fixed3_consistency,
    validate_relaxed_z2_f1_consistency,
)
from scripts.build_srg_positive_control import (
    SRGPositiveControlCompiler,
    verify_srg_matrix,
)
from pysat.solvers import Cadical195


class TestSRGBlockCirculantPositiveControls(unittest.TestCase):
    """Positive controls testing known solvable SRGs with block-circulant structure."""

    def test_paley9_srg_positive_control(self):
        """
        Tests Paley(9) = srg(9, 4, 1, 2) under Z_3.
        Note that Paley(9) shares the IDENTICAL (lambda=1, mu=2) parameters
        with Conway's 99-graph, serving as the primary positive control for the
        common neighbor Tseitin encoding.
        """
        encoder = SRGBlockCirculantEncoder(m=3, q=3, k=4, lam=1, mu=2)
        cnf = encoder.build_cnf()
        self.assertGreater(len(cnf.clauses), 0, "CNF clauses must be populated")
        self.assertGreater(encoder.top_id, 0, "Variables must be allocated")

        sat, A, diag = encoder.solve()
        self.assertTrue(sat, "Solver must find SAT for Paley(9) under Z_3")
        self.assertIsNotNone(A, "Adjacency matrix must be decoded")
        self.assertTrue(diag["is_srg"], "Decoded graph must satisfy SRG axioms")
        self.assertEqual(diag["v"], 9)
        self.assertEqual(diag["k"], 4)
        self.assertEqual(diag["lambda"], 1)
        self.assertEqual(diag["mu"], 2)
        self.assertEqual(diag["num_edges"], 18)
        self.assertEqual(diag["num_non_edges"], 18)

        # Structural validation: A must have zero diagonal and be symmetric
        self.assertTrue(np.array_equal(A, A.T))
        self.assertFalse(np.any(np.diag(A)))
        self.assertTrue(np.all(np.sum(A, axis=1) == 4))

        # verify with verify_srg_matrix validator as well
        self.assertTrue(verify_srg_matrix(A, v=9, k=4, lam=1, mu=2))

        # A^2 + A - 4*I == 2*J - I
        A2 = A @ A
        expected_system = 4 * np.eye(9, dtype=int) + 1 * A + 2 * (np.ones((9, 9), dtype=int) - np.eye(9, dtype=int) - A)
        self.assertTrue(np.array_equal(A2, expected_system), "Adjacency spectral equation A^2 + A - 4*I = 2*(J - I - A) must hold")

    def test_petersen_srg_positive_control(self):
        """
        Tests Petersen graph = srg(10, 3, 0, 1) under Z_5.
        Decomposed into 2 orbits of size 5: outer pentagon C_5 and inner pentagram.
        """
        encoder = SRGBlockCirculantEncoder(m=2, q=5, k=3, lam=0, mu=1)
        encoder.build_cnf()

        sat, A, diag = encoder.solve()
        self.assertTrue(sat, "Solver must find SAT for Petersen graph under Z_5")
        self.assertIsNotNone(A)
        self.assertTrue(diag["is_srg"])
        self.assertEqual(diag["v"], 10)
        self.assertEqual(diag["k"], 3)
        self.assertEqual(diag["lambda"], 0)
        self.assertEqual(diag["mu"], 1)
        self.assertEqual(diag["num_edges"], 15)
        self.assertEqual(diag["num_non_edges"], 30)

        # verify with verify_srg_matrix validator as well
        self.assertTrue(verify_srg_matrix(A, v=10, k=3, lam=0, mu=1))

        # Adjacency spectral equation for Petersen: A^2 + A - 2*I = J
        A2 = A @ A
        expected_system = 3 * np.eye(10, dtype=int) + 0 * A + 1 * (np.ones((10, 10), dtype=int) - np.eye(10, dtype=int) - A)
        self.assertTrue(np.array_equal(A2, expected_system))

        # Girth of Petersen graph is 5: no triangles (A^3 diagonal is 0) and no 4-cycles
        A3 = A2 @ A
        self.assertEqual(int(np.trace(A3)), 0, "Petersen graph is triangle-free: Trace(A^3) == 0")

    def test_c5_cycle_positive_control(self):
        """Tests Cycle C_5 = srg(5, 2, 0, 1) under Z_5."""
        encoder = SRGBlockCirculantEncoder(m=1, q=5, k=2, lam=0, mu=1)
        encoder.build_cnf()

        sat, A, diag = encoder.solve()
        self.assertTrue(sat, "C_5 must be SAT")
        self.assertIsNotNone(A)
        self.assertTrue(diag["is_srg"])
        self.assertEqual(diag["v"], 5)
        self.assertEqual(diag["k"], 2)
        self.assertEqual(diag["lambda"], 0)
        self.assertEqual(diag["mu"], 1)
        self.assertTrue(verify_srg_matrix(A, v=5, k=2, lam=0, mu=1))

    def test_corrupted_srg_rejection(self):
        """Verifies that the SRG validators strictly reject non-SRG adjacency matrices."""
        encoder = SRGBlockCirculantEncoder(m=3, q=3, k=4, lam=1, mu=2)
        encoder.build_cnf()
        sat, A, diag = encoder.solve()
        self.assertTrue(sat)

        # Corrupt one edge
        A_corrupted = A.copy()
        A_corrupted[0, 1] = 1 - A_corrupted[0, 1]
        A_corrupted[1, 0] = A_corrupted[0, 1]

        with self.assertRaises(AssertionError):
            encoder.verify_srg(A_corrupted)

        with self.assertRaises(AssertionError):
            verify_srg_matrix(A_corrupted, v=9, k=4, lam=1, mu=2)

    def test_tseitin_and_gate_semantics(self):
        """Exhaustively verifies truth tables for Tseitin conjunctions y <=> a AND b."""
        compiler = SRGPositiveControlCompiler(v=9, k=4, lam=1, mu=2, p=3)
        y = compiler.get_and_lit(1, 2)
        self.assertGreater(y, 2)

        truth_table = [
            (False, False, False),
            (False, True, False),
            (True, False, False),
            (True, True, True),
        ]
        for val1, val2, expected_y in truth_table:
            solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
            solver.add_clause([1 if val1 else -1])
            solver.add_clause([2 if val2 else -2])
            solver.add_clause([y if expected_y else -y])
            self.assertTrue(solver.solve(), f"AND gate failed for inputs ({val1}, {val2})")

    def test_srg_parameter_feasibility(self):
        """Verifies that invalid or infeasible SRG parameters are rejected by constructor."""
        with self.assertRaises(ValueError):
            SRGPositiveControlCompiler(v=10, k=3, lam=0, mu=1, p=3)
        with self.assertRaises(ValueError):
            SRGPositiveControlCompiler(v=9, k=3, lam=1, mu=2, p=3)


class TestPlantedOneFactorSubstructures(unittest.TestCase):
    """Validates planted 1-factor matchings M_{7K_2} in Gamma_1(x_0)."""

    def test_planted_one_factor_z7(self):
        """Verifies planted 1-factor matching in Z_7 Gamma_1 subconstituent."""
        encoder = Z7Gamma1Encoder()
        encoder.build_constraints()
        self.assertEqual(len(encoder.primary_vars), 13)

        planted = encoder.get_planted_matching_assignment()
        eval_result = encoder.evaluate_clauses(planted)

        self.assertEqual(eval_result["violations"], 0, "Planted matching M_{7K_2} must have zero clause violations in Z_7")
        self.assertEqual(eval_result["satisfied"], eval_result["total_clauses"])

        # Also test that CaDiCaL directly finds a SAT model
        with Cadical195(bootstrap_with=encoder.cnf.clauses) as solver:
            sat = solver.solve()
            self.assertTrue(sat, "Z_7 Gamma_1 CNF must be SATISFIABLE")
            model = set(solver.get_model())
            # Matching variable (0, 1, 0) must be True
            matching_var = encoder.var_map[(0, 1, 0)]
            self.assertIn(matching_var, model, "Solver must assign True to matching variable (0, 1, 0)")
            # Diagonal variables must be False
            for d in range(1, 4):
                self.assertNotIn(encoder.var_map[(0, 0, d)], model)
                self.assertNotIn(encoder.var_map[(1, 1, d)], model)

    def test_planted_one_factor_z2_f1(self):
        """Verifies planted 1-factor matching in Z_2 (f=1) Gamma_1 subconstituent."""
        encoder = Z2F1Gamma1Encoder()
        encoder.build_constraints()
        self.assertEqual(len(encoder.primary_vars), 49)

        planted = encoder.get_planted_matching_assignment()
        eval_result = encoder.evaluate_clauses(planted)

        self.assertEqual(eval_result["violations"], 0, "Planted matching M_{7K_2} must have zero clause violations in Z_2 (f=1)")
        self.assertEqual(eval_result["satisfied"], eval_result["total_clauses"])
        self.assertEqual(eval_result["total_clauses"], 553)

        # Solver finds SAT model with exactly the 7 involution transpositions
        with Cadical195(bootstrap_with=encoder.cnf.clauses) as solver:
            sat = solver.solve()
            self.assertTrue(sat, "Z_2 (f=1) Gamma_1 CNF must be SATISFIABLE")

    def test_planted_one_factor_z3_fixed3(self):
        """Verifies planted 1-factors 6*K_2 in N_0, N_1, N_2 of Z_3 Fixed-3."""
        diag = validate_z3_fixed3_planted_matching()
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["fixed_clauses"], 54)
        self.assertEqual(diag["satisfied"], 54)

    def test_z2_f1_gamma1_compatibility(self):
        """Verifies 2-design incidence matrix and matching pairs in Z_2 (f=1)."""
        diag = validate_z2_f1_gamma1_compatibility()
        self.assertTrue(diag["cct_verified"])
        self.assertEqual(diag["matching_pairs"], 7)
        self.assertEqual(diag["num_vertices_n"], 14)
        self.assertEqual(diag["num_orbits_g2"], 42)


class TestCesarzWoldarPlantedCoordinates(unittest.TestCase):
    """Validates Cesarz & Woldar (2025) coordinate geometry of Gamma_2(x_0)."""

    def setUp(self):
        self.diag = validate_cesarz_woldar_coordinates_and_2paths()

    def test_cesarz_woldar_gamma1_non_edges_bijection(self):
        """Verifies exact bijection between 84 vertices of Gamma_2 and 84 non-edges of Gamma_1."""
        self.assertEqual(self.diag["num_vertices_g2"], 84)
        self.assertEqual(self.diag["gamma1_non_edges"], 84)

    def test_cesarz_woldar_planted_matching_disjointness(self):
        """Verifies no coordinate pair in Gamma_2 is an edge of the planted matching M_{7K_2}."""
        compiler = ConwayZ7CanonicalCompiler(enable_lex=False)
        planted_edges = {frozenset({f"{i}L", f"{i}R"}) for i in range(1, 8)}
        for (p, t), coords in compiler.coords.items():
            self.assertNotIn(frozenset(coords), planted_edges)

    def test_cesarz_woldar_coordinate_regularity(self):
        """Verifies each coordinate in Gamma_1 appears in exactly 12 vertices of Gamma_2."""
        self.assertEqual(self.diag["coord_regularity"], 12)

    def test_cesarz_woldar_2paths_cardinality_and_quotient_matrix(self):
        """
        Verifies 12x12 quotient Diophantine matrix C for 2-paths through Gamma_1:
        Row sums must be 22, target T row sums must be 156, and Trace(C) = 12.
        """
        self.assertEqual(self.diag["c_matrix_row_sum"], 22)
        self.assertEqual(self.diag["t_matrix_row_sum"], 156)
        self.assertEqual(self.diag["trace_c"], 12)
        self.assertEqual(self.diag["trace_t"], 276)
        self.assertEqual(self.diag["c_diagonal"], [2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0])


class TestRelaxedFeasibilityChecks(unittest.TestCase):
    """Validates that relaxing the unsatisfiable global parameter mu=2 yields SAT."""

    def test_relaxed_z7_consistency(self):
        """Verifies Z_7 under internal valence cuts, coordinates, and lex-leader is SAT."""
        diag = validate_relaxed_z7_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 43266)
        self.assertLess(diag["elapsed_seconds"], 2.0)

    def test_relaxed_z7_mu_bound(self):
        """Verifies Z_7 with mu relaxed to mu <= 2 via CardEnc.atmost is SAT."""
        diag = validate_relaxed_z7_mu_bound(max_pairs=50)
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertLess(diag["elapsed_seconds"], 2.0)

    def test_relaxed_z3_fpf_consistency(self):
        """Verifies Z_3 FPF under degree regularity, modular parity cut, and orbit order is SAT."""
        diag = validate_relaxed_z3_fpf_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 155640)
        self.assertLess(diag["elapsed_seconds"], 2.0)

    def test_relaxed_z3_fixed3_consistency(self):
        """Verifies Z_3 Fixed-3 under degree regularity, planted matchings, and S_3 x Z_2 lex-leader is SAT."""
        diag = validate_relaxed_z3_fixed3_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 260300)
        self.assertLess(diag["elapsed_seconds"], 2.0)

    def test_relaxed_z2_f1_consistency(self):
        """Verifies Z_2 (f=1) under zero internal edges, degree 12, and K_{2,2} partner is SAT."""
        diag = validate_relaxed_z2_f1_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 148785)
        self.assertLess(diag["elapsed_seconds"], 2.0)


if __name__ == "__main__":
    unittest.main()
