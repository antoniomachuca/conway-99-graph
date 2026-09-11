"""
Agent A: Group Theory & Orbit Reduction
Decomposes graph into orbit circulants under Aut(G).
Primary targets:
  - Case Z_7: 1 fixed point + 14 orbits of length 7
  - Case Z_3: 0 or 3 fixed points + orbits of length 3
  - Case Z_2: Involutions
"""
from dataclasses import dataclass
from typing import List, Tuple, Dict, Optional
import numpy as np

@dataclass
class Z7Decomposition:
    num_orbits: int = 14
    orbit_size: int = 7
    total_vertices: int = 99
    # Orbit 0: {0} (fixed point)
    # Orbits 1..14: size 7
    # Vertex indexing:
    # 0 -> 0
    # (p, t) -> 1 + (p - 1)*7 + t for p in 1..14, t in 0..6
    
    @staticmethod
    def v_index(p: int, t: int) -> int:
        if p == 0:
            return 0
        return 1 + (p - 1) * 7 + (t % 7)

    @staticmethod
    def from_v_index(v: int) -> Tuple[int, int]:
        if v == 0:
            return (0, 0)
        p = (v - 1) // 7 + 1
        t = (v - 1) % 7
        return (p, t)

    def get_fixed_subgraph(self) -> Dict[Tuple[int, int], int]:
        """
        Returns fixed adjacencies in {0} U O_1 U O_2 (15 vertices)
        determined by 7*K_2 matching in N(0).
        """
        fixed = {}
        # 0 ~ (1, t) and 0 ~ (2, t)
        for t in range(7):
            fixed[(0, self.v_index(1, t))] = 1
            fixed[(0, self.v_index(2, t))] = 1
        # 0 !~ (p, t) for p >= 3
        for p in range(3, 15):
            for t in range(7):
                fixed[(0, self.v_index(p, t))] = 0

        # Inside N(0) = O_1 U O_2:
        # Matching is (1, t) ~ (2, t)
        for t1 in range(7):
            for t2 in range(7):
                # O_1 internal: no edges
                fixed[(self.v_index(1, t1), self.v_index(1, t2))] = 0
                # O_2 internal: no edges
                fixed[(self.v_index(2, t1), self.v_index(2, t2))] = 0
                # O_1 to O_2: only t1 == t2
                fixed[(self.v_index(1, t1), self.v_index(2, t2))] = 1 if t1 == t2 else 0

        return fixed

if __name__ == "__main__":
    decomp = Z7Decomposition()
    fixed = decomp.get_fixed_subgraph()
    print(f"Z_7 Decomposition initialized: {decomp.total_vertices} vertices.")
    print(f"Fixed pairs determined: {len(fixed)}")
