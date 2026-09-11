#!/usr/bin/env python3
r"""
scripts/build_z3_canonical_cnf.py

Canonical SAT / CNF Compiler for the Conway 99-Graph under Z_3 Symmetry
Profiles:
  1. Fixed-Point-Free (fpf): 33 orbits of size 3, 0 fixed points.
  2. 3 Fixed Points (fixed3): Fix(g) = {x_0, x_1, x_2} forming K_3, 32 orbits of size 3.

Theoretical Foundations:
1. Fixed-Point-Free (fpf) Profile:
   - 33 orbits O_0, ..., O_32 of size 3.
   - Internal triangle indicator t_p in {0, 1} for each orbit.
   - Off-diagonal circulants c_{p, q, k} for p < q, k in {0, 1, 2}.
   - Degree regularity k = 14, SRG parameters lambda = 1, mu = 2, K_4-free cuts.
   - CANONICAL CUT 1: Global Modular Parity Cardinality Cut:
       sum_{p=0}^{32} t_p \equiv 231 \equiv 0 \pmod 3.
     Since the Conway 99-graph has exactly N_3 = (99 * 14 * 1) / 6 = 231 triangles,
     and any fixed-point-free Z_3 automorphism fixes setwise only those triangles
     that constitute entire vertex orbits of length 3, the number of triangle orbits
     must be congruent to N_3 mod 3. Encoded via a compact modular adder automaton.
   - CANONICAL CUT 2: Canonical Ordering of Triangular Orbits:
       t_0 >= t_1 >= ... >= t_32.
     Coupled with the modular cut, this locks the 33 variables into 11 monotonic
     triplets t_{3k} = t_{3k+1} = t_{3k+2}, collapsing the 2^{33} search space
     over triangle indicators down to exactly 12 configurations.

2. 3 Fixed Points (fixed3) Profile:
   - Fix(g) = {x_0, x_1, x_2} inducing a triangle K_3.
   - Neighborhoods N_i = N(x_i) \ {the other two} each partition into 4 orbits of size 3:
     N_0 (orbits 0..3), N_1 (orbits 4..7), N_2 (orbits 8..11), and W (orbits 12..31).
   - Each N_i induces a 1-factor 6*K_2.
   - By Crnkovic & Maksimovic (2020), internal degrees E(p, p) = 0 for all 32 orbits.
   - CANONICAL CUT: Lexicographical Ordering under S_3 x Z_2 (order 12):
     The quotient symmetry group G_{Z_3} \cong S_3 x Z_2 acts by permuting the
     3 neighborhoods N_0, N_1, N_2 (S_3 of order 6) and inverting the circulant
     differences d \mapsto -d mod 3 (Z_2 of order 2).
     Full Crawford Lex-Leader constraints X <=_lex g(X) are generated for all
     11 non-identity elements of S_3 x Z_2 to break the symmetry between N_0, N_1, N_2.
"""

import os
import sys
import time
import argparse
import itertools
from typing import Dict, List, Tuple, Optional
from pysat.formula import CNF
from pysat.card import CardEnc, EncType

# ==============================================================================
# 1. Z_3 Fixed-Point-Free (fpf) Compiler
# ==============================================================================

