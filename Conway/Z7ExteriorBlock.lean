/-
  Derivation of the 12×12 exterior row problem from `Z7OrbitMatrix`.

  The equations are the ones encoded by `scripts/z7_row_problem_cnf.py`.
  This file does not import a SAT refutation and does not remove
  `z7_orbit_matrix_nonexistence`.
-/

import Conway.OrbitQuotient
import Conway.Z7CanonicalArithmetic
import Conway.Z7OrbitMatrix

namespace Matrix99
open ConwayOrbit

def z7ExteriorIndex (i : Fin 12) : Fin 15 :=
  ⟨i.val + 3, by omega⟩

/-- Canonical left-neighbor count of exterior orbit `i`, in the order type 2, 0, 1. -/
def z7ExteriorLeft (i : Fin 12) : Nat :=
  if i.val < 3 then 2 else if i.val < 6 then 0 else 1

def sum12 (f : Fin 12 → Nat) : Nat :=
  (List.finRange 12).map f |>.sum

/-- Right-hand side of `C² + C` after removing the fixed root and neighborhood orbits. -/
def z7ExteriorTarget (i j : Fin 12) : Nat :=
  12 * (if i = j then 1 else 0) + 14
    - z7ExteriorLeft i * z7ExteriorLeft j
    - (2 - z7ExteriorLeft i) * (2 - z7ExteriorLeft j)

theorem z7ExteriorLeft_eq_outer (i : Fin 12) :
    z7OuterLeftCount (z7ExteriorIndex i) = z7ExteriorLeft i := by
  revert i; decide

theorem z7ExteriorLeft_trichotomy (i : Fin 12) :
    z7ExteriorLeft i = 0 ∨ z7ExteriorLeft i = 1 ∨ z7ExteriorLeft i = 2 := by
  revert i; decide

theorem z7ExteriorIndex_inj (i j : Fin 12) :
    z7ExteriorIndex i = z7ExteriorIndex j ↔ i = j := by
  revert i j; decide

theorem z7Exterior_not_initial (i : Fin 12) :
    z7ExteriorIndex i ≠ 0 ∧ z7ExteriorIndex i ≠ 1 ∧ z7ExteriorIndex i ≠ 2 := by
  revert i; decide

theorem z7ExteriorIndex_ge3 (i : Fin 12) : 3 ≤ (z7ExteriorIndex i).val := by
  revert i; decide

theorem z7OuterIndices_eq_exterior :
    z7OuterIndices = (List.finRange 12).map z7ExteriorIndex := by
  decide

private theorem sumFin_split3 (f : Fin 15 → Nat) :
    sumFin f = f 0 + f 1 + f 2 + (z7OuterIndices.map f).sum := by
  change f 0 + (f 1 + (f 2 + (z7OuterIndices.map f).sum)) = _
  omega

private theorem exterior_sum_map (f : Fin 15 → Nat) :
    (z7OuterIndices.map f).sum = sum12 (fun j => f (z7ExteriorIndex j)) := by
  rw [z7OuterIndices_eq_exterior, List.map_map]
  rfl

theorem Z7OrbitMatrix.symm_positive (M : Z7OrbitMatrix) (i j : Fin 15)
    (hi : i.val ≠ 0) (hj : j.val ≠ 0) : M.B i j = M.B j i := by
  have h := M.degree_symmetry i j
  simp [z7OrbitSizes, hi, hj] at h
  omega

theorem Z7OrbitMatrix.exterior_symm (M : Z7OrbitMatrix) (i j : Fin 12) :
    M.B (z7ExteriorIndex i) (z7ExteriorIndex j) =
      M.B (z7ExteriorIndex j) (z7ExteriorIndex i) := by
  exact M.symm_positive _ _ (by simpa using (z7Exterior_not_initial i).1)
    (by simpa using (z7Exterior_not_initial j).1)

theorem Z7OrbitMatrix.exterior_bound (M : Z7OrbitMatrix) (i j : Fin 12) :
    M.B (z7ExteriorIndex i) (z7ExteriorIndex j) ≤ 4 :=
  M.outer_bound _ _ (z7ExteriorIndex_ge3 i) (z7ExteriorIndex_ge3 j)

theorem Z7OrbitMatrix.exterior_diag (M : Z7OrbitMatrix) (i : Fin 12) :
    M.B (z7ExteriorIndex i) (z7ExteriorIndex i) = 0 ∨
      M.B (z7ExteriorIndex i) (z7ExteriorIndex i) = 2 :=
  M.diag_parity _

private theorem leftCoeff :
    z7ExteriorLeft 0 = 2 ∧ z7ExteriorLeft 1 = 2 ∧ z7ExteriorLeft 2 = 2 ∧
    z7ExteriorLeft 3 = 0 ∧ z7ExteriorLeft 4 = 0 ∧ z7ExteriorLeft 5 = 0 ∧
    z7ExteriorLeft 6 = 1 ∧ z7ExteriorLeft 7 = 1 ∧ z7ExteriorLeft 8 = 1 ∧
    z7ExteriorLeft 9 = 1 ∧ z7ExteriorLeft 10 = 1 ∧ z7ExteriorLeft 11 = 1 := by
  decide

