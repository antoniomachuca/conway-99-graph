/-
  Symmetry reduction of the exterior row problem.

  `z7ExteriorTarget` is constant on the blocks {0,1,2}, {3,4,5} and {6,…,11}.
  A relabeling that fixes index 0 and permutes the other indices inside those
  blocks preserves `ExteriorEquations`. Sorting row 0 inside {1,2}, {3,4,5}
  and {6,…,11} puts that row in the same canonical list the CNF campaign
  enumerates (`scripts/z7_row0_roots.py`).

  This file does not replay the 33 DRAT proofs and does not remove
  `z7_orbit_matrix_nonexistence`.
-/

import Conway.OrbitQuotient
import Conway.Z7ExteriorEncoding

namespace Matrix99
open ConwayOrbit

def Nondecreasing : List Nat → Prop
  | [] => True
  | [_] => True
  | a :: b :: t => a ≤ b ∧ Nondecreasing (b :: t)

def pairSorted {α : Type} : List (Nat × α) → Prop
  | [] => True
  | [_] => True
  | p :: q :: t => p.1 ≤ q.1 ∧ pairSorted (q :: t)

def insertPair {α : Type} (p : Nat × α) : List (Nat × α) → List (Nat × α)
  | [] => [p]
  | q :: qs => if p.1 ≤ q.1 then p :: q :: qs else q :: insertPair p qs

def sortPairs {α : Type} : List (Nat × α) → List (Nat × α)
  | [] => []
  | p :: ps => insertPair p (sortPairs ps)

theorem insertPair_ne_nil {α : Type} (p : Nat × α) (l : List (Nat × α)) :
    insertPair p l ≠ [] := by
  induction l with
  | nil => simp [insertPair]
  | cons q qs _ =>
    by_cases hle : p.1 ≤ q.1 <;> simp [insertPair, hle]

theorem insertPair_perm {α : Type} (p : Nat × α) (l : List (Nat × α)) :
    List.Perm (insertPair p l) (p :: l) := by
  induction l with
  | nil => simp [insertPair]
  | cons q qs ih =>
    by_cases hle : p.1 ≤ q.1
    · simp [insertPair, hle]
    · simp [insertPair, hle]
      exact (ih.cons q).trans (List.Perm.swap q p qs).symm

theorem sortPairs_perm {α : Type} (l : List (Nat × α)) :
    List.Perm (sortPairs l) l := by
  induction l with
  | nil => simp [sortPairs]
  | cons p ps ih =>
    simp [sortPairs]
    exact (insertPair_perm p (sortPairs ps)).trans (ih.cons p)

theorem pairSorted_fst {α : Type} (l : List (Nat × α)) (h : pairSorted l) :
    Nondecreasing (l.map Prod.fst) := by
  induction l with
  | nil => simp [Nondecreasing]
  | cons p ps ih =>
    cases ps with
    | nil => simp [Nondecreasing]
    | cons q qs =>
      obtain ⟨hle, ht⟩ := h
      simp [Nondecreasing, List.map_cons, hle]
      exact ih ht

theorem insertPair_sorted {α : Type} (p : Nat × α) :
    ∀ l, pairSorted l → pairSorted (insertPair p l)
  | [], _ => by simp [insertPair, pairSorted]
  | q :: qs, hs => by
    by_cases hle : p.1 ≤ q.1
    · cases qs with
      | nil =>
        simp [insertPair, hle, pairSorted]
      | cons r rs =>
        obtain ⟨hq, ht⟩ := hs
        simp [insertPair, hle, pairSorted, hq, ht]
    · have hqle : q.1 ≤ p.1 := Nat.le_of_lt (Nat.lt_of_not_ge hle)
      have hs' : pairSorted qs := by
        cases qs with
        | nil => simp [pairSorted]
        | cons r rs => exact hs.2
      have ih := insertPair_sorted p qs hs'
      have hne := insertPair_ne_nil p qs
      cases hrec : insertPair p qs with
      | nil => exact False.elim (hne hrec)
      | cons r rs =>
        have hhead : q.1 ≤ r.1 := by
          have hps : pairSorted (r :: rs) := by simpa [hrec] using ih
          by_cases hfront : p.1 ≤ q.1
          · exact False.elim (hle hfront)
          · cases qs with
            | nil =>
              simp [insertPair] at hrec
              rcases hrec with ⟨rfl, rfl⟩
              exact hqle
            | cons s ss =>
              by_cases hpsle : p.1 ≤ s.1
              · simp [insertPair, hpsle] at hrec
                rcases hrec with ⟨rfl, rfl⟩
                exact hqle
              · simp [insertPair, hpsle] at hrec
                rcases hrec with ⟨rfl, htail⟩
                exact hs.1
        simp [insertPair, hle, hrec, pairSorted, hhead]
        simpa [hrec] using ih

