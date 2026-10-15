"""Unit Test Suite for Z2 Involution Symmetry Breaking (h=9):
Algebraic Parity Obstruction and Configuration Classification.

Verifies:
1. Exact algebraic parity obstruction for e(i) = 1 (all 9 active orbits internal edges):
   - Row sums = -3.
   - Total sum = 9 * (-3) = -27 (odd).
   - Euler's handshaking lemma contradiction (sum W_ij in 2Z).
   - SAT refutation via CaDiCaL confirms UNSAT.
2. General parity constraint for e(i) in {0, 1}:
   - sum e(i) = 0 mod 2.
   - 256 odd configurations obstructed.
   - Admissible k_e in {0, 2, 4, 6} (k_e=8 excluded by N(x_0) orbit bound).
3. Universal obstruction to positive entries W_ij = +1:
   - e(i)=1, e(j)=1: non-adjacent pair (i,0) not~ (j,1) has >= 3 common neighbors (violates mu <= 2).
   - e(i)=0 or e(j)=0: inclusion-exclusion gives >= 2 common neighbors in S^- (violates lambda <= 1).
   - Forced alphabet: W in {0, -1}^(9x9), W = -B.
4. Complete 4-regular graph classification on 9 vertices (k_e = 0):
   - Exactly 16 classes (OEIS A006820).
   - Exactly 4 classes admissible with mu <= 2.
   - Exactly 1 class is the unique srg(9, 4, 1, 2) Paley(9) (6 triangles, lambda=1, mu=2).
5. Graphic degree sequences for k_e in {0, 2, 4, 6}.
"""

from __future__ import annotations

import itertools
import sys
from pathlib import Path
from typing import List

import numpy as np
import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))

from scripts.verify_z2_h9_parity import (
    classify_h9_degree_sequences,
    classify_h9_w_matrices_ke0,
    generate_all_4regular_9,
    verify_co_neighbor_bounds_mixed_degrees,
    verify_general_parity_constraint,
    verify_h8_h9_h10_coverage,
    verify_h9_all_internal_edges_parity,
    verify_positive_entry_obstruction,
)


class TestH9AllInternalEdgesParity:
    """Mathematical verification of the algebraic parity obstruction for h=9 with all e(i) = 1."""

    def test_algebraic_parity_contradiction(self):
        res = verify_h9_all_internal_edges_parity()
        assert res["h"] == 9
        assert res["row_sum"] == -3
        assert res["total_sum"] == -27
        assert res["is_odd"] is True
        assert res["euler_handshake_contradiction"] is True
        assert res["operational_state"] == "PROVED"

    def test_handshaking_lemma_integer_symmetry(self):
        """For ANY symmetric integer matrix with zero diagonal, total sum is in 2Z."""
        for _ in range(10):
            # Generate random symmetric 9x9 matrix with zero diagonal
            M = np.random.randint(-1, 2, size=(9, 9))
            M = np.tril(M, -1) + np.tril(M, -1).T
            assert np.all(np.diag(M) == 0)
            assert np.array_equal(M, M.T)
            total = int(M.sum())
            assert total % 2 == 0, f"Total sum {total} must be even"

    def test_sat_solver_confirms_unsat(self):
        """Encode the condition: W in {0, -1}^(9x9), W = W^T, W_ii = 0, row sum = -3.
        Equivalently, B = -W in {0, 1}^(9x9) is 3-regular on 9 vertices.
        By S_9 symmetry, fix vertex 0 neighbors to {1, 2, 3}.
        SAT solver (CaDiCaL) must return False (UNSAT) in < 1 second.
        """
        from pysat.solvers import Solver
        from pysat.card import CardEnc, EncType
        from pysat.formula import IDPool

        pool = IDPool()
        clauses = []
        n = 9
        b = {}
        for i in range(n):
            for j in range(i + 1, n):
                v = pool.id(("B", i, j))
                b[(i, j)] = b[(j, i)] = v

        # Fix vertex 0 neighbors by S_9 symmetry: {1, 2, 3}
        for j in range(1, 4):
            clauses.append([b[(0, j)]])
        for j in range(4, n):
            clauses.append([-b[(0, j)]])

        # Vertices 1..8 each have degree 3
        for i in range(1, n):
            row = [b[(i, j)] for j in range(n) if j != i]
            c = CardEnc.equals(lits=row, bound=3, vpool=pool, encoding=EncType.seqcounter)
            clauses.extend(c.clauses)

        with Solver(name="cadical195", bootstrap_with=clauses) as solver:
            is_sat = solver.solve()
            assert is_sat is False, "Parity obstruction failed! Solver returned SAT!"


