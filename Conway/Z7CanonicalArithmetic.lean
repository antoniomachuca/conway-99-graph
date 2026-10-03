import Conway.OrbitQuotient
import Conway.Z7OrbitMatrix

namespace Matrix99
open ConwayOrbit

/-- Raw rooted quotient constraints. No existence assertion is made here. -/
structure Z7RootedMatrix where
  B : Fin 15 → Fin 15 → Nat
  row_sum : ∀ i, rowSum15 B i = 14
  degree_symmetry : ∀ i j, z7OrbitSizes i * B i j = z7OrbitSizes j * B j i
  srg_equation : ∀ i j, mul15 B B i j + B i j = 12 * delta15 i j + 2 * z7OrbitSizes j
  entry_bound : ∀ i j, B i j ≤ z7OrbitSizes j
  diagonal_even : ∀ i, B i i % 2 = 0
  root_row : ∀ j, B 0 j = if j = 1 ∨ j = 2 then 7 else 0
  root_column : ∀ i, B i 0 = if i = 1 ∨ i = 2 then 1 else 0
  diag_one : B 1 1 = 0
  diag_two : B 2 2 = 0
  matching_forward : B 1 2 = 1
  matching_backward : B 2 1 = 1

private theorem weight_nonzero (i : Fin 15) (hi : 1 ≤ i.val) : z7OrbitSizes i = 7 := by
  simp [z7OrbitSizes, show i.val ≠ 0 by omega]

theorem Z7RootedMatrix.symm_nonzero (M : Z7RootedMatrix) (i j : Fin 15)
    (hi : 1 ≤ i.val) (hj : 1 ≤ j.val) : M.B i j = M.B j i := by
  have h := M.degree_symmetry i j
  rw [weight_nonzero i hi, weight_nonzero j hj] at h
  omega

private theorem root_zero (M : Z7RootedMatrix) (i : Fin 15) (hi : 3 ≤ i.val) :
    M.B i 0 = 0 := by
  rw [M.root_column]
  simp [show i ≠ 1 by intro h; cases h; contradiction,
    show i ≠ 2 by intro h; cases h; contradiction]

private theorem indicator_sum (j : Fin 15) (c : Nat) :
    sumFin (fun k => if k = j then c else 0) = c := by
  exact (sum_indicator_list (List.nodup_finRange 15) j c).trans (if_pos (List.mem_finRange j))

private theorem root_product (M : Z7RootedMatrix) (i k : Fin 15) :
    M.B i k * M.B k 0 =
      (if k = 1 then M.B i 1 else 0) + (if k = 2 then M.B i 2 else 0) := by
  rw [M.root_column]
  by_cases h1 : k = 1
  · subst k; simp
  · by_cases h2 : k = 2
    · subst k; simp
    · simp [h1, h2]

private theorem root_mul (M : Z7RootedMatrix) (i : Fin 15) :
    mul15 M.B M.B i 0 = M.B i 1 + M.B i 2 := by
  rw [mul15, ← sumFin_eq_foldl]
  rw [show (fun k => M.B i k * M.B k 0) =
    (fun k => (if k = 1 then M.B i 1 else 0) + (if k = 2 then M.B i 2 else 0)) from
      funext (root_product M i)]
  unfold sumFin
  rw [sum_map_add]
  change sumFin (fun k => if k = 1 then M.B i 1 else 0) +
    sumFin (fun k => if k = 2 then M.B i 2 else 0) = _
  rw [indicator_sum, indicator_sum]

theorem Z7RootedMatrix.outer_two (M : Z7RootedMatrix) (i : Fin 15) (hi : 3 ≤ i.val) :
    M.B i 1 + M.B i 2 = 2 := by
  have hp := root_mul M i
  have h := M.srg_equation i 0
  rw [hp, root_zero M i hi] at h
  have hne : i ≠ 0 := by intro he; have := congrArg Fin.val he; omega
  rw [show z7OrbitSizes 0 = 1 from rfl] at h
  simpa [delta15, hne] using h

