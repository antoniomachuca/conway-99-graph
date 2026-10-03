/-
  Conway/Z7NonExistence.lean
  Formal Architecture and Path to Complete Lean 4 Proof
  ("Camino a una prueba Lean completa") for Non-Existence of Order-7 Automorphisms.

  Mathematical background:
  - Behbahani–Lam (2011) excludes order 7 in the literature.
  - Cesarz–Woldar Lemma 4.12 concerns the Frob(21) section, not the general Z_7 case.

  Architecture of the Formal Reduction:
  1. Graph-level symmetry:
     A Conway-99 adjacency matrix A with an automorphism s of order 7.
  2. Orbit quotient reduction (`conway_z7_induces_orbit_matrix`):
     PROVED graph-to-canonical-15-orbit construction from the explicit period-7 frame.
  3. Computational / Algebraic non-existence (`z7_orbit_matrix_nonexistence`):
     COMPILED placeholder; general matrix refutation and certificate-to-kernel link are PENDING.
     The legacy 296338-byte proof has extra Frob(21)-motivated restrictions and does not establish this declaration.
  4. Formal Transfer Theorem (`conway_no_z7_from_orbit_matrix_reduction`):
     PROVED as a conditional implication. The reduction premise is proved here;
     matrix non-existence remains PENDING.
  5. Main Non-Existence Theorem (`conway_no_z7_automorphism`):
     COMPILED; depends on the remaining matrix non-existence placeholder.

  Taxonomy Status:
  - `conway_no_z7_from_orbit_matrix_reduction`: PROVED as a conditional implication.
  - `hasZ7Symmetry_iff`: PROVED (0 sorry, [propext, Quot.sound]).
  - `conway_z7_induces_orbit_matrix`: PROVED graph-to-canonical-15-orbit construction.
  - `z7_orbit_matrix_nonexistence`: COMPILED placeholder; general refutation and certificate link PENDING.
  - `conway_no_z7_automorphism`: COMPILED and depends on sorryAx through matrix non-existence.
-/

import Conway.Matrix
import Conway.Z7OrbitMatrix
import Conway.OrbitQuotient
import Conway.Z7GraphFrame
import Conway.Z7RootedConstruction

namespace Matrix99

/-! ## 1. Graph-Level Order-7 Automorphism Predicates -/

/--
  Predicate stating that `s` is a non-trivial order-7 automorphism of adjacency matrix `A`.
  - `s` is bijective.
  - `s` has order 7 (s^[7] = id).
  - `s` is non-trivial (fixes not all vertices).
  - `s` preserves adjacency: A (s i) (s j) = A i j.
-/
def IsZ7Automorphism (A : Matrix99 Nat) (s : Fin 99 → Fin 99) : Prop :=
  Function.Bijective s ∧
  s^[7] = id ∧
  (∃ i, s i ≠ i) ∧
  (∀ i j, A (s i) (s j) = A i j)

/--
  Existence of a putative Conway-99 graph admitting an automorphism of order 7.
-/
def HasZ7Symmetry : Prop :=
  ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (s : Fin 99 → Fin 99), IsZ7Automorphism A s

/--
  Definitional equivalence between `HasZ7Symmetry` and the unpacked existential statement.
  Proved with 0 sorry and standard foundational axioms.
-/
theorem hasZ7Symmetry_iff :
    HasZ7Symmetry ↔
    (∃ (A : Matrix99 Nat), ConwayAdj A ∧
      ∃ (s : Fin 99 → Fin 99),
        (Function.Bijective s) ∧
        (s^[7] = id) ∧
        (∃ i, s i ≠ i) ∧
        (∀ i j, A (s i) (s j) = A i j)) := by
  dsimp [HasZ7Symmetry, IsZ7Automorphism]
  rfl


/-! ## 2. Formal Transfer Theorem (Camino a una prueba Lean completa) -/

/--
  Predicate asserting the existence of a valid 15x15 orbit quotient matrix
  under the Z_7 action.
-/
def HasZ7OrbitMatrix : Prop :=
  Nonempty Z7OrbitMatrix

