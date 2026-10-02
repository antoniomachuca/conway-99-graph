#!/usr/bin/env python3
r"""
scripts/build_srg_positive_control.py

Generic Parameterized SAT / CNF Positive Control Compiler for Strongly Regular Graphs (SRGs)
under Cyclic Group Action Z_p.

Theoretical Foundations:
1. Strongly Regular Graph SRG(v, k, \lambda, \mu):
   - A k-regular graph on v vertices with no self-loops.
   - Every two adjacent vertices share exactly \lambda common neighbors.
   - Every two non-adjacent vertices share exactly \mu common neighbors.
   - Algebraic identity: A^2 = k*I + \lambda*A + \mu*(J - I - A).
   - Parameter feasibility equation: k*(k - \lambda - 1) = \mu*(v - k - 1).

2. Semi-regular Prime Cyclic Group Action Z_p:
   - v = m * p, where m is the number of vertex orbits of size p under Z_p.
   - Automorphism generator \sigma: (p_i, t) \mapsto (p_i, (t + 1) \pmod p).
   - Block-circulant structure:
     * Intra-orbit (diagonal blocks): Chord distances d in {1, ..., \lfloor (p-1)/2 \rfloor}.
     * Inter-orbit (off-diagonal blocks): Directed differences d in {0, ..., p-1}.
   - Primary Boolean variables:
     * Diagonal: (p_i, p_i, d) for p_i in 0..m-1, d in 1..\lfloor(p-1)/2\rfloor.
     * Off-diagonal: (p_i, p_j, d) for 0 <= p_i < p_j < m, d in 0..p-1.

3. Canonical CNF Encoding Architecture (identical to scripts/build_z7_canonical_cnf.py):
   - Variable 1 safety: Literal 1 is a variable ID, NEVER conflated with boolean True.
   - 2-path AND-gates (Tseitin encoding) for common neighbor counting.
   - PySAT CardEnc.equals (seqcounter) for exact cardinality constraints:
     * Degree regularity: sum_{w != u} A(u, w) = k for each orbit representative.
     * Common neighbors:
       If \mu - \lambda = \delta > 0: \delta * A(u, v) + sum_{w} (A(u, w) AND A(v, w)) = \mu.
       If \lambda - \mu = \delta > 0: \delta * (~A(u, v)) + sum_{w} (A(u, w) AND A(v, w)) = \lambda.
       If \lambda == \mu: sum_{w} (A(u, w) AND A(v, w)) = \lambda.
   - Crawford Lex-Leader symmetry breaking on the quotient group G \cong S_m \times Z_p^*:
     * S_m permutes the m orbit labels.
     * Z_p^* acts by group automorphism multipliers a in {1, ..., p-1}.

4. Known Solvable Ground-Truth Presets:
   - Paley(9) = srg(9, 4, 1, 2) under Z_3:
     NOTE: \lambda = 1, \mu = 2 is IDENTICAL to Conway's 99-graph (99, 14, 1, 2)!
     3 orbits of size 3 under Z_3.
   - Petersen graph = srg(10, 3, 0, 1) under Z_5:
     2 orbits of size 5 (outer pentagon, inner pentagram).
   - Cycle C_5 = srg(5, 2, 0, 1) under Z_5:
     1 orbit of size 5.
"""

import os
import sys
import time
import argparse
import itertools
from typing import Dict, List, Tuple, Optional, Set
import numpy as np
from pysat.formula import CNF
from pysat.card import CardEnc, EncType
from pysat.solvers import Cadical195


