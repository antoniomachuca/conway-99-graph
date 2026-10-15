#!/usr/bin/env python3
"""
scripts/build_z3_fixed3_orbit_matrix_cnf.py

DIMACS CNF Generator for the 35x35 Orbit Matrix of Conway's 99-Graph
under Z_3 Automorphism with 3 Fixed Points (Fix(g) = {x0, x1, x2}).

Mathematical Background (Crnkovic-Maksimovic 2020; Behbahani-Lam 2011):
- Strongly Regular Graph Parameters: srg(v=99, k=14, lambda=1, mu=2).
- Automorphism g of order 3 with exactly 3 fixed points x0, x1, x2:
  * Since lambda = 1 and mu = 2, the 3 fixed points form an induced triangle K_3.
  * The remaining 96 vertices partition into 32 orbits of size 3.
  * Orbit sizes: n_0 = n_1 = n_2 = 1, and n_3 = ... = n_{34} = 3 (35 orbits total).
  * Neighborhood partition:
    - N_0: 4 orbits of size 3 adjacent to x0 (orbits 3..6).
    - N_1: 4 orbits of size 3 adjacent to x1 (orbits 7..10).
    - N_2: 4 orbits of size 3 adjacent to x2 (orbits 11..14).
    - W: 20 orbits of size 3 not adjacent to any fixed point (orbits 15..34).
  * K_4-Free Exclusion:
    Since Conway's graph is K_4-free (lambda = 1), no orbit in N_0 U N_1 U N_2
    can contain an internal edge: B_jj = 0 for all j in 3..14.
  * For w in W: B_ww in {0, 2} by odd-orbit parity.
  * Spectral trace equation:
    Tr(B) = 14 + 3a - 4(34 - a) = 7a - 122 for multiplicity a in 0..34.
    Since Tr(B) = 2t for 0 <= t <= 20, Tr(B) in {4, 18, 32, 46, 60}.
  * Row Prototype Bounds:
    - In 32x32 submatrix: all entries B_ij in {0, 1, 2} (no 3s).
    - For each i in N_0 U N_1 U N_2: exactly one off-diagonal 2 (in W).
    - For each w in W: if B_ww = 2, zero off-diagonal 2s; if B_ww = 0, at most two off-diagonal 2s.

This script builds the 5 spectral trace CNF instances:
1. `conway_z3_fixed3_tr04.cnf` (Tr = 4, t = 2)
2. `conway_z3_fixed3_tr18.cnf` (Tr = 18, t = 9)
3. `conway_z3_fixed3_tr32.cnf` (Tr = 32, t = 16)
4. `conway_z3_fixed3_tr46.cnf` (Tr = 46, t = 23)
5. `conway_z3_fixed3_tr60.cnf` (Tr = 60, t = 30)
"""

from __future__ import annotations

import argparse
import os
import sys
import time
from pathlib import Path
from typing import Dict, List, Tuple

from pysat.card import CardEnc, EncType
from pysat.formula import CNF

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from scripts.orbit_matrix_encoding import OrbitMatrixCNF

SPECTRAL_TRACES = [4, 18, 32, 46, 60]


