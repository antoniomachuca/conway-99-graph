import Conway.Z7Root14Close
import Conway.Z7Root15Search

namespace Matrix99

theorem exterior_root15_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root15Row j) : False :=
  exterior_pinned_false_of_search z7Root15Row z7Root15_noExtension C hC hrow

theorem no_exterior_root15 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root15Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root15_false C hC hrow

def z7AfterRoot15Remaining : List (List Nat) :=
  z7AfterRoot14Remaining.filter fun r => !(r == pinnedList z7Root15Row)

theorem z7AfterRoot15Remaining_length : z7AfterRoot15Remaining.length = 13 := by
  decide +kernel

theorem exterior_row_not_root15 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ pinnedList z7Root15Row := by
  intro hlist
  apply exterior_root15_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold pinnedList at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root15 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7AfterRoot14Remaining) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot15Remaining := by
  unfold z7AfterRoot15Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root15 C hC
  have hb : ((List.finRange 12).map (C 0) == pinnedList z7Root15Row) = false := by
    cases h : ((List.finRange 12).map (C 0) == pinnedList z7Root15Row) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root15_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot15Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root14_root h
  exact ⟨C, hC, exterior_row_mem_after_root15 C hC hr⟩

#print axioms exterior_root15_false
#print axioms no_exterior_root15
#print axioms exterior_row_not_root15
#print axioms exterior_row_mem_after_root15
#print axioms z7AfterRoot15Remaining_length
#print axioms conway_z7_has_after_root15_root

end Matrix99
