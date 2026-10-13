import Conway.Z3FpfRelabel
import Conway.Z3FpfGroupRing

/-!
# Normalization of the Z3 fixed-point-free group-ring frame at t = 27 (WP5–WP6)

`normalize_t27`: given a group-ring frame whose orbit matrix has `nI = 6`,
relabel the orbit indices and shift representatives so that orbit 0 is a
triangle orbit `k0`, its triangle neighbours sit on positions `1 … nT`,
its non-triangle neighbours on `27 … 27 + (12 - nT) - 1`, and the 0-shift
sets become `{0}` on neighbours (systems B / S10 of the encoder).

`z3_fpf_t27_excluded` and `conway_no_z3_fpf_t27`: the final conditional
theorems of the t = 27 branch.
-/

namespace Matrix99
open ConwayOrbit
namespace Z3FpfGroupRing
open Z3FpfOrbitMatrix

/-! ### Generic list/counting infrastructure -/

theorem list_sum_le {α : Type} (l : List α) (f g : α → Nat)
    (h : ∀ a, a ∈ l → f a ≤ g a) :
    (l.map f).sum ≤ (l.map g).sum := by
  induction l with
  | nil => exact Nat.le_refl 0
  | cons x xs ih =>
    simp only [List.map_cons, List.sum_cons]
    exact Nat.add_le_add (h x (List.Mem.head _)) (ih (fun a ha => h a (List.Mem.tail _ ha)))

theorem sumFin_mono {n : Nat} (f g : Fin n → Nat) (h : ∀ j, f j ≤ g j) :
    sumFin f ≤ sumFin g := by
  unfold sumFin
  apply list_sum_le
  intro a _
  exact h a

theorem filter_length_sumFin {n : Nat} (p : Fin n → Bool) :
    ((List.finRange n).filter p).length =
    sumFin (fun j => if p j = true then (1 : Nat) else 0) := by
  unfold sumFin
  have key : ∀ l : List (Fin n), (l.filter p).length =
      (l.map (fun j => if p j = true then 1 else 0)).sum := by
    intro l
    induction l with
    | nil => rfl
    | cons x xs ih =>
      rw [List.filter_cons]
      by_cases h : p x = true
      · rw [if_pos h, List.map_cons, List.sum_cons, List.length_cons, if_pos h, ih]
        omega
      · rw [if_neg h, List.map_cons, List.sum_cons, if_neg h, ih]
        omega
  exact key _

theorem nodup_append {α : Type} [DecidableEq α] (l1 l2 : List α)
    (h1 : l1.Nodup) (h2 : l2.Nodup)
    (hd : ∀ x, x ∈ l1 → x ∈ l2 → False) : (l1 ++ l2).Nodup := by
  induction l1 with
  | nil => simpa using h2
  | cons x xs ih =>
    have hxs : xs.Nodup := (List.nodup_cons.mp h1).2
    have hx : x ∉ xs := (List.nodup_cons.mp h1).1
    rw [List.cons_append, List.nodup_cons]
    refine ⟨?_, ih hxs (fun a ha hb => hd a (List.Mem.tail _ ha) hb)⟩
    intro hmem
    rw [List.mem_append] at hmem
    rcases hmem with h | h
    · exact hx h
    · exact hd x (List.Mem.head _) h

theorem filter_nodup {n : Nat} (p : Fin n → Bool) :
    ((List.finRange n).filter p).Nodup :=
  (List.nodup_finRange n).filter p

theorem mem_filter {α : Type} [DecidableEq α] (p : α → Bool) (l : List α) (a : α) :
    a ∈ l.filter p ↔ a ∈ l ∧ p a = true :=
  List.mem_filter

/-- Every index of a filtered `finRange` satisfies the predicate. -/
theorem mem_of_mem_filter {n : Nat} (p : Fin n → Bool) {a : Fin n}
    (h : a ∈ (List.finRange n).filter p) : p a = true :=
  (List.mem_filter.mp h).2

theorem list_getElem_mem {α : Type} (l : List α) (i : Nat) (h : i < l.length) :
    l[i] ∈ l :=
  List.getElem_mem h

variable (G : Z3FpfGroupRing) (k0 : Fin 33)

/-- Triangle neighbours of `k0`. -/
def triNbrList : List (Fin 33) :=
  (List.finRange 33).filter
    (fun j => decide (G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1))

/-- Other triangle orbits (not `k0`, not neighbours). -/
def triRestList : List (Fin 33) :=
  (List.finRange 33).filter
    (fun j => decide (G.toOrbitMatrix.B j j = 2 ∧ j ≠ k0 ∧ G.toOrbitMatrix.B k0 j ≠ 1))

/-- Non-triangle neighbours of `k0`. -/
def nonNbrList : List (Fin 33) :=
  (List.finRange 33).filter
    (fun j => decide (G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j = 1))

/-- Remaining non-triangle orbits. -/
def nonRestList : List (Fin 33) :=
  (List.finRange 33).filter
    (fun j => decide (G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j ≠ 1))

/-- The relabeling order: `k0`, triangle neighbours, other triangle orbits,
    non-triangle neighbours, other non-triangle orbits. -/
def relabelList : List (Fin 33) :=
  [k0] ++ G.triNbrList k0 ++ G.triRestList k0 ++ G.nonNbrList k0 ++ G.nonRestList k0

variable {G k0}

/-- `B i i = 2` iff `S i i 1` (the diagonal set is `{1, 2}` or empty). -/
theorem B_diag2_iff (G : Z3FpfGroupRing) (i : Fin 33) :
    G.toOrbitMatrix.B i i = 2 ↔ G.S i i 1 = true := by
  have hd := G.diag i
  have hl := G.loopless i
  have h := sumFin_fin3 (fun s : Fin 3 => if G.S i i s = true then (1 : Nat) else 0)
  rw [hl] at h
  have hB : G.toOrbitMatrix.B i i =
      (if G.S i i 1 = true then (1 : Nat) else 0) +
      (if G.S i i 2 = true then 1 else 0) := by
    rw [Z3FpfGroupRing.toOrbitMatrix_B, h,
        if_neg (by decide : ¬ ((false : Bool) = true))]
    omega
  rw [hB]
  by_cases h1 : G.S i i 1 = true
  · have h2 : G.S i i 2 = true := by rw [← hd]; exact h1
    rw [if_pos h1, if_pos h2]
    simp [h1]
  · have h1f : G.S i i 1 = false := by cases hb : G.S i i 1 <;> simp_all
    have h2 : G.S i i 2 = false := by rw [← hd]; exact h1f
    rw [if_neg (by intro c; rw [h1f] at c; exact Bool.noConfusion c),
        if_neg (by intro c; rw [h2] at c; exact Bool.noConfusion c)]
    constructor
    · intro hx
      omega
    · intro hx
      rw [hx] at h1f
      exact Bool.noConfusion h1f

/-- `B i i = 0` iff `S i i 1 = false`. -/
theorem B_diag0_iff (G : Z3FpfGroupRing) (i : Fin 33) :
    G.toOrbitMatrix.B i i = 0 ↔ G.S i i 1 = false := by
  have h2 := B_diag2_iff G i
  cases hb : G.S i i 1
  · -- S i i 1 = false: need B ≠ 2
    have hn2 : ¬ (G.toOrbitMatrix.B i i = 2) := by
      intro hB2
      have := h2.mp hB2
      rw [hb] at this
      exact Bool.noConfusion this
    have hp := G.toOrbitMatrix.diag_parity i
    constructor
    · intro _
      rfl
    · intro _
      rcases hp with h | h
      · exact h
      · exact absurd h hn2
  · -- S i i 1 = true: B = 2
    have hB : G.toOrbitMatrix.B i i = 2 := h2.mpr hb
    constructor
    · intro h0
      omega
    · intro hf
      exact Bool.noConfusion hf

