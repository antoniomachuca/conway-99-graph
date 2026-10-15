#!/usr/bin/env python3
r"""
tests/test_z84_f7_algebra.py

Comprehensive Unit Test Suite for Requirement R1:
Z84 Structural Reduction over F7 (Rigid Case).

Covers:
1. Canonical Z84 Geometry (M 14x14, B 14x84, K 84x84, BB^T, nePairs bijection).
2. FiberBranchManager: Enumeration of all 10,395 matchings, classification into
   11 canonical orbits of C2 \wr S6, exact orbit sizes, and stabilizer orders.
3. F7AlgebraicModel: Exact nilpotence S^2 = 0 mod 7, prompt operator M_X^2 identity,
   and classification of nilpotent elements.
4. Submatrix Rank Monotonicity: Evaluation of rank_F7(S[:12, :12]) across all 11
   branches, proving that branches 1, 4, 6, 10 have rank 12 and exclude ranks 8 and 10
   on 3,105 matchings.
5. Positive Controls: Complete geometric and algebraic validation on Paley(9) and BVLS(243).
"""

from pathlib import Path
import sys

import numpy as np
import pytest

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.conway_z84_f7 import (
    CanonicalZ84Geometry,
    FiberBranchManager,
    F7AlgebraicModel,
    PositiveControlHarness,
    build_canonical_m_b_k,
    compute_mx_and_schur,
    get_c2_wr_s6_orbits,
)


# -----------------------------------------------------------------------------
# Tier 1 & 2: Canonical Geometry and Invariant Tests
# -----------------------------------------------------------------------------

class TestCanonicalZ84Geometry:
    """Tests for Canonical M, B, K and their structural identities."""

    def test_canonical_m_b_k_dimensions_and_types(self):
        M, B, K = build_canonical_m_b_k()
        assert M.shape == (14, 14)
        assert B.shape == (14, 84)
        assert K.shape == (84, 84)
        assert np.issubdtype(M.dtype, np.integer)
        assert np.issubdtype(B.dtype, np.integer)
        assert np.issubdtype(K.dtype, np.integer)

    def test_canonical_m_invariants(self):
        M, _, _ = build_canonical_m_b_k()
        I14 = np.eye(14, dtype=int)
        assert np.array_equal(M, M.T), "M must be symmetric"
        assert np.all(np.diag(M) == 0), "M diagonal must be 0"
        assert np.all(M.sum(axis=1) == 1), "M must be 1-regular (7 K_2)"
        assert np.array_equal(M @ M, I14), "M^2 must be identity (involutive adjacency)"

    def test_canonical_b_invariants(self):
        _, B, _ = build_canonical_m_b_k()
        assert np.all(np.isin(B, [0, 1])), "B must be binary"
        assert np.all(B.sum(axis=0) == 2), "Every column of B must have weight 2"
        assert np.all(B.sum(axis=1) == 12), "Every row of B must have weight 12"

    def test_canonical_k_invariants(self):
        _, B, K = build_canonical_m_b_k()
        I84 = np.eye(84, dtype=int)
        J84 = np.ones((84, 84), dtype=int)
        expected_K = 12 * I84 + 2 * J84 - (B.T @ B)
        assert np.array_equal(K, expected_K), "K must equal 12 I + 2 J - B^T B"
        assert np.array_equal(K, K.T), "K must be symmetric"
        assert np.all(np.diag(K) == 12), "Diagonal of K must be 12"

    def test_fundamental_bbt_cross_block_identity(self):
        M, B, _ = build_canonical_m_b_k()
        I14 = np.eye(14, dtype=int)
        J14 = np.ones((14, 14), dtype=int)
        expected_BBT = 11 * I14 + J14 - M
        assert np.array_equal(B @ B.T, expected_BBT), "B B^T must equal 11 I + J - M"

    def test_canonical_ne_pairs_bijection(self):
        ne_pairs = CanonicalZ84Geometry.get_canonical_ne_pairs()
        assert len(ne_pairs) == 84
        assert len(set(ne_pairs)) == 84, "All 84 non-edge pairs must be distinct"
        for a, b in ne_pairs:
            assert 0 <= a < b < 14
            assert a // 2 != b // 2, "Non-edge pairs cannot be matched edges of 7 K_2"

    def test_geometry_verification_helper(self):
        M, B, K = build_canonical_m_b_k()
        checks = CanonicalZ84Geometry.verify_bipartite_geometry(M, B, K)
        assert all(checks.values()), f"Some geometric checks failed: {checks}"


# -----------------------------------------------------------------------------
# Tier 3: C2 \wr S6 11-Branch Orbit Decomposition Tests
# -----------------------------------------------------------------------------

