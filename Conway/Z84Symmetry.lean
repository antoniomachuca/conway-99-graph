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


/-! ### 4. Group Action of C₂ ≀ S₆ and 11-Branch Orbit Coverage Theorem -/

/-- The wreath product C₂ ≀ S₆ = (C₂)⁶ ⋊ S₆ of order 46,080.
    `perm` is a permutation of the 6 block indices {0, ..., 5}.
    `flips` is a list of 6 bits indicating whether to swap (2b, 2b+1). -/
structure C2wrS6 where
  perm : List Nat
  flips : List Nat
deriving DecidableEq, Repr

/-- Predicate verifying that g is a valid element of C₂ ≀ S₆. -/
def isC2wrS6 (g : C2wrS6) : Bool :=
  g.perm.length == 6 &&
  g.perm.Nodup &&
  g.perm.all (fun b => b < 6) &&
  g.flips.length == 6 &&
  g.flips.all (fun s => s < 2)

/-- Action of g ∈ C₂ ≀ S₆ on a fiber vertex v ∈ {0, ..., 11}. -/
def c2wrS6_act (g : C2wrS6) (v : Nat) : Nat :=
  let b := v / 2
  let r := v % 2
  let b' := g.perm.getD b 0
  let s := g.flips.getD b 0
  2 * b' + ((r + s) % 2)

/-- Normalizes an edge (u, v) so that u ≤ v. -/
def normEdge (p : Nat × Nat) : Nat × Nat :=
  if p.1 ≤ p.2 then p else (p.2, p.1)

/-- Insertion of an edge into an ordered list of edges. -/
def insEdge (y : Nat × Nat) : List (Nat × Nat) → List (Nat × Nat)
  | [] => [y]
  | z :: zs => if y.1 < z.1 || (y.1 == z.1 && y.2 ≤ z.2) then y :: z :: zs else z :: insEdge y zs

/-- Sorts a list of 6 edges into canonical lexicographic order. -/
def sortEdges : List (Nat × Nat) → List (Nat × Nat)
  | [] => []
  | x :: xs => insEdge x (sortEdges xs)

/-- Action of g ∈ C₂ ≀ S₆ on a perfect matching m of K₁₂. -/
def actMatching (g : C2wrS6) (m : List (Nat × Nat)) : List (Nat × Nat) :=
  sortEdges (m.map fun p => normEdge (c2wrS6_act g p.1, c2wrS6_act g p.2))

/-- Decodes an encoded witness integer into a pair (g, i) ∈ C₂ ≀ S₆ × Fin 11. -/
def decodeWitness (code : Nat) : C2wrS6 × Fin 11 :=
  let t := code % 11
  let c1 := code / 11
  let f := c1 % 64
  let c2 := c1 / 64
  let p0 := c2 % 6
  let c3 := c2 / 6
  let p1 := c3 % 6
  let c4 := c3 / 6
  let p2 := c4 % 6
  let c5 := c4 / 6
  let p3 := c5 % 6
  let c6 := c5 / 6
  let p4 := c6 % 6
  let p5 := c6 / 6
  let flips := [f % 2, (f / 2) % 2, (f / 4) % 2, (f / 8) % 2, (f / 16) % 2, (f / 32) % 2]
  let perm := [p0, p1, p2, p3, p4, p5]
  (⟨perm, flips⟩, ⟨t, Nat.mod_lt _ (by decide)⟩)

/-- Boolean check that g maps matching m to canonical branch representative branchMatching i. -/
def checkAct (m : List (Nat × Nat)) (w : C2wrS6 × Fin 11) : Bool :=
  actMatching w.1 m == branchMatching w.2

/-- Constructive witness extraction lemma from zip of matching list and witness list. -/
theorem exists_witness_of_act_and_isC2wrS6
    (xs : List (List (Nat × Nat))) (ws : List (C2wrS6 × Fin 11))
    (hlen : xs.length ≤ ws.length)
    (h_act : (List.zip xs ws).all (fun (m, w) => checkAct m w) = true)
    (h_valid : ws.all (fun w => isC2wrS6 w.1) = true)
    {m : List (Nat × Nat)} (hm : m ∈ xs) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  induction xs generalizing ws with
  | nil => contradiction
  | cons x' xs' ih =>
    cases ws with
    | nil =>
      dsimp [List.length] at hlen
      contradiction
    | cons w' ws' =>
      dsimp [List.zip, List.all] at h_act
      dsimp [List.all] at h_valid
      rw [Bool.and_eq_true] at h_act
      rw [Bool.and_eq_true] at h_valid
      cases hm with
      | head =>
        have ha : actMatching w'.1 m = branchMatching w'.2 := beq_iff_eq.mp h_act.1
        exact ⟨w'.1, h_valid.1, w'.2, ha⟩
      | tail _ hm' =>
        have hlen' : xs'.length ≤ ws'.length := by
          dsimp [List.length] at hlen
          exact Nat.le_of_succ_le_succ hlen
        exact ih ws' hlen' h_act.2 h_valid.2 hm'

/-- Enumeration of perfect matchings on a list of vertices vs with fuel. -/
def enumMatchings (fuel : Nat) (vs : List Nat) : List (List (Nat × Nat)) :=
  match fuel, vs with
  | _, [] => [[]]
  | 0, _ => []
  | f + 1, x :: xs =>
    xs.flatMap fun y =>
      let rest := xs.filter (fun z => z != y)
      (enumMatchings f rest).map (fun m => (x, y) :: m)

def chunk0_part0 : List (List (Nat × Nat)) :=
  [3, 4, 5].flatMap fun y2 =>
    let rest := [3, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 1) :: (2, y2) :: m)

def codes0_p0 : List Nat := [31532170, 31532169, 31532521, 21648009, 31532166, 31532518, 21648185, 31532342, 31532694, 26970246, 26970422, 30771849, 26970598, 26970774, 30772201, 19113609, 31532168, 31532520, 16199046, 31532163, 31532515, 16199222, 31532339, 31532691, 26970243, 26970419, 29884806, 26970595, 26970771, 29885158, 19113697, 31532256, 31532608, 16199134, 31532251, 31532603, 16199310, 31532427, 31532779, 26970331, 26970507, 29884894, 26970683, 26970859, 29885246, 15438726, 30772195, 30771843, 15438814, 30772283, 30771931, 21394569, 30771848, 30772200, 31405446, 25449603, 25449691, 31405798, 25449955, 25450043, 15438902, 30772371, 30772019, 15438990, 30772459, 30772107, 21394745, 30772024, 30772376, 31405622, 25449779, 25449867, 31405974, 25450131, 25450219, 21648179, 21648003, 24562566, 21648267, 21648091, 24562654, 26843526, 20887771, 20887683, 26843702, 20887947, 20887859, 30518409, 21648008, 21648184, 21648531, 21648355, 24562918, 21648619, 21648443, 24563006, 26843878, 20888123, 20888035, 26844054, 20888299, 20888211, 30518761, 21648360, 21648536, 18543369, 31257608, 31257960, 10728968, 31532165, 31532517, 10729144, 31532341, 31532693, 26970245, 26970421, 28976648, 26970597, 26970773, 28977000, 12735366, 12735365, 12735717, 10728963, 31532161, 31532513, 10729139, 31532337, 31532689, 26970241, 26970417, 28976643, 26970593, 26970769, 28976995, 12735454, 12735453, 12735805, 10729051, 31532249, 31532601, 10729227, 31532425, 31532777, 26970329, 26970505, 28976731, 26970681, 26970857, 28977083, 9968643, 30772193, 30771841, 9968731, 30772281, 30771929, 15776646, 15776645, 15776997, 31257603, 25449601, 25449689, 31257955, 25449953, 25450041, 9968819, 30772369, 30772017, 9968907, 30772457, 30772105, 15776822, 15776821, 15777173, 31257779, 25449777, 25449865, 31258131, 25450129, 25450217, 21648177, 21648001, 23654403, 21648265, 21648089, 23654491, 26695683, 20887769, 20887681, 26695859, 20887945, 20887857, 29462406, 29462405, 29462581, 21648529, 21648353, 23654755, 21648617, 21648441, 23654843, 26696035, 20888121, 20888033, 26696211, 20888297, 20888209, 29462758, 29462757, 29462933, 18543413, 31257652, 31258004, 10729012, 31532209, 31532561, 10729188, 31532385, 31532737, 26970289, 26970465, 28976692, 26970641, 26970817, 28977044, 12735410, 12735409, 12735761, 10729007, 31532205, 31532557, 10729183, 31532381, 31532733, 26970285, 26970461, 28976687, 26970637, 26970813, 28977039, 12735498, 12735497, 12735849, 10729095, 31532293, 31532645, 10729271, 31532469, 31532821, 26970373, 26970549, 28976775, 26970725, 26970901, 28977127, 9968687, 30772237, 30771885, 9968775, 30772325, 30771973, 15776690, 15776689, 15777041, 31257647, 25449645, 25449733, 31257999, 25449997, 25450085, 9968863, 30772413, 30772061, 9968951, 30772501, 30772149, 15776866, 15776865, 15777217, 31257823, 25449821, 25449909, 31258175, 25450173, 25450261, 21648221, 21648045, 23654447, 21648309, 21648133, 23654535, 26695727, 20887813, 20887725, 26695903, 20887989, 20887901, 29462450, 29462449, 29462625, 21648573, 21648397, 23654799, 21648661, 21648485, 23654887, 26696079, 20888165, 20888077, 26696255, 20888341, 20888253, 29462802, 29462801, 29462977]
def witnesses0_p0 : List (C2wrS6 × Fin 11) := codes0_p0.map decodeWitness

theorem chunk0_part0_len : chunk0_part0.length ≤ witnesses0_p0.length := by decide +kernel
theorem chunk0_part0_len_eq : chunk0_part0.length = 315 := by decide +kernel
theorem chunk0_part0_act_valid : (List.zip chunk0_part0 witnesses0_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses0_p0_valid : witnesses0_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk0_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk0_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk0_part0 witnesses0_p0 chunk0_part0_len chunk0_part0_act_valid witnesses0_p0_valid hm

def chunk0_part1 : List (List (Nat × Nat)) :=
  [6, 7, 8].flatMap fun y2 =>
    let rest := [3, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 1) :: (2, y2) :: m)

def codes0_p1 : List Nat := [12608646, 12608645, 12608997, 10602419, 26843521, 26843873, 10602243, 26843697, 26844049, 31405441, 31405617, 28850275, 31405793, 31405969, 28849923, 12608690, 12608689, 12609041, 10602463, 26843565, 26843917, 10602287, 26843741, 26844093, 31405485, 31405661, 28850319, 31405837, 31406013, 28849967, 19050249, 31511048, 31511400, 10602248, 31405445, 31405797, 10602424, 31405621, 31405973, 26843525, 26843701, 28849928, 26843877, 26844053, 28850280, 16156806, 31511043, 31511395, 9715203, 30518753, 30518401, 9715247, 25069793, 25069441, 30518797, 25069837, 16156805, 30518445, 25069485, 16157157, 16156982, 31511219, 31511571, 9715379, 30518929, 30518577, 9715423, 25069969, 25069617, 30518973, 25070013, 16156981, 30518621, 25069661, 16157333, 26949123, 26949299, 29842566, 21394737, 21394561, 23400963, 21394781, 29842565, 20507741, 21394605, 29842741, 20507565, 23401007, 20507697, 20507521, 26949475, 26949651, 29842918, 21395089, 21394913, 23401315, 21395133, 29842917, 20508093, 21394957, 29843093, 20507917, 23401359, 20508049, 20507873, 12608734, 12608733, 12609085, 10602507, 26843609, 26843961, 10602331, 26843785, 26844137, 31405529, 31405705, 28850363, 31405881, 31406057, 28850011, 12608778, 12608777, 12609129, 10602551, 26843653, 26844005, 10602375, 26843829, 26844181, 31405573, 31405749, 28850407, 31405925, 31406101, 28850055, 19050337, 31511136, 31511488, 10602336, 31405533, 31405885, 10602512, 31405709, 31406061, 26843613, 26843789, 28850016, 26843965, 26844141, 28850368, 16156894, 31511131, 31511483, 9715291, 30518841, 30518489, 9715335, 25069881, 25069529, 30518885, 25069925, 16156893, 30518533, 25069573, 16157245, 16157070, 31511307, 31511659, 9715467, 30519017, 30518665, 9715511, 25070057, 25069705, 30519061, 25070101, 16157069, 30518709, 25069749, 16157421, 26949211, 26949387, 29842654, 21394825, 21394649, 23401051, 21394869, 29842653, 20507829, 21394693, 29842829, 20507653, 23401095, 20507785, 20507609, 26949563, 26949739, 29843006, 21395177, 21395001, 23401403, 21395221, 29843005, 20508181, 21395045, 29843181, 20508005, 23401447, 20508137, 20507961, 9081691, 24562913, 24562561, 9081603, 24563001, 24562649, 14889606, 14889605, 14889957, 30370915, 29884801, 29884889, 30370563, 29885153, 29885241, 9081735, 24562957, 24562605, 9081647, 24563045, 24562693, 14889650, 14889649, 14890001, 30370959, 29884845, 29884933, 30370607, 29885197, 29885285, 15396486, 30751075, 30750723, 8954927, 24309473, 24309121, 8954883, 29758433, 29758081, 24309517, 29758477, 15396485, 24309165, 29758125, 15396837, 15396574, 30751163, 30750811, 8955015, 24309561, 24309209, 8954971, 29758521, 29758169, 24309605, 29758565, 15396573, 24309253, 29758213, 15396925, 21331209, 30750728, 30751080, 9081608, 29884805, 29885157, 9081696, 29884893, 29885245, 24562565, 24562653, 30370568, 24562917, 24563005, 30370920, 31363206, 25428483, 25428571, 31363205, 19113733, 18987013, 31363293, 19113645, 18986925, 19113689, 19113601, 24921603, 18986969, 18986881, 24921647, 31363558, 25428835, 25428923, 31363557, 19114085, 18987365, 31363645, 19113997, 18987277, 19114041, 19113953, 24921955, 18987321, 18987233, 24921999]
def witnesses0_p1 : List (C2wrS6 × Fin 11) := codes0_p1.map decodeWitness

theorem chunk0_part1_len : chunk0_part1.length ≤ witnesses0_p1.length := by decide +kernel
theorem chunk0_part1_len_eq : chunk0_part1.length = 315 := by decide +kernel
theorem chunk0_part1_act_valid : (List.zip chunk0_part1 witnesses0_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses0_p1_valid : witnesses0_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk0_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk0_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk0_part1 witnesses0_p1 chunk0_part1_len chunk0_part1_act_valid witnesses0_p1_valid hm

def chunk0_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [3, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 1) :: (2, y2) :: m)

def codes0_p2 : List Nat := [9081867, 24563089, 24562737, 9081779, 24563177, 24562825, 14889782, 14889781, 14890133, 30371091, 29884977, 29885065, 30370739, 29885329, 29885417, 9081911, 24563133, 24562781, 9081823, 24563221, 24562869, 14889826, 14889825, 14890177, 30371135, 29885021, 29885109, 30370783, 29885373, 29885461, 15396662, 30751251, 30750899, 8955103, 24309649, 24309297, 8955059, 29758609, 29758257, 24309693, 29758653, 15396661, 24309341, 29758301, 15397013, 15396750, 30751339, 30750987, 8955191, 24309737, 24309385, 8955147, 29758697, 29758345, 24309781, 29758741, 15396749, 24309429, 29758389, 15397101, 21331385, 30750904, 30751256, 9081784, 29884981, 29885333, 9081872, 29885069, 29885421, 24562741, 24562829, 30370744, 24563093, 24563181, 30371096, 31363382, 25428659, 25428747, 31363381, 19113909, 18987189, 31363469, 19113821, 18987101, 19113865, 19113777, 24921779, 18987145, 18987057, 24921823, 31363734, 25429011, 25429099, 31363733, 19114261, 18987541, 31363821, 19114173, 18987453, 19114217, 19114129, 24922131, 18987497, 18987409, 24922175, 15438897, 15438721, 18205531, 15438985, 15438809, 18205443, 21246899, 16199129, 16199041, 21246723, 16199305, 16199217, 24013446, 24013445, 24013621, 15438941, 15438765, 18205575, 15439029, 15438853, 18205487, 21246943, 16199173, 16199085, 21246767, 16199349, 16199261, 24013490, 24013489, 24013665, 21627059, 21626883, 24520326, 15185457, 15185281, 18078767, 15185501, 24520325, 16072541, 15185325, 24520501, 16072365, 18078723, 16072497, 16072321, 21627147, 21626971, 24520414, 15185545, 15185369, 18078855, 15185589, 24520413, 16072629, 15185413, 24520589, 16072453, 18078811, 16072585, 16072409, 26801286, 20866651, 20866563, 26801285, 14425093, 14551813, 26801373, 14425005, 14551725, 14425049, 14424961, 20359727, 14551769, 14551681, 20359683, 26801462, 20866827, 20866739, 26801461, 14425269, 14551989, 26801549, 14425181, 14551901, 14425225, 14425137, 20359903, 14551945, 14551857, 20359859, 30455049, 21626888, 21627064, 18205448, 16199045, 16199221, 18205536, 16199133, 16199309, 15438725, 15438813, 21246728, 15438901, 15438989, 21246904, 15439249, 15439073, 18205883, 15439337, 15439161, 18205795, 21247251, 16199481, 16199393, 21247075, 16199657, 16199569, 24013798, 24013797, 24013973, 15439293, 15439117, 18205927, 15439381, 15439205, 18205839, 21247295, 16199525, 16199437, 21247119, 16199701, 16199613, 24013842, 24013841, 24014017, 21627411, 21627235, 24520678, 15185809, 15185633, 18079119, 15185853, 24520677, 16072893, 15185677, 24520853, 16072717, 18079075, 16072849, 16072673, 21627499, 21627323, 24520766, 15185897, 15185721, 18079207, 15185941, 24520765, 16072981, 15185765, 24520941, 16072805, 18079163, 16072937, 16072761, 26801638, 20867003, 20866915, 26801637, 14425445, 14552165, 26801725, 14425357, 14552077, 14425401, 14425313, 20360079, 14552121, 14552033, 20360035, 26801814, 20867179, 20867091, 26801813, 14425621, 14552341, 26801901, 14425533, 14552253, 14425577, 14425489, 20360255, 14552297, 14552209, 20360211, 30455401, 21627240, 21627416, 18205800, 16199397, 16199573, 18205888, 16199485, 16199661, 15439077, 15439165, 21247080, 15439253, 15439341, 21247256]
def witnesses0_p2 : List (C2wrS6 × Fin 11) := codes0_p2.map decodeWitness

theorem chunk0_part2_len : chunk0_part2.length ≤ witnesses0_p2.length := by decide +kernel
theorem chunk0_part2_len_eq : chunk0_part2.length = 315 := by decide +kernel
theorem chunk0_part2_act_valid : (List.zip chunk0_part2 witnesses0_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses0_p2_valid : witnesses0_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk0_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk0_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk0_part2 witnesses0_p2 chunk0_part2_len chunk0_part2_act_valid witnesses0_p2_valid hm

def chunk0 : List (List (Nat × Nat)) :=
  chunk0_part0 ++ (chunk0_part1 ++ chunk0_part2)

theorem chunk0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk0] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk0_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk0_part1_coverage m h1
  · exact chunk0_part2_coverage m h2

theorem chunk0_len : chunk0.length = 945 := by
  dsimp [chunk0]
  repeat rw [List.length_append]
  rw [chunk0_part0_len_eq, chunk0_part1_len_eq, chunk0_part2_len_eq]

def chunk1_part0 : List (List (Nat × Nat)) :=
  [3, 4, 5].flatMap fun y2 =>
    let rest := [3, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 2) :: (1, y2) :: m)

