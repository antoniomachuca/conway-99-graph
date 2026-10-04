import Conway.OrbitQuotient
import Conway.OrbitReindex
import Conway.Z7Cycles

namespace ConwayOrbit

def cycle3 {n : Nat} (s : Fin n → Fin n) (u : Fin n) : List (Fin n) :=
  (List.finRange 3).map (fun k => s^[k.val] u)

theorem cycle3_short_return {n} (s : Fin n → Fin n) (h3 : s^[3] = id)
    (u : Fin n) (k : Nat) (hk0 : 0 < k) (hk3 : k < 3) (hret : s^[k] u = u) : s u = u := by
  have hcase : k = 1 ∨ k = 2 := by omega
  rcases hcase with rfl | rfl
  · exact hret
  · have hm := iterate_mod_period 3 (by decide) s h3 (2 * 2) u
    have hpow : s^[2 * 2] u = u := by
      rw [show 2 * 2 = 2 + 2 by rfl, iterate_add_apply, hret, hret]
    simpa [Function.iterate] using hm.symm.trans hpow

theorem cycle3_nodup {n} (s : Fin n → Fin n) (h3 : s^[3] = id)
    (u : Fin n) (hmove : s u ≠ u) : (cycle3 s u).Nodup := by
  unfold cycle3
  apply nodup_map_injective (fun k : Fin 3 => s^[k.val] u) (List.nodup_finRange 3)
  intro a b hab
  by_cases hab_eq : a = b
  · exact hab_eq
  · by_cases hlt : a.val < b.val
    · have hcancel : s^[a.val] (s^[(b.val - a.val)] u) = s^[a.val] u := by
        rw [← iterate_add_apply s a.val (b.val - a.val) u]
        rw [show a.val + (b.val - a.val) = b.val by omega, ← hab]
      have hret : s^[(b.val - a.val)] u = u :=
        iterate_injective s (iterate_bijective (by decide) s h3).1 a.val hcancel
      exact False.elim (hmove (cycle3_short_return s h3 u (b.val - a.val)
        (by omega) (by omega) hret))
    · have hlt' : b.val < a.val := by omega
      have hcancel : s^[b.val] (s^[(a.val - b.val)] u) = s^[b.val] u := by
        rw [← iterate_add_apply s b.val (a.val - b.val) u]
        rw [show b.val + (a.val - b.val) = a.val by omega, hab]
      have hret : s^[(a.val - b.val)] u = u :=
        iterate_injective s (iterate_bijective (by decide) s h3).1 b.val hcancel
      exact False.elim (hmove (cycle3_short_return s h3 u (a.val - b.val)
        (by omega) (by omega) hret))

theorem mem_cycle3_iff_pre {n} (s : Fin n → Fin n) (u v : Fin n) :
    v ∈ cycle3 s u ↔ SameOrbit 3 s u v := by
  unfold cycle3 SameOrbit
  constructor
  · intro h
    have ⟨k, hk, hkv⟩ := List.mem_map.mp h
    exact ⟨⟨k.val, by omega⟩, hkv⟩
  · intro h
    obtain ⟨k, hk⟩ := h
    apply List.mem_map.mpr
    exact ⟨k, List.mem_finRange k, hk⟩

