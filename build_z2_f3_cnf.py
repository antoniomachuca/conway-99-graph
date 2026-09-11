#!/usr/bin/env python3
"""
build_z2_f3_cnf.py
Production-grade CNF Compiler for Conway's 99-Graph under Z_2 Involutions with f = 3.

Mathematical Foundation:
  - Strongly regular graph srg(99, 14, 1, 2) whose adjacency matrix satisfies:
      A = A^T, diag(A) = 0, A^2 + A - 12*I = 2*J
  - Automorphism involution tau in Aut(G) with f = 3 fixed points Fix(tau) = {x_0, x_1, x_2}.
  - 48 orbits of length 2: O_0, ..., O_47 (total 51 vertex orbits: 3 fixed + 48 length-2).
  - Vertex set V(G) = 99:
      * Fixed points: x_0 = 0, x_1 = 1, x_2 = 2.
      * Orbit vertices: (p, t) -> 3 + 2*p + t for p in 0..47, t in {0, 1}.

Dichotomy of Induced Subgraph on Fix(tau):
  By uniqueness of triangles (lambda = 1), G[Fix(tau)] is either:
    * Case B: Independent set 3*K_1 (x_0 !~ x_1, x_1 !~ x_2, x_2 !~ x_0).
      Spectral trace analysis forces eps_1 = 3 (unique candidate), with k = (1, 1, 1).
      In each N(x_i), exactly 1 fixed internal edge (k_i = 1) and 3 pairs of transposed edges (p_i = 3).
      Total internal edges in the graph: eps_1 = 1 + 1 + 1 = 3.
    * Case A: Triangle K_3 (x_0 ~ x_1, x_1 ~ x_2, x_2 ~ x_0).
      Spectral trace analysis forces eps_1 = 10 (unique candidate), with even partition
      k_0 + k_1 + k_2 = 10 (e.g. canonical (4, 4, 2)).
      Macro-partition {X, N', W} of sizes (3, 36, 60) governed by equitable quotient matrix Q:
          Q = [[2, 12,  0],
               [1,  3, 10],
               [0,  6,  8]]

Boolean Variable Representation:
  Total 2,448 primary boolean edge variables:
    * var_fix(i, p): Fixed point x_i to orbit O_p (3 x 48 = 144 variables, IDs 1..144)
    * var_int(p): Internal edge inside orbit O_p (48 variables, IDs 145..192)
    * var_cross(p, q, d): Cross-orbit matching between O_p and O_q (1,128 x 2 = 2,256 variables, IDs 193..2448)
"""

import sys
import os
import time
import argparse
import subprocess
import numpy as np
from typing import Dict, Tuple, List, Optional, Set, Any
from pysat.formula import CNF
from pysat.card import CardEnc, EncType