theorem sortPairs_sorted {α : Type} (l : List (Nat × α)) :
    pairSorted (sortPairs l) := by
  induction l with
  | nil => simp [sortPairs, pairSorted]
  | cons p ps ih =>
    simp [sortPairs]
    exact insertPair_sorted p (sortPairs ps) ih

def sortIdx (xs : List (Fin 12)) (val : Fin 12 → Nat) : List (Fin 12) :=
  (sortPairs (xs.map fun i => (val i, i))).map Prod.snd

private theorem map_snd_pairs (xs : List (Fin 12)) (val : Fin 12 → Nat) :
    ((xs.map fun i => (val i, i)).map Prod.snd) = xs := by
  induction xs with
  | nil => rfl
  | cons a as ih =>
    simp only [List.map_cons]
    rw [ih]

theorem sortIdx_perm (xs : List (Fin 12)) (val : Fin 12 → Nat) :
    List.Perm (sortIdx xs val) xs := by
  unfold sortIdx
  have h := (sortPairs_perm (xs.map fun i => (val i, i))).map Prod.snd
  rw [map_snd_pairs xs val] at h
  exact h

theorem sortIdx_mem (xs : List (Fin 12)) (val : Fin 12 → Nat) (x : Fin 12) :
    x ∈ sortIdx xs val ↔ x ∈ xs :=
  (sortIdx_perm xs val).mem_iff

private theorem map_val_of_pairs (val : Fin 12 → Nat) :
    ∀ l : List (Nat × Fin 12),
      (∀ p, p ∈ l → p.1 = val p.2) →
        (l.map Prod.snd).map val = l.map Prod.fst
  | [], _ => rfl
  | p :: ps, h => by
    have hp : p.1 = val p.2 := h p (by simp)
    have ht := map_val_of_pairs val ps (fun q hq => h q (by simp [hq]))
    simp [hp, ht]

theorem sortIdx_values_nondec (xs : List (Fin 12)) (val : Fin 12 → Nat) :
    Nondecreasing ((sortIdx xs val).map val) := by
  have hs := pairSorted_fst _ (sortPairs_sorted (xs.map fun i => (val i, i)))
  have hmem : ∀ p, p ∈ sortPairs (xs.map fun i => (val i, i)) → p.1 = val p.2 := by
    intro p hp
    have hp' : p ∈ xs.map fun i => (val i, i) := (sortPairs_perm _).mem_iff.mp hp
    simp only [List.mem_map] at hp'
    obtain ⟨i, _, rfl⟩ := hp'
    rfl
  have heq := map_val_of_pairs val _ hmem
  unfold sortIdx
  rw [heq]
  exact hs

def row0Order (C : Fin 12 → Fin 12 → Nat) : List (Fin 12) :=
  [0] ++ sortIdx [1, 2] (C 0) ++ sortIdx [3, 4, 5] (C 0) ++
    sortIdx [6, 7, 8, 9, 10, 11] (C 0)

private theorem nodup_append_disjoint {α : Type} [DecidableEq α]
    {l₁ l₂ : List α} (h₁ : l₁.Nodup) (h₂ : l₂.Nodup)
    (hdis : ∀ x, x ∈ l₁ → x ∉ l₂) : (l₁ ++ l₂).Nodup := by
  induction l₁ with
  | nil => simpa using h₂
  | cons a t ih =>
    simp only [List.nodup_cons, List.cons_append, List.mem_append] at h₁ ⊢
    constructor
    · intro hx
      rcases hx with hx | hx
      · exact h₁.1 hx
      · exact hdis a (List.mem_cons_self) hx
    · exact ih h₁.2 (fun x hx => hdis x (List.mem_cons_of_mem a hx))

private theorem block_nodup_12 : ([1, 2] : List (Fin 12)).Nodup := by decide
private theorem block_nodup_345 : ([3, 4, 5] : List (Fin 12)).Nodup := by decide
private theorem block_nodup_6 : ([6, 7, 8, 9, 10, 11] : List (Fin 12)).Nodup := by decide