class TestFiberBranchManager:
    r"""Tests for the 10,395 matchings and 11 canonical orbits under C2 \wr S6."""

    def test_perfect_matching_count(self):
        matchings = FiberBranchManager.enumerate_all_matchings()
        assert len(matchings) == 10395, "Total perfect matchings on 12 vertices must be 11!! = 10,395"

    def test_perfect_matching_validity(self):
        # Sample matchings to verify 1-factor structure
        matchings = FiberBranchManager.enumerate_all_matchings()
        for m in matchings[:100]:
            assert len(m) == 6
            vertices = [v for edge in m for v in edge]
            assert sorted(vertices) == list(range(12)), "Each matching must partition {0, ..., 11}"

    def test_all_11_orbit_counts_and_sum(self):
        counts = FiberBranchManager.classify_all_matchings()
        expected = FiberBranchManager.EXPECTED_ORBIT_SIZES

        assert len(counts) == 11, "Must partition into exactly 11 orbits"
        assert set(counts.keys()) == set(expected.keys())

        for part, count in expected.items():
            assert counts[part] == count, f"Orbit {part}: expected {count}, got {counts[part]}"

        assert sum(counts.values()) == 10395, "Total orbit sizes must sum to exactly 10,395"

    def test_stabilizer_orders_and_orbit_sizes(self):
        branches = get_c2_wr_s6_orbits()
        assert len(branches) == 11

        total_orbit_sum = 0
        for b in branches:
            part = tuple(b["partition"])
            stab = b["stabilizer_order"]
            orbit = b["orbit_size"]
            # By Orbit-Stabilizer theorem: |Orbit| * |Stab| = |C2 \wr S6| = 46,080
            assert orbit * stab == 46080, f"Orbit-stabilizer product failed on branch {b['branch_index']}"
            assert orbit == FiberBranchManager.EXPECTED_ORBIT_SIZES[part]
            total_orbit_sum += orbit

        assert total_orbit_sum == 10395

    def test_canonical_representatives_cycle_partitions(self):
        for idx, rep in FiberBranchManager.CANONICAL_BRANCH_MATCHINGS.items():
            computed_part = FiberBranchManager.compute_cycle_partition(rep)
            expected_part = FiberBranchManager.PARTITIONS_6[idx]
            assert computed_part == expected_part, f"Branch {idx} matching partition mismatch"


# -----------------------------------------------------------------------------
# Tier 4: F7 Algebraic Model, Nilpotence, and Submatrix Rank Tests
# -----------------------------------------------------------------------------

class TestF7AlgebraicModel:
    """Tests for the F7 algebraic relations, nilpotence, and submatrix rank monotonicity."""

    def test_algebraic_nilpotence_symbolic(self):
        res = F7AlgebraicModel.verify_algebraic_nilpotence_symbolic()
        assert res["mx_square_matches_BTB_minus_2BTMB"] is True
        assert res["schur_complement_identically_nilpotent"] is True
        # Verify that only the 7 elements S + delta J are nilpotent with coeff(X) = 1
        assert res["total_nilpotent_elements_with_X1"] == 7
        for gen in res["nilpotent_generators"]:
            assert gen[0] == 4  # -3 mod 7
            assert gen[2] == 1  # X coeff
            assert gen[3] == 1  # M1 = B^T M B coeff
            assert gen[4] == 3  # M2 = B^T B coeff

    def test_modular_rank_algorithm(self):
        # Test modular Gaussian elimination over F7
        A = np.array([
            [1, 2, 3],
            [2, 4, 6],
            [1, 1, 1],
        ], dtype=int)
        assert F7AlgebraicModel.rank_mod_p(A, 7) == 2

        # Invertible 3x3 over F7
        B = np.array([
            [1, 0, 0],
            [0, 2, 0],
            [0, 0, 3],
        ], dtype=int)
        assert F7AlgebraicModel.rank_mod_p(B, 7) == 3

    def test_submatrix_ranks_and_rank12_exclusions(self):
        branches = get_c2_wr_s6_orbits()

        expected_ranks = {
            0: 10,   # [6]
            1: 12,   # [5, 1]
            2: 8,    # [4, 2]
            3: 10,   # [4, 1, 1]
            4: 12,   # [3, 3]
            5: 10,   # [3, 2, 1]
            6: 12,   # [3, 1, 1, 1]
            7: 6,    # [2, 2, 2]
            8: 8,    # [2, 2, 1, 1]
            9: 10,   # [2, 1, 1, 1, 1]
            10: 12,  # [1, 1, 1, 1, 1, 1]
        }

        rank_12_branches = []
        excluded_matchings_count = 0

        for b in branches:
            idx = b["branch_index"]
            rank_S = b["submatrix_rank_f7"]
            assert rank_S == expected_ranks[idx], f"Branch {idx} rank mismatch: got {rank_S}, expected {expected_ranks[idx]}"

            if rank_S == 12:
                rank_12_branches.append(idx)
                assert b["excludes_ranks_8_10"] is True
                excluded_matchings_count += b["orbit_size"]
            else:
                assert b["excludes_ranks_8_10"] is False

        # Branches with submatrix rank 12 must be exactly {1, 4, 6, 10}
        assert set(rank_12_branches) == {1, 4, 6, 10}

        # Exact matchings excluded from ranks 8 and 10:
        # 2304 + 640 + 160 + 1 = 3105
        assert excluded_matchings_count == 3105


# -----------------------------------------------------------------------------
# Tier 5: Positive Controls Validation
# -----------------------------------------------------------------------------

class TestPositiveControlHarness:
    """Tests certifying positive controls Paley(9) and BVLS(243)."""

    def test_paley9_control(self):
        res = PositiveControlHarness.validate_control("paley9")
        assert res["vertices"] == 9
        assert res["degree"] == 4
        assert res["residual_size"] == 4
        assert res["M_degree_1"] is True
        assert res["M_square_identity"] is True
        assert res["BBT_identity"] is True
        assert res["coupling_equation"] is True
        assert res["quadratic_equation"] is True

    def test_bvls243_control(self):
        res = PositiveControlHarness.validate_control("bvls243")
        assert res["vertices"] == 243
        assert res["degree"] == 22
        assert res["residual_size"] == 220
        assert res["M_degree_1"] is True
        assert res["M_square_identity"] is True
        assert res["BBT_identity"] is True
        assert res["coupling_equation"] is True
        assert res["quadratic_equation"] is True
