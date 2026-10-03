import Conway.Z7FixedGeometry
import Conway.OrbitReindex
import Conway.Z7OrbitMatrix

namespace Matrix99

open ConwayOrbit

structure Z7BoundaryData (B : Fin 15 → Fin 15 → Nat) : Prop where
  root_row : ∀ j : Fin 15, B 0 j = if j = 1 ∨ j = 2 then 7 else 0
  root_column : ∀ i : Fin 15, B i 0 = if i = 1 ∨ i = 2 then 1 else 0
  diag_one : B 1 1 = 0
  diag_two : B 2 2 = 0
  matching_forward : B 1 2 = 1
  matching_backward : B 2 1 = 1

theorem rooted_index_weights (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (h7 : s^[7] = id) (hpres : ∀ u v : Fin 99, A (s u) (s v) = A u v)
    (r : OrbitIndexing (cyclicEquitableData 7 (by decide) A s h7 hpres) 15)
    (hx : s (r.rep 0) = r.rep 0)
    (hunique : ∀ v : Fin 99, s v = v → v = r.rep 0) :
    ∀ i : Fin 15, r.sizes i = z7OrbitSizes i := by
  intro i
  have hs := orbit7_fiber_size s h7 (r.rep i)
  have ha : orbitLabel 7 s (r.rep i) = r.rep i := r.active i
  rw [ha] at hs
  change fiberSize (orbitLabel 7 s) (r.rep i) = z7OrbitSizes i
  cases (inferInstance : Decidable (i = 0)) with
  | isTrue hi =>
    subst i
    rw [if_pos hx] at hs
    exact hs
  | isFalse hi =>
    have hmove : s (r.rep i) ≠ r.rep i := by
      intro hfix
      exact hi (r.injective i 0 (hunique (r.rep i) hfix))
    have hiv : i.val ≠ 0 := by
      intro hv
      exact hi (Fin.ext hv)
    have hb : (i.val == 0) = false := by
      change decide (i.val = 0) = false
      exact decide_eq_false hiv
    rw [if_neg hmove] at hs
    unfold z7OrbitSizes
    rw [hb]
    exact hs

theorem quotient_boundary (A : Matrix99 Nat) (hA : ConwayAdj A) (s : Fin 99 → Fin 99)
    (h7 : s^[7] = id) (hpres : ∀ u v : Fin 99, A (s u) (s v) = A u v)
    (r : OrbitIndexing (cyclicEquitableData 7 (by decide) A s h7 hpres) 15)
    (hx : s (r.rep 0) = r.rep 0)
    (hunique : ∀ v : Fin 99, s v = v → v = r.rep 0)
    (hN : ∀ v : Fin 99, A (r.rep 0) v = 1 ↔
      orbitLabel 7 s v = r.rep 1 ∨ orbitLabel 7 s v = r.rep 2) :
    Z7BoundaryData r.matrix := by
  have hactive : ∀ i : Fin 15, orbitLabel 7 s (r.rep i) = r.rep i := r.active
  have hweights := rooted_index_weights A s h7 hpres r hx hunique
  have hseven : ∀ i : Fin 15, i = 1 ∨ i = 2 → r.sizes i = 7 := by
    intro i hi
    rw [hweights i]
    rcases hi with rfl | rfl <;> rfl
  have hmoving : ∀ i : Fin 15, i ≠ 0 → s (r.rep i) ≠ r.rep i := by
    intro i hi hfix
    exact hi (r.injective i 0 (hunique (r.rep i) hfix))
  have hneighbor : ∀ i : Fin 15, A (r.rep 0) (r.rep i) = 1 ↔ i = 1 ∨ i = 2 := by
    intro i
    rw [hN, hactive i]
    constructor
    · intro hi
      rcases hi with hi | hi
      · exact Or.inl (r.injective i 1 hi)
      · exact Or.inr (r.injective i 2 hi)
    · intro hi
      rcases hi with rfl | rfl
      · exact Or.inl rfl
      · exact Or.inr rfl
  have hsame : ∀ (i : Fin 15) (v : Fin 99), orbitLabel 7 s v = r.rep i →
      SameOrbit 7 s (r.rep i) v := by
    intro i v hv
    exact (orbitLabel_eq_iff (by decide) s h7 (r.rep i) v).mp
      ((hactive i).trans hv.symm)
  have hmatrix : ∀ i j : Fin 15, r.matrix i j =
      sumFin (fun v : Fin 99 => if orbitLabel 7 s v = r.rep j then A (r.rep i) v else 0) := by
    intro i j
    unfold OrbitIndexing.matrix EquitableData.entry
    rw [if_pos (r.active i)]
    rfl
  have hiter : ∀ k : Nat, s^[k] (r.rep 0) = r.rep 0 := by
    intro k
    induction k with
    | zero => rfl
    | succ k ih =>
      change s (s^[k] (r.rep 0)) = r.rep 0
      rw [ih, hx]
  have hfixedfiber : ∀ v : Fin 99, orbitLabel 7 s v = r.rep 0 ↔ r.rep 0 = v := by
    intro v
    constructor
    · intro hv
      obtain ⟨k, hk⟩ := hsame 0 v hv
      rw [hiter k.val] at hk
      exact hk
    · intro hv
      rw [← hv]
      exact hactive 0
  have hcolumn_value : ∀ i : Fin 15, r.matrix i 0 = A (r.rep i) (r.rep 0) := by
    intro i
    rw [hmatrix i 0]
    have hf : (fun v : Fin 99 => if orbitLabel 7 s v = r.rep 0 then A (r.rep i) v else 0) =
        (fun v : Fin 99 => if r.rep 0 = v then A (r.rep i) v else 0) := by
      funext v
      cases (inferInstance : Decidable (r.rep 0 = v)) with
      | isTrue hv => rw [if_pos ((hfixedfiber v).mpr hv), if_pos hv]
      | isFalse hv =>
        have hn : orbitLabel 7 s v ≠ r.rep 0 := fun h => hv ((hfixedfiber v).mp h)
        rw [if_neg hn, if_neg hv]
    rw [hf]
    exact sumFin_indicator_value (r.rep 0) (A (r.rep i))
  have hcolumn : ∀ i : Fin 15, r.matrix i 0 = if i = 1 ∨ i = 2 then 1 else 0 := by
    intro i
    rw [hcolumn_value i, hA.2.1 (r.rep i) (r.rep 0)]
    cases (inferInstance : Decidable (i = 1 ∨ i = 2)) with
    | isTrue hi =>
      rw [if_pos hi]
      exact (hneighbor i).mpr hi
    | isFalse hi =>
      rw [if_neg hi]
      rcases hA.2.2.1 (r.rep 0) (r.rep i) with h0 | h1
      · exact h0
      · exact False.elim (hi ((hneighbor i).mp h1))
  have hrow : ∀ j : Fin 15, r.matrix 0 j = if j = 1 ∨ j = 2 then 7 else 0 := by
    intro j
    cases (inferInstance : Decidable (j = 1 ∨ j = 2)) with
    | isTrue hj =>
      rw [if_pos hj]
      calc
        r.matrix 0 j = r.sizes j := by
          rw [hmatrix 0 j]
          change sumFin (fun v : Fin 99 =>
            if orbitLabel 7 s v = r.rep j then A (r.rep 0) v else 0) =
            sumFin (fun v : Fin 99 => if orbitLabel 7 s v = r.rep j then 1 else 0)
          apply congrArg sumFin
          funext v
          cases (inferInstance : Decidable (orbitLabel 7 s v = r.rep j)) with
          | isTrue hv =>
            have hadj : A (r.rep 0) v = 1 := by
              apply (hN v).mpr
              rcases hj with rfl | rfl
              · exact Or.inl hv
              · exact Or.inr hv
            rw [if_pos hv, if_pos hv, hadj]
          | isFalse hv => rw [if_neg hv, if_neg hv]
        _ = 7 := hseven j hj
    | isFalse hj =>
      rw [if_neg hj, hmatrix 0 j]
      have hf : (fun v : Fin 99 => if orbitLabel 7 s v = r.rep j then A (r.rep 0) v else 0) =
          (fun _ : Fin 99 => 0) := by
        funext v
        cases (inferInstance : Decidable (orbitLabel 7 s v = r.rep j)) with
        | isTrue hv =>
          rw [if_pos hv]
          rcases hA.2.2.1 (r.rep 0) v with h0 | h1
          · exact h0
          · apply False.elim
            apply hj
            rcases (hN v).mp h1 with h1 | h2
            · exact Or.inl (r.injective j 1 (hv.symm.trans h1))
            · exact Or.inr (r.injective j 2 (hv.symm.trans h2))
        | isFalse hv => rw [if_neg hv]
      rw [hf]
      exact sum_map_zero (List.finRange 99)
  have hdiag : ∀ i : Fin 15, i = 1 ∨ i = 2 → r.matrix i i = 0 := by
    intro i hi
    have hi0 : i ≠ 0 := by rcases hi with rfl | rfl <;> decide
    have hu := (hneighbor i).mpr hi
    have hmove := hmoving i hi0
    rw [hmatrix i i]
    have hf : (fun v : Fin 99 => if orbitLabel 7 s v = r.rep i then A (r.rep i) v else 0) =
        (fun _ : Fin 99 => 0) := by
      funext v
      cases (inferInstance : Decidable (orbitLabel 7 s v = r.rep i)) with
      | isTrue hv =>
        rw [if_pos hv]
        exact conway_period7_no_internal_neighbor_edge A hA s h7 hpres
          (r.rep 0) (r.rep i) v hx hu hmove (hsame i v hv)
      | isFalse hv => rw [if_neg hv]
    rw [hf]
    exact sum_map_zero (List.finRange 99)
  have hmatching : r.matrix 1 2 = 1 := by
    have hu := (hneighbor 1).mpr (Or.inl rfl)
    have hmove := hmoving 1 (by decide)
    let mate : Fin 99 := localMate A (r.rep 0) (r.rep 1)
    have hm : A (r.rep 0) mate = 1 ∧ A (r.rep 1) mate = 1 ∧
        (∀ v : Fin 99, A (r.rep 0) v = 1 ∧ A (r.rep 1) v = 1 → v = mate) :=
      localMate_spec A hA (r.rep 0) (r.rep 1) hu
    have hlabel : orbitLabel 7 s mate = r.rep 2 := by
      rcases (hN mate).mp hm.1 with h1 | h2
      · have hz := conway_period7_no_internal_neighbor_edge A hA s h7 hpres
          (r.rep 0) (r.rep 1) mate hx hu hmove (hsame 1 mate h1)
        have hone := hm.2.1
        omega
      · exact h2
    rw [hmatrix 1 2]
    have hf : (fun v : Fin 99 => if orbitLabel 7 s v = r.rep 2 then A (r.rep 1) v else 0) =
        (fun v : Fin 99 => if mate = v then 1 else 0) := by
      funext v
      cases (inferInstance : Decidable (mate = v)) with
      | isTrue hv =>
        rw [← hv, if_pos hlabel, if_pos rfl]
        exact hm.2.1
      | isFalse hv =>
        rw [if_neg hv]
        cases (inferInstance : Decidable (orbitLabel 7 s v = r.rep 2)) with
        | isTrue hcell =>
          rw [if_pos hcell]
          have hxv := (hN v).mpr (Or.inr hcell)
          rcases hA.2.2.1 (r.rep 1) v with h0 | h1
          · exact h0
          · exact False.elim (hv (hm.2.2 v ⟨hxv, h1⟩).symm)
        | isFalse hcell => rw [if_neg hcell]
    rw [hf]
    exact sumFin_indicator_value mate (fun _ : Fin 99 => 1)
  have hmatching_reverse : r.matrix 2 1 = 1 := by
    have hs := r.weighted_symmetry hA.2.1 1 2
    rw [hseven 1 (Or.inl rfl), hseven 2 (Or.inr rfl), hmatching] at hs
    omega
  exact ⟨hrow, hcolumn, hdiag 1 (Or.inl rfl), hdiag 2 (Or.inr rfl), hmatching, hmatching_reverse⟩

#print axioms Z7BoundaryData
#print axioms Z7BoundaryData.mk
#print axioms Z7BoundaryData.root_row
#print axioms Z7BoundaryData.root_column
#print axioms Z7BoundaryData.diag_one
#print axioms Z7BoundaryData.diag_two
#print axioms Z7BoundaryData.matching_forward
#print axioms Z7BoundaryData.matching_backward
#print axioms rooted_index_weights
#print axioms quotient_boundary

end Matrix99
