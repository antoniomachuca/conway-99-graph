/-
  Conway's 99-Graph Problem Formalization in Lean 4
  Neighborhood Automorphisms (C₂ ≀ S₇) and 11-Branch Canonical Reduction
  of the 84-Vertex Second Subconstituent System.
-/
import Conway.Z84Subconstituent
import Conway.Z84Relabel

namespace Matrix99

set_option maxRecDepth 100000

/-! ### 1. Named 84-Vertex Residual Predicate and Bridge Theorems -/

/-- The 6-conjunct residual polynomial system on the 84-vertex second subconstituent Γ₂(x). -/
def IsResidual84 (X : Matrix 84 84) : Prop :=
  (∀ i : Fin 84, X i i = 0) ∧
  (∀ i j : Fin 84, X i j = X j i) ∧
  (∀ i j : Fin 84, X i j = 0 ∨ X i j = 1) ∧
  (∀ i : Fin 84, (List.finRange 84).foldl (fun acc j => acc + X i j) 0 = 12) ∧
  (∀ i j : Fin 84,
    (List.finRange 84).foldl (fun acc k => acc + X i k * X k j) 0 +
      X i j = K_val i j) ∧
  (∀ i : Fin 14, ∀ j : Fin 84,
    (List.finRange 14).foldl (fun acc k => acc + M_val i k * B_val k j) 0 +
    (List.finRange 84).foldl (fun acc k => acc + B_val i k * X k j) 0 =
      2 - B_val i j)

theorem block_A_conwayAdj_iff_residual84 (X : Matrix 84 84) :
    ConwayAdj (block_A X) ↔ IsResidual84 X :=
  second_subconstituent_reduction X

theorem conway_exists_iff_residual84 :
    (∃ A : Matrix99 Nat, ConwayAdj A) ↔ ∃ X : Matrix 84 84, IsResidual84 X :=
  conway_exists_iff_residual

/-! ### 2. Neighborhood Automorphisms Aut(7K₂) and Induced Action on Fin 84 -/

/-- First endpoint of the y-th non-edge pair in Fin 14. -/
def fst84 (y : Fin 84) : Fin 14 :=
  ⟨(nePair y).1, (nePair_spec y).1⟩

/-- Second endpoint of the y-th non-edge pair in Fin 14. -/
def snd84 (y : Fin 84) : Fin 14 :=
  ⟨(nePair y).2, (nePair_spec y).2.1⟩

/-- Index in Fin 84 of the unordered non-edge pair {u, v} ⊂ Fin 14. -/
def mkPair84 (u v : Fin 14) : Fin 84 :=
  let q := if u.val ≤ v.val then (u.val, v.val) else (v.val, u.val)
  ⟨pairIndex q % 84, Nat.mod_lt _ (by decide)⟩

/-- Induced permutation on Fin 84 from a permutation π : Fin 14 → Fin 14. -/
def liftPerm84 (π : Fin 14 → Fin 14) (y : Fin 84) : Fin 84 :=
  mkPair84 (π (fst84 y)) (π (snd84 y))

/-- Relabelling of an 84×84 matrix by ρ : Fin 84 → Fin 84. -/
def relabel84 (ρ : Fin 84 → Fin 84) (X : Matrix 84 84) : Matrix 84 84 :=
  fun y z => X (ρ y) (ρ z)

/-- Inverse of a map π : Fin 14 → Fin 14 via finite search. -/
def inv14 (π : Fin 14 → Fin 14) (b : Fin 14) : Fin 14 :=
  ((List.finRange 14).find? (fun a => π a == b)).getD b

/-- Boolean checker that π : Fin 14 → Fin 14 is an automorphism of M_val (7K₂). -/
def isNbrAut (π : Fin 14 → Fin 14) : Bool :=
  let π' := inv14 π
  (List.finRange 14).all (fun a => (π' (π a) == a) && (π (π' a) == a)) &&
  (List.finRange 14).all (fun a =>
    (List.finRange 14).all (fun b => M_val (π a) (π b) == M_val a b))

theorem fin_val_beq {n : Nat} (a b : Fin n) : (a.val == b.val) = (a == b) := by
  cases e1 : (a.val == b.val) <;> cases e2 : (a == b)
  · rfl
  · exact Bool.noConfusion (e1 ▸ beq_iff_eq.mpr (congrArg Fin.val (beq_iff_eq.mp e2)))
  · exact Bool.noConfusion (e2 ▸ beq_iff_eq.mpr (Fin.ext (beq_iff_eq.mp e1)))
  · rfl

