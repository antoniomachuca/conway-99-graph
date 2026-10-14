import Conway.Z7Root06Close
import Conway.Z7Root07Search

namespace Matrix99

theorem exterior_root07_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root07Row j) : False :=
  exterior_pinned_false_of_search z7Root07Row z7Root07_noExtension C hC hrow

theorem no_exterior_root07 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root07Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root07_false C hC hrow

def z7AfterRoot07Remaining : List (List Nat) :=
  z7AfterRoot06Remaining.filter fun r => !(r == pinnedList z7Root07Row)

theorem z7AfterRoot07Remaining_length : z7AfterRoot07Remaining.length = 20 := by
  decide +kernel

theorem exterior_row_not_root07 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ pinnedList z7Root07Row := by
  intro hlist
  apply exterior_root07_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold pinnedList at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root07 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7AfterRoot06Remaining) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot07Remaining := by
  unfold z7AfterRoot07Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root07 C hC
  have hb : ((List.finRange 12).map (C 0) == pinnedList z7Root07Row) = false := by
    cases h : ((List.finRange 12).map (C 0) == pinnedList z7Root07Row) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root07_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot07Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root06_root h
  exact ⟨C, hC, exterior_row_mem_after_root07 C hC hr⟩

#print axioms exterior_root07_false
#print axioms no_exterior_root07
#print axioms exterior_row_not_root07
#print axioms exterior_row_mem_after_root07
#print axioms z7AfterRoot07Remaining_length
#print axioms conway_z7_has_after_root07_root

end Matrix99
