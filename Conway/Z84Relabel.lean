/-
  Conway's 99-Graph Problem Formalization in Lean 4
  Relabelling theorem: every ConwayAdj matrix is a vertex relabelling of block_A X.
-/
import Conway.Z84Subconstituent
import Conway.Structural

namespace Matrix99

set_option maxRecDepth 100000

/-! ### Generic list lemmas -/

/-- A 0/1-valued foldl sum equals the length of the filtered list. -/
theorem foldl01_eq_filter_length {α : Type} (f : α → Nat) (l : List α)
    (h : ∀ x ∈ l, f x = 0 ∨ f x = 1) :
    l.foldl (fun a x => a + f x) 0 = (l.filter fun x => f x == 1).length := by
  induction l with
  | nil => rfl
  | cons z zs ih =>
    rw [foldl_cons, List.filter_cons]
    have hz := h z (List.mem_cons.mpr (Or.inl rfl))
    cases e : (f z == 1)
    · rw [if_neg Bool.false_ne_true]
      have hf0 : f z = 0 := by
        rcases hz with h0 | h1
        · exact h0
        · rw [beq_iff_eq.mpr h1] at e
          exact Bool.noConfusion e
      rw [hf0, ih (fun x hx => h x (List.mem_cons.mpr (Or.inr hx)))]
      omega
    · rw [if_pos rfl, List.length_cons]
      have hf1 : f z = 1 := beq_iff_eq.mp e
      rw [hf1, ih (fun x hx => h x (List.mem_cons.mpr (Or.inr hx)))]
      omega

/-- Lower bound on a foldl sum by three distinct members of a nodup list. -/
theorem foldl_ge_three_of_mem_distinct {α : Type} (f : α → Nat) {l : List α}
    (hnodup : l.Nodup) {x y z : α} (hxy : x ≠ y) (hxz : x ≠ z) (hyz : y ≠ z)
    (hx : x ∈ l) (hy : y ∈ l) (hz : z ∈ l) :
    l.foldl (fun a w => a + f w) 0 ≥ f x + f y + f z := by
  induction l with
  | nil => contradiction
  | cons c cs ih =>
    rw [foldl_cons]
    have hnd := List.nodup_cons.mp hnodup
    rcases List.mem_cons.mp hx with rfl | hx'
    · have hy' : y ∈ cs := by
        rcases List.mem_cons.mp hy with h | h
        · exact absurd h hxy.symm
        · exact h
      have hz' : z ∈ cs := by
        rcases List.mem_cons.mp hz with h | h
        · exact absurd h hxz.symm
        · exact h
      have hge := foldl_ge_two_of_mem_distinct f hnd.2 hyz hy' hz'
      omega
    · rcases List.mem_cons.mp hy with rfl | hy'
      · have hx'' : x ∈ cs := hx'
        have hz' : z ∈ cs := by
          rcases List.mem_cons.mp hz with h | h
          · exact absurd h hyz.symm
          · exact h
        have hge := foldl_ge_two_of_mem_distinct f hnd.2 hxz hx'' hz'
        omega
      · rcases List.mem_cons.mp hz with rfl | hz'
        · have hy'' : y ∈ cs := hy'
          have hge := foldl_ge_two_of_mem_distinct f hnd.2 hxy hx' hy''
          omega
        · have hge := ih hnd.2 hx' hy' hz'
          omega

/-- A sum equal to 2 with one known unit contributor forces a second contributor. -/
theorem foldl_two_exists_second {α : Type} (f : α → Nat) {l : List α} (hnd : l.Nodup)
    {x : α} (hx : x ∈ l) (hfx : f x = 1)
    (hsum : l.foldl (fun a w => a + f w) 0 = 2) :
    ∃ y ∈ l, y ≠ x ∧ f y > 0 := by
  induction l with
  | nil => contradiction
  | cons c cs ih =>
    rw [foldl_cons] at hsum
    have hnd' := List.nodup_cons.mp hnd
    rcases List.mem_cons.mp hx with rfl | hx'
    · rw [hfx] at hsum
      have hpos : cs.foldl (fun a w => a + f w) 0 > 0 := by omega
      rcases foldl_pos_exists f cs hpos with ⟨y, hym, hyf⟩
      refine ⟨y, List.mem_cons.mpr (Or.inr hym), ?_, hyf⟩
      intro e
      subst e
      exact hnd'.1 hym
    · rcases Nat.eq_zero_or_pos (f c) with hz | hz
      · rw [hz, Nat.zero_add] at hsum
        rcases ih hnd'.2 hx' hsum with ⟨y, hym, hyne, hyf⟩
        exact ⟨y, List.mem_cons.mpr (Or.inr hym), hyne, hyf⟩
      · refine ⟨c, List.mem_cons.mpr (Or.inl rfl), ?_, hz⟩
        intro e
        subst e
        exact hnd'.1 hx'

/-- Filter lengths of complementary predicates add up to the length. -/
theorem length_filter_add_not {α : Type} (p : α → Bool) (l : List α) :
    (l.filter p).length + (l.filter fun a => !(p a)).length = l.length := by
  induction l with
  | nil => rfl
  | cons z zs ih =>
    rw [List.filter_cons, List.filter_cons]
    cases e : p z
    · rw [if_neg Bool.false_ne_true, show (!(false : Bool)) = true from rfl,
        if_pos rfl, List.length_cons, List.length_cons]
      have hih := ih
      omega
    · rw [if_pos rfl, show (!(true : Bool)) = false from rfl,
        if_neg Bool.false_ne_true, List.length_cons, List.length_cons]
      have hih := ih
      omega

/-- Choice-free erase membership for a distinct element. -/
theorem mem_erase_of_ne {α : Type} [BEq α] [LawfulBEq α] {l : List α} {a x : α}
    (hne : a ≠ x) : a ∈ l.erase x ↔ a ∈ l := by
  induction l with
  | nil => exact Iff.rfl
  | cons y ys ih =>
    rw [List.erase_cons]
    cases hyx : (y == x)
    · rw [if_neg Bool.false_ne_true, List.mem_cons, List.mem_cons]
      constructor
      · rintro (rfl | hm)
        · exact Or.inl rfl
        · exact Or.inr (ih.mp hm)
      · rintro (rfl | hm)
        · exact Or.inl rfl
        · exact Or.inr (ih.mpr hm)
    · rw [if_pos rfl]
      constructor
      · intro hm
        exact List.mem_cons.mpr (Or.inr hm)
      · intro hm
        rw [List.mem_cons] at hm
        rcases hm with rfl | h'
        · exact absurd (beq_iff_eq.mp hyx) hne
        · exact h'

/-- Choice-free: erase members are members. -/
theorem mem_of_mem_erase {α : Type} [BEq α] [LawfulBEq α] {l : List α} {a x : α}
    (h : a ∈ l.erase x) : a ∈ l := by
  induction l with
  | nil => exact h
  | cons y ys ih =>
    rw [List.erase_cons] at h
    cases hyx : (y == x)
    · rw [hyx, if_neg Bool.false_ne_true] at h
      rw [List.mem_cons] at h
      rcases h with rfl | hm
      · exact List.mem_cons.mpr (Or.inl rfl)
      · exact List.mem_cons.mpr (Or.inr (ih hm))
    · rw [hyx, if_pos rfl] at h
      exact List.mem_cons.mpr (Or.inr h)

/-- Choice-free: `x` is not in `l.erase x` for nodup `l`. -/
theorem not_mem_erase_self {α : Type} [BEq α] [LawfulBEq α] {l : List α} {x : α}
    (hl : l.Nodup) : x ∉ l.erase x := by
  induction l with
  | nil => intro h; exact nomatch h
  | cons y ys ih =>
    have hnd := List.nodup_cons.mp hl
    rw [List.erase_cons]
    cases hyx : (y == x)
    · rw [if_neg Bool.false_ne_true, List.mem_cons]
      rintro (h1 | h2)
      · exact absurd h1.symm
          (fun e => Bool.noConfusion (hyx ▸ beq_iff_eq.mpr e))
      · exact ih hnd.2 h2
    · rw [if_pos rfl]
      have hya : y = x := beq_iff_eq.mp hyx
      intro h
      exact hnd.1 (hya ▸ h)

/-- Choice-free length of `List.erase` at a member. -/
theorem length_erase_mem {α : Type} [BEq α] [LawfulBEq α] {l : List α} {a : α}
    (h : a ∈ l) : (l.erase a).length = l.length - 1 := by
  induction l with
  | nil => exact nomatch h
  | cons y ys ih =>
    rw [List.erase_cons, List.length_cons]
    cases hyx : (y == a)
    · rw [if_neg Bool.false_ne_true, List.length_cons]
      rw [List.mem_cons] at h
      rcases h with rfl | hm
      · exact absurd rfl
          (fun e => Bool.noConfusion (hyx ▸ beq_iff_eq.mpr e))
      · rw [ih hm]
        have hp := List.length_pos_of_mem hm
        omega
    · rw [if_pos rfl, Nat.add_sub_cancel]