theorem mkPair84_symm (u v : Fin 14) : mkPair84 u v = mkPair84 v u := by
  apply Fin.ext
  dsimp [mkPair84]
  rcases Nat.lt_trichotomy u.val v.val with hlt | heq | hgt
  · rw [if_pos (Nat.le_of_lt hlt), if_neg (by omega : ¬ v.val ≤ u.val)]
  · rw [heq]
  · rw [if_neg (by omega : ¬ u.val ≤ v.val), if_pos (Nat.le_of_lt hgt)]

theorem nePair_fst_eq_fst84 (y : Fin 84) : (nePair y).1 = (fst84 y).val := rfl
theorem nePair_snd_eq_snd84 (y : Fin 84) : (nePair y).2 = (snd84 y).val := rfl

theorem fst84_ne_snd84 (y : Fin 84) : fst84 y ≠ snd84 y := by
  intro e
  exact (nePair_spec y).2.2 (congrArg (fun x : Fin 14 => x.val / 2) e)

theorem fst84_snd84_nonadj (y : Fin 84) : M_val (fst84 y) (snd84 y) = 0 := by
  rw [M_val_eq]
  have hdiv : ((fst84 y).val / 2 == (snd84 y).val / 2) = false := by
    cases e : ((fst84 y).val / 2 == (snd84 y).val / 2)
    · rfl
    · exact absurd (beq_iff_eq.mp e) (nePair_spec y).2.2
  rw [hdiv, Bool.and_false, if_neg Bool.false_ne_true]

theorem nePairs_ord_check :
    nePairs.all (fun p => decide (p.1 ≤ p.2)) = true := by
  decide +kernel

theorem mkPair84_fst84_snd84 (y : Fin 84) : mkPair84 (fst84 y) (snd84 y) = y := by
  have hord : decide ((nePair y).1 ≤ (nePair y).2) = true :=
    all_of_mem (a := nePair y) nePairs_ord_check (nePair_mem y)
  have hle : (fst84 y).val ≤ (snd84 y).val := of_decide_eq_true hord
  have hpi_bool := all_of_mem (a := y) pairIndex_check (List.mem_finRange y)
  have hpi : pairIndex (nePair y) = y.val := beq_iff_eq.mp hpi_bool
  apply Fin.ext
  dsimp [mkPair84]
  rw [if_pos hle]
  show pairIndex (nePair y) % 84 = y.val
  rw [hpi, Nat.mod_eq_of_lt y.isLt]

def checkPairEq (p : Nat × Nat) (u v : Nat) : Bool :=
  (p.1 == u) && (p.2 == v)

theorem mkPair84_lt_check :
    (List.range 14).all (fun u =>
      (List.range 14).all (fun v =>
        if decide (u < v) && (u / 2 != v / 2) then
          checkPairEq (nePair ⟨pairIndex (u, v) % 84, Nat.mod_lt _ (by decide)⟩) u v
        else true)) = true := by
  decide +kernel

theorem mkPair84_of_lt {u v : Fin 14} (hlt : u.val < v.val) (hdiv : u.val / 2 ≠ v.val / 2) :
    fst84 (mkPair84 u v) = u ∧ snd84 (mkPair84 u v) = v := by
  have h1 := all_of_mem mkPair84_lt_check (List.mem_range.mpr u.isLt)
  have h2 := all_of_mem h1 (List.mem_range.mpr v.isLt)
  have hcond : (decide (u.val < v.val) && (u.val / 2 != v.val / 2)) = true := by
    rw [decide_eq_true hlt, bne_iff_ne.mpr hdiv]; rfl
  rw [hcond, if_pos rfl] at h2
  unfold checkPairEq at h2
  rw [Bool.and_eq_true] at h2
  have hmk : mkPair84 u v = ⟨pairIndex (u.val, v.val) % 84, Nat.mod_lt _ (by decide)⟩ := by
    apply Fin.ext; dsimp [mkPair84]; rw [if_pos (Nat.le_of_lt hlt)]
  rw [hmk]
  exact ⟨Fin.ext (beq_iff_eq.mp h2.1), Fin.ext (beq_iff_eq.mp h2.2)⟩

