import Conway.Z7Root11Close
import Conway.Z7Root01Search

namespace Matrix99

theorem exterior_root01_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root01Row j) : False :=
  exterior_pinned_false_of_search z7Root01Row z7Root01_noExtension C hC hrow

theorem no_exterior_root01 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root01Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root01_false C hC hrow

def z7AfterRoot01Remaining : List (List Nat) :=
  z7AfterRoot11Remaining.filter fun r => !(r == pinnedList z7Root01Row)

theorem z7AfterRoot01Remaining_length : z7AfterRoot01Remaining.length = 25 := by
  decide +kernel

theorem exterior_row_not_root01 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ pinnedList z7Root01Row := by
  intro hlist
  apply exterior_root01_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold pinnedList at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root01 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7AfterRoot11Remaining) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot01Remaining := by
  unfold z7AfterRoot01Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root01 C hC
  have hb : ((List.finRange 12).map (C 0) == pinnedList z7Root01Row) = false := by
    cases h : ((List.finRange 12).map (C 0) == pinnedList z7Root01Row) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root01_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot01Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root11_root h
  exact ⟨C, hC, exterior_row_mem_after_root01 C hC hr⟩

#print axioms exterior_root01_false
#print axioms no_exterior_root01
#print axioms exterior_row_not_root01
#print axioms exterior_row_mem_after_root01
#print axioms z7AfterRoot01Remaining_length
#print axioms conway_z7_has_after_root01_root

end Matrix99
