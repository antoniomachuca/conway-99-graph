# Search Strategy and Limits of Computational Evidence

**Author:** Antonio Machuca

**Revision:** September 21, 2026

**Scope:** Corrected interpretation of the repository's symmetry-restricted SAT experiments. This report does not authorize or perform any process, storage, or cloud changes.

## 1. Withdrawal of unsupported probability claims

The previous version asserted a numerical bound on satisfiability probability and gave percentage forecasts for UNSAT completion over several time windows. Those estimates are withdrawn. No calibrated prior, likelihood model, benchmark population, or justified independence assumption was supplied for these instances.

Calling the claimed satisfiability bound a theorem was incorrect: **The claim is false according to the current state of the repository.** Applying Bayes' formula to unsupported numerical assumptions does not turn those assumptions into evidence.

**PENDING:** no quantitative probability of SAT, UNSAT, or completion by a deadline is established. The absence of a model after many conflicts does not provide such a probability. A conjecture that a graph is rigid is not a numerical prior justified by solver telemetry.

## 2. Mathematical targets and their status

The graph parameters are $(99,14,1,2)$, with spectrum $\{14^1,3^{54},(-4)^{44}\}$ and neighborhood $7K_2$. Earlier statements of a different spectrum or seven triangles in a neighborhood were incorrect.

| Target | Prior-work context | Repository experiment status |
|---|---|---|
| Order 2 with one fixed vertex | The one-fixed-vertex restriction is already in the Makhnev–Minakova results, recalled by Makhnev in 2009. | **EXPLORED:** searches using the A/B/C branch construction. Their conclusive resolution and complete encoding audit remain **PENDING**. |
| Order 2 with more fixed vertices | Already excluded in the prior classification; not a new frontier opened by this repository. | Structural and arithmetic Lean components have different scopes; complete graph-level wrappers are **COMPILED**, uncertified scripts **EXPLORED**. |
| Order 3, fixed-point-free | Must not be confused with the excluded fixed-point case. | **EXPLORED:** no conclusion from the audited local evidence. |
| Order 3 with three fixed vertices | Excluded in prior work by Crnković–Maksimović (2020). | **EXPLORED:** an unfinished local reproduction experiment, not a newly open mathematical case. |
| Order 7 | Excluded in prior work by Behbahani–Lam (2011). | **PROVED** only for the formula refutation recorded in the solver/checker logs; graph-encoding validation remains **PENDING**. |
| Full rigidity and existence | Distinct questions; rigidity would not imply nonexistence. | **PENDING**. Imposing a nontrivial automorphism excludes all rigid graphs from the search. |

Sources and exact artifact boundaries are recorded in the [README](../README.md) and [technical audit](technical_report.md).

## 3. Correctness precedes further computational interpretation

**COMPILED:** the canonical and legacy Z3-FPF literal-1 helpers are now repaired; 20 compiler tests, 11 local input-audit tests, and 8 runner tests pass. The follow-up audit also found that historical local C used O10, another secant representative; corrected disjoint C uses O11. Historical CNFs were preserved, so fixing source code does not make old inputs current. Full graph-level certification remains **PENDING**.

The current scripts and historical CNFs must not be assumed equivalent merely because their names match. The obligations now have different scopes:

1. **COMPILED:** local $f=1$ files were reproduced and hashed; remote input provenance remains **PENDING**.
2. **COMPILED:** the affected canonical and legacy helper routes are repaired and regression-tested. Retain these tests when changing encodings.
3. **PENDING:** complete formal graph-to-model interfaces, positive-example validation, and independently checked decoding.
4. **COMPILED:** finite stabilizer checks validate representatives A=21, B=1, C=11 in the coordinate model. The legacy C=10 file is not the disjoint case; full kernel integration remains **PENDING**.
5. **PENDING:** pair any eventual UNSAT verdict with its exact input and an independently verified complete refutation.