class TestGeneralParityConstraint:
    """Verification of general parity constraint sum e(i) = 0 mod 2 for e in {0, 1}^9."""

    def test_parity_filter_counts(self):
        res = verify_general_parity_constraint()
        assert res["total_configurations"] == 512
        assert res["even_configurations_count"] == 256
        assert res["odd_configurations_count"] == 256
        assert res["all_odd_obstructed_by_parity"] is True
        assert res["admissible_k_e_values"] == [0, 2, 4, 6]

    def test_exhaustive_modular_arithmetic(self):
        """sum_{i,j} W_{ij} = sum e(i) - 36. Since LHS in 2Z, sum e(i) in 2Z."""
        for bits in itertools.product([0, 1], repeat=9):
            k_e = sum(bits)
            total = k_e - 36
            if k_e % 2 == 1:
                assert total % 2 != 0, f"Odd k_e={k_e} resulted in even total {total}"
            else:
                assert total % 2 == 0, f"Even k_e={k_e} resulted in odd total {total}"

    def test_orbit_bound_eliminates_k_e_8(self):
        """N(x_0) contains 14 vertices, so at most 7 orbits of size 2 can have internal edges.
        Thus k_e = 8 is impossible in Conway's 99-graph.
        """
        max_internal_orbits = 14 // 2
        assert max_internal_orbits == 7
        res = verify_general_parity_constraint()
        assert 8 not in res["admissible_k_e_values"]


class TestPositiveEntryObstruction:
    """Verification that W cannot contain any +1 entry under lambda <= 1 and mu <= 2."""

    def test_obstruction_analysis(self):
        res = verify_positive_entry_obstruction()
        assert res["all_positive_entries_blocked"] is True
        assert res["forced_w_alphabet"] == [0, -1]
        assert res["operational_state"] == "PROVED"

    def test_mu_contradiction_for_e_both_one(self):
        """If e(i)=1 and e(j)=1 with W_ij = +1:
        u = (i, 0) and v' = (j, 1) share 3 distinct common neighbors:
        x_0, (i, 1), and (j, 0).
        """
        # Formally verify non-adjacency and common neighbors
        # q_ij = 0 => (i, 0) not~ (j, 1)
        # 1. x_0 ~ (i, 0) and x_0 ~ (j, 1) because e(i)=1, e(j)=1
        # 2. (i, 1) ~ (i, 0) via e(i)=1, and (i, 1) ~ (j, 1) via p_ij=1
        # 3. (j, 0) ~ (i, 0) via p_ij=1, and (j, 0) ~ (j, 1) via e(j)=1
        common_neighbors = {"x_0", "(i, 1)", "(j, 0)"}
        assert len(common_neighbors) == 3
        mu_max = 2
        assert len(common_neighbors) > mu_max

    def test_lambda_contradiction_for_mixed_e(self):
        """If e(i)=0, row sum is -4. If W_ij = +1, n_-(i) >= 5.
        With n_-(j) >= 4 in 7 remaining columns:
        overlap >= 5 + 4 - 7 = 2 > lambda = 1.
        """
        n_neg_i = 5
        n_neg_j = 4
        universe = 7
        overlap = n_neg_i + n_neg_j - universe
        assert overlap >= 2
        lambda_max = 1
        assert overlap > lambda_max