private theorem list_sum_mono {α : Type} (l : List α) (f g : α → Nat)
    (h : ∀ x ∈ l, f x ≤ g x) : (l.map f).sum ≤ (l.map g).sum := by
  induction l with
  | nil => exact Nat.le_refl _
  | cons x xs ih =>
    simp only [List.map_cons, List.sum_cons]
    exact Nat.add_le_add (h x (by simp)) (ih (fun y hy => h y (by simp [hy])))

private theorem le_square (x : Nat) : x ≤ x * x := by
  cases x with
  | zero => omega
  | succ x => simp [Nat.mul_succ]

private theorem square_correction (f : Fin 15 → Nat) (j : Fin 15) :
    sumFin f + f j * f j ≤ sumFin (fun k => f k * f k) + f j := by
  have h := list_sum_mono (List.finRange 15)
    (fun k => f k + if k = j then f j * f j else 0)
    (fun k => f k * f k + if k = j then f j else 0) (by
      intro k _
      by_cases he : k = j
      · subst k; simp [Nat.add_comm]
      · simpa [he] using le_square (f k))
  rw [sum_map_add, sum_map_add] at h
  change sumFin f + sumFin (fun k => if k = j then f j * f j else 0) ≤
    sumFin (fun k => f k * f k) + sumFin (fun k => if k = j then f j else 0) at h
  simpa [indicator_sum] using h

private theorem outer_square_sum (M : Z7RootedMatrix) (i : Fin 15) (hi : 3 ≤ i.val) :
    sumFin (fun j => M.B i j * M.B i j) + M.B i i = 26 := by
  have h := M.srg_equation i i
  have hp : mul15 M.B M.B i i = sumFin (fun j => M.B i j * M.B i j) := by
    rw [mul15, ← sumFin_eq_foldl]
    apply congrArg sumFin
    funext j
    by_cases hj : j = 0
    · subst j; rw [root_zero M i hi]; simp
    · rw [M.symm_nonzero j i (by cases j; simp_all; omega) (by omega)]
  rw [hp, weight_nonzero i (by omega)] at h
  simpa [delta15] using h

private theorem outer_correction (M : Z7RootedMatrix) (i j : Fin 15) (hi : 3 ≤ i.val) :
    M.B i j * M.B i j + M.B i i ≤ 12 + M.B i j := by
  have h := square_correction (M.B i) j
  have hr : sumFin (M.B i) = 14 := by rw [sumFin_eq_foldl]; exact M.row_sum i
  have hs := outer_square_sum M i hi
  rw [hr] at h
  omega

theorem Z7RootedMatrix.outer_bound (M : Z7RootedMatrix) (i j : Fin 15)
    (hi : 3 ≤ i.val) (hj : 3 ≤ j.val) : M.B i j ≤ 4 := by
  have h := outer_correction M i j hi
  have hb := M.entry_bound i j
  rw [weight_nonzero j (by omega)] at hb
  have hc : M.B i j ≤ 4 ∨ M.B i j = 5 ∨ M.B i j = 6 ∨ M.B i j = 7 := by omega
  rcases hc with hc | hc | hc | hc
  · exact hc
  all_goals rw [hc] at h; omega

theorem Z7RootedMatrix.diag_parity (M : Z7RootedMatrix) (i : Fin 15) :
    M.B i i = 0 ∨ M.B i i = 2 := by
  by_cases h0 : i = 0
  · subst i; left; simpa using M.root_row 0
  by_cases h1 : i = 1
  · subst i; exact Or.inl M.diag_one
  by_cases h2 : i = 2
  · subst i; exact Or.inl M.diag_two
  have hi : 3 ≤ i.val := by
    simp only [Fin.ext_iff] at h0 h1 h2
    omega
  have h := outer_correction M i i hi
  have hb := M.outer_bound i i hi hi
  have he := M.diagonal_even i
  have hc : M.B i i = 0 ∨ M.B i i = 2 ∨ M.B i i = 4 := by omega
  rcases hc with hc | hc | hc
  · exact Or.inl hc
  · exact Or.inr hc
  · rw [hc] at h; omega

