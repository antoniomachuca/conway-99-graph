# Agent State: Canonical SAT Compiler $\mathbb{Z}_3$ FPF (`state_sat_compiler_z3_fpf.md`)

## Operational Role
Encodes fixed-point-free order-3 automorphism orbit models into canonical DIMACS CNF formulas.

## Formulation Highlights
- 33 orbits of length 3; 0 fixed points.
- Quotient multiplier group action breaks circulant shift and reversal symmetries.
- Modular triangle parity cuts (total triangles $\equiv 0 \pmod 3$) reduce state space from $2^{33}$ to 12 valid states.
- Unit tested in `tests/test_canonical_sat_compilers.py`.
