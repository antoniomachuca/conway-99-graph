/-
  Conditional step from `Z7OrbitMatrix` to the exterior equations encoded by
  `scripts/z7_row_problem_cnf.py`.

  `no_z7_orbit_matrix_of_no_exterior_equations` is the Lean half of the link.
  It does not replay the DRAT proof, and it does not remove
  `z7_orbit_matrix_nonexistence`.
-/

import Conway.Z7ExteriorBlock
import Conway.Z7NonExistence

namespace Matrix99

def ExteriorEquations (C : Fin 12 → Fin 12 → Nat) : Prop :=
  (∀ i j, C i j = C j i) ∧
  (∀ i j, C i j ≤ 4) ∧
  (∀ i, C i i = 0 ∨ C i i = 2) ∧
  (∀ i, sum12 (C i) = 12) ∧
  (∀ i, C i 0 + C i 1 + C i 2 = C i 3 + C i 4 + C i 5) ∧
  (∀ i j, sum12 (fun k => C i k * C j k) + C i j = z7ExteriorTarget i j)

theorem Z7OrbitMatrix.exterior_equations (M : Z7OrbitMatrix) :
    ExteriorEquations (fun i j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j)) :=
  M.exterior_row_problem

theorem entry_domain (C : Fin 12 → Fin 12 → Nat) (h : ExteriorEquations C) (i j : Fin 12) :
    (i = j ∧ (C i j = 0 ∨ C i j = 2)) ∨ (i ≠ j ∧ C i j ≤ 4) := by
  by_cases hij : i = j
  · subst hij
    exact Or.inl ⟨rfl, h.2.2.1 i⟩
  · exact Or.inr ⟨hij, h.2.1 i j⟩

/--
  If no 12×12 matrix satisfies the exterior equations, then no orbit matrix exists.
  The checked CNF refutation is not a proof of the hypothesis.
-/
theorem no_z7_orbit_matrix_of_no_exterior_equations
    (h : ¬ ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C) : ¬ HasZ7OrbitMatrix := by
  intro hM
  obtain ⟨M⟩ := hM
  exact h ⟨fun i j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j), M.exterior_equations⟩

#print axioms Z7OrbitMatrix.exterior_equations
#print axioms no_z7_orbit_matrix_of_no_exterior_equations

end Matrix99