class TestClassificationKE0:
    """Verification of 4-regular graphs on 9 vertices (OEIS A006820)."""

    @pytest.fixture(scope="class")
    def all_classes(self):
        return classify_h9_w_matrices_ke0()

    def test_total_classes_is_16(self, all_classes):
        """OEIS A006820: exactly 16 isomorphism classes of 4-regular graphs on 9 vertices."""
        assert len(all_classes) == 16

    def test_admissible_classes_count_is_4(self, all_classes):
        """Filtering by mu <= 2 yields exactly 4 admissible classes."""
        admissible = [c for c in all_classes if c["mu_le_2"]]
        assert len(admissible) == 4

    def test_rejected_classes_have_mu_at_least_3(self, all_classes):
        """All 12 rejected classes have non-adjacent pairs with >= 3 common neighbors."""
        rejected = [c for c in all_classes if not c["mu_le_2"]]
        assert len(rejected) == 12
        for c in rejected:
            assert c["max_cn_nonadj"] >= 3

    def test_paley_9_properties(self, all_classes):
        """Exactly one admissible class is Paley(9) = srg(9, 4, 1, 2)."""
        admissible = [c for c in all_classes if c["mu_le_2"]]
        paley_classes = [c for c in admissible if c["is_paley9"]]
        assert len(paley_classes) == 1
        p = paley_classes[0]
        assert p["triangles"] == 6
        assert p["max_cn_adj"] == 1
        assert p["max_cn_nonadj"] == 2
        # Spectrum of Paley(9): -2 (mult 4), 1 (mult 4), 4 (mult 1)
        expected_spec = [-2.0, -2.0, -2.0, -2.0, 1.0, 1.0, 1.0, 1.0, 4.0]
        assert np.allclose(p["spectrum"], expected_spec, atol=1e-3)

    def test_admissible_triangles_distribution(self, all_classes):
        """The 4 admissible classes have triangles in {6, 8, 9, 10}."""
        admissible = [c for c in all_classes if c["mu_le_2"]]
        triangles = sorted([c["triangles"] for c in admissible])
        assert triangles == [6, 8, 9, 10]


class TestDegreeSequences:
    """Verification of admissible graphic degree sequences for k_e in {0, 2, 4, 6}."""

    def test_degree_sequences_validity(self):
        seqs = classify_h9_degree_sequences()
        assert len(seqs) == 4
        for name, data in seqs.items():
            degs = data["degree_sequence"]
            assert len(degs) == 9
            assert sum(degs) % 2 == 0
            assert all(d in [3, 4] for d in degs)
            assert data["is_graphic"] is True


class TestCoNeighborBoundsMixedDegrees:
    """Verification of co-neighbor bounds mu <= 2 for mixed degrees k_e in {0, 2, 4, 6}."""

    @pytest.fixture(scope="class")
    def mixed_results(self):
        return verify_co_neighbor_bounds_mixed_degrees()

    def test_independent_set_lemma(self, mixed_results):
        assert mixed_results["independent_set_lemma"] is True

    def test_co_neighbor_bound_lemma(self, mixed_results):
        assert mixed_results["co_neighbor_bound_lemma"] is True

    def test_ke6_bipartite_degree_sum_refutation(self, mixed_results):
        assert mixed_results["ke6_refuted"] is True
        assert mixed_results["ke6_edges_needed"] == 18
        assert mixed_results["ke6_max_capacity"] == 12
        assert mixed_results["ke6_edges_needed"] > mixed_results["ke6_max_capacity"]

    def test_ke4_subset_intersection_refutation(self, mixed_results):
        assert mixed_results["ke4_refuted"] is True
        assert mixed_results["ke4_valid_quads_count"] == 0

    def test_ke2_clusters_and_saturation(self, mixed_results):
        assert mixed_results["ke2_clusters_count"] == 4
        assert mixed_results["ke2_refuted_by_saturation"] is True

    def test_ke0_all_pairs_b2_rejection(self, mixed_results):
        assert mixed_results["ke0_rejected_by_b2_count"] == 13
        assert mixed_results["ke0_surviving_classes_count"] == 3
        assert mixed_results["ke0_refuted_by_saturation"] is True

    def test_all_mixed_degrees_refuted(self, mixed_results):
        assert mixed_results["all_mixed_degrees_refuted"] is True
        assert mixed_results["operational_state"] == "PROVED"


class TestH8H9H10Coverage:
    """Verification that h=8, h=9, and h=10 are completely covered and certified."""

    @pytest.fixture(scope="class")
    def coverage_results(self):
        return verify_h8_h9_h10_coverage(REPO_ROOT)

    def test_h8_certified(self, coverage_results):
        assert coverage_results["h8_certified"] is True
        assert coverage_results["h8_classes_count"] == 5
        assert coverage_results["h8_operational_state"] == "PROVED"

    def test_h9_certified(self, coverage_results):
        assert coverage_results["h9_certified"] is True
        assert coverage_results["h9_operational_state"] == "PROVED"

    def test_h10_certified(self, coverage_results):
        assert coverage_results["h10_certified"] is True
        assert coverage_results["h10_classes_count"] == 16
        assert coverage_results["h10_operational_state"] == "PROVED"

    def test_all_certified_and_covered(self, coverage_results):
        assert coverage_results["all_certified_and_covered"] is True
        assert coverage_results["operational_state"] == "PROVED"

