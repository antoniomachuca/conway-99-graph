import Conway.Z7ExteriorEncoding

namespace Matrix99

def z7Root26Row (j : Fin 12) : Nat :=
  match j.val with
  | 0 => 2
  | 1 => 0
  | 2 | 3 | 4 | 5 => 1
  | 6 | 7 => 0
  | 8 | 9 | 10 => 1
  | _ => 3

private theorem finRange12_root26 :
    List.finRange 12 = [0,1,2,3,4,5,6,7,8,9,10,11] := by decide

theorem z7Root26Row_values :
    (List.finRange 12).map z7Root26Row = [2,0,1,1,1,1,0,0,1,1,1,3] := by decide

theorem exterior_root26_false (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hrow : ∀ j, C 0 j = z7Root26Row j) : False := by
  have h0 : C 11 0 = 3 := (hC.1 11 0).trans (hrow 11)
  have hdot := hC.2.2.2.2.2 0 11
  have hbal := hC.2.2.2.2.1 11
  have hsum := hC.2.2.2.1 11
  have hquad := hC.2.2.2.2.2 11 11
  have ha := hC.2.1 11 6
  have hb := hC.2.1 11 7
  have hleft0 : z7ExteriorLeft 0 = 2 := by decide
  have hleft11 : z7ExteriorLeft 11 = 1 := by decide
  have hr0 : z7Root26Row 0 = 2 := by decide
  have hr1 : z7Root26Row 1 = 0 := by decide
  have hr2 : z7Root26Row 2 = 1 := by decide
  have hr3 : z7Root26Row 3 = 1 := by decide
  have hr4 : z7Root26Row 4 = 1 := by decide
  have hr5 : z7Root26Row 5 = 1 := by decide
  have hr6 : z7Root26Row 6 = 0 := by decide
  have hr7 : z7Root26Row 7 = 0 := by decide
  have hr8 : z7Root26Row 8 = 1 := by decide
  have hr9 : z7Root26Row 9 = 1 := by decide
  have hr10 : z7Root26Row 10 = 1 := by decide
  have hr11 : z7Root26Row 11 = 3 := by decide
  have hd : C 11 2 + C 11 3 + C 11 4 + C 11 5 +
      C 11 8 + C 11 9 + C 11 10 + 3 * C 11 11 = 3 := by
    simp [sum12, finRange12_root26, hrow, hr0, hr1, hr2, hr3, hr4, hr5,
      hr6, hr7, hr8, hr9, hr10, hr11, z7ExteriorTarget, hleft0, hleft11, h0] at hdot
    omega
  simp only [h0] at hbal
  simp [sum12, finRange12_root26, z7ExteriorTarget, hleft11, h0] at hsum hquad
  have hz1 : C 11 1 = 0 := by omega
  have hz2 : C 11 2 = 0 := by omega
  have hz8 : C 11 8 = 0 := by omega
  have hz9 : C 11 9 = 0 := by omega
  have hz10 : C 11 10 = 0 := by omega
  have hz11 : C 11 11 = 0 := by omega
  have hab : C 11 6 + C 11 7 = 6 := by omega
  have hsq : C 11 6 * C 11 6 + C 11 7 * C 11 7 ≤ 15 := by omega
  have hcases : C 11 6 = 2 ∨ C 11 6 = 3 ∨ C 11 6 = 4 := by omega
  rcases hcases with hx | hx | hx
  · have hy : C 11 7 = 4 := by omega
    simp [hx, hy] at hsq
  · have hy : C 11 7 = 3 := by omega
    simp [hx, hy] at hsq
  · have hy : C 11 7 = 2 := by omega
    simp [hx, hy] at hsq

theorem no_exterior_root26 :
    ¬ ∃ C : Fin 12 → Fin 12 → Nat,
      ExteriorEquations C ∧ (∀ j, C 0 j = z7Root26Row j) := by
  intro h
  obtain ⟨C, hC, hr⟩ := h
  exact exterior_root26_false C hC hr

#print axioms z7Root26Row_values
#print axioms exterior_root26_false
#print axioms no_exterior_root26

end Matrix99
