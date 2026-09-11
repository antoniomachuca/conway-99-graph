import Conway.Matrix

namespace Matrix99

/--
  Computational certificate verification:
  Given a candidate binary matrix A : Matrix99 Nat,
  evaluating `checkConway A` computes all properties:
  1. Zero diagonal
  2. Symmetry
  3. Binary entries in {0, 1}
  4. SRG matrix equation: A^2 + A = 12*I + 2*J
-/
def verifyCandidate (A : Matrix99 Nat) : Bool :=
  checkConway A

/--
  Computational reflection soundness theorem:
  If `checkConway A = true`, then `ConwayAdj A` holds.
  Formally proven via List.all_eq_true and List.mem_finRange without axioms or sorries.
-/
theorem conway_soundness (A : Matrix99 Nat) (h : checkConway A = true) : ConwayAdj A := by
  unfold checkConway at h
  rw [Bool.and_eq_true, Bool.and_eq_true, Bool.and_eq_true] at h
  rcases h with ⟨⟨⟨h_diag, h_symm⟩, h_bin⟩, h_srg⟩
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro i
    have h_mem := List.mem_finRange i
    have h_all_i := List.all_eq_true.mp h_diag i h_mem
    exact beq_iff_eq.mp h_all_i
  · intro i j
    have hi_mem := List.mem_finRange i
    have hj_mem := List.mem_finRange j
    have h_all_i := List.all_eq_true.mp h_symm i hi_mem
    have h_all_j := List.all_eq_true.mp h_all_i j hj_mem
    exact beq_iff_eq.mp h_all_j
  · intro i j
    have hi_mem := List.mem_finRange i
    have hj_mem := List.mem_finRange j
    have h_all_i := List.all_eq_true.mp h_bin i hi_mem
    have h_all_j := List.all_eq_true.mp h_all_i j hj_mem
    dsimp at h_all_j
    rw [Bool.or_eq_true] at h_all_j
    rcases h_all_j with h0 | h1
    · left; exact beq_iff_eq.mp h0
    · right; exact beq_iff_eq.mp h1
  · intro i j
    have hi_mem := List.mem_finRange i
    have hj_mem := List.mem_finRange j
    have h_all_i := List.all_eq_true.mp h_srg i hi_mem
    have h_all_j := List.all_eq_true.mp h_all_i j hj_mem
    exact beq_iff_eq.mp h_all_j

/--
  Completeness theorem:
  If `ConwayAdj A` holds, then `checkConway A = true`.
-/
theorem conway_complete (A : Matrix99 Nat) (h : ConwayAdj A) : checkConway A = true := by
  rcases h with ⟨h_diag, h_symm, h_bin, h_srg⟩
  unfold checkConway
  rw [Bool.and_eq_true, Bool.and_eq_true, Bool.and_eq_true]
  refine ⟨⟨⟨?_, ?_⟩, ?_⟩, ?_⟩
  · unfold isZeroDiagonal
    rw [List.all_eq_true]
    intro i _
    exact beq_iff_eq.mpr (h_diag i)
  · unfold isSymmetric
    rw [List.all_eq_true]
    intro i _
    rw [List.all_eq_true]
    intro j _
    exact beq_iff_eq.mpr (h_symm i j)
  · unfold isBinary
    rw [List.all_eq_true]
    intro i _
    rw [List.all_eq_true]
    intro j _
    dsimp
    rw [Bool.or_eq_true]
    rcases h_bin i j with h0 | h1
    · left; exact beq_iff_eq.mpr h0
    · right; exact beq_iff_eq.mpr h1
  · unfold satisfiesSRGEquation
    rw [List.all_eq_true]
    intro i _
    rw [List.all_eq_true]
    intro j _
    exact beq_iff_eq.mpr (h_srg i j)

/--
  Decidable instance enabling `by decide` on concrete matrix expressions.
  Fully verified by iff equivalence with `checkConway A = true`.
-/
instance (A : Matrix99 Nat) : Decidable (ConwayAdj A) :=
  decidable_of_iff (checkConway A = true) ⟨conway_soundness A, conway_complete A⟩

end Matrix99
