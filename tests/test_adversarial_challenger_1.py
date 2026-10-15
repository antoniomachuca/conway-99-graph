#!/usr/bin/env python3
r"""tests/test_adversarial_challenger_1.py

Adversarial stress-testing, fuzzing, and proof corruption audit for Conway's 99-Graph
implementations (Challenger 1).

Coverage:
1. R1 Matching Decomposition Fuzzing:
   - Orbit invariant preservation under random permutations in C2 \wr S6 (order 46,080).
   - Invariant failure under general S12 permutations (discriminative power).
2. R1 Modular Gaussian Elimination Fuzzing:
   - Rank invariance under GL(m, 7) x GL(n, 7) change of basis.
   - Transpose invariance over F7.
   - Rank-1 perturbation bound |rank(A + uv^T) - rank(A)| <= 1.
   - Subadditivity and low-rank factorizations over F7.
3. R1 Submatrix Rank Monotonicity:
   - Empirical proof that rank-12 12x12 submatrix forbids total rank 8 or 10 across
     arbitrary completions over F7.
   - Rigorous audit of the 11 canonical branches in FiberBranchManager.
4. R2 Signed Support Matrix Invariants:
   - Degree obstruction for cubic graphs with positive signings.
   - Inclusion-exclusion fuzzer proving that ANY positive entry with row sum -3
     forces >= 2 common neighbors, strictly violating lambda <= 1.
5. R2 DRAT Proof Corruption & Integrity Audit:
   - Truncation tests rejecting proofs with drat-trim (exit code != 0, s NOT VERIFIED).
   - Empty clause deletion tests.
   - Byte-level bitflip corruption tests.
   - Cryptographic SHA-256 verification against proofs/z2_h8/audit_manifest.json.
"""

from __future__ import annotations

import collections
import glob
import hashlib
import json
import os
from pathlib import Path
import random
import subprocess
import sys
import tempfile
from typing import Any, Dict, List, Set, Tuple

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

import numpy as np
import pytest

from scripts.conway_z84_f7 import (
    CanonicalZ84Geometry,
    F7AlgebraicModel,
    FiberBranchManager,
)
from scripts.enumerate_z2_w_matrices import (
    classify_all_cubic_8,
    enumerate_canonical_w8,
    verify_inclusion_exclusion_obstruction,
)

CADICAL_BIN = REPO_ROOT / "cadical"
DRAT_TRIM_BIN = REPO_ROOT / "drat-trim" / "drat-trim"


# =============================================================================
# Helper Functions for Fuzzing & Invariants
# =============================================================================

def random_c2_wr_s6_element() -> List[int]:
    """Generates a random permutation in C2 \\wr S6 acting on {0, ..., 11}.
    Each block {2b, 2b+1} is mapped to {2*sigma(b), 2*sigma(b)+1} with an optional flip.
    """
    sigma = list(range(6))
    random.shuffle(sigma)
    flips = [random.randint(0, 1) for _ in range(6)]
    perm = [0] * 12
    for b in range(6):
        target_b = sigma[b]
        flip = flips[b]
        perm[2 * b] = 2 * target_b + flip
        perm[2 * b + 1] = 2 * target_b + (1 - flip)
    return perm


def apply_permutation_to_matching(
    matching: List[Tuple[int, int]], perm: List[int]
) -> List[Tuple[int, int]]:
    """Applies a permutation on {0, ..., 11} to a 1-factor."""
    new_edges = []
    for u, v in matching:
        pu, pv = perm[u], perm[v]
        new_edges.append((min(pu, pv), max(pu, pv)))
    return sorted(new_edges)


def generate_random_perfect_matching(n: int = 12) -> List[Tuple[int, int]]:
    """Generates a uniformly random perfect matching on n vertices."""
    verts = list(range(n))
    random.shuffle(verts)
    matching = []
    for i in range(0, n, 2):
        u, v = verts[i], verts[i + 1]
        matching.append((min(u, v), max(u, v)))
    return sorted(matching)


# =============================================================================
# 1. R1 Matching Decomposition Fuzzing Suite
# =============================================================================

