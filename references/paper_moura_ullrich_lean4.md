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

Lean 4 (toolchain `v4.33.1`) serves as the foundational proof verification kernel for the deductive track (Track 2) of this project:

1. **Computational Reflection:**
   - Implements bounded matrix algebra in [`Conway/Matrix.lean`](../Conway/Matrix.lean).
   - Proves deductive soundness and completeness of boolean decision procedures (`checkConway` in [`Conway/Decidable.lean`](../Conway/Decidable.lean)).
2. **Structural Formalization:**
   - Proves $K_4$-freeness ($\omega(G) = 3$), $7K_2$ neighborhood matchings, and diameter $\le 2$ in [`Conway/Structural.lean`](../Conway/Structural.lean) with 0 `sorry`.
3. **Analytic Reductions:**
   - Formalizes Cesarz & Woldar Theorems 3.11 and 4.14 in [`Conway/CesarzWoldarTheorems.lean`](../Conway/CesarzWoldarTheorems.lean) with 0 `sorry`.
   - Proves the Parity Rigidity Corollary ($|\operatorname{Aut}(G)| \text{ even} \implies \operatorname{Aut}(G) \cong \mathbb{Z}_2$) in [`Conway/ParityRigidity.lean`](../Conway/ParityRigidity.lean) with 0 `sorry`.
   - Kernel verification is confirmed via `#print axioms` strictly depending on standard foundations `[propext, Quot.sound]`.