/-- `xT k0 ≤ nI` pointwise: the I-entries of a triangle row are `0` or `1`. -/
theorem xT_le_nI (G : Z3FpfGroupRing) (k0 : Fin 33) (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    G.toOrbitMatrix.xT k0 ≤ G.toOrbitMatrix.nI := by
  apply sumFin_mono
  intro j
  by_cases h : G.toOrbitMatrix.B j j = 0
  · rw [if_pos h, if_pos h]
    by_cases hjk : j = k0
    · subst hjk
      omega
    · exact Z3FpfOrbitMatrix.tri_offdiag_le_one _ k0 j hk0 hjk
  · rw [if_neg h, if_neg h]
    omega

/-- Triangle-orbit count: 27 diagonal entries equal `2`. -/
theorem tri_count (G : Z3FpfGroupRing) (hn : G.toOrbitMatrix.nI = 6) :
    sumFin (fun j => if G.toOrbitMatrix.B j j = 2 then (1 : Nat) else 0) = 27 := by
  have htot : sumFin (fun _ : Fin 33 => (1 : Nat)) = 33 := by decide
  have hsplit : sumFin (fun j => if G.toOrbitMatrix.B j j = 2 then (1 : Nat) else 0) +
      sumFin (fun j => if G.toOrbitMatrix.B j j = 0 then (1 : Nat) else 0) =
      sumFin (fun _ : Fin 33 => (1 : Nat)) := by
    rw [← sumFin_add]
    apply sumFin_congr
    intro j
    rcases G.toOrbitMatrix.diag_parity j with h | h
    · rw [if_neg (by omega : ¬ (G.toOrbitMatrix.B j j = 2)), if_pos h]
    · rw [if_pos h, if_neg (by omega : ¬ (G.toOrbitMatrix.B j j = 0))]
  have hn' : sumFin (fun j => if G.toOrbitMatrix.B j j = 0 then (1 : Nat) else 0) = 6 := hn
  omega

/-- Non-triangle neighbour count equals `xT k0`. -/
theorem nonNbr_count (G : Z3FpfGroupRing) (k0 : Fin 33)
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    sumFin (fun j => if G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j = 1
        then (1 : Nat) else 0) = G.toOrbitMatrix.xT k0 := by
  apply sumFin_congr
  intro j
  by_cases h0 : G.toOrbitMatrix.B j j = 0
  · by_cases h1 : G.toOrbitMatrix.B k0 j = 1
    · rw [if_pos h0, if_pos ⟨h0, h1⟩]
      omega
    · rw [if_pos h0, if_neg (fun c => h1 c.2)]
      by_cases hjk : j = k0
      · subst hjk
        omega
      · have hle := Z3FpfOrbitMatrix.tri_offdiag_le_one _ k0 j hk0 hjk
        omega
  · rw [if_neg h0, if_neg (fun c => h0 c.1)]

/-- Triangle-neighbour count: `12 − xT k0`. -/
theorem triNbr_count (G : Z3FpfGroupRing) (k0 : Fin 33)
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    sumFin (fun j => if G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1
        then (1 : Nat) else 0) = 12 - G.toOrbitMatrix.xT k0 := by
  have hone := Z3FpfOrbitMatrix.tri_ones _ k0 hk0
  have hxI := nonNbr_count G k0 hk0
  have hsplit : sumFin (fun j => if G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1
      then (1 : Nat) else 0) +
      sumFin (fun j => if G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j = 1
        then (1 : Nat) else 0) = 12 := by
    rw [← hone, ← sumFin_add]
    apply sumFin_congr
    intro j
    rcases G.toOrbitMatrix.diag_parity j with hd | hd
    · -- B j j = 0
      rw [if_neg (fun c => by omega :
            ¬ (G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1))]
      by_cases h1 : G.toOrbitMatrix.B k0 j = 1
      · rw [if_pos ⟨hd, h1⟩,
            if_pos ⟨(fun e => by subst e; omega : j ≠ k0), h1⟩]
      · rw [if_neg (fun c => h1 c.2), if_neg (fun c => h1 c.2)]
    · -- B j j = 2
      rw [if_neg (fun c => by omega :
            ¬ (G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j = 1))]
      by_cases h1 : G.toOrbitMatrix.B k0 j = 1
      · rw [if_pos ⟨hd, h1⟩,
            if_pos ⟨(fun e => by subst e; omega : j ≠ k0), h1⟩]
      · rw [if_neg (fun c => h1 c.2), if_neg (fun c => h1 c.2)]
  have hxle := xT_le_nI G k0 hk0
  omega

/-- Other-triangle-orbit count: `14 + xT k0` (assuming `nI = 6`). -/
theorem triRest_count (G : Z3FpfGroupRing) (k0 : Fin 33)
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6) :
    sumFin (fun j => if G.toOrbitMatrix.B j j = 2 ∧ j ≠ k0 ∧ G.toOrbitMatrix.B k0 j ≠ 1
        then (1 : Nat) else 0) = 14 + G.toOrbitMatrix.xT k0 := by
  have hT := tri_count G hn
  have hN := triNbr_count G k0 hk0
  have hsplit : sumFin (fun j => if G.toOrbitMatrix.B j j = 2 then (1 : Nat) else 0) =
      sumFin (fun j => if G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1
          then (1 : Nat) else 0) +
      sumFin (fun j => if G.toOrbitMatrix.B j j = 2 ∧ j ≠ k0 ∧ G.toOrbitMatrix.B k0 j ≠ 1
          then (1 : Nat) else 0) + 1 := by
    have hpt : ∀ j, (if G.toOrbitMatrix.B j j = 2 then (1 : Nat) else 0) =
        (if G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1 then 1 else 0) +
        (if G.toOrbitMatrix.B j j = 2 ∧ j ≠ k0 ∧ G.toOrbitMatrix.B k0 j ≠ 1 then 1 else 0) +
        (if j = k0 then 1 else 0) := by
      intro j
      rcases G.toOrbitMatrix.diag_parity j with hd | hd
      · -- B j j = 0
        rw [if_neg (by omega : ¬ (G.toOrbitMatrix.B j j = 2)),
            if_neg (fun c => by omega :
              ¬ (G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1)),
            if_neg (fun c => by omega :
              ¬ (G.toOrbitMatrix.B j j = 2 ∧ j ≠ k0 ∧ G.toOrbitMatrix.B k0 j ≠ 1))]
        by_cases hjk : j = k0
        · subst hjk
          rw [if_pos rfl]
          omega
        · rw [if_neg hjk]
      · -- B j j = 2
        rw [if_pos hd]
        by_cases hjk : j = k0
        · rw [hjk]
          rw [if_pos rfl,
              if_neg (fun c => by omega :
                ¬ (G.toOrbitMatrix.B k0 k0 = 2 ∧ k0 ≠ k0 ∧ G.toOrbitMatrix.B k0 k0 ≠ 1)),
              if_neg (fun c => by omega :
                ¬ (G.toOrbitMatrix.B k0 k0 = 2 ∧ G.toOrbitMatrix.B k0 k0 = 1))]
        · rw [if_neg hjk]
          by_cases h1 : G.toOrbitMatrix.B k0 j = 1
          · rw [if_pos ⟨hd, h1⟩, if_neg (fun c => c.2.2 h1)]
          · rw [if_neg (fun c => h1 c.2), if_pos ⟨hd, hjk, h1⟩]
    rw [sumFin_congr hpt, sumFin_add, sumFin_add]
    have hK : sumFin (fun j => if j = k0 then (1 : Nat) else 0) = 1 :=
      sumFin_eq_single k0 (fun _ => (1 : Nat))
    omega
  have hxle := xT_le_nI G k0 hk0
  omega

/-- Remaining non-triangle-orbit count: `6 − xT k0`. -/
theorem nonRest_count (G : Z3FpfGroupRing) (k0 : Fin 33)
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6) :
    sumFin (fun j => if G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j ≠ 1
        then (1 : Nat) else 0) = 6 - G.toOrbitMatrix.xT k0 := by
  have hI : sumFin (fun j => if G.toOrbitMatrix.B j j = 0 then (1 : Nat) else 0) = 6 := hn
  have hN := nonNbr_count G k0 hk0
  have hsplit : sumFin (fun j => if G.toOrbitMatrix.B j j = 0 then (1 : Nat) else 0) =
      sumFin (fun j => if G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j = 1
          then (1 : Nat) else 0) +
      sumFin (fun j => if G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j ≠ 1
          then (1 : Nat) else 0) := by
    rw [← sumFin_add]
    apply sumFin_congr
    intro j
    rcases G.toOrbitMatrix.diag_parity j with hd | hd
    · rw [if_pos hd]
      by_cases h1 : G.toOrbitMatrix.B k0 j = 1
      · rw [if_pos ⟨hd, h1⟩, if_neg (fun c => c.2 h1)]
      · rw [if_neg (fun c => h1 c.2), if_pos ⟨hd, h1⟩]
    · rw [if_neg (by omega : ¬ (G.toOrbitMatrix.B j j = 0)),
          if_neg (fun c => by omega :
            ¬ (G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j = 1)),
          if_neg (fun c => by omega :
            ¬ (G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j ≠ 1))]
  have hxle := xT_le_nI G k0 hk0
  omega

/-! ### The relabeling list: membership, nodup, length, completeness -/

/-- All triangle-orbit indices of `G`, in relabeling order. -/
def triPart (G : Z3FpfGroupRing) (k0 : Fin 33) : List (Fin 33) :=
  [k0] ++ G.triNbrList k0 ++ G.triRestList k0

/-- All non-triangle-orbit indices of `G`, in relabeling order. -/
def nonPart (G : Z3FpfGroupRing) (k0 : Fin 33) : List (Fin 33) :=
  G.nonNbrList k0 ++ G.nonRestList k0

theorem relabelList_eq (G : Z3FpfGroupRing) (k0 : Fin 33) :
    G.relabelList k0 = G.triPart k0 ++ G.nonPart k0 := by
  simp only [relabelList, triPart, nonPart, List.append_assoc]