private theorem disj_0_12 : ∀ x : Fin 12, x ∈ [0] → x ∉ [1, 2] := by decide
private theorem disj_012_345 :
    ∀ x : Fin 12, x ∈ [0] ++ ([1, 2] : List (Fin 12)) → x ∉ [3, 4, 5] := by decide
private theorem disj_front_6 :
    ∀ x : Fin 12, x ∈ [0] ++ ([1, 2] : List (Fin 12)) ++ [3, 4, 5] →
      x ∉ [6, 7, 8, 9, 10, 11] := by decide

theorem row0Order_nodup (C : Fin 12 → Fin 12 → Nat) : (row0Order C).Nodup := by
  have h12 : (sortIdx [1, 2] (C 0)).Nodup :=
    (sortIdx_perm [1, 2] (C 0)).symm.nodup block_nodup_12
  have h345 : (sortIdx [3, 4, 5] (C 0)).Nodup :=
    (sortIdx_perm [3, 4, 5] (C 0)).symm.nodup block_nodup_345
  have h6 : (sortIdx [6, 7, 8, 9, 10, 11] (C 0)).Nodup :=
    (sortIdx_perm [6, 7, 8, 9, 10, 11] (C 0)).symm.nodup block_nodup_6
  have h0 : ([0] : List (Fin 12)).Nodup := by decide
  have d1 : ∀ x, x ∈ [0] → x ∉ sortIdx [1, 2] (C 0) := by
    intro x hx hxs
    exact disj_0_12 x hx ((sortIdx_mem _ _ _).mp hxs)
  have front12 := nodup_append_disjoint h0 h12 d1
  have d2 : ∀ x, x ∈ [0] ++ sortIdx [1, 2] (C 0) → x ∉ sortIdx [3, 4, 5] (C 0) := by
    intro x hx hxs
    have hx345 : x ∈ [3, 4, 5] := (sortIdx_mem _ _ _).mp hxs
    have hxfront : x ∈ [0] ++ ([1, 2] : List (Fin 12)) := by
      simp only [List.mem_append, List.mem_singleton] at hx
      rcases hx with hx | hx
      · exact List.mem_append_left _ (List.mem_singleton.mpr hx)
      · exact List.mem_append_right _ ((sortIdx_mem _ _ _).mp hx)
    exact disj_012_345 x hxfront hx345
  have front := nodup_append_disjoint front12 h345 d2
  have d3 : ∀ x,
      x ∈ [0] ++ sortIdx [1, 2] (C 0) ++ sortIdx [3, 4, 5] (C 0) →
        x ∉ sortIdx [6, 7, 8, 9, 10, 11] (C 0) := by
    intro x hx hxs
    have hx6 : x ∈ [6, 7, 8, 9, 10, 11] := (sortIdx_mem _ _ _).mp hxs
    have hxfront : x ∈ [0] ++ ([1, 2] : List (Fin 12)) ++ [3, 4, 5] := by
      simp only [List.mem_append] at hx
      rcases hx with hx | hx
      · rcases hx with hx | hx
        · exact List.mem_append_left _ (List.mem_append_left _ hx)
        · exact List.mem_append_left _ (List.mem_append_right _ ((sortIdx_mem _ _ _).mp hx))
      · exact List.mem_append_right _ ((sortIdx_mem _ _ _).mp hx)
    exact disj_front_6 x hxfront hx6
  simpa [row0Order] using nodup_append_disjoint front h6 d3

theorem row0Order_length (C : Fin 12 → Fin 12 → Nat) : (row0Order C).length = 12 := by
  have e1 := (sortIdx_perm [1, 2] (C 0)).length_eq
  have e2 := (sortIdx_perm [3, 4, 5] (C 0)).length_eq
  have e3 := (sortIdx_perm [6, 7, 8, 9, 10, 11] (C 0)).length_eq
  simp only [List.length_cons, List.length_nil] at e1 e2 e3
  simp [row0Order, List.length_append, List.length_cons, List.length_nil, e1, e2, e3]

theorem row0Order_perm (C : Fin 12 → Fin 12 → Nat) :
    List.Perm (row0Order C) (List.finRange 12) := by
  apply perm_of_nodup_same_members (row0Order_nodup C)
  · intro x _
    exact List.mem_finRange x
  · rw [row0Order_length, List.length_finRange]

def row0Relabel (C : Fin 12 → Fin 12 → Nat) : Fin 12 → Fin 12 :=
  fun i => (row0Order C).get ⟨i.val, by
    rw [row0Order_length]
    exact i.isLt⟩