def codes1_p0 : List Nat := [18423689, 31187208, 31187560, 10658568, 31486405, 31486757, 10658744, 31486581, 31486933, 26924485, 26924661, 28906248, 26924837, 26925013, 28906600, 6350088, 31532167, 31532519, 5255365, 31532162, 31532514, 5255541, 31532338, 31532690, 26970242, 26970418, 28064965, 26970594, 26970770, 28065317, 6350176, 31532255, 31532607, 5255453, 31532250, 31532602, 5255629, 31532426, 31532778, 26970330, 26970506, 28065053, 26970682, 26970858, 28065405, 4495045, 30772194, 30771842, 4495133, 30772282, 30771930, 10151688, 30771847, 30772199, 31106245, 25449602, 25449690, 31106597, 25449954, 25450042, 4495221, 30772370, 30772018, 4495309, 30772458, 30772106, 10151864, 30772023, 30772375, 31106421, 25449778, 25449866, 31106773, 25450130, 25450218, 21648178, 21648002, 22742725, 21648266, 21648090, 22742813, 26544325, 20887770, 20887682, 26544501, 20887946, 20887858, 28399368, 21648007, 21648183, 21648530, 21648354, 22743077, 21648618, 21648442, 22743165, 26544677, 20888122, 20888034, 26544853, 20888298, 20888210, 28399720, 21648359, 21648535, 12006726, 12006725, 12007077, 2122565, 31532164, 31532516, 2122741, 31532340, 31532692, 26970244, 26970420, 11246405, 26970596, 26970772, 11246757, 6350083, 6350082, 6350434, 5255361, 31532160, 31532512, 5255537, 31532336, 31532688, 26970240, 26970416, 28064961, 26970592, 26970768, 28065313, 6350171, 6350170, 6350522, 5255449, 31532248, 31532600, 5255625, 31532424, 31532776, 26970328, 26970504, 28065049, 26970680, 26970856, 28065401, 4495041, 30772192, 30771840, 4495129, 30772280, 30771928, 10151683, 10151682, 10152034, 31106241, 25449600, 25449688, 31106593, 25449952, 25450040, 4495217, 30772368, 30772016, 4495305, 30772456, 30772104, 10151859, 10151858, 10152210, 31106417, 25449776, 25449864, 31106769, 25450128, 25450216, 21648176, 21648000, 22742721, 21648264, 21648088, 22742809, 26544321, 20887768, 20887680, 26544497, 20887944, 20887856, 28399363, 28399362, 28399538, 21648528, 21648352, 22743073, 21648616, 21648440, 22743161, 26544673, 20888120, 20888032, 26544849, 20888296, 20888208, 28399715, 28399714, 28399890, 12006770, 12006769, 12007121, 2122609, 31532208, 31532560, 2122785, 31532384, 31532736, 26970288, 26970464, 11246449, 26970640, 26970816, 11246801, 6350127, 6350126, 6350478, 5255405, 31532204, 31532556, 5255581, 31532380, 31532732, 26970284, 26970460, 28065005, 26970636, 26970812, 28065357, 6350215, 6350214, 6350566, 5255493, 31532292, 31532644, 5255669, 31532468, 31532820, 26970372, 26970548, 28065093, 26970724, 26970900, 28065445, 4495085, 30772236, 30771884, 4495173, 30772324, 30771972, 10151727, 10151726, 10152078, 31106285, 25449644, 25449732, 31106637, 25449996, 25450084, 4495261, 30772412, 30772060, 4495349, 30772500, 30772148, 10151903, 10151902, 10152254, 31106461, 25449820, 25449908, 31106813, 25450172, 25450260, 21648220, 21648044, 22742765, 21648308, 21648132, 22742853, 26544365, 20887812, 20887724, 26544541, 20887988, 20887900, 28399407, 28399406, 28399582, 21648572, 21648396, 22743117, 21648660, 21648484, 22743205, 26544717, 20888164, 20888076, 26544893, 20888340, 20888252, 28399759, 28399758, 28399934]
def witnesses1_p0 : List (C2wrS6 × Fin 11) := codes1_p0.map decodeWitness

theorem chunk1_part0_len : chunk1_part0.length ≤ witnesses1_p0.length := by decide +kernel
theorem chunk1_part0_len_eq : chunk1_part0.length = 315 := by decide +kernel
theorem chunk1_part0_act_valid : (List.zip chunk1_part0 witnesses1_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses1_p0_valid : witnesses1_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk1_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk1_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk1_part0 witnesses1_p0 chunk1_part0_len chunk1_part0_act_valid witnesses1_p0_valid hm

def chunk1_part1 : List (List (Nat × Nat)) :=
  [6, 7, 8].flatMap fun y2 =>
    let rest := [3, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 2) :: (1, y2) :: m)

def codes1_p1 : List Nat := [6223363, 6223362, 6223714, 5128817, 26843520, 26843872, 5128641, 26843696, 26844048, 31405440, 31405616, 27938593, 31405792, 31405968, 27938241, 6223407, 6223406, 6223758, 5128861, 26843564, 26843916, 5128685, 26843740, 26844092, 31405484, 31405660, 27938637, 31405836, 31406012, 27938285, 12640326, 12640325, 12640677, 2629445, 31405444, 31405796, 2629621, 31405620, 31405972, 26843524, 26843700, 11753285, 26843876, 26844052, 11753637, 10658563, 31486401, 31486753, 4241601, 30518752, 30518400, 4241645, 25069792, 25069440, 30518796, 25069836, 10658562, 30518444, 25069484, 10658914, 10658739, 31486577, 31486929, 4241777, 30518928, 30518576, 4241821, 25069968, 25069616, 30518972, 25070012, 10658738, 30518620, 25069660, 10659090, 26924481, 26924657, 28906243, 21394736, 21394560, 22489281, 21394780, 28906242, 20507740, 21394604, 28906418, 20507564, 22489325, 20507696, 20507520, 26924833, 26925009, 28906595, 21395088, 21394912, 22489633, 21395132, 28906594, 20508092, 21394956, 28906770, 20507916, 22489677, 20508048, 20507872, 6223451, 6223450, 6223802, 5128905, 26843608, 26843960, 5128729, 26843784, 26844136, 31405528, 31405704, 27938681, 31405880, 31406056, 27938329, 6223495, 6223494, 6223846, 5128949, 26843652, 26844004, 5128773, 26843828, 26844180, 31405572, 31405748, 27938725, 31405924, 31406100, 27938373, 12640414, 12640413, 12640765, 2629533, 31405532, 31405884, 2629709, 31405708, 31406060, 26843612, 26843788, 11753373, 26843964, 26844140, 11753725, 10658651, 31486489, 31486841, 4241689, 30518840, 30518488, 4241733, 25069880, 25069528, 30518884, 25069924, 10658650, 30518532, 25069572, 10659002, 10658827, 31486665, 31487017, 4241865, 30519016, 30518664, 4241909, 25070056, 25069704, 30519060, 25070100, 10658826, 30518708, 25069748, 10659178, 26924569, 26924745, 28906331, 21394824, 21394648, 22489369, 21394868, 28906330, 20507828, 21394692, 28906506, 20507652, 22489413, 20507784, 20507608, 26924921, 26925097, 28906683, 21395176, 21395000, 22489721, 21395220, 28906682, 20508180, 21395044, 28906858, 20508004, 22489765, 20508136, 20507960, 3608089, 24562912, 24562560, 3608001, 24563000, 24562648, 9264643, 9264642, 9264994, 30219553, 29884800, 29884888, 30219201, 29885152, 29885240, 3608133, 24562956, 24562604, 3608045, 24563044, 24562692, 9264687, 9264686, 9265038, 30219597, 29884844, 29884932, 30219245, 29885196, 29885284, 9898243, 30726433, 30726081, 3481325, 24309472, 24309120, 3481281, 29758432, 29758080, 24309516, 29758476, 9898242, 24309164, 29758124, 9898594, 9898331, 30726521, 30726169, 3481413, 24309560, 24309208, 3481369, 29758520, 29758168, 24309604, 29758564, 9898330, 24309252, 29758212, 9898682, 15681606, 15681605, 15681957, 4910405, 29884804, 29885156, 4910493, 29884892, 29885244, 24562564, 24562652, 15554885, 24562916, 24563004, 15555237, 31187203, 25403841, 25403929, 31187202, 19113732, 18987012, 31187290, 19113644, 18986924, 19113688, 19113600, 24770241, 18986968, 18986880, 24770285, 31187555, 25404193, 25404281, 31187554, 19114084, 18987364, 31187642, 19113996, 18987276, 19114040, 19113952, 24770593, 18987320, 18987232, 24770637]
def witnesses1_p1 : List (C2wrS6 × Fin 11) := codes1_p1.map decodeWitness

theorem chunk1_part1_len : chunk1_part1.length ≤ witnesses1_p1.length := by decide +kernel
theorem chunk1_part1_len_eq : chunk1_part1.length = 315 := by decide +kernel
theorem chunk1_part1_act_valid : (List.zip chunk1_part1 witnesses1_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses1_p1_valid : witnesses1_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk1_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk1_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk1_part1 witnesses1_p1 chunk1_part1_len chunk1_part1_act_valid witnesses1_p1_valid hm

def chunk1_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [3, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 2) :: (1, y2) :: m)

def codes1_p2 : List Nat := [3608265, 24563088, 24562736, 3608177, 24563176, 24562824, 9264819, 9264818, 9265170, 30219729, 29884976, 29885064, 30219377, 29885328, 29885416, 3608309, 24563132, 24562780, 3608221, 24563220, 24562868, 9264863, 9264862, 9265214, 30219773, 29885020, 29885108, 30219421, 29885372, 29885460, 9898419, 30726609, 30726257, 3481501, 24309648, 24309296, 3481457, 29758608, 29758256, 24309692, 29758652, 9898418, 24309340, 29758300, 9898770, 9898507, 30726697, 30726345, 3481589, 24309736, 24309384, 3481545, 29758696, 29758344, 24309780, 29758740, 9898506, 24309428, 29758388, 9898858, 15681782, 15681781, 15682133, 4910581, 29884980, 29885332, 4910669, 29885068, 29885420, 24562740, 24562828, 15555061, 24563092, 24563180, 15555413, 31187379, 25404017, 25404105, 31187378, 19113908, 18987188, 31187466, 19113820, 18987100, 19113864, 19113776, 24770417, 18987144, 18987056, 24770461, 31187731, 25404369, 25404457, 31187730, 19114260, 18987540, 31187818, 19114172, 18987452, 19114216, 19114128, 24770769, 18987496, 18987408, 24770813, 15438896, 15438720, 17293849, 15438984, 15438808, 17293761, 21095537, 16199128, 16199040, 21095361, 16199304, 16199216, 22950403, 22950402, 22950578, 15438940, 15438764, 17293893, 15439028, 15438852, 17293805, 21095581, 16199172, 16199084, 21095405, 16199348, 16199260, 22950447, 22950446, 22950622, 21602417, 21602241, 23584003, 15185456, 15185280, 17167085, 15185500, 23584002, 16072540, 15185324, 23584178, 16072364, 17167041, 16072496, 16072320, 21602505, 21602329, 23584091, 15185544, 15185368, 17167173, 15185588, 23584090, 16072628, 15185412, 23584266, 16072452, 17167129, 16072584, 16072408, 26625283, 20842009, 20841921, 26625282, 14425092, 14551812, 26625370, 14425004, 14551724, 14425048, 14424960, 20208365, 14551768, 14551680, 20208321, 26625459, 20842185, 20842097, 26625458, 14425268, 14551988, 26625546, 14425180, 14551900, 14425224, 14425136, 20208541, 14551944, 14551856, 20208497, 29367366, 29367365, 29367541, 27720005, 16199044, 16199220, 27720093, 16199132, 16199308, 15438724, 15438812, 29240645, 15438900, 15438988, 29240821, 15439248, 15439072, 17294201, 15439336, 15439160, 17294113, 21095889, 16199480, 16199392, 21095713, 16199656, 16199568, 22950755, 22950754, 22950930, 15439292, 15439116, 17294245, 15439380, 15439204, 17294157, 21095933, 16199524, 16199436, 21095757, 16199700, 16199612, 22950799, 22950798, 22950974, 21602769, 21602593, 23584355, 15185808, 15185632, 17167437, 15185852, 23584354, 16072892, 15185676, 23584530, 16072716, 17167393, 16072848, 16072672, 21602857, 21602681, 23584443, 15185896, 15185720, 17167525, 15185940, 23584442, 16072980, 15185764, 23584618, 16072804, 17167481, 16072936, 16072760, 26625635, 20842361, 20842273, 26625634, 14425444, 14552164, 26625722, 14425356, 14552076, 14425400, 14425312, 20208717, 14552120, 14552032, 20208673, 26625811, 20842537, 20842449, 26625810, 14425620, 14552340, 26625898, 14425532, 14552252, 14425576, 14425488, 20208893, 14552296, 14552208, 20208849, 29367718, 29367717, 29367893, 27720357, 16199396, 16199572, 27720445, 16199484, 16199660, 15439076, 15439164, 29240997, 15439252, 15439340, 29241173]
def witnesses1_p2 : List (C2wrS6 × Fin 11) := codes1_p2.map decodeWitness

theorem chunk1_part2_len : chunk1_part2.length ≤ witnesses1_p2.length := by decide +kernel
theorem chunk1_part2_len_eq : chunk1_part2.length = 315 := by decide +kernel
theorem chunk1_part2_act_valid : (List.zip chunk1_part2 witnesses1_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses1_p2_valid : witnesses1_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk1_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk1_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk1_part2 witnesses1_p2 chunk1_part2_len chunk1_part2_act_valid witnesses1_p2_valid hm

def chunk1 : List (List (Nat × Nat)) :=
  chunk1_part0 ++ (chunk1_part1 ++ chunk1_part2)

theorem chunk1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk1] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk1_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk1_part1_coverage m h1
  · exact chunk1_part2_coverage m h2

theorem chunk1_len : chunk1.length = 945 := by
  dsimp [chunk1]
  repeat rw [List.length_append]
  rw [chunk1_part0_len_eq, chunk1_part1_len_eq, chunk1_part2_len_eq]

def chunk2_part0 : List (List (Nat × Nat)) :=
  [2, 4, 5].flatMap fun y2 =>
    let rest := [2, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 3) :: (1, y2) :: m)

def codes2_p0 : List Nat := [18423711, 31187230, 31187582, 10658590, 31486427, 31486779, 10658766, 31486603, 31486955, 26924507, 26924683, 28906270, 26924859, 26925035, 28906622, 6350110, 31532189, 31532541, 5255387, 31532184, 31532536, 5255563, 31532360, 31532712, 26970264, 26970440, 28064987, 26970616, 26970792, 28065339, 6350198, 31532277, 31532629, 5255475, 31532272, 31532624, 5255651, 31532448, 31532800, 26970352, 26970528, 28065075, 26970704, 26970880, 28065427, 4495067, 30772216, 30771864, 4495155, 30772304, 30771952, 10151710, 30771869, 30772221, 31106267, 25449624, 25449712, 31106619, 25449976, 25450064, 4495243, 30772392, 30772040, 4495331, 30772480, 30772128, 10151886, 30772045, 30772397, 31106443, 25449800, 25449888, 31106795, 25450152, 25450240, 21648200, 21648024, 22742747, 21648288, 21648112, 22742835, 26544347, 20887792, 20887704, 26544523, 20887968, 20887880, 28399390, 21648029, 21648205, 21648552, 21648376, 22743099, 21648640, 21648464, 22743187, 26544699, 20888144, 20888056, 26544875, 20888320, 20888232, 28399742, 21648381, 21648557, 12006748, 12006747, 12007099, 2122587, 31532186, 31532538, 2122763, 31532362, 31532714, 26970266, 26970442, 11246427, 26970618, 26970794, 11246779, 6350105, 6350104, 6350456, 5255383, 31532182, 31532534, 5255559, 31532358, 31532710, 26970262, 26970438, 28064983, 26970614, 26970790, 28065335, 6350193, 6350192, 6350544, 5255471, 31532270, 31532622, 5255647, 31532446, 31532798, 26970350, 26970526, 28065071, 26970702, 26970878, 28065423, 4495063, 30772214, 30771862, 4495151, 30772302, 30771950, 10151705, 10151704, 10152056, 31106263, 25449622, 25449710, 31106615, 25449974, 25450062, 4495239, 30772390, 30772038, 4495327, 30772478, 30772126, 10151881, 10151880, 10152232, 31106439, 25449798, 25449886, 31106791, 25450150, 25450238, 21648198, 21648022, 22742743, 21648286, 21648110, 22742831, 26544343, 20887790, 20887702, 26544519, 20887966, 20887878, 28399385, 28399384, 28399560, 21648550, 21648374, 22743095, 21648638, 21648462, 22743183, 26544695, 20888142, 20888054, 26544871, 20888318, 20888230, 28399737, 28399736, 28399912, 12006792, 12006791, 12007143, 2122631, 31532230, 31532582, 2122807, 31532406, 31532758, 26970310, 26970486, 11246471, 26970662, 26970838, 11246823, 6350149, 6350148, 6350500, 5255427, 31532226, 31532578, 5255603, 31532402, 31532754, 26970306, 26970482, 28065027, 26970658, 26970834, 28065379, 6350237, 6350236, 6350588, 5255515, 31532314, 31532666, 5255691, 31532490, 31532842, 26970394, 26970570, 28065115, 26970746, 26970922, 28065467, 4495107, 30772258, 30771906, 4495195, 30772346, 30771994, 10151749, 10151748, 10152100, 31106307, 25449666, 25449754, 31106659, 25450018, 25450106, 4495283, 30772434, 30772082, 4495371, 30772522, 30772170, 10151925, 10151924, 10152276, 31106483, 25449842, 25449930, 31106835, 25450194, 25450282, 21648242, 21648066, 22742787, 21648330, 21648154, 22742875, 26544387, 20887834, 20887746, 26544563, 20888010, 20887922, 28399429, 28399428, 28399604, 21648594, 21648418, 22743139, 21648682, 21648506, 22743227, 26544739, 20888186, 20888098, 26544915, 20888362, 20888274, 28399781, 28399780, 28399956]
def witnesses2_p0 : List (C2wrS6 × Fin 11) := codes2_p0.map decodeWitness

theorem chunk2_part0_len : chunk2_part0.length ≤ witnesses2_p0.length := by decide +kernel
theorem chunk2_part0_len_eq : chunk2_part0.length = 315 := by decide +kernel
theorem chunk2_part0_act_valid : (List.zip chunk2_part0 witnesses2_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses2_p0_valid : witnesses2_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk2_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk2_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk2_part0 witnesses2_p0 chunk2_part0_len chunk2_part0_act_valid witnesses2_p0_valid hm

def chunk2_part1 : List (List (Nat × Nat)) :=
  [6, 7, 8].flatMap fun y2 =>
    let rest := [2, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 3) :: (1, y2) :: m)

def codes2_p1 : List Nat := [6223385, 6223384, 6223736, 5128839, 26843542, 26843894, 5128663, 26843718, 26844070, 31405462, 31405638, 27938615, 31405814, 31405990, 27938263, 6223429, 6223428, 6223780, 5128883, 26843586, 26843938, 5128707, 26843762, 26844114, 31405506, 31405682, 27938659, 31405858, 31406034, 27938307, 12640348, 12640347, 12640699, 2629467, 31405466, 31405818, 2629643, 31405642, 31405994, 26843546, 26843722, 11753307, 26843898, 26844074, 11753659, 10658585, 31486423, 31486775, 4241623, 30518774, 30518422, 4241667, 25069814, 25069462, 30518818, 25069858, 10658584, 30518466, 25069506, 10658936, 10658761, 31486599, 31486951, 4241799, 30518950, 30518598, 4241843, 25069990, 25069638, 30518994, 25070034, 10658760, 30518642, 25069682, 10659112, 26924503, 26924679, 28906265, 21394758, 21394582, 22489303, 21394802, 28906264, 20507762, 21394626, 28906440, 20507586, 22489347, 20507718, 20507542, 26924855, 26925031, 28906617, 21395110, 21394934, 22489655, 21395154, 28906616, 20508114, 21394978, 28906792, 20507938, 22489699, 20508070, 20507894, 6223473, 6223472, 6223824, 5128927, 26843630, 26843982, 5128751, 26843806, 26844158, 31405550, 31405726, 27938703, 31405902, 31406078, 27938351, 6223517, 6223516, 6223868, 5128971, 26843674, 26844026, 5128795, 26843850, 26844202, 31405594, 31405770, 27938747, 31405946, 31406122, 27938395, 12640436, 12640435, 12640787, 2629555, 31405554, 31405906, 2629731, 31405730, 31406082, 26843634, 26843810, 11753395, 26843986, 26844162, 11753747, 10658673, 31486511, 31486863, 4241711, 30518862, 30518510, 4241755, 25069902, 25069550, 30518906, 25069946, 10658672, 30518554, 25069594, 10659024, 10658849, 31486687, 31487039, 4241887, 30519038, 30518686, 4241931, 25070078, 25069726, 30519082, 25070122, 10658848, 30518730, 25069770, 10659200, 26924591, 26924767, 28906353, 21394846, 21394670, 22489391, 21394890, 28906352, 20507850, 21394714, 28906528, 20507674, 22489435, 20507806, 20507630, 26924943, 26925119, 28906705, 21395198, 21395022, 22489743, 21395242, 28906704, 20508202, 21395066, 28906880, 20508026, 22489787, 20508158, 20507982, 3608111, 24562934, 24562582, 3608023, 24563022, 24562670, 9264665, 9264664, 9265016, 30219575, 29884822, 29884910, 30219223, 29885174, 29885262, 3608155, 24562978, 24562626, 3608067, 24563066, 24562714, 9264709, 9264708, 9265060, 30219619, 29884866, 29884954, 30219267, 29885218, 29885306, 9898265, 30726455, 30726103, 3481347, 24309494, 24309142, 3481303, 29758454, 29758102, 24309538, 29758498, 9898264, 24309186, 29758146, 9898616, 9898353, 30726543, 30726191, 3481435, 24309582, 24309230, 3481391, 29758542, 29758190, 24309626, 29758586, 9898352, 24309274, 29758234, 9898704, 15681628, 15681627, 15681979, 4910427, 29884826, 29885178, 4910515, 29884914, 29885266, 24562586, 24562674, 15554907, 24562938, 24563026, 15555259, 31187225, 25403863, 25403951, 31187224, 19113754, 18987034, 31187312, 19113666, 18986946, 19113710, 19113622, 24770263, 18986990, 18986902, 24770307, 31187577, 25404215, 25404303, 31187576, 19114106, 18987386, 31187664, 19114018, 18987298, 19114062, 19113974, 24770615, 18987342, 18987254, 24770659]
def witnesses2_p1 : List (C2wrS6 × Fin 11) := codes2_p1.map decodeWitness

