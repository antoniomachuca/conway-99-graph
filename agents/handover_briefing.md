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
- The historical canonical order-7 and order-3 encoders confused variable ID `1` with True. This helper defect was formally repaired on September 21, 2026 and regression-tested with four truth-table unit tests in `TestCompilerHelperSemantics` (17/17 tests passing). The active $f=1$ GCP search instances were compiled via `agent_b_cnf_compiler.py` and are structurally immune to this defect.

The earlier claim of unconditional end-to-end formal certification of all advertised graph exclusions is incorrect: **The claim is false according to the current state of the repository.**

## 2. Operational taxonomy

| Status | Supported scope |
|---|---|
| **PROVED** | Audited checker equivalence, selected structural lemmas, and standalone arithmetic contradictions with only `[propext, Quot.sound]`. Also historical SAT formula refutations where solver and checker logs contain `s UNSATISFIABLE` and `s VERIFIED`; this does not certify their graph encodings. |
| **COMPILED** | Successful 32-job Lean build with three `sorry` warnings; conditional graph-level wrappers; canonical compiler suite with 17 passing tests following the repair of the helper semantics defect. The aggregate classification theorem reports `[sorryAx, Quot.sound]`. |
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

Current cloud activity, external-drive contents, process IDs, free space, billing, and uptime were not queried. Their current verification status is **PENDING**. Historical records are preserved in [audit_log.md](audit_log.md) and the [September 20 handover record](../AGENT_HANDOVER_BRIEFING.md).

No graph-search process was started, stopped, or reconfigured by the documentation revision. No proof or CNF was regenerated. A partial proof trace does not establish that a fresh process can resume the prior learned solver state.

The previous SAT/UNSAT probability estimates have been withdrawn in the [strategy report](../docs/solver_strategy_and_probability_report.md). Conflict counts are neither disjoint search-space coverage nor a calibrated completion forecast.

## 5. Next work requires explicit scope

Prioritize semantic validation and proof interfaces before interpreting further solver output as new mathematics. Do not silently repair encoders while claiming that an old certificate validates the changed formula. Preserve exact inputs, versions, commands, and logs for any subsequent verification.

The checked Lean components and reproducible calculations retain value without another UNSAT result. No claim of mathematical novelty or publication readiness is supported by this handover. Symmetry-restricted searches cannot find a rigid graph, and proving rigidity would not decide existence.
