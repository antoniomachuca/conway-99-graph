import Conway.Z7ComplementParity
import Conway.Z7Root00Search

namespace Matrix99

theorem exterior_root0_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root0Row j) : False :=
  exterior_root0_false_of_search z7Root0_noExtension C hC hrow

theorem no_exterior_root0 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root0Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root0_false C hC hrow

def z7AfterRoot0Remaining : List (List Nat) :=
  z7ComplementRemainingRoots.filter fun r => !(r == z7Root0List)

theorem z7AfterRoot0Remaining_length : z7AfterRoot0Remaining.length = 27 := by
  decide +kernel

theorem exterior_row_not_root0 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ z7Root0List := by
  intro hlist
  apply exterior_root0_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold z7Root0List at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root0 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7ComplementRemainingRoots) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot0Remaining := by
  unfold z7AfterRoot0Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root0 C hC
  have hb : ((List.finRange 12).map (C 0) == z7Root0List) = false := by
    cases h : ((List.finRange 12).map (C 0) == z7Root0List) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root0_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot0Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_complement_remaining_root h
  exact ⟨C, hC, exterior_row_mem_after_root0 C hC hr⟩

#print axioms exterior_root0_false
#print axioms no_exterior_root0
#print axioms exterior_row_not_root0
#print axioms exterior_row_mem_after_root0
#print axioms z7AfterRoot0Remaining_length
#print axioms conway_z7_has_after_root0_root

end Matrix99
