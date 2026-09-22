# Current Handover: Conway-99 Documentation and Verification Boundaries

**Updated:** September 21, 2026

**Rules:** [AGENTS.md](../AGENTS.md) remains authoritative.

**Current references:** [README](../README.md) and [technical audit](../docs/technical_report.md).

## 1. Corrections that must not be lost

- The restriction that an involution fixes exactly one vertex is prior work, not a discovery of this repository. Makhnev's September 2009 slides state the Makhnev–Minakova result explicitly. [Source](https://www.math.uni-bielefeld.de/~baumeist/sommerschule/makhnev.pdf).
- The exclusion of order 7 was already obtained by Behbahani–Lam (2011), as recalled by Cesarz–Woldar (2025).
- Order 3 is not entirely excluded by those citations. The fixed-point case is excluded in the literature; the fixed-point-free case must be treated separately.
- The advertised $f=5$ and $f=7$ Lean exclusions add incompatible arithmetic premises to the existential statement. The graph-to-premise derivation is not completed in those declarations.
- `ConwayAutGroupBounds` assumes external group-order facts. Arithmetic consequences of those assumptions are not a complete kernel formalization of the literature.
- **COMPILED:** the canonical encoders and the legacy root `build_z3_fpf_cnf.py` are repaired and covered by 20 compiler-helper tests. This is tested code, not a kernel proof. Local $f=1$ inputs were reproduced from `build_z2_f1_cnf.py` and their cuts, not `agent_b_cnf_compiler.py`; the latter currently implements $Z_7$. Remote provenance remains **PENDING**.
- **COMPILED:** 11 input-audit tests check the coordinate model, 2,394 symbolic cardinality equations, and actual branch indices. The old local C uses O10 with support `{1,6}`, another secant. Corrected disjoint C uses O11 with support `{2,3}`. Old CNFs/cuts remain intact; corrected files go into new directories.
- **COMPILED:** 8 bounded-runner tests exercise time, file-size, free-space, failure cleanup, and preservation of artifacts. The combined selected suites pass 39 tests.

The earlier claim of unconditional end-to-end formal certification of all advertised graph exclusions is incorrect: **The claim is false according to the current state of the repository.**

## 2. Operational taxonomy

| Status | Supported scope |
|---|---|
| **PROVED** | Audited checker equivalence, selected structural lemmas, and standalone arithmetic contradictions with only `[propext, Quot.sound]`. Also historical SAT formula refutations where solver and checker logs contain `s UNSATISFIABLE` and `s VERIFIED`; this does not certify their graph encodings. |
| **COMPILED** | Earlier 32-job Lean build with three `sorry` warnings; conditional wrappers; 39 selected Python tests passing (20 compiler, 11 input-audit, 8 runner). The aggregate classification still reports `[sorryAx, Quot.sound]`. |
| **EXPLORED** | Reproduced incidence/stabilizer calculation, uncertified Python/SMT analyses, and inconclusive searches. The computed $1+20+20$ split is not a complete encoding/coverage audit. |
| **PENDING** | Historical input provenance, branch coverage, missing Lean interfaces, methodological novelty, conclusive searches, rigidity, and existence. |

The undecorated binary matrix $C$ and the signed rooted coordinate structure have different relabeling groups. The values 15,360 and 768 describe stabilizer orders, not measured speedup factors. See the technical audit for the corrected variance calculation and group distinction.

## 3. Evidence and reproduction

The September 21 audit ran:

```bash
lake build
python3 -m unittest discover -s tests -p test_canonical_sat_compilers.py -v
```

It also ran targeted axiom checks, the small literal/constant counterexample, and the incidence group calculation. Commands and outputs are described in the README and technical audit.

The retained $f=3$ Case A and Case B logs and the order-7 logs record checked formula refutations. The audit did not rerun `drat-trim`. The order-7 input named `conway_z7_canonical.cnf` is absent from the audited repository root; do not assume a newly generated file matches the historical certificate. One retained Case A record is not evidence that all historical partitions were independently checked.

## 4. Historical operations are not live state

Remote cloud activity, inputs, billing, and uptime remain **PENDING** verification; no remote operation was performed. Historical records are preserved in [audit_log.md](audit_log.md) and the [September 20 handover record](../AGENT_HANDOVER_BRIEFING.md).

The initial documentation-only revision launched no graph search. A subsequent user-authorized implementation follow-up started one corrected **C disjoint** run on September 21 at **15:32:09 CEST**: solver PID 12384, supervisor PID 12329, `nice 10`, seed 20260921, binary DRAT. The configured maximum deadline is **September 22 at 03:32:09 CEST**, with a hard 50 GiB file-size limit and a 50 GiB free-space guard polled every five seconds. This is **EXPLORED**; a solver verdict would still require verification.

Session directory: `/Volumes/Untitled/conway_local_run/f1_c_drat_20260921T132559366256Z`. It contains `input.cnf`, `validation.json`, `sources/`, `run_plan.json`, `manifest.json`, `status.json`, `solver.log`, `supervisor.log`, and `proof.drat`, plus a regenerated legacy Z3-FPF CNF that was not launched. Check live processes and `status.json` before treating this startup record as current activity. No automatic proof-checker or notification service was launched. A partial DRAT does not provide a solver checkpoint.

The previous SAT/UNSAT probability estimates have been withdrawn in the [strategy report](../docs/solver_strategy_and_probability_report.md). Conflict counts are neither disjoint search-space coverage nor a calibrated completion forecast.

## 5. Next work requires explicit scope

Prioritize semantic validation and proof interfaces before interpreting further solver output as new mathematics. Do not silently repair encoders while claiming that an old certificate validates the changed formula. Preserve exact inputs, versions, commands, and logs for any subsequent verification.

The checked Lean components and reproducible calculations retain value without another UNSAT result. No claim of mathematical novelty or publication readiness is supported by this handover. Symmetry-restricted searches cannot find a rigid graph, and proving rigidity would not decide existence.