def build_fixed3_orbit_matrix_cnf(target_trace: int) -> CNF:
    """Build the 35x35 Orbit Matrix CNF for a specific target trace."""
    sizes = [1, 1, 1] + [3] * 32
    fixed: Dict[Tuple[int, int], int] = {}

    # 1. Fixed points K_3
    for i in range(3):
        fixed[(i, i)] = 0
    fixed[(0, 1)] = 1
    fixed[(1, 0)] = 1
    fixed[(0, 2)] = 1
    fixed[(2, 0)] = 1
    fixed[(1, 2)] = 1
    fixed[(2, 1)] = 1

    # N0: orbits 3..6
    for j in range(3, 7):
        fixed[(0, j)] = 3
        fixed[(j, 0)] = 1
        fixed[(1, j)] = 0
        fixed[(j, 1)] = 0
        fixed[(2, j)] = 0
        fixed[(j, 2)] = 0
        fixed[(j, j)] = 0  # K4-free

    # N1: orbits 7..10
    for j in range(7, 11):
        fixed[(0, j)] = 0
        fixed[(j, 0)] = 0
        fixed[(1, j)] = 3
        fixed[(j, 1)] = 1
        fixed[(2, j)] = 0
        fixed[(j, 2)] = 0
        fixed[(j, j)] = 0  # K4-free

    # N2: orbits 11..14
    for j in range(11, 15):
        fixed[(0, j)] = 0
        fixed[(j, 0)] = 0
        fixed[(1, j)] = 0
        fixed[(j, 1)] = 0
        fixed[(2, j)] = 3
        fixed[(j, 2)] = 1
        fixed[(j, j)] = 0  # K4-free

    # W: orbits 15..34
    for j in range(15, 35):
        fixed[(0, j)] = 0
        fixed[(j, 0)] = 0
        fixed[(1, j)] = 0
        fixed[(j, 1)] = 0
        fixed[(2, j)] = 0
        fixed[(j, 2)] = 0

    # 1-factors inside N0, N1, N2
    matched_pairs = [(3, 4), (5, 6), (7, 8), (9, 10), (11, 12), (13, 14)]
    for rng in [range(3, 7), range(7, 11), range(11, 15)]:
        for u in rng:
            for v in range(u + 1, rng.stop):
                val = 1 if (u, v) in matched_pairs else 0
                fixed[(u, v)] = val
                fixed[(v, u)] = val

    # Entry domains
    domains = {}
    for i in range(3, 35):
        for j in range(3, 35):
            if i == j:
                domains[(i, i)] = (0,) if i < 15 else (0, 2)
            elif (i, j) in fixed:
                domains[(i, j)] = (fixed[(i, j)],)
            else:
                domains[(i, j)] = (0, 1, 2)

    enc = OrbitMatrixCNF(sizes=sizes, degree=14, lam=1, mu=2, fixed=fixed, domains=domains)

    # Sub-degrees
    N0, N1, N2, W = list(range(3, 7)), list(range(7, 11)), list(range(11, 15)), list(range(15, 35))
    for u in N0:
        enc.linear_equals([(enc.entries[(u, v)][0], 1) for v in N1], 1)
        enc.linear_equals([(enc.entries[(u, v)][0], 1) for v in N2], 1)
        enc.linear_equals([(lit, 1) for w in W for lit in enc.entries[(u, w)]], 10)

    for u in N1:
        enc.linear_equals([(enc.entries[(u, v)][0], 1) for v in N0], 1)
        enc.linear_equals([(enc.entries[(u, v)][0], 1) for v in N2], 1)
        enc.linear_equals([(lit, 1) for w in W for lit in enc.entries[(u, w)]], 10)

    for u in N2:
        enc.linear_equals([(enc.entries[(u, v)][0], 1) for v in N0], 1)
        enc.linear_equals([(enc.entries[(u, v)][0], 1) for v in N1], 1)
        enc.linear_equals([(lit, 1) for w in W for lit in enc.entries[(u, w)]], 10)

    for w in W:
        enc.linear_equals([(lit, 1) for u in N0 for lit in enc.entries[(w, u)]], 2)
        enc.linear_equals([(lit, 1) for u in N1 for lit in enc.entries[(w, u)]], 2)
        enc.linear_equals([(lit, 1) for u in N2 for lit in enc.entries[(w, u)]], 2)

    # Topological trace constraint: Tr(B) = sum_{w in W} B_{ww} = 2*t
    t = target_trace // 2
    diag_lits = [enc.entries[(w, w)][1] for w in W]
    if t <= len(diag_lits):
        enc.linear_equals([(lit, 1) for lit in diag_lits], t)
    else:
        # t > 20 is impossible on 20 orbits. Encode via unit resolution refutation
        # to ensure CaDiCaL emits a valid DRAT lemma and drat-trim exits with 0.
        for lit in diag_lits:
            enc.cnf.append([lit])
        v = enc.new_variable()
        enc.cnf.append([v])
        enc.cnf.append([-v])

    # Row Prototype Cuts on off-diagonal 2s:
    # 1. For each i in N0 U N1 U N2: exactly one w in W has B_{iw} = 2
    for i in N0 + N1 + N2:
        lits_two = [enc.entries[(i, w)][1] for w in W]
        enc.linear_equals([(l, 1) for l in lits_two], 1)

    # 2. For each w in W:
    # If B_{ww} = 2 (triangular), no entry B_{iw} can equal 2.
    # If B_{ww} = 0, at most two entries B_{iw} can equal 2.
    for w in W:
        tri_lit = enc.entries[(w, w)][1]
        for i in N0 + N1 + N2:
            enc.cnf.append([-tri_lit, -enc.entries[(i, w)][1]])
        enc.cnf.extend(
            CardEnc.atmost(
                lits=[enc.entries[(i, w)][1] for i in N0 + N1 + N2],
                bound=2,
                top_id=enc.top_id,
            ).clauses
        )

    return enc.compile()


def main():
    parser = argparse.ArgumentParser(description="Build Z_3 Fixed-3 35x35 Orbit Matrix CNF Instances")
    parser.add_argument(
        "--traces",
        nargs="+",
        type=int,
        default=SPECTRAL_TRACES,
        help="Spectral traces to build (default: 4 18 32 46 60)",
    )
    parser.add_argument(
        "--out-dir",
        type=Path,
        default=REPO_ROOT / "instances" / "z3_fixed3",
        help="Output directory for CNF files",
    )
    args = parser.parse_args()

    args.out_dir.mkdir(parents=True, exist_ok=True)
    print("=" * 80)
    print("Building Conway 99-Graph Z_3 Fixed-3 Orbit Matrix CNF Instances")
    print(f"Target Spectral Traces: {args.traces}")
    print(f"Output Directory: {args.out_dir}")
    print("=" * 80)

    for tr in args.traces:
        t0 = time.time()
        cnf_filename = args.out_dir / f"conway_z3_fixed3_tr{tr:02d}.cnf"
        print(f"[*] Compiling CNF for Tr(B) = {tr:02d} (t = {tr // 2})...", flush=True)
        cnf = build_fixed3_orbit_matrix_cnf(tr)
        cnf.to_file(str(cnf_filename))
        size_mb = cnf_filename.stat().st_size / (1024 * 1024)
        print(
            f"[+] Saved {cnf_filename.name}: {size_mb:.2f} MB, {len(cnf.clauses):,} clauses, {cnf.nv:,} vars in {time.time() - t0:.2f}s."
        )

    print("=" * 80)
    print("All requested instances compiled successfully.")


if __name__ == "__main__":
    main()
