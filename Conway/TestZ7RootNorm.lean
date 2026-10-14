import Conway.Z7Root22Arithmetic

namespace Z7RootNormTest

open Matrix99

theorem root22_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hr : ∀ j, C 0 j = z7Root22Row j) : False :=
  exterior_root22_false C hC hr

theorem tail_bound_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (j : Fin 12) (hj : 6 ≤ j.val) :
    C 0 0 + C 0 j ≤ 4 :=
  exterior_tail_entry_diag_bound C hC j hj

theorem excluded_indices_exact :
    ((List.range z7RootValues.length).filter fun i =>
      decide (4 < z7RootValues[i]![0]! + z7RootValues[i]![11]!)) = [22, 26] := by
  decide +kernel

theorem remaining_indices_exact :
    ((List.range z7RootValues.length).filter fun i =>
      decide (z7RootValues[i]![0]! + z7RootValues[i]![11]! ≤ 4)) =
    [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25,27,28,29,30,31,32] := by
  decide +kernel

theorem root22_removed : z7RootValues[22]! ∉ z7NormRemainingRoots := by decide +kernel

theorem root26_removed : z7RootValues[26]! ∉ z7NormRemainingRoots := by decide +kernel

theorem root23_retained : z7RootValues[23]! ∈ z7NormRemainingRoots := by decide +kernel

theorem root23_middle_entry : z7RootValues[23]![0]! + z7RootValues[23]![5]! = 5 := by
  decide +kernel

theorem scalar_boundary_control : 8 * 29 * 7 ≤ 29 * 29 + 16 * (7 * 7) := by
  decide +kernel

theorem weakened_scalar_bound_false : ¬ (8 * 29 * 7 ≤ 839 + 16 * (7 * 7)) := by
  decide +kernel

#print axioms root22_statement
#print axioms tail_bound_statement
#print axioms excluded_indices_exact
#print axioms remaining_indices_exact
#print axioms root22_removed
#print axioms root26_removed
#print axioms root23_retained
#print axioms root23_middle_entry
#print axioms scalar_boundary_control
#print axioms weakened_scalar_bound_false

end Z7RootNormTest
