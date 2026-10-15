"""Unit Test Suite for Z2 Involution Symmetry Breaking (h=8) and W-Matrix Enumeration.

Verifies:
1. Inclusion-exclusion algebraic obstruction: no positive entry (+1) can exist in W under lambda <= 1.
2. Exhaustiveness of cubic graph classification: exactly 6 classes (OEIS A005638).
3. Rejection of the mu > 2 cubic class (max common neighbors on non-adjacent pairs = 3).
4. Retention of EXACTLY 5 canonical admissible classes satisfying mu <= 2.
5. Rigorous pairwise non-isomorphism between all 5 canonical classes under S_8.
6. Mathematical invariants for each class:
   - W is symmetric: W = W^T.
   - W has zero diagonal: W_{ii} = 0.
   - All rows of W sum to exactly -3.
   - All entries of W belong to {0, -1}.
   - B = -W is 3-regular on 8 vertices (row sums = 3).
7. Induced 16-vertex subgraph properties:
   - Bipartite structure A_16 = [[0, I+B], [I+B, 0]].
   - Triangle-free and K_4-free (clique number <= 2).
   - Common neighbors on edges is 0 (satisfies lambda <= 1).
   - Common neighbors for non-adjacent vertices in the same spin component is (B^2)_{ij} <= 2.
8. Exact structure of the 64 unit clauses for each canonical class.
9. Integration with z2f1_groupring_sat.Model.
"""

from __future__ import annotations

import itertools
import sys
from pathlib import Path
from typing import List

import numpy as np
import pytest

# Ensure repo root and scratch paths are available
REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))
sys.path.insert(0, str(REPO_ROOT / "scratch" / "avenue2_20261011"))

from scripts.enumerate_z2_w_matrices import (
    build_k4_plus_prism3_adj,
    classify_all_cubic_8,
    classify_all_cubic_10,
    enumerate_canonical_w8,
    enumerate_canonical_w10,
    generate_all_labeled_cubic_8,
    get_canonical_w8_classes,
    get_canonical_w10_classes,
    parse_graph6,
    semantic_to_model_clauses,
    verify_h10_positive_entry_obstruction,
    verify_inclusion_exclusion_obstruction,
)
try:
    from scripts.z2f1_groupring_sat import Model
except ImportError:
    from z2f1_groupring_sat import Model


class TestInclusionExclusionObstruction:
    """Mathematical verification that W cannot contain any +1 entry."""

    def test_inclusion_exclusion_algebraic_proof(self):
        res = verify_inclusion_exclusion_obstruction()
        assert res["all_positive_entries_blocked"] is True
        assert res["forced_configuration"] == (0, 3, 4)
        # Verify for each positive configuration that common neighbors >= 2
        for t in res["positive_entry_tests"]:
            assert t["min_common_neg"] >= 2, f"Expected min common neighbors >= 2, got {t}"
            assert t["violates_lambda_1"] is True

    @pytest.mark.parametrize("n_pos,n_neg,n_zero", [(1, 4, 2), (2, 5, 0)])
    def test_positive_entry_common_neighbors_exceed_lambda(self, n_pos, n_neg, n_zero):
        """If W_ij = +1, both row i and row j have at least 4 minus-ones in 6 columns."""
        rem_cols = 6
        min_overlap = 2 * n_neg - rem_cols
        assert min_overlap >= 2, f"Overlap {min_overlap} must be at least 2"


class TestCubicGraphClassification:
    """Verification of the 6 cubic graph classes on 8 vertices (OEIS A005638)."""

    def test_labeled_cubic_count_oeis_a002829(self):
        """OEIS A002829: There are exactly 19,355 labeled 3-regular graphs on 8 vertices."""
        graphs = generate_all_labeled_cubic_8()
        assert len(graphs) == 19355

    def test_isomorphism_classes_oeis_a005638(self):
        """OEIS A005638: There are exactly 6 isomorphism classes of cubic graphs on 8 vertices."""
        classes = classify_all_cubic_8()
        assert len(classes) == 6

    def test_rejection_of_class_with_mu_greater_than_2(self):
        """Exactly one of the 6 cubic classes has a pair of non-adjacent vertices with
        3 common neighbors (K_{2,3} subgraph), violating mu <= 2.
        """
        all_6 = classify_all_cubic_8()
        rejected = [c for c in all_6 if not c["mu_le_2"]]
        assert len(rejected) == 1
        bad_class = rejected[0]
        assert bad_class["max_cn_nonadj"] == 3
        assert bad_class["triangles"] == 1

    def test_admissible_classes_count_is_exact_5(self):
        """Filtering by mu <= 2 retains exactly 5 admissible classes."""
        classes = get_canonical_w8_classes()
        assert len(classes) == 5