def verify_srg_matrix(A: np.ndarray, v: int, k: int, lam: int, mu: int) -> bool:
    r"""
    Mathematical validator for Strongly Regular Graph adjacency matrix A.
    Verifies:
      1. Shape is (v, v).
      2. Symmetry: A = A^T.
      3. Zero diagonal: A_{ii} = 0 for all i (no self-loops).
      4. Binary entries: A_{ij} in {0, 1}.
      5. Degree regularity: sum_j A_{ij} = k for all i.
      6. Algebraic identity: A^2 = k*I + \lambda*A + \mu*(J - I - A).
         Equivalently:
           (A^2)_{ij} = \lambda for all adjacent pairs (i, j) with i != j.
           (A^2)_{ij} = \mu for all non-adjacent pairs (i, j) with i != j.
    Raises AssertionError if any condition is violated.
    Returns True upon successful verification.
    """
    if A.shape != (v, v):
        raise AssertionError(f"Shape mismatch: expected ({v}, {v}), got {A.shape}")
    if not np.array_equal(A, A.T):
        raise AssertionError("Adjacency matrix A is not symmetric: A != A^T")
    if np.any(np.diag(A) != 0):
        raise AssertionError("Adjacency matrix has non-zero diagonal entries (self-loops present)")
    if not np.all(np.isin(A, [0, 1])):
        raise AssertionError("Adjacency matrix contains non-binary entries (must be 0 or 1)")

    # Degree regularity
    degrees = np.sum(A, axis=1)
    if not np.all(degrees == k):
        mismatched = np.where(degrees != k)[0]
        raise AssertionError(
            f"Degree regularity failed: expected k={k}, but vertices {mismatched[:5]} have degrees {degrees[mismatched[:5]]}"
        )

    # SRG algebraic identity
    A2 = A @ A
    I = np.eye(v, dtype=int)
    J = np.ones((v, v), dtype=int)
    expected_A2 = k * I + lam * A + mu * (J - I - A)
    if not np.array_equal(A2, expected_A2):
        diff_indices = np.where(A2 != expected_A2)
        sample_i, sample_j = diff_indices[0][0], diff_indices[1][0]
        actual_val = A2[sample_i, sample_j]
        expected_val = expected_A2[sample_i, sample_j]
        adj = A[sample_i, sample_j]
        raise AssertionError(
            f"SRG algebraic identity A^2 = k*I + \u03bb*A + \u03bc*(J - I - A) failed at ({sample_i}, {sample_j}): "
            f"adjacent={adj}, actual (A^2)_{{{sample_i},{sample_j}}}={actual_val}, expected={expected_val}"
        )

    return True


