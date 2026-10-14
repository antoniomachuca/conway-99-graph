import Conway.Z7Root00Close
import Conway.Z7Root11Search

namespace Matrix99

theorem exterior_root11_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root11Row j) : False :=
  exterior_pinned_false_of_search z7Root11Row z7Root11_noExtension C hC hrow

theorem no_exterior_root11 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root11Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root11_false C hC hrow

def z7AfterRoot11Remaining : List (List Nat) :=
  z7AfterRoot0Remaining.filter fun r => !(r == pinnedList z7Root11Row)

theorem z7AfterRoot11Remaining_length : z7AfterRoot11Remaining.length = 26 := by
  decide +kernel

theorem exterior_row_not_root11 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ pinnedList z7Root11Row := by
  intro hlist
  apply exterior_root11_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold pinnedList at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root11 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7AfterRoot0Remaining) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot11Remaining := by
  unfold z7AfterRoot11Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root11 C hC
  have hb : ((List.finRange 12).map (C 0) == pinnedList z7Root11Row) = false := by
    cases h : ((List.finRange 12).map (C 0) == pinnedList z7Root11Row) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root11_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot11Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root0_root h
  exact ⟨C, hC, exterior_row_mem_after_root11 C hC hr⟩

#print axioms exterior_root11_false
#print axioms no_exterior_root11
#print axioms exterior_row_not_root11
#print axioms exterior_row_mem_after_root11
#print axioms z7AfterRoot11Remaining_length
#print axioms conway_z7_has_after_root11_root

end Matrix99