theorem mem_triNbrList {G : Z3FpfGroupRing} {k0 j : Fin 33} :
    j ∈ G.triNbrList k0 ↔
      G.toOrbitMatrix.B j j = 2 ∧ G.toOrbitMatrix.B k0 j = 1 := by
  unfold triNbrList
  rw [List.mem_filter]
  constructor
  · rintro ⟨_, h⟩
    exact of_decide_eq_true h
  · intro h
    exact ⟨List.mem_finRange j, decide_eq_true h⟩

theorem mem_triRestList {G : Z3FpfGroupRing} {k0 j : Fin 33} :
    j ∈ G.triRestList k0 ↔
      G.toOrbitMatrix.B j j = 2 ∧ j ≠ k0 ∧ G.toOrbitMatrix.B k0 j ≠ 1 := by
  unfold triRestList
  rw [List.mem_filter]
  constructor
  · rintro ⟨_, h⟩
    exact of_decide_eq_true h
  · intro h
    exact ⟨List.mem_finRange j, decide_eq_true h⟩

theorem mem_nonNbrList {G : Z3FpfGroupRing} {k0 j : Fin 33} :
    j ∈ G.nonNbrList k0 ↔
      G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j = 1 := by
  unfold nonNbrList
  rw [List.mem_filter]
  constructor
  · rintro ⟨_, h⟩
    exact of_decide_eq_true h
  · intro h
    exact ⟨List.mem_finRange j, decide_eq_true h⟩

theorem mem_nonRestList {G : Z3FpfGroupRing} {k0 j : Fin 33} :
    j ∈ G.nonRestList k0 ↔
      G.toOrbitMatrix.B j j = 0 ∧ G.toOrbitMatrix.B k0 j ≠ 1 := by
  unfold nonRestList
  rw [List.mem_filter]
  constructor
  · rintro ⟨_, h⟩
    exact of_decide_eq_true h
  · intro h
    exact ⟨List.mem_finRange j, decide_eq_true h⟩

