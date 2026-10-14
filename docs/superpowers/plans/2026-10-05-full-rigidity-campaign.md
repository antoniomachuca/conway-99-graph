# PLAN: FULL RIGIDITY CAMPAIGN FOR THE CONWAY 99-GRAPH

Document date: 2026-10-05
Document status: DRAFT. Not committed to version control.
Revision: 2. Corrected after external review against the repository state.
Language: ASD-STE100 Simplified Technical English (core rules applied).

---

## 1. PURPOSE

This document gives a long-term plan. The target of the plan is one theorem:

> If a strongly regular graph with parameters (99, 14, 1, 2) exists, then its automorphism group is trivial.

The plan does not claim that this theorem is proved. The plan gives the work items, the order of the work items, the resources, and the risks.

---

## 2. SCOPE

The plan includes:

- The completion of the order-7 kernel proof in Lean 4.
- The refutation of the fixed-point-free order-3 case.
- The refutation of the involution case with one fixed vertex.
- The kernel verification of the two new refutations, or an honest alternative.
- The final rigidity theorem and the publication plan.

The plan does not include:

- A decision on the existence of the graph. This plan cannot find a rigid graph.
- A change to the four-state taxonomy in `AGENTS.md`.

---

## 3. REFERENCED DOCUMENTS

- `AGENTS.md`: rules for honesty and for the four-state taxonomy.
- `docs/superpowers/plans/2026-10-03-z7-row-cnf.md`: the order-7 row-problem plan.
- `docs/technical_report.md`: the literature attribution record.
- `manuscript/conway_involutions.tex`: the current technical note.
- `agents/audit_log.md`: the audit record.

---

## 4. DEFINITIONS

- **SRG**: strongly regular graph with parameters (99, 14, 1, 2).
- **CNF**: a Boolean formula in conjunctive normal form.
- **DRAT**: a proof format for unsatisfiable formulas.
- **Kernel**: the Lean 4 kernel. The kernel is the only trusted component.
- **Certificate pair**: one solver log that ends in `s UNSATISFIABLE`, and one checker log that ends in `s VERIFIED`, for the same CNF file.
- **CNF scope**: a certificate pair proves one formula only. It proves nothing about graphs until a proved bridge connects the formula to the graph.

---

## 5. CURRENT STATUS

This section uses the four-state taxonomy of `AGENTS.md`. Each row gives the CNF scope and the Lean scope separately.

| Item | CNF scope | Lean scope |
| :--- | :--- | :--- |
| Order-7 canonical formula (177,097 variables) | PROVED | COMPILED (`sorry`) |
| Order-7 exterior-row formula (26,166 variables) | PROVED | COMPILED (`sorry`) |
| Involution f=3, cases A and B | PROVED | COMPILED (`sorry`) |
| Fixed-3 order-3 formula | EXPLORED | COMPILED (`sorry`) |
| Fixed-point-free order-3 formula | EXPLORED | COMPILED (`sorry`) |
| Involution f=1 formula | EXPLORED | COMPILED (`sorry`) |
| Rigidity theorem | — | PENDING |

### 5.1 Forensic note on the order-7 artifacts

The verified pair for the 177,097-variable formula is on the external volume, in `/Volumes/Untitled/conway_repro_z7/`. The checker log there reports `s VERIFIED` after 103,482.837 seconds on the 177,097-variable formula. The proof file has 26,746,488,053 bytes.

WARNING: the files with the same base name at the repository root are a stale pair. The root `drat_trim_z7.log` and root `cadical_z7.log` name a formula with 176,613 variables and 421,562 clauses. The root `proof_z7_canonical.drat` has 192,218,491 bytes. These files do not certify the CNF that is on disk at the root. Do not cite the root logs for the canonical formula.

### 5.2 Literature attribution

The attributions were verified against primary sources on 2026-10-05. The repository held an inconsistency; it is corrected.