theorem chunk2_part1_len : chunk2_part1.length ≤ witnesses2_p1.length := by decide +kernel
theorem chunk2_part1_len_eq : chunk2_part1.length = 315 := by decide +kernel
theorem chunk2_part1_act_valid : (List.zip chunk2_part1 witnesses2_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses2_p1_valid : witnesses2_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk2_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk2_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk2_part1 witnesses2_p1 chunk2_part1_len chunk2_part1_act_valid witnesses2_p1_valid hm

def chunk2_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [2, 4, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 3) :: (1, y2) :: m)

def codes2_p2 : List Nat := [3608287, 24563110, 24562758, 3608199, 24563198, 24562846, 9264841, 9264840, 9265192, 30219751, 29884998, 29885086, 30219399, 29885350, 29885438, 3608331, 24563154, 24562802, 3608243, 24563242, 24562890, 9264885, 9264884, 9265236, 30219795, 29885042, 29885130, 30219443, 29885394, 29885482, 9898441, 30726631, 30726279, 3481523, 24309670, 24309318, 3481479, 29758630, 29758278, 24309714, 29758674, 9898440, 24309362, 29758322, 9898792, 9898529, 30726719, 30726367, 3481611, 24309758, 24309406, 3481567, 29758718, 29758366, 24309802, 29758762, 9898528, 24309450, 29758410, 9898880, 15681804, 15681803, 15682155, 4910603, 29885002, 29885354, 4910691, 29885090, 29885442, 24562762, 24562850, 15555083, 24563114, 24563202, 15555435, 31187401, 25404039, 25404127, 31187400, 19113930, 18987210, 31187488, 19113842, 18987122, 19113886, 19113798, 24770439, 18987166, 18987078, 24770483, 31187753, 25404391, 25404479, 31187752, 19114282, 18987562, 31187840, 19114194, 18987474, 19114238, 19114150, 24770791, 18987518, 18987430, 24770835, 15438918, 15438742, 17293871, 15439006, 15438830, 17293783, 21095559, 16199150, 16199062, 21095383, 16199326, 16199238, 22950425, 22950424, 22950600, 15438962, 15438786, 17293915, 15439050, 15438874, 17293827, 21095603, 16199194, 16199106, 21095427, 16199370, 16199282, 22950469, 22950468, 22950644, 21602439, 21602263, 23584025, 15185478, 15185302, 17167107, 15185522, 23584024, 16072562, 15185346, 23584200, 16072386, 17167063, 16072518, 16072342, 21602527, 21602351, 23584113, 15185566, 15185390, 17167195, 15185610, 23584112, 16072650, 15185434, 23584288, 16072474, 17167151, 16072606, 16072430, 26625305, 20842031, 20841943, 26625304, 14425114, 14551834, 26625392, 14425026, 14551746, 14425070, 14424982, 20208387, 14551790, 14551702, 20208343, 26625481, 20842207, 20842119, 26625480, 14425290, 14552010, 26625568, 14425202, 14551922, 14425246, 14425158, 20208563, 14551966, 14551878, 20208519, 29367388, 29367387, 29367563, 27720027, 16199066, 16199242, 27720115, 16199154, 16199330, 15438746, 15438834, 29240667, 15438922, 15439010, 29240843, 15439270, 15439094, 17294223, 15439358, 15439182, 17294135, 21095911, 16199502, 16199414, 21095735, 16199678, 16199590, 22950777, 22950776, 22950952, 15439314, 15439138, 17294267, 15439402, 15439226, 17294179, 21095955, 16199546, 16199458, 21095779, 16199722, 16199634, 22950821, 22950820, 22950996, 21602791, 21602615, 23584377, 15185830, 15185654, 17167459, 15185874, 23584376, 16072914, 15185698, 23584552, 16072738, 17167415, 16072870, 16072694, 21602879, 21602703, 23584465, 15185918, 15185742, 17167547, 15185962, 23584464, 16073002, 15185786, 23584640, 16072826, 17167503, 16072958, 16072782, 26625657, 20842383, 20842295, 26625656, 14425466, 14552186, 26625744, 14425378, 14552098, 14425422, 14425334, 20208739, 14552142, 14552054, 20208695, 26625833, 20842559, 20842471, 26625832, 14425642, 14552362, 26625920, 14425554, 14552274, 14425598, 14425510, 20208915, 14552318, 14552230, 20208871, 29367740, 29367739, 29367915, 27720379, 16199418, 16199594, 27720467, 16199506, 16199682, 15439098, 15439186, 29241019, 15439274, 15439362, 29241195]
def witnesses2_p2 : List (C2wrS6 × Fin 11) := codes2_p2.map decodeWitness

theorem chunk2_part2_len : chunk2_part2.length ≤ witnesses2_p2.length := by decide +kernel
theorem chunk2_part2_len_eq : chunk2_part2.length = 315 := by decide +kernel
theorem chunk2_part2_act_valid : (List.zip chunk2_part2 witnesses2_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses2_p2_valid : witnesses2_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk2_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk2_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk2_part2 witnesses2_p2 chunk2_part2_len chunk2_part2_act_valid witnesses2_p2_valid hm

def chunk2 : List (List (Nat × Nat)) :=
  chunk2_part0 ++ (chunk2_part1 ++ chunk2_part2)

theorem chunk2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk2] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk2_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk2_part1_coverage m h1
  · exact chunk2_part2_coverage m h2

theorem chunk2_len : chunk2.length = 945 := by
  dsimp [chunk2]
  repeat rw [List.length_append]
  rw [chunk2_part0_len_eq, chunk2_part1_len_eq, chunk2_part2_len_eq]

def chunk3_part0 : List (List (Nat × Nat)) :=
  [2, 3, 5].flatMap fun y2 =>
    let rest := [2, 3, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 4) :: (1, y2) :: m)

def codes3_p0 : List Nat := [11985606, 11985605, 11985957, 2101445, 31511044, 31511396, 2101621, 31511220, 31511572, 26949124, 26949300, 11225285, 26949476, 26949652, 11225637, 6329051, 6329050, 6329402, 4473921, 30751072, 30750720, 4474097, 30751248, 30750896, 21627056, 21626880, 22721601, 21627408, 21627232, 22721953, 6328963, 6328962, 6329314, 4474009, 30751160, 30750808, 4474185, 30751336, 30750984, 21627144, 21626968, 22721689, 21627496, 21627320, 22722041, 5234241, 31511040, 31511392, 5234329, 31511128, 31511480, 10130739, 10130738, 10131090, 26523201, 20866648, 20866560, 26523553, 20867000, 20866912, 5234417, 31511216, 31511568, 5234505, 31511304, 31511656, 10130563, 10130562, 10130914, 26523377, 20866824, 20866736, 26523729, 20867176, 20867088, 26949120, 26949296, 28043841, 26949208, 26949384, 28043929, 31085121, 25428480, 25428568, 31085297, 25428656, 25428744, 28378595, 28378594, 28378770, 26949472, 26949648, 28044193, 26949560, 26949736, 28044281, 31085473, 25428832, 25428920, 31085649, 25429008, 25429096, 28378243, 28378242, 28378418, 11985628, 11985627, 11985979, 2101467, 31511066, 31511418, 2101643, 31511242, 31511594, 26949146, 26949322, 11225307, 26949498, 26949674, 11225659, 6329073, 6329072, 6329424, 4473943, 30751094, 30750742, 4474119, 30751270, 30750918, 21627078, 21626902, 22721623, 21627430, 21627254, 22721975, 6328985, 6328984, 6329336, 4474031, 30751182, 30750830, 4474207, 30751358, 30751006, 21627166, 21626990, 22721711, 21627518, 21627342, 22722063, 5234263, 31511062, 31511414, 5234351, 31511150, 31511502, 10130761, 10130760, 10131112, 26523223, 20866670, 20866582, 26523575, 20867022, 20866934, 5234439, 31511238, 31511590, 5234527, 31511326, 31511678, 10130585, 10130584, 10130936, 26523399, 20866846, 20866758, 26523751, 20867198, 20867110, 26949142, 26949318, 28043863, 26949230, 26949406, 28043951, 31085143, 25428502, 25428590, 31085319, 25428678, 25428766, 28378617, 28378616, 28378792, 26949494, 26949670, 28044215, 26949582, 26949758, 28044303, 31085495, 25428854, 25428942, 31085671, 25429030, 25429118, 28378265, 28378264, 28378440, 18529289, 31250568, 31250920, 10721928, 31528645, 31528997, 10722104, 31528821, 31529173, 26966725, 26966901, 28969608, 26967077, 26967253, 28969960, 6328968, 31511047, 31511399, 5234245, 31511042, 31511394, 5234421, 31511218, 31511570, 26949122, 26949298, 28043845, 26949474, 26949650, 28044197, 6329056, 31511135, 31511487, 5234333, 31511130, 31511482, 5234509, 31511306, 31511658, 26949210, 26949386, 28043933, 26949562, 26949738, 28044285, 4473925, 30751074, 30750722, 4474013, 30751162, 30750810, 10130568, 30750727, 30751079, 31085125, 25428482, 25428570, 31085477, 25428834, 25428922, 4474101, 30751250, 30750898, 4474189, 30751338, 30750986, 10130744, 30750903, 30751255, 31085301, 25428658, 25428746, 31085653, 25429010, 25429098, 21627058, 21626882, 22721605, 21627146, 21626970, 22721693, 26523205, 20866650, 20866562, 26523381, 20866826, 20866738, 28378248, 21626887, 21627063, 21627410, 21627234, 22721957, 21627498, 21627322, 22722045, 26523557, 20867002, 20866914, 26523733, 20867178, 20867090, 28378600, 21627239, 21627415]
def witnesses3_p0 : List (C2wrS6 × Fin 11) := codes3_p0.map decodeWitness

theorem chunk3_part0_len : chunk3_part0.length ≤ witnesses3_p0.length := by decide +kernel
theorem chunk3_part0_len_eq : chunk3_part0.length = 315 := by decide +kernel
theorem chunk3_part0_act_valid : (List.zip chunk3_part0 witnesses3_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses3_p0_valid : witnesses3_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk3_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk3_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk3_part0 witnesses3_p0 chunk3_part0_len chunk3_part0_act_valid witnesses3_p0_valid hm

def chunk3_part1 : List (List (Nat × Nat)) :=
  [6, 7, 8].flatMap fun y2 =>
    let rest := [2, 3, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 4) :: (1, y2) :: m)

def codes3_p1 : List Nat := [12724806, 12724805, 12725157, 10721923, 31528641, 31528993, 10722099, 31528817, 31529169, 26966721, 26966897, 28969603, 26967073, 26967249, 28969955, 6181123, 6181122, 6181474, 5086577, 26801280, 26801632, 5086401, 26801456, 26801808, 31363200, 31363376, 27896353, 31363552, 31363728, 27896001, 6181145, 6181144, 6181496, 4178417, 21331376, 21331728, 4178241, 21331200, 21331552, 30455392, 30455568, 22426273, 30455040, 30455216, 22425921, 5086599, 26801302, 26801654, 4178439, 21331398, 21331750, 2692805, 28969602, 28969954, 31363204, 24985488, 20423590, 31363556, 24985136, 20423238, 5086423, 26801478, 26801830, 4178263, 21331222, 21331574, 2692981, 28969778, 28970130, 31363380, 24985312, 20423414, 31363732, 24984960, 20423062, 31363222, 31363398, 27896375, 30455414, 30455590, 22426295, 26801284, 24985510, 20423568, 26801460, 24985334, 20423392, 11816645, 10721922, 10722098, 31363574, 31363750, 27896023, 30455062, 30455238, 22425943, 26801636, 24985158, 20423216, 26801812, 24984982, 20423040, 11816997, 10722274, 10722450, 12724894, 12724893, 12725245, 10722011, 31528729, 31529081, 10722187, 31528905, 31529257, 26966809, 26966985, 28969691, 26967161, 26967337, 28970043, 6181211, 6181210, 6181562, 5086665, 26801368, 26801720, 5086489, 26801544, 26801896, 31363288, 31363464, 27896441, 31363640, 31363816, 27896089, 6181233, 6181232, 6181584, 4178505, 21331464, 21331816, 4178329, 21331288, 21331640, 30455480, 30455656, 22426361, 30455128, 30455304, 22426009, 5086687, 26801390, 26801742, 4178527, 21331486, 21331838, 2692893, 28969690, 28970042, 31363292, 24985576, 20423678, 31363644, 24985224, 20423326, 5086511, 26801566, 26801918, 4178351, 21331310, 21331662, 2693069, 28969866, 28970218, 31363468, 24985400, 20423502, 31363820, 24985048, 20423150, 31363310, 31363486, 27896463, 30455502, 30455678, 22426383, 26801372, 24985598, 20423656, 26801548, 24985422, 20423480, 11816733, 10722010, 10722186, 31363662, 31363838, 27896111, 30455150, 30455326, 22426031, 26801724, 24985246, 20423304, 26801900, 24985070, 20423128, 11817085, 10722362, 10722538, 9961603, 30768673, 30768321, 9961691, 30768761, 30768409, 15766086, 15766085, 15766437, 31250563, 25446081, 25446169, 31250915, 25446433, 25446521, 3565849, 24520672, 24520320, 3565761, 24520760, 24520408, 9222403, 9222402, 9222754, 30177313, 29842560, 29842648, 30176961, 29842912, 29843000, 3565871, 24520694, 24520342, 4973765, 31250562, 31250914, 3418031, 19050350, 19050702, 24225080, 29842564, 18902862, 24224728, 29842916, 18902510, 3565783, 24520782, 24520430, 4973853, 31250650, 31251002, 3417943, 19050262, 19050614, 24224992, 29842652, 18902774, 24224640, 29843004, 18902422, 9222425, 9222424, 9222776, 3418009, 19050328, 19050680, 3417921, 19050240, 19050592, 29695072, 29695160, 24707233, 29694720, 29694808, 24706881, 30177335, 29842582, 29842670, 24225102, 24520324, 18902840, 24225014, 24520412, 18902752, 29695094, 29695182, 24707255, 9961602, 9961690, 15618245, 30176983, 29842934, 29843022, 24224750, 24520676, 18902488, 24224662, 24520764, 18902400, 29694742, 29694830, 24706903, 9961954, 9962042, 15618597]
def witnesses3_p1 : List (C2wrS6 × Fin 11) := codes3_p1.map decodeWitness

theorem chunk3_part1_len : chunk3_part1.length ≤ witnesses3_p1.length := by decide +kernel
theorem chunk3_part1_len_eq : chunk3_part1.length = 315 := by decide +kernel
theorem chunk3_part1_act_valid : (List.zip chunk3_part1 witnesses3_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses3_p1_valid : witnesses3_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk3_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk3_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk3_part1 witnesses3_p1 chunk3_part1_len chunk3_part1_act_valid witnesses3_p1_valid hm

def chunk3_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [2, 3, 5, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 4) :: (1, y2) :: m)

def codes3_p2 : List Nat := [9961779, 30768849, 30768497, 9961867, 30768937, 30768585, 15766262, 15766261, 15766613, 31250739, 25446257, 25446345, 31251091, 25446609, 25446697, 3566025, 24520848, 24520496, 3565937, 24520936, 24520584, 9222579, 9222578, 9222930, 30177489, 29842736, 29842824, 30177137, 29843088, 29843176, 3566047, 24520870, 24520518, 4973941, 31250738, 31251090, 3418207, 19050526, 19050878, 24225256, 29842740, 18903038, 24224904, 29843092, 18902686, 3565959, 24520958, 24520606, 4974029, 31250826, 31251178, 3418119, 19050438, 19050790, 24225168, 29842828, 18902950, 24224816, 29843180, 18902598, 9222601, 9222600, 9222952, 3418185, 19050504, 19050856, 3418097, 19050416, 19050768, 29695248, 29695336, 24707409, 29694896, 29694984, 24707057, 30177511, 29842758, 29842846, 24225278, 24520500, 18903016, 24225190, 24520588, 18902928, 29695270, 29695358, 24707431, 9961778, 9961866, 15618421, 30177159, 29843110, 29843198, 24224926, 24520852, 18902664, 24224838, 24520940, 18902576, 29694918, 29695006, 24707079, 9962130, 9962218, 15618773, 21644657, 21644481, 23647363, 21644745, 21644569, 23647451, 26688643, 20884249, 20884161, 26688819, 20884425, 20884337, 29451846, 29451845, 29452021, 15396656, 15396480, 17251609, 15396744, 15396568, 17251521, 21053297, 16156888, 16156800, 21053121, 16157064, 16156976, 22908163, 22908162, 22908338, 15396678, 15396502, 17251631, 26688642, 26688818, 27783365, 15101064, 14340766, 16156804, 15100888, 14340590, 16156980, 17103791, 14488430, 14488606, 15396766, 15396590, 17251543, 26688730, 26688906, 27783453, 15100976, 14340678, 16156892, 15100800, 14340502, 16157068, 17103703, 14488342, 14488518, 21053319, 16156910, 16156822, 15101086, 14340744, 15396484, 15100998, 14340656, 15396572, 23647362, 23647450, 29304005, 16009158, 16009246, 20145159, 21053143, 16157086, 16156998, 15100910, 14340568, 15396660, 15100822, 14340480, 15396748, 23647538, 23647626, 29304181, 16008982, 16009070, 20144983, 22908185, 22908184, 22908360, 17103769, 14488408, 14488584, 17103681, 14488320, 14488496, 16009136, 16009224, 20145137, 16008960, 16009048, 20144961, 21645009, 21644833, 23647715, 21645097, 21644921, 23647803, 26688995, 20884601, 20884513, 26689171, 20884777, 20884689, 29452198, 29452197, 29452373, 15397008, 15396832, 17251961, 15397096, 15396920, 17251873, 21053649, 16157240, 16157152, 21053473, 16157416, 16157328, 22908515, 22908514, 22908690, 15397030, 15396854, 17251983, 26688994, 26689170, 27783717, 15101416, 14341118, 16157156, 15101240, 14340942, 16157332, 17104143, 14488782, 14488958, 15397118, 15396942, 17251895, 26689082, 26689258, 27783805, 15101328, 14341030, 16157244, 15101152, 14340854, 16157420, 17104055, 14488694, 14488870, 21053671, 16157262, 16157174, 15101438, 14341096, 15396836, 15101350, 14341008, 15396924, 23647714, 23647802, 29304357, 16009510, 16009598, 20145511, 21053495, 16157438, 16157350, 15101262, 14340920, 15397012, 15101174, 14340832, 15397100, 23647890, 23647978, 29304533, 16009334, 16009422, 20145335, 22908537, 22908536, 22908712, 17104121, 14488760, 14488936, 17104033, 14488672, 14488848, 16009488, 16009576, 20145489, 16009312, 16009400, 20145313]
def witnesses3_p2 : List (C2wrS6 × Fin 11) := codes3_p2.map decodeWitness

theorem chunk3_part2_len : chunk3_part2.length ≤ witnesses3_p2.length := by decide +kernel
theorem chunk3_part2_len_eq : chunk3_part2.length = 315 := by decide +kernel
theorem chunk3_part2_act_valid : (List.zip chunk3_part2 witnesses3_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses3_p2_valid : witnesses3_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk3_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk3_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk3_part2 witnesses3_p2 chunk3_part2_len chunk3_part2_act_valid witnesses3_p2_valid hm

def chunk3 : List (List (Nat × Nat)) :=
  chunk3_part0 ++ (chunk3_part1 ++ chunk3_part2)

theorem chunk3_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk3) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk3] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk3_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk3_part1_coverage m h1
  · exact chunk3_part2_coverage m h2

