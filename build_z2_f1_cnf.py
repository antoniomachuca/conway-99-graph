#!/usr/bin/env python3
"""
build_z2_f1_cnf.py
Ultra-compact CNF Compiler for Conway's 99-Graph under Z_2 Involutions with f = 1.

Mathematical Foundation:
  - 1 fixed point x_0 = 0.
  - Neighborhood N(x_0) = {1..14} consists of 7 orbits of length 2: R_0..R_6.
    Induces 7*K_2 matching: (1, 2), (3, 4), ..., (13, 14).
  - Second subconstituent Gamma_2(x_0) = {15..98} consists of 42 orbits of length 2: O_0..O_41.
  - Orbit incidence matrix C of size 7 x 42 satisfies C C^T = 10*I_7 + 2*J_7.
  - Internal edge theorem: Gamma_2(x_0) contains 0 internal edges.
  - Primary boolean variables: 1,764 variables organized as a 42 x 42 matrix M:
      * M[p, p]: internal edge in orbit p (fixed to 0).
      * M[p, q] (p < q): matching M_0 (u_p ~ u_q, u'_p ~ u'_q).
      * M[q, p] (p < q): matching M_1 (u_p ~ u'_q, u'_p ~ u_q).
"""

import sys
import os
import time
import itertools
import argparse
import subprocess
import numpy as np
from typing import Dict, List, Tuple, Optional, Set
from pysat.card import CardEnc, EncType
from pysat.formula import CNF