theorem row0Relabel_inj (C : Fin 12 → Fin 12 → Nat) {a b : Fin 12}
    (h : row0Relabel C a = row0Relabel C b) : a = b := by
  apply Fin.ext
  have hnd := (row0Order_perm C).symm.nodup (List.nodup_finRange 12)
  exact (List.getElem_inj hnd).mp h

theorem row0Relabel_surj (C : Fin 12 → Fin 12 → Nat) (y : Fin 12) :
    ∃ x, row0Relabel C x = y := by
  have hy : y ∈ row0Order C := (row0Order_perm C).mem_iff.mpr (List.mem_finRange y)
  obtain ⟨i, hi⟩ := List.get_of_mem hy
  have hlt : i.val < 12 := by
    have hlen : i.val < (row0Order C).length := i.isLt
    simpa [row0Order_length C] using hlen
  refine ⟨⟨i.val, hlt⟩, ?_⟩
  simpa [row0Relabel, List.get] using hi

theorem perm_sum {l₁ l₂ : List Nat} (h : List.Perm l₁ l₂) : l₁.sum = l₂.sum := by
  induction h with
  | nil => rfl
  | cons x _ ih => simp [List.sum_cons, ih]
  | swap x y l => simp [List.sum_cons, Nat.add_left_comm, Nat.add_comm]
  | trans _ _ ih₁ ih₂ => exact ih₁.trans ih₂

theorem sum_map_perm {α : Type} {l₁ l₂ : List α} (h : List.Perm l₁ l₂) (f : α → Nat) :
    (l₁.map f).sum = (l₂.map f).sum :=
  perm_sum (h.map f)

theorem sum12_comp (σ : Fin 12 → Fin 12)
    (hinj : ∀ a b, σ a = σ b → a = b) (hsurj : ∀ y, ∃ x, σ x = y)
    (f : Fin 12 → Nat) : sum12 (fun j => f (σ j)) = sum12 f := by
  unfold sum12
  have hp := perm_map_finRange σ hinj hsurj
  have hs := sum_map_perm hp.symm f
  simp only [List.map_map] at hs
  exact hs.symm

def conjMatrix (C : Fin 12 → Fin 12 → Nat) (σ : Fin 12 → Fin 12) :
    Fin 12 → Fin 12 → Nat :=
  fun i j => C (σ i) (σ j)

/-- A relabeling that fixes 0 and permutes indices inside the three blocks. -/
structure FixesRow0Blocks (σ : Fin 12 → Fin 12) : Prop where
  inj : ∀ a b, σ a = σ b → a = b
  surj : ∀ y, ∃ x, σ x = y
  fix0 : σ 0 = 0
  slot12 : σ 1 = 1 ∨ σ 1 = 2
  slot12' : σ 2 = 1 ∨ σ 2 = 2
  slot345 : σ 3 = 3 ∨ σ 3 = 4 ∨ σ 3 = 5
  slot345' : σ 4 = 3 ∨ σ 4 = 4 ∨ σ 4 = 5
  slot345'' : σ 5 = 3 ∨ σ 5 = 4 ∨ σ 5 = 5
  slot6 : ∀ i, 6 ≤ i.val → 6 ≤ (σ i).val

theorem left_preserved (σ : Fin 12 → Fin 12) (hσ : FixesRow0Blocks σ) (i : Fin 12) :
    z7ExteriorLeft (σ i) = z7ExteriorLeft i := by
  unfold z7ExteriorLeft
  refine if h3 : i.val < 3 then ?pos else ?neg
  · have hσ3 : (σ i).val < 3 := by
      rcases (show i.val = 0 ∨ i.val = 1 ∨ i.val = 2 by omega) with hv | hv | hv
      · have hi : i = 0 := Fin.ext hv
        simp [hi, hσ.fix0]
      · have hi : i = 1 := Fin.ext hv
        rcases hσ.slot12 with hs | hs <;> simp [hi, hs]
      · have hi : i = 2 := Fin.ext hv
        rcases hσ.slot12' with hs | hs <;> simp [hi, hs]
    simp only [if_pos h3, if_pos hσ3]
  · refine if h6 : i.val < 6 then ?middle else ?last
    · have hsplit : i.val = 3 ∨ i.val = 4 ∨ i.val = 5 := by omega
      have hσmid : 3 ≤ (σ i).val ∧ (σ i).val < 6 := by
        rcases hsplit with hv | hv | hv
        · have hi : i = 3 := Fin.ext hv
          rcases hσ.slot345 with hs | hs | hs <;> (simp only [hi, hs] <;> decide)
        · have hi : i = 4 := Fin.ext hv
          rcases hσ.slot345' with hs | hs | hs <;> (simp only [hi, hs] <;> decide)
        · have hi : i = 5 := Fin.ext hv
          rcases hσ.slot345'' with hs | hs | hs <;> (simp only [hi, hs] <;> decide)
      have hnot3 : ¬ (σ i).val < 3 := by omega
      simp only [if_neg h3, if_neg hnot3, if_pos h6, if_pos hσmid.2]
    · have hhi : 6 ≤ i.val := by omega
      have hσhi := hσ.slot6 i hhi
      have hnot3 : ¬ (σ i).val < 3 := by omega
      have hnot6 : ¬ (σ i).val < 6 := by omega
      simp only [if_neg h3, if_neg h6, if_neg hnot3, if_neg hnot6]

