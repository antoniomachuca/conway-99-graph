import Conway.Z7Root24Close
import Conway.Z7Root27Search

namespace Matrix99

theorem exterior_root27_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root27Row j) : False :=
  exterior_pinned_false_of_search z7Root27Row z7Root27_noExtension C hC hrow

theorem no_exterior_root27 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root27Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root27_false C hC hrow

def z7AfterRoot27Remaining : List (List Nat) :=
  z7AfterRoot24Remaining.filter fun r => !(r == pinnedList z7Root27Row)

theorem z7AfterRoot27Remaining_length : z7AfterRoot27Remaining.length = 4 := by
  decide +kernel

theorem exterior_row_not_root27 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ pinnedList z7Root27Row := by
  intro hlist
  apply exterior_root27_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold pinnedList at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root27 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7AfterRoot24Remaining) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot27Remaining := by
  unfold z7AfterRoot27Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root27 C hC
  have hb : ((List.finRange 12).map (C 0) == pinnedList z7Root27Row) = false := by
    cases h : ((List.finRange 12).map (C 0) == pinnedList z7Root27Row) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root27_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot27Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root24_root h
  exact ⟨C, hC, exterior_row_mem_after_root27 C hC hr⟩

#print axioms exterior_root27_false
#print axioms no_exterior_root27
#print axioms exterior_row_not_root27
#print axioms exterior_row_mem_after_root27
#print axioms z7AfterRoot27Remaining_length
#print axioms conway_z7_has_after_root27_root

end Matrix99