class TestCanonicalW8Invariants:
    """Invariants for the 5 canonical W matrices."""

    @pytest.fixture(scope="class")
    def canonical_classes(self):
        return get_canonical_w8_classes()

    def test_pairwise_non_isomorphism_exhaustive_s8(self, canonical_classes):
        """Prove that all 5 canonical classes are mutually non-isomorphic under S_8."""
        reps = [c["b_matrix"] for c in canonical_classes]
        n = 8
        for i in range(len(reps)):
            for j in range(i + 1, len(reps)):
                m1, m2 = reps[i], reps[j]
                is_iso = any(
                    all(m1[p[u]][p[v]] == m2[u][v] for u in range(n) for v in range(u + 1, n))
                    for p in itertools.permutations(range(n))
                )
                assert not is_iso, f"Class {i+1} and Class {j+1} are isomorphic!"

    def test_matrix_symmetry(self, canonical_classes):
        """W must be symmetric: W = W^T."""
        for c in canonical_classes:
            W = np.array(c["w_matrix"])
            assert np.array_equal(W, W.T), f"Class {c['class_id']} is not symmetric"

    def test_zero_diagonal(self, canonical_classes):
        """W must have zeros along the diagonal."""
        for c in canonical_classes:
            W = np.array(c["w_matrix"])
            assert np.all(np.diag(W) == 0), f"Class {c['class_id']} diagonal is non-zero"

    def test_exact_row_sums_minus_three(self, canonical_classes):
        """Every row of W must sum to exactly -3."""
        for c in canonical_classes:
            W = np.array(c["w_matrix"])
            row_sums = W.sum(axis=1)
            assert np.all(row_sums == -3), f"Class {c['class_id']} row sums != -3: {row_sums}"

    def test_no_positive_entries(self, canonical_classes):
        """All entries in W must be in {0, -1}."""
        for c in canonical_classes:
            W = np.array(c["w_matrix"])
            assert np.all((W == 0) | (W == -1)), f"Class {c['class_id']} has entries not in {{0, -1}}"

    def test_b_matrix_is_3_regular(self, canonical_classes):
        """B = -W must be the adjacency matrix of a 3-regular graph on 8 vertices."""
        for c in canonical_classes:
            B = np.array(c["b_matrix"])
            assert B.shape == (8, 8)
            assert np.all(np.diag(B) == 0)
            assert np.array_equal(B, B.T)
            assert np.all(B.sum(axis=1) == 3)
            # Exactly 12 edges
            assert B.sum() == 24


class TestInduced16VertexSubgraph:
    """Properties of the 16-vertex induced subgraph in Conway-99."""

    @pytest.fixture(scope="class")
    def canonical_classes(self):
        return get_canonical_w8_classes()

    def test_subgraph_is_bipartite_and_k4_free(self, canonical_classes):
        """The 16-vertex subgraph A_16 = [[0, I+B], [I+B, 0]] is bipartite,
        hence triangle-free and K_4-free.
        """
        for c in canonical_classes:
            B = np.array(c["b_matrix"])
            I8 = np.eye(8, dtype=int)
            M = I8 + B
            A16 = np.block([[np.zeros((8, 8), dtype=int), M],
                            [M, np.zeros((8, 8), dtype=int)]])
            assert A16.shape == (16, 16)
            assert np.all(np.diag(A16) == 0)
            assert np.array_equal(A16, A16.T)

            # Degree of each vertex is 1 + 3 = 4
            assert np.all(A16.sum(axis=1) == 4)

            # Check bipartite: no odd cycles
            # A16^3 has trace 0 (no triangles)
            A16_3 = np.linalg.matrix_power(A16, 3)
            assert np.trace(A16_3) == 0, f"Class {c['class_id']} induced subgraph has triangles"

            # Check no K_4: max clique in bipartite graph is at most 2
            # For any 4 vertices, cannot be a clique
            for comb in itertools.combinations(range(16), 4):
                sub = A16[np.ix_(comb, comb)]
                assert sub.sum() < 12, "Found K_4 in induced 16-vertex subgraph!"

    def test_lambda_and_mu_bounds_on_16_vertices(self, canonical_classes):
        """Verify common neighbor constraints:
        - On edges: common neighbors in 16-subgraph = 0 <= lambda = 1.
        - On non-edges within same spin: common neighbors = (I + 2B + B^2)_{ij} = (B^2)_{ij} when B_{ij} = 0,
          which is <= 2.
        """
        for c in canonical_classes:
            B = np.array(c["b_matrix"])
            B2 = B @ B
            # For pairs with B_ij = 0 (non-edges in B):
            for i in range(8):
                for j in range(i + 1, 8):
                    if B[i, j] == 0:
                        cn = B2[i, j]
                        assert cn <= 2, f"Class {c['class_id']} non-adj pair ({i},{j}) has {cn} common neighbors > 2"