theorem target_preserved (σ : Fin 12 → Fin 12) (hσ : FixesRow0Blocks σ) (i j : Fin 12) :
    z7ExteriorTarget (σ i) (σ j) = z7ExteriorTarget i j := by
  have hiff : σ i = σ j ↔ i = j := ⟨fun h => hσ.inj i j h, fun h => h ▸ rfl⟩
  simp [z7ExteriorTarget, left_preserved σ hσ, hiff]

theorem sum_two (σ : Fin 12 → Fin 12) (hσ : FixesRow0Blocks σ) (f : Fin 12 → Nat) :
    f (σ 0) + f (σ 1) + f (σ 2) = f 0 + f 1 + f 2 := by
  have hne : σ 1 ≠ σ 2 := fun h => absurd (hσ.inj 1 2 h) (by decide : (1 : Fin 12) ≠ 2)
  rcases hσ.slot12 with h1 | h1 <;> rcases hσ.slot12' with h2 | h2
  · exact absurd (h1.trans h2.symm) hne
  · simp [hσ.fix0, h1, h2]
  · simp [hσ.fix0, h1, h2, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc]
  · exact absurd (h1.trans h2.symm) hne

theorem sum_three (σ : Fin 12 → Fin 12) (hσ : FixesRow0Blocks σ) (f : Fin 12 → Nat) :
    f (σ 3) + f (σ 4) + f (σ 5) = f 3 + f 4 + f 5 := by
  have h12 : σ 3 ≠ σ 4 := fun h => absurd (hσ.inj 3 4 h) (by decide : (3 : Fin 12) ≠ 4)
  have h13 : σ 3 ≠ σ 5 := fun h => absurd (hσ.inj 3 5 h) (by decide : (3 : Fin 12) ≠ 5)
  have h23 : σ 4 ≠ σ 5 := fun h => absurd (hσ.inj 4 5 h) (by decide : (4 : Fin 12) ≠ 5)
  have hmem : ∀ x, x ∈ [σ 3, σ 4, σ 5] → x ∈ ([3, 4, 5] : List (Fin 12)) := by
    intro x hx
    have hx' : x = σ 3 ∨ x = σ 4 ∨ x = σ 5 := by
      simpa [List.mem_cons, List.mem_singleton] using hx
    rcases hx' with rfl | rfl | rfl
    · rcases hσ.slot345 with h | h | h <;> simp [h]
    · rcases hσ.slot345' with h | h | h <;> simp [h]
    · rcases hσ.slot345'' with h | h | h <;> simp [h]
  have hnd : ([σ 3, σ 4, σ 5] : List (Fin 12)).Nodup := by simp [h12, h13, h23]
  have hp := perm_of_nodup_same_members hnd hmem (by simp)
  have hs := sum_map_perm hp f
  simp only [List.map_cons, List.map_nil, List.sum_cons, List.sum_nil] at hs
  calc
    f (σ 3) + f (σ 4) + f (σ 5) = f (σ 3) + (f (σ 4) + f (σ 5)) := by ac_rfl
    _ = f 3 + (f 4 + f 5) := hs
    _ = f 3 + f 4 + f 5 := by ac_rfl