theorem mkPair84_endpoints {u v : Fin 14} (hne : u ≠ v) (hm : M_val u v = 0) :
    (fst84 (mkPair84 u v) = u ∧ snd84 (mkPair84 u v) = v) ∨
    (fst84 (mkPair84 u v) = v ∧ snd84 (mkPair84 u v) = u) := by
  have hdiv : u.val / 2 ≠ v.val / 2 := by
    intro e
    rw [M_val_eq] at hm
    have hne_val : (u.val != v.val) = true := bne_iff_ne.mpr (fun h => hne (Fin.ext h))
    rw [hne_val, beq_iff_eq.mpr e, Bool.and_true, if_pos rfl] at hm
    exact Nat.noConfusion hm
  rcases Nat.lt_trichotomy u.val v.val with hlt | heq | hgt
  · exact Or.inl (mkPair84_of_lt hlt hdiv)
  · exact absurd (Fin.ext heq) hne
  · rw [mkPair84_symm u v]
    exact Or.inr (mkPair84_of_lt hgt hdiv.symm)

theorem B_val_eq_fst84_snd84 (c : Fin 14) (y : Fin 84) :
    B_val c y = (if (c == fst84 y) || (c == snd84 y) then 1 else 0) := by
  rw [B_val_eq]
  unfold ind
  rw [nePair_fst_eq_fst84, nePair_snd_eq_snd84, fin_val_beq, fin_val_beq]

theorem B_val_mkPair84 (c : Fin 14) {u v : Fin 14} (hne : u ≠ v) (hm : M_val u v = 0) :
    B_val c (mkPair84 u v) = (if (c == u) || (c == v) then 1 else 0) := by
  rw [B_val_eq_fst84_snd84]
  rcases mkPair84_endpoints hne hm with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · rw [h1, h2]
  · rw [h1, h2, Bool.or_comm]

theorem isNbrAut_left_inv {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) (a : Fin 14) :
    inv14 π (π a) = a := by
  unfold isNbrAut at hπ
  rw [Bool.and_eq_true] at hπ
  have ha := all_of_mem hπ.1 (List.mem_finRange a)
  rw [Bool.and_eq_true] at ha
  exact beq_iff_eq.mp ha.1

theorem isNbrAut_right_inv {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) (a : Fin 14) :
    π (inv14 π a) = a := by
  unfold isNbrAut at hπ
  rw [Bool.and_eq_true] at hπ
  have ha := all_of_mem hπ.1 (List.mem_finRange a)
  rw [Bool.and_eq_true] at ha
  exact beq_iff_eq.mp ha.2

theorem isNbrAut_M {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) (a b : Fin 14) :
    M_val (π a) (π b) = M_val a b := by
  unfold isNbrAut at hπ
  rw [Bool.and_eq_true] at hπ
  have ha := all_of_mem hπ.2 (List.mem_finRange a)
  have hb := all_of_mem ha (List.mem_finRange b)
  exact beq_iff_eq.mp hb

theorem isNbrAut_inj {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) {a b : Fin 14}
    (h : π a = π b) : a = b := by
  have h1 := congrArg (inv14 π) h
  rw [isNbrAut_left_inv hπ a, isNbrAut_left_inv hπ b] at h1
  exact h1

theorem liftPerm84_left_inv {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) (y : Fin 84) :
    liftPerm84 (inv14 π) (liftPerm84 π y) = y := by
  unfold liftPerm84
  have hne : π (fst84 y) ≠ π (snd84 y) := fun e => fst84_ne_snd84 y (isNbrAut_inj hπ e)
  have hm : M_val (π (fst84 y)) (π (snd84 y)) = 0 := by
    rw [isNbrAut_M hπ]; exact fst84_snd84_nonadj y
  rcases mkPair84_endpoints hne hm with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · rw [h1, h2, isNbrAut_left_inv hπ, isNbrAut_left_inv hπ, mkPair84_fst84_snd84]
  · rw [h1, h2, isNbrAut_left_inv hπ, isNbrAut_left_inv hπ, mkPair84_symm, mkPair84_fst84_snd84]

