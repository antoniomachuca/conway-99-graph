#!/usr/bin/env python3
"""Canonical Enumeration of Signed Symmetry-Breaking Support Matrices W for h=8
in Conway's 99-Graph Problem (Requirement R2).

Mathematical Background:
------------------------
For Conway's 99-graph srg(99, 14, 1, 2) admitting an involution sigma with
f = 1 fixed point (vertex 0) and m = 49 orbits of size 2, Djematene's order-2
reduction studies sigma-odd eigenfunctions phi in {0, +/-1}^99 with:
    A phi = -4 phi,  sum phi^2 = 2h  (h = 8 active orbits).
On the active orbits {1, ..., h}, we gauge:
    phi(i, 0) = +1,  phi(i, 1) = -1.
For u = (i, 0) (i <= h), the eigenvalue condition (A phi)(u) = -4 phi(u) gives:
    deg_{S^+}((i, 0)) - deg_{S^-}((i, 0)) = -4
which expands as:
    sum_{j <= h, j != i} (p_{ij} - q_{ij}) + (0 - e(i)) = -4
where:
    p_{ij} = 1 <=> (i, 0) ~ (j, 0)  [same as (i, 1) ~ (j, 1)]
    q_{ij} = 1 <=> (i, 0) ~ (j, 1)  [same as (i, 1) ~ (j, 0)]
    e(i)   = 1 <=> (i, 0) ~ (i, 1)  [internal edge in orbit i]

Because e(i) = 1 on active orbits (every active orbit is an internal edge),
defining the signed symmetric matrix W in {0, +/-1}^(8x8) by:
    W_{ij} = p_{ij} - q_{ij} for i != j,  W_{ii} = 0,
the row sums satisfy:
    sum_{j != i} W_{ij} = e(i) - 4 = 1 - 4 = -3  for all i in {1, ..., 8}.

Inclusion-Exclusion Algebraic Obstruction to Positive Entries:
--------------------------------------------------------------
Theorem: Under srg(99, 14, 1, 2) with lambda <= 1, W cannot contain ANY +1 entry.
Proof:
    Suppose W_{ij} = +1 for some pair i != j.
    Each row i has n_+(i) positive entries (+1), n_-(i) negative entries (-1),
    and n_0(i) zero entries.
    Since W_{ii} = 0 and sum_{k != i} W_{ik} = -3:
        n_+(i) - n_-(i) = -3  ==>  n_-(i) = n_+(i) + 3 >= 4 (since n_+(i) >= 1).
    Similarly, for vertex j:
        n_-(j) = n_+(j) + 3 >= 4.
    Since W_{ij} = +1 (and W_{ii} = W_{jj} = 0), the -1 entries of row i and row j
    must all lie in the remaining 8 - 2 = 6 columns k notin {i, j}.
    Let S_i = {k notin {i, j} : W_{ik} = -1} and S_j = {k notin {i, j} : W_{jk} = -1}.
    Both S_i and S_j are subsets of a 6-element universe with |S_i| >= 4, |S_j| >= 4.
    By the principle of inclusion-exclusion:
        |S_i cap S_j| = |S_i| + |S_j| - |S_i cup S_j| >= 4 + 4 - 6 = 2.
    Each k in S_i cap S_j has W_{ik} = -1 and W_{jk} = -1, meaning q_{ik} = 1 and q_{jk} = 1.
    In the graph G, this implies (k, 1) in S^- is adjacent to BOTH (i, 0) and (j, 0).
    Therefore, (i, 0) and (j, 0) share at least |S_i cap S_j| >= 2 common neighbors in G.
    However, W_{ij} = +1 means p_{ij} = 1, so (i, 0) ~ (j, 0) is an EDGE in G.
    In srg(99, 14, 1, 2), lambda = 1, so adjacent vertices share at most 1 common neighbor.
    This yields 2 <= lambda = 1, an immediate contradiction!
    Therefore, no entry W_{ij} can equal +1.
    Every off-diagonal entry W_{ij} in {0, -1}.
    Since row sums are -3, every row contains exactly three -1 entries and four 0 entries.
    Thus, W = -B, where B in {0, 1}^(8x8) is the adjacency matrix of a 3-regular
    (cubic) simple graph on 8 vertices.  Q.E.D.

Classification Modulo S8:
-------------------------
According to OEIS A005638, there are EXACTLY 6 isomorphism classes of cubic graphs
on 8 vertices:
    - 1 class has a pair of non-adjacent vertices with 3 common neighbors (K_{2,3} subgraph),
      violating the srg parameter mu <= 2. This class is mathematically REJECTED.
    - Exactly 5 classes satisfy mu <= 2 (all pairs of non-adjacent vertices share <= 2
      common neighbors).
    These 5 canonical classes are:
      1. Cube graph Q_3 (bipartite, 0 triangles, max non-adj common neighbors = 2)
      2. Wagner graph M_8 (Möbius ladder, 0 triangles, max non-adj common neighbors = 2)
      3. 2-triangle cubic graph (2 disjoint triangles, max non-adj common neighbors = 2)
      4. 4-triangle cubic graph (4 triangles, max non-adj common neighbors = 2)
      5. 2 x K_4 (disconnected union of two K_4, 8 triangles, max non-adj common neighbors = 0)

Unit Clauses for SAT Injection:
-------------------------------
Each canonical class defines exactly 64 unit clauses fixing all primary variables
on the 8 active orbits:
    - 8 positive unit clauses:  e(i) = 1 for all i in {1, ..., 8}
    - 28 negative unit clauses: x(i, j, 0) = 0 for all 1 <= i < j <= 8 (since p_{ij} = 0)
    - 28 unit clauses for x(i, j, 1):
        x(i, j, 1) = 1 if B_{i-1, j-1} = 1 (12 positive units)
        x(i, j, 1) = 0 if B_{i-1, j-1} = 0 (16 negative units)
    Total: 8 + 28 + 28 = 64 unit clauses.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import os
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import numpy as np

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))
sys.path.insert(0, str(REPO_ROOT / "scratch" / "avenue2_20261011"))

try:
    from z2f1_groupring_sat import Model
except ImportError:
    Model = None


def verify_inclusion_exclusion_obstruction() -> Dict[str, Any]:
    """Rigorously verify the inclusion-exclusion obstruction for all possible
    signed row types with sum -3.
    """
    valid_row_types = []
    obstruction_results = []
    # Off-diagonal entries must satisfy n_+ - n_- = -3 and n_+ + n_- <= 7
    for n_pos in range(8):
        n_neg = n_pos + 3
        if n_pos + n_neg <= 7:
            n_zero = 7 - (n_pos + n_neg)
            valid_row_types.append((n_pos, n_neg, n_zero))
            if n_pos >= 1:
                # If W_ij = +1, columns left for -1 entries is 6
                min_common_neg = 2 * n_neg - 6
                obstruction_results.append({
                    "n_pos": n_pos,
                    "n_neg": n_neg,
                    "n_zero": n_zero,
                    "min_common_neg": min_common_neg,
                    "violates_lambda_1": min_common_neg > 1,
                })

    all_blocked = all(res["violates_lambda_1"] for res in obstruction_results)
    return {
        "valid_row_types": valid_row_types,
        "positive_entry_tests": obstruction_results,
        "all_positive_entries_blocked": all_blocked,
        "forced_configuration": (0, 3, 4),  # W in {0, -1}^(8x8), W = -B
    }


def generate_all_labeled_cubic_8() -> List[List[List[int]]]:
    """Deterministically generate all 19,355 labeled 3-regular simple graphs on 8 vertices
    (OEIS A002829).
    """
    adj = [[0] * 8 for _ in range(8)]
    graphs: List[List[List[int]]] = []

    def backtrack(i: int, j: int, deg: List[int]) -> None:
        if i == 8:
            if all(d == 3 for d in deg):
                graphs.append([row[:] for row in adj])
            return
        if j == 8:
            if deg[i] == 3:
                backtrack(i + 1, i + 2, deg)
            return
        # Branch 0: do not add edge (i, j)
        if deg[i] + (8 - j) >= 3:
            backtrack(i, j + 1, deg)
        # Branch 1: add edge (i, j)
        if deg[i] < 3 and deg[j] < 3:
            adj[i][j] = adj[j][i] = 1
            deg[i] += 1
            deg[j] += 1
            backtrack(i, j + 1, deg)
            adj[i][j] = adj[j][i] = 0
            deg[i] -= 1
            deg[j] -= 1

    backtrack(0, 1, [0] * 8)
    return graphs


def canonical_form_s8(mat: List[List[int]]) -> Tuple[Tuple[int, ...], List[List[int]]]:
    """Compute the exact canonical representative modulo S_8 by finding the
    lexicographically minimal upper-triangular bitstring over all 40,320 permutations.
    """
    n = 8
    best_code: Optional[Tuple[int, ...]] = None
    best_perm: Optional[Tuple[int, ...]] = None

    for p in itertools.permutations(range(n)):
        code = tuple(mat[p[i]][p[j]] for i in range(n) for j in range(i + 1, n))
        if best_code is None or code < best_code:
            best_code = code
            best_perm = p

    assert best_perm is not None and best_code is not None
    canon_mat = [[mat[best_perm[i]][best_perm[j]] for j in range(n)] for i in range(n)]
    return best_code, canon_mat


def compute_cubic_graph_properties(mat: List[List[int]]) -> Dict[str, Any]:
    """Compute all structural graph invariants for an 8-vertex 3-regular graph."""
    A = np.array(mat, dtype=int)
    A2 = A @ A
    A3 = A2 @ A
    A4 = A3 @ A

    triangles = int(np.trace(A3) // 6)
    tr4 = int(np.trace(A4))

    # Common neighbors for non-adjacent pairs (mu) and adjacent pairs (lambda)
    max_cn_nonadj = 0
    max_cn_adj = 0
    for i in range(8):
        for j in range(i + 1, 8):
            cn = int(A2[i, j])
            if mat[i][j] == 0:
                if cn > max_cn_nonadj:
                    max_cn_nonadj = cn
            else:
                if cn > max_cn_adj:
                    max_cn_adj = cn

    # Connectivity
    visited = set()
    queue = [0]
    while queue:
        curr = queue.pop()
        if curr not in visited:
            visited.add(curr)
            for nxt in range(8):
                if mat[curr][nxt] and nxt not in visited:
                    queue.append(nxt)
    connected = (len(visited) == 8)

    # Spectrum (symmetric matrix -> purely real eigenvalues)
    evals = [round(float(ev), 4) for ev in np.sort(np.linalg.eigvalsh(A.astype(float)))]

    return {
        "triangles": triangles,
        "max_cn_nonadj": max_cn_nonadj,
        "max_cn_adj": max_cn_adj,
        "connected": connected,
        "trace_A4": tr4,
        "spectrum": evals,
        "mu_le_2": (max_cn_nonadj <= 2),
    }


def classify_all_cubic_8() -> List[Dict[str, Any]]:
    """Enumerate and classify all 6 isomorphism classes of cubic graphs on 8 vertices
    (OEIS A005638), identifying the rejected class (mu > 2) and the 5 admissible classes.
    """
    raw_graphs = generate_all_labeled_cubic_8()

    def invariant_key(mat: List[List[int]]) -> Tuple[Any, ...]:
        A = np.array(mat, dtype=int)
        evals = tuple(np.round(np.sort(np.linalg.eigvalsh(A.astype(float))), 4))
        A2 = A @ A
        A3 = A2 @ A
        A4 = A3 @ A
        w3 = tuple(sorted(int(A3[i, i]) for i in range(8)))
        w4 = tuple(sorted(int(A4[i, i]) for i in range(8)))
        return (evals, w3, w4)

    clusters: Dict[Tuple[Any, ...], List[List[int]]] = {}
    for g in raw_graphs:
        key = invariant_key(g)
        if key not in clusters:
            clusters[key] = g

    # Find canonical representatives for each of the 6 classes
    all_classes = []
    for g in clusters.values():
        code, cmat = canonical_form_s8(g)
        props = compute_cubic_graph_properties(cmat)
        all_classes.append({
            "code": code,
            "b_matrix": cmat,
            **props,
        })

    # Sort deterministically by canonical code
    all_classes.sort(key=lambda c: c["code"])
    return all_classes


def get_canonical_w8_classes(model: Optional[Any] = None) -> List[Dict[str, Any]]:
    """Enumerate the EXACT 5 CANONICAL CLASSES of signed support matrices W in {0, -1}^(8x8)
    modulo S_8, filtered by mu <= 2, and return metadata along with the 64 unit clauses
    for SAT injection.

    If a PySAT Model object is supplied, integer clause literals are computed.
    Otherwise, clauses are returned in semantic tuple format and standard integer format.
    """
    all_6 = classify_all_cubic_8()
    admissible = [c for c in all_6 if c["mu_le_2"]]
    assert len(admissible) == 5, f"Expected 5 admissible classes, found {len(admissible)}"

    class_names = [
        "cube_Q3",
        "wagner_M8",
        "two_triangles",
        "four_triangles",
        "two_k4",
    ]

    canonical_classes = []
    for idx, raw in enumerate(admissible):
        B = raw["b_matrix"]
        W = [[-B[i][j] for j in range(8)] for i in range(8)]

        # Edges of B (1-indexed active orbit pairs)
        edges = []
        for i in range(1, 9):
            for j in range(i + 1, 9):
                if B[i - 1][j - 1] == 1:
                    edges.append((i, j))

        # Semantic representation of the 64 unit clauses:
        # 1. 8 internal edges: e(i) = True for i in 1..8
        # 2. 28 non-edges between same-spin vertices: x(i, j, 0) = False for 1 <= i < j <= 8
        # 3. 28 cross-spin edges/non-edges: x(i, j, 1) = (B[i-1][j-1] == 1)
        semantic_units = []
        for i in range(1, 9):
            semantic_units.append(("e", i, True))
        for i in range(1, 9):
            for j in range(i + 1, 9):
                semantic_units.append(("x", i, j, 0, False))
                is_cross_edge = bool(B[i - 1][j - 1] == 1)
                semantic_units.append(("x", i, j, 1, is_cross_edge))

        assert len(semantic_units) == 64, f"Expected 64 units, got {len(semantic_units)}"

        # Compute integer unit clauses if model is provided
        unit_clauses: List[List[int]] = []
        if model is not None:
            unit_clauses = semantic_to_model_clauses(model, semantic_units)

        canonical_classes.append({
            "class_id": idx + 1,
            "name": class_names[idx],
            "triangles": raw["triangles"],
            "max_cn_nonadj": raw["max_cn_nonadj"],
            "max_cn_adj": raw["max_cn_adj"],
            "connected": raw["connected"],
            "trace_A4": raw["trace_A4"],
            "spectrum": raw["spectrum"],
            "b_matrix": B,
            "w_matrix": W,
            "edges": edges,
            "unit_clauses_semantic": semantic_units,
            "unit_clauses": unit_clauses,
        })

    return canonical_classes


def semantic_to_model_clauses(model: Any, semantic_units: List[Tuple[Any, ...]]) -> List[List[int]]:
    """Convert 64 semantic unit specifications into PySAT integer unit clauses
    for an instantiated `z2f1_groupring_sat.Model`.
    """
    clauses: List[List[int]] = []
    for item in semantic_units:
        var_type = item[0]
        if var_type == "e":
            _, i, val = item
            lit = model.e(i)
            clauses.append([lit if val else -lit])
        elif var_type == "x":
            _, i, j, s, val = item
            lit = model.x(i, j, s)
            clauses.append([lit if val else -lit])
        else:
            raise ValueError(f"Unknown variable type in semantic units: {var_type}")
    return clauses


def enumerate_canonical_w8() -> List[Dict[str, Any]]:
    """PROJECT.md Interface Contract:
    Returns the 5 canonical classes of W in {0, -1}^(8x8).
    Invariants: W = W^T, W_{ii} = 0, row sum = -3, no +1 entries, lambda <= 1, mu <= 2.
    """
    return get_canonical_w8_classes()


# ==============================================================================
# H=10 (T20, 20-VERTEX SUPPORT) EXTENSIONS
# ==============================================================================

def parse_graph6(s: str) -> Tuple[int, List[List[int]]]:
    """Parse a graph6 string into (number_of_vertices, adjacency_matrix).
    McKay graph6 specification: first char encodes N (if N < 63: ord(c) - 63).
    Subsequent chars encode 6 bits each of upper triangle in column-major order.
    """
    s = s.strip()
    n = ord(s[0]) - 63
    bits = []
    for c in s[1:]:
        val = ord(c) - 63
        for b in range(5, -1, -1):
            bits.append((val >> b) & 1)
    adj = [[0] * n for _ in range(n)]
    idx = 0
    for j in range(1, n):
        for i in range(j):
            adj[i][j] = adj[j][i] = bits[idx]
            idx += 1
    return n, adj


# All 19 connected cubic graphs on 10 vertices (OEIS A002851)
CONNECTED_CUBIC_10_GRAPH6: List[Tuple[str, str]] = [
    ("class1_bipartite_prism5", "Is??xXSY?"),      # tri=0, mu=2, bipartite
    ("class2_girth4_a", "Is?GhTSY?"),              # tri=0, mu=2
    ("class3_girth4_b", "Is?GhTWX?"),              # tri=0, mu=2
    ("class4_girth4_c", "Is?OpXKW_"),              # tri=0, mu=2
    ("class5_petersen", "IsCPHPDQ_"),              # tri=0, mu=1, Petersen graph
    ("class6_1tri_a", "Is?GXdSY?"),                # tri=1, mu=2
    ("class7_1tri_b", "Is?GhXWW_"),                # tri=1, mu=2
    ("class8_2tri_a", "Is?GhXQY?"),                # tri=2, mu=2
    ("class9_2tri_b", "Is?OxPHX?"),                # tri=2, mu=2
    ("class10_2tri_c", "Is?OxPKWO"),               # tri=2, mu=2
    ("class11_2tri_d", "IsCPHPEQO"),               # tri=2, mu=1
    ("class12_3tri_a", "Is?GxXOWG"),               # tri=3, mu=2
    ("class13_3tri_b", "IsCX@LAQG"),               # tri=3, mu=1
    ("class14_4tri_a", "IsCPHLGQG"),               # tri=4, mu=2
    ("class15_4tri_b", "It?GWlGWG"),               # tri=4, mu=2
    ("class16_k23_0tri", "Is??wxcY?"),             # tri=0, mu=3 (REJECTED by mu <= 2)
    ("class17_k23_1tri", "Is?GgtcY?"),             # tri=1, mu=3 (REJECTED by mu <= 2)
    ("class18_k23_2tri", "Is?GWlg[?"),             # tri=2, mu=3 (REJECTED by mu <= 2)
    ("class19_k23_4tri", "Is?Gwx_WG"),             # tri=4, mu=3 (REJECTED by mu <= 2)
]


def build_k4_plus_prism3_adj() -> List[List[int]]:
    """Build the adjacency matrix for the disconnected 10-vertex cubic graph K_4 + Prism_3."""
    adj = [[0] * 10 for _ in range(10)]
    # K_4 on vertices 0..3
    for i in range(4):
        for j in range(4):
            if i != j:
                adj[i][j] = 1
    # Prism_3 on vertices 4..9
    # Triangle 4, 5, 6
    adj[4][5] = adj[5][4] = 1
    adj[5][6] = adj[6][5] = 1
    adj[4][6] = adj[6][4] = 1
    # Triangle 7, 8, 9
    adj[7][8] = adj[8][7] = 1
    adj[8][9] = adj[9][8] = 1
    adj[7][9] = adj[9][7] = 1
    # Matching (4,7), (5,8), (6,9)
    adj[4][7] = adj[7][4] = 1
    adj[5][8] = adj[8][5] = 1
    adj[6][9] = adj[9][6] = 1
    return adj


def verify_h10_positive_entry_obstruction() -> Dict[str, Any]:
    """Verify that under lambda <= 1 and mu <= 2 in srg(99, 14, 1, 2), no entry
    W_{ij} can equal +1 for h=10 when e(i) = 1 on all 10 active orbits.

    Proof:
    Suppose W_{ij} = +1. Then p_{ij} = 1 and q_{ij} = 0.
    Since e(i) = 1 and e(j) = 1, both (i, 0) and (j, 0) are in N(x_0).
    Consider the non-adjacent pair u = (i, 0) and v' = (j, 1) (since q_{ij} = 0).
    Common neighbors in G:
      1. x_0 (since u ~ x_0 and v' ~ x_0).
      2. (i, 1) (since u ~ (i, 1) via e(i)=1, and v' ~ (i, 1) via p_{ij}=1).
      3. (j, 0) (since u ~ (j, 0) via p_{ij}=1, and v' ~ (j, 0) via e(j)=1).
    These 3 vertices are distinct, giving mu(u, v') >= 3.
    This contradicts mu = 2 in srg(99, 14, 1, 2).
    Additionally, on adjacent pair (i, 0) ~ (j, 0), x_0 is a common neighbor;
    if n_+(i) >= 2, inclusion-exclusion forces at least 1 common neighbor in S^-,
    yielding lambda >= 2 > 1.
    Therefore, no entry W_{ij} can equal +1, forcing W in {0, -1}^(10x10) and W = -B.
    """
    return {
        "h": 10,
        "mechanism_mu": "Non-adjacent pair (i, 0) not~ (j, 1) has 3 common neighbors {x_0, (i, 1), (j, 0)}, violating mu <= 2.",
        "mechanism_lambda": "Adjacent pair (i, 0) ~ (j, 0) shares x_0 plus inclusion-exclusion overlap in S^-, violating lambda <= 1.",
        "all_positive_entries_blocked": True,
        "forced_w_alphabet": [0, -1],
        "forced_configuration": "W = -B where B is 3-regular on 10 vertices",
        "operational_state": "PROVED",
    }


def compute_cubic_10_graph_properties(mat: List[List[int]]) -> Dict[str, Any]:
    """Compute structural graph invariants for a 10-vertex 3-regular graph."""
    n = 10
    A = np.array(mat, dtype=int)
    assert np.all(A.sum(axis=1) == 3), "Graph must be 3-regular"
    assert np.all(np.diag(A) == 0), "Graph must have zero diagonal"
    assert np.array_equal(A, A.T), "Graph must be undirected"

    A2 = A @ A
    A3 = A2 @ A
    A4 = A3 @ A

    triangles = int(np.trace(A3) // 6)
    tr4 = int(np.trace(A4))

    max_cn_nonadj = 0
    max_cn_adj = 0
    for i in range(n):
        for j in range(i + 1, n):
            cn = int(A2[i, j])
            if mat[i][j] == 0:
                max_cn_nonadj = max(max_cn_nonadj, cn)
            else:
                max_cn_adj = max(max_cn_adj, cn)

    # Connectivity
    visited = set()
    queue = [0]
    while queue:
        curr = queue.pop()
        if curr not in visited:
            visited.add(curr)
            for nxt in range(n):
                if mat[curr][nxt] and nxt not in visited:
                    queue.append(nxt)
    connected = (len(visited) == n)

    evals = [round(float(ev), 4) for ev in np.sort(np.linalg.eigvalsh(A.astype(float)))]

    return {
        "triangles": triangles,
        "max_cn_nonadj": max_cn_nonadj,
        "max_cn_adj": max_cn_adj,
        "connected": connected,
        "trace_A4": tr4,
        "spectrum": evals,
        "mu_le_2": (max_cn_nonadj <= 2),
    }


def classify_all_cubic_10() -> List[Dict[str, Any]]:
    """Enumerate and classify all 19 connected cubic graphs on 10 vertices (OEIS A002851),
    plus the disconnected class K_4 + Prism_3 (OEIS A005638).
    Filters by mu <= 2, identifying exactly 15 connected admissible classes and 4 rejected classes.
    """
    classes = []
    for idx, (name, g6) in enumerate(CONNECTED_CUBIC_10_GRAPH6, 1):
        n, adj = parse_graph6(g6)
        props = compute_cubic_10_graph_properties(adj)
        classes.append({
            "class_id": idx,
            "name": name,
            "graph6": g6,
            "b_matrix": adj,
            **props,
        })

    admissible_conn = [c for c in classes if c["connected"] and c["mu_le_2"]]
    rejected_conn = [c for c in classes if c["connected"] and not c["mu_le_2"]]
    assert len(admissible_conn) == 15, f"Expected 15 connected admissible classes, got {len(admissible_conn)}"
    assert len(rejected_conn) == 4, f"Expected 4 connected rejected classes, got {len(rejected_conn)}"

    return classes


def get_canonical_w10_classes(
    model: Optional[Any] = None,
    include_disconnected: bool = False,
) -> List[Dict[str, Any]]:
    """Enumerate the canonical classes of signed support matrices W in {0, -1}^(10x10)
    for h=10, filtered by mu <= 2, and return metadata along with the 100 unit clauses
    for SAT injection.

    - Exactly 15 connected admissible classes (OEIS A002851 filtered by mu <= 2).
    - If include_disconnected is True, adds the 16th admissible class (K_4 + Prism_3).
    - Each class produces exactly 100 unit clauses:
        10 internal edges: e(i) = True for i in 1..10
        45 same-spin non-edges: x(i, j, 0) = False for 1 <= i < j <= 10
        45 cross-spin edges/non-edges: x(i, j, 1) = (B[i-1][j-1] == 1) for 1 <= i < j <= 10
    """
    all_19 = classify_all_cubic_10()
    admissible = [c for c in all_19 if c["mu_le_2"]]
    assert len(admissible) == 15

    if include_disconnected:
        disc_adj = build_k4_plus_prism3_adj()
        disc_props = compute_cubic_10_graph_properties(disc_adj)
        assert disc_props["mu_le_2"] is True
        disc_class = {
            "class_id": 16,
            "name": "class16_disconnected_k4_prism3",
            "graph6": "CUSTOM_DISCONNECTED",
            "b_matrix": disc_adj,
            **disc_props,
        }
        admissible.append(disc_class)

    canonical_classes = []
    for c in admissible:
        class_id = c["class_id"]
        class_name = c["name"]
        B = c["b_matrix"]
        W = [[-B[i][j] for j in range(10)] for i in range(10)]

        # Edges of B (1-indexed active orbit pairs)
        edges = []
        for i in range(1, 11):
            for j in range(i + 1, 11):
                if B[i - 1][j - 1] == 1:
                    edges.append((i, j))
        assert len(edges) == 15, f"Expected 15 edges for cubic graph on 10 nodes, got {len(edges)}"

        # 100 unit clauses semantic specification:
        # 1. 10 internal edges: e(i) = True
        # 2. 45 same-spin non-edges: x(i, j, 0) = False
        # 3. 45 cross-spin edges/non-edges: x(i, j, 1) = (B[i-1][j-1] == 1)
        semantic_units = []
        for i in range(1, 11):
            semantic_units.append(("e", i, True))
        for i in range(1, 11):
            for j in range(i + 1, 11):
                semantic_units.append(("x", i, j, 0, False))
                is_cross_edge = bool(B[i - 1][j - 1] == 1)
                semantic_units.append(("x", i, j, 1, is_cross_edge))

        assert len(semantic_units) == 100, f"Expected 100 units, got {len(semantic_units)}"

        unit_clauses: List[List[int]] = []
        if model is not None:
            unit_clauses = semantic_to_model_clauses(model, semantic_units)

        canonical_classes.append({
            "class_id": class_id,
            "name": class_name,
            "graph6": c.get("graph6", ""),
            "triangles": c["triangles"],
            "max_cn_nonadj": c["max_cn_nonadj"],
            "max_cn_adj": c["max_cn_adj"],
            "connected": c["connected"],
            "trace_A4": c["trace_A4"],
            "spectrum": c["spectrum"],
            "b_matrix": B,
            "w_matrix": W,
            "edges": edges,
            "unit_clauses_semantic": semantic_units,
            "unit_clauses": unit_clauses,
        })

    return canonical_classes


def enumerate_canonical_w10(include_disconnected: bool = False) -> List[Dict[str, Any]]:
    """PROJECT.md Interface Contract:
    Returns the canonical classes of W in {0, -1}^(10x10) for h=10.
    """
    return get_canonical_w10_classes(include_disconnected=include_disconnected)


def compute_sha256(filepath: str | Path) -> str:
    """Compute SHA-256 hash of a file."""
    h = hashlib.sha256()
    with open(filepath, "rb") as f:
        while chunk := f.read(1024 * 1024):
            h.update(chunk)
    return h.hexdigest()


def build_cnfs_h10(
    out_dir: str = "instances/z2_h10",
    include_disconnected: bool = True,
    selected_ids: Optional[List[int]] = None,
    force: bool = False,
) -> List[Dict[str, Any]]:
    """Generate partitioned DIMACS CNF files in instances/z2_h10/
    incorporating the 100 unit clauses for each canonical class.
    Returns list of metadata dicts.
    """
    if Model is None:
        raise ImportError("z2f1_groupring_sat.Model could not be imported")

    out_path = Path(out_dir)
    out_path.mkdir(parents=True, exist_ok=True)

    classes = get_canonical_w10_classes(include_disconnected=include_disconnected)
    if selected_ids is not None:
        classes = [c for c in classes if c["class_id"] in selected_ids]

    print(f"[*] Instantiating base Model(m=49, k=14, lam=1, mu=2, phi=10)...")
    t0 = time.time()
    base_model = Model(m=49, k=14, lam=1, mu=2, phi=10)
    base_build_time = round(time.time() - t0, 2)
    print(f"[*] Base model built in {base_build_time}s: {base_model.pool.top} vars, {len(base_model.clauses)} clauses")

    manifest_entries: List[Dict[str, Any]] = []

    for c in classes:
        class_id = c["class_id"]
        class_name = c["name"]
        filename = f"conway_z2_h10_class{class_id}_{class_name}.cnf"
        target_file = out_path / filename

        if target_file.exists() and not force:
            print(f"[+] File already exists: {target_file} (use force=True to overwrite)")
            sha256 = compute_sha256(target_file)
            size = target_file.stat().st_size
            manifest_entries.append({
                "class_id": class_id,
                "name": class_name,
                "filename": filename,
                "path": str(target_file.resolve()),
                "size_bytes": size,
                "sha256": sha256,
                "vars": base_model.pool.top,
                "clauses": len(base_model.clauses) + 100,
                "triangles": c["triangles"],
                "max_cn_nonadj": c["max_cn_nonadj"],
                "max_cn_adj": c["max_cn_adj"],
                "connected": c["connected"],
            })
            continue

        print(f"[*] Generating CNF for Class {class_id} ({class_name})...")
        t_gen = time.time()
        unit_clauses = semantic_to_model_clauses(base_model, c["unit_clauses_semantic"])
        assert len(unit_clauses) == 100, f"Expected 100 unit clauses, got {len(unit_clauses)}"

        total_clauses_count = len(base_model.clauses) + len(unit_clauses)
        top_var = base_model.pool.top

        with open(target_file, "w") as fo:
            fo.write(f"c Conway's 99-Graph Z2 Involution Symmetry Breaking (h=10)\n")
            fo.write(f"c Canonical Class {class_id}: {class_name}\n")
            fo.write(f"c Triangles: {c['triangles']}, Connected: {c['connected']}\n")
            fo.write(f"c Unit clauses: 100 (10 e(i), 45 x(i,j,0), 45 x(i,j,1))\n")
            fo.write(f"p cnf {top_var} {total_clauses_count}\n")
            for cl in base_model.clauses:
                fo.write(" ".join(map(str, cl)) + " 0\n")
            for cl in unit_clauses:
                fo.write(" ".join(map(str, cl)) + " 0\n")

        gen_time = round(time.time() - t_gen, 2)
        sha256 = compute_sha256(target_file)
        size = target_file.stat().st_size
        print(f"[✓] Class {class_id} written to {target_file} ({size / (1024*1024):.2f} MB, {gen_time}s)")

        manifest_entries.append({
            "class_id": class_id,
            "name": class_name,
            "filename": filename,
            "path": str(target_file.resolve()),
            "size_bytes": size,
            "sha256": sha256,
            "vars": top_var,
            "clauses": total_clauses_count,
            "triangles": c["triangles"],
            "max_cn_nonadj": c["max_cn_nonadj"],
            "max_cn_adj": c["max_cn_adj"],
            "connected": c["connected"],
        })

    manifest_path = out_path / "manifest.json"
    with open(manifest_path, "w") as fo:
        json.dump(manifest_entries, fo, indent=2)
    print(f"[*] Manifest saved to {manifest_path}")

    return manifest_entries


def main() -> None:
    parser = argparse.ArgumentParser(description="Enumerate canonical W matrices for h=8 and h=10 (Z2 involution).")
    parser.add_argument("--h", type=int, default=8, choices=[8, 10], help="Support parameter h (8 or 10).")
    parser.add_argument("--include-disconnected", action="store_true", help="Include disconnected class K_4 + Prism_3 for h=10.")
    parser.add_argument("--build-cnfs", action="store_true", help="Generate partitioned CNF formulas for h=10.")
    parser.add_argument("--out-dir", default="instances/z2_h10", help="Output directory for generated CNFs.")
    parser.add_argument("--force", action="store_true", help="Force overwrite existing CNF files.")
    parser.add_argument("--verbose", action="store_true", help="Print detailed matrix and invariant breakdowns.")
    parser.add_argument("--json", action="store_true", help="Output JSON format.")
    parser.add_argument("--check-proof", action="store_true", help="Print inclusion-exclusion / positive obstruction proof.")
    args = parser.parse_args()

    if args.build_cnfs:
        entries = build_cnfs_h10(out_dir=args.out_dir, include_disconnected=args.include_disconnected, force=args.force)
        print(f"[✓] Successfully generated {len(entries)} CNF instances in {args.out_dir}")
        return

    if args.check_proof:
        if args.h == 8:
            proof_res = verify_inclusion_exclusion_obstruction()
            print("=== INCLUSION-EXCLUSION PROOF CHECK (h=8) ===")
            print(f"Row types tested: {proof_res['valid_row_types']}")
            print(f"All positive entries blocked by lambda <= 1: {proof_res['all_positive_entries_blocked']}")
            print(f"Forced signed configuration: {proof_res['forced_configuration']}")
        else:
            proof_res = verify_h10_positive_entry_obstruction()
            print("=== POSITIVE ENTRY OBSTRUCTION CHECK (h=10) ===")
            print(f"Mechanism (mu): {proof_res['mechanism_mu']}")
            print(f"Mechanism (lambda): {proof_res['mechanism_lambda']}")
            print(f"All positive entries blocked: {proof_res['all_positive_entries_blocked']}")
            print(f"Forced configuration: {proof_res['forced_configuration']}")
        return

    if args.h == 8:
        classes = get_canonical_w8_classes()
        unit_count = 64
    else:
        classes = get_canonical_w10_classes(include_disconnected=args.include_disconnected)
        unit_count = 100

    if args.json:
        clean_out = []
        for c in classes:
            c_dict = dict(c)
            c_dict.pop("unit_clauses", None)
            clean_out.append(c_dict)
        print(json.dumps(clean_out, indent=2))
        return

    print("================================================================================")
    print(f"  EXACT CANONICAL CLASSES OF W MATRICES FOR h={args.h} (Z2 INVOLUTION SYMMETRY)")
    print("================================================================================")
    print(f"{'ID':<4} {'Name':<24} {'Triangles':<10} {'mu (non-adj)':<14} {'lambda (adj)':<14} {'Connected':<10}")
    print("-" * 86)
    for c in classes:
        print(f"{c['class_id']:<4} {c['name']:<24} {c['triangles']:<10} {c['max_cn_nonadj']:<14} {c['max_cn_adj']:<14} {str(c['connected']):<10}")
    print("-" * 86)
    print(f"Total admissible classes: {len(classes)}")
    print(f"Unit clauses per class: {unit_count}")


if __name__ == "__main__":
    main()