theorem conjPreserves (C : Fin 12 → Fin 12 → Nat) (σ : Fin 12 → Fin 12)
    (hσ : FixesRow0Blocks σ) (hC : ExteriorEquations C) :
    ExteriorEquations (conjMatrix C σ) := by
  obtain ⟨hsym, hbound, hdiag, hsum, hbal, htgt⟩ := hC
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro i j
    simpa [conjMatrix] using hsym (σ i) (σ j)
  · intro i j
    exact hbound (σ i) (σ j)
  · intro i
    exact hdiag (σ i)
  · intro i
    have h := hsum (σ i)
    rw [← sum12_comp σ hσ.inj hσ.surj (C (σ i))] at h
    unfold sum12 conjMatrix
    exact h
  · intro i
    have h := hbal (σ i)
    have hl := sum_two σ hσ (fun j => C (σ i) j)
    have hr := sum_three σ hσ (fun j => C (σ i) j)
    simp only [conjMatrix] at hl hr ⊢
    omega
  · intro i j
    have h := htgt (σ i) (σ j)
    rw [← sum12_comp σ hσ.inj hσ.surj (fun k => C (σ i) k * C (σ j) k),
      target_preserved σ hσ i j] at h
    unfold sum12 conjMatrix
    exact h

theorem row0Relabel_fix0 (C : Fin 12 → Fin 12 → Nat) : row0Relabel C 0 = 0 := by
  simp [row0Relabel, row0Order, List.getElem_append_left]

private theorem list_of_length_two (l : List (Fin 12)) (h : l.length = 2) :
    ∃ a b, l = [a, b] := by
  match l with
  | [] => simp at h
  | a :: [] => simp at h
  | a :: b :: t =>
    match t with
    | [] => exact ⟨a, b, rfl⟩
    | _ :: _ => simp at h

private theorem list_of_length_three (l : List (Fin 12)) (h : l.length = 3) :
    ∃ a b c, l = [a, b, c] := by
  match l with
  | [] => simp at h
  | a :: [] => simp at h
  | a :: b :: [] => simp at h
  | a :: b :: c :: t =>
    match t with
    | [] => exact ⟨a, b, c, rfl⟩
    | _ :: _ => simp at h

private theorem list_of_length_six (l : List (Fin 12)) (h : l.length = 6) :
    ∃ a b c d e f, l = [a, b, c, d, e, f] := by
  match l with
  | a :: b :: c :: d :: e :: f :: t =>
    match t with
    | [] => exact ⟨a, b, c, d, e, f, rfl⟩
    | _ :: _ => simp at h
  | [] | _ :: [] | _ :: _ :: [] | _ :: _ :: _ :: [] | _ :: _ :: _ :: _ :: []
    | _ :: _ :: _ :: _ :: _ :: [] => simp at h

private theorem mem_two (z : Fin 12) (hz : z ∈ ([1, 2] : List (Fin 12))) :
    z = 1 ∨ z = 2 := by
  simpa [List.mem_cons, List.mem_singleton] using hz

private theorem mem_three (z : Fin 12) (hz : z ∈ ([3, 4, 5] : List (Fin 12))) :
    z = 3 ∨ z = 4 ∨ z = 5 := by
  simpa [List.mem_cons, List.mem_singleton] using hz

private theorem block6_val_ge :
    ∀ z : Fin 12, z ∈ [6, 7, 8, 9, 10, 11] → 6 ≤ z.val := by
  decide

private theorem sort_len (xs : List (Fin 12)) (val : Fin 12 → Nat) :
    (sortIdx xs val).length = xs.length :=
  (sortIdx_perm xs val).length_eq