theorem liftPerm84_right_inv {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) (y : Fin 84) :
    liftPerm84 π (liftPerm84 (inv14 π) y) = y := by
  unfold liftPerm84
  have hne : inv14 π (fst84 y) ≠ inv14 π (snd84 y) := by
    intro e
    have h1 := congrArg π e
    rw [isNbrAut_right_inv hπ, isNbrAut_right_inv hπ] at h1
    exact fst84_ne_snd84 y h1
  have hm : M_val (inv14 π (fst84 y)) (inv14 π (snd84 y)) = 0 := by
    rw [← isNbrAut_M hπ (inv14 π (fst84 y)) (inv14 π (snd84 y)),
        isNbrAut_right_inv hπ, isNbrAut_right_inv hπ]
    exact fst84_snd84_nonadj y
  rcases mkPair84_endpoints hne hm with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · rw [h1, h2, isNbrAut_right_inv hπ, isNbrAut_right_inv hπ, mkPair84_fst84_snd84]
  · rw [h1, h2, isNbrAut_right_inv hπ, isNbrAut_right_inv hπ, mkPair84_symm, mkPair84_fst84_snd84]

theorem isNbrAut_B {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) (c : Fin 14) (y : Fin 84) :
    B_val (π c) (liftPerm84 π y) = B_val c y := by
  unfold liftPerm84
  have hne1 : fst84 y ≠ snd84 y := fst84_ne_snd84 y
  have hm1 : M_val (fst84 y) (snd84 y) = 0 := fst84_snd84_nonadj y
  have hne2 : π (fst84 y) ≠ π (snd84 y) := fun e => hne1 (isNbrAut_inj hπ e)
  have hm2 : M_val (π (fst84 y)) (π (snd84 y)) = 0 := by rw [isNbrAut_M hπ]; exact hm1
  rw [B_val_mkPair84 (π c) hne2 hm2]
  have h3 := B_val_mkPair84 c hne1 hm1
  rw [mkPair84_fst84_snd84] at h3
  rw [h3]
  have heq1 : (π c == π (fst84 y)) = (c == fst84 y) := by
    cases e1 : (π c == π (fst84 y)) <;> cases e2 : (c == fst84 y)
    · rfl
    · exact Bool.noConfusion (e1 ▸ beq_iff_eq.mpr (congrArg π (beq_iff_eq.mp e2)))
    · exact Bool.noConfusion (e2 ▸ beq_iff_eq.mpr (isNbrAut_inj hπ (beq_iff_eq.mp e1)))
    · rfl
  have heq2 : (π c == π (snd84 y)) = (c == snd84 y) := by
    cases e1 : (π c == π (snd84 y)) <;> cases e2 : (c == snd84 y)
    · rfl
    · exact Bool.noConfusion (e1 ▸ beq_iff_eq.mpr (congrArg π (beq_iff_eq.mp e2)))
    · exact Bool.noConfusion (e2 ▸ beq_iff_eq.mpr (isNbrAut_inj hπ (beq_iff_eq.mp e1)))
    · rfl
  rw [heq1, heq2]

/-- Block-compatible 99-vertex permutation induced by (π, ρ). -/
def sigma99 (π : Fin 14 → Fin 14) (ρ : Fin 84 → Fin 84) (i : Fin 99) : Fin 99 :=
  if h1 : i.val = 0 then rootV
  else if h2 : i.val ≤ 14 then nbrV (π ⟨i.val - 1, by have := i.isLt; omega⟩)
  else farV (ρ ⟨i.val - 15, by have := i.isLt; omega⟩)

theorem sigma99_root (π : Fin 14 → Fin 14) (ρ : Fin 84 → Fin 84) :
    sigma99 π ρ rootV = rootV := by
  unfold sigma99
  rw [dif_pos rootV_val]

theorem sigma99_nbr (π : Fin 14 → Fin 14) (ρ : Fin 84 → Fin 84) (a : Fin 14) :
    sigma99 π ρ (nbrV a) = nbrV (π a) := by
  unfold sigma99
  rw [dif_neg (nbrV_ne_zero_val a), dif_pos (nbrV_val_le a)]
  congr 1

theorem sigma99_far (π : Fin 14 → Fin 14) (ρ : Fin 84 → Fin 84) (y : Fin 84) :
    sigma99 π ρ (farV y) = farV (ρ y) := by
  unfold sigma99
  rw [dif_neg (farV_ne_zero_val y), dif_neg (farV_val_gt y)]
  congr 1

