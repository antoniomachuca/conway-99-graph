# Conway's 99-Graph Problem: Partial Formalization and Symmetry-Restricted Search

**Author:** Antonio Machuca — Universidad Rey Juan Carlos, Madrid, Spain

**Contact:** [am.machuca.2023@alumnos.urjc.es](mailto:am.machuca.2023@alumnos.urjc.es) / [contactoantoniomachuca@gmail.com](mailto:contactoantoniomachuca@gmail.com)

**Documentation audit:** September 21, 2026

**Technical note:** [LaTeX source](manuscript/conway_involutions.tex) · [PDF](manuscript/conway_involutions.pdf)

## Certificate deposit

CNF files, DRAT traces, and solver logs are gitignored. Cloning this repository does not reproduce the order-7 certificate.

Zenodo concept DOI: [10.5281/zenodo.22983775](https://doi.org/10.5281/zenodo.22983775).

- Published record [10.5281/zenodo.22995101](https://doi.org/10.5281/zenodo.22995101) (27 September 2026, version v2). It stores `conway_z7_canonical.cnf` (`p cnf 177097 422508`), the 26,746,488,053-byte `proof_z7_canonical.drat`, the CaDiCaL 1.9.5 log, the `drat-trim` log ending in `s VERIFIED`, and `SHA256SUMS.txt`. Zenodo reports MD5 `f8ec9e423465f4a28ca21402ab00718d` for that proof.
- Earlier published record [10.5281/zenodo.22983776](https://doi.org/10.5281/zenodo.22983776). It stores the same CNF next to a 192,218,491-byte proof from an earlier run. That record is not the verified certificate.

That formula is **PROVED** only together with `s UNSATISFIABLE` and `s VERIFIED` on the 26,746,488,053-byte proof. The graph-to-CNF implication remains **COMPILED**. The deposit is not the CP-SAT model of Thakkar and Severini. The Lean library and the compilers are not in the deposit.

## Scope and correction notice

This repository contains a partial Lean 4 formalization, Python SAT encoders, structural calculations, and records of symmetry-restricted searches for a strongly regular graph with parameters $(99,14,1,2)$. The existence problem remains open. No new mathematical restriction beyond the cited literature is established by this documentation audit.

Earlier versions overstated novelty, the completeness of the Lean formalization, and what the SAT certificates establish. In particular, the claim that the repository contains an unconditional, end-to-end kernel proof excluding involutions with five or seven fixed points is incorrect: **The claim is false according to the current state of the repository.** The corresponding declarations include additional arithmetic premises that are not derived from the graph in those proofs.

**Implementation update (September 21, 2026) — COMPILED:** the literal-1 defect is repaired in the canonical encoders and the separate legacy `build_z3_fpf_cnf.py`. The selected suites pass 39 tests: 20 compiler-helper tests, 11 local $f=1$ input-audit tests, and 8 bounded-runner tests. These are implementation checks, not kernel certificates.

**Branch C correction:** the historical local C file selects $O_{10}$, whose support is `{1,6}` and intersects the support `{0,1}` of $O_0$. It is another secant representative, not the disjoint branch. The corrected C selects $O_{11}$ with support `{2,3}`. Historical CNFs and cuts remain untouched; new outputs use new directories. The claim that the three historical local CNFs cover all three classes was false. Local base/A/B/legacy-C files were reproduced byte-for-byte from `build_z2_f1_cnf.py` and their recorded cuts; the prior attribution to `agent_b_cnf_compiler.py` is withdrawn because that file currently generates $Z_7$. Remote GCP provenance remains **PENDING**.

**Campaign conclusion and repository stabilization (September 23, 2026) — EXPLORED:** The remote GCP campaign (`conway-sat-worker`, 16 CaDiCaL solvers) concluded at 20:30 UTC on September 23, 2026 via automated finalizer timer. Across 12.5 days of execution, over 2.4 billion conflicts were accumulated across $f=1$ and order-3 actions without resolving satisfiability (`EXPLORED`). Cloud resources were dismantled and verified at 0 active instances/disks. Ad-hoc launcher and monitor scripts were pruned, and non-TestCase exploratory scripts moved to `scripts/exploratory/`, enabling clean, standard `unittest discover` execution across the 39 regression tests.


## 1. Mathematical background and prior work

For a candidate adjacency matrix $A$,

$$A=A^T,\qquad \mathrm{diag}(A)=0,\qquad A\in\{0,1\}^{99\times99},\qquad A^2+A=12I+2J.$$

The corresponding spectrum is $\{14^1,3^{54},(-4)^{44}\}$. Every neighborhood induces seven disjoint edges, $7K_2$, not seven triangles.

The following are **antecedents from the literature**, not new discoveries of this project. Citing them does not mean their complete proofs have been formalized here.

- **Involutions already reduce to one fixed vertex.** Theorem 1 in Makhnev's September 2009 lecture slides, attributed to Makhnev–Minakova, states that an automorphism of prime order $p=2$ fixes exactly one vertex. The slides also eliminate the other fixed-subgraph candidates using character integrality. Consequently, excluding $f=3,5,7,\ldots$ is not a new conclusion of this repository. [Makhnev, *Symmetric graphs and their automorphisms*](https://www.math.uni-bielefeld.de/~baumeist/sommerschule/makhnev.pdf).
- **Order 7 was already excluded.** Behbahani–Lam (2011) restricted possible prime-order automorphisms to orders 2 and 3, as explicitly recalled in the introduction of [Cesarz–Woldar (2025)](https://alco.centre-mersenne.org/articles/10.5802/alco.418/).
- **Order 3 must not be described as entirely excluded.** Crnković–Maksimović (2020) exclude the fixed-point case for order 3 and groups of orders 6 and 9. The fixed-point-free order-3 case must not be conflated with these exclusions. [Article](https://cdm.ucalgary.ca/article/view/62323).
- **Even-order reduction is inherited from prior results.** Combining the Cesarz–Woldar implication $2\mid |\mathrm{Aut}(G)|\Rightarrow |\mathrm{Aut}(G)|\mid6$ with the exclusion of order 6 leaves order 2. The arithmetic implication is formalized here; the graph-theoretic premises are supplied as assumptions.

See [the reference index](references/README.md) for bibliographic details. Novelty of a particular implementation or search reduction remains **PENDING**; no priority claim is made.

## 2. Status of the repository artifacts

The operational labels follow [AGENTS.md](AGENTS.md). A label applies to the stated artifact or proposition, not automatically to the intended graph-theoretic interpretation.

| Artifact or claim | Status | Exact scope |
|---|---|---|
| `conway_soundness` and `conway_complete` | **PROVED** | `checkConway A = true` is equivalent to the defined predicate `ConwayAdj A`; audited axiom dependencies are `[propext, Quot.sound]`. This is a checker, not a graph construction. |
| Audited structural lemmas | **PROVED** | `conway_k4_free`, `conway_neighborhood_one_factor`, `conway_diameter_at_most_two`, and the three-fixed-point dichotomy have only the standard audited axioms. These are not claimed as new mathematical facts. |
| Arithmetic contradiction lemmas | **PROVED** | Statements such as the impossibility of $7a=62$, or of specified incompatible residues. This does not certify the derivation of their premises from a graph action. |
| Graph-level conclusions packaged with external spectral, counting, or group-order premises | **COMPILED** | Includes the advertised $f=5$, $f=7$, parity-rigidity, and Cesarz–Woldar wrappers. Complete graph-to-premise formalization remains **PENDING**. |
| `GrandClassification.lean` and order-3/order-7 nonexistence stubs | **COMPILED** | The build succeeds, but the aggregate theorem depends on `sorryAx`. It is not a proof that the automorphism group has order 1 or 2. |
| Compiler-helper regression suite | **COMPILED** | All 20 tests pass, including the repaired legacy Z3-FPF route. Full graph-to-CNF certification remains pending; the additional 11 input-audit and 8 runner tests have narrower stated scopes. |
| Stored $f=3$ and order-7 SAT verification records | **PROVED**, at recorded formula level only | Solver logs contain `s UNSATISFIABLE` and checker logs contain `s VERIFIED`. Encoding correctness, branch coverage, and input provenance are separate obligations. These checks were inspected, not rerun during the documentation audit. |
| Incidence and stabilizer calculations for $f=1$ | **EXPLORED** | The Python calculation reproduces stabilizer suborbit sizes $1,1,20,20$, including the distinguished orbit; the other 41 labels split as $1+20+20$. This is not an audited end-to-end proof of CNF branch coverage. |
| Inconclusive SAT runs and uncertified Python/SMT analyses | **EXPLORED** | No conclusion follows from timeout, conflict count, proof-file size, or the mere presence of a `.drat` file. |
| Remaining searches, full rigidity, and graph existence | **PENDING** | A rigid graph, if one exists, is outside all searches imposing a nontrivial automorphism. Even proving rigidity would not decide existence. |

## 3. Known limitations

### Lean proofs: inspect the statement as well as the axioms

The final $f=5$ declaration assumes an `eps_1` with both `eps_1 = 18 ∨ eps_1 = 15` and `eps_1 % 7 = 6`. The analogous $f=7$ declaration assumes membership in `{7, 10, 13}` and residue 2. Lean correctly refutes those conjunctions, but the required graph-to-count and graph-to-spectrum connections are not supplied by those declarations.

Similarly, `ConwayAutGroupBounds` assumes the external group-order restrictions. The Cesarz–Woldar module verifies terminal arithmetic contradictions and conditional deductions, not the full orbit classification used in the published proofs.

`#print axioms` is necessary but not sufficient for auditing an advertised theorem. An assumption can hide an unformalized step without appearing as `sorryAx`.

### SAT encoders: distinction between Boolean constants and DIMACS literals

In unpatched canonical encoders and the separate legacy `build_z3_fpf_cnf.py`, variable allocation started at 1 while the helpers also treated integer `1` as true. All three routes are now repaired and regression-tested: `0` remains the false/non-edge sentinel, and `1` is an ordinary variable literal. This is **COMPILED**, not a formal kernel proof. Existing CNFs do not change when Python source is repaired; old inputs must not be silently substituted for regenerated ones.

The local $f=1$ compiler uses a separate Tseitin helper without that shortcut. Its base and historical branch inputs were reproduced exactly, and 2,394 cardinality expressions were checked symbolically against adjacency equations in its coordinate model. The corrected branch representatives are A=21, B=1, C=11. These finite software checks do not replace the missing kernel formalization or establish the provenance of remote runs.

### Reproducibility and historical records

The order-7 CNF, DRAT, and logs are gitignored; they are not in a clone. The on-disk files from the 10–11 September run are not the 24–26 September certificate. See [Certificate deposit](#certificate-deposit). A freshly generated CNF must not be assumed identical to either file.

The $f=3$ records provide one Case A pair and one Case B pair of solver/checker logs. Earlier tables claimed additional partitions and conflict counts not individually supported by those retained records. This revision does not certify all historical partitions.

Conflict totals across seeds can overlap in search effort. They are not a percentage of the mathematical search space eliminated, a probability of satisfiability, or a predictor of completion time. Current cloud process counts, disk space, and uptime were not checked in this audit.

## 4. Verification commands

Run from the repository root with the toolchain specified in `lean-toolchain` and the existing Python dependencies installed.

```bash
# Build the entire library
lake build
lake env lean Conway/TestMatrix.lean

# Run the 39 deterministic regression tests
python3 -B -m unittest discover -s tests -v

# Run the algebraic validation of the f=1 coordinate model
python3 -B scripts/validate_z2_f1_inputs.py
```

On September 23, 2026, the Lean build completed with 32 jobs and three `sorry` warnings. The full test discovery suite passes all 39 tests in ~5 seconds. Additional targeted axiom checks were run:

```bash
lake env lean --stdin <<'LEAN'
import Conway
#print axioms Matrix99.conway_soundness
#print axioms Matrix99.conway_complete
#print axioms Matrix99.conway_k4_free
#print axioms Matrix99.conway_neighborhood_one_factor
#print axioms Matrix99.conway_diameter_at_most_two
#print axioms Matrix99.conway_z2_f3_fixed_points_dichotomy
#print axioms Matrix99.conway_automorphism_group_restricted
LEAN
```

The first six declarations report `[propext, Quot.sound]`; the last reports `[sorryAx, Quot.sound]`.

For the retained $f=3$ formula/proof files, independent checker commands are:

```bash
# Case A (Triangle K_3)
./drat-trim/drat-trim conway_z2_f3_case_a.cnf proof_z2_f3_case_a.drat

# Case B (Independent Set 3K_1)
./drat-trim/drat-trim conway_z2_f3_case_b.cnf proof_z2_f3_case_b.drat
```

These check the specified formulas only. The documentation audit read the existing terminal verdicts; it did not run these commands again.

To rebuild the revised technical note:

```bash
cd manuscript
latexmk -pdf -interaction=nonstopmode -halt-on-error conway_involutions.tex
```

### Controlled local sessions

`python3 -B scripts/validate_z2_f1_inputs.py --prepare-under "/Volumes/Untitled/conway_local_run" --branch C` creates a new timestamped directory with the corrected input, hashes, source snapshots, and `validation.json`; it does not start a solver. `python3 -B scripts/run_bounded_local_search.py --help` describes the separate bounded launcher. It requires explicit time/proof budgets, checks input/source hashes and available disk space, refuses existing run artifacts, and records `manifest.json`, `status.json`, and logs. Do not reuse a previous session directory.

A user-authorized **EXPLORED** run of corrected C started on September 21 at 15:32:09 CEST in `/Volumes/Untitled/conway_local_run/f1_c_drat_20260921T132559366256Z`: one CaDiCaL 1.9.5 process, seed 20260921, `nice 10`, binary DRAT, at most 12 hours or 50 GiB proof, with a 50 GiB free-space reserve. The configured latest stop is September 22 at 03:32:09 CEST. This is a startup record; query the processes and `status.json` for live state. Proof verification remains **PENDING**. No GCP operation or notification was performed.

## 5. Navigation

- [Certificate deposit](#certificate-deposit): which Zenodo record holds the order-7 files, and which published record does not.
- [Technical audit and analytical reconstructions](docs/technical_report.md): exact proof boundaries, encoding counterexample, incidence calculation, and verification obligations.
- [Search strategy and evidence limits](docs/solver_strategy_and_probability_report.md): withdrawn probability estimates and requirements for meaningful experiments.
- [Lean library](Conway): definitions, checker, structural lemmas, conditional deductions, and unfinished nonexistence declarations.
- [Canonical compiler tests](tests/test_canonical_sat_compilers.py): the existing limited regression suite.
- [Current handover](agents/handover_briefing.md): corrected context for future work.
- [Historical audit log](agents/audit_log.md): previous entries preserved with a superseding correction notice. Material in `archive/` and `correspondence/` is historical and may repeat superseded claims.

## 6. What remains useful

The checked Lean components and reproducible orbit calculations remain useful even if no further SAT run concludes. The repository can support work on formalization, encoding validation, and controlled computational experiments. Establishing an original methodological contribution requires additional validation and a comparison with prior work; it is not established by this audit.

Immediate priorities are to repair and test the encoding semantics, establish input provenance and branch completeness, and formalize the missing mathematical interfaces. These are **PENDING** tasks, not changes performed by this documentation revision.

## 7. AI assistance and license

The repository and this documentation revision were developed with AI assistance. Such assistance is not independent mathematical review. Validation claims are limited to the specific theorem statements, test executions, and recorded certificate checks described above; the earlier assertion that every mathematical claim had been deterministically verified is withdrawn.

Licensed under [Apache License 2.0](LICENSE).
