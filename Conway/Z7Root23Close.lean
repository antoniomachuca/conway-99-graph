import Conway.Z7Root21Close
import Conway.Z7Root23Search

namespace Matrix99

theorem exterior_root23_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root23Row j) : False :=
  exterior_pinned_false_of_search z7Root23Row z7Root23_noExtension C hC hrow

theorem no_exterior_root23 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root23Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root23_false C hC hrow

def z7AfterRoot23Remaining : List (List Nat) :=
  z7AfterRoot21Remaining.filter fun r => !(r == pinnedList z7Root23Row)

theorem z7AfterRoot23Remaining_length : z7AfterRoot23Remaining.length = 6 := by
  decide +kernel

theorem exterior_row_not_root23 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ pinnedList z7Root23Row := by
  intro hlist
  apply exterior_root23_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold pinnedList at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root23 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7AfterRoot21Remaining) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot23Remaining := by
  unfold z7AfterRoot23Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root23 C hC
  have hb : ((List.finRange 12).map (C 0) == pinnedList z7Root23Row) = false := by
    cases h : ((List.finRange 12).map (C 0) == pinnedList z7Root23Row) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root23_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot23Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root21_root h
  exact ⟨C, hC, exterior_row_mem_after_root23 C hC hr⟩

#print axioms exterior_root23_false
#print axioms no_exterior_root23
#print axioms exterior_row_not_root23
#print axioms exterior_row_mem_after_root23
#print axioms z7AfterRoot23Remaining_length
#print axioms conway_z7_has_after_root23_root

end Matrix99