theorem chunk3_len : chunk3.length = 945 := by
  dsimp [chunk3]
  repeat rw [List.length_append]
  rw [chunk3_part0_len_eq, chunk3_part1_len_eq, chunk3_part2_len_eq]

def chunk4_part0 : List (List (Nat × Nat)) :=
  [2, 3, 4].flatMap fun y2 =>
    let rest := [2, 3, 4, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 5) :: (1, y2) :: m)

def codes4_p0 : List Nat := [11985650, 11985649, 11986001, 2101489, 31511088, 31511440, 2101665, 31511264, 31511616, 26949168, 26949344, 11225329, 26949520, 26949696, 11225681, 6329095, 6329094, 6329446, 4473965, 30751116, 30750764, 4474141, 30751292, 30750940, 21627100, 21626924, 22721645, 21627452, 21627276, 22721997, 6329007, 6329006, 6329358, 4474053, 30751204, 30750852, 4474229, 30751380, 30751028, 21627188, 21627012, 22721733, 21627540, 21627364, 22722085, 5234285, 31511084, 31511436, 5234373, 31511172, 31511524, 10130783, 10130782, 10131134, 26523245, 20866692, 20866604, 26523597, 20867044, 20866956, 5234461, 31511260, 31511612, 5234549, 31511348, 31511700, 10130607, 10130606, 10130958, 26523421, 20866868, 20866780, 26523773, 20867220, 20867132, 26949164, 26949340, 28043885, 26949252, 26949428, 28043973, 31085165, 25428524, 25428612, 31085341, 25428700, 25428788, 28378639, 28378638, 28378814, 26949516, 26949692, 28044237, 26949604, 26949780, 28044325, 31085517, 25428876, 25428964, 31085693, 25429052, 25429140, 28378287, 28378286, 28378462, 11985672, 11985671, 11986023, 2101511, 31511110, 31511462, 2101687, 31511286, 31511638, 26949190, 26949366, 11225351, 26949542, 26949718, 11225703, 6329117, 6329116, 6329468, 4473987, 30751138, 30750786, 4474163, 30751314, 30750962, 21627122, 21626946, 22721667, 21627474, 21627298, 22722019, 6329029, 6329028, 6329380, 4474075, 30751226, 30750874, 4474251, 30751402, 30751050, 21627210, 21627034, 22721755, 21627562, 21627386, 22722107, 5234307, 31511106, 31511458, 5234395, 31511194, 31511546, 10130805, 10130804, 10131156, 26523267, 20866714, 20866626, 26523619, 20867066, 20866978, 5234483, 31511282, 31511634, 5234571, 31511370, 31511722, 10130629, 10130628, 10130980, 26523443, 20866890, 20866802, 26523795, 20867242, 20867154, 26949186, 26949362, 28043907, 26949274, 26949450, 28043995, 31085187, 25428546, 25428634, 31085363, 25428722, 25428810, 28378661, 28378660, 28378836, 26949538, 26949714, 28044259, 26949626, 26949802, 28044347, 31085539, 25428898, 25428986, 31085715, 25429074, 25429162, 28378309, 28378308, 28378484, 18529333, 31250612, 31250964, 10721972, 31528689, 31529041, 10722148, 31528865, 31529217, 26966769, 26966945, 28969652, 26967121, 26967297, 28970004, 6329012, 31511091, 31511443, 5234289, 31511086, 31511438, 5234465, 31511262, 31511614, 26949166, 26949342, 28043889, 26949518, 26949694, 28044241, 6329100, 31511179, 31511531, 5234377, 31511174, 31511526, 5234553, 31511350, 31511702, 26949254, 26949430, 28043977, 26949606, 26949782, 28044329, 4473969, 30751118, 30750766, 4474057, 30751206, 30750854, 10130612, 30750771, 30751123, 31085169, 25428526, 25428614, 31085521, 25428878, 25428966, 4474145, 30751294, 30750942, 4474233, 30751382, 30751030, 10130788, 30750947, 30751299, 31085345, 25428702, 25428790, 31085697, 25429054, 25429142, 21627102, 21626926, 22721649, 21627190, 21627014, 22721737, 26523249, 20866694, 20866606, 26523425, 20866870, 20866782, 28378292, 21626931, 21627107, 21627454, 21627278, 22722001, 21627542, 21627366, 22722089, 26523601, 20867046, 20866958, 26523777, 20867222, 20867134, 28378644, 21627283, 21627459]
def witnesses4_p0 : List (C2wrS6 × Fin 11) := codes4_p0.map decodeWitness

theorem chunk4_part0_len : chunk4_part0.length ≤ witnesses4_p0.length := by decide +kernel
theorem chunk4_part0_len_eq : chunk4_part0.length = 315 := by decide +kernel
theorem chunk4_part0_act_valid : (List.zip chunk4_part0 witnesses4_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses4_p0_valid : witnesses4_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk4_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk4_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk4_part0 witnesses4_p0 chunk4_part0_len chunk4_part0_act_valid witnesses4_p0_valid hm

def chunk4_part1 : List (List (Nat × Nat)) :=
  [6, 7, 8].flatMap fun y2 =>
    let rest := [2, 3, 4, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 5) :: (1, y2) :: m)

def codes4_p1 : List Nat := [12724850, 12724849, 12725201, 10721967, 31528685, 31529037, 10722143, 31528861, 31529213, 26966765, 26966941, 28969647, 26967117, 26967293, 28969999, 6181167, 6181166, 6181518, 5086621, 26801324, 26801676, 5086445, 26801500, 26801852, 31363244, 31363420, 27896397, 31363596, 31363772, 27896045, 6181189, 6181188, 6181540, 4178461, 21331420, 21331772, 4178285, 21331244, 21331596, 30455436, 30455612, 22426317, 30455084, 30455260, 22425965, 5086643, 26801346, 26801698, 4178483, 21331442, 21331794, 2692849, 28969646, 28969998, 31363248, 24985532, 20423634, 31363600, 24985180, 20423282, 5086467, 26801522, 26801874, 4178307, 21331266, 21331618, 2693025, 28969822, 28970174, 31363424, 24985356, 20423458, 31363776, 24985004, 20423106, 31363266, 31363442, 27896419, 30455458, 30455634, 22426339, 26801328, 24985554, 20423612, 26801504, 24985378, 20423436, 11816689, 10721966, 10722142, 31363618, 31363794, 27896067, 30455106, 30455282, 22425987, 26801680, 24985202, 20423260, 26801856, 24985026, 20423084, 11817041, 10722318, 10722494, 12724938, 12724937, 12725289, 10722055, 31528773, 31529125, 10722231, 31528949, 31529301, 26966853, 26967029, 28969735, 26967205, 26967381, 28970087, 6181255, 6181254, 6181606, 5086709, 26801412, 26801764, 5086533, 26801588, 26801940, 31363332, 31363508, 27896485, 31363684, 31363860, 27896133, 6181277, 6181276, 6181628, 4178549, 21331508, 21331860, 4178373, 21331332, 21331684, 30455524, 30455700, 22426405, 30455172, 30455348, 22426053, 5086731, 26801434, 26801786, 4178571, 21331530, 21331882, 2692937, 28969734, 28970086, 31363336, 24985620, 20423722, 31363688, 24985268, 20423370, 5086555, 26801610, 26801962, 4178395, 21331354, 21331706, 2693113, 28969910, 28970262, 31363512, 24985444, 20423546, 31363864, 24985092, 20423194, 31363354, 31363530, 27896507, 30455546, 30455722, 22426427, 26801416, 24985642, 20423700, 26801592, 24985466, 20423524, 11816777, 10722054, 10722230, 31363706, 31363882, 27896155, 30455194, 30455370, 22426075, 26801768, 24985290, 20423348, 26801944, 24985114, 20423172, 11817129, 10722406, 10722582, 9961647, 30768717, 30768365, 9961735, 30768805, 30768453, 15766130, 15766129, 15766481, 31250607, 25446125, 25446213, 31250959, 25446477, 25446565, 3565893, 24520716, 24520364, 3565805, 24520804, 24520452, 9222447, 9222446, 9222798, 30177357, 29842604, 29842692, 30177005, 29842956, 29843044, 3565915, 24520738, 24520386, 4973809, 31250606, 31250958, 3418075, 19050394, 19050746, 24225124, 29842608, 18902906, 24224772, 29842960, 18902554, 3565827, 24520826, 24520474, 4973897, 31250694, 31251046, 3417987, 19050306, 19050658, 24225036, 29842696, 18902818, 24224684, 29843048, 18902466, 9222469, 9222468, 9222820, 3418053, 19050372, 19050724, 3417965, 19050284, 19050636, 29695116, 29695204, 24707277, 29694764, 29694852, 24706925, 30177379, 29842626, 29842714, 24225146, 24520368, 18902884, 24225058, 24520456, 18902796, 29695138, 29695226, 24707299, 9961646, 9961734, 15618289, 30177027, 29842978, 29843066, 24224794, 24520720, 18902532, 24224706, 24520808, 18902444, 29694786, 29694874, 24706947, 9961998, 9962086, 15618641]
def witnesses4_p1 : List (C2wrS6 × Fin 11) := codes4_p1.map decodeWitness

theorem chunk4_part1_len : chunk4_part1.length ≤ witnesses4_p1.length := by decide +kernel
theorem chunk4_part1_len_eq : chunk4_part1.length = 315 := by decide +kernel
theorem chunk4_part1_act_valid : (List.zip chunk4_part1 witnesses4_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses4_p1_valid : witnesses4_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk4_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk4_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk4_part1 witnesses4_p1 chunk4_part1_len chunk4_part1_act_valid witnesses4_p1_valid hm

def chunk4_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [2, 3, 4, 6, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 5) :: (1, y2) :: m)

def codes4_p2 : List Nat := [9961823, 30768893, 30768541, 9961911, 30768981, 30768629, 15766306, 15766305, 15766657, 31250783, 25446301, 25446389, 31251135, 25446653, 25446741, 3566069, 24520892, 24520540, 3565981, 24520980, 24520628, 9222623, 9222622, 9222974, 30177533, 29842780, 29842868, 30177181, 29843132, 29843220, 3566091, 24520914, 24520562, 4973985, 31250782, 31251134, 3418251, 19050570, 19050922, 24225300, 29842784, 18903082, 24224948, 29843136, 18902730, 3566003, 24521002, 24520650, 4974073, 31250870, 31251222, 3418163, 19050482, 19050834, 24225212, 29842872, 18902994, 24224860, 29843224, 18902642, 9222645, 9222644, 9222996, 3418229, 19050548, 19050900, 3418141, 19050460, 19050812, 29695292, 29695380, 24707453, 29694940, 29695028, 24707101, 30177555, 29842802, 29842890, 24225322, 24520544, 18903060, 24225234, 24520632, 18902972, 29695314, 29695402, 24707475, 9961822, 9961910, 15618465, 30177203, 29843154, 29843242, 24224970, 24520896, 18902708, 24224882, 24520984, 18902620, 29694962, 29695050, 24707123, 9962174, 9962262, 15618817, 21644701, 21644525, 23647407, 21644789, 21644613, 23647495, 26688687, 20884293, 20884205, 26688863, 20884469, 20884381, 29451890, 29451889, 29452065, 15396700, 15396524, 17251653, 15396788, 15396612, 17251565, 21053341, 16156932, 16156844, 21053165, 16157108, 16157020, 22908207, 22908206, 22908382, 15396722, 15396546, 17251675, 26688686, 26688862, 27783409, 15101108, 14340810, 16156848, 15100932, 14340634, 16157024, 17103835, 14488474, 14488650, 15396810, 15396634, 17251587, 26688774, 26688950, 27783497, 15101020, 14340722, 16156936, 15100844, 14340546, 16157112, 17103747, 14488386, 14488562, 21053363, 16156954, 16156866, 15101130, 14340788, 15396528, 15101042, 14340700, 15396616, 23647406, 23647494, 29304049, 16009202, 16009290, 20145203, 21053187, 16157130, 16157042, 15100954, 14340612, 15396704, 15100866, 14340524, 15396792, 23647582, 23647670, 29304225, 16009026, 16009114, 20145027, 22908229, 22908228, 22908404, 17103813, 14488452, 14488628, 17103725, 14488364, 14488540, 16009180, 16009268, 20145181, 16009004, 16009092, 20145005, 21645053, 21644877, 23647759, 21645141, 21644965, 23647847, 26689039, 20884645, 20884557, 26689215, 20884821, 20884733, 29452242, 29452241, 29452417, 15397052, 15396876, 17252005, 15397140, 15396964, 17251917, 21053693, 16157284, 16157196, 21053517, 16157460, 16157372, 22908559, 22908558, 22908734, 15397074, 15396898, 17252027, 26689038, 26689214, 27783761, 15101460, 14341162, 16157200, 15101284, 14340986, 16157376, 17104187, 14488826, 14489002, 15397162, 15396986, 17251939, 26689126, 26689302, 27783849, 15101372, 14341074, 16157288, 15101196, 14340898, 16157464, 17104099, 14488738, 14488914, 21053715, 16157306, 16157218, 15101482, 14341140, 15396880, 15101394, 14341052, 15396968, 23647758, 23647846, 29304401, 16009554, 16009642, 20145555, 21053539, 16157482, 16157394, 15101306, 14340964, 15397056, 15101218, 14340876, 15397144, 23647934, 23648022, 29304577, 16009378, 16009466, 20145379, 22908581, 22908580, 22908756, 17104165, 14488804, 14488980, 17104077, 14488716, 14488892, 16009532, 16009620, 20145533, 16009356, 16009444, 20145357]
def witnesses4_p2 : List (C2wrS6 × Fin 11) := codes4_p2.map decodeWitness

theorem chunk4_part2_len : chunk4_part2.length ≤ witnesses4_p2.length := by decide +kernel
theorem chunk4_part2_len_eq : chunk4_part2.length = 315 := by decide +kernel
theorem chunk4_part2_act_valid : (List.zip chunk4_part2 witnesses4_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses4_p2_valid : witnesses4_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk4_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk4_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk4_part2 witnesses4_p2 chunk4_part2_len chunk4_part2_act_valid witnesses4_p2_valid hm

def chunk4 : List (List (Nat × Nat)) :=
  chunk4_part0 ++ (chunk4_part1 ++ chunk4_part2)

theorem chunk4_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk4) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk4] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk4_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk4_part1_coverage m h1
  · exact chunk4_part2_coverage m h2

theorem chunk4_len : chunk4.length = 945 := by
  dsimp [chunk4]
  repeat rw [List.length_append]
  rw [chunk4_part0_len_eq, chunk4_part1_len_eq, chunk4_part2_len_eq]

def chunk5_part0 : List (List (Nat × Nat)) :=
  [2, 3, 4].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 6) :: (1, y2) :: m)

def codes5_p0 : List Nat := [6075567, 6075566, 6075918, 4093937, 21246896, 21247248, 4093761, 21246720, 21247072, 30370912, 30371088, 22341793, 30370560, 30370736, 22341441, 6075523, 6075522, 6075874, 4093981, 21246940, 21247292, 4093805, 21246764, 21247116, 30370956, 30371132, 22341837, 30370604, 30370780, 22341485, 12492486, 12492485, 12492837, 2481605, 31257604, 31257956, 2481781, 31257780, 31258132, 26695684, 26695860, 11605445, 26696036, 26696212, 11605797, 10510899, 26776641, 26776993, 4980801, 31257600, 31257952, 4980845, 20360076, 20359724, 31257644, 20360032, 10510898, 31257996, 20359680, 10511250, 10510723, 26776817, 26777169, 4980977, 31257776, 31258128, 4981021, 20360252, 20359900, 31257820, 20360208, 10510722, 31258172, 20359856, 10511074, 31338561, 31338737, 28758755, 26695680, 26695856, 27790401, 26695724, 28758754, 24921776, 26695900, 28758930, 24921600, 27790445, 24921820, 24921644, 31338913, 31339089, 28758403, 26696032, 26696208, 27790753, 26696076, 28758402, 24922128, 26696252, 28758578, 24921952, 27790797, 24922172, 24921996, 6075589, 6075588, 6075940, 4093959, 21246918, 21247270, 4093783, 21246742, 21247094, 30370934, 30371110, 22341815, 30370582, 30370758, 22341463, 6075545, 6075544, 6075896, 4094003, 21246962, 21247314, 4093827, 21246786, 21247138, 30370978, 30371154, 22341859, 30370626, 30370802, 22341507, 12492508, 12492507, 12492859, 2481627, 31257626, 31257978, 2481803, 31257802, 31258154, 26695706, 26695882, 11605467, 26696058, 26696234, 11605819, 10510921, 26776663, 26777015, 4980823, 31257622, 31257974, 4980867, 20360098, 20359746, 31257666, 20360054, 10510920, 31258018, 20359702, 10511272, 10510745, 26776839, 26777191, 4980999, 31257798, 31258150, 4981043, 20360274, 20359922, 31257842, 20360230, 10510744, 31258194, 20359878, 10511096, 31338583, 31338759, 28758777, 26695702, 26695878, 27790423, 26695746, 28758776, 24921798, 26695922, 28758952, 24921622, 27790467, 24921842, 24921666, 31338935, 31339111, 28758425, 26696054, 26696230, 27790775, 26696098, 28758424, 24922150, 26696274, 28758600, 24921974, 27790819, 24922194, 24922018, 12598086, 12598085, 12598437, 10595379, 26840001, 26840353, 10595203, 26840177, 26840529, 31401921, 31402097, 28843235, 31402273, 31402449, 28842883, 6054425, 6054424, 6054776, 4051697, 21204656, 21205008, 4051521, 21204480, 21204832, 30328672, 30328848, 22299553, 30328320, 30328496, 22299201, 6054403, 6054402, 6054754, 4959857, 26674560, 26674912, 4959681, 26674736, 26675088, 31236480, 31236656, 27769633, 31236832, 31237008, 27769281, 4051719, 21204678, 21205030, 4959879, 26674582, 26674934, 2566085, 28843234, 28842882, 31236484, 20296870, 24858768, 31236836, 20296518, 24858416, 4051543, 21204502, 21204854, 4959703, 26674758, 26675110, 2566261, 28843410, 28843058, 31236660, 20296694, 24858592, 31237012, 20296342, 24858240, 30328694, 30328870, 22299575, 31236502, 31236678, 27769655, 26674564, 20296848, 24858790, 26674740, 20296672, 24858614, 11689925, 10595378, 10595202, 30328342, 30328518, 22299223, 31236854, 31237030, 27769303, 26674916, 20296496, 24858438, 26675092, 20296320, 24858262, 11690277, 10595730, 10595554]
def witnesses5_p0 : List (C2wrS6 × Fin 11) := codes5_p0.map decodeWitness

theorem chunk5_part0_len : chunk5_part0.length ≤ witnesses5_p0.length := by decide +kernel
theorem chunk5_part0_len_eq : chunk5_part0.length = 315 := by decide +kernel
theorem chunk5_part0_act_valid : (List.zip chunk5_part0 witnesses5_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses5_p0_valid : witnesses5_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk5_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk5_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk5_part0 witnesses5_p0 chunk5_part0_len chunk5_part0_act_valid witnesses5_p0_valid hm

def chunk5_part1 : List (List (Nat × Nat)) :=
  [5, 7, 8].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 6) :: (1, y2) :: m)