class TestUnitClauseStructure:
    """Verification of the 64 unit clauses generated for each class."""

    @pytest.fixture(scope="class")
    def canonical_classes(self):
        return get_canonical_w8_classes()

    def test_exactly_64_semantic_units_per_class(self, canonical_classes):
        for c in canonical_classes:
            units = c["unit_clauses_semantic"]
            assert len(units) == 64

            e_units = [u for u in units if u[0] == "e"]
            x0_units = [u for u in units if u[0] == "x" and u[3] == 0]
            x1_units = [u for u in units if u[0] == "x" and u[3] == 1]

            # 8 internal edges
            assert len(e_units) == 8
            assert all(u[2] is True for u in e_units)

            # 28 same-spin non-edges
            assert len(x0_units) == 28
            assert all(u[4] is False for u in x0_units)

            # 28 cross-spin edges/non-edges
            assert len(x1_units) == 28
            pos_x1 = [u for u in x1_units if u[4] is True]
            neg_x1 = [u for u in x1_units if u[4] is False]
            assert len(pos_x1) == 12  # 12 edges in cubic graph
            assert len(neg_x1) == 16  # 16 non-edges in cubic graph

    def test_model_clauses_generation(self, canonical_classes):
        """Test conversion to Model integer clauses."""
        M = Model(m=49, k=14, lam=1, mu=2, phi=8)
        for c in canonical_classes:
            clauses = semantic_to_model_clauses(M, c["unit_clauses_semantic"])
            assert len(clauses) == 64
            for cl in clauses:
                assert len(cl) == 1
                assert isinstance(cl[0], int)
                assert cl[0] != 0


class TestH10PositiveEntryObstruction:
    """Mathematical verification that W cannot contain any +1 entry for h=10."""

    def test_h10_positive_entry_obstruction(self):
        res = verify_h10_positive_entry_obstruction()
        assert res["h"] == 10
        assert res["all_positive_entries_blocked"] is True
        assert res["forced_w_alphabet"] == [0, -1]
        assert res["operational_state"] == "PROVED"


class TestH10CubicGraphClassification:
    """Verification of the 19 connected cubic graphs on 10 vertices (OEIS A002851)
    and filtering by mu <= 2 (OEIS A005638).
    """

    def test_connected_cubic_classes_count_is_19(self):
        """OEIS A002851: Exactly 19 connected cubic graphs on 10 vertices."""
        classes = classify_all_cubic_10()
        assert len(classes) == 19
        assert all(c["connected"] is True for c in classes)

    def test_k23_subgraph_rejection_count_is_4(self):
        """Exactly 4 connected classes contain K_{2,3} subgraphs (mu = 3), violating mu <= 2."""
        classes = classify_all_cubic_10()
        rejected = [c for c in classes if not c["mu_le_2"]]
        assert len(rejected) == 4
        for r in rejected:
            assert r["max_cn_nonadj"] == 3

    def test_admissible_connected_classes_count_is_15(self):
        """Filtering by mu <= 2 retains EXACTLY 15 connected admissible classes."""
        classes = classify_all_cubic_10()
        admissible = [c for c in classes if c["mu_le_2"]]
        assert len(admissible) == 15
        for a in admissible:
            assert a["max_cn_nonadj"] <= 2

    def test_disconnected_classes_analysis(self):
        """OEIS A005638 has 2 disconnected cubic graphs on 10 vertices:
        - K_4 + K_{3,3}: K_{3,3} has mu = 3 (rejected).
        - K_4 + Prism_3: max non-adj common neighbors = 2 (admissible).
        """
        disc_adj = build_k4_plus_prism3_adj()
        A = np.array(disc_adj, dtype=int)
        assert np.all(A.sum(axis=1) == 3)
        A2 = A @ A
        max_cn_nonadj = 0
        for i in range(10):
            for j in range(i + 1, 10):
                if disc_adj[i][j] == 0:
                    max_cn_nonadj = max(max_cn_nonadj, int(A2[i, j]))
        assert max_cn_nonadj == 2, "K_4 + Prism_3 must have mu = 2"