theorem sigma99_bij {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true) :
    Function.Bijective (sigma99 π (liftPerm84 π)) := by
  have hleft : ∀ i : Fin 99,
      sigma99 (inv14 π) (liftPerm84 (inv14 π)) (sigma99 π (liftPerm84 π) i) = i := by
    intro i
    rcases fin99_cases i with rfl | ⟨a, rfl⟩ | ⟨y, rfl⟩
    · rw [sigma99_root, sigma99_root]
    · rw [sigma99_nbr, sigma99_nbr, isNbrAut_left_inv hπ]
    · rw [sigma99_far, sigma99_far, liftPerm84_left_inv hπ]
  have hright : ∀ i : Fin 99,
      sigma99 π (liftPerm84 π) (sigma99 (inv14 π) (liftPerm84 (inv14 π)) i) = i := by
    intro i
    rcases fin99_cases i with rfl | ⟨a, rfl⟩ | ⟨y, rfl⟩
    · rw [sigma99_root, sigma99_root]
    · rw [sigma99_nbr, sigma99_nbr, isNbrAut_right_inv hπ]
    · rw [sigma99_far, sigma99_far, liftPerm84_right_inv hπ]
  refine ⟨fun i j h => ?_,
    fun v => ⟨sigma99 (inv14 π) (liftPerm84 (inv14 π)) v, hright v⟩⟩
  have h1 := congrArg (sigma99 (inv14 π) (liftPerm84 (inv14 π))) h
  rw [hleft i, hleft j] at h1
  exact h1

theorem block_A_relabel84 {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true)
    (X : Matrix 84 84) :
    block_A (relabel84 (liftPerm84 π) X) =
      fun i j => block_A X (sigma99 π (liftPerm84 π) i) (sigma99 π (liftPerm84 π) j) := by
  funext i j
  rcases fin99_cases i with rfl | ⟨a, rfl⟩ | ⟨y, rfl⟩ <;>
  rcases fin99_cases j with rfl | ⟨b, rfl⟩ | ⟨z, rfl⟩
  · rw [sigma99_root, eval_rr, eval_rr]
  · rw [sigma99_root, sigma99_nbr, eval_rn, eval_rn]
  · rw [sigma99_root, sigma99_far, eval_rf, eval_rf]
  · rw [sigma99_nbr, sigma99_root, eval_nr, eval_nr]
  · rw [sigma99_nbr, sigma99_nbr, eval_nn, eval_nn, isNbrAut_M hπ]
  · rw [sigma99_nbr, sigma99_far, eval_nf, eval_nf, isNbrAut_B hπ]
  · rw [sigma99_far, sigma99_root, eval_fr, eval_fr]
  · rw [sigma99_far, sigma99_nbr, eval_fn, eval_fn, isNbrAut_B hπ]
  · rw [sigma99_far, sigma99_far, eval_ff, eval_ff]; rfl

/-- Any automorphism π of M_val (7K₂) preserves the 84-vertex residual system IsResidual84. -/
theorem residual84_relabel_of_nbrAut {π : Fin 14 → Fin 14} (hπ : isNbrAut π = true)
    (X : Matrix 84 84) (hX : IsResidual84 X) :
    IsResidual84 (relabel84 (liftPerm84 π) X) := by
  rw [← block_A_conwayAdj_iff_residual84]
  rw [block_A_relabel84 hπ X]
  exact conwayAdj_relabel (block_A X) (sigma99_bij hπ)
    ((block_A_conwayAdj_iff_residual84 X).mpr hX)

/-! ### 3. The 12-Vertex Fiber and 11 Canonical Matching Branches -/

/-- The fiber of 12 vertices in Fin 84 adjacent to vertex 0 of Fin 14 in Conway's graph. -/
def fiber0 : List (Fin 84) :=
  (List.finRange 84).filter (fun y => fst84 y == ⟨0, by decide⟩ || snd84 y == ⟨0, by decide⟩)

theorem fiber0_length : fiber0.length = 12 := by decide +kernel

/-- The fiber0 vertices correspond to the first 12 indices of Fin 84. -/
theorem fiber0_eq_first12 :
    fiber0.map Fin.val = List.range 12 := by
  decide +kernel

/-- The 11 integer partitions of 6. -/
def Partitions6 : List (List Nat) :=
  [ [6]
  , [5, 1]
  , [4, 2]
  , [4, 1, 1]
  , [3, 3]
  , [3, 2, 1]
  , [3, 1, 1, 1]
  , [2, 2, 2]
  , [2, 2, 1, 1]
  , [2, 1, 1, 1, 1]
  , [1, 1, 1, 1, 1, 1]
  ]

theorem partitions6_length : Partitions6.length = 11 := by rfl

theorem partitions6_nodup : Partitions6.Nodup := by decide +kernel

