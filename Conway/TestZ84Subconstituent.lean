import Conway.Matrix
import Conway.Structural
import Conway.Z84Subconstituent
import Conway.Z84Relabel

namespace Matrix99

/-- Zero 84-subconstituent used for negative controls. -/
def X0 : Matrix 84 84 := fun _ _ => 0

/-- The original (incorrect) row-0 statement claimed the value 14;
    with X = 0 the actual value differs. -/
theorem block_A_zero_row0_j1_ne_14 :
    Matrix99.mul (block_A X0) (block_A X0) ⟨0, by decide⟩ ⟨1, by decide⟩ +
        block_A X0 ⟨0, by decide⟩ ⟨1, by decide⟩ ≠ 14 := by
  decide +kernel

/-- Corrected value at j = 1: the expression equals 2. -/
theorem block_A_zero_row0_j1_eq_2 :
    Matrix99.mul (block_A X0) (block_A X0) ⟨0, by decide⟩ ⟨1, by decide⟩ +
        block_A X0 ⟨0, by decide⟩ ⟨1, by decide⟩ = 2 := by
  decide +kernel

/-- Corrected value at j = 15: the expression equals 2. -/
theorem block_A_zero_row0_j15_eq_2 :
    Matrix99.mul (block_A X0) (block_A X0) ⟨0, by decide⟩ ⟨15, by decide⟩ +
        block_A X0 ⟨0, by decide⟩ ⟨15, by decide⟩ = 2 := by
  decide +kernel

/-- The all-zero 84-subconstituent cannot complete to a Conway adjacency
    matrix: the required row-sum 12 fails. -/
theorem not_conwayAdj_block_A_zero :
    ¬ ConwayAdj (block_A X0) := by
  intro h
  have hr := (second_subconstituent_reduction X0).mp h
  have hs := hr.2.2.2.1 ⟨0, by decide⟩
  simp only [X0] at hs
  rw [foldl_const] at hs
  omega

#print axioms Matrix99.block_A_diag
#print axioms Matrix99.block_A_symm
#print axioms Matrix99.block_A_binary
#print axioms Matrix99.block_A_srg_0_0
#print axioms Matrix99.block_A_srg_0_j
#print axioms Matrix99.second_subconstituent_reduction
#print axioms Matrix99.sum99_split
#print axioms Matrix99.M_val_eq
#print axioms Matrix99.B_val_eq
#print axioms Matrix99.K_val_eq

end Matrix99
#print axioms Matrix99.conway_relabel_block
#print axioms Matrix99.conway_exists_iff_block
#print axioms Matrix99.conway_exists_iff_residual
