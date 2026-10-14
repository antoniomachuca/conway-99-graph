"""Deterministic checks that M_arr, B_arr, K_arr in
Conway/Z84Subconstituent.lean encode the stated constant matrices:

  * M_val = adjacency of 7K2 on the pairs (2t, 2t+1) of 14 vertices;
  * B_val a y = indicator that vertex a belongs to the y-th lexicographic
    non-edge (a < b, a//2 != b//2) of 7K2 (there are C(14,2)-7 = 84 of them);
  * K_val = 12I + 2J - B^T B  (B^T B has 2 on the diagonal, 0/1 off-diagonal).
"""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "Conway" / "Z84Subconstituent.lean"


def _load_array(name: str) -> list[int]:
    text = SRC.read_text()
    m = re.search(rf"def {name} : Array Nat := #\[([0-9,\s]+)\]", text)
    assert m, f"could not parse {name}"
    return [int(x) for x in m.group(1).split(",")]


M = _load_array("M_arr")
B = _load_array("B_arr")
K = _load_array("K_arr")

N_PAIRS = [(a, b) for a in range(14) for b in range(14)
           if a < b and a // 2 != b // 2]
N_PAIRS.sort()


def test_m_dimensions():
    assert len(M) == 14 * 14
    assert len(B) == 14 * 84
    assert len(K) == 84 * 84


def test_m_is_7k2():
    for i in range(14):
        for j in range(14):
            expected = 1 if (i != j and i // 2 == j // 2) else 0
            assert M[i * 14 + j] == expected, (i, j)


def test_b_columns_are_nonedge_indicators():
    assert len(N_PAIRS) == 84
    for y, (a, b) in enumerate(N_PAIRS):
        for v in range(14):
            expected = 1 if v in (a, b) else 0
            assert B[v * 84 + y] == expected, (v, y)


def test_k_equals_12i_plus_2j_minus_btb():
    for y in range(84):
        for z in range(84):
            btb = sum(B[a * 84 + y] * B[a * 84 + z] for a in range(14))
            expected = (12 if y == z else 0) + 2 - btb
            assert K[y * 84 + z] == expected, (y, z)


def test_btb_shape():
    for y in range(84):
        assert sum(B[a * 84 + y] ** 2 for a in range(14)) == 2
        for z in range(84):
            if y != z:
                assert sum(B[a * 84 + y] * B[a * 84 + z]
                           for a in range(14)) in (0, 1)