class TestFuzzMatchingDecomposition:
    """Adversarial stress-testing of C2 \\wr S6 group actions and cycle partitions."""

    def test_c2_wr_s6_group_axioms(self):
        """Verifies closure, bijection, and block preservation for random group elements."""
        for _ in range(100):
            g = random_c2_wr_s6_element()
            assert sorted(g) == list(range(12)), "Element is not a permutation of 12 vertices"
            # Verify block preservation: {g(2b), g(2b+1)} is of the form {2k, 2k+1}
            for b in range(6):
                u, v = g[2 * b], g[2 * b + 1]
                assert u // 2 == v // 2, f"Block {b} was split across blocks {u//2} and {v//2}"
                assert {u % 2, v % 2} == {0, 1}, "Block elements do not have complementary spins"

    def test_canonical_representatives_orbit_invariance_fuzzing(self):
        """Stress-tests that for all 11 canonical representatives, 50 random
        transformations in C2 \\wr S6 preserve the exact cycle partition.
        """
        for branch_idx in range(11):
            m = FiberBranchManager.CANONICAL_BRANCH_MATCHINGS[branch_idx]
            expected_partition = FiberBranchManager.PARTITIONS_6[branch_idx]
            base_calc = FiberBranchManager.compute_cycle_partition(m)
            assert base_calc == expected_partition

            for _ in range(50):
                g = random_c2_wr_s6_element()
                gm = apply_permutation_to_matching(m, g)
                part = FiberBranchManager.compute_cycle_partition(gm)
                assert part == expected_partition, (
                    f"Orbit invariant violated for branch {branch_idx}! "
                    f"Expected {expected_partition}, got {part}"
                )

    def test_random_matchings_orbit_invariance_fuzzing(self):
        """Generates 50 random matchings, computes their partition, and verifies
        that 20 random C2 \\wr S6 elements preserve the partition identically.
        """
        for _ in range(50):
            rand_m = generate_random_perfect_matching(12)
            orig_partition = FiberBranchManager.compute_cycle_partition(rand_m)
            assert sum(orig_partition) == 6

            for _ in range(20):
                g = random_c2_wr_s6_element()
                gm = apply_permutation_to_matching(rand_m, g)
                part = FiberBranchManager.compute_cycle_partition(gm)
                assert part == orig_partition, (
                    f"Random matching partition altered under C2 \\wr S6! "
                    f"{orig_partition} -> {part}"
                )

    def test_general_s12_violates_orbit_invariance(self):
        """Adversarial check: arbitrary permutations in S12 (not respecting the
        block system) do NOT preserve the cycle partition, proving the invariant
        is genuinely specific to C2 \\wr S6.
        """
        m = FiberBranchManager.CANONICAL_BRANCH_MATCHINGS[0]  # [6]
        orig_part = (6,)
        altered_count = 0
        trials = 100
        for _ in range(trials):
            perm = list(range(12))
            random.shuffle(perm)
            gm = apply_permutation_to_matching(m, perm)
            if FiberBranchManager.compute_cycle_partition(gm) != orig_part:
                altered_count += 1

        assert altered_count > 30, (
            f"Expected arbitrary S12 permutations to frequently change partition, "
            f"but only {altered_count}/{trials} changed"
        )


# =============================================================================
# 2. R1 Modular Gaussian Elimination Fuzzing Suite
# =============================================================================

