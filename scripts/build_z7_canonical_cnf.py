#!/usr/bin/env python3
r"""
scripts/build_z7_canonical_cnf.py

Canonical SAT / CNF Compiler for the Conway 99-Graph under Z_7 Symmetry
Profile: Automorphism of Order 7 fixing a single vertex x_0.

Theoretical Foundations:
1. Cesarz & Woldar (2025), "Automorphisms of Conway's 99-graph":
   - Automorphism group order divisibility: 7 | |Aut(G)| => Aut(G) \cong Z_7.
   - Decomposition of V(G) into 1 fixed point x_0, 2 orbits of size 7 in Gamma_1(x_0)
     (labeled L and R, forming a 1-factor matching 7*K_2), and 12 orbits of size 7
     in Gamma_2(x_0) (84 vertices).
   - Canonical 12 orbits of Gamma_2(x_0):
     * 3 LL orbits: (LL)_1, (LL)_2, (LL)_3 (orbits 0, 1, 2; distances d in {1, 2, 3})
     * 3 RR orbits: (RR)_1, (RR)_2, (RR)_3 (orbits 3, 4, 5; distances d in {1, 2, 3})
     * 6 LR orbits: (LR)_1 .. (LR)_6 (orbits 6..11; shifts s in {1, 2, 3, 4, 5, 6})
2. General Internal Orbit Valences:
   - For any orbit p in {0, ..., 11}, the internal valence b_pp in {0, 2} is permitted.
   - Diagonal circulant variables x_{(p, p, d)} for d in {1, 2, 3}.
   - At-most-one constraint: sum_{d=1}^3 x_{(p, p, d)} <= 1 for each orbit p.
3. Full Lex-Leader Symmetry Breaking for Quotient Group G_{Z_7} \cong Z_2 \times Z_6 (order 12):
   - Multiplier group Aut(Z_7) \cong Z_7^* \cong Z_6 (multiplication by m in {1, ..., 6} mod 7).
   - Reflection / Swap involution Z_2 (swapping L <-> R).
   - The direct product G_{Z_7} = Z_2 \times Z_6 acts faithfully on the 498 primary variables.
   - For all 11 non-identity elements g in G_{Z_7} \ {e}, canonical Crawford lex-leader
     constraints X <=_lex g(X) are injected to eliminate all 12 quotient symmetries.
"""

import os
import sys
import time
import argparse
from typing import Dict, List, Tuple, Optional, Set
from pysat.formula import CNF
from pysat.card import CardEnc, EncType

