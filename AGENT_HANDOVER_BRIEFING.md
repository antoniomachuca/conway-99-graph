# Handover document — corrected status of Conway-99

**Documentation review:** 21 September 2026

**Current detailed status:** [README](README.md), [technical report](docs/technical_report.md), and [agent handover](agents/handover_briefing.md).

## 1. Scientific corrections

- The restriction to an involution with a single fixed vertex already appears in Makhnev's September 2009 exposition, attributed to Makhnev–Minakova. It is not a discovery of this repository.
- The exclusion of order 7 was already known to Behbahani–Lam (2011). The local UNSAT/VERIFIED logs are evidence about the recorded formula, not a proof that its translation from graphs is correct.
- The fixed-point-free order-3 case must not be treated as excluded by conflating it with the case that has fixed points.
- The final Lean declarations for $f=5$ and $f=7$ include incompatible arithmetic hypotheses. The claim that they are unconditional, end-to-end formalized exclusions is incorrect: **The claim is false according to the current state of the repository.**
- **COMPILED:** the literal-`1` defect has been repaired in the canonical compilers and in the legacy route `build_z3_fpf_cnf.py`. 20 compiler tests, 11 input-audit tests, and 8 supervisor tests pass.
- **COMPILED:** the old local C used O10, support `{1,6}`, and repeated the secant class. The corrected disjoint C uses O11, support `{2,3}`. The earlier files are kept and new inputs are generated; this is not a new mathematical exclusion.

## 2. Current taxonomy

| Status | Scope |
|---|---|
| **PROVED** | Checker equivalence, selected structural lemmas, and audited arithmetic contradictions with standard axioms. Historical SAT-refutation records: only at the level of their formulas. |
| **COMPILED** | Earlier Lean build of 32 jobs with three `sorry` warnings; conditional wrappers; 39 selected Python tests pass (20 compilers, 11 audit, 8 supervisor). The aggregate classification still depends on `sorryAx`. |
| **EXPLORED** | Reproducible orbit calculation and searches without a certified resolution. No probability or percentage of progress is inferred from conflict counts. |
| **PENDING** | Repair and validate encodings, recover the exact provenance of inputs, verify coverage, complete formal interfaces, establish novelty, and resolve the open questions. |

The input `conway_z7_canonical.cnf` named in the log is not in the audited local root; the DRAT and the logs are. `drat-trim` was not rerun in this audit. The presence of those files does not complete the graph-to-CNF translation obligations.

## Authorized follow-up session — EXPLORED

On 21 September at 15:32:09 CEST a single search of **corrected disjoint C (O11)** was started: PID 12384, supervisor 12329, `nice 10`, seed 20260921, and binary DRAT. The configured maximum stop is **22 September at 03:32:09 CEST**, or earlier at 50 GiB of DRAT or fewer than 50 GiB free. The supervisor keeps partial artifacts and stops only its own process.

The directory is `/Volumes/Untitled/conway_local_run/f1_c_drat_20260921T132559366256Z`. It includes the input, hashes, a source copy, the manifest, logs, and `status.json`. This note records the startup; processes and status must be queried to confirm later activity. DRAT checking remains **PENDING**. GCP was not modified and no notifications were sent.

## 3. Historical record of 20 September — not current telemetry

The previous document, dated **20 September 2026 at 21:49 CEST**, reported the following data. They are kept as **communicated historical information**, not as measurements confirmed on the 21st:

| Item reported then | Communicated value |
|---|---|
| Branch A | Approximately 135,590,239 conflicts; 51 GB DRAT. |
| Branch B | Approximately 179,187,847 conflicts; 56 GB DRAT. |
| Branch C | Approximately 178,504,217 conflicts; 54 GB DRAT. |
| Total of the three branches | More than 493 million conflicts; none reported resolved. |
| Order 3 on GCP | More than 177 million conflicts on fixed-3 and 163 million on FPF. |
| Accumulated portfolio | More than 1,200 million on GCP and 1,740 million globally, according to the previous report. |
| VM | `conway-sat-worker`, `us-central1-b`, `e2-standard-16`; 16 solvers reported. |
| Uptime | 10 days, 9 hours, and 48 minutes reported. |
| Remote disk | Reported expansion from 550 GB to 850 GB; 824 GiB filesystem; 291 GB free and 65% used. |
| Interruptions and data loss | The previous report stated no interruption and 0 bytes lost; that check was not reconstructed here. |
| Mac | Reported reboot at 10:03 and 79 GiB free. |
| Order-7 DRAT | Reported local download of approximately 183 MB; the local files were inspected in the later audit. |

**PENDING:** verify the remote state with new evidence. The initial documentation review did not access the VM and did not launch searches. The authorized local follow-up and its startup record are described above; the historical data from the 20th are not current telemetry.

## 4. Interpretation and next steps

The retained order-7 records contain `s UNSATISFIABLE` and `s VERIFIED`, but the earlier statement of an unconditional local proof of the full case exceeded that evidence. The encoding and the provenance of the CNF must be verified before the verdict is transferred to the graph problem.

Probability estimates and time-to-UNSAT estimates have been removed from the [strategy report](docs/solver_strategy_and_probability_report.md). The pending priority is to validate the models and their mathematical interfaces. The checked formal code remains useful even if no further branch concludes; it does not by itself establish mathematical novelty or resolve the existence of a possible rigid graph.
