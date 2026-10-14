/-
  Finite bounded reduction of the exterior equations.

  `ExteriorEquations` quantifies over `Nat`-valued 12×12 matrices, but every
  entry is bounded by 4, so a solution over `Nat` is equivalent to a solution
  over `Fin 5`. This is the first kernel step toward removing the `sorry` in
  `z7_orbit_matrix_nonexistence`: the refutation applies to a finite type.

  No new axioms. No `sorry`. No `native_decide`.
-/

import Conway.Z7ExteriorEncoding

namespace Matrix99

/-- The exterior equations over `Fin 5`-valued matrices. -/
def ExteriorEquationsF (D : Fin 12 → Fin 12 → Fin 5) : Prop :=
  (∀ i j, D i j = D j i) ∧
  (∀ i, D i i = 0 ∨ D i i = 2) ∧
  (∀ i, sum12 (fun j => (D i j).val) = 12) ∧
  (∀ i, (D i 0).val + (D i 1).val + (D i 2).val
      = (D i 3).val + (D i 4).val + (D i 5).val) ∧
  (∀ i j, sum12 (fun k => (D i k).val * (D j k).val) + (D i j).val
      = z7ExteriorTarget i j)

/-- A `Nat` solution restricts to a `Fin 5` solution, using the entry bound. -/
theorem exterior_finite_of_nat {C : Fin 12 → Fin 12 → Nat}
    (h : ExteriorEquations C) :
    ExteriorEquationsF (fun i j => ⟨C i j, Nat.lt_succ_of_le (h.2.1 i j)⟩) := by
  obtain ⟨hsym, hle, hdiag, hsum, hbal, htgt⟩ := h
  exact ⟨fun i j => Fin.ext (hsym i j),
    fun i => (hdiag i).elim (fun h0 => Or.inl (Fin.ext h0)) (fun h2 => Or.inr (Fin.ext h2)),
    hsum, hbal, htgt⟩

/-- A `Fin 5` solution embeds into a `Nat` solution. -/
theorem exterior_nat_of_finite {D : Fin 12 → Fin 12 → Fin 5}
    (h : ExteriorEquationsF D) :
    ExteriorEquations (fun i j => (D i j).val) := by
  obtain ⟨hsym, hdiag, hsum, hbal, htgt⟩ := h
  refine ⟨fun i j => congrArg Fin.val (hsym i j),
    fun i j => Nat.lt_succ_iff.mp (D i j).isLt, fun i => ?_, hsum, hbal, htgt⟩
  rcases hdiag i with h0 | h2
  · exact Or.inl (congrArg Fin.val h0)
  · exact Or.inr (congrArg Fin.val h2)

/-- Existence over `Nat` is equivalent to existence over `Fin 5`. -/
theorem exterior_equations_iff_finite :
    (∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C) ↔
      ∃ D : Fin 12 → Fin 12 → Fin 5, ExteriorEquationsF D :=
  ⟨fun ⟨_C, hC⟩ => ⟨_, exterior_finite_of_nat hC⟩,
   fun ⟨_D, hD⟩ => ⟨_, exterior_nat_of_finite hD⟩⟩

/-- The remaining refutation, restated over the finite type: with the
    hypothesis that no `Fin 5` matrix satisfies the exterior equations,
    the orbit matrix is excluded. This is the shape the certificate
    checking will feed. -/
theorem no_z7_orbit_matrix_of_no_finite_exterior
    (h : ¬ ∃ D : Fin 12 → Fin 12 → Fin 5, ExteriorEquationsF D) :
    ¬ HasZ7OrbitMatrix :=
  no_z7_orbit_matrix_of_no_exterior_equations
    (fun ⟨C, hC⟩ => h ⟨_, exterior_finite_of_nat hC⟩)

#print axioms exterior_equations_iff_finite
#print axioms no_z7_orbit_matrix_of_no_finite_exterior

end Matrix99