class TestModularGaussianEliminationAdversarial:
    """Stress tests exact Gaussian elimination over F7 under random perturbations."""

    def test_rank_mod_p_transpose_invariance(self):
        """Verifies rank_F7(A) == rank_F7(A^T) on 100 random rectangular matrices."""
        for _ in range(100):
            nrows = random.randint(2, 25)
            ncols = random.randint(2, 25)
            A = np.random.randint(0, 7, size=(nrows, ncols), dtype=np.int64)
            r = F7AlgebraicModel.rank_mod_p(A, 7)
            r_T = F7AlgebraicModel.rank_mod_p(A.T, 7)
            assert r == r_T, f"Transpose rank mismatch: rank(A)={r} != rank(A^T)={r_T}"
            assert 0 <= r <= min(nrows, ncols)

    def test_rank_mod_p_invertible_basis_change(self):
        """Verifies rank_F7(P A Q) == rank_F7(A) for random P in GL(m, 7) and Q in GL(n, 7)."""
        for _ in range(50):
            m = random.randint(3, 15)
            n = random.randint(3, 15)
            A = np.random.randint(0, 7, size=(m, n), dtype=np.int64)
            r_A = F7AlgebraicModel.rank_mod_p(A, 7)

            # Sample random invertible P in GL(m, 7)
            while True:
                P = np.random.randint(0, 7, size=(m, m), dtype=np.int64)
                if F7AlgebraicModel.rank_mod_p(P, 7) == m:
                    break

            # Sample random invertible Q in GL(n, 7)
            while True:
                Q = np.random.randint(0, 7, size=(n, n), dtype=np.int64)
                if F7AlgebraicModel.rank_mod_p(Q, 7) == n:
                    break

            PAQ = (P @ A @ Q) % 7
            r_PAQ = F7AlgebraicModel.rank_mod_p(PAQ, 7)
            assert r_PAQ == r_A, f"Change of basis altered rank: {r_A} -> {r_PAQ}"

    def test_rank_mod_p_rank_one_perturbation(self):
        """Verifies that adding a rank-1 outer product u v^T can change rank by at most 1."""
        for _ in range(100):
            m = random.randint(4, 20)
            n = random.randint(4, 20)
            A = np.random.randint(0, 7, size=(m, n), dtype=np.int64)
            r_A = F7AlgebraicModel.rank_mod_p(A, 7)

            u = np.random.randint(0, 7, size=(m, 1), dtype=np.int64)
            v = np.random.randint(0, 7, size=(n, 1), dtype=np.int64)
            pert = (u @ v.T) % 7

            A_new = (A + pert) % 7
            r_new = F7AlgebraicModel.rank_mod_p(A_new, 7)
            assert abs(r_new - r_A) <= 1, (
                f"Rank 1 perturbation shifted rank by {abs(r_new - r_A)}! "
                f"r_A={r_A}, r_new={r_new}"
            )

    def test_rank_mod_p_subadditivity(self):
        """Verifies rank_F7(A + B) <= rank_F7(A) + rank_F7(B)."""
        for _ in range(50):
            m = random.randint(3, 16)
            n = random.randint(3, 16)
            A = np.random.randint(0, 7, size=(m, n), dtype=np.int64)
            B = np.random.randint(0, 7, size=(m, n), dtype=np.int64)
            r_A = F7AlgebraicModel.rank_mod_p(A, 7)
            r_B = F7AlgebraicModel.rank_mod_p(B, 7)
            r_sum = F7AlgebraicModel.rank_mod_p((A + B) % 7, 7)
            assert r_sum <= r_A + r_B, f"Subadditivity failed: {r_sum} > {r_A} + {r_B}"

    def test_rank_mod_p_unreduced_integers_robustness(self):
        """Verifies that the rank function safely handles negative or large unreduced inputs."""
        A = np.array([
            [14, 21, 28],
            [-7, -14, -21],
            [35, 42, 49]
        ], dtype=np.int64)
        assert F7AlgebraicModel.rank_mod_p(A, 7) == 0

        B = np.array([
            [-6, 15, -13],  # = [1, 1, 1] mod 7
            [8, 1, -20],    # = [1, 1, 1] mod 7
            [2, 9, 16]      # = [2, 2, 2] mod 7
        ], dtype=np.int64)
        assert F7AlgebraicModel.rank_mod_p(B, 7) == 1


# =============================================================================
# 3. R1 Submatrix Rank Monotonicity & Exclusion Suite
# =============================================================================