private theorem row0Relabel_values (C : Fin 12 → Fin 12 → Nat) :
    ∃ a b c d e f g h i j k,
      row0Relabel C 1 = a ∧ row0Relabel C 2 = b ∧
      row0Relabel C 3 = c ∧ row0Relabel C 4 = d ∧ row0Relabel C 5 = e ∧
      row0Relabel C 6 = f ∧ row0Relabel C 7 = g ∧ row0Relabel C 8 = h ∧
      row0Relabel C 9 = i ∧ row0Relabel C 10 = j ∧ row0Relabel C 11 = k ∧
      sortIdx [1, 2] (C 0) = [a, b] ∧
      sortIdx [3, 4, 5] (C 0) = [c, d, e] ∧
      sortIdx [6, 7, 8, 9, 10, 11] (C 0) = [f, g, h, i, j, k] ∧
      a ∈ ([1, 2] : List (Fin 12)) ∧ b ∈ [1, 2] ∧
      c ∈ ([3, 4, 5] : List (Fin 12)) ∧ d ∈ [3, 4, 5] ∧ e ∈ [3, 4, 5] ∧
      f ∈ ([6, 7, 8, 9, 10, 11] : List (Fin 12)) ∧ g ∈ [6, 7, 8, 9, 10, 11] ∧
      h ∈ [6, 7, 8, 9, 10, 11] ∧ i ∈ [6, 7, 8, 9, 10, 11] ∧
      j ∈ [6, 7, 8, 9, 10, 11] ∧ k ∈ [6, 7, 8, 9, 10, 11] := by
  let l12 := sortIdx [1, 2] (C 0)
  let l345 := sortIdx [3, 4, 5] (C 0)
  let l6 := sortIdx [6, 7, 8, 9, 10, 11] (C 0)
  obtain ⟨a, b, hab⟩ := list_of_length_two l12 (sort_len _ _)
  obtain ⟨c, d, e, hcde⟩ := list_of_length_three l345 (sort_len _ _)
  obtain ⟨f, g, h, i, j, k, hfgijk⟩ := list_of_length_six l6 (sort_len _ _)
  have hab' : sortIdx [1, 2] (C 0) = [a, b] := by simpa [l12] using hab
  have hcde' : sortIdx [3, 4, 5] (C 0) = [c, d, e] := by simpa [l345] using hcde
  have hfgijk' : sortIdx [6, 7, 8, 9, 10, 11] (C 0) = [f, g, h, i, j, k] := by simpa [l6] using hfgijk
  have ma : a ∈ ([1, 2] : List (Fin 12)) := by
    apply (sortIdx_mem [1, 2] (C 0) a).mp
    rw [hab']
    simp
  have mb : b ∈ ([1, 2] : List (Fin 12)) := by
    apply (sortIdx_mem [1, 2] (C 0) b).mp
    rw [hab']
    simp
  have mc : c ∈ ([3, 4, 5] : List (Fin 12)) := by
    apply (sortIdx_mem [3, 4, 5] (C 0) c).mp
    rw [hcde']
    simp
  have md : d ∈ ([3, 4, 5] : List (Fin 12)) := by
    apply (sortIdx_mem [3, 4, 5] (C 0) d).mp
    rw [hcde']
    simp
  have me : e ∈ ([3, 4, 5] : List (Fin 12)) := by
    apply (sortIdx_mem [3, 4, 5] (C 0) e).mp
    rw [hcde']
    simp
  have mf : f ∈ ([6, 7, 8, 9, 10, 11] : List (Fin 12)) := by
    apply (sortIdx_mem [6, 7, 8, 9, 10, 11] (C 0) f).mp
    rw [hfgijk']
    simp
  have mg : g ∈ ([6, 7, 8, 9, 10, 11] : List (Fin 12)) := by
    apply (sortIdx_mem [6, 7, 8, 9, 10, 11] (C 0) g).mp
    rw [hfgijk']
    simp
  have mh : h ∈ ([6, 7, 8, 9, 10, 11] : List (Fin 12)) := by
    apply (sortIdx_mem [6, 7, 8, 9, 10, 11] (C 0) h).mp
    rw [hfgijk']
    simp
  have mi : i ∈ ([6, 7, 8, 9, 10, 11] : List (Fin 12)) := by
    apply (sortIdx_mem [6, 7, 8, 9, 10, 11] (C 0) i).mp
    rw [hfgijk']
    simp
  have mj : j ∈ ([6, 7, 8, 9, 10, 11] : List (Fin 12)) := by
    apply (sortIdx_mem [6, 7, 8, 9, 10, 11] (C 0) j).mp
    rw [hfgijk']
    simp
  have mk : k ∈ ([6, 7, 8, 9, 10, 11] : List (Fin 12)) := by
    apply (sortIdx_mem [6, 7, 8, 9, 10, 11] (C 0) k).mp
    rw [hfgijk']
    simp
  have horder : row0Order C = [0, a, b, c, d, e, f, g, h, i, j, k] := by
    simp only [row0Order, hab', hcde', hfgijk', List.append_assoc]
    rfl
  have h1 : row0Relabel C 1 = a := by simp [row0Relabel, horder] <;> rfl
  have h2 : row0Relabel C 2 = b := by simp [row0Relabel, horder] <;> rfl
  have h3 : row0Relabel C 3 = c := by simp [row0Relabel, horder] <;> rfl
  have h4 : row0Relabel C 4 = d := by simp [row0Relabel, horder] <;> rfl
  have h5 : row0Relabel C 5 = e := by simp [row0Relabel, horder] <;> rfl
  have h6 : row0Relabel C 6 = f := by simp [row0Relabel, horder] <;> rfl
  have h7 : row0Relabel C 7 = g := by simp [row0Relabel, horder] <;> rfl
  have h8 : row0Relabel C 8 = h := by simp [row0Relabel, horder] <;> rfl
  have h9 : row0Relabel C 9 = i := by simp [row0Relabel, horder] <;> rfl
  have h10 : row0Relabel C 10 = j := by simp [row0Relabel, horder] <;> rfl
  have h11 : row0Relabel C 11 = k := by simp [row0Relabel, horder] <;> rfl
  exact ⟨a, b, c, d, e, f, g, h, i, j, k, h1, h2, h3, h4, h5, h6, h7, h8,
    h9, h10, h11, hab', hcde', hfgijk', ma, mb, mc, md, me, mf, mg, mh, mi, mj, mk⟩

theorem row0Relabel_fixesBlocks (C : Fin 12 → Fin 12 → Nat) :
    FixesRow0Blocks (row0Relabel C) := by
  obtain ⟨a, b, c, d, e, f, g, h, i, j, k, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11,
    hab, hcde, hfgijk, ma, mb, mc, md, me, mf, mg, mh, mi, mj, mk⟩ := row0Relabel_values C
  refine ⟨(fun a b h => row0Relabel_inj C h), (fun y => row0Relabel_surj C y), row0Relabel_fix0 C, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · rcases mem_two a ma with rfl | rfl <;> simp [h1]
  · rcases mem_two b mb with rfl | rfl <;> simp [h2]
  · rcases mem_three c mc with rfl | rfl | rfl <;> simp [h3]
  · rcases mem_three d md with rfl | rfl | rfl <;> simp [h4]
  · rcases mem_three e me with rfl | rfl | rfl <;> simp [h5]
  · intro x hx
    have hcases : x = 6 ∨ x = 7 ∨ x = 8 ∨ x = 9 ∨ x = 10 ∨ x = 11 := by omega
    rcases hcases with rfl | rfl | rfl | rfl | rfl | rfl
    · simpa [h6] using block6_val_ge f mf
    · simpa [h7] using block6_val_ge g mg
    · simpa [h8] using block6_val_ge h mh
    · simpa [h9] using block6_val_ge i mi
    · simpa [h10] using block6_val_ge j mj
    · simpa [h11] using block6_val_ge k mk

theorem row0Relabel_sorted (C : Fin 12 → Fin 12 → Nat) :
    Nondecreasing [conjMatrix C (row0Relabel C) 0 1, conjMatrix C (row0Relabel C) 0 2] ∧
    Nondecreasing [conjMatrix C (row0Relabel C) 0 3, conjMatrix C (row0Relabel C) 0 4, conjMatrix C (row0Relabel C) 0 5] ∧
    Nondecreasing [conjMatrix C (row0Relabel C) 0 6, conjMatrix C (row0Relabel C) 0 7,
      conjMatrix C (row0Relabel C) 0 8, conjMatrix C (row0Relabel C) 0 9,
      conjMatrix C (row0Relabel C) 0 10, conjMatrix C (row0Relabel C) 0 11] := by
  obtain ⟨a, b, c, d, e, f, g, h, i, j, k, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11,
    hab, hcde, hfgijk, ma, mb, mc, md, me, mf, mg, mh, mi, mj, mk⟩ := row0Relabel_values C
  have hp := sortIdx_values_nondec [1, 2] (C 0)
  have hm := sortIdx_values_nondec [3, 4, 5] (C 0)
  have ht := sortIdx_values_nondec [6, 7, 8, 9, 10, 11] (C 0)
  have hp' : Nondecreasing [C 0 a, C 0 b] := by simpa [hab] using hp
  have hm' : Nondecreasing [C 0 c, C 0 d, C 0 e] := by simpa [hcde] using hm
  have ht' : Nondecreasing [C 0 f, C 0 g, C 0 h, C 0 i, C 0 j, C 0 k] := by simpa [hfgijk] using ht
  have hfix : row0Relabel C 0 = 0 := row0Relabel_fix0 C
  constructor
  · simpa [conjMatrix, hfix, h1, h2] using hp'
  constructor
  · simpa [conjMatrix, hfix, h3, h4, h5] using hm'
  · simpa [conjMatrix, hfix, h6, h7, h8, h9, h10, h11] using ht'

#print axioms perm_sum
#print axioms sum12_comp
#print axioms left_preserved
#print axioms sum_two
#print axioms sum_three
#print axioms conjPreserves
#print axioms sortIdx_perm
#print axioms row0Relabel_fixesBlocks
#print axioms row0Relabel_sorted

end Matrix99