def codes5_p1 : List Nat := [12598130, 12598129, 12598481, 10595423, 26840045, 26840397, 10595247, 26840221, 26840573, 31401965, 31402141, 28843279, 31402317, 31402493, 28842927, 6054469, 6054468, 6054820, 4051741, 21204700, 21205052, 4051565, 21204524, 21204876, 30328716, 30328892, 22299597, 30328364, 30328540, 22299245, 6054447, 6054446, 6054798, 4959901, 26674604, 26674956, 4959725, 26674780, 26675132, 31236524, 31236700, 27769677, 31236876, 31237052, 27769325, 4051763, 21204722, 21205074, 4959923, 26674626, 26674978, 2566129, 28843278, 28842926, 31236528, 20296914, 24858812, 31236880, 20296562, 24858460, 4051587, 21204546, 21204898, 4959747, 26674802, 26675154, 2566305, 28843454, 28843102, 31236704, 20296738, 24858636, 31237056, 20296386, 24858284, 30328738, 30328914, 22299619, 31236546, 31236722, 27769699, 26674608, 20296892, 24858834, 26674784, 20296716, 24858658, 11689969, 10595422, 10595246, 30328386, 30328562, 22299267, 31236898, 31237074, 27769347, 26674960, 20296540, 24858482, 26675136, 20296364, 24858306, 11690321, 10595774, 10595598, 19036169, 31504008, 31504360, 10595208, 31401925, 31402277, 10595384, 31402101, 31402453, 26840005, 26840181, 28842888, 26840357, 26840533, 28843240, 6075528, 31257607, 31257959, 4980805, 31257602, 31257954, 4980981, 31257778, 31258130, 26695682, 26695858, 27790405, 26696034, 26696210, 27790757, 6075572, 31257651, 31258003, 4980849, 31257646, 31257998, 4981025, 31257822, 31258174, 26695726, 26695902, 27790449, 26696078, 26696254, 27790801, 4093765, 30370914, 30370562, 4093809, 30370958, 30370606, 10510728, 30370567, 30370919, 31338565, 24921602, 24921646, 31338917, 24921954, 24921998, 4093941, 30371090, 30370738, 4093985, 30371134, 30370782, 10510904, 30370743, 30371095, 31338741, 24921778, 24921822, 31339093, 24922130, 24922174, 21246898, 21246722, 22341445, 21246942, 21246766, 22341489, 26776645, 20359726, 20359682, 26776821, 20359902, 20359858, 28758408, 21246727, 21246903, 21247250, 21247074, 22341797, 21247294, 21247118, 22341841, 26776997, 20360078, 20360034, 26777173, 20360254, 20360210, 28758760, 21247079, 21247255, 16146246, 31504003, 31504355, 9708163, 30515233, 30514881, 9708207, 25066273, 25065921, 30515277, 25066317, 16146245, 30514925, 25065965, 16146597, 5227205, 31504002, 31504354, 3185667, 24013814, 24013462, 3164547, 18543778, 18543426, 23971596, 18522658, 29462404, 23971244, 18522306, 29462756, 5227249, 31504046, 31504398, 3185623, 24013858, 24013506, 3164503, 18543734, 18543382, 23971552, 18522614, 29462448, 23971200, 18522262, 29462800, 3185645, 24013792, 24013440, 3185601, 24013836, 24013484, 9602563, 9602562, 9602914, 30430753, 29462400, 29462444, 30430401, 29462752, 29462796, 3164525, 18543756, 18543404, 3164481, 18543712, 18543360, 9602585, 9602584, 9602936, 24960673, 29441632, 29441676, 24960321, 29441280, 29441324, 23971618, 18522636, 24013444, 23971574, 18522592, 24013488, 30430775, 29462422, 29462466, 24960695, 29441654, 29441698, 16125125, 9708162, 9708206, 23971266, 18522284, 24013796, 23971222, 18522240, 24013840, 30430423, 29462774, 29462818, 24960343, 29441302, 29441346, 16125477, 9708514, 9708558]
def witnesses5_p1 : List (C2wrS6 × Fin 11) := codes5_p1.map decodeWitness

theorem chunk5_part1_len : chunk5_part1.length ≤ witnesses5_p1.length := by decide +kernel
theorem chunk5_part1_len_eq : chunk5_part1.length = 315 := by decide +kernel
theorem chunk5_part1_act_valid : (List.zip chunk5_part1 witnesses5_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses5_p1_valid : witnesses5_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk5_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk5_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk5_part1 witnesses5_p1 chunk5_part1_len chunk5_part1_act_valid witnesses5_p1_valid hm

def chunk5_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 7, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 6) :: (1, y2) :: m)

def codes5_p2 : List Nat := [16146422, 31504179, 31504531, 9708339, 30515409, 30515057, 9708383, 25066449, 25066097, 30515453, 25066493, 16146421, 30515101, 25066141, 16146773, 5227381, 31504178, 31504530, 3185843, 24013990, 24013638, 3164723, 18543954, 18543602, 23971772, 18522834, 29462580, 23971420, 18522482, 29462932, 5227425, 31504222, 31504574, 3185799, 24014034, 24013682, 3164679, 18543910, 18543558, 23971728, 18522790, 29462624, 23971376, 18522438, 29462976, 3185821, 24013968, 24013616, 3185777, 24014012, 24013660, 9602739, 9602738, 9603090, 30430929, 29462576, 29462620, 30430577, 29462928, 29462972, 3164701, 18543932, 18543580, 3164657, 18543888, 18543536, 9602761, 9602760, 9603112, 24960849, 29441808, 29441852, 24960497, 29441456, 29441500, 23971794, 18522812, 24013620, 23971750, 18522768, 24013664, 30430951, 29462598, 29462642, 24960871, 29441830, 29441874, 16125301, 9708338, 9708382, 23971442, 18522460, 24013972, 23971398, 18522416, 24014016, 30430599, 29462950, 29462994, 24960519, 29441478, 29441522, 16125653, 9708690, 9708734, 26942083, 26942259, 29832006, 21391217, 21391041, 23393923, 21391261, 29832005, 20504221, 21391085, 29832181, 20504045, 23393967, 20504177, 20504001, 26942082, 26942258, 28036805, 14889798, 14889622, 16871427, 14847580, 15776644, 13960562, 14847404, 15776820, 13960386, 16850307, 13981682, 13981506, 26942126, 26942302, 28036849, 14889842, 14889666, 16871383, 14847536, 15776688, 13960518, 14847360, 15776864, 13960342, 16850263, 13981638, 13981462, 14889776, 14889600, 16871405, 14889820, 14889644, 16871361, 21306737, 15776684, 15776640, 21306561, 15776860, 15776816, 23288323, 23288322, 23288498, 14847602, 14889604, 13960540, 14847558, 14889648, 13960496, 21306759, 15776706, 15776662, 29810885, 23393922, 23393966, 20398599, 15755718, 15755762, 14847426, 14889780, 13960364, 14847382, 14889824, 13960320, 21306583, 15776882, 15776838, 29811061, 23394098, 23394142, 20398423, 15755542, 15755586, 16850285, 13981660, 13981484, 16850241, 13981616, 13981440, 23288345, 23288344, 23288520, 20398577, 15755696, 15755740, 20398401, 15755520, 15755564, 26942435, 26942611, 29832358, 21391569, 21391393, 23394275, 21391613, 29832357, 20504573, 21391437, 29832533, 20504397, 23394319, 20504529, 20504353, 26942434, 26942610, 28037157, 14890150, 14889974, 16871779, 14847932, 15776996, 13960914, 14847756, 15777172, 13960738, 16850659, 13982034, 13981858, 26942478, 26942654, 28037201, 14890194, 14890018, 16871735, 14847888, 15777040, 13960870, 14847712, 15777216, 13960694, 16850615, 13981990, 13981814, 14890128, 14889952, 16871757, 14890172, 14889996, 16871713, 21307089, 15777036, 15776992, 21306913, 15777212, 15777168, 23288675, 23288674, 23288850, 14847954, 14889956, 13960892, 14847910, 14890000, 13960848, 21307111, 15777058, 15777014, 29811237, 23394274, 23394318, 20398951, 15756070, 15756114, 14847778, 14890132, 13960716, 14847734, 14890176, 13960672, 21306935, 15777234, 15777190, 29811413, 23394450, 23394494, 20398775, 15755894, 15755938, 16850637, 13982012, 13981836, 16850593, 13981968, 13981792, 23288697, 23288696, 23288872, 20398929, 15756048, 15756092, 20398753, 15755872, 15755916]
def witnesses5_p2 : List (C2wrS6 × Fin 11) := codes5_p2.map decodeWitness

theorem chunk5_part2_len : chunk5_part2.length ≤ witnesses5_p2.length := by decide +kernel
theorem chunk5_part2_len_eq : chunk5_part2.length = 315 := by decide +kernel
theorem chunk5_part2_act_valid : (List.zip chunk5_part2 witnesses5_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses5_p2_valid : witnesses5_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk5_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk5_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk5_part2 witnesses5_p2 chunk5_part2_len chunk5_part2_act_valid witnesses5_p2_valid hm

def chunk5 : List (List (Nat × Nat)) :=
  chunk5_part0 ++ (chunk5_part1 ++ chunk5_part2)

theorem chunk5_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk5) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk5] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk5_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk5_part1_coverage m h1
  · exact chunk5_part2_coverage m h2

theorem chunk5_len : chunk5.length = 945 := by
  dsimp [chunk5]
  repeat rw [List.length_append]
  rw [chunk5_part0_len_eq, chunk5_part1_len_eq, chunk5_part2_len_eq]

def chunk6_part0 : List (List (Nat × Nat)) :=
  [2, 3, 4].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 7) :: (1, y2) :: m)

def codes6_p0 : List Nat := [6075655, 6075654, 6076006, 4094025, 21246984, 21247336, 4093849, 21246808, 21247160, 30371000, 30371176, 22341881, 30370648, 30370824, 22341529, 6075611, 6075610, 6075962, 4094069, 21247028, 21247380, 4093893, 21246852, 21247204, 30371044, 30371220, 22341925, 30370692, 30370868, 22341573, 12492574, 12492573, 12492925, 2481693, 31257692, 31258044, 2481869, 31257868, 31258220, 26695772, 26695948, 11605533, 26696124, 26696300, 11605885, 10510987, 26776729, 26777081, 4980889, 31257688, 31258040, 4980933, 20360164, 20359812, 31257732, 20360120, 10510986, 31258084, 20359768, 10511338, 10510811, 26776905, 26777257, 4981065, 31257864, 31258216, 4981109, 20360340, 20359988, 31257908, 20360296, 10510810, 31258260, 20359944, 10511162, 31338649, 31338825, 28758843, 26695768, 26695944, 27790489, 26695812, 28758842, 24921864, 26695988, 28759018, 24921688, 27790533, 24921908, 24921732, 31339001, 31339177, 28758491, 26696120, 26696296, 27790841, 26696164, 28758490, 24922216, 26696340, 28758666, 24922040, 27790885, 24922260, 24922084, 6075677, 6075676, 6076028, 4094047, 21247006, 21247358, 4093871, 21246830, 21247182, 30371022, 30371198, 22341903, 30370670, 30370846, 22341551, 6075633, 6075632, 6075984, 4094091, 21247050, 21247402, 4093915, 21246874, 21247226, 30371066, 30371242, 22341947, 30370714, 30370890, 22341595, 12492596, 12492595, 12492947, 2481715, 31257714, 31258066, 2481891, 31257890, 31258242, 26695794, 26695970, 11605555, 26696146, 26696322, 11605907, 10511009, 26776751, 26777103, 4980911, 31257710, 31258062, 4980955, 20360186, 20359834, 31257754, 20360142, 10511008, 31258106, 20359790, 10511360, 10510833, 26776927, 26777279, 4981087, 31257886, 31258238, 4981131, 20360362, 20360010, 31257930, 20360318, 10510832, 31258282, 20359966, 10511184, 31338671, 31338847, 28758865, 26695790, 26695966, 27790511, 26695834, 28758864, 24921886, 26696010, 28759040, 24921710, 27790555, 24921930, 24921754, 31339023, 31339199, 28758513, 26696142, 26696318, 27790863, 26696186, 28758512, 24922238, 26696362, 28758688, 24922062, 27790907, 24922282, 24922106, 12598174, 12598173, 12598525, 10595467, 26840089, 26840441, 10595291, 26840265, 26840617, 31402009, 31402185, 28843323, 31402361, 31402537, 28842971, 6054513, 6054512, 6054864, 4051785, 21204744, 21205096, 4051609, 21204568, 21204920, 30328760, 30328936, 22299641, 30328408, 30328584, 22299289, 6054491, 6054490, 6054842, 4959945, 26674648, 26675000, 4959769, 26674824, 26675176, 31236568, 31236744, 27769721, 31236920, 31237096, 27769369, 4051807, 21204766, 21205118, 4959967, 26674670, 26675022, 2566173, 28843322, 28842970, 31236572, 20296958, 24858856, 31236924, 20296606, 24858504, 4051631, 21204590, 21204942, 4959791, 26674846, 26675198, 2566349, 28843498, 28843146, 31236748, 20296782, 24858680, 31237100, 20296430, 24858328, 30328782, 30328958, 22299663, 31236590, 31236766, 27769743, 26674652, 20296936, 24858878, 26674828, 20296760, 24858702, 11690013, 10595466, 10595290, 30328430, 30328606, 22299311, 31236942, 31237118, 27769391, 26675004, 20296584, 24858526, 26675180, 20296408, 24858350, 11690365, 10595818, 10595642]
def witnesses6_p0 : List (C2wrS6 × Fin 11) := codes6_p0.map decodeWitness

theorem chunk6_part0_len : chunk6_part0.length ≤ witnesses6_p0.length := by decide +kernel
theorem chunk6_part0_len_eq : chunk6_part0.length = 315 := by decide +kernel
theorem chunk6_part0_act_valid : (List.zip chunk6_part0 witnesses6_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses6_p0_valid : witnesses6_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk6_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk6_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk6_part0 witnesses6_p0 chunk6_part0_len chunk6_part0_act_valid witnesses6_p0_valid hm

def chunk6_part1 : List (List (Nat × Nat)) :=
  [5, 6, 8].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 7) :: (1, y2) :: m)

def codes6_p1 : List Nat := [12598218, 12598217, 12598569, 10595511, 26840133, 26840485, 10595335, 26840309, 26840661, 31402053, 31402229, 28843367, 31402405, 31402581, 28843015, 6054557, 6054556, 6054908, 4051829, 21204788, 21205140, 4051653, 21204612, 21204964, 30328804, 30328980, 22299685, 30328452, 30328628, 22299333, 6054535, 6054534, 6054886, 4959989, 26674692, 26675044, 4959813, 26674868, 26675220, 31236612, 31236788, 27769765, 31236964, 31237140, 27769413, 4051851, 21204810, 21205162, 4960011, 26674714, 26675066, 2566217, 28843366, 28843014, 31236616, 20297002, 24858900, 31236968, 20296650, 24858548, 4051675, 21204634, 21204986, 4959835, 26674890, 26675242, 2566393, 28843542, 28843190, 31236792, 20296826, 24858724, 31237144, 20296474, 24858372, 30328826, 30329002, 22299707, 31236634, 31236810, 27769787, 26674696, 20296980, 24858922, 26674872, 20296804, 24858746, 11690057, 10595510, 10595334, 30328474, 30328650, 22299355, 31236986, 31237162, 27769435, 26675048, 20296628, 24858570, 26675224, 20296452, 24858394, 11690409, 10595862, 10595686, 19036257, 31504096, 31504448, 10595296, 31402013, 31402365, 10595472, 31402189, 31402541, 26840093, 26840269, 28842976, 26840445, 26840621, 28843328, 6075616, 31257695, 31258047, 4980893, 31257690, 31258042, 4981069, 31257866, 31258218, 26695770, 26695946, 27790493, 26696122, 26696298, 27790845, 6075660, 31257739, 31258091, 4980937, 31257734, 31258086, 4981113, 31257910, 31258262, 26695814, 26695990, 27790537, 26696166, 26696342, 27790889, 4093853, 30371002, 30370650, 4093897, 30371046, 30370694, 10510816, 30370655, 30371007, 31338653, 24921690, 24921734, 31339005, 24922042, 24922086, 4094029, 30371178, 30370826, 4094073, 30371222, 30370870, 10510992, 30370831, 30371183, 31338829, 24921866, 24921910, 31339181, 24922218, 24922262, 21246986, 21246810, 22341533, 21247030, 21246854, 22341577, 26776733, 20359814, 20359770, 26776909, 20359990, 20359946, 28758496, 21246815, 21246991, 21247338, 21247162, 22341885, 21247382, 21247206, 22341929, 26777085, 20360166, 20360122, 26777261, 20360342, 20360298, 28758848, 21247167, 21247343, 16146334, 31504091, 31504443, 9708251, 30515321, 30514969, 9708295, 25066361, 25066009, 30515365, 25066405, 16146333, 30515013, 25066053, 16146685, 5227293, 31504090, 31504442, 3185755, 24013902, 24013550, 3164635, 18543866, 18543514, 23971684, 18522746, 29462492, 23971332, 18522394, 29462844, 5227337, 31504134, 31504486, 3185711, 24013946, 24013594, 3164591, 18543822, 18543470, 23971640, 18522702, 29462536, 23971288, 18522350, 29462888, 3185733, 24013880, 24013528, 3185689, 24013924, 24013572, 9602651, 9602650, 9603002, 30430841, 29462488, 29462532, 30430489, 29462840, 29462884, 3164613, 18543844, 18543492, 3164569, 18543800, 18543448, 9602673, 9602672, 9603024, 24960761, 29441720, 29441764, 24960409, 29441368, 29441412, 23971706, 18522724, 24013532, 23971662, 18522680, 24013576, 30430863, 29462510, 29462554, 24960783, 29441742, 29441786, 16125213, 9708250, 9708294, 23971354, 18522372, 24013884, 23971310, 18522328, 24013928, 30430511, 29462862, 29462906, 24960431, 29441390, 29441434, 16125565, 9708602, 9708646]
def witnesses6_p1 : List (C2wrS6 × Fin 11) := codes6_p1.map decodeWitness

theorem chunk6_part1_len : chunk6_part1.length ≤ witnesses6_p1.length := by decide +kernel
theorem chunk6_part1_len_eq : chunk6_part1.length = 315 := by decide +kernel
theorem chunk6_part1_act_valid : (List.zip chunk6_part1 witnesses6_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses6_p1_valid : witnesses6_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk6_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk6_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk6_part1 witnesses6_p1 chunk6_part1_len chunk6_part1_act_valid witnesses6_p1_valid hm

def chunk6_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 8, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 7) :: (1, y2) :: m)

def codes6_p2 : List Nat := [16146510, 31504267, 31504619, 9708427, 30515497, 30515145, 9708471, 25066537, 25066185, 30515541, 25066581, 16146509, 30515189, 25066229, 16146861, 5227469, 31504266, 31504618, 3185931, 24014078, 24013726, 3164811, 18544042, 18543690, 23971860, 18522922, 29462668, 23971508, 18522570, 29463020, 5227513, 31504310, 31504662, 3185887, 24014122, 24013770, 3164767, 18543998, 18543646, 23971816, 18522878, 29462712, 23971464, 18522526, 29463064, 3185909, 24014056, 24013704, 3185865, 24014100, 24013748, 9602827, 9602826, 9603178, 30431017, 29462664, 29462708, 30430665, 29463016, 29463060, 3164789, 18544020, 18543668, 3164745, 18543976, 18543624, 9602849, 9602848, 9603200, 24960937, 29441896, 29441940, 24960585, 29441544, 29441588, 23971882, 18522900, 24013708, 23971838, 18522856, 24013752, 30431039, 29462686, 29462730, 24960959, 29441918, 29441962, 16125389, 9708426, 9708470, 23971530, 18522548, 24014060, 23971486, 18522504, 24014104, 30430687, 29463038, 29463082, 24960607, 29441566, 29441610, 16125741, 9708778, 9708822, 26942171, 26942347, 29832094, 21391305, 21391129, 23394011, 21391349, 29832093, 20504309, 21391173, 29832269, 20504133, 23394055, 20504265, 20504089, 26942170, 26942346, 28036893, 14889886, 14889710, 16871515, 14847668, 15776732, 13960650, 14847492, 15776908, 13960474, 16850395, 13981770, 13981594, 26942214, 26942390, 28036937, 14889930, 14889754, 16871471, 14847624, 15776776, 13960606, 14847448, 15776952, 13960430, 16850351, 13981726, 13981550, 14889864, 14889688, 16871493, 14889908, 14889732, 16871449, 21306825, 15776772, 15776728, 21306649, 15776948, 15776904, 23288411, 23288410, 23288586, 14847690, 14889692, 13960628, 14847646, 14889736, 13960584, 21306847, 15776794, 15776750, 29810973, 23394010, 23394054, 20398687, 15755806, 15755850, 14847514, 14889868, 13960452, 14847470, 14889912, 13960408, 21306671, 15776970, 15776926, 29811149, 23394186, 23394230, 20398511, 15755630, 15755674, 16850373, 13981748, 13981572, 16850329, 13981704, 13981528, 23288433, 23288432, 23288608, 20398665, 15755784, 15755828, 20398489, 15755608, 15755652, 26942523, 26942699, 29832446, 21391657, 21391481, 23394363, 21391701, 29832445, 20504661, 21391525, 29832621, 20504485, 23394407, 20504617, 20504441, 26942522, 26942698, 28037245, 14890238, 14890062, 16871867, 14848020, 15777084, 13961002, 14847844, 15777260, 13960826, 16850747, 13982122, 13981946, 26942566, 26942742, 28037289, 14890282, 14890106, 16871823, 14847976, 15777128, 13960958, 14847800, 15777304, 13960782, 16850703, 13982078, 13981902, 14890216, 14890040, 16871845, 14890260, 14890084, 16871801, 21307177, 15777124, 15777080, 21307001, 15777300, 15777256, 23288763, 23288762, 23288938, 14848042, 14890044, 13960980, 14847998, 14890088, 13960936, 21307199, 15777146, 15777102, 29811325, 23394362, 23394406, 20399039, 15756158, 15756202, 14847866, 14890220, 13960804, 14847822, 14890264, 13960760, 21307023, 15777322, 15777278, 29811501, 23394538, 23394582, 20398863, 15755982, 15756026, 16850725, 13982100, 13981924, 16850681, 13982056, 13981880, 23288785, 23288784, 23288960, 20399017, 15756136, 15756180, 20398841, 15755960, 15756004]
def witnesses6_p2 : List (C2wrS6 × Fin 11) := codes6_p2.map decodeWitness

