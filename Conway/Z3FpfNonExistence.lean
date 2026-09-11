import Conway.Matrix

namespace Matrix99

/--
  Theorem (Behbahani-Lam 2011):
  Strongly regular graph srg(99, 14, 1, 2) cannot admit
  a fixed-point-free automorphism of order 3.
-/
theorem conway_no_z3_fpf_automorphism :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (g : Fin 99 → Fin 99),
      (Function.Bijective g) ∧
      (g^[3] = id) ∧
      (∀ i, g i ≠ i) ∧
      (∀ i j, A (g i) (g j) = A i j) := by
  sorry

end Matrix99