def z7OuterIndices : List (Fin 15) := (List.finRange 15).drop 3

def Z7RootedMatrix.outerType (M : Z7RootedMatrix) (a : Nat) : List (Fin 15) :=
  z7OuterIndices.filter (fun i => decide (M.B i 1 = a))

theorem mem_z7OuterIndices (i : Fin 15) : i ∈ z7OuterIndices ↔ 3 ≤ i.val := by
  revert i
  decide

private theorem sumFin_split3 (f : Fin 15 → Nat) :
    sumFin f = f 0 + f 1 + f 2 + (z7OuterIndices.map f).sum := by
  change f 0 + (f 1 + (f 2 + (z7OuterIndices.map f).sum)) = _
  omega

private theorem outer_moments (M : Z7RootedMatrix) :
    (z7OuterIndices.map (fun i => M.B i 1)).sum = 12 ∧
    (z7OuterIndices.map (fun i => M.B i 1 * M.B i 1)).sum = 18 := by
  have hrow : sumFin (M.B 1) = 14 := by rw [sumFin_eq_foldl]; exact M.row_sum 1
  have hdiag := M.srg_equation 1 1
  rw [mul15, ← sumFin_eq_foldl, sumFin_split3] at hdiag
  rw [sumFin_split3] at hrow
  have hlin : (z7OuterIndices.map (M.B 1)).sum =
      (z7OuterIndices.map (fun i => M.B i 1)).sum := by
    apply congrArg List.sum
    apply List.map_congr_left
    intro i hi
    exact M.symm_nonzero 1 i (by decide) (by have := (mem_z7OuterIndices i).mp hi; omega)
  have hsq : (z7OuterIndices.map (fun i => M.B 1 i * M.B i 1)).sum =
      (z7OuterIndices.map (fun i => M.B i 1 * M.B i 1)).sum := by
    apply congrArg List.sum
    apply List.map_congr_left
    intro i hi
    rw [M.symm_nonzero 1 i (by decide) (by have := (mem_z7OuterIndices i).mp hi; omega)]
  rw [hlin, M.root_column 1, M.diag_one, M.matching_forward] at hrow
  rw [hsq, M.root_column 1, M.root_row 1, M.diag_one,
    M.matching_forward, M.matching_backward] at hdiag
  rw [show z7OrbitSizes 1 = 7 from rfl] at hdiag
  simp [delta15] at hrow hdiag
  constructor <;> omega

private theorem three_type_moments {α : Type} (l : List α) (f : α → Nat)
    (hb : ∀ x ∈ l, f x ≤ 2) :
    (l.map f).sum = (l.filter (fun x => decide (f x = 1))).length +
      2 * (l.filter (fun x => decide (f x = 2))).length ∧
    (l.map (fun x => f x * f x)).sum = (l.map f).sum +
      2 * (l.filter (fun x => decide (f x = 2))).length ∧
    l.length = (l.filter (fun x => decide (f x = 0))).length +
      (l.filter (fun x => decide (f x = 1))).length +
      (l.filter (fun x => decide (f x = 2))).length := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    have ih' := ih (fun y hy => hb y (by simp [hy]))
    have hx := hb x (by simp)
    have hc : f x = 0 ∨ f x = 1 ∨ f x = 2 := by omega
    rcases hc with hc | hc | hc <;> simp [hc] <;> refine ⟨?_, ?_, ?_⟩ <;> omega

theorem Z7RootedMatrix.outer_type_counts (M : Z7RootedMatrix) :
    (M.outerType 2).length = 3 ∧ (M.outerType 0).length = 3 ∧
    (M.outerType 1).length = 6 := by
  have h := three_type_moments z7OuterIndices (fun i => M.B i 1) (by
    intro i hi
    have := M.outer_two i ((mem_z7OuterIndices i).mp hi)
    omega)
  have hm := outer_moments M
  have hl : z7OuterIndices.length = 12 := rfl
  unfold Z7RootedMatrix.outerType
  exact ⟨by omega, by omega, by omega⟩