class TestSubmatrixRankMonotonicityExclusions:
    """Stress tests the rank monotonicity lower bound over F7:
    rank_F7(S) >= rank_F7(S[:12, :12]).
    """

    def test_submatrix_rank_12_lower_bound_empirical(self):
        """Generates 200 random completions of a rank-12 12x12 matrix to 84x84
        and verifies that total rank is strictly >= 12 in every single instance.
        """
        # Create an invertible 12x12 matrix over F7
        while True:
            S12 = np.random.randint(0, 7, size=(12, 12), dtype=np.int64)
            if F7AlgebraicModel.rank_mod_p(S12, 7) == 12:
                break

        for _ in range(200):
            completion = np.zeros((84, 84), dtype=np.int64)
            completion[:12, :12] = S12
            # Add random structured completions:
            mode = random.choice(["dense_random", "sparse", "symmetric", "rank_1_blocks"])
            if mode == "dense_random":
                completion[12:, :] = np.random.randint(0, 7, size=(72, 84))
                completion[:, 12:] = np.random.randint(0, 7, size=(84, 72))
            elif mode == "sparse":
                mask = np.random.choice([0, 1], size=(84, 84), p=[0.9, 0.1])
                completion[12:, 12:] = (mask * np.random.randint(0, 7, size=(84, 84)))[12:, 12:]
            elif mode == "symmetric":
                R = np.random.randint(0, 7, size=(84, 84))
                R = (R + R.T) % 7
                completion[12:, :] = R[12:, :]
                completion[:, 12:] = R[:, 12:]
                completion[:12, :12] = S12
            elif mode == "rank_1_blocks":
                u = np.random.randint(0, 7, size=(84, 1))
                v = np.random.randint(0, 7, size=(84, 1))
                outer = (u @ v.T) % 7
                completion[12:, :] = outer[12:, :]
                completion[:, 12:] = outer[:, 12:]
                completion[:12, :12] = S12

            total_rank = F7AlgebraicModel.rank_mod_p(completion, 7)
            assert total_rank >= 12, (
                f"Submatrix rank monotonicity VIOLATED! "
                f"Submatrix rank 12 gave total completion rank {total_rank} < 12!"
            )
            # Rigorous check: total rank cannot be 8 or 10
            assert total_rank not in (8, 10), (
                f"Impossible rank completion observed: {total_rank}!"
            )

    def test_all_11_branch_submatrix_ranks_and_exclusions(self):
        """Verifies the exact submatrix ranks of S[:12, :12] for all 11 branches,
        confirming that branches 1, 4, 6, 10 have submatrix rank 12 and exclude
        ranks 8 and 10 on 3,105 matchings.
        """
        branches = FiberBranchManager.get_c2_wr_s6_orbits()
        assert len(branches) == 11

        expected_ranks = {
            0: 10,  # [6]
            1: 12,  # [5, 1]
            2: 8,   # [4, 2]
            3: 10,  # [4, 1, 1]
            4: 12,  # [3, 3]
            5: 10,  # [3, 2, 1]
            6: 12,  # [3, 1, 1, 1]
            7: 6,   # [2, 2, 2]
            8: 8,   # [2, 2, 1, 1]
            9: 10,  # [2, 1, 1, 1, 1]
            10: 12, # [1, 1, 1, 1, 1, 1]
        }

        rank_12_indices = []
        rank_12_total_size = 0
        for b in branches:
            idx = b["branch_index"]
            assert b["submatrix_rank_f7"] == expected_ranks[idx]
            if b["submatrix_rank_f7"] >= 12:
                rank_12_indices.append(idx)
                rank_12_total_size += b["orbit_size"]
                assert b["excludes_ranks_8_10"] is True
            else:
                assert b["excludes_ranks_8_10"] is False

        assert rank_12_indices == [1, 4, 6, 10]
        assert rank_12_total_size == 3105, f"Expected 3105 excluded matchings, got {rank_12_total_size}"


# =============================================================================
# 4. R2 Signed Support Matrix Invariants Suite
# =============================================================================

class TestInclusionExclusionAdversarial:
    """Stress tests the algebraic obstruction prohibiting +1 entries in W."""

    def test_cubic_graph_degree_barrier_for_positive_entries(self):
        """Proves that for any 3-regular graph on 8 vertices, assigning signs
        s_ij in {+1, -1} to edges can NEVER produce row sum -3 if any edge has sign +1.
        """
        classes = classify_all_cubic_8()
        for c in classes:
            B = np.array(c["b_matrix"], dtype=int)
            # Find all 12 edges
            edges = [(i, j) for i in range(8) for j in range(i + 1, 8) if B[i, j] == 1]
            assert len(edges) == 12

            # Fuzz 500 random signings per cubic graph
            for _ in range(500):
                signs = [random.choice([1, -1]) for _ in range(12)]
                if 1 not in signs:
                    continue  # All negative is the valid W = -B configuration

                # Build signed matrix W
                W = np.zeros((8, 8), dtype=int)
                for (u, v), s in zip(edges, signs):
                    W[u, v] = s
                    W[v, u] = s

                row_sums = W.sum(axis=1)
                # At least one row will fail to equal -3
                has_row_sum_minus_3_everywhere = bool(np.all(row_sums == -3))
                assert not has_row_sum_minus_3_everywhere, (
                    "A cubic graph with a positive entry achieved row sum -3 everywhere!"
                )

    def test_general_signed_matrix_fuzzer_violates_lambda_1(self):
        """Fuzzer: For 2,000 random row pairs (row_i, row_j) with sum -3 and W_ij = +1,
        verifies that EVERY pair has common negative columns |S_i cap S_j| >= 2,
        violating lambda <= 1 unconditionally.
        """
        valid_row_types = [(1, 4, 2), (2, 5, 0)]  # (n_pos, n_neg, n_zero)
        universe = list(range(6))  # 6 columns available outside {i, j}

        for _ in range(2000):
            type_i = random.choice(valid_row_types)
            type_j = random.choice(valid_row_types)

            n_neg_i = type_i[1]
            n_neg_j = type_j[1]

            S_i = set(random.sample(universe, n_neg_i))
            S_j = set(random.sample(universe, n_neg_j))

            common_neg = len(S_i.intersection(S_j))
            # Principle of inclusion-exclusion: |S_i cap S_j| >= n_neg_i + n_neg_j - 6 >= 4 + 4 - 6 = 2
            assert common_neg >= 2, f"Counterexample to inclusion-exclusion: {common_neg} < 2"

    def test_exhaustive_two_row_intersection_bound(self):
        """Exhaustively evaluates all combinations of subsets of size >= 4 in a
        6-element set, proving minimum intersection size is strictly 2.
        """
        import itertools
        universe = set(range(6))
        all_subsets_ge_4 = [
            set(s) for r in range(4, 7) for s in itertools.combinations(universe, r)
        ]
        min_intersection = 6
        for s1 in all_subsets_ge_4:
            for s2 in all_subsets_ge_4:
                inter = len(s1 & s2)
                if inter < min_intersection:
                    min_intersection = inter

        assert min_intersection == 2, f"Expected min intersection 2, got {min_intersection}"


