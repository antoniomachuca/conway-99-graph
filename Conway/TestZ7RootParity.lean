import Conway.Z7Root03Arithmetic

namespace Z7RootParityTest

open Matrix99

theorem root03_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hr : ∀ j, C 0 j = z7Root03Row j) : False :=
  exterior_root03_false C hC hr

theorem parity_obstruction_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) : ¬ Z7TailParityRow (C 0) :=
  exterior_not_tail_parity C hC

theorem tail_even_statement (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (i : Fin 12) :
    (C i 6 + C i 7 + C i 8 + C i 9 + C i 10 + C i 11) % 2 = 0 :=
  exterior_tail_sum_even C hC i

theorem excluded_indices_exact :
    ((List.range z7RootValues.length).filter fun i =>
      decide (4 < z7RootValues[i]![0]! + z7RootValues[i]![11]!) ||
        z7TailParityTest (z7RootValues[i]!)) = [3,22,26] := by
  decide +kernel

theorem remaining_values_exact : z7ParityRemainingRoots =
    ([0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25,27,28,29,30,31,32].map
      fun i => z7RootValues[i]!) := by
  decide +kernel

theorem root03_removed : z7RootValues[3]! ∉ z7ParityRemainingRoots := by decide +kernel

theorem roots22_26_removed : z7RootValues[22]! ∉ z7ParityRemainingRoots ∧
    z7RootValues[26]! ∉ z7ParityRemainingRoots := by decide +kernel

theorem root02_retained : z7RootValues[2]! ∈ z7ParityRemainingRoots := by decide +kernel

theorem root23_retained : z7RootValues[23]! ∈ z7ParityRemainingRoots := by decide +kernel

#print axioms root03_statement
#print axioms parity_obstruction_statement
#print axioms tail_even_statement
#print axioms excluded_indices_exact
#print axioms remaining_values_exact
#print axioms root03_removed
#print axioms roots22_26_removed
#print axioms root02_retained
#print axioms root23_retained

end Z7RootParityTest