class SRGPositiveControlCompiler:
    r"""
    Generic, parameterized SAT encoder for strongly regular graphs under Z_p action.
    """

    PRESETS = {
        "paley9": {"v": 9, "k": 4, "lam": 1, "mu": 2, "p": 3, "name": "Paley(9)"},
        "petersen": {"v": 10, "k": 3, "lam": 0, "mu": 1, "p": 5, "name": "Petersen"},
        "c5": {"v": 5, "k": 2, "lam": 0, "mu": 1, "p": 5, "name": "Cycle C_5"},
    }

    def __init__(
        self,
        v: int,
        k: int,
        lam: int,
        mu: int,
        p: int,
        enable_lex: bool = True,
        lex_depth: Optional[int] = None,
    ):
        if v % p != 0:
            raise ValueError(f"Number of vertices v={v} must be divisible by group order p={p}")
        if not (0 <= lam < k < v):
            raise ValueError(f"Parameters out of valid bounds: must satisfy 0 <= lam ({lam}) < k ({k}) < v ({v})")
        if not (0 < mu <= k):
            raise ValueError(f"Parameter mu={mu} out of valid bounds: must satisfy 0 < mu <= k ({k})")

        # Feasibility check: k*(k - lam - 1) == mu*(v - k - 1)
        lhs = k * (k - lam - 1)
        rhs = mu * (v - k - 1)
        if lhs != rhs:
            raise ValueError(
                f"SRG parameter feasibility check failed: k*(k - lam - 1) = {lhs} != mu*(v - k - 1) = {rhs}"
            )

        self.v = v
        self.k = k
        self.lam = lam
        self.mu = mu
        self.p = p
        self.m = v // p  # number of orbits of size p
        self.enable_lex = enable_lex
        self.lex_depth = lex_depth

        self.cnf = CNF()
        self.top_id = 0

        # Containers
        self.primary_vars: List[Tuple] = []
        self.var_map: Dict[Tuple, int] = {}
        self.aux_and: Dict[Tuple[int, int], int] = {}

        self._init_primary_variables()

    def _init_primary_variables(self):
        r"""
        Allocates primary circulant Boolean variables:
        - Diagonal (intra-orbit): (p_i, p_i, d) for p_i in 0..m-1, d in 1..\lfloor(p-1)/2\rfloor
          (If p=2, d=1).
        - Off-diagonal (inter-orbit): (p_i, p_j, d) for 0 <= p_i < p_j < m, d in 0..p-1.
        """
        max_d = self.p // 2
        # 1. Diagonal variables
        for i in range(self.m):
            for d in range(1, max_d + 1):
                self.top_id += 1
                self.var_map[(i, i, d)] = self.top_id
                self.primary_vars.append((i, i, d))

        # 2. Off-diagonal variables
        for i in range(self.m):
            for j in range(i + 1, self.m):
                for d in range(self.p):
                    self.top_id += 1
                    self.var_map[(i, j, d)] = self.top_id
                    self.primary_vars.append((i, j, d))

    def get_adj_lit(self, p1: int, t1: int, p2: int, t2: int) -> int:
        r"""
        Returns the Boolean literal representing adjacency between vertex (p1, t1)
        and vertex (p2, t2).
        Returns 0 if non-adjacent by definition (self-loops).
        """
        if p1 == p2:
            diff = (t2 - t1) % self.p
            if diff == 0:
                return 0
            d = min(diff, self.p - diff)
            return self.var_map[(p1, p1, d)]
        elif p1 < p2:
            diff = (t2 - t1) % self.p
            return self.var_map[(p1, p2, diff)]
        else:  # p1 > p2
            diff = (t1 - t2) % self.p
            return self.var_map[(p2, p1, diff)]

    def get_and_lit(self, a: int, b: int) -> int:
        r"""
        Tseitin encoding for conjunction: y <=> a AND b.
        Includes constant propagation for 0 (no edge / False) and deduplication.
        Ensures literal 1 is NEVER conflated with boolean True.
        """
        if a == 0 or b == 0:
            return 0
        if a == b:
            return a
        if a == -b:
            return 0
        if a > b:
            a, b = b, a
        k = (a, b)
        if k not in self.aux_and:
            self.top_id += 1
            y = self.top_id
            self.cnf.append([-y, a])
            self.cnf.append([-y, b])
            self.cnf.append([y, -a, -b])
            self.aux_and[k] = y
        return self.aux_and[k]

    def add_card_equals(self, lits: List[int], bound: int):
        r"""
        Encodes sum(lits) == bound with PySAT sequential counter and 0-pruning.
        """
        var_lits = [l for l in lits if l != 0]
        target = bound
        if target < 0:
            self.cnf.append([])
            return
        if target == 0:
            for l in var_lits:
                self.cnf.append([-l])
            return
        if len(var_lits) < target:
            self.cnf.append([])
            return
        if len(var_lits) == target:
            for l in var_lits:
                self.cnf.append([l])
            return

        enc = CardEnc.equals(
            lits=var_lits,
            bound=target,
            top_id=self.top_id,
            encoding=EncType.seqcounter,
        )
        self.top_id = enc.nv
        self.cnf.extend(enc.clauses)

    def build_degree_constraints(self):
        r"""
        Encodes degree regularity: deg(u) = k for all vertices.
        By Z_p action, it suffices to enforce for orbit representatives (p1, 0).
        """
        for p1 in range(self.m):
            u = (p1, 0)
            lits = []
            for p2 in range(self.m):
                for t2 in range(self.p):
                    if (p2, t2) == u:
                        continue
                    adj = self.get_adj_lit(u[0], u[1], p2, t2)
                    if adj != 0:
                        lits.append(adj)
            self.add_card_equals(lits, self.k)

    def build_common_neighbor_constraints(self, verbose: bool = False):
        r"""
        Encodes strongly regular graph common neighbor parameters (\lambda, \mu):
        For every pair of distinct vertices u != v:
          If A(u, v) = 1, sum_{w != u, v} (A(u, w) AND A(v, w)) = \lambda.
          If A(u, v) = 0, sum_{w != u, v} (A(u, w) AND A(v, w)) = \mu.

        By Z_p action, this is enforced on orbit representatives of pairs:
          - Intra-orbit: ((p1, 0), (p1, d)) for d in 1..\lfloor(p-1)/2\rfloor.
          - Inter-orbit: ((p1, 0), (p2, d)) for 0 <= p1 < p2 < m, d in 0..p-1.
        """
        pair_orbits = []
        max_d = self.p // 2
        for p1 in range(self.m):
            for d in range(1, max_d + 1):
                pair_orbits.append(((p1, 0), (p1, d)))
        for p1 in range(self.m):
            for p2 in range(p1 + 1, self.m):
                for d in range(self.p):
                    pair_orbits.append(((p1, 0), (p2, d)))

        delta = self.mu - self.lam
        t0 = time.time()
        total_pairs = len(pair_orbits)

        for idx, (u, v) in enumerate(pair_orbits):
            a_uv = self.get_adj_lit(u[0], u[1], v[0], v[1])
            lits = []

            # Linear combination: delta * A(u, v) + sum(AND) = target_bound
            if delta > 0:
                for _ in range(delta):
                    lits.append(a_uv)
                target_bound = self.mu
            elif delta < 0:
                for _ in range(-delta):
                    lits.append(-a_uv)
                target_bound = self.lam
            else:
                target_bound = self.lam

            for p_w in range(self.m):
                for t_w in range(self.p):
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

            self.add_card_equals(lits, target_bound)

            if verbose and ((idx + 1) % 50 == 0 or idx == total_pairs - 1):
                elapsed = time.time() - t0
                print(
                    f"  [Common Neighbors] Processed {idx+1}/{total_pairs} pairs ({elapsed:.2f}s) | "
                    f"vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}",
                    flush=True,
                )

    def _compute_group_permutations(self) -> List[Tuple[str, Dict[int, int]]]:
        r"""
        Computes the permutation of primary variables induced by elements of the
        quotient symmetry group G_{quot} \cong S_m \times Z_p^*.
        - S_m permutes the orbit indices {0, ..., m-1}.
        - Z_p^* = {1, ..., p-1} acts by multiplier automorphisms d \mapsto a*d mod p.
        Returns a list of (element_name, var_permutation_dict).
        """
        perms = []
        for pi in itertools.permutations(range(self.m)):
            for a in range(1, self.p):
                # Skip the identity element (id, 1)
                if pi == tuple(range(self.m)) and a == 1:
                    continue

                elem_name = f"pi={pi}_mult={a}"
                var_perm = {}
                for k_var in self.primary_vars:
                    vid = self.var_map[k_var]
                    if k_var[0] == k_var[1]:
                        pi_i = pi[k_var[0]]
                        d = k_var[2]
                        ad = (a * d) % self.p
                        new_d = min(ad, self.p - ad)
                        target_key = (pi_i, pi_i, new_d)
                    else:
                        i, j, d = k_var
                        pi_i = pi[i]
                        pi_j = pi[j]
                        ad = (a * d) % self.p
                        if pi_i < pi_j:
                            target_key = (pi_i, pi_j, ad)
                        else:
                            target_key = (pi_j, pi_i, (self.p - ad) % self.p)

                    target_vid = self.var_map[target_key]
                    var_perm[vid] = target_vid

                assert len(var_perm) == len(self.primary_vars)
                assert len(set(var_perm.values())) == len(self.primary_vars), "Permutation must be bijective"
                perms.append((elem_name, var_perm))

        return perms

    def build_lex_leader_cuts(self, verbose: bool = False) -> int:
        r"""
        Injects canonical Crawford Lex-Leader symmetry-breaking constraints:
          X <=_lex g(X)
        for all non-identity elements g in G_{quot} \cong S_m \times Z_p^*.
        """
        if not self.enable_lex:
            return 0

        perms = self._compute_group_permutations()
        total_lex_clauses = 0
        primary_vids = [self.var_map[k] for k in self.primary_vars]

        if self.lex_depth is not None and self.lex_depth > 0:
            target_vids = primary_vids[: self.lex_depth]
        else:
            target_vids = primary_vids

        for elem_name, perm in perms:
            diff_pairs = [(v, perm[v]) for v in target_vids if v != perm[v]]
            if not diff_pairs:
                continue

            m_len = len(diff_pairs)
            c_prev = None
            elem_clauses = 0

            for k in range(m_len):
                a, b = diff_pairs[k]
                if k == 0:
                    self.cnf.append([-a, b])
                    elem_clauses += 1
                else:
                    self.cnf.append([-c_prev, -a, b])
                    elem_clauses += 1

                if k < m_len - 1:
                    self.top_id += 1
                    c_curr = self.top_id
                    if k == 0:
                        self.cnf.append([-c_curr, -a, b])
                        self.cnf.append([-c_curr, a, -b])
                        self.cnf.append([-a, -b, c_curr])
                        self.cnf.append([a, b, c_curr])
                        elem_clauses += 4
                    else:
                        self.cnf.append([-c_curr, c_prev])
                        self.cnf.append([-c_curr, -a, b])
                        self.cnf.append([-c_curr, a, -b])
                        self.cnf.append([-c_prev, -a, -b, c_curr])
                        self.cnf.append([-c_prev, a, b, c_curr])
                        elem_clauses += 5
                    c_prev = c_curr

            total_lex_clauses += elem_clauses

        if verbose:
            print(
                f"[Lex-Leader] Injected {total_lex_clauses:,} clauses across {len(perms)} symmetries | top_id={self.top_id:,}",
                flush=True,
            )

        return total_lex_clauses

    def compile(self, verbose: bool = True) -> CNF:
        r"""
        Executes complete CNF compilation pipeline.
        """
        t0 = time.time()
        if verbose:
            print("=" * 80)
            print(f"SRG Positive Control Compiler: SRG({self.v}, {self.k}, {self.lam}, {self.mu}) under Z_{self.p}")
            print(f"Orbits: {self.m} | Primary variables: {len(self.primary_vars)} | Lex-Leader: {self.enable_lex}")
            print("=" * 80)

        self.build_degree_constraints()
        if verbose:
            print(f"[*] Degree regularity constraints (k={self.k}): vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")

        self.build_common_neighbor_constraints(verbose=verbose)
        if verbose:
            print(f"[*] Common neighbor constraints (\u03bb={self.lam}, \u03bc={self.mu}): vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")

        if self.enable_lex:
            lex_clauses = self.build_lex_leader_cuts(verbose=verbose)
            if verbose:
                print(f"[*] Crawford Lex-Leader cuts injected: {lex_clauses:,} clauses.")

        if verbose:
            print(f"[+] Compilation finished in {time.time() - t0:.2f}s | Final: vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")
            print("=" * 80)

        return self.cnf

    def decode_srg_model(self, model: List[int]) -> np.ndarray:
        r"""
        Decodes a SAT satisfying model into the full v x v binary adjacency matrix A.
        Vertices are indexed as u = p1 * p + t1.
        """
        model_set = set(model)
        A = np.zeros((self.v, self.v), dtype=int)

        for p1 in range(self.m):
            for t1 in range(self.p):
                u_idx = p1 * self.p + t1
                for p2 in range(self.m):
                    for t2 in range(self.p):
                        v_idx = p2 * self.p + t2
                        if u_idx == v_idx:
                            continue
                        lit = self.get_adj_lit(p1, t1, p2, t2)
                        if lit > 0 and lit in model_set:
                            A[u_idx, v_idx] = 1

        return A

    def solve_and_verify(self, verbose: bool = True) -> Tuple[bool, Optional[np.ndarray], float]:
        r"""
        Compiles, solves with CaDiCaL, decodes model, and mathematically verifies the SRG matrix.
        Returns (is_sat, decoded_matrix, elapsed_seconds).
        """
        t0 = time.time()
        self.compile(verbose=verbose)

        solver = Cadical195(bootstrap_with=self.cnf.clauses)
        sat = solver.solve()
        elapsed = time.time() - t0

        if not sat:
            if verbose:
                print(f"[-] Solver returned UNSATISFIABLE in {elapsed:.3f}s")
            return False, None, elapsed

        model = solver.get_model()
        A = self.decode_srg_model(model)
        verify_srg_matrix(A, self.v, self.k, self.lam, self.mu)

        if verbose:
            print(f"[+] Solver returned SATISFIABLE in {elapsed:.3f}s!")
            print(f"[+] Decoded {self.v}x{self.v} adjacency matrix passed all SRG({self.v}, {self.k}, {self.lam}, {self.mu}) mathematical checks.")

        return True, A, elapsed

    def export_dimacs(self, filename: str):
        t0 = time.time()
        print(f"[*] Exporting DIMACS CNF to {filename}...", flush=True)
        self.cnf.to_file(filename)
        size_mb = os.path.getsize(filename) / (1024 * 1024)
        print(f"[+] Export complete: {filename} ({size_mb:.2f} MB, {len(self.cnf.clauses):,} clauses, {self.top_id:,} vars in {time.time() - t0:.2f}s).", flush=True)


