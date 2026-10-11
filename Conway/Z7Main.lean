import Conway.Z7FinalClosure

namespace Matrix99

theorem no_exterior_equations :
    ¬ ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C := by
  rintro ⟨C, hC⟩
  obtain ⟨σ, _, hD, hr⟩ := exterior_has_canonical_root C hC
  have hr := exterior_row_mem_norm_remaining (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_parity_remaining (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_complement_remaining (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root0 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root11 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root01 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root02 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root04 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root05 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root06 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root07 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root08 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root09 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root10 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root12 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root13 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root14 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root15 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root16 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root17 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root18 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root19 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root20 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root21 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root23 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root24 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root27 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root28 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root29 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root30 (conjMatrix C σ) hD hr
  have hr := exterior_row_mem_after_root32 (conjMatrix C σ) hD hr
  have hnil : z7AfterRoot32Remaining = [] :=
    List.eq_nil_of_length_eq_zero z7AfterRoot32Remaining_length
  rw [hnil] at hr
  exact List.not_mem_nil hr

theorem z7_orbit_matrix_nonexistence : ¬ HasZ7OrbitMatrix :=
  no_z7_orbit_matrix_of_no_exterior_equations no_exterior_equations

theorem conway_no_z7_automorphism :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (s : Fin 99 → Fin 99),
      (Function.Bijective s) ∧
      (s^[7] = id) ∧
      (∃ i, s i ≠ i) ∧
      (∀ i j, A (s i) (s j) = A i j) :=
  conway_no_z7_automorphism_kernel

#print axioms no_exterior_equations
#print axioms z7_orbit_matrix_nonexistence
#print axioms conway_no_z7_automorphism

end Matrix99
