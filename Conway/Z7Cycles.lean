import Conway.OrbitQuotient
import Conway.OrbitReindex

namespace ConwayOrbit

def cycle7 {n : Nat} (s : Fin n → Fin n) (u : Fin n) : List (Fin n) :=
  (List.finRange 7).map (fun k => s^[k.val] u)

def countSet {n : Nat} (P : Fin n → Bool) : Nat :=
  sumFin (fun u => if P u then 1 else 0)

def fixedIn {n : Nat} (s : Fin n → Fin n) (P : Fin n → Bool) : Nat :=
  countSet (fun u => P u && decide (s u = u))

theorem mem_erase_of_ne_local {α : Type} [DecidableEq α] {a x : α} {l : List α}
    (h : x ≠ a) : x ∈ l.erase a ↔ x ∈ l := by
  induction l with
  | nil => simp
  | cons b t ih =>
    rw [List.erase_cons]
    by_cases hba : b = a
    · subst b
      simp [h]
    · have hne : ¬b == a := by
        intro he
        exact hba (LawfulBEq.eq_of_beq he)
      simp [hne, ih]

theorem length_erase_local {α : Type} [DecidableEq α] {a : α} {l : List α}
    (ha : a ∈ l) : (l.erase a).length = l.length - 1 := by
  induction l with
  | nil => contradiction
  | cons b t ih =>
    by_cases hba : b = a
    · subst b
      simp
    · have hba' : a ≠ b := Ne.symm hba
      have hat : a ∈ t := by simpa [hba, hba'] using ha
      have hne : ¬b == a := by
        intro he
        exact hba (LawfulBEq.eq_of_beq he)
      rw [List.erase_cons, if_neg hne, List.length_cons, ih hat]
      exact Nat.sub_add_cancel (List.length_pos_of_mem hat)

theorem list_nodup_length_le {α : Type} [DecidableEq α] {l₁ l₂ : List α}
    (h₁ : l₁.Nodup) (hsub : l₁ ⊆ l₂) : l₁.length ≤ l₂.length := by
  induction l₁ generalizing l₂ with
  | nil => simp
  | cons a t ih =>
    rw [List.nodup_cons] at h₁
    have ha : a ∈ l₂ := hsub (List.mem_cons_self ..)
    have htsub : t ⊆ l₂.erase a := by
      intro x hx
      have hxa : x ≠ a := fun h => h₁.1 (h ▸ hx)
      exact (mem_erase_of_ne_local hxa).2 (hsub (List.mem_cons_of_mem _ hx))
    have hih := ih h₁.2 htsub
    have hlen : (l₂.erase a).length = l₂.length - 1 := by
      exact length_erase_local ha
    have hpos : 1 ≤ l₂.length := List.length_pos_of_mem ha
    calc
      t.length + 1 ≤ (l₂.erase a).length + 1 := Nat.succ_le_succ hih
      _ = (l₂.length - 1) + 1 := by rw [hlen]
      _ = l₂.length := Nat.sub_add_cancel hpos

theorem countSet_eq_length_filter {n : Nat} (P : Fin n → Bool) :
    countSet P = ((List.finRange n).filter P).length := by
  unfold countSet sumFin
  have hsum : ∀ (l : List (Fin n)),
      (l.filter P).length = (l.map (fun v => if P v then 1 else 0)).sum := by
    intro l
    induction l with
    | nil => rfl
    | cons a t ih =>
      cases hp : P a <;> simp [hp, ih, Nat.add_comm]
  rw [hsum]

theorem countSet_mem_list {n : Nat} (l : List (Fin n)) (hnd : l.Nodup) :
    countSet (fun v => decide (v ∈ l)) = l.length := by
  rw [countSet_eq_length_filter]
  have filter_nodup : ∀ xs : List (Fin n), xs.Nodup →
      (xs.filter (fun v => decide (v ∈ l))).Nodup := by
    intro xs hxs
    induction xs with
    | nil => exact List.nodup_nil
    | cons a t ih =>
      rw [List.nodup_cons] at hxs
      cases hp : decide (a ∈ l) with
      | false => simpa [hp] using ih hxs.2
      | true =>
        simp [hp]
        exact ⟨by simpa [hp] using hxs.1, ih hxs.2⟩
  have hfilter := filter_nodup (List.finRange n) (List.nodup_finRange n)
  have hsub₁ : (List.finRange n).filter (fun v => decide (v ∈ l)) ⊆ l := by
    intro v hv
    have := List.mem_filter.mp hv
    exact of_decide_eq_true this.2
  have hsub₂ : l ⊆ (List.finRange n).filter (fun v => decide (v ∈ l)) := by
    intro v hv
    apply List.mem_filter.mpr
    exact ⟨List.mem_finRange v, by simpa using hv⟩
  apply Nat.le_antisymm
  · exact list_nodup_length_le hfilter hsub₁
  · exact list_nodup_length_le hnd hsub₂

theorem iterate_injective {n : Nat} (s : Fin n → Fin n)
    (hinj : Function.Injective s) : ∀ k, Function.Injective (s^[k]) := by
  intro k
  induction k with
  | zero => intro x y h; exact h
  | succ k ih =>
    intro x y h
    change s (s^[k] x) = s (s^[k] y) at h
    exact ih (hinj h)

theorem cycle7_short_return {n} (s : Fin n → Fin n) (h7 : s^[7] = id)
    (u : Fin n) (k : Nat) (hk0 : 0 < k) (hk7 : k < 7) (hret : s^[k] u = u) : s u = u := by
  have hpow : ∀ r : Nat, s^[r * k] u = u := by
    intro r
    induction r with
    | zero => simp [Function.iterate]
    | succ r ih =>
      rw [Nat.succ_mul, iterate_add_apply, hret, ih]
  have hcase : k = 1 ∨ k = 2 ∨ k = 3 ∨ k = 4 ∨ k = 5 ∨ k = 6 := by omega
  rcases hcase with rfl | rfl | rfl | rfl | rfl | rfl
  · have hm := iterate_mod_period 7 (by decide) s h7 (1 * 1) u
    have hp := hpow 1
    simpa [Function.iterate] using hm.symm.trans hp
  · have hm := iterate_mod_period 7 (by decide) s h7 (4 * 2) u
    have hp := hpow 4
    simpa [Function.iterate] using hm.symm.trans hp
  · have hm := iterate_mod_period 7 (by decide) s h7 (5 * 3) u
    have hp := hpow 5
    simpa [Function.iterate] using hm.symm.trans hp
  · have hm := iterate_mod_period 7 (by decide) s h7 (2 * 4) u
    have hp := hpow 2
    simpa [Function.iterate] using hm.symm.trans hp
  · have hm := iterate_mod_period 7 (by decide) s h7 (3 * 5) u
    have hp := hpow 3
    simpa [Function.iterate] using hm.symm.trans hp
  · have hm := iterate_mod_period 7 (by decide) s h7 (6 * 6) u
    have hp := hpow 6
    simpa [Function.iterate] using hm.symm.trans hp

theorem cycle7_nodup {n} (s : Fin n → Fin n) (h7 : s^[7] = id)
    (u : Fin n) (hmove : s u ≠ u) : (cycle7 s u).Nodup := by
  unfold cycle7
  apply nodup_map_injective (fun k : Fin 7 => s^[k.val] u) (List.nodup_finRange 7)
  intro a b hab
  by_cases hab_eq : a = b
  · exact hab_eq
  · by_cases hlt : a.val < b.val
    · have hcancel : s^[a.val] (s^[(b.val - a.val)] u) = s^[a.val] u := by
        rw [← iterate_add_apply s a.val (b.val - a.val) u]
        rw [show a.val + (b.val - a.val) = b.val by omega, ← hab]
      have hret : s^[(b.val - a.val)] u = u :=
        iterate_injective s (iterate_bijective (by decide) s h7).1 a.val hcancel
      exact False.elim (hmove (cycle7_short_return s h7 u (b.val - a.val)
        (by omega) (by omega) hret))
    · have hlt' : b.val < a.val := by omega
      have hcancel : s^[b.val] (s^[(a.val - b.val)] u) = s^[b.val] u := by
        rw [← iterate_add_apply s b.val (a.val - b.val) u]
        rw [show b.val + (a.val - b.val) = a.val by omega, hab]
      have hret : s^[(a.val - b.val)] u = u :=
        iterate_injective s (iterate_bijective (by decide) s h7).1 b.val hcancel
      exact False.elim (hmove (cycle7_short_return s h7 u (a.val - b.val)
        (by omega) (by omega) hret))

theorem mem_cycle7_iff_pre {n} (s : Fin n → Fin n) (u v : Fin n) :
    v ∈ cycle7 s u ↔ SameOrbit 7 s u v := by
  unfold cycle7 SameOrbit
  constructor
  · intro h
    have ⟨k, hk, hkv⟩ := List.mem_map.mp h
    exact ⟨⟨k.val, by omega⟩, hkv⟩
  · intro h
    obtain ⟨k, hk⟩ := h
    apply List.mem_map.mpr
    exact ⟨k, List.mem_finRange k, hk⟩

theorem orbit7_fiber_size {n} (s : Fin n → Fin n) (h7 : s^[7] = id) (u : Fin n) :
    fiberSize (orbitLabel 7 s) (orbitLabel 7 s u) = if s u = u then 1 else 7 := by
  by_cases hfixed : s u = u
  · have hiter : ∀ k : Nat, s^[k] u = u := by
      intro k
      induction k with
      | zero => rfl
      | succ k ih =>
        change s (s^[k] u) = u
        rw [ih, hfixed]
    have hsame : ∀ v : Fin n, SameOrbit 7 s u v ↔ u = v := by
      intro v
      constructor
      · intro hv
        obtain ⟨k, hk⟩ := hv
        rw [hiter k.val] at hk
        exact hk
      · intro hv
        subst v
        exact sameOrbit_refl (by decide) u
    have hlabel : ∀ v : Fin n,
        decide (orbitLabel 7 s v = orbitLabel 7 s u) = decide (v = u) := by
      intro v
      have heq := orbitLabel_eq_iff (n := n) (p := 7) (by decide) s h7 v u
      have hvu : SameOrbit 7 s v u ↔ v = u := by
        constructor
        · intro h
          exact ((hsame v).mp (sameOrbit_symm (by decide) h7 h)).symm
        · intro h
          subst v
          exact sameOrbit_refl (by decide) u
      simp [heq, hvu]
    rw [if_pos hfixed]
    unfold fiberSize fiberSum
    calc
      sumFin (fun v => if orbitLabel 7 s v = orbitLabel 7 s u then 1 else 0) =
          sumFin (fun v => if v = u then 1 else 0) := by
            apply congrArg sumFin
            funext v
            have hv := hlabel v
            by_cases h1 : orbitLabel 7 s v = orbitLabel 7 s u <;>
              by_cases h2 : v = u <;>
              simp [h1, h2] at hv ⊢
      _ = 1 := by simpa [eq_comm] using sumFin_indicator_value u (fun _ => 1)
  · have hmove : s u ≠ u := hfixed
    have hpred : ∀ v : Fin n,
        decide (orbitLabel 7 s v = orbitLabel 7 s u) = decide (v ∈ cycle7 s u) := by
      intro v
      have heq := orbitLabel_eq_iff (n := n) (p := 7) (by decide) s h7 v u
      have hmem := mem_cycle7_iff_pre s u v
      have hiff : SameOrbit 7 s v u ↔ v ∈ cycle7 s u := by
        constructor
        · intro h
          exact hmem.mpr (sameOrbit_symm (by decide) h7 h)
        · intro h
          exact sameOrbit_symm (by decide) h7 (hmem.mp h)
      by_cases h1 : orbitLabel 7 s v = orbitLabel 7 s u
      · have hso := heq.mp h1
        have hm := hiff.mp hso
        simp [h1, hm]
      · by_cases h2 : v ∈ cycle7 s u
        · have hso := hiff.mpr h2
          have hl := heq.mpr hso
          exact False.elim (h1 hl)
        · simp [h1, h2]
    rw [if_neg hfixed]
    unfold fiberSize fiberSum
    calc
      sumFin (fun v => if orbitLabel 7 s v = orbitLabel 7 s u then 1 else 0) =
          sumFin (fun v => if v ∈ cycle7 s u then 1 else 0) := by
            apply congrArg sumFin
            funext v
            have hv := hpred v
            by_cases h1 : orbitLabel 7 s v = orbitLabel 7 s u
            · have hv' := hpred v
              have hb : decide (v ∈ cycle7 s u) = true := by simpa [h1] using hv'
              have h2 := of_decide_eq_true hb
              simp [h1, h2]
            · by_cases h2 : v ∈ cycle7 s u
              · have hv' := hpred v
                have hb : decide (orbitLabel 7 s v = orbitLabel 7 s u) = true := by
                  simpa [h2] using hv'
                exact False.elim (h1 (of_decide_eq_true hb))
              · simp [h1, h2]
      _ = 7 := by
        have hc := countSet_mem_list (cycle7 s u) (cycle7_nodup s h7 u hmove)
        unfold countSet at hc
        simpa [cycle7] using hc

theorem countSet_cycle_lower_bound {n} (s : Fin n → Fin n) (h7 : s^[7] = id)
    (P : Fin n → Bool) (hP : ∀ u, P (s u) = P u)
    (u : Fin n) (hu : P u = true) (hmove : s u ≠ u) : 7 ≤ countSet P := by
  have hPcycle : ∀ k : Nat, P (s^[k] u) = true := by
    intro k
    induction k with
    | zero => exact hu
    | succ k ih =>
      change P (s (s^[k] u)) = true
      rw [hP, ih]
  have hsub : cycle7 s u ⊆ (List.finRange n).filter P := by
    intro v hv
    apply List.mem_filter.mpr
    exact ⟨List.mem_finRange v, by
      obtain ⟨k, hk, hkv⟩ := List.mem_map.mp hv
      rw [← hkv]
      exact hPcycle k.val⟩
  have hlen := list_nodup_length_le (cycle7_nodup s h7 u hmove) hsub
  rw [countSet_eq_length_filter]
  simpa [cycle7] using hlen

theorem sumFin_mod_congr {n : Nat} {f g : Fin n → Nat}
    (h : ∀ u, f u % 7 = g u % 7) : sumFin f % 7 = sumFin g % 7 := by
  unfold sumFin
  have hlist : ∀ l : List (Fin n),
      (l.map f).sum % 7 = (l.map g).sum % 7 := by
    intro l
    induction l with
    | nil => rfl
    | cons u t ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [Nat.add_mod, Nat.add_mod, h u, ih]
      rw [Nat.mod_mod, Nat.mod_mod]
      exact (Nat.add_mod (g u) (List.map g t).sum 7).symm
  exact hlist (List.finRange n)

theorem orbitLabel_eq_self_of_fixed {n} (s : Fin n → Fin n)
    (h7 : s^[7] = id) (u : Fin n) (hfixed : s u = u) :
    orbitLabel 7 s u = u := by
  have hiter : ∀ k : Nat, s^[k] u = u := by
    intro k
    induction k with
    | zero => rfl
    | succ k ih =>
      change s (s^[k] u) = u
      rw [ih, hfixed]
  have hm := orbitLabel_mem (by decide) s h7 u
  obtain ⟨k, hk⟩ := hm
  rw [hiter k.val] at hk
  exact hk.symm

theorem bool_invariant_iterate {n : Nat} (s : Fin n → Fin n)
    (P : Fin n → Bool) (hP : ∀ u, P (s u) = P u)
    (k : Nat) (u : Fin n) : P (s^[k] u) = P u := by
  induction k with
  | zero => rfl
  | succ k ih =>
    change P (s (s^[k] u)) = P u
    rw [hP, ih]

theorem bool_invariant_sameOrbit {n : Nat} (s : Fin n → Fin n)
    (P : Fin n → Bool) (hP : ∀ u, P (s u) = P u)
    {u v : Fin n} (h : SameOrbit 7 s u v) : P v = P u := by
  obtain ⟨k, hk⟩ := h
  rw [← hk, bool_invariant_iterate s P hP k.val u]

theorem countSet_mod_seven {n} (s : Fin n → Fin n) (h7 : s^[7] = id)
    (P : Fin n → Bool) (hP : ∀ u, P (s u) = P u) :
    countSet P % 7 = fixedIn s P % 7 := by
  let label := orbitLabel 7 s
  have hpart : sumFin (fun j => fiberSum label (fun v => if P v then 1 else 0) j) = countSet P := by
    change sumFin (fiberSum label (fun v => if P v then 1 else 0)) = countSet P
    rw [fiber_sum_partition]
    rfl
  have hpoint : ∀ j : Fin n,
      fiberSum label (fun v => if P v then 1 else 0) j % 7 =
        (if P j && decide (s j = j) then 1 else 0) % 7 := by
    intro j
    by_cases hj : label j = j
    · by_cases hpj : P j = true
      · have hsum : fiberSum label (fun v => if P v then 1 else 0) j = fiberSize label j := by
          unfold fiberSum fiberSize
          apply congrArg List.sum
          apply List.map_congr_left
          intro v hv
          by_cases hvj : label v = j
          · have hso := orbitLabel_eq_iff (n := n) (p := 7) (by decide) s h7 v j
            have hlabels : orbitLabel 7 s v = orbitLabel 7 s j := by
              change label v = label j
              rw [hvj, hj]
            have hpv := bool_invariant_sameOrbit s P hP (hso.mp hlabels)
            have hpv' : P v = true := by rw [← hpv]; exact hpj
            simp [hvj, hpv']
          · simp [hvj]
        rw [hsum]
        have hsize := orbit7_fiber_size s h7 j
        have hsize' : fiberSize (orbitLabel 7 s) j = if s j = j then 1 else 7 := by
          simpa [label, hj] using hsize
        by_cases hsj : s j = j
        · rw [hsize']
          simp [hpj, hsj]
        · rw [hsize']
          simp [hpj, hsj]
      · have hsum : fiberSum label (fun v => if P v then 1 else 0) j = 0 := by
          unfold fiberSum sumFin
          calc
            (List.map (fun v => if label v = j then (if P v then 1 else 0) else 0)
              (List.finRange n)).sum =
                (List.map (fun _ : Fin n => 0) (List.finRange n)).sum := by
                  apply congrArg List.sum
                  apply List.map_congr_left
                  intro v hv
                  by_cases hvj : label v = j
                  · have hso := orbitLabel_eq_iff (n := n) (p := 7) (by decide) s h7 v j
                    have hlabels : orbitLabel 7 s v = orbitLabel 7 s j := by
                      change label v = label j
                      rw [hvj, hj]
                    have hpv := bool_invariant_sameOrbit s P hP (hso.mp hlabels)
                    have hpv' : ¬P v = true := by
                      intro h
                      exact hpj (hpv.trans h)
                    simp [hvj, hpv']
                  · simp [hvj]
            _ = 0 := sum_map_zero (List.finRange n)
        rw [hsum]
        simp [hpj]
    · have hzero : fiberSum label (fun v => if P v then 1 else 0) j = 0 := by
        unfold fiberSum sumFin
        calc
          (List.map (fun v => if label v = j then (if P v then 1 else 0) else 0)
            (List.finRange n)).sum =
              (List.map (fun _ : Fin n => 0) (List.finRange n)).sum := by
                apply congrArg List.sum
                apply List.map_congr_left
                intro v hv
                by_cases hvj : label v = j
                · apply False.elim
                  apply hj
                  rw [← hvj]
                  exact orbitLabel_idempotent (by decide) s h7 v
                · simp [hvj]
          _ = 0 := sum_map_zero (List.finRange n)
      rw [hzero]
      have hfixed : ¬s j = j := by
        intro hsj
        apply hj
        exact orbitLabel_eq_self_of_fixed s h7 j hsj
      simp [hfixed]
  calc
    countSet P % 7 = sumFin (fun j => fiberSum label (fun v => if P v then 1 else 0) j) % 7 := by rw [hpart]
    _ = sumFin (fun j => if P j && decide (s j = j) then 1 else 0) % 7 :=
      sumFin_mod_congr hpoint
    _ = fixedIn s P % 7 := by rfl

theorem mem_cycle7_iff {n} (s : Fin n → Fin n) (u v : Fin n) :
    v ∈ cycle7 s u ↔ SameOrbit 7 s u v := mem_cycle7_iff_pre s u v

theorem period7_has_fixed_on_99 (s : Fin 99 → Fin 99) (h7 : s^[7] = id) :
    ∃ u : Fin 99, s u = u := by
  let P : Fin 99 → Bool := fun _ => true
  have hP : ∀ u, P (s u) = P u := by intro u; rfl
  have hcount : countSet P = 99 := by
    rw [countSet_eq_length_filter]
    have hfilter : ∀ xs : List (Fin 99), xs.filter (fun _ => true) = xs := by
      intro xs
      induction xs <;> simp_all
    rw [hfilter, List.length_finRange]
  have hmod := countSet_mod_seven s h7 P hP
  have hpos : 0 < fixedIn s P := by
    cases hz : fixedIn s P with
    | zero =>
      have hzero : 99 % 7 = 0 := by
        rw [hcount, hz] at hmod
        exact hmod
      have : 99 % 7 ≠ 0 := by decide
      exact False.elim (this hzero)
    | succ k => omega
  have hlen : 0 < ((List.finRange 99).filter (fun u => P u && decide (s u = u))).length := by
    rw [← countSet_eq_length_filter]
    exact hpos
  obtain ⟨u, hu⟩ := List.exists_mem_of_length_pos hlen
  have hu' := List.mem_filter.mp hu
  have hdec : decide (s u = u) = true := by simpa [P] using hu'.2
  exact ⟨u, of_decide_eq_true hdec⟩

#print axioms list_nodup_length_le
#print axioms countSet_eq_length_filter
#print axioms countSet_mem_list
#print axioms countSet_cycle_lower_bound
#print axioms orbit7_fiber_size
#print axioms countSet_mod_seven
#print axioms period7_has_fixed_on_99
#print axioms cycle7
#print axioms countSet
#print axioms fixedIn
#print axioms cycle7_short_return
#print axioms cycle7_nodup
#print axioms mem_cycle7_iff

end ConwayOrbit
