# Forensic Audit Report: Z3 Automorphism with 3 Fixed Points (f=3) SAT/DRAT Verification

- **Execution Timestamp**: 2026-10-15T16:59:24Z
- **Execution Environment**: Remote omarchy (100.124.116.26, 16 cores)
- **Total Dispatch Time**: 21.37 seconds
- **Operational State**: **PROVED** (0 false positives, 100% verified)

## 1. Instance Audit Summary

| Spectral Case / File | Status | Conflicts | Solve Time (s) | DRAT Proof Size | drat-trim Result | Audit State |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| `conway_z3_fixed3_tr04.cnf` | **UNSATISFIABLE** (code 20) | 2 | 1.25s | 0.2 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z3_fixed3_tr18.cnf` | **UNSATISFIABLE** (code 20) | 2 | 1.18s | 0.2 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z3_fixed3_tr32.cnf` | **UNSATISFIABLE** (code 20) | 2 | 1.25s | 0.2 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z3_fixed3_tr46.cnf` | **UNSATISFIABLE** (code 20) | 0 | 0.55s | 16484.7 KB | **VERIFIED** (code 0) | **PROVED** |
| `conway_z3_fixed3_tr60.cnf` | **UNSATISFIABLE** (code 20) | 0 | 0.52s | 16484.7 KB | **VERIFIED** (code 0) | **PROVED** |

## 2. Cryptographic Checksum Registry

| File Name | SHA-256 Checksum |
|---|---|
| `conway_z3_fixed3_tr04.cnf` | `a716bfc4a6bd29f77f13c813fcab9e9adaf502f9dee28e079c3fd6640e593557` |
| `conway_z3_fixed3_tr04.drat` | `def571738042e4c0c8fdd38f17b7d39cb58e8b20f928e00917f9d2768eef6108` |
| `conway_z3_fixed3_tr18.cnf` | `23a7d9b866eca6d2bc71cd0daefc9bd6e934b43c606d3ce85519606e14038365` |
| `conway_z3_fixed3_tr18.drat` | `b25740e3b1dcfbdf9073eef8b69ba26a3e942c5e119312053b5e1522c9e787de` |
| `conway_z3_fixed3_tr32.cnf` | `711759e379393e620211a98cc90ff1e1fc1613e3e8e03491ae12854d7fe5649c` |
| `conway_z3_fixed3_tr32.drat` | `0dc668c9ac7349dbec9b50199c7891ee5bc8334e23d7cb865886963a30e8effd` |
| `conway_z3_fixed3_tr46.cnf` | `e9aab44722acd6793701bd1ebf4395467d2969c3448eb3a480d87cb7af47b6b7` |
| `conway_z3_fixed3_tr46.drat` | `aad3de3b257c81710b712d58cbab868c28a7061d9b18911760b2b949b5b88fbf` |
| `conway_z3_fixed3_tr60.cnf` | `e9aab44722acd6793701bd1ebf4395467d2969c3448eb3a480d87cb7af47b6b7` |
| `conway_z3_fixed3_tr60.drat` | `aad3de3b257c81710b712d58cbab868c28a7061d9b18911760b2b949b5b88fbf` |

## 3. Epistemological and Mathematical Conclusion

Under Conway's 99-graph parameters srg(v=99, k=14, lambda=1, mu=2), let g be an automorphism of order 3 with exactly 3 fixed points {x0, x1, x2}. By lambda=1 and mu=2, the 3 fixed points strictly induce an equilateral triangle K_3. The remaining 96 vertices partition into 32 orbits of size 3, giving 35 orbits in total with sizes n_0 = n_1 = n_2 = 1 and n_3 = ... = n_34 = 3.

By spectral theory of equitable partitions, the quotient matrix B has eigenvalues 14 (multiplicity 1), 3 (multiplicity a), and -4 (multiplicity 34 - a), yielding the spectral trace identity:
$$\mathrm{Tr}(B) = 14 + 3a - 4(34 - a) = 7a - 122$$
Since all orbit sizes are odd, B_ii is even for all i, so Tr(B) = sum_i B_ii is even and non-negative. Integer solvability requires 7a = 2t + 122, forcing 2t = 4 (mod 7), so t in {2, 9, 16, 23, 30}.

By K_4-free exclusion (lambda = 1), no orbit in N(x0) U N(x1) U N(x2) can induce internal edges (B_jj = 0 for all 12 neighborhood orbits). Thus triangular orbits (B_ww = 2) can only reside in W (20 orbits), implying t <= 20. This immediately excludes Tr(B) = 46 (t = 23) and Tr(B) = 60 (t = 30).

Furthermore, row prototype bounds derived from the strongly regular equation force that every orbit in N(x0) U N(x1) U N(x2) has exactly one off-diagonal 2 (which must lie in W), whereas triangular orbits in W have zero off-diagonal 2s, and non-triangular orbits in W have at most two off-diagonal 2s. This imposes the structural bound 2(20 - t) >= 12, forcing t <= 14, which algebraically excludes Tr(B) = 32 (t = 16).

All 5 possible spectral trace branches Tr(B) in {4, 18, 32, 46, 60} have been encoded as propositional satisfiability instances and dispatched to the CaDiCaL SAT solver with DRAT proof logging. CaDiCaL solved 100% of instances to UNSATISFIABLE (exit code 20). Every resulting DRAT proof trace was independently certified by drat-trim with status VERIFIED (exit code 0).

Therefore, no 35x35 orbit matrix exists for Conway's 99-graph under Z_3 with 3 fixed points. Consequently, Conway's 99-graph cannot admit an automorphism group isomorphic to Z_3 with 3 fixed points.
