import sys
import time
from pysat.formula import CNF
from pysat.card import CardEnc, EncType

class ConwayZ3Builder:
    def __init__(self):
        self.cnf = CNF()
        self.top_id = 0
        self.edge_vars = {} # (p, q, d): int for p < q, and (p, p): int
        self.aux_and = {}   # (lit1, lit2): int
        self.fixed_edges = {} # (p, q, d): 0 or 1

        self._init_variables()
        self._init_fixed_subgraphs()

    def _init_variables(self):
        # 32 orbits: 0..31
        # N0: 0..3
        # N1: 4..7
        # N2: 8..11
        # W: 12..31
        
        # Diagonal variables E(p, p)
        # For p in 0..11, E(p, p) = 0 (no internal edges in N0, N1, N2)
        for p in range(12):
            self.fixed_edges[(p, p)] = 0
            
        # For p in 12..31, E(p, p) is a variable
        for p in range(12, 32):
            self.top_id += 1
            self.edge_vars[(p, p)] = self.top_id

        # Pairs p < q
        for p in range(32):
            for q in range(p + 1, 32):
                for d in range(3):
                    self.top_id += 1
                    self.edge_vars[(p, q, d)] = self.top_id

    def _init_fixed_subgraphs(self):
        # In N0 (0..3):
        # 0 matched to 1: (0, 1, 0) = 1, (0, 1, 1) = 0, (0, 1, 2) = 0
        # 2 matched to 3: (2, 3, 0) = 1, (2, 3, 1) = 0, (2, 3, 2) = 0
        # all other pairs in N0 are 0
        n0_matched = {(0, 1), (2, 3)}
        for p in range(0, 4):
            for q in range(p + 1, 4):
                if (p, q) in n0_matched:
                    self.fixed_edges[(p, q, 0)] = 1
                    self.fixed_edges[(p, q, 1)] = 0
                    self.fixed_edges[(p, q, 2)] = 0
                else:
                    self.fixed_edges[(p, q, 0)] = 0
                    self.fixed_edges[(p, q, 1)] = 0
                    self.fixed_edges[(p, q, 2)] = 0

        # In N1 (4..7):
        n1_matched = {(4, 5), (6, 7)}
        for p in range(4, 8):
            for q in range(p + 1, 8):
                if (p, q) in n1_matched:
                    self.fixed_edges[(p, q, 0)] = 1
                    self.fixed_edges[(p, q, 1)] = 0
                    self.fixed_edges[(p, q, 2)] = 0
                else:
                    self.fixed_edges[(p, q, 0)] = 0
                    self.fixed_edges[(p, q, 1)] = 0
                    self.fixed_edges[(p, q, 2)] = 0

        # In N2 (8..11):
        n2_matched = {(8, 9), (10, 11)}
        for p in range(8, 12):
            for q in range(p + 1, 12):
                if (p, q) in n2_matched:
                    self.fixed_edges[(p, q, 0)] = 1
                    self.fixed_edges[(p, q, 1)] = 0
                    self.fixed_edges[(p, q, 2)] = 0
                else:
                    self.fixed_edges[(p, q, 0)] = 0
                    self.fixed_edges[(p, q, 1)] = 0
                    self.fixed_edges[(p, q, 2)] = 0

    def get_adj_lit(self, p1: int, t1: int, p2: int, t2: int):
        """Returns 0 (False), 1 (True), or literal int > 0."""
        if p1 == p2:
            dt = (t2 - t1) % 3
            if dt == 0:
                return 0
            # dt == 1 or dt == 2
            if (p1, p1) in self.fixed_edges:
                return self.fixed_edges[(p1, p1)]
            return self.edge_vars[(p1, p1)]
        elif p1 < p2:
            d = (t2 - t1) % 3
            if (p1, p2, d) in self.fixed_edges:
                return self.fixed_edges[(p1, p2, d)]
            return self.edge_vars[(p1, p2, d)]
        else:
            d = (t1 - t2) % 3
            d_p2 = (-d) % 3
            # A((p1, t1), (p2, t2)) = A((p2, t2), (p1, t1)) = X(p2, p1, (t1 - t2)%3)
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

print("Initialized ConwayZ3Builder successfully.")