| Claim | Correct attribution | Source checked |
| :--- | :--- | :--- |
| Fixed-subgraph classification; involution has one fixed vertex | Makhnev–Minakova 2004, peer-reviewed | `references/paper_makhnev_minakova_2004.md`; bib key `makhnev2001automorphisms` |
| Prime divisors of the group order are in {2, 3}; order 7 excluded | Behbahani–Lam, thesis 2009 / journal 2011 | `references/thesis_behbahani_lam_2009.pdf`, Theorem 4.14 |
| Order-3 action has no fixed points | Behbahani–Lam, thesis 2009 / journal 2011 | Same theorem 4.14 |
| Groups of orders 6 and 9 excluded | Crnković–Maksimović 2020 | Cesarz–Woldar 2025, introduction, items (a) and (b) |

NOTE: the 2009 lecture slides of Makhnev are a secondary pointer only. The peer-reviewed source of 2004 exists and is cited.

Consequence of the cited results: the rigidity theorem needs exactly two new refutations. The involution case f=1 and the fixed-point-free order-3 case.

### 5.3 The 2.4 billion conflicts figure

The 12.5-day campaign accumulated more than 2.4 billion conflicts across the f=1 and the order-3 formulas together. This is an aggregate, not an f=1 measurement. The campaign started before the compiler repair of 2026-09-21. The manuscript states that some formulas can contain the literal-1 defect, and that part of the campaign can have used a wrong disjoint-class representative. This figure is not a difficulty bound for the corrected formulas. Do not use it as one.

---

## 6. GENERAL RULES FOR EVIDENCE

1. Use the four-state taxonomy for each claim. Give the CNF scope and the Lean scope separately.
2. Keep the solver log and the checker log for each CNF. A claim is PROVED only with a certificate pair for that exact file.
3. Record the SHA-256 hash of each CNF and each proof file in `SHA256SUMS.txt`.
4. Copy each certificate pair to the external volume. The free space on the external volume was 144 GiB on 2026-10-05.
5. Do not delete old artifacts. Do not overwrite output directories. Keep stale pairs, but mark them as stale.
6. Use positive controls before each campaign. A compiler that fails a positive control is not trusted.
7. Do not report a search as conclusive if the log has no verdict line.

---

## 7. PHASE 1: CLOSE THE ORDER-7 KERNEL PROOF

Target: `conway_no_z7_automorphism` becomes PROVED. Zero `sorry`. Axioms only `[propext, Quot.sound]`.

Known facts:

- The Lean reduction from the graph to the exterior-row equations is PROVED.
- The exterior-row formula is PROVED at CNF scope. Its proof has 4.75 GB and 1.4 billion resolution steps. The canonical formula proof has 26.7 GB. The kernel cannot check proofs of this size directly.
- A "33 roots" design does not exist in the repository. That figure comes from an estimate table outside the documents. The case split is a proposal, not established work.

Three routes are open:

- **Route A: case split.** Split the exterior-row problem into small cases. Solve each case. Check each small proof in the kernel with a reflective checker. The per-case proof size is not measured. Measure it on two or three cases before any schedule is trusted.
- **Route B: verified checker.** Verify a DRAT or LRAT checker in Lean. Run it on the existing large proof. If `native_decide` is used, the compiled checker is trusted code. Record this change of the trust base explicitly.
- **Route C: trusted external checker.** Keep `drat-trim` as trusted. Prove in Lean only the bridge from the graph to the CNF. This is weaker, and honest.

Constraints:

1. The checker must run in the Lean kernel. Do not use `native_decide` without recording the trust-base change. The manuscript states that the current modules contain no `native_decide`.
2. Efficient data structures are permitted inside the checker. The earlier no-heap-allocation constraint is removed. It made the checker slower and gave no extra safety.
3. Decide the route after the measurement of the per-case proof sizes in Route A.

Execution anchors: `scripts/z7_row_problem_cnf.py`, `scripts/solve_z7_row_problem.py`, `tests/test_z7_row_problem_cnf.py`, `Conway/Z7NonExistence.lean`, `Conway/Z7OrbitMatrix.lean`.

Estimate: 6 to 10 hours apply only to Route A with small per-case proofs. That premise is unmeasured. Route B is a project of weeks.

