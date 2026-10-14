import Conway.Z7Root30Close
import Conway.Z7Root32Search

namespace Matrix99

theorem exterior_root32_false (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root32Row j) : False :=
  exterior_pinned_false_of_search z7Root32Row z7Root32_noExtension C hC hrow

theorem no_exterior_root32 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root32Row j) := by
  intro h
  obtain ⟨C, hC, hrow⟩ := h
  exact exterior_root32_false C hC hrow

def z7AfterRoot32Remaining : List (List Nat) :=
  z7AfterRoot30Remaining.filter fun r => !(r == pinnedList z7Root32Row)

theorem z7AfterRoot32Remaining_length : z7AfterRoot32Remaining.length = 0 := by
  decide +kernel

theorem exterior_row_not_root32 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    (List.finRange 12).map (C 0) ≠ pinnedList z7Root32Row := by
  intro hlist
  apply exterior_root32_false C hC
  intro j
  have hentry := congrArg (fun row => rowEntry row j) hlist
  rw [rowEntry_map] at hentry
  unfold pinnedList at hentry
  rw [rowEntry_map] at hentry
  exact hentry

theorem exterior_row_mem_after_root32 (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hr : (List.finRange 12).map (C 0) ∈ z7AfterRoot30Remaining) :
    (List.finRange 12).map (C 0) ∈ z7AfterRoot32Remaining := by
  unfold z7AfterRoot32Remaining
  rw [List.mem_filter]
  refine ⟨hr, ?_⟩
  have hne := exterior_row_not_root32 C hC
  have hb : ((List.finRange 12).map (C 0) == pinnedList z7Root32Row) = false := by
    cases h : ((List.finRange 12).map (C 0) == pinnedList z7Root32Row) with
    | false => rfl
    | true => exact absurd ((beq_iff_eq).1 h) hne
  rw [hb]
  decide

theorem conway_z7_has_after_root32_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat, ExteriorEquations C ∧
      (List.finRange 12).map (C 0) ∈ z7AfterRoot32Remaining := by
  obtain ⟨C, hC, hr⟩ := conway_z7_has_after_root30_root h
  exact ⟨C, hC, exterior_row_mem_after_root32 C hC hr⟩

#print axioms exterior_root32_false
#print axioms no_exterior_root32
#print axioms exterior_row_not_root32
#print axioms exterior_row_mem_after_root32
#print axioms z7AfterRoot32Remaining_length
#print axioms conway_z7_has_after_root32_root

end Matrix99