class ConwayZ7CanonicalCompiler:
    def __init__(self, lex_depth: Optional[int] = None, enable_lex: bool = True):
        self.lex_depth = lex_depth
        self.enable_lex = enable_lex
        self.cnf = CNF()
        self.top_id = 0

        # Geometry & Variable containers
        self.coords: Dict[Tuple[int, int], Set[str]] = {}
        self.all_coords: List[str] = []
        self.primary_vars: List[Tuple] = []
        self.var_map: Dict[Tuple, int] = {}
        self.aux_and: Dict[Tuple[int, int], int] = {}

        self._init_geometry()
        self._init_primary_variables()

    def _init_geometry(self):
        """
        Initializes the canonical coordinates of the 84 vertices in Gamma_2(x_0)
        following Cesarz & Woldar (2025):
        - Orbits 0, 1, 2 (LL): coordinates in L with distances 1, 2, 3
        - Orbits 3, 4, 5 (RR): coordinates in R with distances 1, 2, 3
        - Orbits 6..11   (LR): coordinates in L x R with shifts 1..6
        """
        for p in range(12):
            for t in range(7):
                if p in (0, 1, 2):
                    d = p + 1
                    i1 = (0 + t) % 7 + 1
                    i2 = (d + t) % 7 + 1
                    self.coords[(p, t)] = {f"{i1}L", f"{i2}L"}
                elif p in (3, 4, 5):
                    d = (p - 3) + 1
                    i1 = (0 + t) % 7 + 1
                    i2 = (d + t) % 7 + 1
                    self.coords[(p, t)] = {f"{i1}R", f"{i2}R"}
                else: # p in 6..11
                    d = (p - 6) + 1
                    i1 = (0 + t) % 7 + 1
                    i2 = (d + t) % 7 + 1
                    self.coords[(p, t)] = {f"{i1}L", f"{i2}R"}

        self.all_coords = [f"{i}L" for i in range(1, 8)] + [f"{i}R" for i in range(1, 8)]

    def _init_primary_variables(self):
        """
        Allocates primary circulant Boolean variables:
        - Diagonal: (p, p, d) for p in 0..11, d in 1..3 (12 * 3 = 36 vars)
        - Off-diagonal: (p, q, d) for 0 <= p < q < 12, d in 0..6 (66 * 7 = 462 vars)
        Total primary variables = 498.
        """
        # 1. Diagonal variables (allowing b_pp in {0, 2})
        for p in range(12):
            for d in range(1, 4):
                self.top_id += 1
                self.var_map[(p, p, d)] = self.top_id
                self.primary_vars.append((p, p, d))

        # 2. Off-diagonal variables
        for p in range(12):
            for q in range(p + 1, 12):
                for d in range(7):
                    self.top_id += 1
                    self.var_map[(p, q, d)] = self.top_id
                    self.primary_vars.append((p, q, d))

        assert len(self.primary_vars) == 498
        assert self.top_id == 498

    def get_adj_lit(self, p1: int, t1: int, p2: int, t2: int) -> int:
        """
        Returns the Boolean literal representing adjacency between (p1, t1) and (p2, t2).
        Returns 0 if non-adjacent by definition (self-loops).
        """
        if p1 == p2:
            diff = (t2 - t1) % 7
            if diff == 0:
                return 0
            d = min(diff, 7 - diff)
            return self.var_map[(p1, p1, d)]
        elif p1 < p2:
            diff = (t2 - t1) % 7
            return self.var_map[(p1, p2, diff)]
        else: # p1 > p2
            diff = (t1 - t2) % 7
            return self.var_map[(p2, p1, diff)]

    def get_and_lit(self, a: int, b: int) -> int:
        """
        Tseitin encoding for conjunction: y <=> a AND b.
        Includes constant propagation and deduplication.
        """
        if a == 0 or b == 0:
            return 0
        if a == 1:
            return b
        if b == 1:
            return a
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
        """
        Encodes sum(lits) == bound with sequential counter and constant pruning.
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

    def build_internal_valence_cuts(self):
        """
        Encodes b_pp in {0, 2} for all 12 orbits p in {0, ..., 11}:
        At most one distance d in {1, 2, 3} can be active per orbit:
          sum_{d=1}^3 x_{(p, p, d)} <= 1.
        Equivalent to pairwise AMO clauses: ~x_{(p, p, d1)} | ~x_{(p, p, d2)}.
        """
        amo_count = 0
        for p in range(12):
            for d1 in range(1, 4):
                for d2 in range(d1 + 1, 4):
                    v1 = self.var_map[(p, p, d1)]
                    v2 = self.var_map[(p, p, d2)]
                    self.cnf.append([-v1, -v2])
                    amo_count += 1
        return amo_count

    def build_coordinate_constraints(self):
        """
        Encodes Lemma 4.7 coordinate intersection constraints:
        For every vertex v = (p, 0) and coordinate K in Gamma_1(x_0):
        sum_{w in Gamma_2, K in c_w} A(v, w) = 1 if K in c_v U opp(c_v) else 2.
        """
        for p in range(12):
            v = (p, 0)
            c_v = self.coords[v]
            opp_v = {f"{c[:-1]}{'R' if c.endswith('L') else 'L'}" for c in c_v}
            for K in self.all_coords:
                lits = []
                for q in range(12):
                    for t in range(7):
                        if (q, t) == v:
                            continue
                        if K in self.coords[(q, t)]:
                            adj = self.get_adj_lit(p, 0, q, t)
                            if adj != 0:
                                lits.append(adj)
                bound = 1 if (K in c_v or K in opp_v) else 2
                self.add_card_equals(lits, bound)

    def build_common_neighbor_constraints(self, verbose: bool = False):
        """
        Encodes strongly regular graph common neighbor parameters (lambda=1, mu=2):
        A(u, v) + sum_{w != u, v} (A(u, w) AND A(v, w)) = 2 - |c_u cap c_v|.
        Evaluated across all 498 pair orbits under Z_7 action.
        """
        t0 = time.time()
        pair_orbits = []
        for p in range(12):
            for q in range(p, 12):
                if p == q:
                    for dt in range(1, 4):
                        pair_orbits.append(((p, 0), (q, dt)))
                else:
                    for dt in range(7):
                        pair_orbits.append(((p, 0), (q, dt)))

        assert len(pair_orbits) == 498
        total_pairs = len(pair_orbits)

        for idx, (u, v) in enumerate(pair_orbits):
            c_uv = len(self.coords[u].intersection(self.coords[v]))
            target_bound = 2 - c_uv
            a_uv = self.get_adj_lit(u[0], u[1], v[0], v[1])
            lits = [a_uv] if a_uv != 0 else []

            for q in range(12):
                for t in range(7):
                    w = (q, t)
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
            if verbose and ((idx + 1) % 100 == 0 or idx == total_pairs - 1):
                elapsed = time.time() - t0
                print(f"  [Z_7 Common Neighbors] Processed {idx+1}/{total_pairs} pairs ({elapsed:.1f}s) | vars={self.top_id:,} | clauses={len(self.cnf.clauses):,}", flush=True)

    def _compute_group_permutations(self) -> List[Tuple[str, Dict[int, int]]]:
        r"""
        Computes the permutation of the 498 primary variables induced by each of
        the 11 non-identity elements of G_{Z_7} \cong Z_2 x Z_6 (order 12).
        Returns list of (element_name, var_permutation_dict).
        """
        perms = []
        for sigma in (0, 1): # 0 = identity, 1 = swap L <-> R
            for m in range(1, 7): # multiplier in Z_7^* = {1..6}
                if sigma == 0 and m == 1:
                    continue # skip identity

                elem_name = f"sigma={sigma}_mult={m}"

                # 1. Action on coordinate labels:
                def map_coord(c: str) -> str:
                    idx = int(c[:-1])
                    side = c[-1]
                    new_idx = (m * idx) % 7
                    if new_idx == 0:
                        new_idx = 7
                    new_side = ("R" if side == "L" else "L") if sigma == 1 else side
                    return f"{new_idx}{new_side}"

                # 2. Action on Gamma_2 vertices (p, t) -> (q, s):
                vertex_map = {}
                for p in range(12):
                    for t in range(7):
                        mapped_c = {map_coord(c) for c in self.coords[(p, t)]}
                        for q in range(12):
                            for s in range(7):
                                if self.coords[(q, s)] == mapped_c:
                                    vertex_map[(p, t)] = (q, s)
                                    break

                # 3. Action on primary variables:
                var_perm = {}
                for p1, p2, d in self.primary_vars:
                    orig_vid = self.var_map[(p1, p2, d)]
                    u = (p1, 0)
                    w = (p2, d)
                    gu = vertex_map[u]
                    gw = vertex_map[w]
                    # Compute mapped variable
                    q1, s1 = gu
                    q2, s2 = gw
                    if q1 == q2:
                        diff = (s2 - s1) % 7
                        assert diff != 0
                        dist = min(diff, 7 - diff)
                        target_key = (q1, q1, dist)
                    elif q1 < q2:
                        diff = (s2 - s1) % 7
                        target_key = (q1, q2, diff)
                    else:
                        diff = (s1 - s2) % 7
                        target_key = (q2, q1, diff)

                    target_vid = self.var_map[target_key]
                    var_perm[orig_vid] = target_vid

                assert len(set(var_perm.values())) == 498
                perms.append((elem_name, var_perm))

        return perms

    def build_lex_leader_cuts(self, verbose: bool = False):
        r"""
        Injects canonical Crawford Lex-Leader symmetry-breaking constraints
        for all 11 non-identity elements of G_{Z_7} \cong Z_2 x Z_6:
          X <=_lex g(X)
        """
        if not self.enable_lex:
            return 0

        perms = self._compute_group_permutations()
        total_lex_clauses = 0
        primary_vids = [self.var_map[k] for k in self.primary_vars]

        if self.lex_depth is not None and self.lex_depth > 0:
            target_vids = primary_vids[:self.lex_depth]
        else:
            target_vids = primary_vids

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
            print(f"[Z_7 Lex-Leader] Injected {total_lex_clauses:,} clauses across {len(perms)} symmetries | top_id={self.top_id:,}", flush=True)

        return total_lex_clauses

    def compile(self, verbose: bool = True) -> CNF:
        """
        Executes complete compilation pipeline for canonical Z_7 CNF.
        """
        t0 = time.time()
        if verbose:
            print("=" * 80)
            print("Conway 99-Graph: Canonical Z_7 CNF Compiler (Cesarz & Woldar 2025)")
            print(f"Internal valence: b_pp in {{0, 2}} | G_{{Z_7}} Lex-Leader: {self.enable_lex} (depth: {self.lex_depth or 'full'})")
            print("=" * 80)

        amo_cuts = self.build_internal_valence_cuts()
        if verbose:
            print(f"[*] Internal valence cuts (b_pp in {{0, 2}}): {amo_cuts} clauses.")

        self.build_coordinate_constraints()
        if verbose:
            print(f"[*] Coordinate constraints (Lemma 4.7): vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")

        self.build_common_neighbor_constraints(verbose=verbose)
        if verbose:
            print(f"[*] SRG common neighbor constraints (lambda=1, mu=2): vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")

        lex_clauses = self.build_lex_leader_cuts(verbose=verbose)
        if verbose:
            print(f"[*] Full G_{{Z_7}} Lex-Leader cuts injected: {lex_clauses:,} clauses.")
            print(f"[+] Total compilation finished in {time.time() - t0:.2f}s | Final: vars={self.top_id:,}, clauses={len(self.cnf.clauses):,}.")
            print("=" * 80)

        return self.cnf

    def export_dimacs(self, filename: str):
        t0 = time.time()
        print(f"[*] Exporting DIMACS CNF to {filename}...", flush=True)
        self.cnf.to_file(filename)
        size_mb = os.path.getsize(filename) / (1024 * 1024)
        print(f"[+] Export complete: {filename} ({size_mb:.2f} MB, {len(self.cnf.clauses):,} clauses, {self.top_id:,} vars in {time.time() - t0:.2f}s).", flush=True)

def parse_args():
    parser = argparse.ArgumentParser(description="Canonical Z_7 CNF Compiler for Conway's 99-Graph")
    parser.add_argument("--dry-run", action="store_true", help="Compile and validate in memory without writing DIMACS file")
    parser.add_argument("--output", type=str, default="conway_z7_canonical.cnf", help="Output DIMACS file path")
    parser.add_argument("--lex-depth", type=int, default=None, help="Depth limit for lex-leader chains (default: full)")
    parser.add_argument("--skip-lex", action="store_true", help="Omit lex-leader symmetry-breaking cuts")
    return parser.parse_args()

def main():
    args = parse_args()
    compiler = ConwayZ7CanonicalCompiler(
        lex_depth=args.lex_depth,
        enable_lex=(not args.skip_lex)
    )
    compiler.compile(verbose=True)

    if args.dry_run:
        print("[DRY-RUN] Validation successful. DIMACS export skipped to protect disk.")
    else:
        compiler.export_dimacs(args.output)

if __name__ == "__main__":
    main()