A SAT model should be decoded and checked directly against all graph conditions. A DRAT check validates a refutation of a formula; it does not validate the formula's interpretation.

The initial documentation audit did not repair code. The subsequent implementation follow-up repaired the helper routes and branch indexing, preserving old inputs. It does not invalidate proof-checker software or identify every historical run as affected.

## 4. What telemetry can and cannot establish

**EXPLORED:** an inconclusive run can record resource use and solver behavior for a particular formula, version, seed, configuration, and time budget. It is not a partial proof of graph nonexistence.

- Conflict counts from different runs need not cover disjoint parts of the search space. Their sum measures reported work, not distinct candidates eliminated.
- Different seeds do not make executions statistically independent or their search spaces disjoint.
- Eliminated variables, clause reductions, and low glue/LBD values are not calibrated measures of distance to the empty clause.
- An interrupted or large `.drat` file is not a completed proof.
- A heuristic hunter without proof logging can produce an UNSAT claim, but that claim requires a proof-producing/checking workflow before it meets the repository's certificate standard.
- A solver restart and a fresh process launch are not the same operation. Preserving a partial DRAT trace does not establish that the solver can resume its learned state from that trace.
- There is no demonstrated universal rule that rotating seeds is better than continuing a run, or that a particular branch will finish first.
- Removing DRAT output does not imply zero disk I/O or zero risk of disk exhaustion; logs and other processes still write data.

The earlier tables of projected completion probabilities and blanket guarantees about safe storage, uninterrupted progress, and seed diversification are not retained as current recommendations.

## 5. Requirements for useful benchmark records

For a future experiment, retain the following together:

| Record | Purpose |
|---|---|
| Generator revision, command, options, dependencies | Identify the model and reproduce compilation. |
| CNF and its cryptographic hash | Identify the exact input, independently of a descriptive filename. |
| Solver version, binary provenance, command, seed, options | Specify the experiment. |
| Hardware, resource limits, start/end times | Define the computational budget. |
| Full solver log and exit status | Distinguish SAT, UNSAT, timeout, interruption, and failure. |
| Proof or decoded candidate, with hashes | Preserve the claimed evidence. |
| Independent checker command, version, and terminal output | Establish the exact verification performed. |
| Graph-to-encoding and symmetry-cut justification | Support transfer from formula-level to graph-level conclusions. |

These are requirements, not a claim that every historical experiment already satisfies them. Controlled comparisons should include inconclusive runs and use comparable inputs and budgets. Runtime differences between unrelated encodings or hardware configurations do not establish a speedup caused by one symmetry cut.

## 6. Historical and live operational state

Older descriptions of machine load, PIDs, storage capacity, uptime, and accumulated conflicts are snapshots or prior reports, not live telemetry. The initial September 21 documentation audit did not query the cloud VM or external-drive sessions; the later local follow-up is recorded separately below. Current operational conditions remain **PENDING** verification.

Historical entries are preserved in [agents/audit_log.md](../agents/audit_log.md) with a superseding correction notice. Their presence is not evidence that each reported operation occurred or that every numerical aggregate was independently reconstructed.

The initial documentation-only revision performed no operational changes. A later user-authorized follow-up launched one corrected local C search with a 12-hour/50-GiB budget and a 50-GiB reserve; see the [current handover](../agents/handover_briefing.md) for its startup record and evidence directory. No cloud process was changed. Subsequent decisions require current evidence and authorization, not the withdrawn probability tables.

## 7. Defensible value without a concluding solve

A validated encoding, reusable checker, reproducible structural reduction, or carefully controlled benchmark can have value without a new UNSAT result. That value must be assessed separately from original mathematical discovery.

At present, the audited Lean components are **PROVED** within their stated scopes; the encoders are **COMPILED** with known limitations; the inconclusive experiments are **EXPLORED**; full semantic validation, novelty, rigidity, and existence remain **PENDING**. None of these labels supplies a probability or a completion forecast.
