import Conway.Matrix

namespace Matrix99

/--
  Theorem (Behbahani-Lam 2011, Cesarz-Woldar 2025):
  No strongly regular graph with parameters srg(99, 14, 1, 2)
  admits an automorphism of order 7.
-/
theorem conway_no_z7_automorphism :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (s : Fin 99 → Fin 99),
      (Function.Bijective s) ∧
      (s^[7] = id) ∧
      (∃ i, s i ≠ i) ∧ -- non-trivial
      (∀ i j, A (s i) (s j) = A i j) := by
  sorry

end Matrix99
