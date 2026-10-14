import Conway.Z7ComplementParity

namespace Z7ComplementParityTest

open Matrix99

theorem root25_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hr : ∀ j, C 0 j = z7Root25Row j) : False :=
  exterior_root25_false C hC hr

theorem root31_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hr : ∀ j, C 0 j = z7Root31Row j) : False :=
  exterior_root31_false C hC hr

theorem first_six_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (i : Fin 12) (hi : i.val < 6) :
    ¬ (∀ j, C i j % 2 = 0) :=
  exterior_first_six_not_all_even C hC i hi

theorem complement_indices_exact :
    ((List.range z7RootValues.length).filter fun i =>
      z7ComplementParityTest (z7RootValues[i]!)) = [25,31] := by decide +kernel

theorem all_excluded_indices_exact :
    ((List.range z7RootValues.length).filter fun i =>
      decide (4 < z7RootValues[i]![0]! + z7RootValues[i]![11]!) ||
        z7TailParityTest (z7RootValues[i]!) || z7ComplementParityTest (z7RootValues[i]!)) =
    [3,22,25,26,31] := by decide +kernel

theorem remaining_values_exact : z7ComplementRemainingRoots =
    ([0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,27,28,29,30,32].map
      fun i => z7RootValues[i]!) := by decide +kernel

theorem root25_wrong_index : ¬ Z7ComplementParityRow z7Root25Row 5 := by decide +kernel

theorem root31_wrong_index : ¬ Z7ComplementParityRow z7Root31Row 1 := by decide +kernel

theorem root23_retained : z7RootValues[23]! ∈ z7ComplementRemainingRoots := by decide +kernel

theorem root19_retained : z7RootValues[19]! ∈ z7ComplementRemainingRoots := by decide +kernel

#print axioms root25_statement
#print axioms root31_statement
#print axioms first_six_statement
#print axioms complement_indices_exact
#print axioms all_excluded_indices_exact
#print axioms remaining_values_exact
#print axioms root25_wrong_index
#print axioms root31_wrong_index
#print axioms root23_retained
#print axioms root19_retained

end Z7ComplementParityTest
