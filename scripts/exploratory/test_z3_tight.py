import time
from pysat.formula import CNF
from pysat.card import CardEnc, EncType
from pysat.solvers import Cadical195, Kissat404

class ConwayZ3TightCompiler:
    def __init__(self):
        self.cnf = CNF()
        self.top_id = 0
        self.edge_vars = {}   # (p, q, d): int for p < q
        self.aux_and = {}     # (lit1, lit2): int
        self.fixed_edges = {} # (p, q, d): 0 or 1

        self._init_variables()
        self._init_fixed_subgraphs()

    def _init_variables(self):
        # 32 orbits: 0..31
        # N0: 0..3, N1: 4..7, N2: 8..11, W: 12..31
        # Crnkovic & Maksimovic (2020): E(p, p) = 0 for ALL 32 orbits!
        for p in range(32):
            self.fixed_edges[(p, p)] = 0

        # Variables for p < q, d in {0, 1, 2}
        for p in range(32):
            for q in range(p + 1, 32):
                for d in range(3):
                    self.top_id += 1
                    self.edge_vars[(p, q, d)] = self.top_id

    def _init_fixed_subgraphs(self):
        # In N0 (0..3): 0~1, 2~3
        n0_matched = {(0, 1), (2, 3)}
        for p in range(0, 4):
            for q in range(p + 1, 4):
                for d in range(3):
                    val = 1 if ((p, q) in n0_matched and d == 0) else 0
                    self.fixed_edges[(p, q, d)] = val
                    self.cnf.append([self.edge_vars[(p, q, d)]] if val == 1 else [-self.edge_vars[(p, q, d)]])

        # In N1 (4..7): 4~5, 6~7
        n1_matched = {(4, 5), (6, 7)}
        for p in range(4, 8):
            for q in range(p + 1, 8):
                for d in range(3):
                    val = 1 if ((p, q) in n1_matched and d == 0) else 0
                    self.fixed_edges[(p, q, d)] = val
                    self.cnf.append([self.edge_vars[(p, q, d)]] if val == 1 else [-self.edge_vars[(p, q, d)]])

        # In N2 (8..11): 8~9, 10~11
        n2_matched = {(8, 9), (10, 11)}
        for p in range(8, 12):
            for q in range(p + 1, 12):
                for d in range(3):
                    val = 1 if ((p, q) in n2_matched and d == 0) else 0
                    self.fixed_edges[(p, q, d)] = val
                    self.cnf.append([self.edge_vars[(p, q, d)]] if val == 1 else [-self.edge_vars[(p, q, d)]])

    def get_adj_lit(self, p1: int, t1: int, p2: int, t2: int):
        if p1 == p2:
            return 0 # E(p, p) = 0 for ALL p
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

    def get_and_lit(self, lit1, lit2):
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

    def add_card_equals(self, lits, bound):
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
        print("Building degree constraints...", flush=True)
        # Degree into orbit vertices: 13 if p < 12, 14 if p >= 12
        for p in range(32):
            lits = []
            for q in range(32):
                if q == p:
                    continue
                for t in range(3):
                    l = self.get_adj_lit(p, 0, q, t)
                    lits.append(l)
            target = 13 if p < 12 else 14
            self.add_card_equals(lits, target)

        # Sub-degree constraints:
        blocks = {
            "N0": list(range(0, 4)),
            "N1": list(range(4, 8)),
            "N2": list(range(8, 12)),
            "W": list(range(12, 32))
        }

        # For u in N0:
        for p in blocks["N0"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N1"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N2"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] for t in range(3)], 10)

        # For u in N1:
        for p in blocks["N1"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N0"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N2"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] for t in range(3)], 10)

        # For u in N2:
        for p in blocks["N2"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N0"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N1"] for t in range(3)], 1)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] for t in range(3)], 10)

        # For w in W:
        for p in blocks["W"]:
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N0"] for t in range(3)], 2)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N1"] for t in range(3)], 2)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["N2"] for t in range(3)], 2)
            self.add_card_equals([self.get_adj_lit(p, 0, q, t) for q in blocks["W"] if q != p for t in range(3)], 8)

    def build_common_neighbor_constraints(self):
        print("Building common neighbor constraints (1520 pair orbits)...", flush=True)
        t0 = time.time()
        
        pair_orbits = []
        for p in range(32):
            for q in range(p, 32):
                if p == q:
                    pair_orbits.append(((p, 0), (p, 1)))
                else:
                    for dt in range(3):
                        pair_orbits.append(((p, 0), (q, dt)))

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
            if (idx + 1) % 400 == 0 or idx == len(pair_orbits) - 1:
                print(f"  Processed {idx+1}/{len(pair_orbits)} pair orbits ({time.time()-t0:.1f}s), clauses={len(self.cnf.clauses)}, vars={self.top_id}", flush=True)

t0 = time.time()
comp = ConwayZ3TightCompiler()
comp.build_degree_constraints()
comp.build_common_neighbor_constraints()
print(f"Compilation time: {time.time()-t0:.2f}s")
print(f"Total clauses: {len(comp.cnf.clauses)}, total variables: {comp.top_id}")

comp.cnf.to_file("conway_z3_fixed3.cnf")
print("Saved conway_z3_fixed3.cnf")