class ConwayZ2F3Compiler:
    def __init__(
        self,
        case: str = "B",
        k_partition: Tuple[int, int, int] = (4, 4, 2),
        symmetry_breaking: bool = True,
        k4_cuts: bool = True,
        cnf_output: Optional[str] = None
    ):
        self.case = case.upper()
        if self.case not in ("A", "B"):
            raise ValueError(f"Invalid case: {case}. Must be 'A' or 'B'.")
            
        self.k_partition = k_partition
        self.symmetry_breaking = symmetry_breaking
        self.k4_cuts = k4_cuts
        
        if cnf_output is None:
            self.cnf_output = f"conway_z2_f3_case_{self.case.lower()}.cnf"
        else:
            self.cnf_output = cnf_output
            
        self.cnf = CNF()
        self.num_primary = 2448
        self.top_id = self.num_primary
        
        # Pre-fixed variable constants
        self.fixed_fix: Dict[Tuple[int, int], int] = {}
        self.fixed_int: Dict[int, int] = {}
        self.fixed_cross: Dict[Tuple[int, int, int], int] = {}
        
        # Tseitin cache for AND gates
        self.aux_and: Dict[Tuple[int, int], int] = {}
        
        self._init_variables_and_constants()

    @staticmethod
    def pair_idx(p: int, q: int) -> int:
        """Bijective lexicographical index for unordered pair 0 <= p < q < 48 (0..1127)."""
        if p > q:
            p, q = q, p
        return p * 48 - (p * (p + 1)) // 2 + (q - p - 1)

    def var_fix_id(self, i: int, p: int) -> int:
        """Primary variable ID for x_i ~ O_p (1..144)."""
        return 1 + i * 48 + p

    def var_int_id(self, p: int) -> int:
        """Primary variable ID for internal edge in O_p (145..192)."""
        return 145 + p

    def var_cross_id(self, p: int, q: int, d: int) -> int:
        """Primary variable ID for cross-matching between O_p and O_q (193..2448)."""
        return 193 + 2 * self.pair_idx(p, q) + d

    def _init_variables_and_constants(self):
        """Initializes domain constants and structural symmetry breaking."""
        if self.case == "B":
            # Fix(tau) is 3*K_1 (independent set).
            # Internal edges: eps_1 = 3. Exactly 1 in each N(x_i):
            # O_0 in N(x_0), O_1 in N(x_1), O_2 in N(x_2).
            self.fixed_int[0] = 1
            self.fixed_int[1] = 1
            self.fixed_int[2] = 1
            for p in range(3, 48):
                self.fixed_int[p] = 0
                
            # Fixed points to internal edge orbits:
            # Common neighbor localization: x_i is the unique fixed point neighbor of O_i.
            self.fixed_fix[(0, 0)] = 1
            self.fixed_fix[(1, 0)] = 0
            self.fixed_fix[(2, 0)] = 0

            self.fixed_fix[(0, 1)] = 0
            self.fixed_fix[(1, 1)] = 1
            self.fixed_fix[(2, 1)] = 0

            self.fixed_fix[(0, 2)] = 0
            self.fixed_fix[(1, 2)] = 0
            self.fixed_fix[(2, 2)] = 1

            if self.symmetry_breaking:
                # Canonical assignment for N(x_0):
                # x_0 connected to O_0 and O_3..O_8
                for p in range(3, 9):
                    self.fixed_fix[(0, p)] = 1
                for p in range(9, 48):
                    self.fixed_fix[(0, p)] = 0

                # 3 transposed pairs inside N(x_0): (3,4), (5,6), (7,8)
                matched = [(3, 4), (5, 6), (7, 8)]
                for p, q in matched:
                    self.fixed_cross[(p, q, 0)] = 1
                    self.fixed_cross[(p, q, 1)] = 0

                # All other cross edges within N(x_0) = {0, 3, 4, 5, 6, 7, 8} are 0 (1-factor matching)
                n0_orbits = [0, 3, 4, 5, 6, 7, 8]
                matched_set = set(matched)
                for idx1 in range(len(n0_orbits)):
                    for idx2 in range(idx1 + 1, len(n0_orbits)):
                        p, q = n0_orbits[idx1], n0_orbits[idx2]
                        if (p, q) not in matched_set:
                            self.fixed_cross[(p, q, 0)] = 0
                            self.fixed_cross[(p, q, 1)] = 0

        elif self.case == "A":
            # Fix(tau) is K_3 (triangle).
            k0, k1, k2 = self.k_partition
            if k0 + k1 + k2 != 10 or k0 % 2 != 0 or k1 % 2 != 0 or k2 % 2 != 0:
                raise ValueError(f"Partition {self.k_partition} must sum to 10 with all even parts.")
            
            # Neighborhoods:
            # N'(x_0) = orbits 0..5 (size 6 orbits = 12 vertices)
            # N'(x_1) = orbits 6..11 (size 6 orbits = 12 vertices)
            # N'(x_2) = orbits 12..17 (size 6 orbits = 12 vertices)
            # W = orbits 18..47 (size 30 orbits = 60 vertices)
            for p in range(48):
                self.fixed_fix[(0, p)] = 1 if 0 <= p < 6 else 0
                self.fixed_fix[(1, p)] = 1 if 6 <= p < 12 else 0
                self.fixed_fix[(2, p)] = 1 if 12 <= p < 18 else 0

            # Internal edges in N'(x_0): k0 internal edges
            for i in range(6):
                p = i
                self.fixed_int[p] = 1 if i < k0 else 0
            # Matched transposed pairs in N'(x_0) for remaining (6 - k0) orbits:
            rem0 = [i for i in range(6) if i >= k0]
            for i in range(0, len(rem0), 2):
                p, q = rem0[i], rem0[i+1]
                self.fixed_cross[(p, q, 0)] = 1
                self.fixed_cross[(p, q, 1)] = 0

            # Internal edges in N'(x_1): k1 internal edges
            for i in range(6):
                p = 6 + i
                self.fixed_int[p] = 1 if i < k1 else 0
            rem1 = [6 + i for i in range(6) if i >= k1]
            for i in range(0, len(rem1), 2):
                p, q = rem1[i], rem1[i+1]
                self.fixed_cross[(p, q, 0)] = 1
                self.fixed_cross[(p, q, 1)] = 0

            # Internal edges in N'(x_2): k2 internal edges
            for i in range(6):
                p = 12 + i
                self.fixed_int[p] = 1 if i < k2 else 0
            rem2 = [12 + i for i in range(6) if i >= k2]
            for i in range(0, len(rem2), 2):
                p, q = rem2[i], rem2[i+1]
                self.fixed_cross[(p, q, 0)] = 1
                self.fixed_cross[(p, q, 1)] = 0

            # W orbits (18..47): 0 internal edges
            for p in range(18, 48):
                self.fixed_int[p] = 0

    def get_edge_lit(self, u: int, v: int) -> int:
        """
        Returns the literal (or constant 0/1) for adjacency between vertices u and v.
        u, v in 0..98:
          0..2: fixed points x_0, x_1, x_2
          3..98: orbit vertices (p, t) with p = (v-3)//2, t = (v-3)%2
        """
        if u == v:
            return 0
        if u > v:
            u, v = v, u
            
        # Between fixed points
        if u < 3 and v < 3:
            return 1 if self.case == "A" else 0
            
        # Fixed point to orbit
        if u < 3 and v >= 3:
            i = u
            p = (v - 3) // 2
            if (i, p) in self.fixed_fix:
                return self.fixed_fix[(i, p)]
            return self.var_fix_id(i, p)
            
        # Orbit vertex to orbit vertex
        p = (u - 3) // 2
        tu = (u - 3) % 2
        q = (v - 3) // 2
        tv = (v - 3) % 2
        
        if p == q:
            # Internal edge
            if tu == tv:
                return 0
            if p in self.fixed_int:
                return self.fixed_int[p]
            return self.var_int_id(p)
            
        # Distinct orbits p != q
        if p > q:
            p, q = q, p
            tu, tv = tv, tu
            
        d = (tv - tu) % 2
        if (p, q, d) in self.fixed_cross:
            return self.fixed_cross[(p, q, d)]
        return self.var_cross_id(p, q, d)

    def get_and_lit(self, lit1: int, lit2: int) -> int:
        """Tseitin encoding for conjunction: y <=> lit1 and lit2 with constant folding."""
        if lit1 == 0 or lit2 == 0:
            return 0
        if lit1 == 1:
            return lit2
        if lit2 == 1:
            return lit1
        if lit1 == lit2:
            return lit1
        if lit1 == -lit2 or lit2 == -lit1:
            return 0
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
        """Encodes sum(lits) == bound with constant folding and sequential counter."""
        c = 0
        var_lits = []
        for l in lits:
            if l == 1:
                c += 1
            elif l != 0:
                var_lits.append(l)
                
        target = bound - c
        if target < 0:
            self.cnf.append([]) # Immediate conflict
            return
        if target == 0:
            for l in var_lits:
                self.cnf.append([-l])
            return
        if len(var_lits) < target:
            self.cnf.append([]) # Immediate conflict
            return
        if len(var_lits) == target:
            for l in var_lits:
                self.cnf.append([l])
            return
            
        enc = CardEnc.equals(lits=var_lits, bound=target, top_id=self.top_id, encoding=EncType.seqcounter)
        self.top_id = enc.nv
        self.cnf.extend(enc.clauses)

    def build_constraints(self):
        """Compiles all algebraic, regular, and common neighbor constraints into CNF."""
        t0 = time.time()
        print("=" * 80)
        print(f"BUILDING CNF: CONWAY 99-GRAPH UNDER Z_2 INVOLUTIONS (f = 3, CASE {self.case})")
        print(f"  Configuration: k-partition={self.k_partition if self.case == 'A' else '(1, 1, 1)'}, symm_break={self.symmetry_breaking}, k4_cuts={self.k4_cuts}")
        print("=" * 80)

        # 1. Unit clauses for pre-fixed variables
        print("  [1/5] Emitting unit clauses for fixed variables...", flush=True)
        unit_count = 0
        for (i, p), val in self.fixed_fix.items():
            var = self.var_fix_id(i, p)
            self.cnf.append([var] if val == 1 else [-var])
            unit_count += 1
            
        for p, val in self.fixed_int.items():
            var = self.var_int_id(p)
            self.cnf.append([var] if val == 1 else [-var])
            unit_count += 1
            
        for (p, q, d), val in self.fixed_cross.items():
            var = self.var_cross_id(p, q, d)
            self.cnf.append([var] if val == 1 else [-var])
            unit_count += 1
        print(f"        Emitted {unit_count} pre-fixed unit clauses.")

        # 2. Degree 14 for all 51 orbit representatives
        print("  [2/5] Encoding degree 14 for all 51 orbit representatives...", flush=True)
        all_vertices = list(range(99))
        
        # 3 fixed points
        for i in range(3):
            lits = [self.get_edge_lit(i, w) for w in all_vertices if w != i]
            self.add_card_equals(lits, 14)
            
        # 48 orbit representatives (p, 0) -> vertex 3 + 2*p
        for p in range(48):
            u = 3 + 2 * p
            lits = [self.get_edge_lit(u, w) for w in all_vertices if w != u]
            self.add_card_equals(lits, 14)

        # 3. Macro-partition equitable quotient matrix Q cuts (for Case A)
        if self.case == "A":
            print("  [3/5] Encoding Case A equitable quotient matrix Q cuts...", flush=True)
            # Row 2: vertex in N'(x_i_own): 1 in N'(x_i_own), 1 in each other N'(x_j), 10 in W
            for p in range(18):
                u = 3 + 2 * p
                i_own = p // 6
                # edges to N'(x_i_own)
                own_nbrs = [3 + 2*q + t for q in range(i_own*6, (i_own+1)*6) for t in (0, 1) if (3 + 2*q + t) != u]
                lits_own = [self.get_edge_lit(u, w) for w in own_nbrs]
                self.add_card_equals(lits_own, 1)
                
                # edges to other two N'(x_j)
                for j in range(3):
                    if j == i_own:
                        continue
                    other_nbrs = [3 + 2*q + t for q in range(j*6, (j+1)*6) for t in (0, 1)]
                    lits_other = [self.get_edge_lit(u, w) for w in other_nbrs]
                    self.add_card_equals(lits_other, 1)
                    
                # edges to W
                w_nbrs = [3 + 2*q + t for q in range(18, 48) for t in (0, 1)]
                lits_w = [self.get_edge_lit(u, w) for w in w_nbrs]
                self.add_card_equals(lits_w, 10)

            # Row 3: vertex in W: 2 in N'(x_0), 2 in N'(x_1), 2 in N'(x_2), 8 in W
            for p in range(18, 48):
                u = 3 + 2 * p
                for j in range(3):
                    n_nbrs = [3 + 2*q + t for q in range(j*6, (j+1)*6) for t in (0, 1)]
                    lits_n = [self.get_edge_lit(u, w) for w in n_nbrs]
                    self.add_card_equals(lits_n, 2)
                    
                w_other = [3 + 2*q + t for q in range(18, 48) for t in (0, 1) if (3 + 2*q + t) != u]
                lits_w = [self.get_edge_lit(u, w) for w in w_other]
                self.add_card_equals(lits_w, 8)
        else:
            print("  [3/5] (Case B: Macro-cuts covered by degree & orbit pairing)", flush=True)

        # 4. Common neighbors across 2,451 pair orbit representatives
        print("  [4/5] Encoding common neighbors across 2,451 pair orbit representatives...", flush=True)
        pair_orbits = []
        # 3 fixed point pairs
        for i in range(3):
            for j in range(i + 1, 3):
                pair_orbits.append((i, j))
                
        # 144 fixed point to orbit
        for i in range(3):
            for p in range(48):
                pair_orbits.append((i, 3 + 2 * p))
                
        # 48 internal orbit pairs
        for p in range(48):
            pair_orbits.append((3 + 2 * p, 3 + 2 * p + 1))
            
        # 2256 cross orbit pairs
        for p in range(48):
            for q in range(p + 1, 48):
                pair_orbits.append((3 + 2 * p, 3 + 2 * q))
                pair_orbits.append((3 + 2 * p, 3 + 2 * q + 1))

        assert len(pair_orbits) == 2451, f"Expected 2451 pair orbits, got {len(pair_orbits)}"
        
        t_pair_start = time.time()
        for idx, (u, v) in enumerate(pair_orbits):
            e_uv = self.get_edge_lit(u, v)
            lits = [e_uv] if e_uv != 0 else []
            for w in all_vertices:
                if w == u or w == v:
                    continue
                e_uw = self.get_edge_lit(u, w)
                if e_uw == 0:
                    continue
                e_vw = self.get_edge_lit(v, w)
                if e_vw == 0:
                    continue
                and_lit = self.get_and_lit(e_uw, e_vw)
                if and_lit != 0:
                    lits.append(and_lit)
            self.add_card_equals(lits, 2)
            
            if (idx + 1) % 500 == 0 or idx == len(pair_orbits) - 1:
                elapsed = time.time() - t_pair_start
                print(f"        Progress: {idx+1}/2451 pairs ({elapsed:.1f}s, clauses={len(self.cnf.clauses):,}, vars={self.top_id:,})...", flush=True)

        # 5. K_4 exclusion cuts on known triangles
        if self.k4_cuts:
            print("  [5/5] Encoding explicit K_4-exclusion clauses on known triangles...", flush=True)
            triangles = []
            if self.case == "B":
                # 3 triangles with fixed points: (x_i, u_{i,0}, u_{i,1})
                for i in range(3):
                    triangles.append((i, 3 + 2 * i, 3 + 2 * i + 1))
                if self.symmetry_breaking:
                    # Transposed matched pairs in N(x_0): (3,4), (5,6), (7,8)
                    for p, q in [(3, 4), (5, 6), (7, 8)]:
                        triangles.append((0, 3 + 2 * p, 3 + 2 * q))
                        triangles.append((0, 3 + 2 * p + 1, 3 + 2 * q + 1))
            elif self.case == "A":
                triangles.append((0, 1, 2))
                
            k4_clause_count = 0
            for (t1, t2, t3) in triangles:
                for w in all_vertices:
                    if w in (t1, t2, t3):
                        continue
                    e1 = self.get_edge_lit(t1, w)
                    if e1 == 0:
                        continue
                    e2 = self.get_edge_lit(t2, w)
                    if e2 == 0:
                        continue
                    e3 = self.get_edge_lit(t3, w)
                    if e3 == 0:
                        continue
                    cl = []
                    if e1 != 1: cl.append(-e1)
                    if e2 != 1: cl.append(-e2)
                    if e3 != 1: cl.append(-e3)
                    if cl:
                        self.cnf.append(cl)
                        k4_clause_count += 1
                    else:
                        self.cnf.append([])
            print(f"        Added {k4_clause_count} K_4-exclusion clauses on {len(triangles)} triangles.")
        else:
            print("  [5/5] K_4 explicit cuts skipped (--no-k4 specified).", flush=True)

        total_time = time.time() - t0
        print("-" * 80)
        print(f"[+] CNF Compilation completed in {total_time:.2f}s!")
        print(f"    Primary variables:   {self.num_primary:,}")
        print(f"    Auxiliary variables: {self.top_id - self.num_primary:,}")
        print(f"    Total variables:     {self.top_id:,}")
        print(f"    Total clauses:       {len(self.cnf.clauses):,}")
        print("=" * 80)

    def export_dimacs(self, path: Optional[str] = None):
        """Exports formula to standard DIMACS CNF format."""
        out_path = path or self.cnf_output
        print(f"Writing DIMACS CNF to {out_path}...", flush=True)
        t0 = time.time()
        self.cnf.to_file(out_path)
        size_mb = os.path.getsize(out_path) / (1024 * 1024)
        print(f"[+] Exported {out_path} ({size_mb:.2f} MB) in {time.time() - t0:.2f}s.")

    def verify_dimacs(self, path: Optional[str] = None) -> Dict[str, Any]:
        """Audits DIMACS syntax, variables, clauses, and detects empty clauses."""
        in_path = path or self.cnf_output
        print(f"Auditing DIMACS syntax on {in_path}...", flush=True)
        t0 = time.time()
        
        num_vars = 0
        num_clauses = 0
        empty_clauses = 0
        unit_clauses = 0
        binary_clauses = 0
        max_lit = 0
        actual_clauses = 0
        
        with open(in_path, "r", errors="ignore") as f:
            for line in f:
                sline = line.strip()
                if not sline or sline.startswith("c"):
                    continue
                if sline.startswith("p cnf"):
                    parts = sline.split()
                    num_vars = int(parts[2])
                    num_clauses = int(parts[3])
                    continue
                
                lits = [int(p) for p in sline.split() if p != "0"]
                actual_clauses += 1
                if len(lits) == 0:
                    empty_clauses += 1
                elif len(lits) == 1:
                    unit_clauses += 1
                elif len(lits) == 2:
                    binary_clauses += 1
                    
                for l in lits:
                    al = abs(l)
                    if al > max_lit:
                        max_lit = al

        audit = {
            "header_vars": num_vars,
            "header_clauses": num_clauses,
            "actual_clauses": actual_clauses,
            "max_literal": max_lit,
            "empty_clauses": empty_clauses,
            "unit_clauses": unit_clauses,
            "binary_clauses": binary_clauses,
            "syntax_valid": (num_clauses == actual_clauses and max_lit <= num_vars and empty_clauses == 0),
            "audit_time_sec": round(time.time() - t0, 2)
        }
        print(f"[+] Audit Results: Header clauses={num_clauses:,}, Actual={actual_clauses:,}, Empty={empty_clauses}, MaxVar={max_lit:,} (Valid: {audit['syntax_valid']})")
        return audit

    def run_cadical(
        self,
        timeout_sec: int = 30,
        proof_drat: Optional[str] = None,
        log_file: Optional[str] = None
    ) -> Optional[bool]:
        """Runs CaDiCaL with optional DRAT proof tracing and logging."""
        cadical_bin = "./cadical"
        if not os.path.exists(cadical_bin):
            print(f"CaDiCaL binary not found at {cadical_bin}!")
            return None

        cmd = [cadical_bin, "-t", str(timeout_sec), self.cnf_output]
        if proof_drat:
            cmd.append(proof_drat)

        print(f"Executing: {' '.join(cmd)}")
        t0 = time.time()
        
        if log_file:
            with open(log_file, "w") as log_f:
                res = subprocess.run(cmd, stdout=log_f, stderr=subprocess.STDOUT)
            elapsed = time.time() - t0
            print(f"CaDiCaL completed in {elapsed:.2f}s with return code {res.returncode}. Log saved to {log_file}.")
        else:
            res = subprocess.run(cmd, capture_output=True, text=True)
            elapsed = time.time() - t0
            print(f"CaDiCaL completed in {elapsed:.2f}s with return code {res.returncode}.")
            for line in res.stdout.splitlines()[-25:]:
                print(f"  [cadical] {line}")

        if res.returncode == 10:
            print("[+] SATISFIABLE!")
            return True
        elif res.returncode == 20:
            print("[-] UNSATISFIABLE!")
            return False
        else:
            print(f"[*] Solver returned {res.returncode} (timeout / search in progress).")
            return None

    def reconstruct_adjacency(self, model: Set[int]) -> np.ndarray:
        """Reconstructs the full 99x99 adjacency matrix from a satisfying assignment."""
        A = np.zeros((99, 99), dtype=int)
        all_vertices = list(range(99))
        for u in all_vertices:
            for v in range(u + 1, 99):
                lit = self.get_edge_lit(u, v)
                if lit == 1 or lit in model:
                    A[u, v] = A[v, u] = 1
        return A