class ConwayZ2F1Compiler:
    def __init__(self, cnf_output: str = "conway_z2_f1.cnf"):
        self.cnf_output = cnf_output
        self.cnf = CNF()
        self.top_id = 1764 # 42 x 42 primary boolean variables
        self.aux_and: Dict[Tuple[int, int], int] = {}
        
        # 1. Construct the 2-design matrix C (7 x 42)
        self._init_design_matrix()
        
        # 2. Build neighborhood maps
        self._init_neighborhood_maps()

    def _init_design_matrix(self):
        """
        Construct the 7 x 42 incidence matrix C = [C_1 | C_2].
        Each column corresponds to a 2-subset of {0..6}.
        C C^T = 10*I_7 + 2*J_7.
        """
        pairs = list(itertools.combinations(range(7), 2)) # 21 pairs
        assert len(pairs) == 21
        self.orbit_pairs = pairs + pairs # 42 columns
        
        self.C = np.zeros((7, 42), dtype=int)
        for j, (r1, r2) in enumerate(self.orbit_pairs):
            self.C[r1, j] = 1
            self.C[r2, j] = 1
            
        CCT = self.C @ self.C.T
        expected = 10 * np.eye(7, dtype=int) + 2 * np.ones((7, 7), dtype=int)
        assert np.array_equal(CCT, expected), "Incidence matrix C does not satisfy C C^T = 10*I_7 + 2*J_7!"

    def _init_neighborhood_maps(self):
        """
        Map each vertex in Gamma_2(x_0) to its 2 neighbors in N(x_0).
        Vertices in N(x_0):
          For r in 0..6: a_r = 1 + 2*r, t(a_r) = 2 + 2*r.
        Vertices in Gamma_2(x_0):
          For p in 0..41: u_p = (p, 0), u'_p = (p, 1).
        """
        self.nbrs_N: Dict[Tuple[int, int], Set[int]] = {}
        self.nbrs_G2_of_N: Dict[int, List[Tuple[int, int]]] = {a: [] for a in range(1, 15)}
        
        for j, (r1, r2) in enumerate(self.orbit_pairs):
            ar1, tar1 = 1 + 2 * r1, 2 + 2 * r1
            ar2, tar2 = 1 + 2 * r2, 2 + 2 * r2
            uj = (j, 0)
            tuj = (j, 1)
            
            if j < 21:
                # Column in first copy: u_j ~ a_{r1}, a_{r2}
                self.nbrs_N[uj] = {ar1, ar2}
                self.nbrs_N[tuj] = {tar1, tar2}
                self.nbrs_G2_of_N[ar1].append(uj)
                self.nbrs_G2_of_N[ar2].append(uj)
                self.nbrs_G2_of_N[tar1].append(tuj)
                self.nbrs_G2_of_N[tar2].append(tuj)
            else:
                # Column in second copy: u_j ~ a_{r1}, t(a_{r2})
                self.nbrs_N[uj] = {ar1, tar2}
                self.nbrs_N[tuj] = {tar1, ar2}
                self.nbrs_G2_of_N[ar1].append(uj)
                self.nbrs_G2_of_N[tar2].append(uj)
                self.nbrs_G2_of_N[tar1].append(tuj)
                self.nbrs_G2_of_N[ar2].append(tuj)

    @staticmethod
    def var_id(p: int, q: int) -> int:
        """Primary variable ID: 1 + 42*p + q in 1..1764."""
        return 1 + p * 42 + q

    def get_edge(self, u_idx: Tuple[int, int], v_idx: Tuple[int, int]) -> Optional[int]:
        """
        Returns the variable representing adjacency between u_idx and v_idx in Gamma_2.
        u_idx = (p, tu), v_idx = (q, tv) where tu, tv in {0, 1}.
        """
        p, tu = u_idx
        q, tv = v_idx
        if p == q:
            if tu == tv:
                return None
            return self.var_id(p, p) # internal edge (fixed to 0)
        diff = (tv - tu) % 2
        if diff == 0:
            return self.var_id(min(p, q), max(p, q))
        else:
            return self.var_id(max(p, q), min(p, q))

    def get_and_var(self, a: int, b: int) -> int:
        """Tseitin encoding for AND gate: y <=> a and b."""
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

    def build_constraints(self):
        t0 = time.time()
        print("=" * 80)
        print("BUILDING CNF: CONWAY 99-GRAPH UNDER Z_2 INVOLUTIONS (f = 1)")
        print(f"Primary variables: 1,764 (42 x 42 matrix M)")
        print(f"2-Design matrix C: 7 x 42 with C C^T = 10*I + 2*J")
        print("=" * 80)

        # 1. Zero internal edges in Gamma_2(x_0)
        print("[1/5] Enforcing 0 internal edges in Gamma_2(x_0) (42 unit clauses)...")
        for p in range(42):
            self.cnf.append([-self.var_id(p, p)])

        # 2. Regularity degree 14 constraints: degree inside Gamma_2(x_0) = 12
        print("[2/5] Encoding degree 14 constraints (degree = 12 in Gamma_2 for 42 orbits)...")
        for p in range(42):
            lits = [self.var_id(p, q) for q in range(42) if q != p] + \
                   [self.var_id(q, p) for q in range(42) if q != p]
            card = CardEnc.equals(lits=lits, bound=12, top_id=self.top_id, encoding=EncType.seqcounter)
            self.top_id = card.nv
            self.cnf.extend(card.clauses)

        # 3. Unique K_{2,2} partner for each orbit (Internal pair common neighbors mu = 2)
        print("[3/5] Encoding unique K_{2,2} partner for each orbit (mu = 2 for {u_p, u'_p})...")
        for p in range(42):
            lits = [self.get_and_var(self.var_id(min(p, q), max(p, q)),
                                      self.var_id(max(p, q), min(p, q)))
                    for q in range(42) if q != p]
            card = CardEnc.equals(lits=lits, bound=1, top_id=self.top_id, encoding=EncType.seqcounter)
            self.top_id = card.nv
            self.cnf.extend(card.clauses)

        # 4. Compatibility constraints between N(x_0) and Gamma_2(x_0)
        print("[4/5] Encoding compatibility constraints between N(x_0) and Gamma_2(x_0) (588 constraints)...")
        for a in range(1, 15):
            ta = a + 1 if (a - 1) % 2 == 0 else a - 1
            for p in range(42):
                u = (p, 0)
                if a in self.nbrs_N[u] or ta in self.nbrs_N[u]:
                    target = 1
                else:
                    target = 2
                lits = []
                for v in self.nbrs_G2_of_N[a]:
                    e = self.get_edge(u, v)
                    if e is not None:
                        lits.append(e)
                card = CardEnc.equals(lits=lits, bound=target, top_id=self.top_id, encoding=EncType.seqcounter)
                self.top_id = card.nv
                self.cnf.extend(card.clauses)

        # 5. Cross-orbit common neighbor constraints (lambda = 1 for adj, mu = 2 for non-adj)
        print("[5/5] Encoding cross-orbit common neighbors for all 861 orbit pairs (1,722 pairs)...")
        t_start_cross = time.time()
        total_pairs = 861 * 2
        pair_count = 0
        for p in range(42):
            for q in range(p + 1, 42):
                for tv in (0, 1):
                    pair_count += 1
                    u = (p, 0)
                    v = (q, tv)
                    edge_uv = self.get_edge(u, v)
                    cn_N = len(self.nbrs_N[u].intersection(self.nbrs_N[v]))
                    target = 2 - cn_N
                    lits = [edge_uv] if edge_uv is not None else []
                    for k in range(42):
                        if k == p or k == q:
                            continue
                        for tk in (0, 1):
                            w = (k, tk)
                            e_uw = self.get_edge(u, w)
                            e_vw = self.get_edge(v, w)
                            if e_uw is not None and e_vw is not None:
                                lits.append(self.get_and_var(e_uw, e_vw))
                    card = CardEnc.equals(lits=lits, bound=target, top_id=self.top_id, encoding=EncType.seqcounter)
                    self.top_id = card.nv
                    self.cnf.extend(card.clauses)
                    
            if (p + 1) % 10 == 0 or p == 41:
                elapsed = time.time() - t_start_cross
                print(f"      Progress: orbit {p+1}/42 ({pair_count}/{total_pairs} pairs, {elapsed:.1f}s, {len(self.cnf.clauses)} clauses)...", flush=True)

        print(f"\n[+] CNF Compilation complete in {time.time() - t0:.2f}s!")
        print(f"    Total Primary Variables: 1,764")
        print(f"    Total Auxiliary Variables: {self.top_id - 1764}")
        print(f"    Grand Total Variables: {self.top_id}")
        print(f"    Total Clauses: {len(self.cnf.clauses):,}")

    def export_dimacs(self):
        t0 = time.time()
        print(f"Writing DIMACS CNF to {self.cnf_output}...")
        self.cnf.to_file(self.cnf_output)
        size_mb = os.path.getsize(self.cnf_output) / (1024 * 1024)
        print(f"Exported {self.cnf_output} ({size_mb:.2f} MB) in {time.time() - t0:.2f}s.")

    def run_cadical(self, timeout_sec: int = 10) -> Optional[bool]:
        """Runs CaDiCaL to test solvability."""
        cadical_bin = "./cadical"
        if not os.path.exists(cadical_bin):
            print("CaDiCaL binary not found in workspace.")
            return None

        cmd = [cadical_bin, "-t", str(timeout_sec), "-v", self.cnf_output]
        print(f"Running CaDiCaL with {timeout_sec}s timeout: {' '.join(cmd)}")
        t0 = time.time()
        res = subprocess.run(cmd, capture_output=True, text=True)
        elapsed = time.time() - t0
        print(f"CaDiCaL finished in {elapsed:.2f}s with return code {res.returncode}.")
        
        for line in res.stdout.splitlines()[-20:]:
            print(f"  [cadical] {line}")
            
        if res.returncode == 10:
            print("[+] SATISFIABLE!")
            return True
        elif res.returncode == 20:
            print("[-] UNSATISFIABLE!")
            return False
        else:
            print(f"[*] Search incomplete within {timeout_sec}s (timeout / in-progress).")
            return None

    def reconstruct_adjacency(self, model: Set[int]) -> np.ndarray:
        """Reconstruct the full 99x99 adjacency matrix from SAT model."""
        A = np.zeros((99, 99), dtype=int)
        # x_0 = 0 to N(x_0)
        for v in range(1, 15):
            A[0, v] = A[v, 0] = 1
        # Inside N(x_0): 7*K_2
        for r in range(7):
            ar, tar = 1 + 2 * r, 2 + 2 * r
            A[ar, tar] = A[tar, ar] = 1
        # N(x_0) to Gamma_2(x_0)
        for p in range(42):
            for tp in (0, 1):
                u_idx = (p, tp)
                u_v = 15 + 2 * p + tp
                for a in self.nbrs_N[u_idx]:
                    A[a, u_v] = A[u_v, a] = 1
        # Inside Gamma_2(x_0)
        for p in range(42):
            for q in range(p + 1, 42):
                for tp in (0, 1):
                    for tq in (0, 1):
                        u_v = 15 + 2 * p + tp
                        w_v = 15 + 2 * q + tq
                        var = self.get_edge((p, tp), (q, tq))
                        if var is not None and var in model:
                            A[u_v, w_v] = A[w_v, u_v] = 1
        return A

def main():
    parser = argparse.ArgumentParser(description="Build and test CNF for Conway's 99-Graph under Z_2 (f=1).")
    parser.add_argument("--output", default="conway_z2_f1.cnf", help="Output CNF filename")
    parser.add_argument("--solve", action="store_true", help="Run preliminary CaDiCaL test")
    parser.add_argument("--timeout", type=int, default=10, help="CaDiCaL timeout in seconds")
    args = parser.parse_args()

    compiler = ConwayZ2F1Compiler(cnf_output=args.output)
    compiler.build_constraints()
    compiler.export_dimacs()

    if args.solve:
        compiler.run_cadical(timeout_sec=args.timeout)

if __name__ == "__main__":
    main()
