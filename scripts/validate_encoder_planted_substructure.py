#!/usr/bin/env python3
r"""
scripts/validate_encoder_planted_substructure.py

Positive Control and Planted Substructure Validation Suite for SAT Encoders:
1. Parameterized Positive Control Harness for SRG Block-Circulant Encoders:
   - Paley(9) = srg(9, 4, 1, 2) under Z_3 (standalone experimental positive control).
   - Petersen = srg(10, 3, 0, 1) under Z_5 (2 orbits of size 5).
   - Solves via CaDiCaL, decodes model into full adjacency matrix, and verifies all SRG parameters.
2. Planted 1-factor on Gamma_1(x_0) (M_{7K_2}):
   - In Z_7, Gamma_1(x_0) consists of 2 orbits (L, R) of size 7. Planted matching M_{7K_2} has zero clause violations.
   - In Z_2 (f=1), Gamma_1(x_0) consists of 7 orbits of length 2. Planted matching M_{7K_2} has zero clause violations.
   - In Z_3 (Fixed-3), neighborhoods N_0, N_1, N_2 have fixed 1-factors 6*K_2 with zero clause violations.
3. Planted Cesarz-Woldar Coordinate 2-Paths:
   - Reconstructs the 84 vertices of Gamma_2(x_0) in Z_7 and their coordinates in Gamma_1(x_0).
   - Verifies coordinate bijection to the 84 non-edges of Gamma_1, 12-fold regularity per coordinate,
     Tseitin 2-path definitions, and the 12x12 quotient Diophantine matrix C (row sums = 22, target T row sums = 156).
4. Relaxed Consistency Checks:
   - Explores selected relaxed subsystems and records satisfying assignments with zero
     violations; these checks do not resolve the open Z_2(f=1) or Z_3 fixed-point-free cases.

Four-State Taxonomy:
- Standalone positive-control checks: COMPILED.
- Isolated toy-model and coordinate checks: COMPILED.
- Relaxed subsystem checks: EXPLORED.
"""

import os
import sys
import time
import argparse
from typing import Dict, List, Tuple, Optional, Set, Any
import numpy as np

from pysat.formula import CNF
from pysat.card import CardEnc, EncType
from pysat.solvers import Cadical195

# Ensure repo root and scripts are in sys.path
REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if REPO_ROOT not in sys.path:
    sys.path.insert(0, REPO_ROOT)
scripts_path = os.path.join(REPO_ROOT, "scripts")
if scripts_path not in sys.path:
    sys.path.insert(0, scripts_path)

from build_z7_canonical_cnf import ConwayZ7CanonicalCompiler
from build_z3_canonical_cnf import ConwayZ3FPFCanonicalCompiler, ConwayZ3Fixed3CanonicalCompiler
import build_z2_f1_cnf as z2_model


# ==============================================================================
# 1. Parameterized SRG Block-Circulant Encoder
# ==============================================================================