def parse_args():
    parser = argparse.ArgumentParser(description="Generic SRG Positive Control SAT Encoder under Z_p")
    parser.add_argument(
        "--preset",
        type=str,
        choices=["paley9", "petersen", "c5"],
        default=None,
        help="Known solvable SRG preset (paley9, petersen, c5)",
    )
    parser.add_argument("--v", type=int, help="Number of vertices")
    parser.add_argument("--k", type=int, help="Degree regularity")
    parser.add_argument("--lam", type=int, help="Common neighbors for adjacent vertices")
    parser.add_argument("--mu", type=int, help="Common neighbors for non-adjacent vertices")
    parser.add_argument("--p", type=int, help="Cyclic group order Z_p")
    parser.add_argument("--skip-lex", action="store_true", help="Omit lex-leader symmetry breaking")
    parser.add_argument("--lex-depth", type=int, default=None, help="Lex-leader depth limit")
    parser.add_argument("--output", type=str, default=None, help="Output DIMACS CNF file path")
    parser.add_argument("--solve", action="store_true", help="Solve with CaDiCaL and verify decoded matrix")
    return parser.parse_args()


def main():
    args = parse_args()

    if args.preset:
        preset_cfg = SRGPositiveControlCompiler.PRESETS[args.preset]
        v = preset_cfg["v"]
        k = preset_cfg["k"]
        lam = preset_cfg["lam"]
        mu = preset_cfg["mu"]
        p = preset_cfg["p"]
        name = preset_cfg["name"]
        print(f"[*] Loaded preset: {name} -> SRG({v}, {k}, {lam}, {mu}) under Z_{p}")
    else:
        if None in (args.v, args.k, args.lam, args.mu, args.p):
            print("Error: Must specify either --preset or all of (--v, --k, --lam, --mu, --p).")
            sys.exit(1)
        v, k, lam, mu, p = args.v, args.k, args.lam, args.mu, args.p

    compiler = SRGPositiveControlCompiler(
        v=v,
        k=k,
        lam=lam,
        mu=mu,
        p=p,
        enable_lex=(not args.skip_lex),
        lex_depth=args.lex_depth,
    )

    if args.solve or args.output is None:
        sat, A, elapsed = compiler.solve_and_verify(verbose=True)
        if not sat:
            sys.exit(1)
    else:
        compiler.compile(verbose=True)

    if args.output:
        compiler.export_dimacs(args.output)


if __name__ == "__main__":
    main()
