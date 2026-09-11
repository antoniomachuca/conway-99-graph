"""
Conway 99-Graph CNF Compiler: Symmetry Profile Z_3 Fixed-Point-Free (fpf)
Algebraic Combinatorics & SAT Formalization for SRG(99, 14, 1, 2)

Mathematical Specification:
1. Automorphism group Z_3 = <g> acting fixed-point-free on V (99 vertices).
   - 33 orbits O_0, ..., O_32 of length 3.
   - Vertices: v_{p, k} with p in {0, ..., 32}, k in {0, 1, 2}.
   - Generator action: g(v_{p, k}) = v_{p, (k + 1) % 3}.
2. Variables:
   - Diagonal blocks: c_{p, p, 0} = 0, and c_{p, p, 1} = c_{p, p, 2} = t_p in {0, 1}.
     t_p = 1 indicates O_p induces a triangle K_3 (internal degree 2).
     t_p = 0 indicates O_p is an independent set (internal degree 0).
   - Off-diagonal blocks: for p < q, circulant variables c_{p, q, k} in {0, 1} for k in {0, 1, 2},
     where A(v_{p, i}, v_{q, j}) = c_{p, q, (j - i) % 3}.
3. Degree regularity:
   - For each orbit p in {0, ..., 32}:
     deg(v_{p, 0}) = 2 * t_p + sum_{q != p} (c_{p, q, 0} + c_{p, q, 1} + c_{p, q, 2}) = 14.
4. Strongly Regular Parameters (k = 14, lambda = 1, mu = 2):
   Fixing u = v_{p, 0}, for every target vertex w:
   - Internal pair w = v_{p, 1}:
     (A^2)_{v_{p, 0}, v_{p, 1}} = 1 if t_p = 1, or 2 if t_p = 0.
     Internal common neighbor is v_{p, 2} (present iff t_p = 1).
     Unconditional algebraic relation: 2 * t_p + sum_{r != p, m} (A(v_{p, 0}, v_{r, m}) and A(v_{p, 1}, v_{r, m})) = 2.
   - Cross pair w = v_{q, k} (p < q, k in {0, 1, 2}):
     (A^2)_{v_{p, 0}, v_{q, k}} = sum_{z != u, w} A(u, z) * A(z, w).
     SRG relation: c_{p, q, k} + (A^2)_{v_{p, 0}, v_{q, k}} = 2.
5. Structural Cuts:
   - K_4-free: lambda = 1 forbids any 4 mutually adjacent vertices.
   - Orbit triangle cut: if t_p = 1 (O_p is K_3), no external vertex can be adjacent to >= 2 vertices of O_p.
     Hence, for all q != p: c_{min(p,q), max(p,q), 0} + c_{min(p,q), max(p,q), 1} + c_{min(p,q), max(p,q), 2} <= 1 when t_p = 1.
     Encoded as ternary clauses: ~t_p | ~c_{p, q, a} | ~c_{p, q, b} for all a < b.
     Symmetrically for t_q = 1.
   - Internal pair binary cuts: if t_p = 1, no external common neighbor between v_{p, 0} and v_{p, 1} can exist (~t_p | ~Y).
6. Target Output:
   - conway_z3_fpf.cnf (DIMACS CNF).
"""

import os
import sys
import time
from typing import Dict, List, Tuple
from pysat.formula import CNF
from pysat.card import CardEnc, EncType