theorem chunk6_part2_len : chunk6_part2.length ≤ witnesses6_p2.length := by decide +kernel
theorem chunk6_part2_len_eq : chunk6_part2.length = 315 := by decide +kernel
theorem chunk6_part2_act_valid : (List.zip chunk6_part2 witnesses6_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses6_p2_valid : witnesses6_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk6_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk6_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk6_part2 witnesses6_p2 chunk6_part2_len chunk6_part2_act_valid witnesses6_p2_valid hm

def chunk6 : List (List (Nat × Nat)) :=
  chunk6_part0 ++ (chunk6_part1 ++ chunk6_part2)

theorem chunk6_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk6) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk6] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk6_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk6_part1_coverage m h1
  · exact chunk6_part2_coverage m h2

theorem chunk6_len : chunk6.length = 945 := by
  dsimp [chunk6]
  repeat rw [List.length_append]
  rw [chunk6_part0_len_eq, chunk6_part1_len_eq, chunk6_part2_len_eq]

def chunk7_part0 : List (List (Nat × Nat)) :=
  [2, 3, 4].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 8) :: (1, y2) :: m)

def codes7_p0 : List Nat := [2573209, 18205880, 18205528, 2573121, 18205792, 18205440, 8356527, 8356526, 8356878, 23862433, 28850272, 28850360, 23862081, 28849920, 28850008, 2573253, 18205924, 18205572, 2573165, 18205836, 18205484, 8356483, 8356482, 8356834, 23862477, 28850316, 28850404, 23862125, 28849964, 28850052, 8990171, 24496033, 24495681, 2699885, 18079116, 18078764, 2699841, 28976640, 28976992, 18079072, 28976684, 8990170, 18078720, 28977036, 8990522, 8990083, 24496121, 24495769, 2699973, 18079204, 18078852, 2699929, 28976728, 28977080, 18079160, 28976772, 8990082, 18078808, 28977124, 8990434, 14773446, 14773445, 14773797, 4002245, 28976644, 28976996, 4002333, 28976732, 28977084, 23654404, 23654492, 14646725, 23654756, 23654844, 14647077, 30279395, 29817921, 29818009, 30279394, 23654444, 23401048, 30279482, 23654532, 23400960, 23654400, 23654488, 29311041, 23401092, 23401004, 29311085, 30279043, 29818273, 29818361, 30279042, 23654796, 23401400, 30279130, 23654884, 23401312, 23654752, 23654840, 29311393, 23401444, 23401356, 29311437, 2573231, 18205902, 18205550, 2573143, 18205814, 18205462, 8356549, 8356548, 8356900, 23862455, 28850294, 28850382, 23862103, 28849942, 28850030, 2573275, 18205946, 18205594, 2573187, 18205858, 18205506, 8356505, 8356504, 8356856, 23862499, 28850338, 28850426, 23862147, 28849986, 28850074, 8990193, 24496055, 24495703, 2699907, 18079138, 18078786, 2699863, 28976662, 28977014, 18079094, 28976706, 8990192, 18078742, 28977058, 8990544, 8990105, 24496143, 24495791, 2699995, 18079226, 18078874, 2699951, 28976750, 28977102, 18079182, 28976794, 8990104, 18078830, 28977146, 8990456, 14773468, 14773467, 14773819, 4002267, 28976666, 28977018, 4002355, 28976754, 28977106, 23654426, 23654514, 14646747, 23654778, 23654866, 14647099, 30279417, 29817943, 29818031, 30279416, 23654466, 23401070, 30279504, 23654554, 23400982, 23654422, 23654510, 29311063, 23401114, 23401026, 29311107, 30279065, 29818295, 29818383, 30279064, 23654818, 23401422, 30279152, 23654906, 23401334, 23654774, 23654862, 29311415, 23401466, 23401378, 29311459, 9074651, 24559393, 24559041, 9074563, 24559481, 24559129, 14879046, 14879045, 14879397, 30363875, 29881281, 29881369, 30363523, 29881633, 29881721, 2530969, 18163640, 18163288, 2530881, 18163552, 18163200, 8335385, 8335384, 8335736, 23820193, 28808032, 28808120, 23819841, 28807680, 28807768, 2530991, 18163662, 18163310, 4086725, 30363874, 30363522, 2678831, 23633302, 23633654, 18015822, 28955524, 23338040, 18015470, 28955876, 23337688, 2530903, 18163574, 18163222, 4086813, 30363962, 30363610, 2678743, 23633390, 23633742, 18015734, 28955612, 23337952, 18015382, 28955964, 23337600, 8335363, 8335362, 8335714, 2678809, 23633280, 23633632, 2678721, 23633368, 23633720, 28955520, 28955608, 29290273, 28955872, 28955960, 29289921, 23820215, 28808054, 28808142, 18015800, 23633284, 23338062, 18015712, 23633372, 23337974, 28955542, 28955630, 29290295, 9074650, 9074562, 14731205, 23819863, 28807702, 28807790, 18015448, 23633636, 23337710, 18015360, 23633724, 23337622, 28955894, 28955982, 29289943, 9075002, 9074914, 14731557]
def witnesses7_p0 : List (C2wrS6 × Fin 11) := codes7_p0.map decodeWitness

theorem chunk7_part0_len : chunk7_part0.length ≤ witnesses7_p0.length := by decide +kernel
theorem chunk7_part0_len_eq : chunk7_part0.length = 315 := by decide +kernel
theorem chunk7_part0_act_valid : (List.zip chunk7_part0 witnesses7_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses7_p0_valid : witnesses7_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk7_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk7_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk7_part0 witnesses7_p0 chunk7_part0_len chunk7_part0_act_valid witnesses7_p0_valid hm

def chunk7_part1 : List (List (Nat × Nat)) :=
  [5, 6, 7].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 8) :: (1, y2) :: m)

def codes7_p1 : List Nat := [9074695, 24559437, 24559085, 9074607, 24559525, 24559173, 14879090, 14879089, 14879441, 30363919, 29881325, 29881413, 30363567, 29881677, 29881765, 2531013, 18163684, 18163332, 2530925, 18163596, 18163244, 8335429, 8335428, 8335780, 23820237, 28808076, 28808164, 23819885, 28807724, 28807812, 2531035, 18163706, 18163354, 4086769, 30363918, 30363566, 2678875, 23633346, 23633698, 18015866, 28955568, 23338084, 18015514, 28955920, 23337732, 2530947, 18163618, 18163266, 4086857, 30364006, 30363654, 2678787, 23633434, 23633786, 18015778, 28955656, 23337996, 18015426, 28956008, 23337644, 8335407, 8335406, 8335758, 2678853, 23633324, 23633676, 2678765, 23633412, 23633764, 28955564, 28955652, 29290317, 28955916, 28956004, 29289965, 23820259, 28808098, 28808186, 18015844, 23633328, 23338106, 18015756, 23633416, 23338018, 28955586, 28955674, 29290339, 9074694, 9074606, 14731249, 23819907, 28807746, 28807834, 18015492, 23633680, 23337754, 18015404, 23633768, 23337666, 28955938, 28956026, 29289987, 9075046, 9074958, 14731601, 15385926, 30744035, 30743683, 8947887, 24305953, 24305601, 8947843, 29754913, 29754561, 24305997, 29754957, 15385925, 24305645, 29754605, 15386277, 4466885, 30744034, 30743682, 2404227, 17783458, 17783106, 2425347, 23253494, 23253142, 17762338, 23211276, 28702084, 17761986, 23210924, 28702436, 4466929, 30744078, 30743726, 2404183, 17783414, 17783062, 2425303, 23253538, 23253186, 17762294, 23211232, 28702128, 17761942, 23210880, 28702480, 2404205, 17783436, 17783084, 2404161, 17783392, 17783040, 8842265, 8842264, 8842616, 24200353, 28681312, 28681356, 24200001, 28680960, 28681004, 2425325, 23253472, 23253120, 2425281, 23253516, 23253164, 8842243, 8842242, 8842594, 29670433, 28702080, 28702124, 29670081, 28702432, 28702476, 17762316, 23211298, 23253124, 17762272, 23211254, 23253168, 24200375, 28681334, 28681378, 29670455, 28702102, 28702146, 15364805, 8947886, 8947842, 17761964, 23210946, 23253476, 17761920, 23210902, 23253520, 24200023, 28680982, 28681026, 29670103, 28702454, 28702498, 15365157, 8948238, 8948194, 15386014, 30744123, 30743771, 8947975, 24306041, 24305689, 8947931, 29755001, 29754649, 24306085, 29755045, 15386013, 24305733, 29754693, 15386365, 4466973, 30744122, 30743770, 2404315, 17783546, 17783194, 2425435, 23253582, 23253230, 17762426, 23211364, 28702172, 17762074, 23211012, 28702524, 4467017, 30744166, 30743814, 2404271, 17783502, 17783150, 2425391, 23253626, 23253274, 17762382, 23211320, 28702216, 17762030, 23210968, 28702568, 2404293, 17783524, 17783172, 2404249, 17783480, 17783128, 8842353, 8842352, 8842704, 24200441, 28681400, 28681444, 24200089, 28681048, 28681092, 2425413, 23253560, 23253208, 2425369, 23253604, 23253252, 8842331, 8842330, 8842682, 29670521, 28702168, 28702212, 29670169, 28702520, 28702564, 17762404, 23211386, 23253212, 17762360, 23211342, 23253256, 24200463, 28681422, 28681466, 29670543, 28702190, 28702234, 15364893, 8947974, 8947930, 17762052, 23211034, 23253564, 17762008, 23210990, 23253608, 24200111, 28681070, 28681114, 29670191, 28702542, 28702586, 15365245, 8948326, 8948282]
def witnesses7_p1 : List (C2wrS6 × Fin 11) := codes7_p1.map decodeWitness

theorem chunk7_part1_len : chunk7_part1.length ≤ witnesses7_p1.length := by decide +kernel
theorem chunk7_part1_len_eq : chunk7_part1.length = 315 := by decide +kernel
theorem chunk7_part1_act_valid : (List.zip chunk7_part1 witnesses7_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses7_p1_valid : witnesses7_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk7_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk7_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk7_part1 witnesses7_p1 chunk7_part1_len chunk7_part1_act_valid witnesses7_p1_valid hm

def chunk7_part2 : List (List (Nat × Nat)) :=
  [9, 10, 11].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 9, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 8) :: (1, y2) :: m)

def codes7_p2 : List Nat := [21317129, 30743688, 30744040, 9074568, 29881285, 29881637, 9074656, 29881373, 29881725, 24559045, 24559133, 30363528, 24559397, 24559485, 30363880, 8356488, 28976647, 28976999, 2699845, 28976642, 28976994, 2699933, 28976730, 28977082, 23654402, 23654490, 29311045, 23654754, 23654842, 29311397, 8356532, 28976691, 28977043, 2699889, 28976686, 28977038, 2699977, 28976774, 28977126, 23654446, 23654534, 29311089, 23654798, 23654886, 29311441, 2573125, 28850274, 28849922, 2573169, 28850318, 28849966, 8990088, 28849927, 28850279, 29817925, 23400962, 23401006, 29818277, 23401314, 23401358, 2573213, 28850362, 28850010, 2573257, 28850406, 28850054, 8990176, 28850015, 28850367, 29818013, 23401050, 23401094, 29818365, 23401402, 23401446, 18205530, 18205442, 23862085, 18205574, 18205486, 23862129, 24495685, 18078766, 18078722, 24495773, 18078854, 18078810, 30279048, 18205447, 18205535, 18205882, 18205794, 23862437, 18205926, 18205838, 23862481, 24496037, 18079118, 18079074, 24496125, 18079206, 18079162, 30279400, 18205799, 18205887, 31352646, 25421443, 25421531, 31352645, 19110213, 18983493, 31352733, 19110125, 18983405, 19110169, 19110081, 24914563, 18983449, 18983361, 24914607, 31078085, 25421442, 25421530, 12735364, 12566532, 12439834, 12735452, 12566444, 12439746, 12608750, 12608662, 18392067, 12460954, 12460866, 18370947, 31078129, 25421486, 25421574, 12735408, 12566488, 12439790, 12735496, 12566400, 12439702, 12608794, 12608706, 18392023, 12460910, 12460822, 18370903, 12608644, 12566554, 12439812, 12608688, 12566510, 12439768, 31331525, 24914562, 24914606, 19025711, 12735426, 12735382, 18877871, 12714394, 12714350, 12608732, 12566466, 12439724, 12608776, 12566422, 12439680, 31331613, 24914650, 24914694, 19025623, 12735514, 12735470, 18877783, 12714306, 12714262, 12608728, 12608640, 18392045, 12608772, 12608684, 18392001, 19025689, 12735404, 12735360, 19025601, 12735492, 12735448, 24808963, 24808962, 24809050, 12460932, 12460844, 18370925, 12460888, 12460800, 18370881, 18877849, 12714372, 12714328, 18877761, 12714284, 12714240, 24808985, 24808984, 24809072, 31352998, 25421795, 25421883, 31352997, 19110565, 18983845, 31353085, 19110477, 18983757, 19110521, 19110433, 24914915, 18983801, 18983713, 24914959, 31078437, 25421794, 25421882, 12735716, 12566884, 12440186, 12735804, 12566796, 12440098, 12609102, 12609014, 18392419, 12461306, 12461218, 18371299, 31078481, 25421838, 25421926, 12735760, 12566840, 12440142, 12735848, 12566752, 12440054, 12609146, 12609058, 18392375, 12461262, 12461174, 18371255, 12608996, 12566906, 12440164, 12609040, 12566862, 12440120, 31331877, 24914914, 24914958, 19026063, 12735778, 12735734, 18878223, 12714746, 12714702, 12609084, 12566818, 12440076, 12609128, 12566774, 12440032, 31331965, 24915002, 24915046, 19025975, 12735866, 12735822, 18878135, 12714658, 12714614, 12609080, 12608992, 18392397, 12609124, 12609036, 18392353, 19026041, 12735756, 12735712, 19025953, 12735844, 12735800, 24809315, 24809314, 24809402, 12461284, 12461196, 18371277, 12461240, 12461152, 18371233, 18878201, 12714724, 12714680, 18878113, 12714636, 12714592, 24809337, 24809336, 24809424]
def witnesses7_p2 : List (C2wrS6 × Fin 11) := codes7_p2.map decodeWitness

theorem chunk7_part2_len : chunk7_part2.length ≤ witnesses7_p2.length := by decide +kernel
theorem chunk7_part2_len_eq : chunk7_part2.length = 315 := by decide +kernel
theorem chunk7_part2_act_valid : (List.zip chunk7_part2 witnesses7_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses7_p2_valid : witnesses7_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk7_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk7_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk7_part2 witnesses7_p2 chunk7_part2_len chunk7_part2_act_valid witnesses7_p2_valid hm

def chunk7 : List (List (Nat × Nat)) :=
  chunk7_part0 ++ (chunk7_part1 ++ chunk7_part2)

theorem chunk7_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk7) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk7] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk7_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk7_part1_coverage m h1
  · exact chunk7_part2_coverage m h2

theorem chunk7_len : chunk7.length = 945 := by
  dsimp [chunk7]
  repeat rw [List.length_append]
  rw [chunk7_part0_len_eq, chunk7_part1_len_eq, chunk7_part2_len_eq]

def chunk8_part0 : List (List (Nat × Nat)) :=
  [2, 3, 4].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 9) :: (1, y2) :: m)

def codes8_p0 : List Nat := [2573385, 18206056, 18205704, 2573297, 18205968, 18205616, 8356703, 8356702, 8357054, 23862609, 28850448, 28850536, 23862257, 28850096, 28850184, 2573429, 18206100, 18205748, 2573341, 18206012, 18205660, 8356659, 8356658, 8357010, 23862653, 28850492, 28850580, 23862301, 28850140, 28850228, 8990347, 24496209, 24495857, 2700061, 18079292, 18078940, 2700017, 28976816, 28977168, 18079248, 28976860, 8990346, 18078896, 28977212, 8990698, 8990259, 24496297, 24495945, 2700149, 18079380, 18079028, 2700105, 28976904, 28977256, 18079336, 28976948, 8990258, 18078984, 28977300, 8990610, 14773622, 14773621, 14773973, 4002421, 28976820, 28977172, 4002509, 28976908, 28977260, 23654580, 23654668, 14646901, 23654932, 23655020, 14647253, 30279571, 29818097, 29818185, 30279570, 23654620, 23401224, 30279658, 23654708, 23401136, 23654576, 23654664, 29311217, 23401268, 23401180, 29311261, 30279219, 29818449, 29818537, 30279218, 23654972, 23401576, 30279306, 23655060, 23401488, 23654928, 23655016, 29311569, 23401620, 23401532, 29311613, 2573407, 18206078, 18205726, 2573319, 18205990, 18205638, 8356725, 8356724, 8357076, 23862631, 28850470, 28850558, 23862279, 28850118, 28850206, 2573451, 18206122, 18205770, 2573363, 18206034, 18205682, 8356681, 8356680, 8357032, 23862675, 28850514, 28850602, 23862323, 28850162, 28850250, 8990369, 24496231, 24495879, 2700083, 18079314, 18078962, 2700039, 28976838, 28977190, 18079270, 28976882, 8990368, 18078918, 28977234, 8990720, 8990281, 24496319, 24495967, 2700171, 18079402, 18079050, 2700127, 28976926, 28977278, 18079358, 28976970, 8990280, 18079006, 28977322, 8990632, 14773644, 14773643, 14773995, 4002443, 28976842, 28977194, 4002531, 28976930, 28977282, 23654602, 23654690, 14646923, 23654954, 23655042, 14647275, 30279593, 29818119, 29818207, 30279592, 23654642, 23401246, 30279680, 23654730, 23401158, 23654598, 23654686, 29311239, 23401290, 23401202, 29311283, 30279241, 29818471, 29818559, 30279240, 23654994, 23401598, 30279328, 23655082, 23401510, 23654950, 23655038, 29311591, 23401642, 23401554, 29311635, 9074827, 24559569, 24559217, 9074739, 24559657, 24559305, 14879222, 14879221, 14879573, 30364051, 29881457, 29881545, 30363699, 29881809, 29881897, 2531145, 18163816, 18163464, 2531057, 18163728, 18163376, 8335561, 8335560, 8335912, 23820369, 28808208, 28808296, 23820017, 28807856, 28807944, 2531167, 18163838, 18163486, 4086901, 30364050, 30363698, 2679007, 23633478, 23633830, 18015998, 28955700, 23338216, 18015646, 28956052, 23337864, 2531079, 18163750, 18163398, 4086989, 30364138, 30363786, 2678919, 23633566, 23633918, 18015910, 28955788, 23338128, 18015558, 28956140, 23337776, 8335539, 8335538, 8335890, 2678985, 23633456, 23633808, 2678897, 23633544, 23633896, 28955696, 28955784, 29290449, 28956048, 28956136, 29290097, 23820391, 28808230, 28808318, 18015976, 23633460, 23338238, 18015888, 23633548, 23338150, 28955718, 28955806, 29290471, 9074826, 9074738, 14731381, 23820039, 28807878, 28807966, 18015624, 23633812, 23337886, 18015536, 23633900, 23337798, 28956070, 28956158, 29290119, 9075178, 9075090, 14731733]
def witnesses8_p0 : List (C2wrS6 × Fin 11) := codes8_p0.map decodeWitness

theorem chunk8_part0_len : chunk8_part0.length ≤ witnesses8_p0.length := by decide +kernel
theorem chunk8_part0_len_eq : chunk8_part0.length = 315 := by decide +kernel
theorem chunk8_part0_act_valid : (List.zip chunk8_part0 witnesses8_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses8_p0_valid : witnesses8_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk8_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk8_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk8_part0 witnesses8_p0 chunk8_part0_len chunk8_part0_act_valid witnesses8_p0_valid hm

def chunk8_part1 : List (List (Nat × Nat)) :=
  [5, 6, 7].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 9) :: (1, y2) :: m)