private theorem finRange12 :
    List.finRange 12 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] := by
  decide

private theorem exterior_components (f : Fin 12 → Nat) :
    sum12 f = f 0 + f 1 + f 2 + (f 3 + f 4 + f 5) +
      (f 6 + f 7 + f 8 + f 9 + f 10 + f 11) ∧
    sum12 (fun j => f j * z7ExteriorLeft j) =
      2 * (f 0 + f 1 + f 2) + (f 6 + f 7 + f 8 + f 9 + f 10 + f 11) := by
  unfold sum12
  rw [finRange12]
  simp only [List.map_cons, List.map_nil, List.sum_cons, List.sum_nil, leftCoeff,
    Nat.mul_zero, Nat.mul_one, Nat.add_zero, Nat.zero_add]
  refine ⟨?_, ?_⟩
  · ac_rfl
  · simp only [Nat.mul_succ, Nat.two_mul]
    ac_rfl

theorem Z7OrbitMatrix.exterior_row_sum (M : Z7OrbitMatrix) (i : Fin 12) :
    sum12 (fun j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j)) = 12 := by
  have hrow : sumFin (M.B (z7ExteriorIndex i)) = 14 := by
    rw [sumFin_eq_foldl]
    exact M.row_sum _
  rw [sumFin_split3, exterior_sum_map] at hrow
  have hinit := z7Exterior_not_initial i
  rw [M.root_column (z7ExteriorIndex i)] at hrow
  simp [hinit.2.1, hinit.2.2] at hrow
  rw [M.outer_left _ (z7ExteriorIndex_ge3 i), M.outer_right _ (z7ExteriorIndex_ge3 i),
    z7ExteriorLeft_eq_outer] at hrow
  rcases z7ExteriorLeft_trichotomy i with ha | ha | ha <;> simp [ha] at hrow <;> omega

private theorem exterior_left_dot (M : Z7OrbitMatrix) (i : Fin 12) :
    sum12 (fun j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j) * z7ExteriorLeft j) = 12 := by
  have hsrg := M.srg_equation (z7ExteriorIndex i) 1
  rw [mul15, ← sumFin_eq_foldl, sumFin_split3] at hsrg
  simp [delta15, show z7OrbitSizes 1 = 7 from rfl] at hsrg
  have hinit := z7Exterior_not_initial i
  rw [M.root_column (z7ExteriorIndex i), M.root_row 1, M.diag_one, M.matching_backward] at hsrg
  simp [hinit.2.1, hinit.2.2] at hsrg
  rw [M.outer_left _ (z7ExteriorIndex_ge3 i), M.outer_right _ (z7ExteriorIndex_ge3 i),
    z7ExteriorLeft_eq_outer] at hsrg
  have houter :
      (z7OuterIndices.map (fun k => M.B (z7ExteriorIndex i) k * M.B k 1)).sum =
        sum12 (fun j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j) * z7ExteriorLeft j) := by
    rw [exterior_sum_map]
    apply congrArg sum12
    funext j
    rw [M.outer_left _ (z7ExteriorIndex_ge3 j), z7ExteriorLeft_eq_outer]
  rw [houter] at hsrg
  rcases z7ExteriorLeft_trichotomy i with ha | ha | ha <;> simp [ha] at hsrg <;> omega

theorem Z7OrbitMatrix.exterior_balance (M : Z7OrbitMatrix) (i : Fin 12) :
    M.B (z7ExteriorIndex i) (z7ExteriorIndex 0) +
        M.B (z7ExteriorIndex i) (z7ExteriorIndex 1) +
        M.B (z7ExteriorIndex i) (z7ExteriorIndex 2) =
      M.B (z7ExteriorIndex i) (z7ExteriorIndex 3) +
        M.B (z7ExteriorIndex i) (z7ExteriorIndex 4) +
        M.B (z7ExteriorIndex i) (z7ExteriorIndex 5) := by
  have hcomp := exterior_components (fun j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j))
  have hsum := M.exterior_row_sum i
  have hdot := exterior_left_dot M i
  rw [hcomp.1] at hsum
  rw [hcomp.2] at hdot
  omega