class ConwayZ3FPFCompiler:
    def __init__(self, num_orbits: int = 33):
        self.num_orbits = num_orbits
        self.cnf = CNF()
        self.top_id = 0

        # Primary Boolean Variables
        self.t_vars: Dict[int, int] = {}                    # p -> var_id (triangle indicator for orbit p)
        self.edge_vars: Dict[Tuple[int, int, int], int] = {} # (p, q, k) -> var_id for p < q, k in {0, 1, 2}
        
        # Tseitin Conjunction Cache: (min(l1, l2), max(l1, l2)) -> aux_var_id
        self.aux_and: Dict[Tuple[int, int], int] = {}

        self._init_variables()

    def _init_variables(self):
        """
        Initializes primary variables under Z_3 fixed-point-free symmetry.
        Total 33 orbits of length 3 (33 * 3 = 99 vertices).
        """
        # 1. Diagonal triangle variables t_p for p = 0 .. 32
        for p in range(self.num_orbits):
            self.top_id += 1
            self.t_vars[p] = self.top_id

        # 2. Off-diagonal circulant edge variables c_{p, q, k} for p < q and k in {0, 1, 2}
        # 33 * 32 / 2 = 528 pairs * 3 = 1584 variables
        for p in range(self.num_orbits):
            for q in range(p + 1, self.num_orbits):
                for k in range(3):
                    self.top_id += 1
                    self.edge_vars[(p, q, k)] = self.top_id

        print(f"[Z_3 FPF] Primary variables allocated: {self.top_id} "
              f"(t_p: {len(self.t_vars)}, c_{{p, q, k}}: {len(self.edge_vars)})", flush=True)

    def get_adj_lit(self, p: int, i: int, q: int, j: int) -> int:
        """
        Returns the adjacency literal A(v_{p, i}, v_{q, j}):
        - 0 if p == q and i == j (no self loops)
        - t_p if p == q and i != j (internal edges exist iff t_p = 1)
        - c_{p, q, (j - i) % 3} if p < q
        - c_{q, p, (i - j) % 3} if p > q
        """
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
        """
        Tseitin encoding for conjunction: y <=> (l1 AND l2).
        Includes constant folding and deduplication.
        """
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
        Degree regularity k = 14 for all vertices:
        For vertex v_{p, 0}:
        deg(v_{p, 0}) = 2 * t_p + sum_{q != p} (c_{p, q, 0} + c_{p, q, 1} + c_{p, q, 2}) = 14.
        """
        print("[Z_3 FPF] Encoding degree regularity (k=14) for all 33 orbits...", flush=True)
        t0 = time.time()
        for p in range(self.num_orbits):
            lits = [self.t_vars[p], self.t_vars[p]]
            for q in range(self.num_orbits):
                if q != p:
                    for m in range(3):
                        lits.append(self.get_adj_lit(p, 0, q, m))
            self.add_card_equals(lits, 14)

        elapsed = time.time() - t0
        print(f"[Z_3 FPF] Degree constraints complete ({elapsed:.2f}s) | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

    def build_structural_cuts(self):
        """
        Structural cuts:
        1. Orbit triangle K_4-free cut:
           If t_p = 1 (O_p is K_3), no external vertex can be adjacent to >= 2 vertices of O_p.
           Hence, for every q != p and 0 <= k1 < k2 <= 2:
             ~t_p | ~c_{p, q, k1} | ~c_{p, q, k2}
           and symmetrically for t_q = 1:
             ~t_q | ~c_{p, q, k1} | ~c_{p, q, k2}.
        """
        print("[Z_3 FPF] Encoding structural K_4-free cuts on orbit triangles...", flush=True)
        t0 = time.time()
        cuts_count = 0
        for p in range(self.num_orbits):
            for q in range(p + 1, self.num_orbits):
                for k1 in range(3):
                    for k2 in range(k1 + 1, 3):
                        c1 = self.edge_vars[(p, q, k1)]
                        c2 = self.edge_vars[(p, q, k2)]
                        # If t_p = 1, at most one edge between O_p and O_q
                        self.cnf.append([-self.t_vars[p], -c1, -c2])
                        # If t_q = 1, at most one edge between O_p and O_q
                        self.cnf.append([-self.t_vars[q], -c1, -c2])
                        cuts_count += 2

        elapsed = time.time() - t0
        print(f"[Z_3 FPF] Structural cuts complete ({cuts_count:,} clauses in {elapsed:.2f}s) | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

    def build_srg_constraints(self):
        """
        Strongly Regular Parameters (lambda = 1, mu = 2):
        Evaluated on all 1,617 pair orbits under Z_3 symmetry:
        1. 33 Internal pair orbits: (v_{p, 0}, v_{p, 1})
           A(u, v) + (A^2)_{u, v} = 2 * t_p + sum_{r != p, m} (A(v_{p, 0}, v_{r, m}) AND A(v_{p, 1}, v_{r, m})) = 2.
           Binary cut: t_p = 1 implies no external common neighbors (~t_p | ~Y).
        2. 1,584 Cross pair orbits: (v_{p, 0}, v_{q, k}) for p < q and k in {0, 1, 2}
           c_{p, q, k} + sum_{z != u, w} (A(u, z) AND A(z, w)) = 2.
        """
        print("[Z_3 FPF] Encoding strongly regular parameters across 1,617 pair orbits...", flush=True)
        t0 = time.time()

        # 1. Internal pairs: (p, 0) and (p, 1)
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
                            # Direct binary cut: if t_p = 1, no external common neighbor
                            self.cnf.append([-self.t_vars[p], -y])
            # Algebraic equation: 2 * t_p + sum(y) == 2
            self.add_card_equals([self.t_vars[p], self.t_vars[p]] + y_lits, 2)

        elapsed_internal = time.time() - t0
        print(f"  Internal pair constraints complete (33 orbits in {elapsed_internal:.2f}s) | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

        # 2. Cross pairs: (p, 0) and (q, k) for p < q, k in {0, 1, 2}
        t1 = time.time()
        total_cross_pairs = self.num_orbits * (self.num_orbits - 1) // 2 * 3
        processed = 0

        for p in range(self.num_orbits):
            for q in range(p + 1, self.num_orbits):
                for k in range(3):
                    processed += 1
                    a_uw = self.get_adj_lit(p, 0, q, k)  # c_{p, q, k}
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
                    # Algebraic equation: c_{p, q, k} + (A^2)_{u, w} == 2
                    self.add_card_equals([a_uw] + y_lits, 2)

            if (p + 1) % 5 == 0 or p == self.num_orbits - 1:
                elapsed_cross = time.time() - t1
                print(f"  Processed orbit {p+1}/{self.num_orbits} ({processed}/{total_cross_pairs} cross pairs, {elapsed_cross:.1f}s) | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

        total_elapsed = time.time() - t0
        print(f"[Z_3 FPF] Common neighbor constraints complete in {total_elapsed:.2f}s | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

    def export_dimacs(self, filename: str = "conway_z3_fpf.cnf"):
        """
        Exports the CNF instance to DIMACS format.
        """
        print(f"[Z_3 FPF] Exporting DIMACS CNF to {filename}...", flush=True)
        t0 = time.time()
        self.cnf.to_file(filename)
        elapsed = time.time() - t0
        file_size_mb = os.path.getsize(filename) / (1024 * 1024)
        print(f"[Z_3 FPF] Export finished: {filename} ({file_size_mb:.2f} MB, {len(self.cnf.clauses):,} clauses, {self.top_id:,} variables in {elapsed:.2f}s).", flush=True)

if __name__ == "__main__":
    t_start = time.time()
    print("=" * 75)
    print("Conway 99-Graph CNF Compiler: Symmetry Profile Z_3 Fixed-Point-Free")
    print("=" * 75)
    compiler = ConwayZ3FPFCompiler(num_orbits=33)
    compiler.build_degree_constraints()
    compiler.build_structural_cuts()
    compiler.build_srg_constraints()
    compiler.export_dimacs("conway_z3_fpf.cnf")
    total_time = time.time() - t_start
    print(f"[Z_3 FPF] Compilation pipeline successfully finished in {total_time:.2f}s.")
    print("=" * 75)
