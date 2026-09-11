#!/usr/bin/env python3
"""
tests/test_canonical_sat_compilers.py

Unit and Regression Tests for Canonical SAT/CNF Compilers:
  1. scripts/build_z7_canonical_cnf.py (Cesarz & Woldar 2025 profile, b_pp in {0, 2}, G_{Z_7} lex-leader)
  2. scripts/build_z3_canonical_cnf.py (FPF with modular parity and Fixed-3 with S_3 x Z_2 lex-leader)
"""

import os
import sys
import unittest
from pysat.solvers import Cadical195
from pysat.formula import CNF

# Ensure scripts directory is in path
REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if REPO_ROOT not in sys.path:
    sys.path.insert(0, REPO_ROOT)
scripts_path = os.path.join(REPO_ROOT, "scripts")
if scripts_path not in sys.path:
    sys.path.insert(0, scripts_path)

from build_z7_canonical_cnf import ConwayZ7CanonicalCompiler
from build_z3_canonical_cnf import ConwayZ3FPFCanonicalCompiler, ConwayZ3Fixed3CanonicalCompiler

class TestCanonicalZ7Compiler(unittest.TestCase):
    def setUp(self):
        self.compiler = ConwayZ7CanonicalCompiler(enable_lex=True)

    def test_geometry_and_coords(self):
        """Verifies Cesarz & Woldar 12-orbit partition of Gamma_2(x_0)."""
        coords = self.compiler.coords
        self.assertEqual(len(coords), 84, "Gamma_2 must contain exactly 84 vertices (12 orbits of size 7)")
        
        # Each coordinate in Gamma_1(x_0) must appear in exactly 12 vertices of Gamma_2
        counts = {K: 0 for K in self.compiler.all_coords}
        for (p, t), c in coords.items():
            self.assertEqual(len(c), 2, f"Vertex ({p}, {t}) must have exactly 2 coordinates in Gamma_1")
            for K in c:
                counts[K] += 1
        self.assertEqual(len(counts), 14, "Gamma_1 must have 14 coordinate labels (7 L and 7 R)")
        for K, cnt in counts.items():
            self.assertEqual(cnt, 12, f"Coordinate {K} must be shared by exactly 12 vertices of Gamma_2")

    def test_primary_variables(self):
        """Verifies allocation of 498 primary variables (36 diagonal + 462 off-diagonal)."""
        self.assertEqual(len(self.compiler.primary_vars), 498)
        self.assertEqual(self.compiler.top_id, 498)

    def test_internal_valence_amo(self):
        """Verifies that b_pp in {0, 2} adds exactly 36 AMO clauses."""
        amo_count = self.compiler.build_internal_valence_cuts()
        self.assertEqual(amo_count, 36)
        self.assertEqual(len(self.compiler.cnf.clauses), 36)

    def test_g_z7_permutations(self):
        """Verifies that all 11 non-identity elements of G_{Z_7} are bijections on the 498 variables."""
        perms = self.compiler._compute_group_permutations()
        self.assertEqual(len(perms), 11, "G_{Z_7} must have exactly 11 non-identity operations")
        for elem_name, perm in perms:
            self.assertEqual(len(perm), 498, f"Permutation {elem_name} must cover all 498 variables")
            self.assertEqual(len(set(perm.values())), 498, f"Permutation {elem_name} must be bijective")

    def test_lex_leader_semantic_correctness(self):
        """Verifies that lex-leader cuts strictly block any assignment where X >_lex g(X)."""
        compiler = ConwayZ7CanonicalCompiler(enable_lex=True)
        compiler.build_lex_leader_cuts()
        perms = compiler._compute_group_permutations()
        
        # Pick the first permutation that has differing variables
        elem_name, perm = perms[0]
        primary_vids = [compiler.var_map[k] for k in compiler.primary_vars]
        diff_pairs = [(v, perm[v]) for v in primary_vids if v != perm[v]]
        self.assertGreater(len(diff_pairs), 1)

        # Force a0 == b0 (equality at pos 0), and a1 == 1, b1 == 0 (violation at pos 1)
        a0, b0 = diff_pairs[0]
        a1, b1 = diff_pairs[1]

        solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
        # a0 = 1, b0 = 1
        solver.add_clause([a0])
        solver.add_clause([b0])
        # a1 = 1, b1 = 0 => X >_lex g(X)
        solver.add_clause([a1])
        solver.add_clause([-b1])

        sat = solver.solve()
        self.assertFalse(sat, f"Lex-leader must refute X >_lex g(X) at second bit for {elem_name}")

    def test_full_z7_dry_run(self):
        """Verifies full Z_7 CNF compilation pipeline in memory."""
        cnf = self.compiler.compile(verbose=False)
        self.assertGreater(len(cnf.clauses), 400000, "Z_7 CNF must contain >400k clauses")
        self.assertGreater(self.compiler.top_id, 170000, "Z_7 CNF must contain >170k variables")