theorem partitions6_sum :
    Partitions6.all (fun p => p.foldl (· + ·) 0 == 6) = true := by
  decide +kernel

/-- Canonical matching representative for each of the 11 partition branches on the 12 fiber vertices. -/
def branchMatching : Fin 11 → List (Nat × Nat)
  | ⟨0, _⟩  => [(0, 2), (1, 4), (3, 6), (5, 8), (7, 10), (9, 11)]
  | ⟨1, _⟩  => [(0, 1), (2, 4), (3, 6), (5, 8), (7, 10), (9, 11)]
  | ⟨2, _⟩  => [(0, 2), (1, 3), (4, 6), (5, 8), (7, 10), (9, 11)]
  | ⟨3, _⟩  => [(0, 1), (2, 3), (4, 6), (5, 8), (7, 10), (9, 11)]
  | ⟨4, _⟩  => [(0, 2), (1, 4), (3, 5), (6, 8), (7, 10), (9, 11)]
  | ⟨5, _⟩  => [(0, 1), (2, 4), (3, 5), (6, 8), (7, 10), (9, 11)]
  | ⟨6, _⟩  => [(0, 1), (2, 3), (4, 5), (6, 8), (7, 10), (9, 11)]
  | ⟨7, _⟩  => [(0, 2), (1, 3), (4, 6), (5, 7), (8, 10), (9, 11)]
  | ⟨8, _⟩  => [(0, 1), (2, 3), (4, 6), (5, 7), (8, 10), (9, 11)]
  | ⟨9, _⟩  => [(0, 1), (2, 3), (4, 5), (6, 7), (8, 10), (9, 11)]
  | ⟨10, _⟩ => [(0, 1), (2, 3), (4, 5), (6, 7), (8, 9), (10, 11)]

/-- Verification that each branch matching is a valid 1-factor on 12 vertices. -/
def isPerfectMatching12 (m : List (Nat × Nat)) : Bool :=
  (m.length == 6) &&
  let vs := m.flatMap (fun p => [p.1, p.2])
  (vs.all (fun v => v < 12)) &&
  ((List.range 12).all (fun v => vs.count v == 1))

theorem branchMatching_valid :
    (List.finRange 11).all (fun i => isPerfectMatching12 (branchMatching i)) = true := by
  decide +kernel

/-- Neighbor of v in matching m. -/
def matchingPartner (m : List (Nat × Nat)) (v : Nat) : Nat :=
  match m.find? (fun p => p.1 == v || p.2 == v) with
  | some (a, b) => if a == v then b else a
  | none => v

/-- Block partner of v: 2b ↔ 2b+1 for b < 6. -/
def blockPartner (v : Nat) : Nat :=
  if v % 2 == 0 then v + 1 else v - 1

/-- Traverses an alternating cycle in M ∪ B starting from vertex start. -/
def traceCycle (m : List (Nat × Nat)) (start : Nat) : List Nat :=
  let rec go (cur : Nat) (steps : Nat) : List Nat :=
    match steps with
    | 0 => []
    | s + 1 =>
      let nxt := blockPartner (matchingPartner m cur)
      if nxt == start then [cur]
      else cur :: go nxt s
  go start 12

/-- Insertion sort descending for short lists of Nat. -/
def insertSortDesc : List Nat → List Nat
  | [] => []
  | x :: xs =>
    let rec ins (y : Nat) : List Nat → List Nat
      | [] => [y]
      | z :: zs => if y ≥ z then y :: z :: zs else z :: ins y zs
    ins x (insertSortDesc xs)

/-- Computes the cycle partition of 6 induced by matching m and the 6 block-edges. -/
def cyclePartition (m : List (Nat × Nat)) : List Nat :=
  let rec go (remBlocks : List Nat) (fuel : Nat) : List Nat :=
    match fuel, remBlocks with
    | 0, _ => []
    | _, [] => []
    | f + 1, b :: _ =>
      let cyc := traceCycle m (2 * b)
      let cycBlocks := cyc.map (· / 2)
      let rem' := remBlocks.filter (fun x => !cycBlocks.contains x)
      cyc.length :: go rem' f
  insertSortDesc (go (List.range 6) 6)

/-- Soundness: the 11 canonical matchings induce exactly the 11 integer partitions of 6. -/
theorem branchMatching_cyclePartition_sound :
    (List.finRange 11).all (fun i =>
      cyclePartition (branchMatching i) == Partitions6[i.val]!) = true := by
  decide +kernel

end Matrix99

