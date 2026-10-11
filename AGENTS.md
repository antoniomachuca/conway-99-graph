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

## 5. Verification Notes for Lean 4.33.1
- The `by_cases` macro opens `Classical`. For the restricted foundation policy above, use explicit computable `Decidable` instances and constructive case splits when needed, then inspect the final theorem's transitive axioms.
- Library simplification lemmas can introduce `Classical.choice` even when the source contains no explicit classical command. This was observed for `Int.natCast_eq_zero`; use the axiom output, not a source-text scan, as the final gate.
- Targeted checks for the root coverage and root-26 bridge are `lake build Conway.Z7RootCoverage Conway.Z7Root26Bridge`, followed by `lake env lean -M1536 -j1 Conway/Z7RootCoverage.lean` and the analogous command for `Conway/Z7Root26Bridge.lean`. Coverage does not certify all root refutations, and a root-specific bridge does not certify the entire Python encoder.
- For Z7 row-norm work, verify `lake build Conway.Z7Root22Arithmetic Conway.TestZ7RootNorm`. Keep closed finite arithmetic certificate checks kernel-based (`decide +kernel`). If `omega` treats `Fin` projections and their Nat values as unrelated atoms, expose a Nat-typed lemma before changing resource limits or mathematical constraints.
- Parity checks: `lake build Conway.Z7ComplementParity Conway.TestZ7RootParity Conway.TestZ7ComplementParity`. Write bang lookups as `xs[i]! = ...` with a space; `xs[i]!=...` parses as Boolean inequality, not a bang lookup followed by equality.
- Z7 closure: `Conway/Z7FinalClosure.lean` proves `conway_no_z7_automorphism_kernel` from the 33 root exclusions. The older `conway_no_z7_automorphism` in `Z7NonExistence.lean` still uses `sorry`, and `Z2Classification`/`GrandClassification` still call it. Audit with `lake build Conway.Z7FinalClosure` and `#print axioms Matrix99.conway_no_z7_automorphism_kernel`.
- Kernel memory: measure physical footprint (`proc_pid_rusage` `ri_phys_footprint`, as in `scratch/lead_bounded_long_20261011.py`), not `ps` RSS; RSS hid 20 GB of compressed and swapped memory. Kernel caches are per declaration, so split large `decide +kernel` checks into many theorems: `z7UnaryRows_cached_i` (depth-4 generator split), the chunked per-root Search template (`scripts/z7_search_template.py`), and the five `cauchyCheck_ok_a` lemmas. Avoid `DecidableEq`/`BEq` instances on large `List (List Nat)`; use explicit Bool comparators with soundness lemmas. Long `rw` chains over goals containing large literals grow quadratically; assemble in groups of at most 16.
- Build heavy modules one target per `lake build`; multi-target builds run several Lean processes in parallel and exceed the memory cap.
- `scripts/run_lean_root_closer.py` exits immediately while `scratch/closer.pause` exists. Another agent on this machine has restarted the closer before.
