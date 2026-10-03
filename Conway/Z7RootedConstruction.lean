import Conway.Z7QuotientBoundary
import Conway.Z7CanonicalArithmetic

namespace Matrix99

open ConwayOrbit

def rootedMatrixOfOrbitIndexing (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (r : OrbitIndexing (cyclicEquitableData 7 (by decide) A s h7 hpres) 15)
    (hx : s (r.rep 0) = r.rep 0)
    (hunique : ∀ v, s v = v → v = r.rep 0)
    (hN : ∀ v, A (r.rep 0) v = 1 ↔
      orbitLabel 7 s v = r.rep 1 ∨ orbitLabel 7 s v = r.rep 2) : Z7RootedMatrix := by
  have hw := rooted_index_weights A s h7 hpres r hx hunique
  have hb := quotient_boundary A hA s h7 hpres r hx hunique hN
  refine {
    B := r.matrix
    row_sum := ?_
    degree_symmetry := ?_
    srg_equation := ?_
    entry_bound := ?_
    diagonal_even := ?_
    root_row := hb.root_row
    root_column := hb.root_column
    diag_one := hb.diag_one
    diag_two := hb.diag_two
    matching_forward := hb.matching_forward
    matching_backward := hb.matching_backward
  }
  · intro i
    change (List.finRange 15).foldl (fun acc j => acc + r.matrix i j) 0 = 14
    rw [← sumFin_eq_foldl]
    exact r.row_sum 14 (conway_row_sum A hA) i
  · intro i j
    have h := r.weighted_symmetry hA.2.1 i j
    rw [hw i, hw j] at h
    exact h
  · intro i j
    have hpoly : ∀ u v, sumFin (fun w => A u w * A w v) + A u v =
        12 * (if u = v then 1 else 0) + 2 := by
      intro u v
      rw [sumFin_eq_foldl]
      exact (hA.2.2.2 u v).trans (conway_target_formula u v)
    have h := r.quotient_equation 12 2 hpoly i j
    rw [hw j, sumFin_eq_foldl] at h
    exact h
  · intro i j
    have h := (cyclicEquitableData 7 (by decide) A s h7 hpres).entry_le_size
      (fun u v => by
        rcases hA.2.2.1 u v with h | h <;> omega) (r.rep i) (r.rep j)
    calc
      r.matrix i j = (cyclicEquitableData 7 (by decide) A s h7 hpres).entry (r.rep i) (r.rep j) := rfl
      _ ≤ r.sizes j := h
      _ = z7OrbitSizes j := hw j
  · intro i
    have h := (cyclicEquitableData 7 (by decide) A s h7 hpres).diagonal_even_of_odd_size
      hA.2.1 hA.1 (r.rep i)
    have hodd : r.sizes i % 2 = 1 := by
      rw [hw i]
      unfold z7OrbitSizes
      split <;> decide
    exact h hodd

theorem rootedMatrixOfOrbitIndexing_B (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (r : OrbitIndexing (cyclicEquitableData 7 (by decide) A s h7 hpres) 15)
    (hx : s (r.rep 0) = r.rep 0)
    (hunique : ∀ v, s v = v → v = r.rep 0)
    (hN : ∀ v, A (r.rep 0) v = 1 ↔
      orbitLabel 7 s v = r.rep 1 ∨ orbitLabel 7 s v = r.rep 2)
    (i j : Fin 15) :
    (rootedMatrixOfOrbitIndexing A hA s h7 hpres r hx hunique hN).B i j = r.matrix i j := rfl

#print axioms rootedMatrixOfOrbitIndexing
#print axioms rootedMatrixOfOrbitIndexing_B

end Matrix99