theorem orbit3_fiber_size {n} (s : Fin n → Fin n) (h3 : s^[3] = id) (u : Fin n) :
    fiberSize (orbitLabel 3 s) (orbitLabel 3 s u) = if s u = u then 1 else 3 := by
  by_cases hfixed : s u = u
  · have hiter : ∀ k : Nat, s^[k] u = u := by
      intro k
      induction k with
      | zero => rfl
      | succ k ih =>
        change s (s^[k] u) = u
        rw [ih, hfixed]
    have hsame : ∀ v : Fin n, SameOrbit 3 s u v ↔ u = v := by
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
        decide (orbitLabel 3 s v = orbitLabel 3 s u) = decide (v = u) := by
      intro v
      have heq := orbitLabel_eq_iff (n := n) (p := 3) (by decide) s h3 v u
      have hvu : SameOrbit 3 s v u ↔ v = u := by
        constructor
        · intro h
          exact ((hsame v).mp (sameOrbit_symm (by decide) h3 h)).symm
        · intro h
          subst v
          exact sameOrbit_refl (by decide) u
      simp [heq, hvu]
    rw [if_pos hfixed]
    unfold fiberSize fiberSum
    calc
      sumFin (fun v => if orbitLabel 3 s v = orbitLabel 3 s u then 1 else 0) =
          sumFin (fun v => if v = u then 1 else 0) := by
            apply congrArg sumFin
            funext v
            have hv := hlabel v
            by_cases h1 : orbitLabel 3 s v = orbitLabel 3 s u <;>
              by_cases h2 : v = u <;>
              simp [h1, h2] at hv ⊢
      _ = 1 := by simpa [eq_comm] using sumFin_indicator_value u (fun _ => 1)
  · have hmove : s u ≠ u := hfixed
    have hpred : ∀ v : Fin n,
        decide (orbitLabel 3 s v = orbitLabel 3 s u) = decide (v ∈ cycle3 s u) := by
      intro v
      have heq := orbitLabel_eq_iff (n := n) (p := 3) (by decide) s h3 v u
      have hmem := mem_cycle3_iff_pre s u v
      have hiff : SameOrbit 3 s v u ↔ v ∈ cycle3 s u := by
        constructor
        · intro h
          exact hmem.mpr (sameOrbit_symm (by decide) h3 h)
        · intro h
          exact sameOrbit_symm (by decide) h3 (hmem.mp h)
      by_cases h1 : orbitLabel 3 s v = orbitLabel 3 s u
      · have hso := heq.mp h1
        have hm := hiff.mp hso
        simp [h1, hm]
      · by_cases h2 : v ∈ cycle3 s u
        · have hso := hiff.mpr h2
          have hl := heq.mpr hso
          exact False.elim (h1 hl)
        · simp [h1, h2]
    rw [if_neg hfixed]
    unfold fiberSize fiberSum
    calc
      sumFin (fun v => if orbitLabel 3 s v = orbitLabel 3 s u then 1 else 0) =
          sumFin (fun v => if v ∈ cycle3 s u then 1 else 0) := by
            apply congrArg sumFin
            funext v
            have hv := hpred v
            by_cases h1 : orbitLabel 3 s v = orbitLabel 3 s u
            · have hv' := hpred v
              have hb : decide (v ∈ cycle3 s u) = true := by simpa [h1] using hv'
              have h2 := of_decide_eq_true hb
              simp [h1, h2]
            · by_cases h2 : v ∈ cycle3 s u
              · have hv' := hpred v
                have hb : decide (orbitLabel 3 s v = orbitLabel 3 s u) = true := by
                  simpa [h2] using hv'
                exact False.elim (h1 (of_decide_eq_true hb))
              · simp [h1, h2]
      _ = 3 := by
        have hc := countSet_mem_list (cycle3 s u) (cycle3_nodup s h3 u hmove)
        have hlen : (cycle3 s u).length = 3 := by
          unfold cycle3
          simp [List.length_finRange]
        rw [hlen] at hc
        simpa [countSet, cycle3] using hc

theorem orbit3_fiber_size_inactive (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (j : Fin 99) (hj : orbitLabel 3 s j ≠ j) :
    fiberSize (orbitLabel 3 s) j = 0 := by
  have hnone : ∀ v, orbitLabel 3 s v ≠ j := by
    intro v hv
    apply hj
    rw [← hv]
    exact orbitLabel_idempotent (by decide) s h3 v
  unfold fiberSize fiberSum sumFin
  simp only [hnone]
  exact sum_map_zero (List.finRange 99)

def active3Labels (s : Fin 99 → Fin 99) : List (Fin 99) :=
  (List.finRange 99).filter (fun v => decide (orbitLabel 3 s v = v))

theorem active3Labels_member_iff (s : Fin 99 → Fin 99) (v : Fin 99) :
    v ∈ active3Labels s ↔ orbitLabel 3 s v = v := by
  simp [active3Labels]

theorem active3Labels_nodup (s : Fin 99 → Fin 99) : (active3Labels s).Nodup := by
  exact List.Pairwise.filter _ (List.nodup_finRange 99)

theorem orbitLabel3_eq_self_of_fixed {n} (s : Fin n → Fin n)
    (h3 : s^[3] = id) (u : Fin n) (hfixed : s u = u) :
    orbitLabel 3 s u = u := by
  have hiter : ∀ k : Nat, s^[k] u = u := by
    intro k
    induction k with
    | zero => rfl
    | succ k ih =>
      change s (s^[k] u) = u
      rw [ih, hfixed]
  have hm := orbitLabel_mem (by decide) s h3 u
  obtain ⟨k, hk⟩ := hm
  rw [hiter k.val] at hk
  exact hk.symm

#print axioms cycle3_short_return
#print axioms cycle3_nodup
#print axioms mem_cycle3_iff_pre
#print axioms orbit3_fiber_size
#print axioms orbit3_fiber_size_inactive
#print axioms active3Labels_member_iff
#print axioms active3Labels_nodup
#print axioms orbitLabel3_eq_self_of_fixed

end ConwayOrbit
