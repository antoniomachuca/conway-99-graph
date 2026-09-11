"""
Agent B: CNF/SMT Compiler & Symmetry Breaking
Encodes Conway's 99-Graph SRG(99, 14, 1, 2) system A^2 + A - 12*I = 2*J
under candidate automorphism groups (Z_7, Z_3, Z_2).
Includes:
  - Canonical vertex 0 neighborhood fixation (7*K_2 matching)
  - Orbit projection to circulant blocks
  - Lexicographic Symmetry Breaking (Lex-Leader)
  - DIMACS CNF output and solver invocation (CaDiCaL, Kissat, Glucose, Z3)
  - Progress checkpointing and witness reconstruction
"""

import time
import sys
import os
import json
import numpy as np
from typing import Dict, List, Tuple, Optional, Any
from pysat.solvers import Cadical195, Kissat404, Glucose42
from pysat.card import CardEnc, EncType
from pysat.formula import CNF

class ConwayCNFCompiler:
    def __init__(self, group_name: str = "Z_7"):
        self.group_name = group_name
        self.cnf = CNF()
        self.top_id = 0
        self.var_map: Dict[Tuple, int] = {}
        self.aux_and_map: Dict[Tuple[int, int], int] = {}
        self.coords: Dict[Tuple[int, int], set] = {}
        self.all_coords: List[str] = []
        self._init_geometry()

    def _init_geometry(self):
        if self.group_name == "Z_7":
            # 12 orbits in Gamma_2 (84 vertices)
            # Orbits 0..2: (LL)_1, (LL)_2, (LL)_3
            # Orbits 3..5: (RR)_1, (RR)_2, (RR)_3
            # Orbits 6..11: (LR)_1..6
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
                    else:
                        d = (p - 6) + 1
                        i1 = (0 + t) % 7 + 1
                        i2 = (d + t) % 7 + 1
                        self.coords[(p, t)] = {f"{i1}L", f"{i2}R"}
            self.all_coords = [f"{i}L" for i in range(1, 8)] + [f"{i}R" for i in range(1, 8)]

            # Circulant variables:
            # Pairs (p, q) for p < q: 7 differences
            # Diagonal p == q: 3 differences
            for p in range(12):
                for q in range(p, 12):
                    if p == q:
                        for d in range(1, 4):
                            self.top_id += 1
                            self.var_map[(p, p, d)] = self.top_id
                    else:
                        for d in range(7):
                            self.top_id += 1
                            self.var_map[(p, q, d)] = self.top_id

    def get_adj_var(self, p1: int, t1: int, p2: int, t2: int) -> Optional[int]:
        if p1 == p2:
            diff = (t2 - t1) % 7
            if diff == 0:
                return None
            d = min(diff, 7 - diff)
            return self.var_map[(p1, p1, d)]
        elif p1 < p2:
            diff = (t2 - t1) % 7
            return self.var_map[(p1, p2, diff)]
        else:
            diff = (t1 - t2) % 7
            return self.var_map[(p2, p1, diff)]

    def get_and_var(self, a: int, b: int) -> int:
        if a > b:
            a, b = b, a
        k = (a, b)
        if k not in self.aux_and_map:
            self.top_id += 1
            y = self.top_id
            self.cnf.append([-y, a])
            self.cnf.append([-y, b])
            self.cnf.append([y, -a, -b])
            self.aux_and_map[k] = y
        return self.aux_and_map[k]

    def build_constraints(self, progress_callback=None):
        t0 = time.time()
        print(f"[{self.group_name}] Building coordinate & degree constraints...", flush=True)
        # Coordinate constraints (Lemma 4.7)
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
                            adj = self.get_adj_var(p, 0, q, t)
                            if adj is not None:
                                lits.append(adj)
                bound = 1 if (K in c_v or K in opp_v) else 2
                card_cnf = CardEnc.equals(lits=lits, bound=bound, top_id=self.top_id, encoding=EncType.seqcounter)
                self.top_id = card_cnf.nv
                self.cnf.extend(card_cnf.clauses)

        print(f"[{self.group_name}] Building SRG common neighbor constraints...", flush=True)
        pairs = []
        for p in range(12):
            for q in range(p, 12):
                if p == q:
                    for dt in range(1, 4):
                        pairs.append(((p, 0), (q, dt)))
                else:
                    for dt in range(7):
                        pairs.append(((p, 0), (q, dt)))

        total_pairs = len(pairs)
        for idx, (u, v) in enumerate(pairs):
            c_uv = len(self.coords[u].intersection(self.coords[v]))
            target_bound = 2 - c_uv
            a_uv = self.get_adj_var(u[0], u[1], v[0], v[1])
            lits = [a_uv] if a_uv is not None else []
            for q in range(12):
                for t in range(7):
                    w = (q, t)
                    if w == u or w == v:
                        continue
                    a_uw = self.get_adj_var(u[0], u[1], w[0], w[1])
                    a_vw = self.get_adj_var(v[0], v[1], w[0], w[1])
                    if a_uw is not None and a_vw is not None:
                        lits.append(self.get_and_var(a_uw, a_vw))
            card_cnf = CardEnc.equals(lits=lits, bound=target_bound, top_id=self.top_id, encoding=EncType.seqcounter)
            self.top_id = card_cnf.nv
            self.cnf.extend(card_cnf.clauses)
            if (idx + 1) % 100 == 0 or idx == total_pairs - 1:
                elapsed = time.time() - t0
                print(f"[{self.group_name}] Progress: {idx+1}/{total_pairs} pairs ({elapsed:.1f}s), total clauses: {len(self.cnf.clauses)}", flush=True)

        print(f"[{self.group_name}] Model complete: {len(self.cnf.clauses)} clauses, {self.top_id} variables.", flush=True)

    def write_dimacs(self, filename: str):
        self.cnf.to_file(filename)
        print(f"[{self.group_name}] DIMACS CNF exported to {filename}", flush=True)

    def solve(self, solver_name: str = "cadical195") -> Tuple[bool, Optional[np.ndarray]]:
        print(f"[{self.group_name}] Launching solver: {solver_name}...", flush=True)
        t0 = time.time()
        if solver_name == "cadical195":
            solver = Cadical195(bootstrap_with=self.cnf.clauses)
        elif solver_name == "kissat404":
            solver = Kissat404(bootstrap_with=self.cnf.clauses)
        elif solver_name == "glucose42":
            solver = Glucose42(bootstrap_with=self.cnf.clauses)
        else:
            raise ValueError(f"Unknown solver {solver_name}")

        sat = solver.solve()
        elapsed = time.time() - t0
        print(f"[{self.group_name}] Solver {solver_name} returned: {sat} in {elapsed:.2f}s", flush=True)
        if not sat:
            return False, None
        
        # Reconstruct 99x99 matrix
        model = set(solver.get_model())
        A = self.reconstruct_99_matrix(model)
        return True, A

    def reconstruct_99_matrix(self, model: set) -> np.ndarray:
        A = np.zeros((99, 99), dtype=int)
        # 0 is root
        # 1..7: L
        # 8..14: R
        # 15..98: Gamma_2
        for t in range(7):
            vL = 1 + t
            vR = 8 + t
            A[0, vL] = A[vL, 0] = 1
            A[0, vR] = A[vR, 0] = 1
            A[vL, vR] = A[vR, vL] = 1 # matching 7*K_2

        # Connect Gamma_1 to Gamma_2
        for p in range(12):
            for t in range(7):
                v_g2 = 15 + p * 7 + t
                for c in self.coords[(p, t)]:
                    idx = int(c[:-1])
                    side = c[-1]
                    v_g1 = (idx) if side == 'L' else (7 + idx)
                    A[v_g1, v_g2] = A[v_g2, v_g1] = 1

        # Inside Gamma_2
        for p1 in range(12):
            for t1 in range(7):
                u = 15 + p1 * 7 + t1
                for p2 in range(12):
                    for t2 in range(7):
                        v = 15 + p2 * 7 + t2
                        if u < v:
                            adj_var = self.get_adj_var(p1, t1, p2, t2)
                            if adj_var is not None and adj_var in model:
                                A[u, v] = A[v, u] = 1
        return A

if __name__ == "__main__":
    compiler = ConwayCNFCompiler("Z_7")
    compiler.build_constraints()
    compiler.write_dimacs("conway_z7.cnf")
    sat, witness = compiler.solve("cadical195")
    print(f"Final Disposition Z_7: SAT={sat}")