def z7EquitableData (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (hs : IsZ7Automorphism A s) : ConwayOrbit.EquitableData A :=
  ConwayOrbit.cyclicEquitableData 7 (by decide) A s hs.2.1 hs.2.2.2

theorem conway_z7_quotient_row_sum (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (hs : IsZ7Automorphism A s) (i : Fin 99) :
    ConwayOrbit.sumFin ((z7EquitableData A s hs).entry i) =
      if (z7EquitableData A s hs).label i = i then 14 else 0 :=
  (z7EquitableData A s hs).row_sum 14 (conway_row_sum A hA) i

theorem conway_z7_quotient_weighted_symmetry (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (hs : IsZ7Automorphism A s) (i j : Fin 99) :
    ConwayOrbit.fiberSize (z7EquitableData A s hs).label i * (z7EquitableData A s hs).entry i j =
      ConwayOrbit.fiberSize (z7EquitableData A s hs).label j * (z7EquitableData A s hs).entry j i :=
  (z7EquitableData A s hs).weighted_symmetry hA.2.1 i j

theorem conway_z7_quotient_equation (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (hs : IsZ7Automorphism A s) (i j : Fin 99)
    (hi : (z7EquitableData A s hs).label i = i) :
    ConwayOrbit.sumFin (fun r => (z7EquitableData A s hs).entry i r * (z7EquitableData A s hs).entry r j) +
      (z7EquitableData A s hs).entry i j =
      12 * (if i = j then 1 else 0) + 2 * ConwayOrbit.fiberSize (z7EquitableData A s hs).label j := by
  apply (z7EquitableData A s hs).quotient_equation 12 2
  · intro u v
    rw [sumFin_eq_foldl]
    exact (hA.2.2.2 u v).trans (conway_target_formula u v)
  · exact hi

/--
  Formal Transfer Theorem ("Camino a una prueba Lean completa"):
  Reduces the global graph-level non-existence of Z_7 automorphisms to:
  1. The orbit matrix reduction (`conway_z7_induces_orbit_matrix`).
  2. The non-existence of `Z7OrbitMatrix` (`z7_orbit_matrix_nonexistence`).

  Status: PROVED as a conditional implication (0 sorry in this theorem body).
-/
theorem conway_no_z7_from_orbit_matrix_reduction
    (h_red : HasZ7Symmetry → HasZ7OrbitMatrix)
    (h_no_mat : ¬ HasZ7OrbitMatrix) :
    ¬ HasZ7Symmetry := by
  intro h_sym
  have h_ex := h_red h_sym
  exact h_no_mat h_ex

/-! ## 3. Orbit Quotient Reduction and Matrix Non-Existence -/

/--
  Theorem (Orbit Quotient Reduction for Z_7).
  The explicit period-7 graph frame yields the canonical rooted 15-orbit matrix.
-/
theorem conway_z7_induces_orbit_matrix :
    HasZ7Symmetry → HasZ7OrbitMatrix := by
  intro h
  obtain ⟨A, hA, s, hs⟩ := h
  obtain ⟨frame⟩ := conway_period7_graph_frame A hA s hs.2.1 hs.2.2.2 hs.2.2.1
  exact ⟨(rootedMatrixOfOrbitIndexing A hA s hs.2.1 hs.2.2.2
    frame.indexing frame.root_fixed frame.unique_fixed frame.neighborhood).canonicalize⟩

/--
  Theorem (Non-existence of Z7OrbitMatrix):
  No 15×15 orbit quotient matrix satisfying the general specification exists.

  Status: COMPILED placeholder; general matrix refutation and certificate-to-kernel link are PENDING.
  The legacy 296338-byte proof has extra Frob(21)-motivated restrictions and does not establish this declaration.
-/
theorem z7_orbit_matrix_nonexistence :
    ¬ HasZ7OrbitMatrix := by
  sorry

/-! ## 4. Main Non-Existence Theorem -/

/--
  Theorem (Behbahani–Lam 2011):
  No strongly regular graph with parameters srg(99, 14, 1, 2)
  admits an automorphism of order 7.

  Status: COMPILED; depends on `conway_z7_induces_orbit_matrix` and
  `z7_orbit_matrix_nonexistence`, hence transitively depends on sorryAx.
  Directly applies the conditional transfer theorem `conway_no_z7_from_orbit_matrix_reduction`.
-/
theorem conway_no_z7_automorphism :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (s : Fin 99 → Fin 99),
      (Function.Bijective s) ∧
      (s^[7] = id) ∧
      (∃ i, s i ≠ i) ∧
      (∀ i j, A (s i) (s j) = A i j) := by
  have h_not : ¬ HasZ7Symmetry :=
    conway_no_z7_from_orbit_matrix_reduction
      conway_z7_induces_orbit_matrix
      z7_orbit_matrix_nonexistence
  intro h_ex
  rw [← hasZ7Symmetry_iff] at h_ex
  exact h_not h_ex

/-! ## 5. Spectral Trace Contradiction Pipeline -/

/--
  Conditional refutation via spectral trace balance:
  If a reduction supplies an orbit matrix M with all diagonal entries zero,
  and if the resulting multiplicity a = 6 spectrum is refuted,
  then no Z_7 automorphism can exist. This assumes both the reduction and the refutation.

  Status: PROVED as a conditional implication; it is not a new unconditional result.
-/
theorem conway_no_z7_from_spectrum_refutation
    (h_red : HasZ7Symmetry → ∃ (M : Z7OrbitMatrix), (∀ i : Fin 15, M.B i i = 0) ∧ ∃ a : Int, Z7OrbitSpectrum M a)
    (h_refute_spec : ¬ ∃ (M : Z7OrbitMatrix), (∀ i : Fin 15, M.B i i = 0) ∧ ∃ a : Int, Z7OrbitSpectrum M a ∧ a = 6) :
    ¬ HasZ7Symmetry := by
  intro h_sym
  have ⟨M, h_diag, a, spec⟩ := h_red h_sym
  have h_forced : a = 6 ∧ (14 - a) = 8 :=
    z7_orbit_multiplicities_given_zero_diagonal M a spec h_diag
  exact h_refute_spec ⟨M, h_diag, a, spec, h_forced.1⟩

end Matrix99