def Z7RootedMatrix.canonicalOrder (M : Z7RootedMatrix) : List (Fin 15) :=
  [0, 1, 2] ++ M.outerType 2 ++ M.outerType 0 ++ M.outerType 1

theorem Z7RootedMatrix.mem_outerType (M : Z7RootedMatrix) (a : Nat) (i : Fin 15) :
    i ∈ M.outerType a ↔ 3 ≤ i.val ∧ M.B i 1 = a := by
  simp [outerType, List.mem_filter, mem_z7OuterIndices]

theorem Z7RootedMatrix.canonicalOrder_length (M : Z7RootedMatrix) :
    M.canonicalOrder.length = 15 := by
  have h := M.outer_type_counts
  simp [canonicalOrder, h.1, h.2.1, h.2.2]

theorem Z7RootedMatrix.mem_canonicalOrder (M : Z7RootedMatrix) (i : Fin 15) :
    i ∈ M.canonicalOrder := by
  by_cases hi : 3 ≤ i.val
  · have ht := M.outer_two i hi
    have hc : M.B i 1 = 0 ∨ M.B i 1 = 1 ∨ M.B i 1 = 2 := by omega
    rcases hc with hc | hc | hc <;> simp [canonicalOrder, M.mem_outerType, hi, hc]
  · have hc : i = 0 ∨ i = 1 ∨ i = 2 := by simp only [Fin.ext_iff]; omega
    rcases hc with rfl | rfl | rfl <;> simp [canonicalOrder]

theorem Z7RootedMatrix.canonicalOrder_perm (M : Z7RootedMatrix) :
    List.Perm M.canonicalOrder (List.finRange 15) := by
  apply List.Perm.symm
  apply perm_of_nodup_same_members (List.nodup_finRange 15)
  · intro i _; exact M.mem_canonicalOrder i
  · simp [M.canonicalOrder_length]

theorem Z7RootedMatrix.canonicalOrder_nodup (M : Z7RootedMatrix) :
    M.canonicalOrder.Nodup :=
  M.canonicalOrder_perm.symm.nodup (List.nodup_finRange 15)

/-- Computable reordering by lookup in the three explicitly filtered blocks. -/
def Z7RootedMatrix.canonicalPermutation (M : Z7RootedMatrix) (i : Fin 15) : Fin 15 :=
  M.canonicalOrder.get ⟨i.val, by rw [M.canonicalOrder_length]; exact i.isLt⟩

@[simp] theorem Z7RootedMatrix.canonicalPermutation_zero (M : Z7RootedMatrix) :
    M.canonicalPermutation 0 = 0 := rfl

@[simp] theorem Z7RootedMatrix.canonicalPermutation_one (M : Z7RootedMatrix) :
    M.canonicalPermutation 1 = 1 := rfl

@[simp] theorem Z7RootedMatrix.canonicalPermutation_two (M : Z7RootedMatrix) :
    M.canonicalPermutation 2 = 2 := rfl

theorem Z7RootedMatrix.canonicalPermutation_injective (M : Z7RootedMatrix) :
    ∀ i j, M.canonicalPermutation i = M.canonicalPermutation j → i = j := by
  intro i j h
  apply Fin.ext
  exact (List.getElem_inj M.canonicalOrder_nodup).mp h

theorem Z7RootedMatrix.canonicalPermutation_surjective (M : Z7RootedMatrix) :
    ∀ j, ∃ i, M.canonicalPermutation i = j := by
  intro j
  obtain ⟨i, hi⟩ := List.get_of_mem (M.mem_canonicalOrder j)
  refine ⟨⟨i.val, by have := i.isLt; have := M.canonicalOrder_length; omega⟩, ?_⟩
  exact hi

