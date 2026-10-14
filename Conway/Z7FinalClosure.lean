import Conway.Z7Root32Close

namespace Matrix99

theorem conway_z7_impossible (h : HasZ7Symmetry) : False := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root32_root h
  have hlen := z7AfterRoot32Remaining_length
  have hnil : z7AfterRoot32Remaining = [] := List.eq_nil_of_length_eq_zero hlen
  rw [hnil] at hr
  exact List.not_mem_nil hr

theorem no_conway_z7_symmetry : ¬ HasZ7Symmetry := by
  intro h
  exact conway_z7_impossible h

theorem conway_no_z7_automorphism_kernel :
    ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
      ∃ (s : Fin 99 → Fin 99),
        (Function.Bijective s) ∧
        (s^[7] = id) ∧
        (∃ i, s i ≠ i) ∧
        (∀ i j, A (s i) (s j) = A i j) :=
  fun h_ex => no_conway_z7_symmetry (hasZ7Symmetry_iff.mpr h_ex)

#print axioms conway_z7_impossible
#print axioms no_conway_z7_symmetry
#print axioms conway_no_z7_automorphism_kernel

end Matrix99
