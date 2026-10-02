#!/usr/bin/env python3
r"""
tests/test_encoder_positive_controls.py

Unit and Positive Control Tests for SAT Encoders:
1. Parameterized Positive Control Harness for SRG Block-Circulant Encoders:
   - Paley(9) = srg(9, 4, 1, 2) under Z_3 (identical \lambda=1, \mu=2 to Conway-99).
   - Petersen graph = srg(10, 3, 0, 1) under Z_5.
   - Cycle C_5 = srg(5, 2, 0, 1) under Z_5.
   - Exact mathematical decoding and algebraic validation of A^2 = k*I + \lambda*A + \mu*(J - I - A).
   - Anti-regression tests for variable 1 semantic safety (preventing false UNSAT from var==1 bug).
2. Planted Feasible Substructure Validations for Conway-99 Compilers:
   - Z_7 Canonical Compiler: Internal valence AMO + Lemma 4.7 coordinates + G_{Z_7} lex-leader + orbit 0 common neighbors.
   - Z_3 FPF Canonical Compiler: Modular parity adder + orbit ordering + planted t=0 configuration + orbit 0 degree & common neighbors.
   - Z_3 Fixed-3 Canonical Compiler: Fixed 1-factor matchings in N_0, N_1, N_2 + S_3 x Z_2 Crawford lex-leader cuts.
   - Z_2 f=1 Compiler: 0 internal edges + degree 12 in \Gamma_2 + unique K_{2,2} partner per orbit.
"""

import os
import sys
import unittest
import numpy as np
from pysat.solvers import Cadical195

import math

# Ensure repo root and scripts are in sys.path
REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if REPO_ROOT not in sys.path:
    sys.path.insert(0, REPO_ROOT)
scripts_path = os.path.join(REPO_ROOT, "scripts")
if scripts_path not in sys.path:
    sys.path.insert(0, scripts_path)

from scripts.build_srg_positive_control import (
    SRGPositiveControlCompiler,
    verify_srg_matrix,
)
from scripts.build_z7_canonical_cnf import ConwayZ7CanonicalCompiler
from scripts.build_z3_canonical_cnf import (
    ConwayZ3FPFCanonicalCompiler,
    ConwayZ3Fixed3CanonicalCompiler,
)
from build_z2_f1_cnf import ConwayZ2F1Compiler


