import Conway.Z7RootData
import Conway.Z7Row0Symmetry

namespace Matrix99

def Z7CanonicalRow (r : Fin 12 → Nat) : Prop :=
  Nondecreasing [r 1, r 2] ∧ Nondecreasing [r 3, r 4, r 5] ∧
    Nondecreasing [r 6, r 7, r 8, r 9, r 10, r 11]

theorem z7CanonicalRow_covered (r : Fin 12 → Nat)
    (hbound : ∀ j, r j ≤ 4) (hd : r 0 = 0 ∨ r 0 = 2)
    (hc : Z7CanonicalRow r) (hs : sum12 r = 12)
    (hb : r 0 + r 1 + r 2 = r 3 + r 4 + r 5)
    (hq : sum12 (fun j => r j * r j) + r 0 = 22) :
    (List.finRange 12).map r ∈ z7RootValues := by
  let v : Fin 12 → Fin 5 := fun j => ⟨r j, Nat.lt_succ_of_le (hbound j)⟩
  have hp : [r 1, r 2] ∈ z7PairValues :=
    z7PairValues_complete (v 1) (v 2) (by simpa [v, Nondecreasing] using hc.1)
  have hm : [r 3, r 4, r 5] ∈ z7TripleValues :=
    z7TripleValues_complete (v 3) (v 4) (v 5)
      (by simpa [v, Nondecreasing] using hc.2.1)
  have ht : [r 6, r 7, r 8, r 9, r 10, r 11] ∈ z7TailValues :=
    z7TailValues_complete (v 6) (v 7) (v 8) (v 9) (v 10) (v 11)
      (by simpa [v, Nondecreasing] using hc.2.2)
  have hfin : List.finRange 12 = [0,1,2,3,4,5,6,7,8,9,10,11] := by decide
  let R := [r 0,r 1,r 2,r 3,r 4,r 5,r 6,r 7,r 8,r 9,r 10,r 11]
  have hsR : R.sum = 12 := by simpa [sum12, hfin, R] using hs
  have hqR : (R.map (fun x => x*x)).sum + r 0 = 22 := by
    simpa [sum12, hfin, R] using hq
  have hbR : (R.take 3).sum = ((R.drop 3).take 3).sum := by
    change r 0 + (r 1 + (r 2 + 0)) = r 3 + (r 4 + (r 5 + 0))
    simpa only [Nat.add_zero, Nat.add_assoc] using hb
  have hfirst : R[0]! = r 0 := by rfl
  have hunary : z7UnaryRow R = true := by
    unfold z7UnaryRow
    rw [hsR, hbR, hfirst, hqR]
    change (true && true && decide (((R.drop 3).take 3).sum = ((R.drop 3).take 3).sum) && true) = true
    rw [decide_eq_true (Eq.refl ((R.drop 3).take 3).sum)]
    rfl
  have hcandidate : R ∈ z7Candidates (r 0) [r 1,r 2] := by
    unfold z7Candidates
    apply List.mem_flatMap.mpr
    refine ⟨[r 3,r 4,r 5], hm, ?_⟩
    apply List.mem_filterMap.mpr
    refine ⟨[r 6,r 7,r 8,r 9,r 10,r 11], ht, ?_⟩
    change (if z7UnaryRow R then some R else none) = some R
    rw [hunary]
    rfl
  have hcovered := z7Candidates_covered (r 0) [r 1,r 2] hd hp
  have hdecide : decide (R ∈ z7RootValues) = true :=
    List.all_eq_true.mp hcovered R hcandidate
  have hmem : R ∈ z7RootValues := of_decide_eq_true hdecide
  simpa [hfin, R] using hmem

theorem exterior_has_canonical_root (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) :
    ∃ σ : Fin 12 → Fin 12,
      FixesRow0Blocks σ ∧ ExteriorEquations (conjMatrix C σ) ∧
        (List.finRange 12).map (conjMatrix C σ 0) ∈ z7RootValues := by
  let σ := row0Relabel C
  have hσ : FixesRow0Blocks σ := row0Relabel_fixesBlocks C
  have hD := conjPreserves C σ hσ hC
  refine ⟨σ,hσ,hD,?_⟩
  apply z7CanonicalRow_covered (conjMatrix C σ 0)
  · exact hD.2.1 0
  · exact hD.2.2.1 0
  · exact row0Relabel_sorted C
  · exact hD.2.2.2.1 0
  · exact hD.2.2.2.2.1 0
  · have h := hD.2.2.2.2.2 0 0
    have ht : z7ExteriorTarget 0 0 = 22 := by decide
    simpa only [ht] using h

theorem conway_z7_has_canonical_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat,
      ExteriorEquations C ∧ (List.finRange 12).map (C 0) ∈ z7RootValues := by
  obtain ⟨M⟩ := conway_z7_induces_orbit_matrix h
  let C := fun i j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j)
  have hC : ExteriorEquations C := M.exterior_equations
  obtain ⟨σ, _, hD, hr⟩ := exterior_has_canonical_root C hC
  exact ⟨conjMatrix C σ, hD, hr⟩

#print axioms z7CanonicalRow_covered
#print axioms exterior_has_canonical_root
#print axioms conway_z7_has_canonical_root

end Matrix99