def main():
    parser = argparse.ArgumentParser(description="Production CNF Compiler for Conway's 99-Graph under Z_2 (f=3).")
    parser.add_argument("--case", choices=["A", "B"], default="B", help="Dichotomy case: 'B' (3*K_1, eps_1=3) or 'A' (K_3, eps_1=10)")
    parser.add_argument("--k-partition", nargs=3, type=int, default=[4, 4, 2], help="Case A internal edge partition (k0, k1, k2) summing to 10 (default: 4 4 2)")
    parser.add_argument("--output", default=None, help="Output DIMACS CNF path")
    parser.add_argument("--no-symmetry-breaking", action="store_true", help="Disable canonical N(x_0) symmetry breaking")
    parser.add_argument("--no-k4", action="store_true", help="Disable explicit K_4 exclusion clauses")
    parser.add_argument("--audit", action="store_true", help="Perform syntax audit on exported DIMACS CNF")
    parser.add_argument("--solve", action="store_true", help="Run CaDiCaL solver")
    parser.add_argument("--timeout", type=int, default=30, help="Solver timeout in seconds")
    parser.add_argument("--drat", default=None, help="Path to write DRAT proof trace")
    parser.add_argument("--log", default=None, help="Path to write solver log")
    args = parser.parse_args()

    compiler = ConwayZ2F3Compiler(
        case=args.case,
        k_partition=tuple(args.k_partition),
        symmetry_breaking=not args.no_symmetry_breaking,
        k4_cuts=not args.no_k4,
        cnf_output=args.output
    )
    
    compiler.build_constraints()
    compiler.export_dimacs()
    
    if args.audit:
        compiler.verify_dimacs()
        
    if args.solve or args.drat:
        compiler.run_cadical(timeout_sec=args.timeout, proof_drat=args.drat, log_file=args.log)

if __name__ == "__main__":
    main()