class TestSRGPositiveControls(unittest.TestCase):
    r"""Positive control test suite for generic SRG block-circulant SAT encoding."""

    def test_paley9_z3_satisfiable_and_matrix_verified(self):
        r"""
        Paley(9) = srg(9, 4, 1, 2) under Z_3:
        Positive control with lambda=1, mu=2 (IDENTICAL to Conway 99-graph).
        """
        compiler = SRGPositiveControlCompiler(v=9, k=4, lam=1, mu=2, p=3, enable_lex=True)
        self.assertEqual(compiler.m, 3, "Paley(9) under Z_3 must have 3 orbits of size 3")
        self.assertEqual(len(compiler.primary_vars), 12, "Must have 3 diagonal + 9 cross = 12 primary variables")

        sat, A, elapsed = compiler.solve_and_verify(verbose=False)
        self.assertTrue(sat, "Paley(9) must be SATISFIABLE under Z_3 with Crawford lex-leader cuts")
        self.assertIsNotNone(A, "Decoded adjacency matrix must not be None")
        self.assertEqual(A.shape, (9, 9), "Adjacency matrix must be 9x9")

        # Independent verification with verify_srg_matrix
        self.assertTrue(verify_srg_matrix(A, 9, 4, 1, 2))

    def test_petersen_z5_satisfiable_and_matrix_verified(self):
        r"""
        Petersen graph = srg(10, 3, 0, 1) under Z_5:
        Positive control with 2 orbits of size 5 (pentagon and pentagram).
        """
        compiler = SRGPositiveControlCompiler(v=10, k=3, lam=0, mu=1, p=5, enable_lex=True)
        self.assertEqual(compiler.m, 2, "Petersen under Z_5 must have 2 orbits of size 5")
        self.assertEqual(len(compiler.primary_vars), 9, "Must have 4 diagonal + 5 cross = 9 primary variables")

        sat, A, elapsed = compiler.solve_and_verify(verbose=False)
        self.assertTrue(sat, "Petersen graph must be SATISFIABLE under Z_5 with Crawford lex-leader cuts")
        self.assertIsNotNone(A)
        self.assertEqual(A.shape, (10, 10))

        self.assertTrue(verify_srg_matrix(A, 10, 3, 0, 1))

    def test_c5_z5_satisfiable_and_matrix_verified(self):
        r"""
        Cycle C_5 = srg(5, 2, 0, 1) under Z_5:
        Positive control with 1 orbit of size 5.
        """
        compiler = SRGPositiveControlCompiler(v=5, k=2, lam=0, mu=1, p=5, enable_lex=True)
        self.assertEqual(compiler.m, 1, "C_5 under Z_5 must have 1 orbit of size 5")
        self.assertEqual(len(compiler.primary_vars), 2, "Must have 2 diagonal chord variables")

        sat, A, elapsed = compiler.solve_and_verify(verbose=False)
        self.assertTrue(sat, "C_5 must be SATISFIABLE under Z_5")
        self.assertIsNotNone(A)
        self.assertEqual(A.shape, (5, 5))

        self.assertTrue(verify_srg_matrix(A, 5, 2, 0, 1))

    def test_srg_matrix_validator_catches_violations(self):
        r"""Verifies that verify_srg_matrix strictly catches corrupted adjacency matrices."""
        # 1. Start with valid Petersen matrix
        compiler = SRGPositiveControlCompiler(v=10, k=3, lam=0, mu=1, p=5, enable_lex=False)
        _, A_valid, _ = compiler.solve_and_verify(verbose=False)
        self.assertTrue(verify_srg_matrix(A_valid, 10, 3, 0, 1))

        # 2. Corrupt symmetry: A[0, 1] != A[1, 0]
        A_asym = A_valid.copy()
        A_asym[0, 1] = 1 - A_asym[0, 1]
        with self.assertRaises(AssertionError):
            verify_srg_matrix(A_asym, 10, 3, 0, 1)

        # 3. Corrupt diagonal: A[0, 0] = 1 (self-loop)
        A_diag = A_valid.copy()
        A_diag[0, 0] = 1
        with self.assertRaises(AssertionError):
            verify_srg_matrix(A_diag, 10, 3, 0, 1)

        # 4. Corrupt degree regularity: delete an edge
        A_deg = A_valid.copy()
        # Find an edge to remove symmetrically
        edges = list(zip(*np.where(A_deg == 1)))
        u, v = edges[0]
        A_deg[u, v] = 0
        A_deg[v, u] = 0
        with self.assertRaises(AssertionError):
            verify_srg_matrix(A_deg, 10, 3, 0, 1)

        # 5. Wrong parameters: pass wrong k or wrong mu
        with self.assertRaises(AssertionError):
            verify_srg_matrix(A_valid, 10, 4, 0, 1)
        with self.assertRaises(AssertionError):
            verify_srg_matrix(A_valid, 10, 3, 1, 1)

    def test_quotient_symmetry_permutations_bijective(self):
        r"""Verifies that all elements of S_m x Z_p^* are bijective permutations of primary variables."""
        for name, preset in SRGPositiveControlCompiler.PRESETS.items():
            compiler = SRGPositiveControlCompiler(
                v=preset["v"],
                k=preset["k"],
                lam=preset["lam"],
                mu=preset["mu"],
                p=preset["p"],
                enable_lex=True,
            )
            perms = compiler._compute_group_permutations()
            num_primary = len(compiler.primary_vars)
            # Expected quotient group size: m! * (p - 1) - 1 (excluding identity)
            expected_perms = (math.factorial(compiler.m) * (compiler.p - 1)) - 1
            self.assertEqual(len(perms), expected_perms, f"{name} must have {expected_perms} non-identity quotient symmetries")

            for elem_name, perm in perms:
                self.assertEqual(len(perm), num_primary, f"{elem_name} must cover all primary variables")
                self.assertEqual(len(set(perm.values())), num_primary, f"{elem_name} must be a bijection")

    def test_encoder_helper_semantics_no_var1_bug(self):
        r"""Verifies that literal 1 is treated strictly as a variable ID and not boolean True."""
        compiler = SRGPositiveControlCompiler(v=9, k=4, lam=1, mu=2, p=3)
        top_before = compiler.top_id
        # In this compiler, variable 1 is the first primary variable (0, 0, 1).
        # Tseitin AND gate get_and_lit(1, 2) must allocate a fresh variable, not return 2 or 1!
        y = compiler.get_and_lit(1, 2)
        self.assertEqual(y, top_before + 1, "get_and_lit(1, 2) must allocate top_id + 1")

        # Verify truth table of y <=> (1 AND 2)
        for val1 in (0, 1):
            for val2 in (0, 1):
                expected_y = val1 and val2
                solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
                solver.add_clause([1 if val1 else -1])
                solver.add_clause([2 if val2 else -2])
                solver.add_clause([y if expected_y else -y])
                self.assertTrue(solver.solve(), f"AND gate failed for inputs ({val1}, {val2})")

                # Opposite must be UNSAT
                solver_neg = Cadical195(bootstrap_with=compiler.cnf.clauses)
                solver_neg.add_clause([1 if val1 else -1])
                solver_neg.add_clause([2 if val2 else -2])
                solver_neg.add_clause([-y if expected_y else y])
                self.assertFalse(solver_neg.solve(), f"AND gate opposite was SAT for inputs ({val1}, {val2})")

    def test_parameter_feasibility_check(self):
        r"""Verifies that invalid or infeasible SRG parameters are rejected by constructor."""
        # Non-divisible: v=10, p=3 -> 10 not divisible by 3
        with self.assertRaises(ValueError):
            SRGPositiveControlCompiler(v=10, k=3, lam=0, mu=1, p=3)

        # Infeasible equation: k*(k - lam - 1) != mu*(v - k - 1)
        # E.g. v=9, k=3, lam=1, mu=2: 3*(3-1-1) = 3 != 2*(9-3-1) = 10
        with self.assertRaises(ValueError):
            SRGPositiveControlCompiler(v=9, k=3, lam=1, mu=2, p=3)


