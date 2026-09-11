import Conway.Matrix

namespace Matrix99

/--
  Theorem (Crnkovic-Maksimovic 2020, Behbahani-Lam 2011):
  Strongly regular graph srg(99, 14, 1, 2) cannot admit
  an automorphism group isomorphic to Z_3 with 3 fixed points.
-/
theorem conway_no_z3_fixed3_automorphism :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (g : Fin 99 → Fin 99),
      (Function.Bijective g) ∧
      (g^[3] = id) ∧
      (∃ (f1 f2 f3 : Fin 99), f1 ≠ f2 ∧ f2 ≠ f3 ∧ f1 ≠ f3 ∧
        g f1 = f1 ∧ g f2 = f2 ∧ g f3 = f3 ∧
        (∀ i, g i = i → i = f1 ∨ i = f2 ∨ i = f3)) ∧
      (∀ i j, A (g i) (g j) = A i j) := by
  sorry

end Matrix99