theorem Z7RootedMatrix.canonicalPermutation_outer (M : Z7RootedMatrix) (i : Fin 15)
    (hi : 3 ≤ i.val) : 3 ≤ (M.canonicalPermutation i).val := by
  have h0 : M.canonicalPermutation i ≠ 0 := by
    intro h
    have he := M.canonicalPermutation_injective i 0 h
    subst i; contradiction
  have h1 : M.canonicalPermutation i ≠ 1 := by
    intro h
    have he := M.canonicalPermutation_injective i 1 h
    subst i; contradiction
  have h2 : M.canonicalPermutation i ≠ 2 := by
    intro h
    have he := M.canonicalPermutation_injective i 2 h
    subst i; contradiction
  have hv0 : (M.canonicalPermutation i).val ≠ 0 := fun h => h0 (Fin.ext h)
  have hv1 : (M.canonicalPermutation i).val ≠ 1 := fun h => h1 (Fin.ext h)
  have hv2 : (M.canonicalPermutation i).val ≠ 2 := fun h => h2 (Fin.ext h)
  omega

theorem Z7RootedMatrix.canonicalPermutation_weight (M : Z7RootedMatrix) (i : Fin 15) :
    z7OrbitSizes (M.canonicalPermutation i) = z7OrbitSizes i := by
  by_cases hi : i = 0
  · subst i; rfl
  have hp : M.canonicalPermutation i ≠ 0 := by
    intro h; exact hi (M.canonicalPermutation_injective i 0 h)
  have hv : i.val ≠ 0 := fun h => hi (Fin.ext h)
  have hw : (M.canonicalPermutation i).val ≠ 0 := fun h => hp (Fin.ext h)
  rw [weight_nonzero i (by omega), weight_nonzero _ (by omega)]

theorem Z7RootedMatrix.canonicalPermutation_left (M : Z7RootedMatrix) (i : Fin 15)
    (hi : 3 ≤ i.val) : M.B (M.canonicalPermutation i) 1 = z7OuterLeftCount i := by
  have hc := M.outer_type_counts
  by_cases h6 : i.val < 6
  · have hm : M.canonicalPermutation i ∈ M.outerType 2 := by
      unfold canonicalPermutation canonicalOrder
      simp only [List.get_eq_getElem]
      rw [List.getElem_append_left (by
        simp only [List.length_append, List.length_cons, List.length_nil]
        omega)]
      rw [List.getElem_append_left (by
        simp only [List.length_append, List.length_cons, List.length_nil]
        omega)]
      rw [List.getElem_append_right (by simp; omega)]
      exact List.getElem_mem _
    simpa [z7OuterLeftCount, h6] using (M.mem_outerType 2 _).mp hm |>.2
  · by_cases h9 : i.val < 9
    · have hm : M.canonicalPermutation i ∈ M.outerType 0 := by
        unfold canonicalPermutation canonicalOrder
        simp only [List.get_eq_getElem]
        rw [List.getElem_append_left (by
          simp only [List.length_append, List.length_cons, List.length_nil]
          omega)]
        rw [List.getElem_append_right (by
          simp only [List.length_append, List.length_cons, List.length_nil]
          omega)]
        exact List.getElem_mem _
      simpa [z7OuterLeftCount, h6, h9] using (M.mem_outerType 0 _).mp hm |>.2
    · have hm : M.canonicalPermutation i ∈ M.outerType 1 := by
        unfold canonicalPermutation canonicalOrder
        simp only [List.get_eq_getElem]
        rw [List.getElem_append_right (by
          simp only [List.length_append, List.length_cons, List.length_nil]
          omega)]
        exact List.getElem_mem _
      simpa [z7OuterLeftCount, h6, h9] using (M.mem_outerType 1 _).mp hm |>.2

theorem Z7RootedMatrix.canonicalPermutation_bijective (M : Z7RootedMatrix) :
    Function.Bijective M.canonicalPermutation :=
  ⟨M.canonicalPermutation_injective, M.canonicalPermutation_surjective⟩

theorem Z7RootedMatrix.canonicalPermutation_eq_iff (M : Z7RootedMatrix) (i j : Fin 15) :
    M.canonicalPermutation i = M.canonicalPermutation j ↔ i = j :=
  ⟨M.canonicalPermutation_injective i j, fun h => congrArg M.canonicalPermutation h⟩