theorem mem_triPart {G : Z3FpfGroupRing} {k0 j : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    j ∈ G.triPart k0 ↔ G.toOrbitMatrix.B j j = 2 := by
  unfold triPart
  rw [List.mem_append, List.mem_append, List.mem_singleton,
      mem_triNbrList, mem_triRestList]
  constructor
  · rintro ((rfl | h) | h)
    · exact hk0
    · exact h.1
    · exact h.1
  · intro h
    by_cases hjk : j = k0
    · exact Or.inl (Or.inl hjk)
    · by_cases h1 : G.toOrbitMatrix.B k0 j = 1
      · exact Or.inl (Or.inr ⟨h, h1⟩)
      · exact Or.inr ⟨h, hjk, h1⟩

theorem mem_nonPart {G : Z3FpfGroupRing} {k0 j : Fin 33} :
    j ∈ G.nonPart k0 ↔ G.toOrbitMatrix.B j j = 0 := by
  unfold nonPart
  rw [List.mem_append, mem_nonNbrList, mem_nonRestList]
  constructor
  · rintro (h | h)
    · exact h.1
    · exact h.1
  · intro h
    by_cases h1 : G.toOrbitMatrix.B k0 j = 1
    · exact Or.inl ⟨h, h1⟩
    · exact Or.inr ⟨h, h1⟩

/-- Every index occurs in the relabeling list. -/
theorem mem_relabelList {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (j : Fin 33) :
    j ∈ G.relabelList k0 := by
  rw [relabelList_eq, List.mem_append]
  rcases G.toOrbitMatrix.diag_parity j with h | h
  · exact Or.inr (mem_nonPart.mpr h)
  · exact Or.inl ((mem_triPart hk0).mpr h)

theorem triPart_nodup {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    (G.triPart k0).Nodup := by
  unfold triPart
  apply nodup_append
  · apply nodup_append
    · simp
    · exact filter_nodup _
    · intro x hx hxTN
      rw [List.mem_singleton] at hx
      subst hx
      have := (mem_triNbrList.mp hxTN).2
      omega
  · exact filter_nodup _
  · intro x hx hxTR
    have hx2 : G.toOrbitMatrix.B x x = 2 := by
      rw [List.mem_append, List.mem_singleton, mem_triNbrList] at hx
      rcases hx with (rfl | h)
      · exact hk0
      · exact h.1
    have hxTR' := mem_triRestList.mp hxTR
    rw [List.mem_append, List.mem_singleton, mem_triNbrList] at hx
    rcases hx with (rfl | h)
    · exact hxTR'.2.1 rfl
    · exact hxTR'.2.2 h.2

theorem nonPart_nodup {G : Z3FpfGroupRing} {k0 : Fin 33} :
    (G.nonPart k0).Nodup := by
  unfold nonPart
  apply nodup_append
  · exact filter_nodup _
  · exact filter_nodup _
  · intro x hx hxNR
    exact (mem_nonRestList.mp hxNR).2 (mem_nonNbrList.mp hx).2

theorem relabelList_nodup {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    (G.relabelList k0).Nodup := by
  rw [relabelList_eq]
  apply nodup_append
  · exact triPart_nodup hk0
  · exact nonPart_nodup
  · intro x hxT hxN
    have h2 := (mem_triPart hk0).mp hxT
    have h0 := mem_nonPart.mp hxN
    omega

/-- Bridge `if decide P = true` to `if P`. -/
theorem if_decide_true {P : Prop} [Decidable P] (a b : Nat) :
    (if decide P = true then a else b) = if P then a else b := by
  by_cases h : P
  · rw [if_pos h, if_pos (decide_eq_true h)]
  · rw [if_neg h, if_neg (fun c => h (of_decide_eq_true c))]

theorem triNbrList_length {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    (G.triNbrList k0).length = 12 - G.toOrbitMatrix.xT k0 := by
  unfold triNbrList
  rw [filter_length_sumFin,
      sumFin_congr (fun j => if_decide_true (1 : Nat) 0)]
  exact triNbr_count G k0 hk0

theorem triRestList_length {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6) :
    (G.triRestList k0).length = 14 + G.toOrbitMatrix.xT k0 := by
  unfold triRestList
  rw [filter_length_sumFin,
      sumFin_congr (fun j => if_decide_true (1 : Nat) 0)]
  exact triRest_count G k0 hk0 hn

theorem nonNbrList_length {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    (G.nonNbrList k0).length = G.toOrbitMatrix.xT k0 := by
  unfold nonNbrList
  rw [filter_length_sumFin,
      sumFin_congr (fun j => if_decide_true (1 : Nat) 0)]
  exact nonNbr_count G k0 hk0

theorem nonRestList_length {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6) :
    (G.nonRestList k0).length = 6 - G.toOrbitMatrix.xT k0 := by
  unfold nonRestList
  rw [filter_length_sumFin,
      sumFin_congr (fun j => if_decide_true (1 : Nat) 0)]
  exact nonRest_count G k0 hk0 hn

theorem triPart_length {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6) :
    (G.triPart k0).length = 27 := by
  unfold triPart
  rw [List.length_append, List.length_append, List.length_singleton,
      triNbrList_length hk0, triRestList_length hk0 hn]
  have hxle := xT_le_nI G k0 hk0
  rw [hn] at hxle
  omega

theorem nonPart_length {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6) :
    (G.nonPart k0).length = 6 := by
  unfold nonPart
  rw [List.length_append, nonNbrList_length hk0, nonRestList_length hk0 hn]
  have hxle := xT_le_nI G k0 hk0
  rw [hn] at hxle
  omega

theorem relabelList_length {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6) :
    (G.relabelList k0).length = 33 := by
  rw [relabelList_eq, List.length_append, triPart_length hk0 hn, nonPart_length hk0 hn]

/-- Choice-free `List.idxOf_lt_length_of_mem` (the core lemma needs `EquivBEq`,
whose `Fin 33` instance uses `Classical.choice`). -/
theorem idxOf_lt_length_of_mem_d {α : Type u} [BEq α] [LawfulBEq α]
    (l : List α) (a : α) (h : a ∈ l) : l.idxOf a < l.length := by
  induction l with
  | nil => simp at h
  | cons x xs ih =>
      rw [List.idxOf_cons]
      cases hb : (x == a)
      · rw [cond_false]
        have hne : a ≠ x := by
          intro hax
          rw [hax, beq_self_eq_true] at hb
          exact Bool.noConfusion hb
        exact Nat.succ_lt_succ (ih ((List.mem_cons.mp h).resolve_left hne))
      · rw [cond_true]
        exact Nat.zero_lt_succ _

/-! ### The relabeling permutation and its inverse -/

/-- Position `i` ↦ orbit index occupying it: `π i = L[i]`. -/
def relabelPi (G : Z3FpfGroupRing) (k0 : Fin 33)
    (hlen : (G.relabelList k0).length = 33) : Fin 33 → Fin 33 :=
  fun i => (G.relabelList k0).get ⟨i.val, hlen.symm ▸ i.isLt⟩

/-- Orbit index ↦ its position: `σ j = ⟨L.idxOf j, _⟩`. -/
def relabelSigma (G : Z3FpfGroupRing) (k0 : Fin 33)
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) : Fin 33 → Fin 33 :=
  fun j => ⟨(G.relabelList k0).idxOf j,
    by have h := idxOf_lt_length_of_mem_d _ _ (hmem j)
       rw [hlen] at h
       exact h⟩

theorem relabel_left {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hnodup : (G.relabelList k0).Nodup)
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) :
    ∀ i, G.relabelSigma k0 hmem hlen (G.relabelPi k0 hlen i) = i := by
  intro i
  apply Fin.ext
  show (G.relabelList k0).idxOf
      ((G.relabelList k0).get ⟨i.val, hlen.symm ▸ i.isLt⟩) = i.val
  exact hnodup.idxOf_getElem i.val _

theorem relabel_right {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) :
    ∀ j, G.relabelPi k0 hlen (G.relabelSigma k0 hmem hlen j) = j := by
  intro j
  show (G.relabelList k0).get ⟨(G.relabelList k0).idxOf j, _⟩ = j
  exact List.getElem_idxOf _

/-- `idxOf (π i) = i.val`. -/
theorem idxOf_pi {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hnodup : (G.relabelList k0).Nodup)
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) (i : Fin 33) :
    (G.relabelList k0).idxOf (G.relabelPi k0 hlen i) = i.val :=
  congrArg Fin.val (relabel_left hnodup hmem hlen i)

/-- Choice-free variant of `idxOf_append_d` (the core lemma uses
`Classical.choice`, which violates this project's foundation gate). -/
theorem idxOf_append_d {α : Type u} [BEq α] [LawfulBEq α] (l₁ l₂ : List α) (a : α) :
    (l₁ ++ l₂).idxOf a = if a ∈ l₁ then l₁.idxOf a else l₂.idxOf a + l₁.length := by
  induction l₁ with
  | nil => simp
  | cons x xs ih =>
      rw [List.cons_append, List.idxOf_cons]
      cases hb : (x == a)
      · rw [cond_false]
        have hne : a ≠ x := by
          intro hax
          rw [hax, beq_self_eq_true] at hb
          exact Bool.noConfusion hb
        by_cases hin : a ∈ xs
        · rw [if_pos (show a ∈ x :: xs from List.Mem.tail x hin),
              List.idxOf_cons, hb, cond_false]
          rw [if_pos hin] at ih
          rw [ih]
        · have hin' : a ∉ x :: xs := fun hm => by
            rcases List.mem_cons.mp hm with hax | haxs
            · exact hne hax
            · exact hin haxs
          rw [if_neg hin']
          rw [if_neg hin] at ih
          rw [ih]
          rfl
      · rw [cond_true]
        have hxa : x = a := beq_iff_eq.mp hb
        subst hxa
        rw [if_pos (show x ∈ x :: xs from List.Mem.head _),
            List.idxOf_cons, beq_self_eq_true, cond_true]

/-- `σ k0 = 0` since `k0` is the head of the list. -/
theorem idxOf_k0 {G : Z3FpfGroupRing} {k0 : Fin 33} :
    (G.relabelList k0).idxOf k0 = 0 := by
  rw [relabelList_eq, idxOf_append_d]
  rw [if_pos]
  · unfold triPart
    rw [idxOf_append_d, if_pos (List.mem_append_left _ (List.mem_singleton_self k0)),
        List.singleton_append, List.idxOf_cons,
        show (k0 == k0) = true from beq_iff_eq.mpr rfl, cond_true]
  · unfold triPart
    exact List.mem_append_left _ (List.mem_append_left _ (List.mem_singleton_self k0))

theorem sigma_k0 {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) :
    G.relabelSigma k0 hmem hlen k0 = 0 :=
  Fin.ext idxOf_k0

/-- `π i = k0` iff `i = 0` (π is injective and `π 0 = k0`). -/
theorem pi_eq_k0_iff {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hnodup : (G.relabelList k0).Nodup)
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) (i : Fin 33) :
    G.relabelPi k0 hlen i = k0 ↔ i = 0 := by
  constructor
  · intro h
    have hσ := relabel_left hnodup hmem hlen i
    rw [h, sigma_k0 hmem hlen] at hσ
    exact hσ.symm
  · rintro rfl
    have hσ := relabel_right hmem hlen k0
    rw [sigma_k0 hmem hlen] at hσ
    exact hσ

/-! ### Positional characterization of the relabeling list -/

theorem idxOf_triNbr_eq {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) {x : Fin 33}
    (hx : x ∈ G.triNbrList k0) :
    (G.relabelList k0).idxOf x = (G.triNbrList k0).idxOf x + 1 := by
  have hxT : x ∈ G.triPart k0 :=
    List.mem_append_left _ (List.mem_append_right _ hx)
  have hxkTN : x ∈ [k0] ++ G.triNbrList k0 := List.mem_append_right _ hx
  have hxk : x ∉ [k0] := by
    intro h
    rw [List.mem_singleton] at h
    have hb := (mem_triNbrList.mp hx).2
    rw [h] at hb
    omega
  rw [relabelList_eq, idxOf_append_d, if_pos hxT]
  unfold triPart
  rw [idxOf_append_d, if_pos hxkTN, idxOf_append_d, if_neg hxk,
      List.length_singleton]

theorem idxOf_triRest_eq {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) {x : Fin 33}
    (hx : x ∈ G.triRestList k0) :
    (G.relabelList k0).idxOf x =
      (G.triRestList k0).idxOf x + 1 + (G.triNbrList k0).length := by
  have hxT : x ∈ G.triPart k0 := List.mem_append_right _ hx
  have hxkTN : x ∉ [k0] ++ G.triNbrList k0 := by
    intro c
    rw [List.mem_append, List.mem_singleton] at c
    rcases c with h | h
    · subst h
      exact (mem_triRestList.mp hx).2.1 rfl
    · exact (mem_triRestList.mp hx).2.2 (mem_triNbrList.mp h).2
  rw [relabelList_eq, idxOf_append_d, if_pos hxT]
  unfold triPart
  rw [idxOf_append_d, if_neg hxkTN, List.length_append, List.length_singleton]
  omega

theorem idxOf_nonNbr_eq {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    {x : Fin 33} (hx : x ∈ G.nonNbrList k0) :
    (G.relabelList k0).idxOf x = (G.nonNbrList k0).idxOf x + 27 := by
  have hxN : x ∈ G.nonPart k0 := List.mem_append_left _ hx
  have hxT : x ∉ G.triPart k0 := by
    intro c
    have h2 := (mem_triPart hk0).mp c
    have h0 := (mem_nonNbrList.mp hx).1
    omega
  rw [relabelList_eq, idxOf_append_d, if_neg hxT, triPart_length hk0 hn]
  unfold nonPart
  rw [idxOf_append_d, if_pos hx]

theorem idxOf_nonRest_eq {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    {x : Fin 33} (hx : x ∈ G.nonRestList k0) :
    (G.relabelList k0).idxOf x =
      (G.nonRestList k0).idxOf x + (27 + (G.nonNbrList k0).length) := by
  have hxN : x ∈ G.nonPart k0 := List.mem_append_right _ hx
  have hxT : x ∉ G.triPart k0 := by
    intro c
    have h2 := (mem_triPart hk0).mp c
    have h0 := (mem_nonRestList.mp hx).1
    omega
  have hxNN : x ∉ G.nonNbrList k0 := by
    intro c
    exact (mem_nonRestList.mp hx).2 (mem_nonNbrList.mp c).2
  rw [relabelList_eq, idxOf_append_d, if_neg hxT, triPart_length hk0 hn]
  unfold nonPart
  rw [idxOf_append_d, if_neg hxNN]
  omega

/-- Positions of triangle orbits are `< 27`. -/
theorem idxOf_triPart_lt27 {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    {x : Fin 33} (hx : x ∈ G.triPart k0) :
    (G.relabelList k0).idxOf x < 27 := by
  unfold triPart at hx
  rw [List.mem_append, List.mem_append, List.mem_singleton] at hx
  rcases hx with (h | h) | h
  · subst h
    rw [idxOf_k0]
    decide
  · rw [idxOf_triNbr_eq hk0 h]
    have := idxOf_lt_length_of_mem_d _ _ h
    have hl := triNbrList_length hk0
    have hxle := xT_le_nI G k0 hk0
    rw [hn] at hxle
    omega
  · rw [idxOf_triRest_eq hk0 h]
    have := idxOf_lt_length_of_mem_d _ _ h
    have hl1 := triNbrList_length hk0
    have hl2 := triRestList_length hk0 hn
    have hxle := xT_le_nI G k0 hk0
    rw [hn] at hxle
    omega

/-- Positions of non-triangle orbits are `≥ 27`. -/
theorem idxOf_nonPart_ge27 {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    {x : Fin 33} (hx : x ∈ G.nonPart k0) :
    27 ≤ (G.relabelList k0).idxOf x := by
  unfold nonPart at hx
  rw [List.mem_append] at hx
  rcases hx with h | h
  · rw [idxOf_nonNbr_eq hk0 hn h]
    omega
  · rw [idxOf_nonRest_eq hk0 hn h]
    omega

/-- `x ∈ triPart` iff its position is `< 27`. -/
theorem triPart_iff_idxLt27 {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    (x : Fin 33) :
    x ∈ G.triPart k0 ↔ (G.relabelList k0).idxOf x < 27 := by
  constructor
  · exact idxOf_triPart_lt27 hk0 hn
  · intro h
    have hmem := mem_relabelList hk0 x
    rw [relabelList_eq, List.mem_append] at hmem
    rcases hmem with hT | hN
    · exact hT
    · have := idxOf_nonPart_ge27 hk0 hn hN
      omega

/-- `x ∈ nonPart` iff its position is `≥ 27`. -/
theorem nonPart_iff_idxGe27 {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    (x : Fin 33) :
    x ∈ G.nonPart k0 ↔ 27 ≤ (G.relabelList k0).idxOf x := by
  constructor
  · exact idxOf_nonPart_ge27 hk0 hn
  · intro h
    have hmem := mem_relabelList hk0 x
    rw [relabelList_eq, List.mem_append] at hmem
    rcases hmem with hT | hN
    · have := idxOf_triPart_lt27 hk0 hn hT
      omega
    · exact hN

/-- Position bounds characterize `triNbrList`. -/
theorem triNbr_iff_idxBounds {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    (x : Fin 33) :
    x ∈ G.triNbrList k0 ↔
      1 ≤ (G.relabelList k0).idxOf x ∧
        (G.relabelList k0).idxOf x < 1 + (G.triNbrList k0).length := by
  constructor
  · intro hx
    rw [idxOf_triNbr_eq hk0 hx]
    constructor
    · omega
    · have := idxOf_lt_length_of_mem_d _ _ hx
      omega
  · rintro ⟨h1, h2⟩
    have hlt27 : (G.relabelList k0).idxOf x < 27 := by
      have hl := triNbrList_length hk0
      have hxle := xT_le_nI G k0 hk0
      rw [hn] at hxle
      omega
    have hxT := (triPart_iff_idxLt27 hk0 hn x).mpr hlt27
    unfold triPart at hxT
    rw [List.mem_append, List.mem_append, List.mem_singleton] at hxT
    rcases hxT with (h | h) | h
    · subst h
      rw [idxOf_k0] at h1
      omega
    · exact h
    · rw [idxOf_triRest_eq hk0 h] at h2
      omega

/-- Position bounds characterize `nonNbrList`. -/
theorem nonNbr_iff_idxBounds {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    (x : Fin 33) :
    x ∈ G.nonNbrList k0 ↔
      27 ≤ (G.relabelList k0).idxOf x ∧
        (G.relabelList k0).idxOf x < 27 + (G.nonNbrList k0).length := by
  constructor
  · intro hx
    rw [idxOf_nonNbr_eq hk0 hn hx]
    constructor
    · have := nonNbrList_length hk0
      have hxle := xT_le_nI G k0 hk0
      rw [hn] at hxle
      omega
    · have := idxOf_lt_length_of_mem_d _ _ hx
      omega
  · rintro ⟨h1, h2⟩
    have hxN := (nonPart_iff_idxGe27 hk0 hn x).mpr h1
    unfold nonPart at hxN
    rw [List.mem_append] at hxN
    rcases hxN with h | h
    · exact h
    · rw [idxOf_nonRest_eq hk0 hn h] at h2
      omega

/-! ### The row-0 shift -/

theorem fin3_eq012 (s : Fin 3) : s = 0 ∨ s = 1 ∨ s = 2 := by
  obtain ⟨v, hv⟩ := s
  by_cases h0 : v = 0
  · exact Or.inl (Fin.ext h0)
  · by_cases h1 : v = 1
    · exact Or.inr (Or.inl (Fin.ext h1))
    · exact Or.inr (Or.inr (Fin.ext (by omega : v = 2)))

theorem fin3_sub_zero : ∀ a : Fin 3, a - 0 = a := by decide

theorem fin3_add_eq_right : ∀ s a : Fin 3, s + a = a ↔ s = 0 := by decide

/-- Every summand is bounded by the total. -/
theorem sumFin_term_le {n : Nat} (f : Fin n → Nat) (i : Fin n) : f i ≤ sumFin f := by
  unfold sumFin
  have key : ∀ l : List (Fin n), i ∈ l → f i ≤ (l.map f).sum := by
    intro l hmem
    induction l with
    | nil => cases hmem
    | cons x xs ih =>
      rw [List.map_cons, List.sum_cons]
      rcases List.mem_cons.mp hmem with rfl | h
      · exact Nat.le_add_right _ _
      · exact Nat.le_trans (ih h) (Nat.le_add_left _ _)
  exact key _ (List.mem_finRange i)

/-- Dropping a zero term from a filtered sum. -/
theorem sumFin_excl_ne {n : Nat} (a : Fin n) (P : Fin n → Prop)
    [∀ k, Decidable (P k)] (f : Fin n → Nat) (h0 : f a = 0) :
    sumFin (fun k => if P k ∧ k ≠ a then f k else 0) =
      sumFin (fun k => if P k then f k else 0) := by
  apply sumFin_congr
  intro k
  by_cases hk : k = a
  · rw [hk]
    rw [if_neg (fun c => c.2 rfl)]
    by_cases hp : P a
    · rw [if_pos hp, h0]
    · rw [if_neg hp]
  · by_cases hp : P k
    · rw [if_pos ⟨hp, hk⟩, if_pos hp]
    · rw [if_neg (fun c => hp c.1), if_neg hp]

/-- The unique member of a unit shift set `{s}`. -/
def normPick (G₁ : Z3FpfGroupRing) (j : Fin 33) : Fin 3 :=
  if G₁.S 0 j 1 = true then 1 else if G₁.S 0 j 2 = true then 2 else 0

/-- The per-orbit shift normalizing row 0: `c 0 = 0`, `c j =` the unique
    shift for neighbours of orbit 0, `0` elsewhere. -/
def normShiftC (G₁ : Z3FpfGroupRing) : Fin 33 → Fin 3 :=
  fun j => if j = 0 then 0 else normPick G₁ j

theorem normShiftC_zero (G₁ : Z3FpfGroupRing) : normShiftC G₁ 0 = 0 :=
  if_pos rfl

theorem normShiftC_ne {G₁ : Z3FpfGroupRing} {j : Fin 33} (hj : j ≠ 0) :
    normShiftC G₁ j = normPick G₁ j :=
  if_neg hj

/-- On a unit shift set, `normPick` is the unique member. -/
theorem normPick_spec (G₁ : Z3FpfGroupRing) (j : Fin 33)
    (h : G₁.toOrbitMatrix.B 0 j = 1) (s : Fin 3) :
    G₁.S 0 j s = true ↔ s = normPick G₁ j := by
  rw [toOrbitMatrix_B, sumFin_fin3] at h
  rcases fin3_eq012 s with rfl | rfl | rfl <;>
    cases h0 : G₁.S 0 j 0 <;>
    cases h1 : G₁.S 0 j 1 <;>
    cases h2 : G₁.S 0 j 2 <;>
    simp_all [normPick]

/-- On an empty shift set, every shift is false. -/
theorem normShift_all_false (G₁ : Z3FpfGroupRing) (j : Fin 33)
    (h : G₁.toOrbitMatrix.B 0 j = 0) (t : Fin 3) :
    G₁.S 0 j t = false := by
  rw [toOrbitMatrix_B] at h
  have hle := sumFin_term_le (fun u : Fin 3 =>
    if G₁.S 0 j u = true then (1 : Nat) else 0) t
  rw [h] at hle
  have : (if G₁.S 0 j t = true then (1 : Nat) else 0) = 0 := Nat.le_zero.mp hle
  by_cases ht : G₁.S 0 j t = true
  · rw [if_pos ht] at this
    exact absurd this (by decide : (1 : Nat) ≠ 0)
  · exact Bool.eq_false_iff.mpr ht

/-- After the normalizing shift, a row-0 unit set `{s₀}` becomes `{0}`. -/
theorem normShift_row0_eq (G₁ : Z3FpfGroupRing) (j : Fin 33)
    (hj : j ≠ 0) (hB : G₁.toOrbitMatrix.B 0 j = 1) (s : Fin 3) :
    (G₁.shift (normShiftC G₁)).S 0 j s = true ↔ s = 0 := by
  show G₁.S 0 j (s + normShiftC G₁ j - normShiftC G₁ 0) = true ↔ s = 0
  rw [normShiftC_ne hj, normShiftC_zero, fin3_sub_zero]
  exact (normPick_spec G₁ j hB (s + normPick G₁ j)).trans
    (fin3_add_eq_right s (normPick G₁ j))

/-! ### The two position characterizations on `π` -/

/-- `B (π i) (π i) = 2` iff `i < 27`. -/
theorem pi_diag_iff {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hnodup : (G.relabelList k0).Nodup)
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) (i : Fin 33) :
    G.toOrbitMatrix.B (G.relabelPi k0 hlen i) (G.relabelPi k0 hlen i) = 2 ↔
      i.val < 27 := by
  have e1 : G.toOrbitMatrix.B (G.relabelPi k0 hlen i) (G.relabelPi k0 hlen i) = 2 ↔
      G.relabelPi k0 hlen i ∈ G.triPart k0 := (mem_triPart hk0).symm
  have e2 := triPart_iff_idxLt27 hk0 hn (G.relabelPi k0 hlen i)
  rw [idxOf_pi hnodup hmem hlen i] at e2
  exact e1.trans e2

/-- `B k0 (π j) = 1` iff `j` lies in the two neighbour position ranges. -/
theorem pi_nbr_iff {G : Z3FpfGroupRing} {k0 : Fin 33}
    (hnodup : (G.relabelList k0).Nodup)
    (hk0 : G.toOrbitMatrix.B k0 k0 = 2) (hn : G.toOrbitMatrix.nI = 6)
    (hmem : ∀ j : Fin 33, j ∈ G.relabelList k0)
    (hlen : (G.relabelList k0).length = 33) (j : Fin 33) :
    G.toOrbitMatrix.B k0 (G.relabelPi k0 hlen j) = 1 ↔
      (1 ≤ j.val ∧ j.val ≤ 12 - G.toOrbitMatrix.xT k0) ∨
        (27 ≤ j.val ∧ j.val < 27 + G.toOrbitMatrix.xT k0) := by
  have hTNlen := triNbrList_length hk0
  have hNNlen := nonNbrList_length hk0
  rw [← hTNlen, ← hNNlen]
  constructor
  · intro hB1
    have hxk : G.relabelPi k0 hlen j ≠ k0 := by
      intro e
      rw [e] at hB1
      omega
    rcases G.toOrbitMatrix.diag_parity (G.relabelPi k0 hlen j) with hd | hd
    · have hxN : G.relabelPi k0 hlen j ∈ G.nonPart k0 := mem_nonPart.mpr hd
      unfold nonPart at hxN
      rw [List.mem_append] at hxN
      rcases hxN with hNN | hNR
      · right
        have hb := (nonNbr_iff_idxBounds hk0 hn _).mp hNN
        rw [idxOf_pi hnodup hmem hlen j] at hb
        exact ⟨by omega, by omega⟩
      · exact absurd hB1 (mem_nonRestList.mp hNR).2
    · have hxT : G.relabelPi k0 hlen j ∈ G.triPart k0 := (mem_triPart hk0).mpr hd
      unfold triPart at hxT
      rw [List.mem_append, List.mem_append, List.mem_singleton] at hxT
      rcases hxT with (h | h) | h
      · exact absurd h hxk
      · left
        have hb := (triNbr_iff_idxBounds hk0 hn _).mp h
        rw [idxOf_pi hnodup hmem hlen j] at hb
        exact ⟨by omega, by omega⟩
      · exact absurd hB1 (mem_triRestList.mp h).2.2
  · rintro (⟨h1, h2⟩ | ⟨h1, h2⟩)
    · have hb : 1 ≤ (G.relabelList k0).idxOf (G.relabelPi k0 hlen j) ∧
          (G.relabelList k0).idxOf (G.relabelPi k0 hlen j) <
            1 + (G.triNbrList k0).length := by
        rw [idxOf_pi hnodup hmem hlen j]
        exact ⟨by omega, by omega⟩
      exact (mem_triNbrList.mp ((triNbr_iff_idxBounds hk0 hn _).mpr hb)).2
    · have hb : 27 ≤ (G.relabelList k0).idxOf (G.relabelPi k0 hlen j) ∧
          (G.relabelList k0).idxOf (G.relabelPi k0 hlen j) <
            27 + (G.nonNbrList k0).length := by
        rw [idxOf_pi hnodup hmem hlen j]
        exact ⟨by omega, by omega⟩
      exact (mem_nonNbrList.mp ((nonNbr_iff_idxBounds hk0 hn _).mpr hb)).2

/-! ### Normalization -/

/-- WP5: every group-ring frame with `nI = 6` and a triangle orbit `k0`
    relabels and shifts to a frame satisfying `SysB (12 - xT k0)`, and the
    counting hypotheses upgrade it to `Count27` (i.e. `S10` when `xT = 2`). -/
theorem normalize_t27 (G : Z3FpfGroupRing) (hn : G.toOrbitMatrix.nI = 6)
    (k0 : Fin 33) (hk0 : G.toOrbitMatrix.B k0 k0 = 2) :
    ∃ G' : Z3FpfGroupRing, G'.SysB (12 - G.toOrbitMatrix.xT k0) ∧
      ((∀ k, G.toOrbitMatrix.B k k = 2 → G.toOrbitMatrix.xT k = 2) →
       (∀ j, G.toOrbitMatrix.B j j = 0 → G.toOrbitMatrix.aI j = 1) →
        G'.Count27) := by
  have hmem : ∀ j : Fin 33, j ∈ G.relabelList k0 := mem_relabelList hk0
  have hlen : (G.relabelList k0).length = 33 := relabelList_length hk0 hn
  have hnodup : (G.relabelList k0).Nodup := relabelList_nodup hk0
  have hlr : ∀ i, G.relabelSigma k0 hmem hlen (G.relabelPi k0 hlen i) = i :=
    fun i => relabel_left hnodup hmem hlen i
  have hrr : ∀ j, G.relabelPi k0 hlen (G.relabelSigma k0 hmem hlen j) = j :=
    fun j => relabel_right hmem hlen j
  have πinj : ∀ a b : Fin 33,
      G.relabelPi k0 hlen a = G.relabelPi k0 hlen b → a = b := by
    intro a b h
    exact (hlr a).symm.trans ((congrArg _ h).trans (hlr b))
  have πsurj : ∀ y : Fin 33, ∃ x, G.relabelPi k0 hlen x = y :=
    fun y => ⟨_, hrr y⟩
  have hπ0 : G.relabelPi k0 hlen 0 = k0 :=
    (pi_eq_k0_iff hnodup hmem hlen 0).mpr rfl
  let G₁ := G.perm (G.relabelPi k0 hlen) (G.relabelSigma k0 hmem hlen) hlr hrr
  let G' := G₁.shift (normShiftC G₁)
  have hB' : ∀ i j : Fin 33, G'.toOrbitMatrix.B i j =
      G.toOrbitMatrix.B (G.relabelPi k0 hlen i) (G.relabelPi k0 hlen j) := by
    intro i j
    exact (shift_B G₁ _ i j).trans (perm_B G _ _ hlr hrr i j)
  have hB0j : ∀ j : Fin 33, G₁.toOrbitMatrix.B 0 j =
      G.toOrbitMatrix.B k0 (G.relabelPi k0 hlen j) := by
    intro j
    exact (perm_B G _ _ hlr hrr 0 j).trans (by rw [hπ0])
  have hB0le : ∀ j : Fin 33, j ≠ 0 → G₁.toOrbitMatrix.B 0 j ≤ 1 := by
    intro j hj
    rw [hB0j j]
    exact Z3FpfOrbitMatrix.tri_offdiag_le_one G.toOrbitMatrix k0 _ hk0
      (fun e => hj ((pi_eq_k0_iff hnodup hmem hlen j).mp e))
  refine ⟨G', ⟨⟨?_, ?_, ?_⟩, ?_⟩⟩
  · -- Tri27
    intro i
    have e1 : G'.S i i 1 = G₁.S i i 1 := by
      show G₁.S i i (1 + normShiftC G₁ i - normShiftC G₁ i) = G₁.S i i 1
      rw [fin3_add_sub_cancel]
    have e2 : G₁.S i i 1 = G.S (G.relabelPi k0 hlen i) (G.relabelPi k0 hlen i) 1 := rfl
    rw [e1, e2, ← B_diag2_iff]
    exact pi_diag_iff hnodup hk0 hn hmem hlen i
  · -- Gauge
    intro j hj h
    have hj0 : j ≠ 0 := fun e => by
      have : j.val = 0 := congrArg Fin.val e
      omega
    have hf : ∀ s : Fin 3, G'.S 0 j s = true → s = 0 := by
      intro s hs
      have hle := hB0le j hj0
      have hBj : G₁.toOrbitMatrix.B 0 j = 0 ∨ G₁.toOrbitMatrix.B 0 j = 1 := by
        omega
      rcases hBj with h0 | h1
      · have hsf : G'.S 0 j s = false := by
          show G₁.S 0 j (s + normShiftC G₁ j - normShiftC G₁ 0) = false
          rw [normShiftC_ne hj0, normShiftC_zero, fin3_sub_zero]
          exact normShift_all_false G₁ j h0 _
        rw [hsf] at hs
        exact Bool.noConfusion hs
      · exact (normShift_row0_eq G₁ j hj0 h1 s).mp hs
    rcases h with h1 | h2
    · exact absurd (hf 1 h1) (by decide : (1 : Fin 3) ≠ 0)
    · exact absurd (hf 2 h2) (by decide : (2 : Fin 3) ≠ 0)
  · -- Row0
    intro j hj s
    have hj0 : j ≠ 0 := fun e => by
      have : j.val = 0 := congrArg Fin.val e
      omega
    have h12 : 12 - (12 - G.toOrbitMatrix.xT k0) = G.toOrbitMatrix.xT k0 := by
      have hxle := xT_le_nI G k0 hk0
      rw [hn] at hxle
      omega
    rw [h12]
    have hR : (1 ≤ j.val ∧ j.val ≤ 12 - G.toOrbitMatrix.xT k0) ∨
        (27 ≤ j.val ∧ j.val < 27 + G.toOrbitMatrix.xT k0) ↔
        G.toOrbitMatrix.B k0 (G.relabelPi k0 hlen j) = 1 :=
      (pi_nbr_iff hnodup hk0 hn hmem hlen j).symm
    have hle : G.toOrbitMatrix.B k0 (G.relabelPi k0 hlen j) ≤ 1 := by
      have := hB0le j hj0
      rw [hB0j j] at this
      exact this
    by_cases hB1 : G.toOrbitMatrix.B k0 (G.relabelPi k0 hlen j) = 1
    · have hR' : (1 ≤ j.val ∧ j.val ≤ 12 - G.toOrbitMatrix.xT k0) ∨
          (27 ≤ j.val ∧ j.val < 27 + G.toOrbitMatrix.xT k0) := hR.mpr hB1
      have hspec : G'.S 0 j s = true ↔ s = 0 := by
        have hB1' : G₁.toOrbitMatrix.B 0 j = 1 := by
          rw [hB0j j]
          exact hB1
        exact normShift_row0_eq G₁ j hj0 hB1' s
      constructor
      · intro h
        exact ⟨hspec.mp h, hR'⟩
      · rintro ⟨hs, _⟩
        exact hspec.mpr hs
    · have hB0 : G.toOrbitMatrix.B k0 (G.relabelPi k0 hlen j) = 0 := by omega
      have hR' : ¬ ((1 ≤ j.val ∧ j.val ≤ 12 - G.toOrbitMatrix.xT k0) ∨
          (27 ≤ j.val ∧ j.val < 27 + G.toOrbitMatrix.xT k0)) :=
        fun hR'' => hB1 (hR.mp hR'')
      have hB0' : G₁.toOrbitMatrix.B 0 j = 0 := by
        rw [hB0j j]
        exact hB0
      have hsf : G'.S 0 j s = false := by
        show G₁.S 0 j (s + normShiftC G₁ j - normShiftC G₁ 0) = false
        rw [normShiftC_ne hj0, normShiftC_zero, fin3_sub_zero]
        exact normShift_all_false G₁ j hB0' _
      rw [hsf]
      constructor
      · intro h
        exact Bool.noConfusion h
      · rintro ⟨_, hR''⟩
        exact absurd hR'' hR'
  · -- Count27
    intro hxT haI
    constructor
    · intro k hk
      have hpt : ∀ j : Fin 33,
          (if 27 ≤ j.val then sumFin (fun s : Fin 3 =>
              if G'.S k j s = true then (1 : Nat) else 0) else 0) =
          (if 27 ≤ j.val then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen k) (G.relabelPi k0 hlen j)
          else 0) := by
        intro j
        by_cases h : 27 ≤ j.val
        · rw [if_pos h, if_pos h, ← toOrbitMatrix_B]
          exact hB' k j
        · rw [if_neg h, if_neg h]
      rw [sumFin_congr hpt]
      have hcomp := sumFin_comp_eq (G.relabelPi k0 hlen) πinj πsurj
        (fun j' => if 27 ≤ (G.relabelSigma k0 hmem hlen j').val then
          G.toOrbitMatrix.B (G.relabelPi k0 hlen k) j' else 0)
      have hF : ∀ j : Fin 33,
          (if 27 ≤ (G.relabelSigma k0 hmem hlen (G.relabelPi k0 hlen j)).val then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen k) (G.relabelPi k0 hlen j)
          else 0) =
          (if 27 ≤ j.val then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen k) (G.relabelPi k0 hlen j)
          else 0) := by
        intro j
        rw [hlr j]
      rw [sumFin_congr hF] at hcomp
      rw [hcomp]
      have hF2 : ∀ j' : Fin 33,
          (if 27 ≤ (G.relabelSigma k0 hmem hlen j').val then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen k) j' else 0) =
          (if G.toOrbitMatrix.B j' j' = 0 then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen k) j' else 0) := by
        intro j'
        have hiff : 27 ≤ (G.relabelSigma k0 hmem hlen j').val ↔
            G.toOrbitMatrix.B j' j' = 0 := by
          show 27 ≤ (G.relabelList k0).idxOf j' ↔ _
          exact (nonPart_iff_idxGe27 hk0 hn j').symm.trans mem_nonPart
        exact if_congr_prop hiff _ _
      rw [sumFin_congr hF2]
      exact hxT _ ((pi_diag_iff hnodup hk0 hn hmem hlen k).mpr hk)
    · intro j hj
      have hpt : ∀ k : Fin 33,
          (if 27 ≤ k.val ∧ k ≠ j then sumFin (fun s : Fin 3 =>
              if G'.S j k s = true then (1 : Nat) else 0) else 0) =
          (if 27 ≤ k.val ∧ k ≠ j then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen j) (G.relabelPi k0 hlen k)
          else 0) := by
        intro k
        by_cases h : 27 ≤ k.val ∧ k ≠ j
        · rw [if_pos h, if_pos h, ← toOrbitMatrix_B]
          exact hB' j k
        · rw [if_neg h, if_neg h]
      rw [sumFin_congr hpt]
      have hcomp := sumFin_comp_eq (G.relabelPi k0 hlen) πinj πsurj
        (fun k' => if 27 ≤ (G.relabelSigma k0 hmem hlen k').val ∧
            G.relabelSigma k0 hmem hlen k' ≠ j then
          G.toOrbitMatrix.B (G.relabelPi k0 hlen j) k' else 0)
      have hF : ∀ k : Fin 33,
          (if 27 ≤ (G.relabelSigma k0 hmem hlen (G.relabelPi k0 hlen k)).val ∧
              G.relabelSigma k0 hmem hlen (G.relabelPi k0 hlen k) ≠ j then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen j) (G.relabelPi k0 hlen k)
          else 0) =
          (if 27 ≤ k.val ∧ k ≠ j then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen j) (G.relabelPi k0 hlen k)
          else 0) := by
        intro k
        rw [hlr k]
      rw [sumFin_congr hF] at hcomp
      rw [hcomp]
      have hF2 : ∀ k' : Fin 33,
          (if 27 ≤ (G.relabelSigma k0 hmem hlen k').val ∧
              G.relabelSigma k0 hmem hlen k' ≠ j then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen j) k' else 0) =
          (if G.toOrbitMatrix.B k' k' = 0 ∧ k' ≠ G.relabelPi k0 hlen j then
            G.toOrbitMatrix.B (G.relabelPi k0 hlen j) k' else 0) := by
        intro k'
        have hiff : (27 ≤ (G.relabelSigma k0 hmem hlen k').val ∧
            G.relabelSigma k0 hmem hlen k' ≠ j) ↔
            (G.toOrbitMatrix.B k' k' = 0 ∧ k' ≠ G.relabelPi k0 hlen j) := by
          constructor
          · rintro ⟨h27, hne⟩
            refine ⟨mem_nonPart.mp ((nonPart_iff_idxGe27 hk0 hn k').mpr h27),
              fun e => hne ?_⟩
            rw [e]
            exact hlr j
          · rintro ⟨h0, hne⟩
            refine ⟨(nonPart_iff_idxGe27 hk0 hn k').mp (mem_nonPart.mpr h0),
              fun e => hne ?_⟩
            exact (hrr k').symm.trans (congrArg _ e)
        exact if_congr_prop hiff _ _
      rw [sumFin_congr hF2]
      have hπjI : G.toOrbitMatrix.B (G.relabelPi k0 hlen j)
          (G.relabelPi k0 hlen j) = 0 := by
        have hidx : 27 ≤ (G.relabelList k0).idxOf (G.relabelPi k0 hlen j) := by
          rw [idxOf_pi hnodup hmem hlen j]
          exact hj
        exact mem_nonPart.mp ((nonPart_iff_idxGe27 hk0 hn _).mpr hidx)
      rw [sumFin_excl_ne (G.relabelPi k0 hlen j)
            (fun k' => G.toOrbitMatrix.B k' k' = 0)
            (fun k' => G.toOrbitMatrix.B (G.relabelPi k0 hlen j) k') hπjI]
      have hxT5 : G.toOrbitMatrix.xT (G.relabelPi k0 hlen j) = 5 := by
        have hx := Z3FpfOrbitMatrix.xT_eq_of_I G.toOrbitMatrix _ hπjI
        rw [haI _ hπjI] at hx
        omega
      exact hxT5

/-- At least one triangle orbit exists when `nI = 6`. -/
theorem exists_tri (G : Z3FpfGroupRing) (hn : G.toOrbitMatrix.nI = 6) :
    ∃ k : Fin 33, G.toOrbitMatrix.B k k = 2 := by
  have hc := tri_count G hn
  by_cases hany : (List.finRange 33).any
      (fun k => decide (G.toOrbitMatrix.B k k = 2)) = true
  · rcases List.any_eq_true.mp hany with ⟨k, _, hk⟩
    exact ⟨k, of_decide_eq_true hk⟩
  · have hz : ∀ j : Fin 33, ¬ (G.toOrbitMatrix.B j j = 2) := by
      intro j hjj
      apply hany
      rw [List.any_eq_true]
      exact ⟨j, List.mem_finRange j, decide_eq_true hjj⟩
    have h0 : sumFin (fun j : Fin 33 =>
        if G.toOrbitMatrix.B j j = 2 then (1 : Nat) else 0) = 0 := by
      apply zero_fun_sumFin
      intro j
      exact if_neg (hz j)
    omega

/-- WP6: the `t = 27` orbit-matrix branch is excluded once the encoder systems
`B6`, `B7`, `B8`, `B9`, `B11`, `S10` are certified empty. Conditional: the six
hypotheses are exactly the SAT certifications. -/
theorem z3_fpf_t27_excluded
    (h6 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 6) (h7 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 7)
    (h8 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 8) (h9 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 9)
    (h11 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 11) (h10 : ¬ ∃ G : Z3FpfGroupRing, G.SysS10) :
    ¬ ∃ G : Z3FpfGroupRing, G.toOrbitMatrix.nI = 6 := by
  rintro ⟨G, hn⟩
  have hx02 : ∀ k : Fin 33, G.toOrbitMatrix.B k k = 2 →
      G.toOrbitMatrix.xT k = 0 ∨ G.toOrbitMatrix.xT k = 2 := by
    intro k hk
    obtain ⟨G', hB, -⟩ := normalize_t27 G hn k hk
    have hxle := xT_le_nI G k hk
    rw [hn] at hxle
    have hn6 : ¬ (12 - G.toOrbitMatrix.xT k = 6) := fun e => h6 ⟨G', e ▸ hB⟩
    have hn7 : ¬ (12 - G.toOrbitMatrix.xT k = 7) := fun e => h7 ⟨G', e ▸ hB⟩
    have hn8 : ¬ (12 - G.toOrbitMatrix.xT k = 8) := fun e => h8 ⟨G', e ▸ hB⟩
    have hn9 : ¬ (12 - G.toOrbitMatrix.xT k = 9) := fun e => h9 ⟨G', e ▸ hB⟩
    have hn11 : ¬ (12 - G.toOrbitMatrix.xT k = 11) := fun e => h11 ⟨G', e ▸ hB⟩
    omega
  obtain ⟨hT, hI⟩ := G.toOrbitMatrix.t27_forces hn hx02
  obtain ⟨k0, hk0⟩ := exists_tri G hn
  obtain ⟨G', hB, hC⟩ := normalize_t27 G hn k0 hk0
  have h10eq : 12 - G.toOrbitMatrix.xT k0 = 10 := by
    have hx := hT k0 hk0
    omega
  have hB10 : G'.SysB 10 := h10eq ▸ hB
  exact h10 ⟨G', hB10, hC hT hI⟩

/-- Graph-level version: a fixed-point-free order-3 automorphism of a Conway
adjacency matrix with `81` automorphism edges is excluded once the six encoder
systems are certified empty. Conditional on the same six SAT certifications. -/
theorem conway_no_z3_fpf_t27
    (h6 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 6) (h7 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 7)
    (h8 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 8) (h9 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 9)
    (h11 : ¬ ∃ G : Z3FpfGroupRing, G.SysB 11) (h10 : ¬ ∃ G : Z3FpfGroupRing, G.SysS10) :
    ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧ ∃ g : Fin 99 → Fin 99,
      IsZ3FpfAutomorphism A g ∧
      sumFin (fun x : Fin 99 => if A x (g x) = 1 then (1 : Nat) else 0) = 81 := by
  rintro ⟨A, hA, g, hg, h81⟩
  have hcount := conway_z3_fpf_triangle_edge_count A hA g hg
  rw [h81] at hcount
  have hT : sumFin (fun k : Fin 33 =>
      if (fpfGroupRing A hA g hg).S k k 1 = true then (1 : Nat) else 0) = 27 := by
    omega
  have hnI : (fpfGroupRing A hA g hg).toOrbitMatrix.nI = 6 := by
    have hB2 : ∀ k : Fin 33,
        ((fpfGroupRing A hA g hg).toOrbitMatrix.B k k = 2) ↔
        ((fpfGroupRing A hA g hg).S k k 1 = true) := by
      intro k
      have hBk : (fpfGroupRing A hA g hg).toOrbitMatrix.B k k =
          sumFin (fun s : Fin 3 =>
            if (fpfGroupRing A hA g hg).S k k s = true then (1 : Nat) else 0) :=
        (fpfGroupRing A hA g hg).toOrbitMatrix_B k k
      have h0 : (fpfGroupRing A hA g hg).S k k 0 = false :=
        (fpfGroupRing A hA g hg).loopless k
      have hd : (fpfGroupRing A hA g hg).S k k 1 =
          (fpfGroupRing A hA g hg).S k k 2 := (fpfGroupRing A hA g hg).diag k
      rw [hBk, Z3FpfGroupRing.sumFin_fin3]
      cases h1 : (fpfGroupRing A hA g hg).S k k 1
      · have h2 : (fpfGroupRing A hA g hg).S k k 2 = false := by rw [← hd, h1]
        simp [h0, h2]
      · have h2 : (fpfGroupRing A hA g hg).S k k 2 = true := by rw [← hd, h1]
        simp [h0, h2]
    have hsplit : sumFin (fun k : Fin 33 =>
          if (fpfGroupRing A hA g hg).toOrbitMatrix.B k k = 2
            then (1 : Nat) else 0) +
        (fpfGroupRing A hA g hg).toOrbitMatrix.nI = 33 := by
      have htot : sumFin (fun _ : Fin 33 => (1 : Nat)) = 33 := by decide
      have hs : sumFin (fun k : Fin 33 =>
            if (fpfGroupRing A hA g hg).toOrbitMatrix.B k k = 2
              then (1 : Nat) else 0) +
          sumFin (fun k : Fin 33 =>
            if (fpfGroupRing A hA g hg).toOrbitMatrix.B k k = 0
              then (1 : Nat) else 0) =
          sumFin (fun _ : Fin 33 => (1 : Nat)) := by
        rw [← sumFin_add]
        apply sumFin_congr
        intro k
        rcases (fpfGroupRing A hA g hg).toOrbitMatrix.diag_parity k with h | h
        · rw [if_pos h,
            if_neg (by omega : ¬ ((fpfGroupRing A hA g hg).toOrbitMatrix.B k k = 2))]
        · rw [if_pos h,
            if_neg (by omega : ¬ ((fpfGroupRing A hA g hg).toOrbitMatrix.B k k = 0))]
      rw [htot] at hs
      exact hs
    have hB2sum : sumFin (fun k : Fin 33 =>
        if (fpfGroupRing A hA g hg).toOrbitMatrix.B k k = 2
          then (1 : Nat) else 0) =
        sumFin (fun k : Fin 33 =>
          if (fpfGroupRing A hA g hg).S k k 1 = true then (1 : Nat) else 0) := by
      apply sumFin_congr
      intro k
      exact Z3FpfGroupRing.if_congr_prop (hB2 k) _ _
    omega
  exact z3_fpf_t27_excluded h6 h7 h8 h9 h11 h10 ⟨fpfGroupRing A hA g hg, hnI⟩

end Z3FpfGroupRing
end Matrix99

#check Matrix99.Z3FpfGroupRing.normalize_t27
#print axioms Matrix99.Z3FpfGroupRing.normalize_t27
#check Matrix99.Z3FpfGroupRing.exists_tri
#print axioms Matrix99.Z3FpfGroupRing.exists_tri
#check Matrix99.Z3FpfGroupRing.z3_fpf_t27_excluded
#print axioms Matrix99.Z3FpfGroupRing.z3_fpf_t27_excluded
#check Matrix99.Z3FpfGroupRing.conway_no_z3_fpf_t27
#print axioms Matrix99.Z3FpfGroupRing.conway_no_z3_fpf_t27
