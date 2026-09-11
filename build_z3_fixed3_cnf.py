"""
Conway 99-Graph CNF Compiler: Symmetry Profile Z_3 (3 Fixed Points)
Algebraic Combinatorics & SAT Formalization for SRG(99, 14, 1, 2)
Author: SAT Compiler Agent (Combinatorial SAT & Group Actions Specialist)

Problem Specification:
1. Automorphism group Z_3 = <sigma> with Fix(sigma) = {x_0, x_1, x_2}.
   The 3 fixed points form a triangle K_3.
2. Each neighborhood N_i = N(x_i) \ {the other two} has size 12 and decomposes
   into 4 orbits of size 3 (O_0..O_3 for N_0, O_4..O_7 for N_1, O_8..O_11 for N_2).
   Each N_i induces a 1-factor of 6*K_2 (two 3-edge matchings between orbit pairs).
3. The remaining 60 vertices W decompose into 20 orbits of length 3 (O_12..O_31),
   each vertex having exactly 2 neighbors in N_0, 2 in N_1, and 2 in N_2.
4. Internal orbit degrees E(p, p) = 0 for all 32 orbits (Crnkovic & Maksimovic 2020).
5. Degree regularity (k=14) and common neighbor constraints (lambda=1, mu=2)
   are compiled into CNF via sequential counter cardinality encodings.
6. Export to conway_z3_fixed3.cnf with DRAT proof tracing capability.
"""

import os
import sys
import time
from typing import Dict, List, Tuple, Optional
from pysat.formula import CNF
from pysat.card import CardEnc, EncType

class ConwayZ3Compiler:
    def __init__(self):
        self.cnf = CNF()
        self.top_id = 0
        self.edge_vars: Dict[Tuple[int, int, int], int] = {}
        self.aux_and: Dict[Tuple[int, int], int] = {}
        self.fixed_edges: Dict[Tuple, int] = {}

        self._init_variables()
        self._init_fixed_subgraphs()

    def _init_variables(self):
        """
        Initializes the primary Boolean edge variables under Z_3 symmetry.
        Total 32 orbits of length 3:
          N_0: orbits 0..3 (12 vertices)
          N_1: orbits 4..7 (12 vertices)
          N_2: orbits 8..11 (12 vertices)
          W:   orbits 12..31 (60 vertices)
        """
        # Crnkovic & Maksimovic (2020) Lemma: No orbit of length 3 has internal edges.
        # Thus E(p, p) = 0 for all 32 orbits.
        for p in range(32):
            self.fixed_edges[(p, p)] = 0

        # Primary circulant variables X(p, q, d) for p < q and d in {0, 1, 2}.
        # Total pairs = 32 * 31 / 2 = 496 pairs, each having 3 differences -> 1488 variables.
        for p in range(32):
            for q in range(p + 1, 32):
                for d in range(3):
                    self.top_id += 1
                    self.edge_vars[(p, q, d)] = self.top_id

    def _init_fixed_subgraphs(self):
        """
        Fixes the induced 1-factors in N_0, N_1, N_2:
        - In N_0: O_0 matched to O_1, O_2 matched to O_3 (6*K_2).
        - In N_1: O_4 matched to O_5, O_6 matched to O_7 (6*K_2).
        - In N_2: O_8 matched to O_9, O_10 matched to O_11 (6*K_2).
        All other pairs within N_i are strictly 0.
        """
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
        """
        Returns the adjacency literal between (p1, t1) and (p2, t2):
        - Returns 0 if known non-adjacent
        - Returns 1 if known adjacent
        - Returns variable ID > 1 if unknown
        """
        if p1 == p2:
            return 0
        elif p1 < p2:
            d = (t2 - t1) % 3
            if (p1, p2, d) in self.fixed_edges:
                return self.fixed_edges[(p1, p2, d)]
            return self.edge_vars[(p1, p2, d)]
        else:
            d = (t1 - t2) % 3
            if (p2, p1, d) in self.fixed_edges:
                return self.fixed_edges[(p2, p1, d)]
            return self.edge_vars[(p2, p1, d)]

    def get_and_lit(self, lit1: int, lit2: int) -> int:
        """
        Tseitin encoding for conjunction: y <=> (lit1 AND lit2).
        Includes constant folding and deduplication.
        """
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
        """
        Encodes sum(lits) == bound with constant pruning and sequential counter.
        """
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
        """
        Encodes degree regularity k = 14:
        - Fixed points x_0, x_1, x_2 have degree 14 by construction.
        - Orbit vertices (p, 0):
          For p in N_i: 1 to x_i + 1 in N_i + 1 in each of other two N_j + 10 in W = 14.
          For p in W:   0 to fixed points + 2 in N_0 + 2 in N_1 + 2 in N_2 + 8 in W = 14.
        """
        print("[Z_3 Fixed-3] Encoding degree regularity (k=14) and orbit quotient partition...", flush=True)
        blocks = {
            "N0": list(range(0, 4)),
            "N1": list(range(4, 8)),
            "N2": list(range(8, 12)),
            "W": list(range(12, 32))
        }

        # Sub-degree constraints into blocks
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

        # Global degree into orbit vertices
        for p in range(32):
            lits = [self.get_adj_lit(p, 0, q, t) for q in range(32) if q != p for t in range(3)]
            target = 13 if p < 12 else 14
            self.add_card_equals(lits, target)

    def build_common_neighbor_constraints(self):
        """
        Encodes common neighbor property:
          |N(u) cap N(v)| = lambda = 1 if u ~ v
          |N(u) cap N(v)| = mu = 2     if u !~ v
        Equivalently:
          A(u, v) + sum_{w != u,v} (A(u, w) AND A(v, w)) = 2 - c_fix(u, v)
        where c_fix(u, v) = 1 if u, v in same N_i, else 0.
        Evaluated on all 1,520 pair orbits under Z_3 symmetry.
        """
        print("[Z_3 Fixed-3] Encoding common neighbor constraints across 1,520 pair orbits...", flush=True)
        t0 = time.time()
        pair_orbits = []
        for p in range(32):
            for q in range(p, 32):
                if p == q:
                    pair_orbits.append(((p, 0), (p, 1)))
                else:
                    for dt in range(3):
                        pair_orbits.append(((p, 0), (q, dt)))

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
            if (idx + 1) % 300 == 0 or idx == total_pairs - 1:
                elapsed = time.time() - t0
                print(f"  Processed {idx+1}/{total_pairs} pair orbits ({elapsed:.1f}s) | clauses={len(self.cnf.clauses):,} | vars={self.top_id:,}", flush=True)

    def export_dimacs(self, filename: str = "conway_z3_fixed3.cnf"):
        print(f"[Z_3 Fixed-3] Exporting DIMACS CNF to {filename}...", flush=True)
        self.cnf.to_file(filename)
        file_size_mb = os.path.getsize(filename) / (1024 * 1024)
        print(f"[Z_3 Fixed-3] Export complete: {filename} ({file_size_mb:.2f} MB, {len(self.cnf.clauses):,} clauses, {self.top_id:,} variables).", flush=True)

if __name__ == "__main__":
    t_start = time.time()
    compiler = ConwayZ3Compiler()
    compiler.build_degree_constraints()
    compiler.build_common_neighbor_constraints()
    compiler.export_dimacs("conway_z3_fixed3.cnf")
    print(f"[Z_3 Fixed-3] Total compilation time: {time.time() - t_start:.2f}s")