# =============================================================================
# 5. R2 DRAT Proof Corruption & Integrity Audit Suite
# =============================================================================

class TestDRATProofCorruptionRejection:
    """Forensic verification that drat-trim strictly REJECTS corrupted, truncated,
    or altered DRAT proofs.
    """

    @pytest.mark.skipif(not DRAT_TRIM_BIN.exists(), reason="drat-trim binary not found")
    def test_drat_trim_rejects_truncated_proof_class1(self):
        """Class 1 (Cube Q3): Truncates proof to 50% length and verifies rejection."""
        cnf_files = sorted(list((REPO_ROOT / "instances" / "z2_h8").glob("conway_z2_h8_class1_*.cnf")))
        drat_files = sorted(list((REPO_ROOT / "proofs" / "z2_h8").glob("conway_z2_h8_class1_*.drat")))
        assert cnf_files and drat_files

        cnf = str(cnf_files[0])
        drat = str(drat_files[0])
        with open(drat, "rb") as f:
            full_data = f.read()

        # Truncate to 50%
        half_data = full_data[: len(full_data) // 2]
        with tempfile.NamedTemporaryFile(suffix=".drat", delete=False) as tf:
            tf.write(half_data)
            tf_path = tf.name

        try:
            res = subprocess.run([str(DRAT_TRIM_BIN), cnf, tf_path], capture_output=True, text=True)
            assert res.returncode != 0, f"Truncated proof unexpectedly succeeded: returncode={res.returncode}"
            assert "s VERIFIED" not in res.stdout, "Truncated proof falsely outputted 's VERIFIED'"
            assert "s NOT VERIFIED" in res.stdout or "c ERROR" in res.stdout, (
                f"Expected drat-trim rejection message, got:\n{res.stdout[-300:]}"
            )
        finally:
            if os.path.exists(tf_path):
                os.unlink(tf_path)

    @pytest.mark.skipif(not DRAT_TRIM_BIN.exists(), reason="drat-trim binary not found")
    def test_drat_trim_rejects_truncated_proof_class2(self):
        """Class 2 (Wagner M8): Truncates proof to 50% length and verifies rejection."""
        cnf_files = sorted(list((REPO_ROOT / "instances" / "z2_h8").glob("conway_z2_h8_class2_*.cnf")))
        drat_files = sorted(list((REPO_ROOT / "proofs" / "z2_h8").glob("conway_z2_h8_class2_*.drat")))
        assert cnf_files and drat_files

        cnf = str(cnf_files[0])
        drat = str(drat_files[0])
        with open(drat, "rb") as f:
            full_data = f.read()

        half_data = full_data[: len(full_data) // 2]
        with tempfile.NamedTemporaryFile(suffix=".drat", delete=False) as tf:
            tf.write(half_data)
            tf_path = tf.name

        try:
            res = subprocess.run([str(DRAT_TRIM_BIN), cnf, tf_path], capture_output=True, text=True)
            assert res.returncode != 0
            assert "s VERIFIED" not in res.stdout
            assert "s NOT VERIFIED" in res.stdout or "c ERROR" in res.stdout
        finally:
            if os.path.exists(tf_path):
                os.unlink(tf_path)

    @pytest.mark.skipif(not DRAT_TRIM_BIN.exists(), reason="drat-trim binary not found")
    def test_drat_trim_rejects_empty_clause_cutoff_class1(self):
        """Class 1: Strips the final 128 bytes containing the empty clause derivation."""
        cnf = str(sorted(list((REPO_ROOT / "instances" / "z2_h8").glob("conway_z2_h8_class1_*.cnf")))[0])
        drat = str(sorted(list((REPO_ROOT / "proofs" / "z2_h8").glob("conway_z2_h8_class1_*.drat")))[0])
        with open(drat, "rb") as f:
            data = f.read()

        trimmed = data[:-128]
        with tempfile.NamedTemporaryFile(suffix=".drat", delete=False) as tf:
            tf.write(trimmed)
            tf_path = tf.name

        try:
            res = subprocess.run([str(DRAT_TRIM_BIN), cnf, tf_path], capture_output=True, text=True)
            assert res.returncode != 0
            assert "s VERIFIED" not in res.stdout
            assert "s NOT VERIFIED" in res.stdout
        finally:
            if os.path.exists(tf_path):
                os.unlink(tf_path)

    @pytest.mark.skipif(not DRAT_TRIM_BIN.exists(), reason="drat-trim binary not found")
    def test_drat_trim_rejects_bitflip_corruption_class1(self):
        """Class 1: Corrupts bytes within core lemmas leading to empty clause,
        verifying that drat-trim strictly rejects the proof.
        Note: Because drat-trim checks backwards from the empty clause, only lemmas
        in the backward resolution core are validated; corrupting non-core lemmas
        is ignored, while corrupting core lemmas causes immediate verification failure.
        """
        cnf = str(sorted(list((REPO_ROOT / "instances" / "z2_h8").glob("conway_z2_h8_class1_*.cnf")))[0])
        drat = str(sorted(list((REPO_ROOT / "proofs" / "z2_h8").glob("conway_z2_h8_class1_*.drat")))[0])
        with open(drat, "rb") as f:
            data = bytearray(f.read())

        # Corrupt bytes in the final resolution chain (last 200 bytes before final 0)
        for pos in range(len(data) - 200, len(data) - 5):
            data[pos] ^= 0xAA

        with tempfile.NamedTemporaryFile(suffix=".drat", delete=False) as tf:
            tf.write(data)
            tf_path = tf.name

        try:
            res = subprocess.run([str(DRAT_TRIM_BIN), cnf, tf_path], capture_output=True, text=True)
            assert "s VERIFIED" not in res.stdout, "Corrupted core lemma falsely produced 's VERIFIED'"
            assert res.returncode != 0 or "s NOT VERIFIED" in res.stdout, (
                f"Expected non-zero return code or 's NOT VERIFIED', got:\n{res.stdout[-300:]}"
            )
        finally:
            if os.path.exists(tf_path):
                os.unlink(tf_path)

    def test_audit_manifest_cryptographic_hashes_against_disk(self):
        """Forensic anti-hallucination check: verifies that every SHA-256 hash recorded
        in proofs/z2_h8/audit_manifest.json strictly matches the actual file on disk.
        """
        manifest_path = REPO_ROOT / "proofs" / "z2_h8" / "audit_manifest.json"
        assert manifest_path.exists(), "audit_manifest.json missing!"

        with open(manifest_path, "r") as f:
            records = json.load(f)

        assert len(records) == 5, f"Expected 5 manifest records, got {len(records)}"

        for r in records:
            cnf_path = Path(r["cnf_path"])
            drat_path = Path(r["drat_path"])

            assert cnf_path.exists(), f"CNF file missing: {cnf_path}"
            assert drat_path.exists(), f"DRAT file missing: {drat_path}"

            # Calculate SHA-256
            cnf_sha = hashlib.sha256(cnf_path.read_bytes()).hexdigest()
            drat_sha = hashlib.sha256(drat_path.read_bytes()).hexdigest()

            assert cnf_sha == r["cnf_sha256"], f"CNF hash mismatch for {cnf_path.name}"
            assert drat_sha == r["drat_sha256"], f"DRAT hash mismatch for {drat_path.name}"

            # Verify recorded status
            assert r["solver_status"] == "UNSATISFIABLE"
            assert r["solver_exit_code"] == 20
            assert r["chk_verified"] is True
            assert r["chk_exit_code"] == 0
            assert r["operational_state"] == "PROVED"