private theorem exterior_square_split (M : Z7OrbitMatrix) (i j : Fin 12) :
    mul15 M.B M.B (z7ExteriorIndex i) (z7ExteriorIndex j) =
      z7ExteriorLeft i * z7ExteriorLeft j +
        (2 - z7ExteriorLeft i) * (2 - z7ExteriorLeft j) +
        sum12 (fun k => M.B (z7ExteriorIndex i) (z7ExteriorIndex k) *
          M.B (z7ExteriorIndex j) (z7ExteriorIndex k)) := by
  rw [mul15, ← sumFin_eq_foldl, sumFin_split3]
  have hinit_i := z7Exterior_not_initial i
  have hinit_j := z7Exterior_not_initial j
  have hpos_j : (z7ExteriorIndex j).val ≠ 0 := by simpa using hinit_j.1
  have h0 : M.B (z7ExteriorIndex i) 0 * M.B 0 (z7ExteriorIndex j) = 0 := by
    rw [M.root_column (z7ExteriorIndex i), M.root_row (z7ExteriorIndex j)]
    simp [hinit_i.2.1, hinit_i.2.2, hinit_j.2.1, hinit_j.2.2]
  rw [h0, M.symm_positive 1 _ (by decide) hpos_j, M.symm_positive 2 _ (by decide) hpos_j,
    M.outer_left _ (z7ExteriorIndex_ge3 i), M.outer_right _ (z7ExteriorIndex_ge3 i),
    M.outer_left _ (z7ExteriorIndex_ge3 j), M.outer_right _ (z7ExteriorIndex_ge3 j),
    z7ExteriorLeft_eq_outer i, z7ExteriorLeft_eq_outer j]
  have houter :
      (z7OuterIndices.map (fun k => M.B (z7ExteriorIndex i) k * M.B k (z7ExteriorIndex j))).sum =
        sum12 (fun k => M.B (z7ExteriorIndex i) (z7ExteriorIndex k) *
          M.B (z7ExteriorIndex j) (z7ExteriorIndex k)) := by
    rw [exterior_sum_map]
    apply congrArg sum12
    funext k
    have hpos_k : (z7ExteriorIndex k).val ≠ 0 := by simpa using (z7Exterior_not_initial k).1
    rw [M.symm_positive _ _ hpos_k hpos_j]
  rw [houter]
  omega

theorem Z7OrbitMatrix.exterior_quadratic (M : Z7OrbitMatrix) (i j : Fin 12) :
    sum12 (fun k => M.B (z7ExteriorIndex i) (z7ExteriorIndex k) *
        M.B (z7ExteriorIndex j) (z7ExteriorIndex k)) +
      M.B (z7ExteriorIndex i) (z7ExteriorIndex j) =
      z7ExteriorTarget i j := by
  have hsrg := M.srg_equation (z7ExteriorIndex i) (z7ExteriorIndex j)
  have hsize : z7OrbitSizes (z7ExteriorIndex j) = 7 := by
    have h := z7Exterior_not_initial j
    simp [z7OrbitSizes, h.1]
  have hdelta : delta15 (z7ExteriorIndex i) (z7ExteriorIndex j) = if i = j then 1 else 0 := by
    simp [delta15, z7ExteriorIndex_inj]
  rw [exterior_square_split M i j, hsize, hdelta] at hsrg
  rcases z7ExteriorLeft_trichotomy i with ha | ha | ha <;>
    rcases z7ExteriorLeft_trichotomy j with hb | hb | hb <;>
    simp [z7ExteriorTarget, ha, hb] at hsrg ⊢ <;> omega

/--
  Every field of the enumerated exterior problem, derived from `Z7OrbitMatrix`.
  Symmetry here is equality of matrix entries, not a relabeling quotient.
-/
theorem Z7OrbitMatrix.exterior_row_problem (M : Z7OrbitMatrix) :
    (∀ i j, M.B (z7ExteriorIndex i) (z7ExteriorIndex j) =
        M.B (z7ExteriorIndex j) (z7ExteriorIndex i)) ∧
    (∀ i j, M.B (z7ExteriorIndex i) (z7ExteriorIndex j) ≤ 4) ∧
    (∀ i, M.B (z7ExteriorIndex i) (z7ExteriorIndex i) = 0 ∨
        M.B (z7ExteriorIndex i) (z7ExteriorIndex i) = 2) ∧
    (∀ i, sum12 (fun j => M.B (z7ExteriorIndex i) (z7ExteriorIndex j)) = 12) ∧
    (∀ i,
      M.B (z7ExteriorIndex i) (z7ExteriorIndex 0) +
          M.B (z7ExteriorIndex i) (z7ExteriorIndex 1) +
          M.B (z7ExteriorIndex i) (z7ExteriorIndex 2) =
        M.B (z7ExteriorIndex i) (z7ExteriorIndex 3) +
          M.B (z7ExteriorIndex i) (z7ExteriorIndex 4) +
          M.B (z7ExteriorIndex i) (z7ExteriorIndex 5)) ∧
    (∀ i j,
      sum12 (fun k => M.B (z7ExteriorIndex i) (z7ExteriorIndex k) *
          M.B (z7ExteriorIndex j) (z7ExteriorIndex k)) +
        M.B (z7ExteriorIndex i) (z7ExteriorIndex j) =
        z7ExteriorTarget i j) :=
  ⟨M.exterior_symm, M.exterior_bound, M.exterior_diag, M.exterior_row_sum,
    M.exterior_balance, M.exterior_quadratic⟩

#print axioms Z7OrbitMatrix.exterior_row_problem

end Matrix99