Exit condition: `conway_no_z7_automorphism` is PROVED, or a recorded decision to use Route C.

---

## 8. PHASE 2: REFUTE THE FIXED-POINT-FREE ORDER-3 CASE

Target: a certificate pair for the order-3 fixed-point-free CNF.

The current instance has 852,324 variables and 1,860,024 clauses. The search is EXPLORED, not conclusive.

Work items:

1. Add the known structural constraints to the encoder. Use the 1-factor neighborhood structure. Use the second-subconstituent counts.
2. Extend the positive controls. The order-3 control graph exists: the Berlekamp–van Lint–Seidel graph with a translation.
3. Build a standalone Kissat binary. Do not use the PySAT wrapper for long campaigns.
4. Run a portfolio: CaDiCaL and Kissat, with proof logging on.
5. Set a fixed budget before the run. Example budget: 30 days of wall time.
6. If the budget is consumed with no verdict, stop. Change to cube-and-conquer. Generate the cubes. Solve each cube with proof logging. Keep each cube certificate pair.
7. Check the proof with `drat-trim`. Record the hashes.

Execution anchors: `build_z3_fpf_cnf.py`, `scripts/build_z3_canonical_cnf.py`, `tests/test_canonical_sat_compilers.py`. The file `tests/test_z3_fixed3_encoding_coverage.py` covers the fixed-3 encoding only. It is not an anchor for this phase.

Exit condition: a certificate pair for the order-3 CNF, or a SAT result. See Section 12 for the SAT case.

Honest note: the search can consume the full budget with no verdict. Do not report progress as a result.

---

## 9. PHASE 3: REFUTE THE INVOLUTION CASE f=1

Target: a certificate pair for the involution CNF with one fixed vertex.

The instance has 666,309 variables and 1,508,157 clauses.

WARNING: plain CDCL search is not sufficient for this phase. Do not start another monolithic run without a certificate strategy.

Known facts:

- The column-weight identity CCᵀ = 10I + 2J is already in the manuscript, with the proof that every column of a binary solution has weight 2. Do not do this work again.
- No new algebraic identity is currently identified. Finding one is a research item. Its status is PENDING.
- Interrupted f=1 proof traces already occupy 14.4 GB in compressed form on the archive volume. Proof logging increases the storage need. The free space of 144 GiB is a narrow margin.

Work items:

1. Research item: look for new constraints. Candidates are orbit-matrix enumeration for involutions and interlacing constraints. There is no guarantee that a useful constraint exists.
2. Split the problem with cubes. Each cube must be small enough for a proof trace of manageable size.
3. Run the cubes in parallel. Keep one certificate pair per cube.
4. Aggregate the cube proofs, or keep the cube list as the certificate with a verified cube-coverage check.
5. Check the final proof with `drat-trim`. Record the hashes.

Execution anchors: `build_z2_f1_cnf.py`, `scripts/classify_z2_f1_incidence_matrix.py`, `tests/test_z2_f1_input_audit.py`, `validate_z2_f1_inputs.py`.

Exit condition: a certificate pair for the f=1 CNF, or a SAT result.

Honest note: this phase can fail. Months of compute can give no verdict. There is no known bound on the search time. This risk cannot be removed by engineering.

---

## 10. PHASE 4: KERNEL VERIFICATION OR AN HONEST ALTERNATIVE

Target: the two refutations are accepted at the strongest trust level that is feasible.

Work items:

1. Apply the route decision of Phase 1 to the new refutations.
2. If the proofs are large, the kernel route needs a case split with small per-case proofs, or a verified checker with a recorded trust-base change.
3. Formalize the reductions in Lean: an SRG with an involution gives the f=1 structure; an SRG with an order-3 fixed-point-free action gives the order-3 structure. Parts of this exist in `Conway/Z2Classification.lean` and `Conway/Z3Cycles.lean`.
4. State the two theorems. Each theorem: no SRG admits this automorphism. Zero `sorry`.
5. Run `#print axioms` on each theorem. Record the output.

