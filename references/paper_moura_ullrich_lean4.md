# Bibliographic Dossier: de Moura & Ullrich (2021)

## Citation Details
- **Authors:** Leonardo de Moura and Sebastian Ullrich
- **Title:** The Lean 4 Theorem Prover and Programming Language
- **Conference:** 28th International Conference on Automated Deduction (CADE-28), 2021
- **Proceedings:** *Automated Deduction -- CADE 28*, Lecture Notes in Computer Science (LNCS), Vol. 12699, pp. 625–635, Springer.
- **DOI:** [10.1007/978-3-030-79876-5_37](https://doi.org/10.1007/978-3-030-79876-5_37)
- **Official Documentation:** [https://lean-lang.org/](https://lean-lang.org/)

---

## Role in Conway-99 Investigation

Lean 4 (toolchain `v4.33.1`) is used for a partial formalization. The September 21, 2026 audit distinguishes the following scopes:

1. **PROVED — candidate checking:** `conway_soundness` and `conway_complete` in [Decidable.lean](../Conway/Decidable.lean) establish equivalence between the Boolean checker and the matrix predicate defined in [Matrix.lean](../Conway/Matrix.lean).
2. **PROVED — selected structural statements:** targeted axiom checks confirm $K_4$-freeness, the neighborhood one-factor property, and diameter at most two in [Structural.lean](../Conway/Structural.lean), with only `[propext, Quot.sound]`. This is not a claim that every declaration in the module has been audited.
3. **PROVED arithmetic; COMPILED applications:** [CesarzWoldarTheorems.lean](../Conway/CesarzWoldarTheorems.lean) verifies terminal arithmetic contradictions, not the complete graph-action reductions of the published paper. [ParityRigidity.lean](../Conway/ParityRigidity.lean) deduces consequences of externally supplied group-order bounds.
4. **COMPILED — aggregate library:** the build succeeds with three `sorry` warnings. The aggregate classification declaration depends on `[sorryAx, Quot.sound]`; it is not an unconditional automorphism-group classification.
5. **PENDING — missing interfaces:** complete derivation of the external spectral, counting, and group-order premises from the graph. `#print axioms` alone does not establish that an assumed premise follows from the intended application.

The earlier description of full Cesarz–Woldar and graph-level parity-rigidity formalizations was overstated. See the [technical audit](../docs/technical_report.md) for the exact boundaries.