class TestCanonicalZ3FPFCompiler(unittest.TestCase):
    def setUp(self):
        self.compiler = ConwayZ3FPFCanonicalCompiler(enable_modular=True, enable_orbit_order=True)

    def test_variable_allocation(self):
        """Verifies allocation of 33 triangle vars and 1584 circulant vars."""
        self.assertEqual(len(self.compiler.t_vars), 33)
        self.assertEqual(len(self.compiler.edge_vars), 1584)
        self.assertEqual(self.compiler.top_id, 1617)

    def test_modular_parity_cut_isolated(self):
        """Verifies that the modular parity cut strictly allows only sums congruent to 0 mod 3."""
        compiler = ConwayZ3FPFCanonicalCompiler(enable_modular=True, enable_orbit_order=True)
        mod_clauses = compiler.build_modular_parity_cut()
        order_clauses = compiler.build_canonical_orbit_ordering()
        self.assertGreater(mod_clauses, 0)
        self.assertGreater(order_clauses, 0)

        # Solve for all satisfying assignments of triangle vars
        solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
        allowed_configs = []
        while solver.solve():
            m = solver.get_model()
            t_vals = tuple(1 if m[compiler.t_vars[p] - 1] > 0 else 0 for p in range(33))
            allowed_configs.append(t_vals)
            # Block this configuration
            clause = [-compiler.t_vars[p] if t_vals[p] else compiler.t_vars[p] for p in range(33)]
            solver.add_clause(clause)

        self.assertEqual(len(allowed_configs), 12, "Exactly 12 configurations of t_p must be admissible (sums 0, 3, 6, ..., 33)")
        sums = [sum(c) for c in allowed_configs]
        self.assertEqual(sorted(sums), [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33])

    def test_full_z3_fpf_dry_run(self):
        """Verifies full Z_3 FPF CNF compilation pipeline in memory."""
        cnf = self.compiler.compile(verbose=False)
        self.assertGreater(len(cnf.clauses), 1800000, "Z_3 FPF CNF must contain >1.8M clauses")
        self.assertGreater(self.compiler.top_id, 850000, "Z_3 FPF CNF must contain >850k variables")


class TestCanonicalZ3Fixed3Compiler(unittest.TestCase):
    def setUp(self):
        self.compiler = ConwayZ3Fixed3CanonicalCompiler(enable_lex=True)

    def test_variable_and_fixed_edges(self):
        """Verifies 1488 primary vars and fixed 1-factor matchings in N0, N1, N2."""
        self.assertEqual(len(self.compiler.edge_vars), 1488)
        self.assertEqual(len(self.compiler.fixed_edges), 54) # 3 blocks * 6 pairs * 3 diffs

    def test_s3_z2_permutations_preserve_fixed_edges(self):
        """Verifies all 11 non-identity symmetries in S_3 x Z_2 preserve the fixed matchings."""
        perms = self.compiler._compute_s3_z2_permutations()
        self.assertEqual(len(perms), 11, "S_3 x Z_2 has exactly 11 non-identity operations")

        for elem_name, perm in perms:
            self.assertEqual(len(perm), 1488)
            self.assertEqual(len(set(perm.values())), 1488)
            # Check fixed edges are mapped to identically fixed edges
            for (p, q, d), val in self.compiler.fixed_edges.items():
                orig_vid = self.compiler.edge_vars[(p, q, d)]
                target_vid = perm[orig_vid]
                # Find target key
                target_key = None
                for k, v in self.compiler.edge_vars.items():
                    if v == target_vid:
                        target_key = k
                        break
                self.assertIsNotNone(target_key)
                self.assertIn(target_key, self.compiler.fixed_edges)
                self.assertEqual(self.compiler.fixed_edges[target_key], val)

    def test_s3_z2_lex_leader_semantic_correctness(self):
        """Verifies that S_3 x Z_2 lex-leader cuts strictly block X >_lex g(X)."""
        compiler = ConwayZ3Fixed3CanonicalCompiler(enable_lex=True)
        compiler.build_lex_leader_cuts()
        perms = compiler._compute_s3_z2_permutations()

        elem_name, perm = perms[0]
        all_vids = list(compiler.edge_vars.values())
        diff_pairs = [(v, perm[v]) for v in all_vids if v != perm[v]]
        self.assertGreater(len(diff_pairs), 1)

        a0, b0 = diff_pairs[0]
        a1, b1 = diff_pairs[1]

        solver = Cadical195(bootstrap_with=compiler.cnf.clauses)
        solver.add_clause([a0])
        solver.add_clause([b0])
        solver.add_clause([a1])
        solver.add_clause([-b1])

        sat = solver.solve()
        self.assertFalse(sat, f"Lex-leader must refute X >_lex g(X) at second bit for {elem_name}")

    def test_full_z3_fixed3_dry_run(self):
        """Verifies full Z_3 Fixed-3 CNF compilation pipeline in memory."""
        cnf = self.compiler.compile(verbose=False)
        self.assertGreater(len(cnf.clauses), 1500000, "Z_3 Fixed-3 CNF must contain >1.5M clauses")
        self.assertGreater(self.compiler.top_id, 700000, "Z_3 Fixed-3 CNF must contain >700k variables")

if __name__ == "__main__":
    unittest.main()