/-- `l` is a permutation of `a :: l.erase a` when `a ∈ l`. -/
theorem erase_cons_perm {α : Type} [BEq α] [LawfulBEq α] {a : α} {l : List α}
    (h : a ∈ l) : l.Perm (a :: l.erase a) := by
  induction l with
  | nil => exact nomatch h
  | cons y ys ih =>
    rw [List.erase_cons]
    rw [List.mem_cons] at h
    cases hyx : (y == a)
    · rw [if_neg Bool.false_ne_true]
      rcases h with rfl | hm
      · exact absurd rfl
          (fun e => Bool.noConfusion (hyx ▸ beq_iff_eq.mpr e))
      · exact (List.Perm.cons y (ih hm)).trans (List.Perm.swap _ _ _)
    · rw [if_pos rfl]
      rw [beq_iff_eq.mp hyx]

/-- Choice-free `Perm` from equal membership on nodup lists. -/
theorem my_perm_ext {α : Type} [BEq α] [LawfulBEq α] {l m : List α}
    (hl : l.Nodup) (hm : m.Nodup) (hs : ∀ a, a ∈ l ↔ a ∈ m) : l.Perm m := by
  induction l generalizing m with
  | nil =>
    rcases m with _ | ⟨x, xs⟩
    · exact List.Perm.refl _
    · exfalso
      have hxm : x ∈ x :: xs := List.mem_cons.mpr (Or.inl rfl)
      exact absurd ((hs x).mpr hxm) List.not_mem_nil
  | cons x xs ih =>
    have hnd := List.nodup_cons.mp hl
    have hxm : x ∈ m := (hs x).mp (List.mem_cons.mpr (Or.inl rfl))
    have hsub : ∀ a, a ∈ xs ↔ a ∈ m.erase x := by
      intro a
      constructor
      · intro ha
        have hne : a ≠ x := fun e => by rw [e] at ha; exact hnd.1 ha
        exact (mem_erase_of_ne hne).mpr
          ((hs a).mp (List.mem_cons.mpr (Or.inr ha)))
      · intro h
        have ham : a ∈ m := mem_of_mem_erase h
        have hne : a ≠ x := fun e =>
          not_mem_erase_self hm (e ▸ h)
        have hmem := (hs a).mpr ham
        rw [List.mem_cons] at hmem
        rcases hmem with he | ha
        · exact absurd he hne
        · exact ha
    have hpm := ih hnd.2 (hm.erase x) hsub
    exact (List.Perm.cons x hpm).trans (erase_cons_perm hxm).symm

theorem nodup_sub_length_le {α : Type} [BEq α] [LawfulBEq α] {l m : List α}
    (hl : l.Nodup) (hm : m.Nodup) (hs : ∀ a ∈ l, a ∈ m) : l.length ≤ m.length := by
  induction l generalizing m with
  | nil => exact Nat.zero_le _
  | cons x xs ih =>
    have hnd := List.nodup_cons.mp hl
    have hxm : x ∈ m := hs x (List.mem_cons.mpr (Or.inl rfl))
    have hmpos : m.length > 0 := List.length_pos_of_mem hxm
    have hsub : ∀ a ∈ xs, a ∈ m.erase x := by
      intro a ha
      have ham : a ∈ m := hs a (List.mem_cons.mpr (Or.inr ha))
      have hne : a ≠ x := fun e => by subst e; exact hnd.1 ha
      exact (mem_erase_of_ne hne).mpr ham
    have ih' := ih hnd.2 (hm.erase x) hsub
    have hlen := length_erase_mem hxm
    rw [List.length_cons]
    omega

/-- Map preserves Nodup under on-list injectivity. -/
theorem nodup_map_injOn {α β : Type} {f : α → β} {l : List α} (hn : l.Nodup)
    (hinj : ∀ a ∈ l, ∀ b ∈ l, f a = f b → a = b) : (l.map f).Nodup := by
  induction l with
  | nil => exact List.nodup_nil
  | cons x xs ih =>
    have hnd := List.nodup_cons.mp hn
    rw [List.map_cons, List.nodup_cons]
    refine ⟨?_, ih hnd.2 (fun a ha b hb h =>
      hinj a (List.mem_cons.mpr (Or.inr ha)) b (List.mem_cons.mpr (Or.inr hb)) h)⟩
    intro hmem
    rcases List.mem_map.mp hmem with ⟨b, hb, hfb⟩
    have hb_eq : b = x := hinj b (List.mem_cons.mpr (Or.inr hb)) x
      (List.mem_cons.mpr (Or.inl rfl)) hfb
    subst hb_eq
    exact hnd.1 hb

/-- foldl sum is invariant under permutation. -/
theorem foldl_perm {α : Type} (f : α → Nat) {l₁ l₂ : List α} (h : l₁.Perm l₂) :
    l₁.foldl (fun a x => a + f x) 0 = l₂.foldl (fun a x => a + f x) 0 := by
  induction h with
  | nil => rfl
  | cons x _ ih => rw [foldl_cons, foldl_cons, ih]
  | swap x y l =>
    rw [foldl_cons, foldl_cons, foldl_cons, foldl_cons]
    omega
  | trans _ _ ih1 ih2 => rw [ih1, ih2]

/-- getD through an append, left part. -/
theorem getD_append_left {α : Type} (l₁ l₂ : List α) (d : α) (k : Nat)
    (hk : k < l₁.length) : (l₁ ++ l₂).getD k d = l₁.getD k d := by
  rw [List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD,
      List.getElem?_append_left hk]

/-- getD through an append, right part. -/
theorem getD_append_right {α : Type} (l₁ l₂ : List α) (d : α) (k : Nat)
    (hk : l₁.length ≤ k) : (l₁ ++ l₂).getD k d = l₂.getD (k - l₁.length) d := by
  rw [List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD,
      List.getElem?_append_right hk]

