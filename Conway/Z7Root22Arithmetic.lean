import Conway.Z7RootNormBounds
import Conway.Z7Root26Arithmetic
import Conway.Z7RootCoverage
namespace Matrix99

def z7Root22Row (j : Fin 12) : Nat :=
  match j.val with
  | 0 => 2
  | 1 | 2 | 3 => 0
  | 4 | 5 | 6 | 7 | 8 | 9 | 10 => 1
  | _ => 3

theorem z7Root22Row_values : (List.finRange 12).map z7Root22Row =
    [2,0,0,0,1,1,1,1,1,1,1,3] := by decide

theorem z7Root22Row_manifest : (List.finRange 12).map z7Root22Row = z7RootValues[22]! := by decide

theorem exterior_root22_false (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hrow : ∀ j, C 0 j = z7Root22Row j) : False := by
  have h := exterior_last_entry_diag_bound C hC
  have h0 : C 0 0 = 2 := hrow 0
  have h11 : C 0 11 = 3 := hrow 11
  omega

theorem no_exterior_root22 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root22Row j) := by
  intro h
  obtain ⟨C,hC,hr⟩ := h
  exact exterior_root22_false C hC hr

theorem exterior_root26_false_via_norm (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hrow : ∀ j, C 0 j = z7Root26Row j) : False := by
  have h := exterior_last_entry_diag_bound C hC
  have h0 : C 0 0 = 2 := hrow 0
  have h11 : C 0 11 = 3 := hrow 11
  omega

def z7NormExcludedRoots : List (List Nat) :=
  z7RootValues.filter fun r => decide (4 < r[0]!+r[11]!)
def z7NormRemainingRoots : List (List Nat) :=
  z7RootValues.filter fun r => decide (r[0]!+r[11]! ≤ 4)

theorem z7NormExcludedRoots_values :
    z7NormExcludedRoots = [z7RootValues[22]!,z7RootValues[26]!] := by decide

theorem z7NormRemainingRoots_length : z7NormRemainingRoots.length = 31 := by decide

theorem exterior_row_mem_norm_remaining (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hr : (List.finRange 12).map (C 0) ∈ z7RootValues) :
    (List.finRange 12).map (C 0) ∈ z7NormRemainingRoots := by
  apply List.mem_filter.mpr
  refine ⟨hr,?_⟩
  apply decide_eq_true
  change C 0 0+C 0 11 ≤ 4
  exact exterior_last_entry_diag_bound C hC

theorem conway_z7_has_norm_remaining_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat,
      ExteriorEquations C ∧ (List.finRange 12).map (C 0) ∈ z7NormRemainingRoots := by
  obtain ⟨C,hC,hr⟩ := conway_z7_has_canonical_root h
  exact ⟨C,hC,exterior_row_mem_norm_remaining C hC hr⟩

#print axioms z7Root22Row_values
#print axioms z7Root22Row_manifest
#print axioms exterior_root22_false
#print axioms no_exterior_root22
#print axioms exterior_root26_false_via_norm
#print axioms z7NormExcludedRoots_values
#print axioms z7NormRemainingRoots_length
#print axioms exterior_row_mem_norm_remaining
#print axioms conway_z7_has_norm_remaining_root
end Matrix99