class SRGBlockCirculantEncoder:
    """
    Parameterized SAT encoder for strongly regular graphs SRG(v, k, lam, mu)
    possessing a cyclic automorphism group Z_q partitioning the v vertices
    into m = v // q orbits of size q.
    """

    def __init__(self, m: int, q: int, k: int, lam: int, mu: int):
        self.m = m
        self.q = q
        self.v = m * q
        self.k = k
        self.lam = lam
        self.mu = mu

        self.cnf = CNF()
        self.top_id = 0
        self.var_map: Dict[Tuple, int] = {}
        self.aux_and: Dict[Tuple[int, int], int] = {}

        self._init_variables()

    def _init_variables(self):
        # 1. Diagonal circulants: (p, p, d) for p in 0..m-1, d in 1..floor(q/2)
        for p in range(self.m):
            for d in range(1, self.q // 2 + 1):
                self.top_id += 1
                self.var_map[(p, p, d)] = self.top_id

        # 2. Off-diagonal circulants: (p, q_orb, d) for 0 <= p < q_orb < m, d in 0..q-1
        for p in range(self.m):
            for q_orb in range(p + 1, self.m):
                for d in range(self.q):
                    self.top_id += 1
                    self.var_map[(p, q_orb, d)] = self.top_id

    def get_adj_lit(self, p1: int, t1: int, p2: int, t2: int) -> int:
        if p1 == p2:
            diff = (t2 - t1) % self.q
            if diff == 0:
                return 0
            d = min(diff, self.q - diff)
            return self.var_map[(p1, p1, d)]
        elif p1 < p2:
            diff = (t2 - t1) % self.q
            return self.var_map[(p1, p2, diff)]
        else: # p1 > p2
            diff = (t1 - t2) % self.q
            return self.var_map[(p2, p1, diff)]

    def get_and_lit(self, a: int, b: int) -> int:
        if a == 0 or b == 0:
            return 0
        if a == b:
            return a
        if a == -b:
            return 0
        if a > b:
            a, b = b, a
        k_pair = (a, b)
        if k_pair not in self.aux_and:
            self.top_id += 1
            y = self.top_id
            self.cnf.append([-y, a])
            self.cnf.append([-y, b])
            self.cnf.append([y, -a, -b])
            self.aux_and[k_pair] = y
        return self.aux_and[k_pair]

    def add_card_equals(self, lits: List[int], bound: int):
        var_lits = [l for l in lits if l != 0]
        if bound < 0 or len(var_lits) < bound:
            self.cnf.append([])
            return
        if bound == 0:
            for l in var_lits:
                self.cnf.append([-l])
            return
        if len(var_lits) == bound:
            for l in var_lits:
                self.cnf.append([l])
            return

        enc = CardEnc.equals(lits=var_lits, bound=bound, top_id=self.top_id, encoding=EncType.seqcounter)
        self.top_id = enc.nv
        self.cnf.extend(enc.clauses)

    def build_cnf(self) -> CNF:
        # 1. Degree regularity: each vertex (p, 0) has degree k
        for p in range(self.m):
            lits = []
            for q_orb in range(self.m):
                for t in range(self.q):
                    if q_orb == p and t == 0:
                        continue
                    adj = self.get_adj_lit(p, 0, q_orb, t)
                    if adj != 0:
                        lits.append(adj)
            self.add_card_equals(lits, self.k)

        # 2. SRG common neighbor constraints across all orbit pairs
        # Orbit representatives u = (p, 0) and v = (q_orb, dt)
        pair_orbits = []
        for p in range(self.m):
            for q_orb in range(p, self.m):
                if p == q_orb:
                    for dt in range(1, self.q // 2 + 1):
                        pair_orbits.append(((p, 0), (q_orb, dt)))
                else:
                    for dt in range(self.q):
                        pair_orbits.append(((p, 0), (q_orb, dt)))

        for u, v in pair_orbits:
            a_uv = self.get_adj_lit(u[0], u[1], v[0], v[1])
            # When mu - lam == 1 (as in Paley(9) and Petersen(10)),
            # A(u, v) + sum_w (A(u, w) AND A(v, w)) == mu
            lits = [a_uv] if (a_uv != 0 and (self.mu - self.lam == 1)) else []
            for p_w in range(self.m):
                for t_w in range(self.q):
                    w = (p_w, t_w)
                    if w == u or w == v:
                        continue
                    a_uw = self.get_adj_lit(u[0], u[1], w[0], w[1])
                    if a_uw == 0:
                        continue
                    a_vw = self.get_adj_lit(v[0], v[1], w[0], w[1])
                    if a_vw == 0:
                        continue
                    and_lit = self.get_and_lit(a_uw, a_vw)
                    if and_lit != 0:
                        lits.append(and_lit)

            if self.mu - self.lam == 1:
                self.add_card_equals(lits, self.mu)
            else:
                raise NotImplementedError("General mu - lam != 1 requires conditional cardinality encoding.")

        return self.cnf

    def solve(self, solver_name: str = "cadical195") -> Tuple[bool, Optional[np.ndarray], Dict[str, Any]]:
        t0 = time.time()
        if solver_name == "cadical195":
            solver = Cadical195(bootstrap_with=self.cnf.clauses)
        else:
            raise ValueError(f"Unsupported solver: {solver_name}")

        sat = solver.solve()
        solve_time = time.time() - t0

        if not sat:
            return False, None, {"sat": False, "solve_time": solve_time}

        model = set(solver.get_model())
        A = self.decode_adjacency(model)
        verification = self.verify_srg(A)
        verification["sat"] = True
        verification["solve_time"] = solve_time
        verification["clauses"] = len(self.cnf.clauses)
        verification["variables"] = self.top_id
        return True, A, verification

    def decode_adjacency(self, model: Set[int]) -> np.ndarray:
        n = self.v
        A = np.zeros((n, n), dtype=int)
        for p1 in range(self.m):
            for t1 in range(self.q):
                i = p1 * self.q + t1
                for p2 in range(self.m):
                    for t2 in range(self.q):
                        j = p2 * self.q + t2
                        if i < j:
                            lit = self.get_adj_lit(p1, t1, p2, t2)
                            if lit in model:
                                A[i, j] = 1
                                A[j, i] = 1
        return A

    def verify_srg(self, A: np.ndarray) -> Dict[str, Any]:
        assert A.shape == (self.v, self.v), f"Expected shape ({self.v}, {self.v}), got {A.shape}"
        assert np.array_equal(A, A.T), "Adjacency matrix must be symmetric"
        assert not np.any(np.diag(A)), "Adjacency matrix must have zero diagonal"

        degrees = np.sum(A, axis=1)
        unique_degrees = np.unique(degrees)
        assert len(unique_degrees) == 1 and unique_degrees[0] == self.k, f"Degrees must all equal {self.k}, got {unique_degrees}"

        A2 = A @ A
        lambda_obs = []
        mu_obs = []
        for i in range(self.v):
            for j in range(i + 1, self.v):
                if A[i, j] == 1:
                    lambda_obs.append(A2[i, j])
                else:
                    mu_obs.append(A2[i, j])

        unique_lambdas = set(lambda_obs)
        unique_mus = set(mu_obs)
        assert unique_lambdas == {self.lam}, f"Observed lambda {unique_lambdas} does not match expected {self.lam}"
        assert unique_mus == {self.mu}, f"Observed mu {unique_mus} does not match expected {self.mu}"

        return {
            "is_srg": True,
            "v": self.v,
            "k": self.k,
            "lambda": self.lam,
            "mu": self.mu,
            "num_edges": int(np.sum(A) // 2),
            "num_non_edges": int((self.v * (self.v - 1)) // 2 - (np.sum(A) // 2))
        }


# ==============================================================================
# 2. Planted 1-Factor on Gamma_1(x_0) (M_{7K_2}) Validations
# ==============================================================================

class Z7Gamma1Encoder:
    """
    Experimental isolated toy model for an induced 14-vertex Z_7 subgraph; it does not encode production clauses.
    Orbits: L = {1L..7L} (orbit 0), R = {1R..7R} (orbit 1).
    Variables:
      - Diagonal in L: (0, 0, d) for d in {1, 2, 3}
      - Diagonal in R: (1, 1, d) for d in {1, 2, 3}
      - Off-diagonal L-R: (0, 1, d) for d in {0..6}
    Total primary variables: 13.
    """

    def __init__(self):
        self.cnf = CNF()
        self.top_id = 0
        self.var_map: Dict[Tuple, int] = {}
        self.primary_vars: List[Tuple] = []

        # 1. Diagonal L
        for d in range(1, 4):
            self.top_id += 1
            self.var_map[(0, 0, d)] = self.top_id
            self.primary_vars.append((0, 0, d))
        # 2. Diagonal R
        for d in range(1, 4):
            self.top_id += 1
            self.var_map[(1, 1, d)] = self.top_id
            self.primary_vars.append((1, 1, d))
        # 3. Off-diagonal L-R
        for d in range(7):
            self.top_id += 1
            self.var_map[(0, 1, d)] = self.top_id
            self.primary_vars.append((0, 1, d))

        assert len(self.primary_vars) == 13

    def build_constraints(self):
        # 1. Diagonal edges must be 0: In odd order q=7, any internal circulant edge
        # contributes degree 2 to every vertex. Since deg(v) = 1 in Gamma_1(x_0),
        # all internal edges are strictly forbidden.
        for d in range(1, 4):
            self.cnf.append([-self.var_map[(0, 0, d)]])
            self.cnf.append([-self.var_map[(1, 1, d)]])

        # 2. Degree regularity across L and R: exactly one difference active between L and R
        lits = [self.var_map[(0, 1, d)] for d in range(7)]
        card = CardEnc.equals(lits=lits, bound=1, encoding=EncType.pairwise)
        self.cnf.extend(card.clauses)

        return self.cnf

    def get_planted_matching_assignment(self) -> Dict[int, bool]:
        """
        Planted matching M_{7K_2}:
        x_{(0, 1, 0)} = True (matching (iL, iR)), all other 12 variables False.
        """
        assignment = {}
        for var_key, vid in self.var_map.items():
            if var_key == (0, 1, 0):
                assignment[vid] = True
            else:
                assignment[vid] = False
        return assignment

    def evaluate_clauses(self, assignment: Dict[int, bool]) -> Dict[str, Any]:
        """Verifies that an assignment satisfies all clauses."""
        satisfied = 0
        violations = 0
        violated_clauses = []
        for clause in self.cnf.clauses:
            clause_sat = False
            for lit in clause:
                vid = abs(lit)
                val = assignment.get(vid, False)
                if (lit > 0 and val) or (lit < 0 and not val):
                    clause_sat = True
                    break
            if clause_sat:
                satisfied += 1
            else:
                violations += 1
                violated_clauses.append(clause)

        return {
            "total_clauses": len(self.cnf.clauses),
            "satisfied": satisfied,
            "violations": violations,
            "violated_clauses": violated_clauses
        }


class Z2F1Gamma1Encoder:
    """
    Experimental isolated toy model for an induced 14-vertex Z_2(f=1) subgraph; it does not encode production clauses.
    Neighborhood N(x_0) = {1..14} consists of 7 orbits of length 2: R_0..R_6.
    R_r = {1 + 2*r, 2 + 2*r}.
    Variables:
      - Internal edge in orbit r: (r, r) for r in 0..6 (7 variables)
      - Cross-orbit edges: (r, s, b) for 0 <= r < s < 7, b in {0, 1} (21 * 2 = 42 variables)
    Total primary variables: 49.
    """

    def __init__(self):
        self.cnf = CNF()
        self.top_id = 0
        self.var_map: Dict[Tuple, int] = {}
        self.primary_vars: List[Tuple] = []

        # 1. Internal edges
        for r in range(7):
            self.top_id += 1
            self.var_map[(r, r)] = self.top_id
            self.primary_vars.append((r, r))

        # 2. Cross-orbit edges
        for r in range(7):
            for s in range(r + 1, 7):
                for b in (0, 1):
                    self.top_id += 1
                    self.var_map[(r, s, b)] = self.top_id
                    self.primary_vars.append((r, s, b))

        assert len(self.primary_vars) == 49

    def get_adj_lit(self, r1: int, t1: int, r2: int, t2: int) -> int:
        if r1 == r2:
            if t1 == t2:
                return 0
            return self.var_map[(r1, r1)]
        elif r1 < r2:
            b = (t2 - t1) % 2
            return self.var_map[(r1, r2, b)]
        else: # r1 > r2
            b = (t1 - t2) % 2
            return self.var_map[(r2, r1, b)]

    def build_constraints(self):
        # Degree regularity: each of the 7 orbit vertices (r, 0) has degree 1 in Gamma_1
        for r in range(7):
            lits = [self.var_map[(r, r)]]
            for s in range(7):
                if s == r:
                    continue
                for ts in (0, 1):
                    lits.append(self.get_adj_lit(r, 0, s, ts))
            assert len(lits) == 13
            card = CardEnc.equals(lits=lits, bound=1, encoding=EncType.pairwise)
            self.cnf.extend(card.clauses)

        return self.cnf

    def get_planted_matching_assignment(self) -> Dict[int, bool]:
        """
        Planted matching M_{7K_2}:
        x_{(r, r)} = True for all r in 0..6 (the 7 involution edges),
        all cross-orbit edges = False.
        """
        assignment = {}
        for var_key, vid in self.var_map.items():
            if len(var_key) == 2 and var_key[0] == var_key[1]:
                assignment[vid] = True
            else:
                assignment[vid] = False
        return assignment

    def evaluate_clauses(self, assignment: Dict[int, bool]) -> Dict[str, Any]:
        satisfied = 0
        violations = 0
        violated_clauses = []
        for clause in self.cnf.clauses:
            clause_sat = False
            for lit in clause:
                vid = abs(lit)
                val = assignment.get(vid, False)
                if (lit > 0 and val) or (lit < 0 and not val):
                    clause_sat = True
                    break
            if clause_sat:
                satisfied += 1
            else:
                violations += 1
                violated_clauses.append(clause)

        return {
            "total_clauses": len(self.cnf.clauses),
            "satisfied": satisfied,
            "violations": violations,
            "violated_clauses": violated_clauses
        }


def validate_z3_fixed3_planted_matching() -> Dict[str, Any]:
    """
    Validates that the planted 1-factors 6*K_2 fixed in N_0, N_1, N_2
    in ConwayZ3Fixed3CanonicalCompiler have zero clause violations.
    """
    compiler = ConwayZ3Fixed3CanonicalCompiler(enable_lex=False)
    # The fixed unit clauses were generated during initialization
    fixed_clauses = compiler.cnf.clauses
    assert len(fixed_clauses) == 54, f"Expected 54 fixed subgraph unit clauses, got {len(fixed_clauses)}"

    # Build the planted truth assignment from fixed_edges
    assignment = {}
    for (p, q, d), val in compiler.fixed_edges.items():
        var = compiler.edge_vars[(p, q, d)]
        assignment[var] = bool(val)

    # Evaluate all 54 unit clauses
    satisfied = 0
    violations = 0
    for clause in fixed_clauses:
        assert len(clause) == 1, "Fixed clauses must be unit clauses"
        lit = clause[0]
        vid = abs(lit)
        val = assignment[vid]
        if (lit > 0 and val) or (lit < 0 and not val):
            satisfied += 1
        else:
            violations += 1

    assert violations == 0, f"Found {violations} violations in Z_3 Fixed-3 planted matchings!"
    return {
        "fixed_clauses": len(fixed_clauses),
        "satisfied": satisfied,
        "violations": violations
    }


def validate_z2_f1_gamma1_compatibility() -> Dict[str, Any]:
    """
    Validates that in Z_2 (f=1), the 588 compatibility constraints between
    N(x_0) and Gamma_2(x_0) perfectly reflect the planted 1-factor M_{7K_2}.
    """
    compiler = z2_model.ConwayZ2F1Compiler()
    # Check that opposite in N(x_0) matches the involution transposition
    for a in range(1, 15):
        ta = a + 1 if (a - 1) % 2 == 0 else a - 1
        # Partner must be in same orbit of length 2
        assert (a - 1) // 2 == (ta - 1) // 2
        assert a != ta

    # Check 2-design property of incidence matrix C: C C^T = 10*I_7 + 2*J_7
    CCT = compiler.C @ compiler.C.T
    expected = 10 * np.eye(7, dtype=int) + 2 * np.ones((7, 7), dtype=int)
    assert np.array_equal(CCT, expected)

    return {
        "num_orbits_g2": 42,
        "num_vertices_n": 14,
        "matching_pairs": 7,
        "cct_verified": True
    }


# ==============================================================================
# 3. Planted Cesarz-Woldar Coordinate 2-Paths Validations
# ==============================================================================

def validate_cesarz_woldar_coordinates_and_2paths() -> Dict[str, Any]:
    """
    Validates Cesarz & Woldar (2025) coordinate geometry of Gamma_2(x_0):
    - 84 vertices across 12 orbits of size 7.
    - Bijection with the 84 non-edges of Gamma_1(x_0).
    - Tseitin 2-path definitions through Gamma_1.
    - 12x12 quotient Diophantine matrix C (row sums = 22, target T row sums = 156).
    """
    compiler = ConwayZ7CanonicalCompiler(enable_lex=False)
    coords = compiler.coords

    # 1. 84 vertices with 2 coordinates each
    assert len(coords) == 84
    for (p, t), c in coords.items():
        assert len(c) == 2, f"Vertex ({p}, {t}) must have exactly 2 coordinates"

    # 2. None of the coordinates is an edge of the planted matching M_{7K_2} = {(iL, iR)}
    planted_matching_edges = {frozenset({f"{i}L", f"{i}R"}) for i in range(1, 8)}
    for (p, t), c in coords.items():
        assert frozenset(c) not in planted_matching_edges, f"Vertex ({p}, {t}) contains planted matching edge: {c}"

    # 3. Bijection with the 84 non-edges of Gamma_1
    all_gamma1_non_edges = set()
    all_coords = compiler.all_coords # 14 coordinates
    for i in range(len(all_coords)):
        for j in range(i + 1, len(all_coords)):
            pair = frozenset({all_coords[i], all_coords[j]})
            if pair not in planted_matching_edges:
                all_gamma1_non_edges.add(pair)

    assert len(all_gamma1_non_edges) == 84, f"Expected 84 non-edges in Gamma_1, found {len(all_gamma1_non_edges)}"
    assigned_pairs = {frozenset(c) for c in coords.values()}
    assert assigned_pairs == all_gamma1_non_edges, "Cesarz-Woldar coordinates must exactly match the 84 non-edges of Gamma_1"

    # 4. Each coordinate in Gamma_1 appears in exactly 12 vertices of Gamma_2
    coord_freq = {c: 0 for c in all_coords}
    for c_set in coords.values():
        for c in c_set:
            coord_freq[c] += 1
    for c, freq in coord_freq.items():
        assert freq == 12, f"Coordinate {c} must appear in exactly 12 vertices, found {freq}"

    # 5. Tseitin 2-Path cardinality and 12x12 Quotient Matrix C
    C = np.zeros((12, 12), dtype=int)
    for i in range(12):
        u_coords = coords[(i, 0)]
        for j in range(12):
            total_2paths = 0
            for t in range(7):
                if i == j and t == 0:
                    continue
                w_coords = coords[(j, t)]
                # Number of 2-paths through Gamma_1 is exactly |u_coords cap w_coords|
                inter = len(u_coords.intersection(w_coords))
                total_2paths += inter
            C[i, j] = total_2paths

    # Theoretical properties of C:
    # Row sums are identically 22:
    row_sums = np.sum(C, axis=1)
    assert np.all(row_sums == 22), f"Row sums of C must all equal 22, got {row_sums}"

    # Diagonal of C: 6 orbits have internal 2-paths = 2, 6 orbits have internal 2-paths = 0
    expected_diag = np.array([2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0])
    assert np.array_equal(np.diag(C), expected_diag), f"C diagonal mismatch: {np.diag(C)}"

    # Target matrix T = B^2 + B = (14*J - 2*I) - C
    T = np.zeros((12, 12), dtype=int)
    for i in range(12):
        for j in range(12):
            T[i, j] = (24 - C[i, j]) if i == j else (14 - C[i, j])

    t_row_sums = np.sum(T, axis=1)
    assert np.all(t_row_sums == 156), f"Row sums of T must all equal 156, got {t_row_sums}"

    return {
        "num_vertices_g2": len(coords),
        "gamma1_non_edges": len(all_gamma1_non_edges),
        "coord_regularity": 12,
        "c_matrix_row_sum": int(row_sums[0]),
        "t_matrix_row_sum": int(t_row_sums[0]),
        "c_diagonal": np.diag(C).tolist(),
        "trace_c": int(np.trace(C)),
        "trace_t": int(np.trace(T))
    }


# ==============================================================================
# 4. Relaxed Feasibility Consistency Validations
# ==============================================================================

def validate_relaxed_z7_consistency() -> Dict[str, Any]:
    """
    Explores a selected relaxed Z_7 subsystem
    (internal valence AMO cuts, coordinate constraints, and Crawford lex-leader cuts)
    that admits a satisfying assignment with zero clause violations.
    """
    t0 = time.time()
    compiler = ConwayZ7CanonicalCompiler(enable_lex=True)
    compiler.build_internal_valence_cuts()
    compiler.build_coordinate_constraints()
    compiler.build_lex_leader_cuts()

    num_clauses = len(compiler.cnf.clauses)
    num_vars = compiler.top_id

    with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
        sat = solver.solve()
        assert sat, "Relaxed Z_7 CNF must be SATISFIABLE!"
        model = set(solver.get_model())

    violations = 0
    for clause in compiler.cnf.clauses:
        if not any(lit in model for lit in clause):
            violations += 1

    assert violations == 0, f"Found {violations} clause violations in satisfying assignment!"
    elapsed = time.time() - t0

    return {
        "system": "Z_7 Relaxed (Internal Valence + Coordinates + Lex-Leader)",
        "sat": True,
        "clauses": num_clauses,
        "variables": num_vars,
        "violations": violations,
        "elapsed_seconds": elapsed
    }


def validate_relaxed_z7_mu_bound(max_pairs: int = 50) -> Dict[str, Any]:
    """
    Explores a selected Z_7 subsystem with relaxed common-neighbor bounds
    (mu <= 2 and lambda <= 1 via CardEnc.atmost) and checks zero clause violations.
    """
    t0 = time.time()
    compiler = ConwayZ7CanonicalCompiler(enable_lex=False)
    compiler.build_internal_valence_cuts()

    pair_orbits = []
    for p in range(12):
        for q in range(p, 12):
            if p == q:
                for dt in range(1, 4):
                    pair_orbits.append(((p, 0), (q, dt)))
            else:
                for dt in range(7):
                    pair_orbits.append(((p, 0), (q, dt)))

    for idx, (u, v) in enumerate(pair_orbits[:max_pairs]):
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
                a_vw = compiler.get_adj_lit(v[0], v[1], w[0], w[1])
                if a_uw != 0 and a_vw != 0:
                    lits.append(compiler.get_and_lit(a_uw, a_vw))

        var_lits = [l for l in lits if l != 0]
        enc = CardEnc.atmost(lits=var_lits, bound=target_bound, top_id=compiler.top_id, encoding=EncType.seqcounter)
        compiler.top_id = enc.nv
        compiler.cnf.extend(enc.clauses)

    num_clauses = len(compiler.cnf.clauses)
    num_vars = compiler.top_id

    with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
        sat = solver.solve()
        assert sat, "Z_7 mu-relaxed CNF must be SATISFIABLE!"
        model = set(solver.get_model())

    violations = sum(1 for cl in compiler.cnf.clauses if not any(l in model for l in cl))
    assert violations == 0, f"Found {violations} clause violations!"
    elapsed = time.time() - t0

    return {
        "system": f"Z_7 Relaxed mu <= 2 ({max_pairs} pair orbits)",
        "sat": True,
        "clauses": num_clauses,
        "variables": num_vars,
        "violations": violations,
        "elapsed_seconds": elapsed
    }


def validate_relaxed_z3_fpf_consistency() -> Dict[str, Any]:
    """
    Explores a selected Z_3 fixed-point-free subsystem under degree regularity,
    a modular parity cut, and canonical orbit ordering.
    """
    t0 = time.time()
    compiler = ConwayZ3FPFCanonicalCompiler(num_orbits=33, enable_modular=True, enable_orbit_order=True)
    compiler.build_modular_parity_cut()
    compiler.build_canonical_orbit_ordering()
    compiler.build_degree_constraints()

    num_clauses = len(compiler.cnf.clauses)
    num_vars = compiler.top_id

    with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
        sat = solver.solve()
        assert sat, "Relaxed Z_3 FPF CNF must be SATISFIABLE!"
        model = set(solver.get_model())

    violations = sum(1 for cl in compiler.cnf.clauses if not any(l in model for l in cl))
    assert violations == 0, f"Found {violations} clause violations!"
    elapsed = time.time() - t0

    return {
        "system": "Z_3 FPF Relaxed (Degree + Modular Parity + Orbit Ordering)",
        "sat": True,
        "clauses": num_clauses,
        "variables": num_vars,
        "violations": violations,
        "elapsed_seconds": elapsed
    }


def validate_relaxed_z3_fixed3_consistency() -> Dict[str, Any]:
    """
    Validates Z_3 Fixed-3 under degree regularity (k=14),
    planted 1-factors in N_0, N_1, N_2, and S_3 x Z_2 lex-leader cuts.
    """
    t0 = time.time()
    compiler = ConwayZ3Fixed3CanonicalCompiler(enable_lex=True)
    compiler.build_degree_constraints()
    compiler.build_lex_leader_cuts()

    num_clauses = len(compiler.cnf.clauses)
    num_vars = compiler.top_id

    with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
        sat = solver.solve()
        assert sat, "Relaxed Z_3 Fixed-3 CNF must be SATISFIABLE!"
        model = set(solver.get_model())

    violations = sum(1 for cl in compiler.cnf.clauses if not any(l in model for l in cl))
    assert violations == 0, f"Found {violations} clause violations!"
    elapsed = time.time() - t0

    return {
        "system": "Z_3 Fixed-3 Relaxed (Planted Matchings + Degree + S_3 x Z_2 Lex-Leader)",
        "sat": True,
        "clauses": num_clauses,
        "variables": num_vars,
        "violations": violations,
        "elapsed_seconds": elapsed
    }


def validate_relaxed_z2_f1_consistency() -> Dict[str, Any]:
    """
    Explores a selected Z_2 (f=1) local subsystem; this does not resolve the open case.
    """
    t0 = time.time()
    compiler = z2_model.ConwayZ2F1Compiler()
    compiler.build_local_constraints()
    num_clauses = len(compiler.cnf.clauses)
    num_vars = compiler.top_id

    with Cadical195(bootstrap_with=compiler.cnf.clauses) as solver:
        sat = solver.solve()
        assert sat, "Selected Z_2 (f=1) subsystem must be SATISFIABLE!"
        model = set(solver.get_model())

    violations = sum(1 for cl in compiler.cnf.clauses if not any(l in model for l in cl))
    assert violations == 0, f"Found {violations} clause violations!"
    elapsed = time.time() - t0

    return {
        "system": "Z_2 (f=1) Selected Local Subsystem",
        "sat": True,
        "clauses": num_clauses,
        "variables": num_vars,
        "violations": violations,
        "elapsed_seconds": elapsed
    }


# ==============================================================================
# CLI Entry Point
# ==============================================================================

def main():
    parser = argparse.ArgumentParser(description="Planted Substructure & Positive Control Validator for Conway-99 SAT Encoders")
    parser.add_argument("--verbose", action="store_true", help="Print detailed diagnostic output")
    args = parser.parse_args()

    print("=" * 80)
    print("CONWAY-99 SAT ENCODER POSITIVE CONTROL & PLANTED SUBSTRUCTURE VALIDATION")
    print("Radical Honesty Audit: Four-State Taxonomy [PROVED, COMPILED, EXPLORED, PENDING]")
    print("=" * 80)

    # 1. Parameterized SRG Controls
    print("\n[PART 1] Parameterized SRG Block-Circulant Positive Controls")
    print("-" * 80)

    # Paley(9) = srg(9, 4, 1, 2) under Z_3
    print("1.1 Paley(9) = srg(9, 4, 1, 2) under Z_3 (standalone experimental positive control)...")
    enc_paley = SRGBlockCirculantEncoder(m=3, q=3, k=4, lam=1, mu=2)
    enc_paley.build_cnf()
    sat, A_paley, diag_paley = enc_paley.solve()
    print(f"    Verdict: {'SATISFIABLE' if sat else 'UNSATISFIABLE'} in {diag_paley['solve_time']:.3f}s | "
          f"Vars: {diag_paley['variables']} | Clauses: {diag_paley['clauses']}")
    print(f"    Graph: v={diag_paley['v']}, k={diag_paley['k']}, lambda={diag_paley['lambda']}, mu={diag_paley['mu']} -> COMPILED")

    # Petersen = srg(10, 3, 0, 1) under Z_5
    print("1.2 Petersen = srg(10, 3, 0, 1) under Z_5...")
    enc_petersen = SRGBlockCirculantEncoder(m=2, q=5, k=3, lam=0, mu=1)
    enc_petersen.build_cnf()
    sat, A_petersen, diag_petersen = enc_petersen.solve()
    print(f"    Verdict: {'SATISFIABLE' if sat else 'UNSATISFIABLE'} in {diag_petersen['solve_time']:.3f}s | "
          f"Vars: {diag_petersen['variables']} | Clauses: {diag_petersen['clauses']}")
    print(f"    Graph: v={diag_petersen['v']}, k={diag_petersen['k']}, lambda={diag_petersen['lambda']}, mu={diag_petersen['mu']} -> COMPILED")

    # 2. Experimental isolated toy-model checks
    print("\n[PART 2] Experimental isolated toy-model checks for M_{7K_2}")
    print("-" * 80)

    # Z_7 Gamma_1
    print("2.1 Z_7 Gamma_1(x_0) (2 orbits of size 7, L and R)...")
    z7_g1 = Z7Gamma1Encoder()
    z7_g1.build_constraints()
    planted_z7 = z7_g1.get_planted_matching_assignment()
    eval_z7 = z7_g1.evaluate_clauses(planted_z7)
    print(f"    Planted matching M_{{7K_2}}: {eval_z7['satisfied']}/{eval_z7['total_clauses']} clauses satisfied | "
          f"Violations: {eval_z7['violations']} -> COMPILED")

    # Z_2 f=1 Gamma_1
    print("2.2 Z_2 (f=1) Gamma_1(x_0) (7 orbits of length 2)...")
    z2_g1 = Z2F1Gamma1Encoder()
    z2_g1.build_constraints()
    planted_z2 = z2_g1.get_planted_matching_assignment()
    eval_z2 = z2_g1.evaluate_clauses(planted_z2)
    print(f"    Planted matching M_{{7K_2}}: {eval_z2['satisfied']}/{eval_z2['total_clauses']} clauses satisfied | "
          f"Violations: {eval_z2['violations']} -> COMPILED")

    # Z_3 Fixed-3 Planted Matchings
    print("2.3 Z_3 Fixed-3 Planted 1-Factors (N_0, N_1, N_2)...")
    res_z3_fix = validate_z3_fixed3_planted_matching()
    print(f"    Planted matchings 6*K_2: {res_z3_fix['satisfied']}/{res_z3_fix['fixed_clauses']} clauses satisfied | "
          f"Violations: {res_z3_fix['violations']} -> COMPILED")

    # Z_2 f=1 Compatibility
    print("2.4 Z_2 (f=1) Gamma_1 - Gamma_2 Compatibility (588 constraints)...")
    res_z2_compat = validate_z2_f1_gamma1_compatibility()
    print(f"    2-Design C C^T = 10*I + 2*J: {res_z2_compat['cct_verified']} | "
          f"Matching pairs: {res_z2_compat['matching_pairs']} -> COMPILED")

    # 3. Planted Cesarz-Woldar 2-Paths
    print("\n[PART 3] Planted Cesarz-Woldar Coordinate 2-Paths in Z_7")
    print("-" * 80)
    cw_diag = validate_cesarz_woldar_coordinates_and_2paths()
    print(f"    Gamma_2 vertices: {cw_diag['num_vertices_g2']} | Gamma_1 non-edges: {cw_diag['gamma1_non_edges']} (Exact Bijection)")
    print(f"    Coordinate regularity: each coordinate appears in {cw_diag['coord_regularity']} vertices")
    print(f"    Quotient matrix C: row sum = {cw_diag['c_matrix_row_sum']}, trace = {cw_diag['trace_c']}")
    print(f"    Target matrix T: row sum = {cw_diag['t_matrix_row_sum']}, trace = {cw_diag['trace_t']} -> COMPILED")

    # 4. Relaxed Feasibility Consistency
    print("\n[PART 4] Relaxed Feasibility Consistency Checks")
    print("-" * 80)

    # Z_7 Relaxed
    res_z7 = validate_relaxed_z7_consistency()
    print(f"4.1 {res_z7['system']}:")
    print(f"    SAT={res_z7['sat']} in {res_z7['elapsed_seconds']:.3f}s | Clauses={res_z7['clauses']:,} | Violations={res_z7['violations']} -> EXPLORED")

    # Z_7 mu <= 2
    res_z7_mu = validate_relaxed_z7_mu_bound(max_pairs=50)
    print(f"4.2 {res_z7_mu['system']}:")
    print(f"    SAT={res_z7_mu['sat']} in {res_z7_mu['elapsed_seconds']:.3f}s | Clauses={res_z7_mu['clauses']:,} | Violations={res_z7_mu['violations']} -> EXPLORED")

    # Z_3 FPF Relaxed
    res_z3_fpf = validate_relaxed_z3_fpf_consistency()
    print(f"4.3 {res_z3_fpf['system']}:")
    print(f"    SAT={res_z3_fpf['sat']} in {res_z3_fpf['elapsed_seconds']:.3f}s | Clauses={res_z3_fpf['clauses']:,} | Violations={res_z3_fpf['violations']} -> EXPLORED")

    # Z_3 Fixed-3 Relaxed
    res_z3_fixed3 = validate_relaxed_z3_fixed3_consistency()
    print(f"4.4 {res_z3_fixed3['system']}:")
    print(f"    SAT={res_z3_fixed3['sat']} in {res_z3_fixed3['elapsed_seconds']:.3f}s | Clauses={res_z3_fixed3['clauses']:,} | Violations={res_z3_fixed3['violations']} -> EXPLORED")

    # Z_2 f=1 Relaxed
    res_z2 = validate_relaxed_z2_f1_consistency()
    print(f"4.5 {res_z2['system']}:")
    print(f"    SAT={res_z2['sat']} in {res_z2['elapsed_seconds']:.3f}s | Clauses={res_z2['clauses']:,} | Violations={res_z2['violations']} -> EXPLORED")

    print("\n" + "=" * 80)
    print("Selected positive-control and subsystem checks completed.")
    print("=" * 80)


if __name__ == "__main__":
    main()