/-- getD through a flatMap with constant block length. -/
theorem flatMap_getD_gen {α β : Type} (l : List α) (g : α → List β) (n : Nat)
    (hlen : ∀ x ∈ l, (g x).length = n) (i j : Nat)
    (hi : i < l.length) (hj : j < n) (da : α) (db : β) :
    (l.flatMap g).getD (i * n + j) db = (g (l.getD i da)).getD j db := by
  have aux : ∀ l : List α, (∀ x ∈ l, (g x).length = n) → ∀ i,
      i < l.length →
      (l.flatMap g).getD (i * n + j) db = (g (l.getD i da)).getD j db := by
    intro l
    induction l with
    | nil => intro _ i hi; exact absurd (by simpa using hi) (Nat.not_lt_zero i)
    | cons x xs ih =>
      intro hlen i hi
      have hxn : (g x).length = n := hlen x (List.mem_cons.mpr (Or.inl rfl))
      have hlen' : ∀ x' ∈ xs, (g x').length = n :=
        fun x' h => hlen x' (List.mem_cons.mpr (Or.inr h))
      rw [List.flatMap_cons]
      cases i with
      | zero =>
        rw [Nat.zero_mul, Nat.zero_add,
            getD_append_left (g x) (xs.flatMap g) db j (by rw [hxn]; exact hj),
            List.getD_cons_zero]
      | succ i =>
        have hi' : i < xs.length := by
          have h := hi; rw [List.length_cons] at h; omega
        rw [getD_append_right (g x) (xs.flatMap g) db ((i + 1) * n + j)
            (by rw [hxn, Nat.succ_mul]; omega)]
        have he : (i + 1) * n + j - (g x).length = i * n + j := by
          rw [hxn, Nat.succ_mul]; omega
        rw [he, List.getD_cons_succ, ih hlen' i hi']
  exact aux l hlen i hi

/-- getD over List.finRange. -/
theorem getD_finRange {n i : Nat} (h : i < n) (d : Fin n) :
    (List.finRange n).getD i d = ⟨i, h⟩ := by
  rw [List.getD_eq_getElem?_getD,
      List.getElem?_eq_getElem (by rw [List.length_finRange]; exact h)]
  rw [List.getElem_finRange]
  rfl

/-- Sum of a constant-2 map equals twice the length. -/
theorem map_const_two_sum {α : Type} (l : List α) :
    (l.map fun _ => 2).sum = 2 * l.length := by
  induction l with
  | nil => rfl
  | cons x xs ih =>
    rw [List.map_cons, List.sum_cons, ih, List.length_cons, Nat.mul_succ]
    omega

/-! ### The neighborhood of the root -/

variable (A : Matrix99 Nat)

/-- Neighbors of the root as a list. -/
def relN : List (Fin 99) := (List.finRange 99).filter fun v => A rootV v == 1

theorem relN_mem (v : Fin 99) : v ∈ relN A ↔ A rootV v = 1 := by
  unfold relN
  rw [List.mem_filter]
  constructor
  · exact fun h => beq_iff_eq.mp h.2
  · exact fun h => ⟨List.mem_finRange v, beq_iff_eq.mpr h⟩

theorem relN_length (hA : ConwayAdj A) : (relN A).length = 14 := by
  have hd : mul A A rootV rootV = 14 := conway_vertex_degree A hA rootV
  have e : (List.finRange 99).foldl (fun acc k => acc + A rootV k * A k rootV) 0
        = (List.finRange 99).foldl (fun acc k => acc + A rootV k) 0 := by
    apply foldl_congr
    intro k _
    rcases hA.2.2.1 rootV k with h0 | h1
    · rw [h0, Nat.zero_mul]
    · have hs : A k rootV = 1 := by rw [hA.2.1 k rootV]; exact h1
      rw [h1, hs]
  have hf : ∀ k ∈ List.finRange 99, A rootV k = 0 ∨ A rootV k = 1 :=
    fun k _ => hA.2.2.1 rootV k
  have h := foldl01_eq_filter_length (fun k => A rootV k) (List.finRange 99) hf
  unfold mul at hd
  rw [e] at hd
  unfold relN
  rw [← h]
  exact hd

/-! ### The partner involution on the neighborhood -/

/-- The unique common neighbor of the root and u, found computably. -/
def relPartner (u : Fin 99) : Fin 99 :=
  ((List.finRange 99).find? fun w => A rootV w == 1 && A u w == 1).getD u

theorem relPartner_spec (hA : ConwayAdj A) (u : Fin 99) (hu : A rootV u = 1) :
    A rootV (relPartner A u) = 1 ∧ A u (relPartner A u) = 1 := by
  have hux : rootV ≠ u := adjacent_ne A hA rootV u hu
  have ⟨w, hwu, hwx⟩ := conway_common_neighbor_exists A hA rootV u hux hu
  have hpred : (A rootV w == 1 && A u w == 1) = true := by
    rw [hwx, hwu]
    rfl
  have hsome : ((List.finRange 99).find?
      fun w => A rootV w == 1 && A u w == 1).isSome = true :=
    (List.find?_isSome).mpr ⟨w, List.mem_finRange w, hpred⟩
  rcases Option.isSome_iff_exists.mp hsome with ⟨w', hw'⟩
  have hspec := List.find?_some hw'
  have hval : relPartner A u = w' := by
    unfold relPartner
    rw [hw']
    rfl
  rw [hval]
  have ⟨h1, h2⟩ := Bool.and_eq_true_iff.mp hspec
  exact ⟨beq_iff_eq.mp h1, beq_iff_eq.mp h2⟩

theorem relPartner_unique (hA : ConwayAdj A) (u w : Fin 99) (hu : A rootV u = 1)
    (hw : A rootV w = 1) (huw : A u w = 1) :
    w = relPartner A u := by
  have ⟨hp1, hp2⟩ := relPartner_spec A hA u hu
  exact conway_common_neighbors_unique A hA rootV u
    (adjacent_ne A hA rootV u hu) hu w (relPartner A u) ⟨huw, hw⟩ ⟨hp2, hp1⟩

theorem relPartner_ne_self (hA : ConwayAdj A) (u : Fin 99) (hu : A rootV u = 1) :
    relPartner A u ≠ u := by
  have ⟨_, hp2⟩ := relPartner_spec A hA u hu
  intro e
  rw [e] at hp2
  have h := hA.1 u
  rw [h] at hp2
  exact Nat.zero_ne_one hp2

theorem relPartner_invol (hA : ConwayAdj A) (u : Fin 99) (hu : A rootV u = 1) :
    relPartner A (relPartner A u) = u := by
  have ⟨hp1, hp2⟩ := relPartner_spec A hA u hu
  have hpu_u : A (relPartner A u) u = 1 := by rw [hA.2.1]; exact hp2
  have h := relPartner_unique A hA (relPartner A u) u hp1 hu hpu_u
  exact h.symm

theorem relPartner_mem_N (hA : ConwayAdj A) (u : Fin 99) (hu : A rootV u = 1) :
    relPartner A u ∈ relN A := (relN_mem A _).mpr (relPartner_spec A hA u hu).1

theorem relPartner_adj_N (hA : ConwayAdj A) (u : Fin 99) (hu : A rootV u = 1) :
    A rootV (relPartner A u) = 1 := (relPartner_spec A hA u hu).1

end Matrix99

namespace Matrix99

variable (A : Matrix99 Nat)

/-! ### The ordered neighborhood list -/

/-- The smaller member of each matched pair in N. -/
def relFirsts : List (Fin 99) :=
  (relN A).filter fun u => decide (u.val < (relPartner A u).val)

/-- The larger member of each matched pair in N. -/
def relSeconds : List (Fin 99) :=
  (relN A).filter fun u => !(decide (u.val < (relPartner A u).val))

/-- The 14 neighbors listed pair by pair: [u, partner u, v, partner v, ...]. -/
def relOrd : List (Fin 99) := (relFirsts A).flatMap fun u => [u, relPartner A u]

/-- Access to the ordered neighborhood. -/
def ordAt (a : Nat) : Fin 99 := (relOrd A).getD a rootV

theorem relFirsts_mem (u : Fin 99) :
    u ∈ relFirsts A ↔ A rootV u = 1 ∧ u.val < (relPartner A u).val := by
  unfold relFirsts
  rw [List.mem_filter, relN_mem]
  constructor
  · exact fun h => ⟨h.1, of_decide_eq_true h.2⟩
  · exact fun h => ⟨h.1, decide_eq_true h.2⟩

theorem relSeconds_mem (u : Fin 99) :
    u ∈ relSeconds A ↔ A rootV u = 1 ∧ ¬ u.val < (relPartner A u).val := by
  unfold relSeconds
  rw [List.mem_filter, relN_mem]
  constructor
  · intro h
    refine ⟨h.1, ?_⟩
    intro hlt
    have : (decide (u.val < (relPartner A u).val)) = true := decide_eq_true hlt
    have h2 := h.2
    rw [this] at h2
    exact Bool.noConfusion h2
  · intro h
    refine ⟨h.1, ?_⟩
    cases e : decide (u.val < (relPartner A u).val)
    · rfl
    · exact absurd (of_decide_eq_true e) h.2

theorem relOrd_nodup_go (hA : ConwayAdj A) (l : List (Fin 99))
    (hsub : ∀ u ∈ l, A rootV u = 1 ∧ u.val < (relPartner A u).val)
    (hnodup : l.Nodup) :
    (l.flatMap fun u => [u, relPartner A u]).Nodup := by
  induction l with
  | nil => exact List.nodup_nil
  | cons u us ih =>
    rw [List.flatMap_cons]
    have hnd := List.nodup_cons.mp hnodup
    have hu := hsub u (List.mem_cons.mpr (Or.inl rfl))
    have hsub' : ∀ v ∈ us, A rootV v = 1 ∧ v.val < (relPartner A v).val :=
      fun v hv => hsub v (List.mem_cons.mpr (Or.inr hv))
    apply nodup_append
    · rw [List.nodup_cons]
      refine ⟨fun h => ?_, List.nodup_cons.mpr ⟨List.not_mem_nil, List.nodup_nil⟩⟩
      have h2 : u = relPartner A u := List.mem_singleton.mp h
      exact (relPartner_ne_self A hA u hu.1) h2.symm
    · exact ih hsub' hnd.2
    · intro a ha b hb
      rcases List.mem_flatMap.mp hb with ⟨v, hv, hbv⟩
      have hvv := hsub' v hv
      have hne : u ≠ v := fun e => by subst e; exact hnd.1 hv
      rcases List.mem_cons.mp ha with rfl | ha'
      · rcases List.mem_cons.mp hbv with rfl | hbv'
        · exact hne
        · have hbv'' : b = relPartner A v := List.mem_singleton.mp hbv'
          rw [hbv'']
          intro e
          have h2 : relPartner A a = v := by
            have h3 := congrArg (relPartner A) e
            rw [relPartner_invol A hA v hvv.1] at h3
            exact h3
          have h4 : a.val = (relPartner A v).val := congrArg Fin.val e
          have c1 : a.val < (relPartner A a).val := hu.2
          rw [h2] at c1
          have c2 : v.val < (relPartner A v).val := hvv.2
          rw [← h4] at c2
          omega
      · have ha'' : a = relPartner A u := List.mem_singleton.mp ha'
        rw [ha'']
        rcases List.mem_cons.mp hbv with rfl | hbv'
        · intro e
          have h2 : relPartner A b = u := by
            have h3 := congrArg (relPartner A) e
            rw [relPartner_invol A hA u hu.1] at h3
            exact h3.symm
          have h4 : (relPartner A u).val = b.val := congrArg Fin.val e
          have c1 : u.val < (relPartner A u).val := hu.2
          rw [h4] at c1
          have c2 : b.val < (relPartner A b).val := hvv.2
          rw [h2] at c2
          omega
        · have hbv'' : b = relPartner A v := List.mem_singleton.mp hbv'
          rw [hbv'']
          intro e
          have h2 : u = v := by
            have e2 := congrArg (relPartner A) e
            rw [relPartner_invol A hA u hu.1, relPartner_invol A hA v hvv.1] at e2
            exact e2
          exact hne h2

theorem relOrd_nodup (hA : ConwayAdj A) : (relOrd A).Nodup :=
  relOrd_nodup_go A hA (relFirsts A) (fun u hu => relFirsts_mem A u |>.mp hu)
    ((List.nodup_finRange 99).sublist (List.filter_sublist.trans List.filter_sublist))

theorem relOrd_mem (hA : ConwayAdj A) (v : Fin 99) :
    v ∈ relOrd A ↔ A rootV v = 1 := by
  constructor
  · intro h
    rcases List.mem_flatMap.mp h with ⟨u, hu, hv⟩
    have hu' := (relFirsts_mem A u).mp hu
    rcases List.mem_cons.mp hv with rfl | hv'
    · exact hu'.1
    · have : v = relPartner A u := List.mem_singleton.mp hv'
      rw [this]
      exact (relPartner_spec A hA u hu'.1).1
  · intro hv
    rcases Nat.lt_or_ge v.val (relPartner A v).val with hlt | hge
    · apply List.mem_flatMap.mpr
      exact ⟨v, (relFirsts_mem A v).mpr ⟨hv, hlt⟩,
        List.mem_cons.mpr (Or.inl rfl)⟩
    · apply List.mem_flatMap.mpr
      have hlt : (relPartner A v).val < v.val := by
        have hne := relPartner_ne_self A hA v hv
        have hnv : (relPartner A v).val ≠ v.val := fun e => hne (Fin.ext e)
        omega
      refine ⟨relPartner A v, (relFirsts_mem A _).mpr ⟨?_, ?_⟩, ?_⟩
      · exact (relPartner_spec A hA v hv).1
      · rw [relPartner_invol A hA v hv]
        exact hlt
      · exact List.mem_cons.mpr
          (Or.inr (List.mem_singleton.mpr (relPartner_invol A hA v hv).symm))

theorem relFirsts_seconds_len (hA : ConwayAdj A) :
    (relFirsts A).length + (relSeconds A).length = 14 := by
  unfold relFirsts relSeconds
  rw [length_filter_add_not]
  exact relN_length A hA

theorem relFirsts_map_perm_seconds (hA : ConwayAdj A) :
    ((relFirsts A).map (relPartner A)).Perm (relSeconds A) := by
  have hndF : (relFirsts A).Nodup :=
    (List.nodup_finRange 99).sublist (List.filter_sublist.trans List.filter_sublist)
  have hndS : (relSeconds A).Nodup :=
    (List.nodup_finRange 99).sublist (List.filter_sublist.trans List.filter_sublist)
  have hndM : ((relFirsts A).map (relPartner A)).Nodup := by
    apply nodup_map_injOn hndF
    intro a ha b hb hab
    have ha' := (relFirsts_mem A a).mp ha
    have hb' := (relFirsts_mem A b).mp hb
    have e1 := congrArg (relPartner A) hab
    rw [relPartner_invol A hA a ha'.1, relPartner_invol A hA b hb'.1] at e1
    exact e1
  apply my_perm_ext hndM hndS
  intro v
  constructor
  · intro h
    rcases List.mem_map.mp h with ⟨u, hu, huv⟩
    have hu' := (relFirsts_mem A u).mp hu
    rw [relSeconds_mem]
    refine ⟨?_, ?_⟩
    · rw [← huv]
      exact (relPartner_spec A hA u hu'.1).1
    · rw [← huv]
      rw [relPartner_invol A hA u hu'.1]
      exact Nat.not_lt.mpr (Nat.le_of_lt hu'.2)
  · intro h
    have hv' := (relSeconds_mem A v).mp h
    have hlt : (relPartner A v).val < v.val := by
      have hne := relPartner_ne_self A hA v hv'.1
      have hnv : (relPartner A v).val ≠ v.val := fun e => hne (Fin.ext e)
      omega
    apply List.mem_map.mpr
    exact ⟨relPartner A v, (relFirsts_mem A _).mpr
      ⟨(relPartner_spec A hA v hv'.1).1, by rw [relPartner_invol A hA v hv'.1]; exact hlt⟩,
      relPartner_invol A hA v hv'.1⟩

theorem relFirsts_length (hA : ConwayAdj A) : (relFirsts A).length = 7 := by
  have h1 := relFirsts_seconds_len A hA
  have h2 := relFirsts_map_perm_seconds A hA
  have h3 : ((relFirsts A).map (relPartner A)).length = (relSeconds A).length :=
    List.Perm.length_eq h2
  rw [List.length_map] at h3
  omega

theorem relOrd_length (hA : ConwayAdj A) : (relOrd A).length = 14 := by
  unfold relOrd
  rw [List.length_flatMap]
  have e : (relFirsts A).map (fun u => ([u, relPartner A u] : List (Fin 99)).length) =
      (relFirsts A).map fun _ => 2 := rfl
  rw [e, map_const_two_sum, relFirsts_length A hA]

theorem ordAt_mem_N (hA : ConwayAdj A) (a : Nat) (ha : a < 14) :
    A rootV (ordAt A a) = 1 := by
  have hlen : (relOrd A).length = 14 := relOrd_length A hA
  have hlt : a < (relOrd A).length := by rw [hlen]; exact ha
  have e : ordAt A a = (relOrd A)[a] := by
    unfold ordAt
    rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hlt]
    rfl
  rw [e]
  exact (relOrd_mem A hA _).mp (List.getElem_mem hlt)

theorem ordAt_fst (t : Nat) (ht : t < (relFirsts A).length) :
    ordAt A (2 * t) = (relFirsts A).getD t rootV := by
  unfold ordAt relOrd
  have h := flatMap_getD_gen (relFirsts A) (fun u => [u, relPartner A u]) 2
    (fun x _ => rfl) t 0 ht (by decide) rootV rootV
  have e : t * 2 + 0 = 2 * t := by omega
  rw [e] at h
  rw [h, List.getD_cons_zero]

theorem ordAt_snd (t : Nat) (ht : t < (relFirsts A).length) :
    ordAt A (2 * t + 1) = relPartner A ((relFirsts A).getD t rootV) := by
  unfold ordAt relOrd
  have h := flatMap_getD_gen (relFirsts A) (fun u => [u, relPartner A u]) 2
    (fun x _ => rfl) t 1 ht (by decide) rootV rootV
  have e : t * 2 + 1 = 2 * t + 1 := by omega
  rw [e] at h
  rw [h, List.getD_cons_succ, List.getD_cons_zero]

theorem ordAt_inj (hA : ConwayAdj A) {a b : Nat} (ha : a < 14) (hb : b < 14)
    (h : ordAt A a = ordAt A b) : a = b := by
  have hlen : (relOrd A).length = 14 := relOrd_length A hA
  have hia : a < (relOrd A).length := by rw [hlen]; exact ha
  have hib : b < (relOrd A).length := by rw [hlen]; exact hb
  unfold ordAt at h
  rw [List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD,
      List.getElem?_eq_getElem hia, List.getElem?_eq_getElem hib,
      Option.getD_some, Option.getD_some] at h
  have e : (relOrd A)[a]? = (relOrd A)[b]? := by
    rw [List.getElem?_eq_getElem hia, List.getElem?_eq_getElem hib, h]
  exact (List.getElem?_inj hia (relOrd_nodup A hA)).mp e

/-- The partner of the a-th neighbor is the twin-indexed neighbor. -/
def twin14 (a : Nat) : Nat := 2 * (a / 2) + (1 - a % 2)

theorem twin14_lt {a : Nat} (h : a < 14) : twin14 a < 14 := by
  unfold twin14
  have hd : 2 * (a / 2) + a % 2 = a := by omega
  have hm : a % 2 < 2 := Nat.mod_lt a (by decide)
  omega

theorem twin14_half {a : Nat} (h : a < 14) : twin14 a / 2 = a / 2 := by
  unfold twin14
  have hd : 2 * (a / 2) + a % 2 = a := by omega
  have hm : a % 2 < 2 := Nat.mod_lt a (by decide)
  omega

theorem twin14_ne {a : Nat} (h : a < 14) : twin14 a ≠ a := by
  unfold twin14
  have hd : 2 * (a / 2) + a % 2 = a := by omega
  have hm : a % 2 < 2 := Nat.mod_lt a (by decide)
  omega

theorem fstAt_mem_N (hA : ConwayAdj A) (t : Nat) (ht : t < 7) :
    A rootV ((relFirsts A).getD t rootV) = 1 := by
  have hlen : (relFirsts A).length = 7 := relFirsts_length A hA
  have hlt : t < (relFirsts A).length := by rw [hlen]; exact ht
  rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hlt]
  exact ((relFirsts_mem A _).mp (List.getElem_mem _)).1

theorem relPartner_ordAt (hA : ConwayAdj A) (a : Fin 14) :
    relPartner A (ordAt A a.val) = ordAt A (twin14 a.val) := by
  have hlen : (relFirsts A).length = 7 := relFirsts_length A hA
  have hd : 2 * (a.val / 2) + a.val % 2 = a.val := by omega
  have hm : a.val % 2 < 2 := Nat.mod_lt a.val (by decide)
  have ht7 : a.val / 2 < 7 := by have := a.isLt; omega
  have hlt : a.val / 2 < (relFirsts A).length := by rw [hlen]; exact ht7
  have e1 : ordAt A (2 * (a.val / 2)) = (relFirsts A).getD (a.val / 2) rootV :=
    ordAt_fst A _ hlt
  have e2 : ordAt A (2 * (a.val / 2) + 1) =
      relPartner A ((relFirsts A).getD (a.val / 2) rootV) :=
    ordAt_snd A _ hlt
  rcases Nat.eq_zero_or_pos (a.val % 2) with hr | hr
  · -- a = 2t, twin a = 2t+1
    have hav : a.val = 2 * (a.val / 2) := by omega
    have htw : twin14 a.val = 2 * (a.val / 2) + 1 := by unfold twin14; omega
    have e3 : ordAt A a.val = ordAt A (2 * (a.val / 2)) := congrArg (ordAt A) hav
    rw [e3, e1, htw, e2]
  · -- a = 2t+1, twin a = 2t; partner(partner u) = u
    have hav : a.val = 2 * (a.val / 2) + 1 := by omega
    have htw : twin14 a.val = 2 * (a.val / 2) := by
      unfold twin14
      have : a.val % 2 = 1 := by omega
      omega
    have hmem : A rootV ((relFirsts A).getD (a.val / 2) rootV) = 1 :=
      fstAt_mem_N A hA _ ht7
    have e3 : ordAt A a.val = ordAt A (2 * (a.val / 2) + 1) := congrArg (ordAt A) hav
    rw [e3, e2, relPartner_invol A hA _ hmem, htw, e1]

/-- Adjacency inside N is the 7K2 matching. -/
theorem ordAt_adj (hA : ConwayAdj A) (a b : Fin 14) :
    A (ordAt A a.val) (ordAt A b.val) = M_val a b := by
  rw [M_val_eq]
  cases eab : (a == b)
  · -- a ≠ b
    have hab : a ≠ b := by
      intro e2
      rw [beq_iff_eq.mpr e2] at eab
      exact Bool.noConfusion eab
    cases eh : (a.val / 2 == b.val / 2)
    · -- different pairs: not adjacent
      have hhalf : ¬ a.val / 2 = b.val / 2 :=
        fun e2 => Bool.noConfusion (eh ▸ beq_iff_eq.mpr e2)
      rw [Bool.and_false]
      rw [if_neg Bool.false_ne_true]
      rcases hA.2.2.1 (ordAt A a.val) (ordAt A b.val) with h0 | h1
      · exact h0
      · exfalso
        have hpu := relPartner_unique A hA (ordAt A a.val) (ordAt A b.val)
          (ordAt_mem_N A hA a.val a.isLt) (ordAt_mem_N A hA b.val b.isLt) h1
        rw [relPartner_ordAt A hA a] at hpu
        have htwin : twin14 a.val = b.val := ordAt_inj A hA (twin14_lt a.isLt) b.isLt hpu.symm
        rw [← htwin, twin14_half a.isLt] at hhalf
        exact hhalf rfl
    · -- same pair: b = twin a
      have hhalf : a.val / 2 = b.val / 2 := beq_iff_eq.mp eh
      have htb : b.val = twin14 a.val := by
        have hd : 2 * (a.val / 2) + a.val % 2 = a.val := by omega
        have hd' : 2 * (b.val / 2) + b.val % 2 = b.val := by omega
        have hm : a.val % 2 < 2 := Nat.mod_lt a.val (by decide)
        have hm' : b.val % 2 < 2 := Nat.mod_lt b.val (by decide)
        have hne2 : b.val ≠ a.val := fun e => hab (Fin.ext e.symm)
        unfold twin14
        omega
      have e1 : ordAt A b.val = relPartner A (ordAt A a.val) := by
        rw [htb, ← relPartner_ordAt A hA a]
      rw [e1]
      have h2 : A (ordAt A a.val) (relPartner A (ordAt A a.val)) = 1 :=
        (relPartner_spec A hA _ (ordAt_mem_N A hA a.val a.isLt)).2
      rw [h2]
      rw [Bool.and_true]
      have hne : (a.val != b.val) = true :=
        bne_iff_ne.mpr (fun e => hab (Fin.ext e))
      rw [hne]
      rfl
  · -- a = b
    have hab : a = b := beq_iff_eq.mp eab
    have hbe : (a.val != b.val && a.val / 2 == b.val / 2) = false := by
      have h1 : (a.val != b.val) = false := by
        cases e1 : (a.val != b.val)
        · rfl
        · rw [bne_iff_ne] at e1
          exact absurd (congrArg Fin.val (beq_iff_eq.mp eab)) e1
      rw [h1, Bool.false_and]
    rw [hbe]
    rw [if_neg Bool.false_ne_true]
    rw [← hab]
    exact hA.1 (ordAt A a.val)

end Matrix99

namespace Matrix99

variable (A : Matrix99 Nat)

/-! ### The far vertices -/

/-- Checker: every designated pair consists of two distinct-pair neighbors. -/
theorem nePair_spec_check : nePairs.all (fun p =>
    decide (p.1 < 14) && decide (p.2 < 14) && (p.1 / 2 != p.2 / 2)) = true := by
  decide +kernel

theorem nePair_spec (y : Fin 84) :
    (nePair y).1 < 14 ∧ (nePair y).2 < 14 ∧ (nePair y).1 / 2 ≠ (nePair y).2 / 2 := by
  have h := all_of_mem nePair_spec_check (nePair_mem y)
  rw [Bool.and_eq_true_iff, Bool.and_eq_true_iff] at h
  exact ⟨of_decide_eq_true h.1.1, of_decide_eq_true h.1.2, bne_iff_ne.mp h.2⟩

/-- Neighborhood vertices from different matching pairs are nonadjacent. -/
theorem ordAt_adj_zero (hA : ConwayAdj A) {a b : Nat} (ha : a < 14) (hb : b < 14)
    (hh : a / 2 ≠ b / 2) : A (ordAt A a) (ordAt A b) = 0 := by
  rcases hA.2.2.1 (ordAt A a) (ordAt A b) with h0 | h1
  · exact h0
  · exfalso
    have hpu := relPartner_unique A hA _ _ (ordAt_mem_N A hA a ha)
      (ordAt_mem_N A hA b hb) h1
    have hpo : relPartner A (ordAt A a) = ordAt A (twin14 a) :=
      relPartner_ordAt A hA ⟨a, ha⟩
    rw [hpo] at hpu
    have ht : twin14 a = b := ordAt_inj A hA (twin14_lt ha) hb hpu.symm
    rw [← ht] at hh
    exact hh (twin14_half ha).symm

/-- The second coordinate of common neighbors of a nonadjacent pair: μ = 2. -/
theorem ordAt_pair_mul (hA : ConwayAdj A) (y : Fin 84) :
    mul A A (ordAt A (nePair y).1) (ordAt A (nePair y).2) = 2 := by
  have ⟨hp1, hp2, hh⟩ := nePair_spec y
  have hadj0 := ordAt_adj_zero A hA hp1 hp2 hh
  have hne : ordAt A (nePair y).1 ≠ ordAt A (nePair y).2 := by
    intro e
    have : (nePair y).1 = (nePair y).2 := ordAt_inj A hA hp1 hp2 e
    exact hh (congrArg (· / 2) this)
  have heq := hA.2.2.2 (ordAt A (nePair y).1) (ordAt A (nePair y).2)
  rw [hadj0, Nat.add_zero, targetRHS_eq, if_neg hne] at heq
  exact heq

/-- The far vertex attached to designated pair `y`. -/
def relFar (y : Fin 84) : Fin 99 :=
  ((List.finRange 99).find? fun v =>
    (v != rootV) && (A (ordAt A (nePair y).1) v == 1) &&
      (A (ordAt A (nePair y).2) v == 1)).getD rootV

/-- Existence of a second common neighbor of `ordAt p`, `ordAt q` besides `x`. -/
theorem relFar_spec (hA : ConwayAdj A) (y : Fin 84) :
    relFar A y ≠ rootV ∧
    A (ordAt A (nePair y).1) (relFar A y) = 1 ∧
    A (ordAt A (nePair y).2) (relFar A y) = 1 := by
  have hmul := ordAt_pair_mul A hA y
  have ⟨hp1, hp2, hh⟩ := nePair_spec y
  have h1 : A (ordAt A (nePair y).1) rootV = 1 := by
    rw [hA.2.1 (ordAt A (nePair y).1) rootV]
    exact ordAt_mem_N A hA _ hp1
  have h2 : A rootV (ordAt A (nePair y).2) = 1 := ordAt_mem_N A hA _ hp2
  -- contributors f k = A i k * A k j, sum = 2, rootV contributes 1
  have hsum : (List.finRange 99).foldl
      (fun a w => a + A (ordAt A (nePair y).1) w * A w (ordAt A (nePair y).2)) 0 = 2 := hmul
  have hfx : A (ordAt A (nePair y).1) rootV * A rootV (ordAt A (nePair y).2) = 1 := by
    rw [h1, h2]
  rcases foldl_two_exists_second
      (fun k => A (ordAt A (nePair y).1) k * A k (ordAt A (nePair y).2))
      (List.nodup_finRange 99) (List.mem_finRange rootV) hfx hsum with ⟨w, _, hwx, hfw⟩
  have hpred : ((w != rootV) && (A (ordAt A (nePair y).1) w == 1) &&
      (A (ordAt A (nePair y).2) w == 1)) = true := by
    have hw1 : A (ordAt A (nePair y).1) w = 1 := by
      rcases hA.2.2.1 (ordAt A (nePair y).1) w with h0 | hh1
      · rw [h0, Nat.zero_mul] at hfw
        exact absurd hfw (Nat.lt_irrefl 0)
      · exact hh1
    have hw2 : A w (ordAt A (nePair y).2) = 1 := by
      rcases hA.2.2.1 w (ordAt A (nePair y).2) with h0 | hh1
      · rw [hw1, h0, Nat.mul_zero] at hfw
        exact absurd hfw (Nat.lt_irrefl 0)
      · exact hh1
    have hw2' : A (ordAt A (nePair y).2) w = 1 := by
      rw [← hA.2.1 w (ordAt A (nePair y).2)]
      exact hw2
    rw [bne_iff_ne.mpr hwx, beq_iff_eq.mpr hw1, beq_iff_eq.mpr hw2']
    rfl
  have hsome : ((List.finRange 99).find? fun v =>
      (v != rootV) && (A (ordAt A (nePair y).1) v == 1) &&
        (A (ordAt A (nePair y).2) v == 1)).isSome = true :=
    (List.find?_isSome).mpr ⟨w, List.mem_finRange w, hpred⟩
  rcases Option.isSome_iff_exists.mp hsome with ⟨v, hv⟩
  have hspec := List.find?_some hv
  have hval : relFar A y = v := by
    unfold relFar
    rw [hv]
    rfl
  rw [hval]
  have h12 := Bool.and_eq_true_iff.mp (Bool.and_eq_true_iff.mp hspec).1
  exact ⟨bne_iff_ne.mp h12.1, beq_iff_eq.mp h12.2,
    beq_iff_eq.mp (Bool.and_eq_true_iff.mp hspec).2⟩

/-- The far vertex is not adjacent to the root. -/
theorem relFar_root_nonadj (hA : ConwayAdj A) (y : Fin 84) :
    A rootV (relFar A y) = 0 := by
  have ⟨hne, h1, h2⟩ := relFar_spec A hA y
  rcases hA.2.2.1 rootV (relFar A y) with h0 | hN
  · exact h0
  · exfalso
    -- far y ∈ N and adjacent to ordAt p, ordAt q → both equal partner (far y)
    have ⟨hp1, hp2, hhh⟩ := nePair_spec y
    have hpu := relPartner_unique A hA (relFar A y) (ordAt A (nePair y).1)
      hN (ordAt_mem_N A hA _ hp1) (by rw [hA.2.1]; exact h1)
    have hqv := relPartner_unique A hA (relFar A y) (ordAt A (nePair y).2)
      hN (ordAt_mem_N A hA _ hp2) (by rw [hA.2.1]; exact h2)
    have hpq : ordAt A (nePair y).1 = ordAt A (nePair y).2 := hpu.trans hqv.symm
    have hpq' : (nePair y).1 = (nePair y).2 := ordAt_inj A hA hp1 hp2 hpq
    exact hhh (congrArg (· / 2) hpq')

end Matrix99

namespace Matrix99

variable (A : Matrix99 Nat)

/-- mul x v = 2 for a root-nonadjacent vertex v ≠ x. -/
theorem mul_root_nonadj (hA : ConwayAdj A) (v : Fin 99) (hvx : v ≠ rootV)
    (h0 : A rootV v = 0) : mul A A rootV v = 2 := by
  have heq := hA.2.2.2 rootV v
  have hne' : ¬ rootV = v := fun e => hvx e.symm
  rw [h0, Nat.add_zero, targetRHS_eq, if_neg hne'] at heq
  exact heq

/-- Every neighbor index of `far y` is one of its two designated pair entries. -/
theorem far_incidence (hA : ConwayAdj A) (y : Fin 84) (a : Nat) (ha : a < 14) :
    A (ordAt A a) (relFar A y) = ind a (nePair y) := by
  have ⟨hne, hp, hq⟩ := relFar_spec A hA y
  have h0 := relFar_root_nonadj A hA y
  have hmul := mul_root_nonadj A hA (relFar A y) hne h0
  unfold ind
  cases ha1 : (a == (nePair y).1)
  · cases ha2 : (a == (nePair y).2)
    · -- a is neither designated index: A (ordAt a) v = 0
      rw [show (false || false) = false from rfl, if_neg Bool.false_ne_true]
      rcases hA.2.2.1 (ordAt A a) (relFar A y) with h0a | h1a
      · exact h0a
      · exfalso
        have ⟨hp1, hp2, hhalf⟩ := nePair_spec y
        -- three distinct contributors
        have hap : a ≠ (nePair y).1 := by
          intro e
          rw [beq_iff_eq.mpr e] at ha1
          exact Bool.noConfusion ha1
        have haq : a ≠ (nePair y).2 := by
          intro e
          rw [beq_iff_eq.mpr e] at ha2
          exact Bool.noConfusion ha2
        have hOa := ordAt_mem_N A hA a ha
        have hOp := ordAt_mem_N A hA _ hp1
        have hOq := ordAt_mem_N A hA _ hp2
        have e1 : A rootV (ordAt A a) * A (ordAt A a) (relFar A y) = 1 := by
          rw [hOa, h1a]
        have e2 : A rootV (ordAt A (nePair y).1) * A (ordAt A (nePair y).1) (relFar A y) = 1 := by
          rw [hOp, hp]
        have e3 : A rootV (ordAt A (nePair y).2) * A (ordAt A (nePair y).2) (relFar A y) = 1 := by
          rw [hOq, hq]
        have hneap : ordAt A a ≠ ordAt A (nePair y).1 :=
          fun e => hap (ordAt_inj A hA ha hp1 e)
        have hneaq : ordAt A a ≠ ordAt A (nePair y).2 :=
          fun e => haq (ordAt_inj A hA ha hp2 e)
        have hnepq : ordAt A (nePair y).1 ≠ ordAt A (nePair y).2 := by
          intro e
          exact hhalf (congrArg (· / 2) (ordAt_inj A hA hp1 hp2 e))
        have hge := foldl_ge_three_of_mem_distinct
          (fun k => A rootV k * A k (relFar A y)) (List.nodup_finRange 99)
          hneap hneaq hnepq
          (List.mem_finRange _) (List.mem_finRange _) (List.mem_finRange _)
        rw [e1, e2, e3] at hge
        change mul A A rootV (relFar A y) ≥ 3 at hge
        omega
    · -- a = q
      have hae : a = (nePair y).2 := beq_iff_eq.mp ha2
      rw [show (false || true) = true from rfl, if_pos rfl]
      rw [hae]
      exact hq
  · -- a = p
    rw [show (true || (a == (nePair y).2)) = true from rfl, if_pos rfl]
    have hae : a = (nePair y).1 := beq_iff_eq.mp ha1
    rw [hae]
    exact hp

end Matrix99

namespace Matrix99

variable (A : Matrix99 Nat)

/-- Three distinct neighborhood vertices cannot all be adjacent to a
    root-nonadjacent vertex. -/
theorem far_no_third_nbr (hA : ConwayAdj A) (v : Fin 99) (hvx : v ≠ rootV)
    (h0 : A rootV v = 0) {a b c : Nat} (ha : a < 14) (hb : b < 14) (hc : c < 14)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    (hva : A (ordAt A a) v = 1) (hvb : A (ordAt A b) v = 1)
    (hvc : A (ordAt A c) v = 1) : False := by
  have hmul := mul_root_nonadj A hA v hvx h0
  have e1 : A rootV (ordAt A a) * A (ordAt A a) v = 1 := by
    rw [ordAt_mem_N A hA a ha, hva]
  have e2 : A rootV (ordAt A b) * A (ordAt A b) v = 1 := by
    rw [ordAt_mem_N A hA b hb, hvb]
  have e3 : A rootV (ordAt A c) * A (ordAt A c) v = 1 := by
    rw [ordAt_mem_N A hA c hc, hvc]
  have hge := foldl_ge_three_of_mem_distinct (fun k => A rootV k * A k v)
    (List.nodup_finRange 99)
    (fun e => hab (ordAt_inj A hA ha hb e))
    (fun e => hac (ordAt_inj A hA ha hc e))
    (fun e => hbc (ordAt_inj A hA hb hc e))
    (List.mem_finRange _) (List.mem_finRange _) (List.mem_finRange _)
  rw [e1, e2, e3] at hge
  change mul A A rootV v ≥ 3 at hge
  omega

/-- Checker: two distinct designated pairs share at most one element. -/
theorem nePair_union3_check : nePairs.all (fun p =>
    nePairs.all fun q =>
      if (p.1 == q.1) && (p.2 == q.2) then true
      else (q.1 != p.1 && q.1 != p.2) || (q.2 != p.1 && q.2 != p.2)) = true := by
  decide +kernel

theorem relFar_inj (hA : ConwayAdj A) {y z : Fin 84}
    (h : relFar A y = relFar A z) : y = z := by
  cases hpyz : (nePair y == nePair z)
  · exfalso
    have ⟨hne, hp1, hp2⟩ := relFar_spec A hA y
    have ⟨hne', hq1, hq2⟩ := relFar_spec A hA z
    rw [← h] at hq1 hq2
    have h0 := relFar_root_nonadj A hA y
    have ⟨yp1, yp2, yph⟩ := nePair_spec y
    have ⟨zq1, zq2, zqh⟩ := nePair_spec z
    have hbc : ((nePair y).1 == (nePair z).1 && (nePair y).2 == (nePair z).2) =
        false := hpyz
    have hall := all_of_mem
      (all_of_mem (l := nePairs) (a := nePair y) nePair_union3_check (nePair_mem y))
      (nePair_mem z)
    rw [hbc] at hall
    rw [if_neg Bool.false_ne_true] at hall
    have yp12 : (nePair y).1 ≠ (nePair y).2 :=
      fun e => yph (congrArg (· / 2) e)
    rcases Bool.or_eq_true_iff.mp hall with hl | hr
    · have h11 := Bool.and_eq_true_iff.mp hl
      exact far_no_third_nbr A hA (relFar A y) hne h0 zq1 yp1 yp2
        (bne_iff_ne.mp h11.1) (bne_iff_ne.mp h11.2) yp12
        hq1 hp1 hp2
    · have h22 := Bool.and_eq_true_iff.mp hr
      exact far_no_third_nbr A hA (relFar A y) hne h0 zq2 yp1 yp2
        (bne_iff_ne.mp h22.1) (bne_iff_ne.mp h22.2) yp12
        hq2 hp1 hp2
  · have h12 := Bool.and_eq_true_iff.mp hpyz
    have heq : nePair y = nePair z := by
      apply Prod.ext_iff.mpr
      exact ⟨beq_iff_eq.mp h12.1, beq_iff_eq.mp h12.2⟩
    exact nePair_inj heq

end Matrix99

namespace Matrix99

variable (A : Matrix99 Nat)

/-! ### The relabelling list and permutation -/

/-- The 99 vertices listed as root, then the 14 ordered neighbors, then the
    84 far vertices. -/
def relList : List (Fin 99) :=
  rootV :: (relOrd A ++ (List.finRange 84).map (relFar A))

/-- The relabelling permutation. -/
def relSigma (k : Fin 99) : Fin 99 := (relList A).getD k.val rootV

theorem relList_nodup (hA : ConwayAdj A) : (relList A).Nodup := by
  unfold relList
  rw [List.nodup_cons]
  refine ⟨?_, ?_⟩
  · intro hmem
    rw [List.mem_append] at hmem
    rcases hmem with hmem | hmem
    · have h1 := (relOrd_mem A hA _).mp hmem
      have h0 := hA.1 rootV
      omega
    · rcases List.mem_map.mp hmem with ⟨y, _, hy⟩
      have hne := (relFar_spec A hA y).1
      exact hne hy
  · apply nodup_append
    · exact relOrd_nodup A hA
    · apply nodup_map_injOn (List.nodup_finRange 84)
      intro a _ b _ h
      exact relFar_inj A hA h
    · intro a ha b hb
      rcases List.mem_map.mp hb with ⟨y, _, hy⟩
      rw [← hy]
      intro e
      have h1 := (relOrd_mem A hA a).mp ha
      have h0 := relFar_root_nonadj A hA y
      rw [← e] at h0
      rw [h1] at h0
      exact Nat.noConfusion h0

theorem relList_length (hA : ConwayAdj A) : (relList A).length = 99 := by
  unfold relList
  rw [List.length_cons, List.length_append, relOrd_length A hA,
      List.length_map, List.length_finRange]

/-- Every Fin 99 vertex appears in the relabelling list. -/
theorem relList_complete (hA : ConwayAdj A) (v : Fin 99) : v ∈ relList A := by
  cases List.instDecidableMemOfLawfulBEq v (relList A) with
  | isTrue h => exact h
  | isFalse h =>
    exfalso
    have hnd : (v :: relList A).Nodup :=
      List.nodup_cons.mpr ⟨h, relList_nodup A hA⟩
    have hsub : ∀ a ∈ v :: relList A, a ∈ List.finRange 99 := by
      intro a _; exact List.mem_finRange a
    have hle := nodup_sub_length_le hnd (List.nodup_finRange 99) hsub
    rw [List.length_cons, relList_length A hA, List.length_finRange] at hle
    omega

end Matrix99

namespace Matrix99

variable (A : Matrix99 Nat)

theorem relSigma_inj (hA : ConwayAdj A) : Function.Injective (relSigma A) := by
  intro i j h
  have hlen : (relList A).length = 99 := relList_length A hA
  have hia : i.val < (relList A).length := by rw [hlen]; exact i.isLt
  have hib : j.val < (relList A).length := by rw [hlen]; exact j.isLt
  unfold relSigma at h
  rw [List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD,
      List.getElem?_eq_getElem hia, List.getElem?_eq_getElem hib,
      Option.getD_some, Option.getD_some] at h
  have e : (relList A)[i.val]? = (relList A)[j.val]? := by
    rw [List.getElem?_eq_getElem hia, List.getElem?_eq_getElem hib, h]
  exact Fin.ext ((List.getElem?_inj hia (relList_nodup A hA)).mp e)

theorem relSigma_surj (hA : ConwayAdj A) (v : Fin 99) :
    ∃ i : Fin 99, relSigma A i = v := by
  have hm := relList_complete A hA v
  rcases List.mem_iff_getElem.mp hm with ⟨n, hn, hv⟩
  have hn' : n < 99 := by rw [relList_length A hA] at hn; exact hn
  refine ⟨⟨n, hn'⟩, ?_⟩
  unfold relSigma
  rw [List.getD_eq_getElem?_getD,
      List.getElem?_eq_getElem (by rw [relList_length A hA]; exact hn'),
      Option.getD_some]
  exact hv

theorem relSigma_bij (hA : ConwayAdj A) : Function.Bijective (relSigma A) :=
  ⟨relSigma_inj A hA, fun v => relSigma_surj A hA v⟩

theorem bij_map_perm {σ : Fin 99 → Fin 99} (hinj : Function.Injective σ)
    (hsurj : ∀ v : Fin 99, ∃ i, σ i = v) :
    ((List.finRange 99).map σ).Perm (List.finRange 99) := by
  have hnd : ((List.finRange 99).map σ).Nodup :=
    nodup_map_injOn (List.nodup_finRange 99)
      (fun a _ b _ h => hinj h)
  apply my_perm_ext hnd (List.nodup_finRange 99)
  intro v
  rw [List.mem_map]
  constructor
  · rintro ⟨i, -, rfl⟩
    exact List.mem_finRange _
  · intro _
    rcases hsurj v with ⟨i, hi⟩
    exact ⟨i, List.mem_finRange i, hi⟩

theorem relSigma_map_perm (hA : ConwayAdj A) :
    ((List.finRange 99).map (relSigma A)).Perm (List.finRange 99) :=
  bij_map_perm (relSigma_inj A hA) (relSigma_surj A hA)

set_option maxRecDepth 10000
/-- Reindexing a row-product through a bijection `σ`. -/
theorem bij_mul {σ : Fin 99 → Fin 99} (hbij : Function.Bijective σ)
    (hA : ConwayAdj A) (i j : Fin 99) :
    (List.finRange 99).foldl
      (fun acc k => acc + A (σ i) (σ k) * A (σ k) (σ j)) 0
      = mul A A (σ i) (σ j) := by
  have h1 : (List.finRange 99).foldl
      (fun acc k => acc + A (σ i) (σ k) * A (σ k) (σ j)) 0
      = ((List.finRange 99).map σ).foldl
        (fun acc w => acc + A (σ i) w * A w (σ j)) 0 :=
    List.foldl_map.symm
  rw [h1, foldl_perm _ (bij_map_perm hbij.1 hbij.2)]
  rfl

end Matrix99

namespace Matrix99

variable (A : Matrix99 Nat)

/-- The residual matrix: the far-vertex adjacency block. -/
def relX : Matrix 84 84 := fun y z => A (relFar A y) (relFar A z)

theorem relSigma_root : relSigma A rootV = rootV := by
  unfold relSigma relList
  show (rootV :: (relOrd A ++ (List.finRange 84).map (relFar A))).getD
      rootV.val rootV = rootV
  rw [show rootV.val = 0 from rfl, List.getD_cons_zero]

theorem relSigma_nbr (hA : ConwayAdj A) (a : Fin 14) :
    relSigma A (nbrV a) = ordAt A a.val := by
  unfold relSigma relList ordAt
  show (rootV :: (relOrd A ++ (List.finRange 84).map (relFar A))).getD
      (nbrV a).val rootV = (relOrd A).getD a.val rootV
  rw [show (nbrV a).val = a.val + 1 from rfl, List.getD_cons_succ,
      getD_append_left (relOrd A) _ rootV a.val
        (by rw [relOrd_length A hA]; exact a.isLt)]

theorem relSigma_far (hA : ConwayAdj A) (y : Fin 84) :
    relSigma A (farV y) = relFar A y := by
  unfold relSigma relList
  show (rootV :: (relOrd A ++ (List.finRange 84).map (relFar A))).getD
      (farV y).val rootV = relFar A y
  rw [show (farV y).val = y.val + 15 from rfl]
  rw [show y.val + 15 = (y.val + 14) + 1 from rfl, List.getD_cons_succ]
  rw [getD_append_right (relOrd A) _ rootV (y.val + 14)
        (by rw [relOrd_length A hA]; omega)]
  rw [relOrd_length A hA]
  rw [show y.val + 14 - 14 = y.val from Nat.add_sub_cancel y.val 14]
  rw [getD_map (List.finRange 84) (relFar A) y.val y rootV
        (by rw [List.length_finRange]; exact y.isLt)]
  congr 1
  rw [List.getD_eq_getElem?_getD,
      List.getElem?_eq_getElem (by rw [List.length_finRange]; exact y.isLt),
      Option.getD_some]
  show (List.finRange 84)[y.val]'(by rw [List.length_finRange]; exact y.isLt) = y
  apply Fin.ext
  rw [List.getElem_finRange]
  rfl

/-- The relabelled adjacency matrix equals the block matrix. -/
theorem relMat_eq_block (hA : ConwayAdj A) :
    (fun i j => A (relSigma A i) (relSigma A j)) = block_A (relX A) := by
  funext i j
  show A (relSigma A i) (relSigma A j) = block_A (relX A) i j
  rcases fin99_cases i with hi | ⟨a, hi⟩ | ⟨y, hi⟩
  · subst hi
    rcases fin99_cases j with hj | ⟨b, hj⟩ | ⟨z, hj⟩
    · subst hj
      rw [relSigma_root, hA.1 rootV, eval_rr]
    · subst hj
      rw [relSigma_root, relSigma_nbr A hA, eval_rn]
      exact ordAt_mem_N A hA b.val b.isLt
    · subst hj
      rw [relSigma_root, relSigma_far A hA, eval_rf]
      exact relFar_root_nonadj A hA z
  · rcases hi with ⟨a, rfl⟩
    rcases fin99_cases j with hj | ⟨b, hj⟩ | ⟨z, hj⟩
    · subst hj
      rw [relSigma_nbr A hA, relSigma_root, eval_nr]
      have := ordAt_mem_N A hA a.val a.isLt
      rw [hA.2.1 (ordAt A a.val) rootV]
      exact this
    · subst hj
      rw [relSigma_nbr A hA, relSigma_nbr A hA, eval_nn]
      exact ordAt_adj A hA a b
    · subst hj
      rw [relSigma_nbr A hA, relSigma_far A hA, eval_nf, B_val_eq]
      exact far_incidence A hA z a.val a.isLt
  · rcases hi with ⟨y, rfl⟩
    rcases fin99_cases j with hj | ⟨b, hj⟩ | ⟨z, hj⟩
    · subst hj
      rw [relSigma_far A hA, relSigma_root, eval_fr]
      have h0 := relFar_root_nonadj A hA y
      rw [hA.2.1 (relFar A y) rootV]
      exact h0
    · subst hj
      rw [relSigma_far A hA, relSigma_nbr A hA, eval_fn, B_val_eq]
      rw [hA.2.1 (relFar A y) (ordAt A b.val)]
      exact far_incidence A hA y b.val b.isLt
    · subst hj
      rw [relSigma_far A hA, relSigma_far A hA, eval_ff]
      rfl

/-- Any relabelling by a bijection preserves `ConwayAdj`. -/
theorem conwayAdj_relabel {σ : Fin 99 → Fin 99} (hbij : Function.Bijective σ)
    (hA : ConwayAdj A) :
    ConwayAdj (fun i j => A (σ i) (σ j)) := by
  have hA' := hA
  obtain ⟨hdia, hsym, hbin, hmu⟩ := hA
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro i
    exact hdia (σ i)
  · intro i j
    exact hsym (σ i) (σ j)
  · intro i j
    exact hbin (σ i) (σ j)
  · intro i j
    show mul _ _ i j + A (σ i) (σ j) = targetRHS i j
    unfold mul
    have hbm := bij_mul A hbij hA' i j
    rw [hbm, hmu (σ i) (σ j), targetRHS_eq, targetRHS_eq]
    split
    · next h => rw [if_pos (hbij.1 h)]
    · next h =>
      rw [if_neg (fun e => h (congrArg σ e))]

/-- The three target theorems. -/
theorem conway_relabel_block (A : Matrix99 Nat) (hA : ConwayAdj A) :
    ∃ (σ : Fin 99 → Fin 99) (X : Matrix 84 84),
      Function.Bijective σ ∧ ∀ i j, A (σ i) (σ j) = block_A X i j := by
  exact ⟨relSigma A, relX A, relSigma_bij A hA,
    fun i j => congrFun (congrFun (relMat_eq_block A hA) i) j⟩

theorem conway_exists_iff_block :
    (∃ A : Matrix99 Nat, ConwayAdj A) ↔
      ∃ X : Matrix 84 84, ConwayAdj (block_A X) := by
  constructor
  · rintro ⟨A, hA⟩
    rcases conway_relabel_block A hA with ⟨σ, X, hbij, heq⟩
    refine ⟨X, ?_⟩
    have hm : block_A X = fun i j => A (σ i) (σ j) :=
      funext fun i => funext fun j => (heq i j).symm
    rw [hm]
    exact conwayAdj_relabel A hbij hA
  · rintro ⟨X, hX⟩
    exact ⟨block_A X, hX⟩

theorem conway_exists_iff_residual :
    (∃ A : Matrix99 Nat, ConwayAdj A) ↔ ∃ X : Matrix 84 84,
      ((∀ i : Fin 84, X i i = 0) ∧
       (∀ i j : Fin 84, X i j = X j i) ∧
       (∀ i j : Fin 84, X i j = 0 ∨ X i j = 1) ∧
       (∀ i : Fin 84, (List.finRange 84).foldl (fun acc j => acc + X i j) 0 = 12) ∧
       (∀ i j : Fin 84,
          (List.finRange 84).foldl (fun acc k => acc + X i k * X k j) 0 +
            X i j = K_val i j) ∧
       (∀ i : Fin 14, ∀ j : Fin 84,
          (List.finRange 14).foldl (fun acc k => acc + M_val i k * B_val k j) 0 +
          (List.finRange 84).foldl (fun acc k => acc + B_val i k * X k j) 0 =
            2 - B_val i j)) := by
  rw [conway_exists_iff_block]
  constructor
  · rintro ⟨X, hX⟩
    exact ⟨X, (second_subconstituent_reduction X).mp hX⟩
  · rintro ⟨X, hX⟩
    exact ⟨X, (second_subconstituent_reduction X).mpr hX⟩

#print axioms relMat_eq_block
#print axioms conwayAdj_relabel
#print axioms conway_relabel_block
#print axioms conway_exists_iff_block
#print axioms conway_exists_iff_residual

#print axioms Matrix99.foldl01_eq_filter_length
#print axioms Matrix99.foldl_ge_three_of_mem_distinct
#print axioms Matrix99.foldl_two_exists_second
#print axioms Matrix99.length_filter_add_not
#print axioms Matrix99.nodup_sub_length_le
#print axioms Matrix99.nodup_map_injOn
#print axioms Matrix99.foldl_perm
#print axioms Matrix99.getD_append_left
#print axioms Matrix99.getD_append_right
#print axioms Matrix99.flatMap_getD_gen
#print axioms Matrix99.getD_finRange
#print axioms Matrix99.map_const_two_sum
#print axioms Matrix99.relN_mem
#print axioms Matrix99.relN_length
#print axioms Matrix99.relPartner_spec
#print axioms Matrix99.relPartner_unique
#print axioms Matrix99.relPartner_ne_self
#print axioms Matrix99.relPartner_invol
#print axioms Matrix99.relPartner_mem_N
#print axioms Matrix99.relPartner_adj_N
#print axioms Matrix99.relFirsts_mem
#print axioms Matrix99.relSeconds_mem
#print axioms Matrix99.relOrd_nodup_go
#print axioms Matrix99.relOrd_nodup
#print axioms Matrix99.relOrd_mem
#print axioms Matrix99.relFirsts_seconds_len
#print axioms Matrix99.relFirsts_map_perm_seconds
#print axioms Matrix99.relFirsts_length
#print axioms Matrix99.relOrd_length
#print axioms Matrix99.ordAt_mem_N
#print axioms Matrix99.ordAt_fst
#print axioms Matrix99.ordAt_snd
#print axioms Matrix99.ordAt_inj
#print axioms Matrix99.twin14_lt
#print axioms Matrix99.twin14_half
#print axioms Matrix99.twin14_ne
#print axioms Matrix99.fstAt_mem_N
#print axioms Matrix99.relPartner_ordAt
#print axioms Matrix99.ordAt_adj
#print axioms Matrix99.nePair_spec_check
#print axioms Matrix99.nePair_spec
#print axioms Matrix99.ordAt_adj_zero
#print axioms Matrix99.ordAt_pair_mul
#print axioms Matrix99.relFar_spec
#print axioms Matrix99.relFar_root_nonadj
#print axioms Matrix99.mul_root_nonadj
#print axioms Matrix99.far_incidence
#print axioms Matrix99.far_no_third_nbr
#print axioms Matrix99.nePair_union3_check
#print axioms Matrix99.relFar_inj
#print axioms Matrix99.relList_nodup
#print axioms Matrix99.relList_length
#print axioms Matrix99.relList_complete
#print axioms Matrix99.relSigma_inj
#print axioms Matrix99.relSigma_surj
#print axioms Matrix99.relSigma_bij
#print axioms Matrix99.bij_map_perm
#print axioms Matrix99.relSigma_map_perm
#print axioms Matrix99.bij_mul
#print axioms Matrix99.relSigma_root
#print axioms Matrix99.relSigma_nbr
#print axioms Matrix99.relSigma_far
#print axioms Matrix99.relMat_eq_block
#print axioms Matrix99.conwayAdj_relabel

end Matrix99