Estimate: not bounded. It depends on the proof sizes of Phases 2 and 3, which do not exist yet. The earlier estimate of weeks was not justified and is withdrawn.

Exit condition: both theorems are PROVED, or the trust level is recorded honestly for each.

---

## 11. PHASE 5: FINAL THEOREM AND PUBLICATION

Work items:

1. Combine the two theorems with the cited literature results. The final theorem: if the SRG exists, its automorphism group is trivial.
2. Use the corrected attributions of Section 5.2. The involution classification rests on the peer-reviewed source of 2004.
3. The literature steps are cited, not re-proved in Lean. State this clearly in the paper.
4. Write the paper. Target journals, in order of fit:
   - Journal of Automated Reasoning, for the verification method.
   - A combinatorics journal, for the rigidity theorem, only if the mathematics is judged new by external review.
5. Send the preprint to external experts before submission. Include the authors of the cited symmetry papers.
6. Deposit all artifacts in Zenodo. Record the DOI in the paper.

---

## 12. ALTERNATIVE OUTCOME: A SATISFIABLE CASE

If a solver returns SATISFIABLE for one case:

1. Stop all other work.
2. Extract the graph from the model.
3. Check the graph in Lean with the decidable adjacency test. This check is fast.
4. Check the graph with an independent script.
5. If the graph is valid, this is a solution of the Conway problem. This outcome is not the target of this plan, but it is a stronger result.
6. Record all files and hashes before any announcement.

NOTE: the literature expects the graph to be rigid if it exists. Treat a SAT result as a possible encoder defect until the graph passes all independent checks.

---

## 13. RISKS

| Risk | Effect | Mitigation |
| :--- | :--- | :--- |
| Kernel evaluation is slow | Phases 1 and 4 exceed the estimate | Measure per-case proof sizes first. Keep Route C open. |
| The f=1 search gives no verdict | Phase 3 consumes months | Fixed budgets. Cube-and-conquer. |
| Proof files are too large | Verification fails | Proof trimming. Cube splitting. Check disk space before each run. |
| Encoder defect | Wrong result | Positive controls. Independent re-implementation. Cross-check with the CP-SAT model of Thakkar and Severini. |
| A case is SATISFIABLE | The plan changes | See Section 12. |
| Literature attribution is wrong in a submission | A false claim in the paper | Resolved on 2026-10-05 against primary sources. See Section 5.2. Keep the corrected lines. |
| Stale artifact pairs at the repository root | A false certificate claim | Done: `STALE_ARTIFACTS.md` created. Cite only hashed files. See Section 5.1. |
| `native_decide` enters the build silently | The trust base changes without notice | Grep for `native_decide` in each audit. |

---

## 14. SCHEDULE ESTIMATE

| Phase | Estimate | Confidence |
| :--- | :--- | :--- |
| Phase 1: order-7 kernel proof | 6 to 10 hours, only if Route A shows small per-case proofs | Low |
| Phase 2: order-3 refutation | Days to months of compute | Low |
| Phase 3: involution f=1 refutation | Months or more of compute | Very low |
| Phase 4: kernel verification | Not bounded before Phases 2 and 3 | Very low |
| Phase 5: paper and submission | Weeks | Medium |

Total: this is a campaign of months, with a real possibility of no conclusion in Phases 2 and 3. A search for a non-existence proof is not an engineering task with a fixed end date. Do not promise a date for the rigidity theorem.

---

## 15. MINIMUM PUBLISHABLE UNITS

If the full campaign stalls, these partial results are publishable, with honest framing:

1. Phase 1 alone: the first kernel-checked refutation of a symmetry case of the Conway problem. Target: Journal of Automated Reasoning. Framing: verification method, not new mathematics. The order-7 exclusion is from Behbahani–Lam 2011. A kernel certificate closes the encoding discrepancy that the Thakkar–Severini CP-SAT run left open. It is not a new combinatorial theorem.
2. Phases 1 and 2: two symmetry cases closed with kernel checks.
3. Phases 1, 2, 3, and 4: the rigidity theorem. This is the only unit with strong combinatorial novelty.

---

END OF PLAN