class ConwayZ3FPFCanonicalCompiler:
    def __init__(self, num_orbits: int = 33, enable_modular: bool = True, enable_orbit_order: bool = True):
        self.num_orbits = num_orbits
        self.enable_modular = enable_modular
        self.enable_orbit_order = enable_orbit_order
        self.cnf = CNF()
        self.top_id = 0

        # Primary variables
        self.t_vars: Dict[int, int] = {}
        self.edge_vars: Dict[Tuple[int, int, int], int] = {}
        self.aux_and: Dict[Tuple[int, int], int] = {}

        self._init_variables()

    def _init_variables(self):
        # 1. Diagonal triangle indicators t_p for p in 0..32 (33 vars)
        for p in range(self.num_orbits):
            self.top_id += 1
            self.t_vars[p] = self.top_id

        # 2. Off-diagonal circulant variables c_{p, q, k} for p < q and k in {0, 1, 2}
        # 33 * 32 / 2 = 528 pairs * 3 = 1584 variables
        for p in range(self.num_orbits):
            for q in range(p + 1, self.num_orbits):
                for k in range(3):
                    self.top_id += 1
                    self.edge_vars[(p, q, k)] = self.top_id

        assert len(self.t_vars) == 33
        assert len(self.edge_vars) == 1584
        assert self.top_id == 1617

    def get_adj_lit(self, p: int, i: int, q: int, j: int) -> int:
        if p == q:
            if i == j:
                return 0
            return self.t_vars[p]
        elif p < q:
            d = (j - i) % 3
            return self.edge_vars[(p, q, d)]
        else: # p > q
            d = (i - j) % 3
            return self.edge_vars[(q, p, d)]

    def get_and_lit(self, l1: int, l2: int) -> int:
        if l1 == 0 or l2 == 0:
            return 0
        if l1 == 1:
            return l2
        if l2 == 1:
            return l1
        if l1 == l2:
            return l1
        if l1 == -l2:
            return 0
        if l1 > l2:
            l1, l2 = l2, l1
        k = (l1, l2)
        if k not in self.aux_and:
            self.top_id += 1
            y = self.top_id
            self.cnf.append([-y, l1])
            self.cnf.append([-y, l2])
            self.cnf.append([y, -l1, -l2])
            self.aux_and[k] = y
        return self.aux_and[k]

    def add_card_equals(self, lits: List[int], bound: int):
        c = 0
        var_lits = []
        for l in lits:
            if l == 1:
                c += 1
            elif l != 0:
                var_lits.append(l)
        target = bound - c
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

        enc = CardEnc.equals(lits=var_lits, bound=target, top_id=self.top_id, encoding=EncType.seqcounter)
        self.top_id = enc.nv
        self.cnf.extend(enc.clauses)

    def build_modular_parity_cut(self) -> int:
        r"""
        Injects the modular parity constraint:
          \sum_{p=0}^{32} t_p \equiv 231 \equiv 0 \pmod 3.
        Encoded via a sequential modular adder automaton with states {0, 1, 2}.
        """
        if not self.enable_modular:
            return 0

        initial_clauses = len(self.cnf.clauses)
        state_vars = {} # (step, r) -> var_id
        for i in range(self.num_orbits):
            for r in range(3):
                self.top_id += 1
                state_vars[(i, r)] = self.top_id

        # ALO and AMO for state variables at each step
        for i in range(self.num_orbits):
            self.cnf.append([state_vars[(i, 0)], state_vars[(i, 1)], state_vars[(i, 2)]])
            for r1 in range(3):
                for r2 in range(r1 + 1, 3):
                    self.cnf.append([-state_vars[(i, r1)], -state_vars[(i, r2)]])

        # Step 0 transition from base sum = 0
        t0 = self.t_vars[0]
        self.cnf.append([t0, state_vars[(0, 0)]])
        self.cnf.append([-t0, -state_vars[(0, 0)]])
        self.cnf.append([-t0, state_vars[(0, 1)]])
        self.cnf.append([t0, -state_vars[(0, 1)]])
        self.cnf.append([-state_vars[(0, 2)]])

        # Steps 1..32 transitions
        for i in range(1, self.num_orbits):
            ti = self.t_vars[i]
            for r in range(3):
                prev_same = state_vars[(i - 1, r)]
                prev_pred = state_vars[(i - 1, (r - 1) % 3)]
                curr = state_vars[(i, r)]
                # (prev_same and not ti) => curr
                self.cnf.append([-prev_same, ti, curr])
                # (prev_pred and ti) => curr
                self.cnf.append([-prev_pred, -ti, curr])

        # Final assertion: total sum mod 3 == 0 (since 231 mod 3 = 0)
        self.cnf.append([state_vars[(self.num_orbits - 1, 0)]])
        self.cnf.append([-state_vars[(self.num_orbits - 1, 1)]])
        self.cnf.append([-state_vars[(self.num_orbits - 1, 2)]])

        return len(self.cnf.clauses) - initial_clauses

    def build_canonical_orbit_ordering(self) -> int:
        r"""
        Injects canonical symmetry breaking ordering on triangular orbits:
          t_0 >= t_1 >= ... >= t_32.
        Coupled with sum(t_p) = 0 mod 3, this locks t_{3k} = t_{3k+1} = t_{3k+2}.
        """
        if not self.enable_orbit_order:
            return 0

        initial_clauses = len(self.cnf.clauses)
        # Monotonic chain: ~t_{p+1} | t_p
        for p in range(self.num_orbits - 1):
            self.cnf.append([-self.t_vars[p + 1], self.t_vars[p]])

        # If modular parity is also enabled, enforce equality within triplets:
        if self.enable_modular:
            for k in range(11):
                p0 = 3 * k
                p1 = p0 + 1
                p2 = p0 + 2
                # t_{p0} == t_{p1} == t_{p2}
                self.cnf.append([-self.t_vars[p0], self.t_vars[p1]])
                self.cnf.append([-self.t_vars[p1], self.t_vars[p0]])
                self.cnf.append([-self.t_vars[p1], self.t_vars[p2]])
                self.cnf.append([-self.t_vars[p2], self.t_vars[p1]])

        return len(self.cnf.clauses) - initial_clauses

    def build_degree_constraints(self):
        """Degree regularity k = 14 across all 33 orbits."""
        for p in range(self.num_orbits):
            lits = [self.t_vars[p], self.t_vars[p]]
            for q in range(self.num_orbits):
                if q != p:
                    for m in range(3):
                        lits.append(self.get_adj_lit(p, 0, q, m))
            self.add_card_equals(lits, 14)

    def build_structural_cuts(self):
        """Structural K_4-free cuts on orbit triangles."""
        for p in range(self.num_orbits):
            for q in range(p + 1, self.num_orbits):
                for k1 in range(3):
                    for k2 in range(k1 + 1, 3):
                        c1 = self.edge_vars[(p, q, k1)]
                        c2 = self.edge_vars[(p, q, k2)]
                        self.cnf.append([-self.t_vars[p], -c1, -c2])
                        self.cnf.append([-self.t_vars[q], -c1, -c2])

    def build_srg_constraints(self, verbose: bool = False):
        """Strongly regular graph common neighbor constraints across 1,617 pair orbits."""
        t0 = time.time()
        # 1. 33 Internal pairs: (p, 0) and (p, 1)
        for p in range(self.num_orbits):
            y_lits = []
            for r in range(self.num_orbits):
                if r != p:
                    for m in range(3):
                        a_u = self.get_adj_lit(p, 0, r, m)
                        a_v = self.get_adj_lit(p, 1, r, m)
                        y = self.get_and_lit(a_u, a_v)
                        if y != 0:
                            y_lits.append(y)
                            self.cnf.append([-self.t_vars[p], -y])
            self.add_card_equals([self.t_vars[p], self.t_vars[p]] + y_lits, 2)

        # 2. 1,584 Cross pairs: (p, 0) and (q, k) for p < q, k in {0, 1, 2}
        total_cross = self.num_orbits * (self.num_orbits - 1) // 2 * 3
        processed = 0
        for p in range(self.num_orbits):
            for q in range(p + 1, self.num_orbits):
                for k in range(3):
                    processed += 1
                    a_uw = self.get_adj_lit(p, 0, q, k)
                    y_lits = []
                    for r in range(self.num_orbits):
                        for m in range(3):
                            if (r == p and m == 0) or (r == q and m == k):
                                continue
                            a_uz = self.get_adj_lit(p, 0, r, m)
                            a_zw = self.get_adj_lit(r, m, q, k)
                            y = self.get_and_lit(a_uz, a_zw)
                            if y != 0:
                                y_lits.append(y)
                    self.add_card_equals([a_uw] + y_lits, 2)

            if verbose and ((p + 1) % 10 == 0 or p == self.num_orbits - 1):
                elapsed = time.time() - t0
                print(f"  [Z_3 FPF Common Neighbors] Orbit {p+1}/{self.num_orbits} ({processed}/{total_cross} pairs, {elapsed:.1f}s) | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

    def compile(self, verbose: bool = True) -> CNF:
        t0 = time.time()
        if verbose:
            print("=" * 80)
            print("Conway 99-Graph: Canonical Z_3 FPF Compiler (Fixed-Point-Free)")
            print(f"Modular Parity Cut: {self.enable_modular} | Triangular Orbit Order: {self.enable_orbit_order}")
            print("=" * 80)

        mod_clauses = self.build_modular_parity_cut()
        if verbose:
            print(f"[*] Modular parity cardinality cut (sum t_p = 0 mod 3): {mod_clauses} clauses.")

        order_clauses = self.build_canonical_orbit_ordering()
        if verbose:
            print(f"[*] Canonical triangular orbit ordering & triplet locking: {order_clauses} clauses.")

        self.build_degree_constraints()
        if verbose:
            print(f"[*] Degree regularity constraints (k=14): vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")

        self.build_structural_cuts()
        if verbose:
            print(f"[*] Structural K_4-free cuts on orbit triangles: clauses={len(self.cnf.clauses):,}.")

        self.build_srg_constraints(verbose=verbose)
        if verbose:
            print(f"[+] Total compilation finished in {time.time() - t0:.2f}s | Final: vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")
            print("=" * 80)

        return self.cnf

    def export_dimacs(self, filename: str):
        t0 = time.time()
        print(f"[*] Exporting DIMACS CNF to {filename}...", flush=True)
        self.cnf.to_file(filename)
        size_mb = os.path.getsize(filename) / (1024 * 1024)
        print(f"[+] Export complete: {filename} ({size_mb:.2f} MB, {len(self.cnf.clauses):,} clauses, {self.top_id:,} vars in {time.time() - t0:.2f}s).", flush=True)


# ==============================================================================
# 2. Z_3 with 3 Fixed Points (fixed3) Compiler
# ==============================================================================

class ConwayZ3Fixed3CanonicalCompiler:
    def __init__(self, lex_depth: Optional[int] = None, enable_lex: bool = True):
        self.lex_depth = lex_depth
        self.enable_lex = enable_lex
        self.cnf = CNF()
        self.top_id = 0

        self.edge_vars: Dict[Tuple[int, int, int], int] = {}
        self.aux_and: Dict[Tuple[int, int], int] = {}
        self.fixed_edges: Dict[Tuple[int, int, int], int] = {}

        self._init_variables()
        self._init_fixed_subgraphs()

    def _init_variables(self):
        # 32 orbits of length 3:
        # N0: orbits 0..3, N1: orbits 4..7, N2: orbits 8..11, W: orbits 12..31
        # No internal edges: E(p, p) = 0 for all 32 orbits (Crnkovic & Maksimovic 2020)
        # Variables X(p, q, d) for p < q and d in {0, 1, 2}
        for p in range(32):
            for q in range(p + 1, 32):
                for d in range(3):
                    self.top_id += 1
                    self.edge_vars[(p, q, d)] = self.top_id

        assert len(self.edge_vars) == 1488
        assert self.top_id == 1488

    def _init_fixed_subgraphs(self):
        """Fixes the induced 1-factors in N_0, N_1, N_2."""
        matched_pairs = [
            (range(0, 4), {(0, 1), (2, 3)}),    # N_0
            (range(4, 8), {(4, 5), (6, 7)}),    # N_1
            (range(8, 12), {(8, 9), (10, 11)})  # N_2
        ]
        for rng, matched in matched_pairs:
            for p in rng:
                for q in range(p + 1, rng.stop):
                    for d in range(3):
                        val = 1 if ((p, q) in matched and d == 0) else 0
                        self.fixed_edges[(p, q, d)] = val
                        var = self.edge_vars[(p, q, d)]
                        self.cnf.append([var] if val == 1 else [-var])

    def get_adj_lit(self, p1: int, t1: int, p2: int, t2: int) -> int:
        if p1 == p2:
            return 0 # no internal edges in any orbit
        elif p1 < p2:
            d = (t2 - t1) % 3
            if (p1, p2, d) in self.fixed_edges:
                return self.fixed_edges[(p1, p2, d)]
            return self.edge_vars[(p1, p2, d)]
        else: # p1 > p2
            d = (t1 - t2) % 3
            if (p2, p1, d) in self.fixed_edges:
                return self.fixed_edges[(p2, p1, d)]
            return self.edge_vars[(p2, p1, d)]

    def get_and_lit(self, lit1: int, lit2: int) -> int:
        if lit1 == 0 or lit2 == 0:
            return 0
        if lit1 == 1:
            return lit2
        if lit2 == 1:
            return lit1
        if lit1 == lit2:
            return lit1
        if lit1 > lit2:
            lit1, lit2 = lit2, lit1
        k = (lit1, lit2)
        if k not in self.aux_and:
            self.top_id += 1
            y = self.top_id
            self.cnf.append([-y, lit1])
            self.cnf.append([-y, lit2])
            self.cnf.append([y, -lit1, -lit2])
            self.aux_and[k] = y
        return self.aux_and[k]

    def add_card_equals(self, lits: List[int], bound: int):
        c = 0
        var_lits = []
        for l in lits:
            if l == 1:
                c += 1
            elif l != 0:
                var_lits.append(l)
        target = bound - c
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

        enc = CardEnc.equals(lits=var_lits, bound=target, top_id=self.top_id, encoding=EncType.seqcounter)
        self.top_id = enc.nv
        self.cnf.extend(enc.clauses)

    def build_degree_constraints(self):
        """Encodes degree regularity k=14 and block sub-degrees."""
        blocks = {
            "N0": list(range(0, 4)),
            "N1": list(range(4, 8)),
            "N2": list(range(8, 12)),
            "W": list(range(12, 32))
        }

        # Sub-degrees into blocks
        for p in blocks["N0"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N1"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N2"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] for t in range(3)], 10)

        for p in blocks["N1"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N0"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N2"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] for t in range(3)], 10)

        for p in blocks["N2"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N0"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N1"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] for t in range(3)], 10)

        for p in blocks["W"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N0"] for t in range(3)], 2)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N1"] for t in range(3)], 2)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N2"] for t in range(3)], 2)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] if q != p for t in range(3)], 8)

        # Global degree into orbit vertices: 13 if in N_i, 14 if in W
        for p in range(32):
            lits = [self.get_adj_lit(p, 0, q, t) for q in range(32) if q != p for t in range(3)]
            target = 13 if p < 12 else 14
            self.add_card_equals(lits, target)

    def build_common_neighbor_constraints(self, verbose: bool = False):
        """Encodes common neighbor constraints across all 1,520 pair orbits."""
        t0 = time.time()
        pair_orbits = []
        for p in range(32):
            for q in range(p, 32):
                if p == q:
                    pair_orbits.append(((p, 0), (p, 1)))
                else:
                    for dt in range(3):
                        pair_orbits.append(((p, 0), (q, dt)))

        assert len(pair_orbits) == 1520
        total_pairs = len(pair_orbits)

        for idx, (u, v) in enumerate(pair_orbits):
            p1, t1 = u
            p2, t2 = v

            in_n0 = (p1 < 4 and p2 < 4)
            in_n1 = (4 <= p1 < 8 and 4 <= p2 < 8)
            in_n2 = (8 <= p1 < 12 and 8 <= p2 < 12)
            c_fix = 1 if (in_n0 or in_n1 or in_n2) else 0
            target_bound = 2 - c_fix

            lits = []
            a_uv = self.get_adj_lit(p1, t1, p2, t2)
            if a_uv != 0:
                lits.append(a_uv)

            for q in range(32):
                for t in range(3):
                    w = (q, t)
                    if w == u or w == v:
                        continue
                    a_uw = self.get_adj_lit(p1, t1, q, t)
                    if a_uw == 0:
                        continue
                    a_vw = self.get_adj_lit(p2, t2, q, t)
                    if a_vw == 0:
                        continue
                    and_lit = self.get_and_lit(a_uw, a_vw)
                    if and_lit != 0:
                        lits.append(and_lit)

            self.add_card_equals(lits, target_bound)
            if verbose and ((idx + 1) % 300 == 0 or idx == total_pairs - 1):
                elapsed = time.time() - t0
                print(f"  [Z_3 Fixed-3 Common Neighbors] Processed {idx+1}/{total_pairs} pairs ({elapsed:.1f}s) | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

    def _compute_s3_z2_permutations(self) -> List[Tuple[str, Dict[int, int]]]:
        """
        Computes the permutation of the 1488 primary variables induced by each of
        the 11 non-identity elements of S_3 x Z_2 (order 12).
        """
        def map_orbit(p: int, pi: Tuple[int, int, int]) -> int:
            if p < 12:
                block = p // 4
                k = p % 4
                return 4 * pi[block] + k
            return p # W is fixed

        perms = []
        s3 = list(itertools.permutations([0, 1, 2]))
        z2 = [False, True]

        for pi in s3:
            for inv in z2:
                if pi == (0, 1, 2) and not inv:
                    continue # skip identity

                elem_name = f"pi={pi}_inv={inv}"
                var_perm = {}

                for (p, q, d), vid in self.edge_vars.items():
                    mp = map_orbit(p, pi)
                    mq = map_orbit(q, pi)
                    md = (3 - d) % 3 if inv else d

                    if mp < mq:
                        target_key = (mp, mq, md)
                    else:
                        target_d = (3 - md) % 3
                        target_key = (mq, mp, target_d)

                    target_vid = self.edge_vars[target_key]
                    var_perm[vid] = target_vid

                assert len(set(var_perm.values())) == len(self.edge_vars)
                perms.append((elem_name, var_perm))

        return perms

    def build_lex_leader_cuts(self, verbose: bool = False) -> int:
        r"""
        Injects canonical Lex-Leader symmetry breaking for S_3 x Z_2 (order 12)
        on the primary edge variables distinguishing N_0, N_1, N_2:
          X <=_lex g(X)
        """
        if not self.enable_lex:
            return 0

        perms = self._compute_s3_z2_permutations()
        total_lex_clauses = 0

        # Prioritize variables connecting N_i to each other and to W
        all_vids = list(self.edge_vars.values())
        if self.lex_depth is not None and self.lex_depth > 0:
            target_vids = all_vids[:self.lex_depth]
        else:
            target_vids = all_vids

        for elem_name, perm in perms:
            diff_pairs = [(v, perm[v]) for v in target_vids if v != perm[v]]
            if not diff_pairs:
                continue

            m = len(diff_pairs)
            c_prev = None
            elem_clauses = 0

            for k in range(m):
                a, b = diff_pairs[k]
                if k == 0:
                    self.cnf.append([-a, b])
                    elem_clauses += 1
                else:
                    self.cnf.append([-c_prev, -a, b])
                    elem_clauses += 1

                if k < m - 1:
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
            print(f"[Z_3 Fixed-3 Lex-Leader] Injected {total_lex_clauses:,} clauses across {len(perms)} symmetries | top_id={self.top_id:,}", flush=True)

        return total_lex_clauses

    def compile(self, verbose: bool = True) -> CNF:
        t0 = time.time()
        if verbose:
            print("=" * 80)
            print("Conway 99-Graph: Canonical Z_3 Fixed-3 Compiler (Fix = {x0, x1, x2})")
            print(f"S_3 x Z_2 Lex-Leader: {self.enable_lex} (depth: {self.lex_depth or 'full'})")
            print("=" * 80)

        self.build_degree_constraints()
        if verbose:
            print(f"[*] Degree regularity & quotient partition constraints: vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")

        self.build_common_neighbor_constraints(verbose=verbose)
        if verbose:
            print(f"[*] Common neighbor constraints across 1,520 pair orbits: vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")

        lex_clauses = self.build_lex_leader_cuts(verbose=verbose)
        if verbose:
            print(f"[*] S_3 x Z_2 Lex-Leader cuts injected: {lex_clauses:,} clauses.")
            print(f"[+] Total compilation finished in {time.time() - t0:.2f}s | Final: vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")
            print("=" * 80)

        return self.cnf

    def export_dimacs(self, filename: str):
        t0 = time.time()
        print(f"[*] Exporting DIMACS CNF to {filename}...", flush=True)
        self.cnf.to_file(filename)
        size_mb = os.path.getsize(filename) / (1024 * 1024)
        print(f"[+] Export complete: {filename} ({size_mb:.2f} MB, {len(self.cnf.clauses):,} clauses, {self.top_id:,} vars in {time.time() - t0:.2f}s).", flush=True)


# ==============================================================================
# CLI and Main Entry Point
# ==============================================================================

def parse_args():
    parser = argparse.ArgumentParser(description="Canonical Z_3 CNF Compiler (FPF and Fixed-3) for Conway 99-Graph")
    parser.add_argument("--mode", choices=["fpf", "fixed3", "all"], default="fpf", help="Symmetry profile mode to compile")
    parser.add_argument("--dry-run", action="store_true", help="Compile in memory and validate statistics without writing DIMACS")
    parser.add_argument("--output", type=str, default=None, help="Output DIMACS file path (defaults to conway_z3_<mode>_canonical.cnf)")
    parser.add_argument("--lex-depth", type=int, default=None, help="Depth limit for lex-leader chains in fixed3 mode")
    parser.add_argument("--skip-modular", action="store_true", help="Skip modular parity cardinality cut in fpf mode")
    parser.add_argument("--skip-orbit-order", action="store_true", help="Skip triangular orbit ordering in fpf mode")
    parser.add_argument("--skip-lex", action="store_true", help="Skip lex-leader symmetry breaking in fixed3 mode")
    return parser.parse_args()

def run_fpf(args):
    out_file = args.output or "conway_z3_fpf_canonical.cnf"
    compiler = ConwayZ3FPFCanonicalCompiler(
        enable_modular=(not args.skip_modular),
        enable_orbit_order=(not args.skip_orbit_order)
    )
    compiler.compile(verbose=True)
    if args.dry_run:
        print("[DRY-RUN] Z_3 FPF validation complete. DIMACS export skipped.")
    else:
        compiler.export_dimacs(out_file)

def run_fixed3(args):
    out_file = args.output or "conway_z3_fixed3_canonical.cnf"
    compiler = ConwayZ3Fixed3CanonicalCompiler(
        lex_depth=args.lex_depth,
        enable_lex=(not args.skip_lex)
    )
    compiler.compile(verbose=True)
    if args.dry_run:
        print("[DRY-RUN] Z_3 Fixed-3 validation complete. DIMACS export skipped.")
    else:
        compiler.export_dimacs(out_file)

def main():
    args = parse_args()
    if args.mode == "fpf":
        run_fpf(args)
    elif args.mode == "fixed3":
        run_fixed3(args)
    elif args.mode == "all":
        run_fpf(args)
        run_fixed3(args)

if __name__ == "__main__":
    main()