private theorem canonical_delta (M : Z7RootedMatrix) (i j : Fin 15) :
    delta15 (M.canonicalPermutation i) (M.canonicalPermutation j) = delta15 i j := by
  simp only [delta15, M.canonicalPermutation_eq_iff]

private theorem canonical_root_test (M : Z7RootedMatrix) (i : Fin 15) :
    (M.canonicalPermutation i = 1 ∨ M.canonicalPermutation i = 2) ↔ i = 1 ∨ i = 2 := by
  have h1 := M.canonicalPermutation_eq_iff i 1
  have h2 := M.canonicalPermutation_eq_iff i 2
  simp only [M.canonicalPermutation_one, M.canonicalPermutation_two] at h1 h2
  simp only [h1, h2]

/-- Canonicalization is conditional on the raw rooted data, not a graph existence claim. -/
def Z7RootedMatrix.canonicalize (M : Z7RootedMatrix) : Z7OrbitMatrix where
  B i j := M.B (M.canonicalPermutation i) (M.canonicalPermutation j)
  row_sum i := by
    unfold rowSum15
    rw [← sumFin_eq_foldl,
      sumFin_comp_eq M.canonicalPermutation M.canonicalPermutation_injective
        M.canonicalPermutation_surjective (M.B (M.canonicalPermutation i)), sumFin_eq_foldl]
    exact M.row_sum (M.canonicalPermutation i)
  degree_symmetry i j := by
    have h := M.degree_symmetry (M.canonicalPermutation i) (M.canonicalPermutation j)
    simpa only [M.canonicalPermutation_weight] using h
  srg_equation i j := by
    unfold mul15
    rw [← sumFin_eq_foldl,
      sumFin_comp_eq M.canonicalPermutation M.canonicalPermutation_injective
        M.canonicalPermutation_surjective
        (fun k => M.B (M.canonicalPermutation i) k * M.B k (M.canonicalPermutation j)),
      sumFin_eq_foldl]
    have h := M.srg_equation (M.canonicalPermutation i) (M.canonicalPermutation j)
    simpa only [mul15, canonical_delta, M.canonicalPermutation_weight] using h
  diag_parity i := M.diag_parity (M.canonicalPermutation i)
  diag_zero := by simpa using M.root_row 0
  diag_one := M.diag_one
  diag_two := M.diag_two
  entry_bound i j := by
    have h := M.entry_bound (M.canonicalPermutation i) (M.canonicalPermutation j)
    simpa only [M.canonicalPermutation_weight] using h
  outer_bound i j hi hj := M.outer_bound _ _
    (M.canonicalPermutation_outer i hi) (M.canonicalPermutation_outer j hj)
  root_row j := by
    simp only [M.canonicalPermutation_zero, M.root_row, canonical_root_test]
  root_column i := by
    simp only [M.canonicalPermutation_zero, M.root_column, canonical_root_test]
  matching_forward := M.matching_forward
  matching_backward := M.matching_backward
  outer_left i hi := by
    simpa only [M.canonicalPermutation_one] using M.canonicalPermutation_left i hi
  outer_right i hi := by
    have h := M.outer_two (M.canonicalPermutation i) (M.canonicalPermutation_outer i hi)
    have hl := M.canonicalPermutation_left i hi
    simp only [M.canonicalPermutation_two]
    omega

theorem Z7RootedMatrix.canonicalize_B (M : Z7RootedMatrix) (i j : Fin 15) :
    M.canonicalize.B i j = M.B (M.canonicalPermutation i) (M.canonicalPermutation j) := rfl

#print axioms Z7RootedMatrix
#print axioms Z7RootedMatrix.outer_two
#print axioms Z7RootedMatrix.outer_bound
#print axioms Z7RootedMatrix.diag_parity
#print axioms Z7RootedMatrix.outer_type_counts
#print axioms Z7RootedMatrix.canonicalOrder_nodup
#print axioms Z7RootedMatrix.canonicalPermutation_bijective
#print axioms Z7RootedMatrix.canonicalize

end Matrix99