def codes8_p1 : List Nat := [9074871, 24559613, 24559261, 9074783, 24559701, 24559349, 14879266, 14879265, 14879617, 30364095, 29881501, 29881589, 30363743, 29881853, 29881941, 2531189, 18163860, 18163508, 2531101, 18163772, 18163420, 8335605, 8335604, 8335956, 23820413, 28808252, 28808340, 23820061, 28807900, 28807988, 2531211, 18163882, 18163530, 4086945, 30364094, 30363742, 2679051, 23633522, 23633874, 18016042, 28955744, 23338260, 18015690, 28956096, 23337908, 2531123, 18163794, 18163442, 4087033, 30364182, 30363830, 2678963, 23633610, 23633962, 18015954, 28955832, 23338172, 18015602, 28956184, 23337820, 8335583, 8335582, 8335934, 2679029, 23633500, 23633852, 2678941, 23633588, 23633940, 28955740, 28955828, 29290493, 28956092, 28956180, 29290141, 23820435, 28808274, 28808362, 18016020, 23633504, 23338282, 18015932, 23633592, 23338194, 28955762, 28955850, 29290515, 9074870, 9074782, 14731425, 23820083, 28807922, 28808010, 18015668, 23633856, 23337930, 18015580, 23633944, 23337842, 28956114, 28956202, 29290163, 9075222, 9075134, 14731777, 15386102, 30744211, 30743859, 8948063, 24306129, 24305777, 8948019, 29755089, 29754737, 24306173, 29755133, 15386101, 24305821, 29754781, 15386453, 4467061, 30744210, 30743858, 2404403, 17783634, 17783282, 2425523, 23253670, 23253318, 17762514, 23211452, 28702260, 17762162, 23211100, 28702612, 4467105, 30744254, 30743902, 2404359, 17783590, 17783238, 2425479, 23253714, 23253362, 17762470, 23211408, 28702304, 17762118, 23211056, 28702656, 2404381, 17783612, 17783260, 2404337, 17783568, 17783216, 8842441, 8842440, 8842792, 24200529, 28681488, 28681532, 24200177, 28681136, 28681180, 2425501, 23253648, 23253296, 2425457, 23253692, 23253340, 8842419, 8842418, 8842770, 29670609, 28702256, 28702300, 29670257, 28702608, 28702652, 17762492, 23211474, 23253300, 17762448, 23211430, 23253344, 24200551, 28681510, 28681554, 29670631, 28702278, 28702322, 15364981, 8948062, 8948018, 17762140, 23211122, 23253652, 17762096, 23211078, 23253696, 24200199, 28681158, 28681202, 29670279, 28702630, 28702674, 15365333, 8948414, 8948370, 15386190, 30744299, 30743947, 8948151, 24306217, 24305865, 8948107, 29755177, 29754825, 24306261, 29755221, 15386189, 24305909, 29754869, 15386541, 4467149, 30744298, 30743946, 2404491, 17783722, 17783370, 2425611, 23253758, 23253406, 17762602, 23211540, 28702348, 17762250, 23211188, 28702700, 4467193, 30744342, 30743990, 2404447, 17783678, 17783326, 2425567, 23253802, 23253450, 17762558, 23211496, 28702392, 17762206, 23211144, 28702744, 2404469, 17783700, 17783348, 2404425, 17783656, 17783304, 8842529, 8842528, 8842880, 24200617, 28681576, 28681620, 24200265, 28681224, 28681268, 2425589, 23253736, 23253384, 2425545, 23253780, 23253428, 8842507, 8842506, 8842858, 29670697, 28702344, 28702388, 29670345, 28702696, 28702740, 17762580, 23211562, 23253388, 17762536, 23211518, 23253432, 24200639, 28681598, 28681642, 29670719, 28702366, 28702410, 15365069, 8948150, 8948106, 17762228, 23211210, 23253740, 17762184, 23211166, 23253784, 24200287, 28681246, 28681290, 29670367, 28702718, 28702762, 15365421, 8948502, 8948458]
def witnesses8_p1 : List (C2wrS6 × Fin 11) := codes8_p1.map decodeWitness

theorem chunk8_part1_len : chunk8_part1.length ≤ witnesses8_p1.length := by decide +kernel
theorem chunk8_part1_len_eq : chunk8_part1.length = 315 := by decide +kernel
theorem chunk8_part1_act_valid : (List.zip chunk8_part1 witnesses8_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses8_p1_valid : witnesses8_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk8_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk8_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk8_part1 witnesses8_p1 chunk8_part1_len chunk8_part1_act_valid witnesses8_p1_valid hm

def chunk8_part2 : List (List (Nat × Nat)) :=
  [8, 10, 11].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 10, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 9) :: (1, y2) :: m)

def codes8_p2 : List Nat := [21317305, 30743864, 30744216, 9074744, 29881461, 29881813, 9074832, 29881549, 29881901, 24559221, 24559309, 30363704, 24559573, 24559661, 30364056, 8356664, 28976823, 28977175, 2700021, 28976818, 28977170, 2700109, 28976906, 28977258, 23654578, 23654666, 29311221, 23654930, 23655018, 29311573, 8356708, 28976867, 28977219, 2700065, 28976862, 28977214, 2700153, 28976950, 28977302, 23654622, 23654710, 29311265, 23654974, 23655062, 29311617, 2573301, 28850450, 28850098, 2573345, 28850494, 28850142, 8990264, 28850103, 28850455, 29818101, 23401138, 23401182, 29818453, 23401490, 23401534, 2573389, 28850538, 28850186, 2573433, 28850582, 28850230, 8990352, 28850191, 28850543, 29818189, 23401226, 23401270, 29818541, 23401578, 23401622, 18205706, 18205618, 23862261, 18205750, 18205662, 23862305, 24495861, 18078942, 18078898, 24495949, 18079030, 18078986, 30279224, 18205623, 18205711, 18206058, 18205970, 23862613, 18206102, 18206014, 23862657, 24496213, 18079294, 18079250, 24496301, 18079382, 18079338, 30279576, 18205975, 18206063, 31352822, 25421619, 25421707, 31352821, 19110389, 18983669, 31352909, 19110301, 18983581, 19110345, 19110257, 24914739, 18983625, 18983537, 24914783, 31078261, 25421618, 25421706, 12735540, 12566708, 12440010, 12735628, 12566620, 12439922, 12608926, 12608838, 18392243, 12461130, 12461042, 18371123, 31078305, 25421662, 25421750, 12735584, 12566664, 12439966, 12735672, 12566576, 12439878, 12608970, 12608882, 18392199, 12461086, 12460998, 18371079, 12608820, 12566730, 12439988, 12608864, 12566686, 12439944, 31331701, 24914738, 24914782, 19025887, 12735602, 12735558, 18878047, 12714570, 12714526, 12608908, 12566642, 12439900, 12608952, 12566598, 12439856, 31331789, 24914826, 24914870, 19025799, 12735690, 12735646, 18877959, 12714482, 12714438, 12608904, 12608816, 18392221, 12608948, 12608860, 18392177, 19025865, 12735580, 12735536, 19025777, 12735668, 12735624, 24809139, 24809138, 24809226, 12461108, 12461020, 18371101, 12461064, 12460976, 18371057, 18878025, 12714548, 12714504, 18877937, 12714460, 12714416, 24809161, 24809160, 24809248, 31353174, 25421971, 25422059, 31353173, 19110741, 18984021, 31353261, 19110653, 18983933, 19110697, 19110609, 24915091, 18983977, 18983889, 24915135, 31078613, 25421970, 25422058, 12735892, 12567060, 12440362, 12735980, 12566972, 12440274, 12609278, 12609190, 18392595, 12461482, 12461394, 18371475, 31078657, 25422014, 25422102, 12735936, 12567016, 12440318, 12736024, 12566928, 12440230, 12609322, 12609234, 18392551, 12461438, 12461350, 18371431, 12609172, 12567082, 12440340, 12609216, 12567038, 12440296, 31332053, 24915090, 24915134, 19026239, 12735954, 12735910, 18878399, 12714922, 12714878, 12609260, 12566994, 12440252, 12609304, 12566950, 12440208, 31332141, 24915178, 24915222, 19026151, 12736042, 12735998, 18878311, 12714834, 12714790, 12609256, 12609168, 18392573, 12609300, 12609212, 18392529, 19026217, 12735932, 12735888, 19026129, 12736020, 12735976, 24809491, 24809490, 24809578, 12461460, 12461372, 18371453, 12461416, 12461328, 18371409, 18878377, 12714900, 12714856, 18878289, 12714812, 12714768, 24809513, 24809512, 24809600]
def witnesses8_p2 : List (C2wrS6 × Fin 11) := codes8_p2.map decodeWitness

theorem chunk8_part2_len : chunk8_part2.length ≤ witnesses8_p2.length := by decide +kernel
theorem chunk8_part2_len_eq : chunk8_part2.length = 315 := by decide +kernel
theorem chunk8_part2_act_valid : (List.zip chunk8_part2 witnesses8_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses8_p2_valid : witnesses8_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk8_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk8_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk8_part2 witnesses8_p2 chunk8_part2_len chunk8_part2_act_valid witnesses8_p2_valid hm

def chunk8 : List (List (Nat × Nat)) :=
  chunk8_part0 ++ (chunk8_part1 ++ chunk8_part2)

theorem chunk8_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk8) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk8] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk8_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk8_part1_coverage m h1
  · exact chunk8_part2_coverage m h2

theorem chunk8_len : chunk8.length = 945 := by
  dsimp [chunk8]
  repeat rw [List.length_append]
  rw [chunk8_part0_len_eq, chunk8_part1_len_eq, chunk8_part2_len_eq]

def chunk9_part0 : List (List (Nat × Nat)) :=
  [2, 3, 4].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 9, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 10) :: (1, y2) :: m)

def codes9_p0 : List Nat := [9081864, 9081688, 11697049, 9081776, 9081600, 11696961, 14738417, 10602504, 10602416, 14738241, 10602328, 10602240, 17480367, 17480366, 17480542, 9081908, 9081732, 11697093, 9081820, 9081644, 11697005, 14738461, 10602548, 10602460, 14738285, 10602372, 10602284, 17480323, 17480322, 17480498, 15372017, 15371841, 18114011, 8955100, 8954924, 11823725, 8955056, 18114010, 10729004, 8954880, 18114186, 10729180, 11823681, 10728960, 10729136, 15372105, 15371929, 18113923, 8955188, 8955012, 11823813, 8955144, 18113922, 10729092, 8954968, 18114098, 10729268, 11823769, 10729048, 10729224, 21155379, 16132249, 16132161, 21155378, 9715288, 9968684, 21155466, 9715200, 9968772, 9715332, 9715244, 15625325, 9968640, 9968728, 15625281, 21155203, 16132425, 16132337, 21155202, 9715464, 9968860, 21155290, 9715376, 9968948, 9715508, 9715420, 15625501, 9968816, 9968904, 15625457, 23897286, 23897285, 23897461, 22249925, 10728964, 10729140, 22250013, 10729052, 10729228, 9968644, 9968732, 23770565, 9968820, 9968908, 23770741, 9081886, 9081710, 11697071, 9081798, 9081622, 11696983, 14738439, 10602526, 10602438, 14738263, 10602350, 10602262, 17480389, 17480388, 17480564, 9081930, 9081754, 11697115, 9081842, 9081666, 11697027, 14738483, 10602570, 10602482, 14738307, 10602394, 10602306, 17480345, 17480344, 17480520, 15372039, 15371863, 18114033, 8955122, 8954946, 11823747, 8955078, 18114032, 10729026, 8954902, 18114208, 10729202, 11823703, 10728982, 10729158, 15372127, 15371951, 18113945, 8955210, 8955034, 11823835, 8955166, 18113944, 10729114, 8954990, 18114120, 10729290, 11823791, 10729070, 10729246, 21155401, 16132271, 16132183, 21155400, 9715310, 9968706, 21155488, 9715222, 9968794, 9715354, 9715266, 15625347, 9968662, 9968750, 15625303, 21155225, 16132447, 16132359, 21155224, 9715486, 9968882, 21155312, 9715398, 9968970, 9715530, 9715442, 15625523, 9968838, 9968926, 15625479, 23897308, 23897307, 23897483, 22249947, 10728986, 10729162, 22250035, 10729074, 10729250, 9968666, 9968754, 23770587, 9968842, 9968930, 23770763, 15435377, 15435201, 18198491, 15435465, 15435289, 18198403, 21239859, 16195609, 16195521, 21239683, 16195785, 16195697, 24002886, 24002885, 24003061, 9039624, 9039448, 11654809, 9039536, 9039360, 11654721, 14696177, 10560264, 10560176, 14696001, 10560088, 10560000, 17459225, 17459224, 17459400, 9039646, 9039470, 11654831, 21239858, 21239682, 22334405, 8891806, 9652104, 10707844, 8891630, 9651928, 10708020, 11802671, 9947542, 9947718, 9039558, 9039382, 11654743, 21239946, 21239770, 22334493, 8891718, 9652016, 10707932, 8891542, 9651840, 10708108, 11802583, 9947630, 9947806, 14696199, 10560286, 10560198, 8891784, 9652126, 9947524, 8891696, 9652038, 9947612, 18198490, 18198402, 23855045, 10707862, 10707950, 15604359, 14696023, 10560110, 10560022, 8891608, 9651950, 9947700, 8891520, 9651862, 9947788, 18198666, 18198578, 23855221, 10708038, 10708126, 15604183, 17459203, 17459202, 17459378, 11802649, 9947520, 9947696, 11802561, 9947608, 9947784, 10707840, 10707928, 15604337, 10708016, 10708104, 15604161]
def witnesses9_p0 : List (C2wrS6 × Fin 11) := codes9_p0.map decodeWitness

theorem chunk9_part0_len : chunk9_part0.length ≤ witnesses9_p0.length := by decide +kernel
theorem chunk9_part0_len_eq : chunk9_part0.length = 315 := by decide +kernel
theorem chunk9_part0_act_valid : (List.zip chunk9_part0 witnesses9_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses9_p0_valid : witnesses9_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk9_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk9_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk9_part0 witnesses9_p0 chunk9_part0_len chunk9_part0_act_valid witnesses9_p0_valid hm

def chunk9_part1 : List (List (Nat × Nat)) :=
  [5, 6, 7].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 9, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 10) :: (1, y2) :: m)

def codes9_p1 : List Nat := [15435421, 15435245, 18198535, 15435509, 15435333, 18198447, 21239903, 16195653, 16195565, 21239727, 16195829, 16195741, 24002930, 24002929, 24003105, 9039668, 9039492, 11654853, 9039580, 9039404, 11654765, 14696221, 10560308, 10560220, 14696045, 10560132, 10560044, 17459269, 17459268, 17459444, 9039690, 9039514, 11654875, 21239902, 21239726, 22334449, 8891850, 9652148, 10707888, 8891674, 9651972, 10708064, 11802715, 9947586, 9947762, 9039602, 9039426, 11654787, 21239990, 21239814, 22334537, 8891762, 9652060, 10707976, 8891586, 9651884, 10708152, 11802627, 9947674, 9947850, 14696243, 10560330, 10560242, 8891828, 9652170, 9947568, 8891740, 9652082, 9947656, 18198534, 18198446, 23855089, 10707906, 10707994, 15604403, 14696067, 10560154, 10560066, 8891652, 9651994, 9947744, 8891564, 9651906, 9947832, 18198710, 18198622, 23855265, 10708082, 10708170, 15604227, 17459247, 17459246, 17459422, 11802693, 9947564, 9947740, 11802605, 9947652, 9947828, 10707884, 10707972, 15604381, 10708060, 10708148, 15604205, 21620019, 21619843, 24509766, 15181937, 15181761, 18071727, 15181981, 24509765, 16069021, 15181805, 24509941, 16068845, 18071683, 16068977, 16068801, 21620018, 21619842, 22714565, 8659442, 8659266, 11528067, 8638322, 10454404, 9525340, 8638146, 10454580, 9525164, 11549187, 9567558, 9567382, 21620062, 21619886, 22714609, 8659398, 8659222, 11528023, 8638278, 10454448, 9525296, 8638102, 10454624, 9525120, 11549143, 9567602, 9567426, 8659420, 8659244, 11528045, 8659376, 8659200, 11528001, 15076337, 10433500, 10433456, 15076161, 10433324, 10433280, 17966105, 17966104, 17966280, 8638300, 9567364, 9525362, 8638256, 9567408, 9525318, 15076359, 10433522, 10433478, 24488645, 18071726, 18071682, 15984519, 10454422, 10454466, 8638124, 9567540, 9525186, 8638080, 9567584, 9525142, 15076183, 10433346, 10433302, 24488821, 18071902, 18071858, 15984343, 10454598, 10454642, 11549165, 9567536, 9567360, 11549121, 9567580, 9567404, 17966083, 17966082, 17966258, 15984497, 10454400, 10454444, 15984321, 10454576, 10454620, 21620107, 21619931, 24509854, 15182025, 15181849, 18071815, 15182069, 24509853, 16069109, 15181893, 24510029, 16068933, 18071771, 16069065, 16068889, 21620106, 21619930, 22714653, 8659530, 8659354, 11528155, 8638410, 10454492, 9525428, 8638234, 10454668, 9525252, 11549275, 9567646, 9567470, 21620150, 21619974, 22714697, 8659486, 8659310, 11528111, 8638366, 10454536, 9525384, 8638190, 10454712, 9525208, 11549231, 9567690, 9567514, 8659508, 8659332, 11528133, 8659464, 8659288, 11528089, 15076425, 10433588, 10433544, 15076249, 10433412, 10433368, 17966193, 17966192, 17966368, 8638388, 9567452, 9525450, 8638344, 9567496, 9525406, 15076447, 10433610, 10433566, 24488733, 18071814, 18071770, 15984607, 10454510, 10454554, 8638212, 9567628, 9525274, 8638168, 9567672, 9525230, 15076271, 10433434, 10433390, 24488909, 18071990, 18071946, 15984431, 10454686, 10454730, 11549253, 9567624, 9567448, 11549209, 9567668, 9567492, 17966171, 17966170, 17966346, 15984585, 10454488, 10454532, 15984409, 10454664, 10454708]
def witnesses9_p1 : List (C2wrS6 × Fin 11) := codes9_p1.map decodeWitness

theorem chunk9_part1_len : chunk9_part1.length ≤ witnesses9_p1.length := by decide +kernel
theorem chunk9_part1_len_eq : chunk9_part1.length = 315 := by decide +kernel
theorem chunk9_part1_act_valid : (List.zip chunk9_part1 witnesses9_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses9_p1_valid : witnesses9_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk9_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk9_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk9_part1 witnesses9_p1 chunk9_part1_len chunk9_part1_act_valid witnesses9_p1_valid hm

def chunk9_part2 : List (List (Nat × Nat)) :=
  [8, 9, 11].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 9, 11].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 10) :: (1, y2) :: m)