class TestConwayPlantedFeasibleSubstructures(unittest.TestCase):
    r"""
    Positive control validations on planted feasible substructures of the Conway-99 compilers.
    Ensures that SAT encoding components (coordinates, AMOs, matchings, degree counts,
    and Crawford lex-leader symmetry cuts) are mutually consistent and satisfiable.
    """

    def test_z7_compiler_planted_substructure(self):
        r"""
        Z_7 Canonical Compiler Planted Substructure:
        - Internal valence AMO cuts (b_{pp} in {0, 2})
        - Lemma 4.7 coordinate intersection cardinality constraints
        - G_{Z_7} \cong Z_2 x Z_6 Crawford lex-leader symmetry cuts
        - Localized common neighbor constraints for orbit 0
        Must be SATISFIABLE and solved quickly.
        """
        compiler = ConwayZ7CanonicalCompiler(enable_lex=True)
        amo_count = compiler.build_internal_valence_cuts()
        self.assertEqual(amo_count, 36)

        compiler.build_coordinate_constraints()
        compiler.build_lex_leader_cuts()

        # Add localized common neighbor constraints for orbit 0 internal pairs
        for dt in range(1, 4):
            u = (0, 0)
            v = (0, dt)
            c_uv = len(compiler.coords[u].intersection(compiler.coords[v]))
            target_bound = 2 - c_uv
            a_uv = compiler.get_adj_lit(u[0], u[1], v[0], v[1])
            lits = [a_uv] if a_uv != 0 else []
            for q in range(12):
                for t in range(7):
                    w = (q, t)
                    if w == u or w == v:
                        continue
                    a_uw = compiler.get_adj_lit(u[0], u[1], w[0], w[1])
                    if a_uw == 0:
                        continue
                    a_vw = compiler.get_adj_lit(v[0], v[1], w[0], w[1])
                    if a_vw == 0:
                        continue
                    and_lit = compiler.get_and_lit(a_uw, a_vw)
                    if and_lit != 0:
                        lits.append(and_lit)
            compiler.add_card_equals(lits, target_bound)

        solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
        sat = solver.solve()
        self.assertTrue(sat, "Z_7 planted coordinate + valence + lex-leader + orbit 0 substructure must be SATISFIABLE")

    def test_z3_fpf_compiler_planted_substructure(self):
        r"""
        Z_3 FPF Canonical Compiler Planted Substructure:
        - Modular parity sequential adder (\sum t_p \equiv 0 \pmod 3)
        - Canonical orbit ordering (t_0 >= ... >= t_32 and triplet locking)
        - Planted triangle configuration t_p = 0 for all p (all 33 orbits triangle-free)
        - Orbit 0 degree regularity (k=14)
        - Orbit 0 internal pair common neighbors (\mu=2)
        Must be SATISFIABLE.
        """
        compiler = ConwayZ3FPFCanonicalCompiler(enable_modular=True, enable_orbit_order=True)
        mod_clauses = compiler.build_modular_parity_cut()
        self.assertGreater(mod_clauses, 0)
        order_clauses = compiler.build_canonical_orbit_ordering()
        self.assertGreater(order_clauses, 0)

        # Plant t_p = 0 for all p (the configuration with 0 triangles)
        for p in range(33):
            compiler.cnf.append([-compiler.t_vars[p]])

        # Degree constraints for orbit 0: degree = 14
        lits = [compiler.t_vars[0], compiler.t_vars[0]]
        for q in range(1, 33):
            for m in range(3):
                lits.append(compiler.get_adj_lit(0, 0, q, m))
        compiler.add_card_equals(lits, 14)

        # Internal pair common neighbors for orbit 0: (0, 0) and (0, 1)
        y_lits = []
        for r in range(1, 33):
            for m in range(3):
                a_u = compiler.get_adj_lit(0, 0, r, m)
                a_v = compiler.get_adj_lit(0, 1, r, m)
                y = compiler.get_and_lit(a_u, a_v)
                if y != 0:
                    y_lits.append(y)
        compiler.add_card_equals([compiler.t_vars[0], compiler.t_vars[0]] + y_lits, 2)

        solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
        sat = solver.solve()
        self.assertTrue(sat, "Z_3 FPF planted substructure must be SATISFIABLE")

    def test_z3_fixed3_compiler_planted_substructure(self):
        r"""
        Z_3 Fixed-3 Canonical Compiler Planted Substructure:
        - Fixed 1-factor matchings in N_0, N_1, N_2 (54 fixed edge unit clauses)
        - S_3 x Z_2 full Crawford lex-leader symmetry cuts (11 symmetries)
        Must be SATISFIABLE.
        """
        compiler = ConwayZ3Fixed3CanonicalCompiler(enable_lex=True)
        lex_clauses = compiler.build_lex_leader_cuts()
        self.assertGreater(lex_clauses, 0)

        # Inject fixed 1-factor matching edges
        for k, val in compiler.fixed_edges.items():
            vid = compiler.edge_vars[k]
            compiler.cnf.append([vid if val else -vid])

        solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
        sat = solver.solve()
        self.assertTrue(sat, "Z_3 Fixed-3 fixed matchings + S_3 x Z_2 lex-leader cuts must be SATISFIABLE")

    def test_z2_f1_compiler_planted_substructure(self):
        r"""
        Z_2 f=1 Compiler Planted Substructure:
        - 0 internal edges in \Gamma_2(x_0) (42 unit clauses)
        - Degree 12 inside \Gamma_2(x_0) for all 42 orbits
        - Unique K_{2,2} partner for each orbit (\mu=2 internal pair common neighbors)
        Must be SATISFIABLE.
        """
        compiler = ConwayZ2F1Compiler()
        # 1. Zero internal edges
        for p in range(42):
            compiler.cnf.append([-compiler.var_id(p, p)])

        # 2. Degree regularity in Gamma_2 = 12
        from pysat.card import CardEnc, EncType
        for p in range(42):
            lits = [compiler.var_id(p, q) for q in range(42) if q != p] + \
                   [compiler.var_id(q, p) for q in range(42) if q != p]
            card = CardEnc.equals(lits=lits, bound=12, top_id=compiler.top_id, encoding=EncType.seqcounter)
            compiler.top_id = card.nv
            compiler.cnf.extend(card.clauses)

        # 3. K_2,2 partner
        for p in range(42):
            lits = [compiler.get_and_var(compiler.var_id(min(p, q), max(p, q)),
                                          compiler.var_id(max(p, q), min(p, q)))
                    for q in range(42) if q != p]
            card = CardEnc.equals(lits=lits, bound=1, top_id=compiler.top_id, encoding=EncType.seqcounter)
            compiler.top_id = card.nv
            compiler.cnf.extend(card.clauses)

        solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
        sat = solver.solve()
        self.assertTrue(sat, "Z_2 f=1 partial substructure (0 internal + deg 12 + K_2,2 partners) must be SATISFIABLE")


if __name__ == "__main__":
    unittest.main()
