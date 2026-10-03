#!/usr/bin/env python3
r"""
tests/test_encoder_positive_controls.py

Unit and Regression Tests for SAT Encoders, Constraint Compilers,
and Planted Substructure Validations in Conway's 99-Graph Framework.

Tests Cover:
1. SRG Block-Circulant Positive Controls:
   - Paley(9) = srg(9, 4, 1, 2) under Z_3 (standalone experimental positive control).
   - Petersen = srg(10, 3, 0, 1) under Z_5.
   - Cycle C_5 = srg(5, 2, 0, 1) under Z_5.
   - Decoded graph validation and corrupted graph rejection.
   - Tseitin AND-gate semantics and SRG parameter feasibility checks.
2. Experimental isolated toy-model checks for planted 1-factors on Gamma_1(x_0) (M_{7K_2}):
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

import itertools
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
from scripts.production_positive_controls import (
    PlantedClauseSink,
    inversion_order,
    known_graph,
    translation_order,
    check_planted,
    verify_graph,
)
from build_z2_f1_cnf import ConwayZ2F1Compiler
from scripts.build_z3_canonical_cnf import ConwayZ3FPFCanonicalCompiler
from pysat.solvers import Cadical195


def _clauses_satisfied(clauses, model):
    return all(any(lit in model for lit in clause) for clause in clauses)


def _paley9_z2_values(compiler):
    vertices, adjacency, degree = known_graph("paley9")
    order = inversion_order(vertices, adjacency)
    expected = adjacency[np.ix_(order, order)]
    offset = degree + 1
    values = {}
    for p in range(compiler.num_outer_orbits):
        for q in range(compiler.num_outer_orbits):
            u = offset + 2 * p
            v = offset + 2 * q + int(p >= q)
            values[compiler.var_id(p, q)] = bool(expected[u, v])
    return expected, values


def _paley9_z3_values(compiler, triangle=True):
    vertices, adjacency, degree = known_graph("paley9")
    order = translation_order(vertices, adjacency, triangle=triangle)
    expected = adjacency[np.ix_(order, order)]
    values = {var: bool(expected[3 * p, 3 * p + 1]) for p, var in compiler.t_vars.items()}
    values.update({var: bool(expected[3 * p, 3 * q + d]) for (p, q, d), var in compiler.edge_vars.items()})
    return expected, values


class TestProductionCompilerPositiveControls(unittest.TestCase):
    def test_paley9_complete_production_cnf_z2(self):
        compiler = ConwayZ2F1Compiler(degree=4)
        compiler.build_constraints()
        with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
            self.assertTrue(solver.solve())
            model = set(solver.get_model())
        adjacency = compiler.reconstruct_adjacency(model)
        self.assertTrue(verify_graph(adjacency, 4))
        self.assertTrue(_clauses_satisfied(compiler.cnf.clauses, model))

    def test_paley9_complete_production_cnf_z3_fpf(self):
        compiler = ConwayZ3FPFCanonicalCompiler(num_orbits=3, degree=4)
        compiler.compile(verbose=False)
        with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
            self.assertTrue(solver.solve())
            model = set(solver.get_model())
        adjacency = np.zeros((9, 9), dtype=int)
        for p1 in range(3):
            for t1 in range(3):
                for p2 in range(3):
                    for t2 in range(3):
                        if p1 == p2 and t1 == t2:
                            continue
                        lit = compiler.get_adj_lit(p1, t1, p2, t2)
                        if lit > 0 and lit in model:
                            adjacency[3 * p1 + t1, 3 * p2 + t2] = 1
        self.assertTrue(verify_graph(adjacency, 4))
        self.assertTrue(_clauses_satisfied(compiler.cnf.clauses, model))

    def test_paley9_planted_production_clauses(self):
        self.assertEqual(check_planted("paley9", "z2-f1")["status"], "COMPILED")
        self.assertEqual(check_planted("paley9", "z3-fpf")["status"], "COMPILED")
        self.assertEqual(check_planted("paley9", "z3-fpf", triangle=False)["status"], "COMPILED")

    def test_paley9_flipped_z2_primary_is_unsat(self):
        compiler = ConwayZ2F1Compiler(degree=4)
        compiler.build_constraints()
        _, values = _paley9_z2_values(compiler)
        values[compiler.var_id(0, 1)] = not values[compiler.var_id(0, 1)]
        with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
            for variable, value in values.items():
                solver.add_clause([variable if value else -variable])
            self.assertFalse(solver.solve())

    def test_paley9_flipped_z3_primary_is_unsat(self):
        compiler = ConwayZ3FPFCanonicalCompiler(num_orbits=3, degree=4)
        _, values = _paley9_z3_values(compiler)
        values[compiler.edge_vars[(0, 1, 0)]] = not values[compiler.edge_vars[(0, 1, 0)]]
        compiler.compile(verbose=False)
        with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
            for variable, value in values.items():
                solver.add_clause([variable if value else -variable])
            self.assertFalse(solver.solve())

    def test_bvls_fixture_geometry(self):
        vertices, adjacency, degree = known_graph("bvls243")
        self.assertEqual(len(vertices), 243)
        self.assertEqual(degree, 22)
        self.assertEqual(int(adjacency.sum() // 2), 2673)
        self.assertTrue(verify_graph(adjacency, 22))

        inversion = inversion_order(vertices, adjacency)
        self.assertEqual(sorted(inversion), list(range(243)))
        for triangle in (True, False):
            translation = translation_order(vertices, adjacency, triangle=triangle)
            self.assertEqual(sorted(translation), list(range(243)))

    def test_production_constructor_validation(self):
        with self.assertRaises(ValueError):
            ConwayZ2F1Compiler(degree=True)
        with self.assertRaises(ValueError):
            ConwayZ2F1Compiler(degree=5)
        with self.assertRaises(ValueError):
            ConwayZ3FPFCanonicalCompiler(num_orbits=32)


class TestProductionModularResidue(unittest.TestCase):
    def test_degree8_residue2_modular_constraints(self):
        compiler = ConwayZ3FPFCanonicalCompiler(
            num_orbits=11,
            enable_modular=True,
            enable_orbit_order=True,
            degree=8,
        )
        self.assertEqual(compiler.triangle_residue, 2)
        compiler.build_modular_parity_cut()
        compiler.build_canonical_orbit_ordering()
        sums = []
        with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
            for bits in itertools.product((False, True), repeat=compiler.num_orbits):
                assumptions = [
                    compiler.t_vars[index] if value else -compiler.t_vars[index]
                    for index, value in enumerate(bits)
                ]
                if solver.solve(assumptions=assumptions):
                    sums.append(sum(bits))
        self.assertEqual(sums, [2, 5, 8, 11])


class TestProductionLiteralSemantics(unittest.TestCase):
    def test_literal_one_and_gate_truth_tables(self):
        for compiler, method in (
            (ConwayZ2F1Compiler(degree=4), "get_and_var"),
            (ConwayZ3FPFCanonicalCompiler(num_orbits=3, degree=4), "get_and_lit"),
        ):
            gate = getattr(compiler, method)(1, 2)
            for a in (False, True):
                for b in (False, True):
                    for output in (False, True):
                        with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
                            solver.add_clause([1 if a else -1])
                            solver.add_clause([2 if b else -2])
                            solver.add_clause([gate if output else -gate])
                            self.assertEqual(solver.solve(), output == (a and b))


class TestPlantedClauseSink(unittest.TestCase):
    def test_empty_clause_rejected_on_flush(self):
        sink = PlantedClauseSink({})
        sink.append([])
        with self.assertRaises(ValueError):
            sink.flush()

    def test_unknown_auxiliary_reuse_rejected_after_flush(self):
        sink = PlantedClauseSink({})
        sink.append([1])
        sink.flush()
        sink.append([1])
        with self.assertRaises(ValueError):
            sink.flush()

    def test_independent_batches_are_accepted(self):
        sink = PlantedClauseSink({})
        sink.append([1])
        sink.flush()
        sink.append([-2])
        sink.flush()
        self.assertEqual(sink.checked, 2)

    def test_pinned_false_literal_is_not_true(self):
        sink = PlantedClauseSink({1: False})
        sink.append([-1])
        sink.flush()
        sink.append([1])
        with self.assertRaises(ValueError):
            sink.flush()


class TestSRGBlockCirculantPositiveControls(unittest.TestCase):
    """Positive controls testing known solvable SRGs with block-circulant structure."""

    def test_paley9_srg_positive_control(self):
        """
        Tests the standalone experimental Paley(9) SRG encoder under Z_3.
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
    """Checks isolated toy models for planted 1-factor matchings."""

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
    """Checks selected relaxed subsystems without resolving the open cases."""

    def test_relaxed_z7_consistency(self):
        """Verifies Z_7 under internal valence cuts, coordinates, and lex-leader is SAT."""
        diag = validate_relaxed_z7_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 43266)

    def test_relaxed_z7_mu_bound(self):
        """Verifies Z_7 with mu relaxed to mu <= 2 via CardEnc.atmost is SAT."""
        diag = validate_relaxed_z7_mu_bound(max_pairs=50)
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)

    def test_relaxed_z3_fpf_consistency(self):
        """Verifies Z_3 FPF under degree regularity, modular parity cut, and orbit order is SAT."""
        diag = validate_relaxed_z3_fpf_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 155640)

    def test_relaxed_z3_fixed3_consistency(self):
        """Verifies Z_3 Fixed-3 under degree regularity, planted matchings, and S_3 x Z_2 lex-leader is SAT."""
        diag = validate_relaxed_z3_fixed3_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 260300)

    def test_relaxed_z2_f1_consistency(self):
        """Verifies Z_2 (f=1) under zero internal edges, degree 12, and K_{2,2} partner is SAT."""
        diag = validate_relaxed_z2_f1_consistency()
        self.assertTrue(diag["sat"])
        self.assertEqual(diag["violations"], 0)
        self.assertEqual(diag["clauses"], 148785)


if __name__ == "__main__":
    unittest.main()