def codes9_p2 : List Nat := [26790726, 20859611, 20859523, 26790725, 14421573, 14548293, 26790813, 14421485, 14548205, 14421529, 14421441, 20352687, 14548249, 14548161, 20352643, 26516165, 20859610, 20859522, 8173444, 7877914, 8004612, 8173532, 7877826, 8004524, 7899034, 7898946, 13809027, 8046830, 8046742, 13830147, 26516209, 20859654, 20859566, 8173488, 7877870, 8004568, 8173576, 7877782, 8004480, 7898990, 7898902, 13808983, 8046874, 8046786, 13830103, 8046724, 7877892, 8004634, 8046768, 7877848, 8004590, 26769605, 20352686, 20352642, 14315951, 8152474, 8152430, 14463791, 8173506, 8173462, 8046812, 7877804, 8004546, 8046856, 7877760, 8004502, 26769693, 20352774, 20352730, 14315863, 8152386, 8152342, 14463703, 8173594, 8173550, 7899012, 7898924, 13809005, 7898968, 7898880, 13808961, 14315929, 8152452, 8152408, 14315841, 8152364, 8152320, 20247065, 20247064, 20247152, 8046808, 8046720, 13830125, 8046852, 8046764, 13830081, 14463769, 8173484, 8173440, 14463681, 8173572, 8173528, 20247043, 20247042, 20247130, 26790902, 20859787, 20859699, 26790901, 14421749, 14548469, 26790989, 14421661, 14548381, 14421705, 14421617, 20352863, 14548425, 14548337, 20352819, 26516341, 20859786, 20859698, 8173620, 7878090, 8004788, 8173708, 7878002, 8004700, 7899210, 7899122, 13809203, 8047006, 8046918, 13830323, 26516385, 20859830, 20859742, 8173664, 7878046, 8004744, 8173752, 7877958, 8004656, 7899166, 7899078, 13809159, 8047050, 8046962, 13830279, 8046900, 7878068, 8004810, 8046944, 7878024, 8004766, 26769781, 20352862, 20352818, 14316127, 8152650, 8152606, 14463967, 8173682, 8173638, 8046988, 7877980, 8004722, 8047032, 7877936, 8004678, 26769869, 20352950, 20352906, 14316039, 8152562, 8152518, 14463879, 8173770, 8173726, 7899188, 7899100, 13809181, 7899144, 7899056, 13809137, 14316105, 8152628, 8152584, 14316017, 8152540, 8152496, 20247241, 20247240, 20247328, 8046984, 8046896, 13830301, 8047028, 8046940, 13830257, 14463945, 8173660, 8173616, 14463857, 8173748, 8173704, 20247219, 20247218, 20247306, 30440969, 21619848, 21620024, 18198408, 16195525, 16195701, 18198496, 16195613, 16195789, 15435205, 15435293, 21239688, 15435381, 15435469, 21239864, 17480328, 10728967, 10729143, 11823685, 10728962, 10729138, 11823773, 10729050, 10729226, 9968642, 9968730, 15625285, 9968818, 9968906, 15625461, 17480372, 10729011, 10729187, 11823729, 10729006, 10729182, 11823817, 10729094, 10729270, 9968686, 9968774, 15625329, 9968862, 9968950, 15625505, 11696965, 10602418, 10602242, 11697009, 10602462, 10602286, 18113928, 10602247, 10602423, 16132165, 9715202, 9715246, 16132341, 9715378, 9715422, 11697053, 10602506, 10602330, 11697097, 10602550, 10602374, 18114016, 10602335, 10602511, 16132253, 9715290, 9715334, 16132429, 9715466, 9715510, 9081690, 9081602, 14738245, 9081734, 9081646, 14738289, 15371845, 8954926, 8954882, 15371933, 8955014, 8954970, 21155208, 9081607, 9081695, 9081866, 9081778, 14738421, 9081910, 9081822, 14738465, 15372021, 8955102, 8955058, 15372109, 8955190, 8955146, 21155384, 9081783, 9081871]
def witnesses9_p2 : List (C2wrS6 × Fin 11) := codes9_p2.map decodeWitness

theorem chunk9_part2_len : chunk9_part2.length ≤ witnesses9_p2.length := by decide +kernel
theorem chunk9_part2_len_eq : chunk9_part2.length = 315 := by decide +kernel
theorem chunk9_part2_act_valid : (List.zip chunk9_part2 witnesses9_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses9_p2_valid : witnesses9_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk9_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk9_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk9_part2 witnesses9_p2 chunk9_part2_len chunk9_part2_act_valid witnesses9_p2_valid hm

def chunk9 : List (List (Nat × Nat)) :=
  chunk9_part0 ++ (chunk9_part1 ++ chunk9_part2)

theorem chunk9_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk9) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk9] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk9_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk9_part1_coverage m h1
  · exact chunk9_part2_coverage m h2

theorem chunk9_len : chunk9.length = 945 := by
  dsimp [chunk9]
  repeat rw [List.length_append]
  rw [chunk9_part0_len_eq, chunk9_part1_len_eq, chunk9_part2_len_eq]

def chunk10_part0 : List (List (Nat × Nat)) :=
  [2, 3, 4].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 9, 10].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 11) :: (1, y2) :: m)

def codes10_p0 : List Nat := [9082216, 9082040, 11697401, 9082128, 9081952, 11697313, 14738769, 10602856, 10602768, 14738593, 10602680, 10602592, 17480719, 17480718, 17480894, 9082260, 9082084, 11697445, 9082172, 9081996, 11697357, 14738813, 10602900, 10602812, 14738637, 10602724, 10602636, 17480675, 17480674, 17480850, 15372369, 15372193, 18114363, 8955452, 8955276, 11824077, 8955408, 18114362, 10729356, 8955232, 18114538, 10729532, 11824033, 10729312, 10729488, 15372457, 15372281, 18114275, 8955540, 8955364, 11824165, 8955496, 18114274, 10729444, 8955320, 18114450, 10729620, 11824121, 10729400, 10729576, 21155731, 16132601, 16132513, 21155730, 9715640, 9969036, 21155818, 9715552, 9969124, 9715684, 9715596, 15625677, 9968992, 9969080, 15625633, 21155555, 16132777, 16132689, 21155554, 9715816, 9969212, 21155642, 9715728, 9969300, 9715860, 9715772, 15625853, 9969168, 9969256, 15625809, 23897638, 23897637, 23897813, 22250277, 10729316, 10729492, 22250365, 10729404, 10729580, 9968996, 9969084, 23770917, 9969172, 9969260, 23771093, 9082238, 9082062, 11697423, 9082150, 9081974, 11697335, 14738791, 10602878, 10602790, 14738615, 10602702, 10602614, 17480741, 17480740, 17480916, 9082282, 9082106, 11697467, 9082194, 9082018, 11697379, 14738835, 10602922, 10602834, 14738659, 10602746, 10602658, 17480697, 17480696, 17480872, 15372391, 15372215, 18114385, 8955474, 8955298, 11824099, 8955430, 18114384, 10729378, 8955254, 18114560, 10729554, 11824055, 10729334, 10729510, 15372479, 15372303, 18114297, 8955562, 8955386, 11824187, 8955518, 18114296, 10729466, 8955342, 18114472, 10729642, 11824143, 10729422, 10729598, 21155753, 16132623, 16132535, 21155752, 9715662, 9969058, 21155840, 9715574, 9969146, 9715706, 9715618, 15625699, 9969014, 9969102, 15625655, 21155577, 16132799, 16132711, 21155576, 9715838, 9969234, 21155664, 9715750, 9969322, 9715882, 9715794, 15625875, 9969190, 9969278, 15625831, 23897660, 23897659, 23897835, 22250299, 10729338, 10729514, 22250387, 10729426, 10729602, 9969018, 9969106, 23770939, 9969194, 9969282, 23771115, 15435729, 15435553, 18198843, 15435817, 15435641, 18198755, 21240211, 16195961, 16195873, 21240035, 16196137, 16196049, 24003238, 24003237, 24003413, 9039976, 9039800, 11655161, 9039888, 9039712, 11655073, 14696529, 10560616, 10560528, 14696353, 10560440, 10560352, 17459577, 17459576, 17459752, 9039998, 9039822, 11655183, 21240210, 21240034, 22334757, 8892158, 9652456, 10708196, 8891982, 9652280, 10708372, 11803023, 9947894, 9948070, 9039910, 9039734, 11655095, 21240298, 21240122, 22334845, 8892070, 9652368, 10708284, 8891894, 9652192, 10708460, 11802935, 9947982, 9948158, 14696551, 10560638, 10560550, 8892136, 9652478, 9947876, 8892048, 9652390, 9947964, 18198842, 18198754, 23855397, 10708214, 10708302, 15604711, 14696375, 10560462, 10560374, 8891960, 9652302, 9948052, 8891872, 9652214, 9948140, 18199018, 18198930, 23855573, 10708390, 10708478, 15604535, 17459555, 17459554, 17459730, 11803001, 9947872, 9948048, 11802913, 9947960, 9948136, 10708192, 10708280, 15604689, 10708368, 10708456, 15604513]
def witnesses10_p0 : List (C2wrS6 × Fin 11) := codes10_p0.map decodeWitness

theorem chunk10_part0_len : chunk10_part0.length ≤ witnesses10_p0.length := by decide +kernel
theorem chunk10_part0_len_eq : chunk10_part0.length = 315 := by decide +kernel
theorem chunk10_part0_act_valid : (List.zip chunk10_part0 witnesses10_p0).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses10_p0_valid : witnesses10_p0.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk10_part0_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk10_part0) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk10_part0 witnesses10_p0 chunk10_part0_len chunk10_part0_act_valid witnesses10_p0_valid hm

def chunk10_part1 : List (List (Nat × Nat)) :=
  [5, 6, 7].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 9, 10].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 11) :: (1, y2) :: m)

def codes10_p1 : List Nat := [15435773, 15435597, 18198887, 15435861, 15435685, 18198799, 21240255, 16196005, 16195917, 21240079, 16196181, 16196093, 24003282, 24003281, 24003457, 9040020, 9039844, 11655205, 9039932, 9039756, 11655117, 14696573, 10560660, 10560572, 14696397, 10560484, 10560396, 17459621, 17459620, 17459796, 9040042, 9039866, 11655227, 21240254, 21240078, 22334801, 8892202, 9652500, 10708240, 8892026, 9652324, 10708416, 11803067, 9947938, 9948114, 9039954, 9039778, 11655139, 21240342, 21240166, 22334889, 8892114, 9652412, 10708328, 8891938, 9652236, 10708504, 11802979, 9948026, 9948202, 14696595, 10560682, 10560594, 8892180, 9652522, 9947920, 8892092, 9652434, 9948008, 18198886, 18198798, 23855441, 10708258, 10708346, 15604755, 14696419, 10560506, 10560418, 8892004, 9652346, 9948096, 8891916, 9652258, 9948184, 18199062, 18198974, 23855617, 10708434, 10708522, 15604579, 17459599, 17459598, 17459774, 11803045, 9947916, 9948092, 11802957, 9948004, 9948180, 10708236, 10708324, 15604733, 10708412, 10708500, 15604557, 21620371, 21620195, 24510118, 15182289, 15182113, 18072079, 15182333, 24510117, 16069373, 15182157, 24510293, 16069197, 18072035, 16069329, 16069153, 21620370, 21620194, 22714917, 8659794, 8659618, 11528419, 8638674, 10454756, 9525692, 8638498, 10454932, 9525516, 11549539, 9567910, 9567734, 21620414, 21620238, 22714961, 8659750, 8659574, 11528375, 8638630, 10454800, 9525648, 8638454, 10454976, 9525472, 11549495, 9567954, 9567778, 8659772, 8659596, 11528397, 8659728, 8659552, 11528353, 15076689, 10433852, 10433808, 15076513, 10433676, 10433632, 17966457, 17966456, 17966632, 8638652, 9567716, 9525714, 8638608, 9567760, 9525670, 15076711, 10433874, 10433830, 24488997, 18072078, 18072034, 15984871, 10454774, 10454818, 8638476, 9567892, 9525538, 8638432, 9567936, 9525494, 15076535, 10433698, 10433654, 24489173, 18072254, 18072210, 15984695, 10454950, 10454994, 11549517, 9567888, 9567712, 11549473, 9567932, 9567756, 17966435, 17966434, 17966610, 15984849, 10454752, 10454796, 15984673, 10454928, 10454972, 21620459, 21620283, 24510206, 15182377, 15182201, 18072167, 15182421, 24510205, 16069461, 15182245, 24510381, 16069285, 18072123, 16069417, 16069241, 21620458, 21620282, 22715005, 8659882, 8659706, 11528507, 8638762, 10454844, 9525780, 8638586, 10455020, 9525604, 11549627, 9567998, 9567822, 21620502, 21620326, 22715049, 8659838, 8659662, 11528463, 8638718, 10454888, 9525736, 8638542, 10455064, 9525560, 11549583, 9568042, 9567866, 8659860, 8659684, 11528485, 8659816, 8659640, 11528441, 15076777, 10433940, 10433896, 15076601, 10433764, 10433720, 17966545, 17966544, 17966720, 8638740, 9567804, 9525802, 8638696, 9567848, 9525758, 15076799, 10433962, 10433918, 24489085, 18072166, 18072122, 15984959, 10454862, 10454906, 8638564, 9567980, 9525626, 8638520, 9568024, 9525582, 15076623, 10433786, 10433742, 24489261, 18072342, 18072298, 15984783, 10455038, 10455082, 11549605, 9567976, 9567800, 11549561, 9568020, 9567844, 17966523, 17966522, 17966698, 15984937, 10454840, 10454884, 15984761, 10455016, 10455060]
def witnesses10_p1 : List (C2wrS6 × Fin 11) := codes10_p1.map decodeWitness

theorem chunk10_part1_len : chunk10_part1.length ≤ witnesses10_p1.length := by decide +kernel
theorem chunk10_part1_len_eq : chunk10_part1.length = 315 := by decide +kernel
theorem chunk10_part1_act_valid : (List.zip chunk10_part1 witnesses10_p1).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses10_p1_valid : witnesses10_p1.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk10_part1_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk10_part1) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk10_part1 witnesses10_p1 chunk10_part1_len chunk10_part1_act_valid witnesses10_p1_valid hm

def chunk10_part2 : List (List (Nat × Nat)) :=
  [8, 9, 10].flatMap fun y2 =>
    let rest := [2, 3, 4, 5, 6, 7, 8, 9, 10].filter (fun z => z != y2)
    (enumMatchings 4 rest).map (fun m => (0, 11) :: (1, y2) :: m)

def codes10_p2 : List Nat := [26791078, 20859963, 20859875, 26791077, 14421925, 14548645, 26791165, 14421837, 14548557, 14421881, 14421793, 20353039, 14548601, 14548513, 20352995, 26516517, 20859962, 20859874, 8173796, 7878266, 8004964, 8173884, 7878178, 8004876, 7899386, 7899298, 13809379, 8047182, 8047094, 13830499, 26516561, 20860006, 20859918, 8173840, 7878222, 8004920, 8173928, 7878134, 8004832, 7899342, 7899254, 13809335, 8047226, 8047138, 13830455, 8047076, 7878244, 8004986, 8047120, 7878200, 8004942, 26769957, 20353038, 20352994, 14316303, 8152826, 8152782, 14464143, 8173858, 8173814, 8047164, 7878156, 8004898, 8047208, 7878112, 8004854, 26770045, 20353126, 20353082, 14316215, 8152738, 8152694, 14464055, 8173946, 8173902, 7899364, 7899276, 13809357, 7899320, 7899232, 13809313, 14316281, 8152804, 8152760, 14316193, 8152716, 8152672, 20247417, 20247416, 20247504, 8047160, 8047072, 13830477, 8047204, 8047116, 13830433, 14464121, 8173836, 8173792, 14464033, 8173924, 8173880, 20247395, 20247394, 20247482, 26791254, 20860139, 20860051, 26791253, 14422101, 14548821, 26791341, 14422013, 14548733, 14422057, 14421969, 20353215, 14548777, 14548689, 20353171, 26516693, 20860138, 20860050, 8173972, 7878442, 8005140, 8174060, 7878354, 8005052, 7899562, 7899474, 13809555, 8047358, 8047270, 13830675, 26516737, 20860182, 20860094, 8174016, 7878398, 8005096, 8174104, 7878310, 8005008, 7899518, 7899430, 13809511, 8047402, 8047314, 13830631, 8047252, 7878420, 8005162, 8047296, 7878376, 8005118, 26770133, 20353214, 20353170, 14316479, 8153002, 8152958, 14464319, 8174034, 8173990, 8047340, 7878332, 8005074, 8047384, 7878288, 8005030, 26770221, 20353302, 20353258, 14316391, 8152914, 8152870, 14464231, 8174122, 8174078, 7899540, 7899452, 13809533, 7899496, 7899408, 13809489, 14316457, 8152980, 8152936, 14316369, 8152892, 8152848, 20247593, 20247592, 20247680, 8047336, 8047248, 13830653, 8047380, 8047292, 13830609, 14464297, 8174012, 8173968, 14464209, 8174100, 8174056, 20247571, 20247570, 20247658, 30441321, 21620200, 21620376, 18198760, 16195877, 16196053, 18198848, 16195965, 16196141, 15435557, 15435645, 21240040, 15435733, 15435821, 21240216, 17480680, 10729319, 10729495, 11824037, 10729314, 10729490, 11824125, 10729402, 10729578, 9968994, 9969082, 15625637, 9969170, 9969258, 15625813, 17480724, 10729363, 10729539, 11824081, 10729358, 10729534, 11824169, 10729446, 10729622, 9969038, 9969126, 15625681, 9969214, 9969302, 15625857, 11697317, 10602770, 10602594, 11697361, 10602814, 10602638, 18114280, 10602599, 10602775, 16132517, 9715554, 9715598, 16132693, 9715730, 9715774, 11697405, 10602858, 10602682, 11697449, 10602902, 10602726, 18114368, 10602687, 10602863, 16132605, 9715642, 9715686, 16132781, 9715818, 9715862, 9082042, 9081954, 14738597, 9082086, 9081998, 14738641, 15372197, 8955278, 8955234, 15372285, 8955366, 8955322, 21155560, 9081959, 9082047, 9082218, 9082130, 14738773, 9082262, 9082174, 14738817, 15372373, 8955454, 8955410, 15372461, 8955542, 8955498, 21155736, 9082135, 9082223]
def witnesses10_p2 : List (C2wrS6 × Fin 11) := codes10_p2.map decodeWitness

theorem chunk10_part2_len : chunk10_part2.length ≤ witnesses10_p2.length := by decide +kernel
theorem chunk10_part2_len_eq : chunk10_part2.length = 315 := by decide +kernel
theorem chunk10_part2_act_valid : (List.zip chunk10_part2 witnesses10_p2).all (fun (m, w) => checkAct m w) = true := by decide +kernel
theorem witnesses10_p2_valid : witnesses10_p2.all (fun w => isC2wrS6 w.1) = true := by decide +kernel

theorem chunk10_part2_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk10_part2) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  exists_witness_of_act_and_isC2wrS6 chunk10_part2 witnesses10_p2 chunk10_part2_len chunk10_part2_act_valid witnesses10_p2_valid hm

def chunk10 : List (List (Nat × Nat)) :=
  chunk10_part0 ++ (chunk10_part1 ++ chunk10_part2)

theorem chunk10_coverage (m : List (Nat × Nat)) (hm : m ∈ chunk10) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [chunk10] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk10_part0_coverage m h0
  rcases List.mem_append.mp hm with h1 | h2
  · exact chunk10_part1_coverage m h1
  · exact chunk10_part2_coverage m h2

theorem chunk10_len : chunk10.length = 945 := by
  dsimp [chunk10]
  repeat rw [List.length_append]
  rw [chunk10_part0_len_eq, chunk10_part1_len_eq, chunk10_part2_len_eq]

/-- The complete set of all 10,395 perfect matchings on the 12 fiber vertices,
    partitioned into 11 canonical branches by the partner of vertex 0. -/
def FiberMatchings : List (List (Nat × Nat)) :=
  chunk0 ++ (chunk1 ++ (chunk2 ++ (chunk3 ++ (chunk4 ++
  (chunk5 ++ (chunk6 ++ (chunk7 ++ (chunk8 ++ (chunk9 ++ chunk10)))))))))

/-- Theorem: Exact 11-Branch Orbit Coverage of C₂ ≀ S₆ on Fiber Matchings.
    Every matching in FiberMatchings is mapped by some g ∈ C₂ ≀ S₆ to one of the
    11 canonical branch matchings branchMatching i (i ∈ Fin 11). -/
theorem fiber_matchings_orbit_coverage (m : List (Nat × Nat)) (hm : m ∈ FiberMatchings) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i := by
  dsimp [FiberMatchings] at hm
  rcases List.mem_append.mp hm with h0 | hm
  · exact chunk0_coverage m h0
  rcases List.mem_append.mp hm with h1 | hm
  · exact chunk1_coverage m h1
  rcases List.mem_append.mp hm with h2 | hm
  · exact chunk2_coverage m h2
  rcases List.mem_append.mp hm with h3 | hm
  · exact chunk3_coverage m h3
  rcases List.mem_append.mp hm with h4 | hm
  · exact chunk4_coverage m h4
  rcases List.mem_append.mp hm with h5 | hm
  · exact chunk5_coverage m h5
  rcases List.mem_append.mp hm with h6 | hm
  · exact chunk6_coverage m h6
  rcases List.mem_append.mp hm with h7 | hm
  · exact chunk7_coverage m h7
  rcases List.mem_append.mp hm with h8 | hm
  · exact chunk8_coverage m h8
  rcases List.mem_append.mp hm with h9 | h10
  · exact chunk9_coverage m h9
  · exact chunk10_coverage m h10

/-- Theorem: The cardinality of FiberMatchings is exactly 11!! = 10,395. -/
theorem fiber_matchings_length : FiberMatchings.length = 10395 := by
  dsimp [FiberMatchings]
  repeat rw [List.length_append]
  rw [chunk0_len, chunk1_len, chunk2_len, chunk3_len, chunk4_len,
      chunk5_len, chunk6_len, chunk7_len, chunk8_len, chunk9_len, chunk10_len]

end Matrix99