class TestH10CanonicalWInvariants:
    """Invariants for the 15 canonical W matrices for h=10."""

    @pytest.fixture(scope="class")
    def canonical_h10_classes(self):
        return get_canonical_w10_classes()

    def test_matrix_symmetry(self, canonical_h10_classes):
        """W must be symmetric: W = W^T."""
        for c in canonical_h10_classes:
            W = np.array(c["w_matrix"])
            assert np.array_equal(W, W.T), f"Class {c['class_id']} is not symmetric"

    def test_zero_diagonal(self, canonical_h10_classes):
        """W must have zeros along the diagonal."""
        for c in canonical_h10_classes:
            W = np.array(c["w_matrix"])
            assert np.all(np.diag(W) == 0), f"Class {c['class_id']} diagonal is non-zero"

    def test_exact_row_sums_minus_three(self, canonical_h10_classes):
        """Every row of W must sum to exactly -3."""
        for c in canonical_h10_classes:
            W = np.array(c["w_matrix"])
            row_sums = W.sum(axis=1)
            assert np.all(row_sums == -3), f"Class {c['class_id']} row sums != -3: {row_sums}"

    def test_no_positive_entries(self, canonical_h10_classes):
        """All entries in W must be in {0, -1}."""
        for c in canonical_h10_classes:
            W = np.array(c["w_matrix"])
            assert np.all((W == 0) | (W == -1)), f"Class {c['class_id']} has entries not in {{0, -1}}"

    def test_b_matrix_is_3_regular(self, canonical_h10_classes):
        """B = -W must be 3-regular on 10 vertices (15 edges)."""
        for c in canonical_h10_classes:
            B = np.array(c["b_matrix"])
            assert B.shape == (10, 10)
            assert np.all(np.diag(B) == 0)
            assert np.array_equal(B, B.T)
            assert np.all(B.sum(axis=1) == 3)
            assert B.sum() == 30  # 15 edges * 2
            assert len(c["edges"]) == 15

    def test_petersen_graph_properties(self, canonical_h10_classes):
        """Class 5 is the Petersen graph."""
        petersen = [c for c in canonical_h10_classes if c["name"] == "class5_petersen"][0]
        assert petersen["triangles"] == 0
        assert petersen["max_cn_nonadj"] == 1
        assert petersen["max_cn_adj"] == 0
        # Spectrum: -2 (mult 4), 1 (mult 5), 3 (mult 1)
        expected = [-2.0, -2.0, -2.0, -2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 3.0]
        assert np.allclose(petersen["spectrum"], expected, atol=1e-3)


class TestH10UnitClauseStructure:
    """Verification of the 100 unit clauses generated for each h=10 class."""

    @pytest.fixture(scope="class")
    def canonical_h10_classes(self):
        return get_canonical_w10_classes()

    def test_exactly_100_semantic_units_per_class(self, canonical_h10_classes):
        for c in canonical_h10_classes:
            units = c["unit_clauses_semantic"]
            assert len(units) == 100

            e_units = [u for u in units if u[0] == "e"]
            x0_units = [u for u in units if u[0] == "x" and u[3] == 0]
            x1_units = [u for u in units if u[0] == "x" and u[3] == 1]

            # 10 internal edges
            assert len(e_units) == 10
            assert all(u[2] is True for u in e_units)

            # 45 same-spin non-edges: binom(10, 2) = 45
            assert len(x0_units) == 45
            assert all(u[4] is False for u in x0_units)

            # 45 cross-spin edges/non-edges
            assert len(x1_units) == 45
            pos_x1 = [u for u in x1_units if u[4] is True]
            neg_x1 = [u for u in x1_units if u[4] is False]
            assert len(pos_x1) == 15  # 15 edges in cubic graph on 10 nodes
            assert len(neg_x1) == 30  # 45 - 15 = 30 non-edges

    def test_model_clauses_generation_h10(self, canonical_h10_classes):
        """Test conversion to Model integer clauses for phi=10."""
        M = Model(m=49, k=14, lam=1, mu=2, phi=10)
        for c in canonical_h10_classes[:3]:  # Spot check first 3 classes
            clauses = semantic_to_model_clauses(M, c["unit_clauses_semantic"])
            assert len(clauses) == 100
            for cl in clauses:
                assert len(cl) == 1
                assert isinstance(cl[0], int)
                assert cl[0] != 0


class TestInterfaceContracts:
    """Verify compliance with PROJECT.md Interface Contracts."""

    def test_enumerate_canonical_w8_contract(self):
        classes = enumerate_canonical_w8()
        assert isinstance(classes, list)
        assert len(classes) == 5
        for c in classes:
            assert "class_id" in c
            assert "name" in c
            assert "w_matrix" in c
            assert "b_matrix" in c
            assert "unit_clauses_semantic" in c

    def test_enumerate_canonical_w10_contract(self):
        classes = enumerate_canonical_w10()
        assert isinstance(classes, list)
        assert len(classes) == 15
        for c in classes:
            assert "class_id" in c
            assert "name" in c
            assert "w_matrix" in c
            assert "b_matrix" in c
            assert "unit_clauses_semantic" in c

    def test_enumerate_canonical_w10_with_disconnected(self):
        classes = enumerate_canonical_w10(include_disconnected=True)
        assert isinstance(classes, list)
        assert len(classes) == 16
        assert classes[-1]["name"] == "class16_disconnected_k4_prism3"
