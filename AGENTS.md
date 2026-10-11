# Mandatory Project Rules: Scientific Honesty and Communication

This file defines the permanent behavioral and communication directives for all agents, subagents, and models interacting with this repository.

---

## 1. Radical Honesty and Epistemological Rigor (Anti-AI-Slop)
- **Always speak honestly, soberly, realistically, and directly.**
- All forms of "AI-hype", artificial complacency, unjustified optimism, and grandiose claims ("Grand Theorem Proven", "100% Solved", "Ready for Publication", "Definitive Breakthrough") are strictly forbidden.
- Communication must adopt the austere and precise tone of a skeptical mathematician or forensic auditor.

---

## 2. Strict Four-State Taxonomy
Every reported result must be explicitly categorized into one of these four operational states:
1. **PROVED:**
   - In Lean 4: Requires 0 `sorry`, 0 `sorryAx`, and `#print axioms` showing exclusively standard foundations (`[propext, Quot.sound]`).
   - In SAT: Requires that the solver log explicitly terminates in `s UNSATISFIABLE` or `s SATISFIABLE`, and the DRAT proof is verified with `drat-trim` returning `s VERIFIED`.
2. **COMPILED:**
   - Code that compiles cleanly with `lake build` or standard compiler, but whose theorems contain `sorry`, transitively depend on `sorryAx`, or assume premises not formally certified in the kernel.
   - Production Python SAT compilers whose canonical symmetry cuts and constraint encodings pass deterministic unit test suites (`tests/test_canonical_sat_compilers.py`).
3. **EXPLORED:**
   - SAT searches that have not reached a conclusion (interrupted by timeout/SIGTERM or currently running), or Python/SMT (Z3) scripts that serve as exploratory heuristics without certified resolution proofs.
4. **PENDING:**
   - Open mathematical hypotheses, unresolved instances, or pending lemmas.

---

## 3. Forensic Anti-Hallucination Protocol
- If a prior claim or report does not match the actual state of files on disk, state explicitly:
  > **‘The claim is false according to the current state of the repository.’**
- It is strictly forbidden to assume a `.drat` file is complete merely because it exists.
- It is strictly forbidden to claim a process executed if there is no verifiable evidence in the logs.
- It is strictly forbidden to confuse a conditional proof (with added premises inside the formula) with an unconditional mathematical demonstration.

---

## 4. Real-World Context of Conway's 99-Graph
- Always remember that Conway's 99-graph is an open mathematical problem unsolved for over 50 years.
- If the graph exists, the prevailing consensus in the literature is that it is rigid ($\mathrm{Aut}(G) = \{1\}$).
- Searches under symmetry groups ($\mathbb{Z}_2, \mathbb{Z}_3, \mathbb{Z}_7$) only cover specific branches with automorphisms; if the graph lacks symmetries, these searches will never find it.

---

## 5. Z84 second-subconstituent reduction (feat/conway84-subconstituent)

`Conway/Z84Subconstituent.lean` proves `Matrix99.second_subconstituent_reduction`
(a *conditional* structural reduction, not a proof the 99-graph exists).

Verification commands used (all Lean runs under the 300 s / 2 GiB wrapper
`scratch/lead_bounded_20261007.py` with scratch stem dir `scratch/z84_block_20261011/`):

```bash
python3 -I -B scratch/lead_bounded_20261007.py scratch/z84_block_20261011/<stem> \
  /bin/sh -c 'cd "$1" && shift && exec "$@"' sh "<worktree>" \
  lake build Conway.Z84Subconstituent Conway.TestZ84Subconstituent
python3 -I -B scratch/lead_bounded_20261007.py scratch/z84_block_20261011/<stem> \
  /bin/sh -c 'cd "$1" && shift && exec "$@"' sh "<worktree>" \
  lake env lean Conway/Z84Subconstituent.lean
python3 -I -B scratch/lead_bounded_20261007.py scratch/z84_block_20261011/<stem> \
  /bin/sh -c 'cd "$1" && shift && exec "$@"' sh "<worktree>" \
  lake env lean Conway/TestZ84Subconstituent.lean
python3 -m pytest tests/test_z84_constants.py -q
```

Status: all `#print axioms` outputs for the six theorems are a subset of
`[propext, Quot.sound]` (no `sorryAx`, no `Classical.choice`). Note: on `Nat`,
`beq_self_eq_true n` pulls in `Classical.choice` (through the instance it is
applied at; the constant alone is axiom-free), while `beq_iff_eq.mpr rfl` is clean.
This tainted `targetRHS_diag` and `conway_vertex_degree` on `main`; it is fixed on
this branch. Kernel `decide` must not range over `∀ x : Fin n` with `B_val`/`K_val`
in the body (indexed `getElem!` exhausts 2 GiB); check the arrays against the
structural generators `genM`/`genB`/`genK` in one pass instead.
