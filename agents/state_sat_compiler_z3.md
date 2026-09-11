# Agent State: Canonical SAT Compiler $\mathbb{Z}_3$ (`state_sat_compiler_z3.md`)

## Operational Role
Encodes order-3 automorphism orbit models with 3 fixed points into canonical DIMACS CNF formulas.

## Formulation Highlights
- 3 fixed points form a triangle $K_3$ by $K_4$-freeness and $\lambda=1$.
- 32 orbits of length 3 partitioned under $S_3 \times \mathbb{Z}_2$ action.
- Lex-leader symmetry breaking clauses break color inversions and base permutations.
- Unit tested in `tests/test_canonical_sat_compilers.py`.
