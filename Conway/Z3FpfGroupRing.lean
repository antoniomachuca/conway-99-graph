import Conway.Z3FpfNonExistence
import Conway.Z3FpfCounting

namespace Matrix99
open ConwayOrbit

/-- Shift sets of a fixed-point-free order-3 automorphism: (i, c) ~ (j, c + s) iff S i j s. -/
structure Z3FpfGroupRing where
  S : Fin 33 → Fin 33 → Fin 3 → Bool
  sym : ∀ i j s, S j i s = S i j (-s)
  loopless : ∀ i, S i i 0 = false
  diag : ∀ i, S i i 1 = S i i 2
  deg : ∀ i, sumFin (fun j => sumFin (fun s : Fin 3 => if S i j s = true then 1 else 0)) = 14
  eq : ∀ i j s,
    sumFin (fun k => sumFin (fun u : Fin 3 => if S i k u = true ∧ S k j (s - u) = true then 1 else 0))
      + (if S i j s = true then 1 else 0)
      = 2 + 12 * (if i = j ∧ s = 0 then 1 else 0)

namespace Z3FpfGroupRing

open Z3FpfOrbitMatrix

/-- Fin-3 subtraction on values, reduced mod 3. -/
theorem fin3_sub_val : ∀ a b : Fin 3, (a - b).val = (a.val + (3 - b.val)) % 3 := by
  decide

theorem fin3_neg_val : ∀ a : Fin 3, (-a).val = (3 - a.val) % 3 := by
  decide

theorem fin3_neg_neg : ∀ a : Fin 3, - -a = a := by
  decide

theorem fin3_sub_add : ∀ a b : Fin 3, (a - b) + b = a := by
  decide

theorem fin3_add_sub : ∀ a b : Fin 3, (a + b) - b = a := by
  decide

theorem fin3_eq_zero_val (a : Fin 3) : a = 0 ↔ a.val = 0 :=
  ⟨fun h => by rw [h]; rfl, fun h => Fin.ext h⟩

/-- `finRange 3` computes to the literal list. -/
theorem finRange3 : (List.finRange 3 : List (Fin 3)) = [0, 1, 2] := by
  decide

/-- Three-term evaluation of a `Fin 3` finite sum. -/
theorem sumFin_fin3 (f : Fin 3 → Nat) : sumFin f = f 0 + f 1 + f 2 := by
  unfold sumFin
  rw [finRange3]
  simp only [List.map_cons, List.map_nil, List.sum_cons, List.sum_nil]
  omega

/-- `if` congruence for propositions. -/
theorem if_congr_prop {P Q : Prop} [Decidable P] [Decidable Q] (h : P ↔ Q)
    (a b : Nat) : (if P then a else b) = if Q then a else b := by
  by_cases hp : P
  · rw [if_pos hp, if_pos (h.mp hp)]
  · rw [if_neg hp, if_neg (fun hq => hp (h.mpr hq))]

/-- Indicator-of-product equals product of indicators. -/
theorem if_and_mul {P Q : Prop} [Decidable P] [Decidable Q] :
    (if P ∧ Q then (1 : Nat) else 0) = (if P then 1 else 0) * (if Q then 1 else 0) := by
  by_cases hp : P <;> by_cases hq : Q <;> simp [hp, hq]

/-- `(b - u) ↦ ...` is a bijection of `Fin 3` for fixed `u`. -/
theorem sumFin_sub3 (u : Fin 3) (f : Fin 3 → Nat) :
    sumFin (fun s : Fin 3 => f (s - u)) = sumFin f := by
  apply sumFin_comp_eq (fun s : Fin 3 => s - u)
  · intro a b h
    have h2 := congrArg (fun x : Fin 3 => x + u) h
    rw [fin3_sub_add, fin3_sub_add] at h2
    exact h2
  · intro y
    exact ⟨y + u, fin3_add_sub y u⟩

/-- Negation is a bijection of `Fin 3`. -/
theorem sumFin_neg3 (f : Fin 3 → Nat) :
    sumFin (fun s : Fin 3 => f (-s)) = sumFin f := by
  apply sumFin_comp_eq (fun s : Fin 3 => -s)
  · intro a b h
    have h2 := congrArg (fun x : Fin 3 => -x) h
    rw [fin3_neg_neg, fin3_neg_neg] at h2
    exact h2
  · intro y
    exact ⟨-y, fin3_neg_neg y⟩

/-- Orbit matrix of the group-ring data: `b_ij = |S_ij|`. -/
def toOrbitMatrix (G : Z3FpfGroupRing) : Z3FpfOrbitMatrix where
  B := fun i j => sumFin (fun s : Fin 3 => if G.S i j s = true then 1 else 0)
  row_sum := by
    intro i
    unfold rowSum33
    rw [← sumFin_eq_foldl]
    exact G.deg i
  degree_symmetry := by
    intro i j
    have hpt : ∀ s : Fin 3, (if G.S i j s = true then (1 : Nat) else 0) =
        (if G.S j i (-s) = true then 1 else 0) := by
      intro s
      rw [G.sym j i s]
    rw [sumFin_congr hpt]
    exact sumFin_neg3 (fun s => if G.S j i s = true then (1 : Nat) else 0)
  srg_equation := by
    intro i j
    -- b_ik * b_kj = Σ_u Σ_s [Sik u][Skj (s-u)]
    have hfact : ∀ (k : Fin 33) (u : Fin 3),
        sumFin (fun s : Fin 3 =>
          if G.S i k u = true ∧ G.S k j (s - u) = true then (1 : Nat) else 0) =
        (if G.S i k u = true then 1 else 0) *
          sumFin (fun s : Fin 3 => if G.S k j s = true then 1 else 0) := by
      intro k u
      have hpt : ∀ s, (if G.S i k u = true ∧ G.S k j (s - u) = true then (1 : Nat) else 0) =
          (if G.S i k u = true then 1 else 0) *
            (if G.S k j (s - u) = true then 1 else 0) :=
        fun s => if_and_mul
      rw [sumFin_congr hpt, sumFin_mul_left]
      have hsh : sumFin (fun s : Fin 3 => if G.S k j (s - u) = true then (1 : Nat) else 0) =
          sumFin (fun s : Fin 3 => if G.S k j s = true then 1 else 0) :=
        sumFin_sub3 u (fun s => if G.S k j s = true then (1 : Nat) else 0)
      rw [hsh]
    have hprod : ∀ k : Fin 33,
        (sumFin (fun u : Fin 3 => if G.S i k u = true then 1 else 0)) *
        (sumFin (fun s : Fin 3 => if G.S k j s = true then 1 else 0)) =
        sumFin (fun u : Fin 3 => sumFin (fun s : Fin 3 =>
          if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0)) := by
      intro k
      rw [sumFin_congr (hfact k), sumFin_mul_right]
    -- reorder Σ_s Σ_k Σ_u to Σ_k Σ_u Σ_s
    have hswap : sumFin (fun s : Fin 3 => sumFin (fun k : Fin 33 =>
        sumFin (fun u : Fin 3 =>
          if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0))) =
        sumFin (fun k : Fin 33 => sumFin (fun u : Fin 3 => sumFin (fun s : Fin 3 =>
          if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0))) := by
      rw [sumFin_swap_rect]
      apply sumFin_congr
      intro k
      exact sumFin_swap_rect _
    -- sum `eq` over s
    have hsum : sumFin (fun s : Fin 3 =>
        (sumFin (fun k => sumFin (fun u : Fin 3 =>
          if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0)) +
          (if G.S i j s = true then 1 else 0))) =
        sumFin (fun s : Fin 3 => 2 + 12 * (if i = j ∧ s = 0 then (1 : Nat) else 0)) :=
      sumFin_congr (fun s => G.eq i j s)
    rw [sumFin_add] at hsum
    rw [hswap] at hsum
    rw [← sumFin_congr (fun k => hprod k)] at hsum
    -- RHS: Σ_s (2 + 12 * δ_s) = 6 + 12 * (if i = j then 1 else 0)
    have hconst : sumFin (fun _ : Fin 3 => (2 : Nat)) = 6 := by decide
    have hδ : sumFin (fun s : Fin 3 => if i = j ∧ s = 0 then (1 : Nat) else 0) =
        if i = j then 1 else 0 := by
      by_cases hij : i = j
      · rw [if_pos hij]
        have hpt : ∀ s : Fin 3, (if i = j ∧ s = 0 then (1 : Nat) else 0) =
            if s = 0 then 1 else 0 := by
          intro s
          by_cases h : s = 0 <;> simp [hij, h]
        rw [sumFin_congr hpt]
        exact sumFin_eq_single 0 (fun _ => (1 : Nat))
      · rw [if_neg hij]
        apply zero_fun_sumFin
        intro s
        rw [if_neg (fun hc => hij hc.1)]
    have hRHS : sumFin (fun s : Fin 3 => 2 + 12 * (if i = j ∧ s = 0 then (1 : Nat) else 0)) =
        6 + 12 * (if i = j then 1 else 0) := by
      rw [sumFin_add, hconst, sumFin_mul_left 12 _, hδ]
    rw [hRHS] at hsum
    -- LHS: mul33 form
    unfold mul33
    rw [← sumFin_eq_foldl]
    unfold delta33
    change (sumFin fun k => (sumFin fun u : Fin 3 => if G.S i k u = true then (1 : Nat) else 0) *
          sumFin fun s : Fin 3 => if G.S k j s = true then 1 else 0) +
        (sumFin fun s : Fin 3 => if G.S i j s = true then 1 else 0) =
        12 * (if i = j then 1 else 0) + 6
    omega
  diag_parity := by
    intro i
    have hs3 : sumFin (fun s : Fin 3 => if G.S i i s = true then (1 : Nat) else 0) =
        (if G.S i i 0 = true then 1 else 0) + (if G.S i i 1 = true then 1 else 0) +
          (if G.S i i 2 = true then 1 else 0) := sumFin_fin3 _
    rw [hs3]
    have h0 : (if G.S i i 0 = true then (1 : Nat) else 0) = 0 := by
      rw [G.loopless i]
      rfl
    have h12 : (if G.S i i 2 = true then (1 : Nat) else 0) =
        (if G.S i i 1 = true then 1 else 0) := by
      rw [← G.diag i]
    rw [h0, h12]
    by_cases h : G.S i i 1 = true
    · rw [if_pos h]
      exact Or.inr rfl
    · rw [if_neg h]
      exact Or.inl rfl
  entry_bound := by
    intro i j
    rw [sumFin_fin3]
    have h1 : ∀ s : Fin 3, (if G.S i j s = true then (1 : Nat) else 0) ≤ 1 := by
      intro s
      by_cases h : G.S i j s = true <;> simp [h]
    have h0' := h1 0
    have h1' := h1 1
    have h2' := h1 2
    omega

theorem toOrbitMatrix_B (G : Z3FpfGroupRing) (i j : Fin 33) :
    G.toOrbitMatrix.B i j = sumFin (fun s : Fin 3 => if G.S i j s = true then 1 else 0) := rfl

/-- The label of an orbit representative shifted inside its own orbit is the
    representative itself. -/
theorem pairMap_label (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (e : Z3FpfOrbitEnumeration s) (k : Fin 33) (u : Fin 3) :
    orbitLabel 3 s (s^[u.val] (e.rep k)) = e.rep k := by
  calc orbitLabel 3 s (s^[u.val] (e.rep k))
      = orbitLabel 3 s (e.rep k) :=
        (orbitLabel_eq_iff (by decide) s h3 _ _).mpr
          (sameOrbit_symm (by decide) h3 ⟨u, rfl⟩)
    _ = e.rep k := e.active k

/-- The pair map `(k, u) ↦ s^[u] (rep k)` is injective for a fixed-point-free
    order-3 permutation. -/
theorem pairMap_injective (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (hfpf : ∀ v, s v ≠ v) (e : Z3FpfOrbitEnumeration s) :
    ∀ (k l : Fin 33) (u v : Fin 3),
      s^[u.val] (e.rep k) = s^[v.val] (e.rep l) → k = l ∧ u = v := by
  intro k l u v h
  have hkl : k = l := by
    have h1 := congrArg (orbitLabel 3 s) h
    rw [pairMap_label s h3 e k u, pairMap_label s h3 e l v] at h1
    exact e.injective k l h1
  obtain rfl := hkl
  refine ⟨rfl, ?_⟩
  -- cancel the common iterate
  by_cases huv : u.val ≤ v.val
  · have h2 : s^[u.val] (s^[v.val - u.val] (e.rep k)) = s^[u.val] (e.rep k) := by
      rw [← iterate_add_apply]
      rw [show u.val + (v.val - u.val) = v.val by omega]
      exact h.symm
    have hinj : Function.Injective (s^[u.val]) :=
      iterate_injective s (iterate_bijective (by decide) s h3).1 u.val
    have hret : s^[v.val - u.val] (e.rep k) = e.rep k := hinj h2
    by_cases hd : v.val - u.val = 0
    · have : u.val = v.val := by omega
      exact Fin.ext this
    · exfalso
      have h1 := cycle3_short_return s h3 (e.rep k) (v.val - u.val) (by omega) (by omega) hret
      exact hfpf _ h1
  · have h2 : s^[v.val] (s^[u.val - v.val] (e.rep k)) = s^[v.val] (e.rep k) := by
      rw [← iterate_add_apply]
      rw [show v.val + (u.val - v.val) = u.val by omega]
      exact h
    have hinj : Function.Injective (s^[v.val]) :=
      iterate_injective s (iterate_bijective (by decide) s h3).1 v.val
    have hret : s^[u.val - v.val] (e.rep k) = e.rep k := hinj h2
    by_cases hd : u.val - v.val = 0
    · have : u.val = v.val := by omega
      exact Fin.ext this
    · exfalso
      have h1 := cycle3_short_return s h3 (e.rep k) (u.val - v.val) (by omega) (by omega) hret
      exact hfpf _ h1

/-- The pair map is surjective: every vertex is `s^[u]` of a representative. -/
theorem pairMap_surjective (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (e : Z3FpfOrbitEnumeration s) :
    ∀ w : Fin 99, ∃ (k : Fin 33) (u : Fin 3), s^[u.val] (e.rep k) = w := by
  intro w
  obtain ⟨k, hk⟩ := e.complete _ (orbitLabel_idempotent (by decide) s h3 w)
  obtain ⟨t, ht⟩ := orbitLabel_mem (by decide) s h3 w
  refine ⟨k, ⟨(3 - t.val) % 3, by omega⟩, ?_⟩
  show s^[(3 - t.val) % 3] (e.rep k) = w
  rw [← iterate_mod_period 3 (by decide) s h3 (3 - t.val) (e.rep k)]
  rw [hk, ← ht]
  rw [← iterate_add_apply]
  rw [show 3 - t.val + t.val = 3 by omega]
  have h3' : s^[3] w = w := congrFun h3 w
  exact h3'

/-- Splitting a sum over `Fin 99` along the orbit-representative bijection. -/
theorem sumFin_pair (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (hfpf : ∀ v, s v ≠ v) (e : Z3FpfOrbitEnumeration s) (f : Fin 99 → Nat) :
    sumFin (fun k : Fin 33 => sumFin (fun u : Fin 3 => f (s^[u.val] (e.rep k)))) =
      sumFin f := by
  have hinj := pairMap_injective s h3 hfpf e
  have hsurj := pairMap_surjective s h3 e
  have hcount : ∀ w : Fin 99, sumFin (fun k : Fin 33 => sumFin (fun u : Fin 3 =>
      if s^[u.val] (e.rep k) = w then (1 : Nat) else 0)) = 1 := by
    intro w
    obtain ⟨k0, u0, h0⟩ := hsurj w
    have hinner : ∀ k : Fin 33, sumFin (fun u : Fin 3 =>
        if s^[u.val] (e.rep k) = w then (1 : Nat) else 0) =
        if k = k0 then 1 else 0 := by
      intro k
      by_cases hk : k = k0
      · rw [if_pos hk]
        cases hk
        have hpt : ∀ u : Fin 3, (if s^[u.val] (e.rep k0) = w then (1 : Nat) else 0) =
            if u = u0 then 1 else 0 := by
          intro u
          by_cases hu : u = u0
          · cases hu
            rw [h0, if_pos rfl, if_pos rfl]
          · rw [if_neg hu]
            by_cases he : s^[u.val] (e.rep k0) = w
            · rw [if_pos he]
              exact absurd (hinj k0 k0 u u0 (he.trans h0.symm)).2 hu
            · rw [if_neg he]
        rw [sumFin_congr hpt]
        exact sumFin_eq_single u0 (fun _ => (1 : Nat))
      · rw [if_neg hk]
        apply zero_fun_sumFin
        intro u
        by_cases he : s^[u.val] (e.rep k) = w
        · rw [if_pos he]
          exact absurd (hinj k k0 u u0 (he.trans h0.symm)).1 hk
        · rw [if_neg he]
    rw [sumFin_congr hinner]
    exact sumFin_eq_single k0 (fun _ => (1 : Nat))
  have hpt : ∀ (k : Fin 33) (u : Fin 3), f (s^[u.val] (e.rep k)) =
      sumFin (fun w : Fin 99 => if s^[u.val] (e.rep k) = w then f w else 0) := by
    intro k u
    exact (sumFin_indicator_value _ f).symm
  rw [sumFin_congr (fun k => sumFin_congr (hpt k))]
  -- Σ_k Σ_u Σ_w → Σ_w Σ_k Σ_u
  have hswap : sumFin (fun k : Fin 33 => sumFin (fun u : Fin 3 => sumFin (fun w : Fin 99 =>
      if s^[u.val] (e.rep k) = w then f w else 0))) =
      sumFin (fun w : Fin 99 => sumFin (fun k : Fin 33 => sumFin (fun u : Fin 3 =>
        if s^[u.val] (e.rep k) = w then f w else 0))) := by
    calc sumFin (fun k : Fin 33 => sumFin (fun u : Fin 3 => sumFin (fun w : Fin 99 =>
            if s^[u.val] (e.rep k) = w then f w else 0)))
        = sumFin (fun k : Fin 33 => sumFin (fun w : Fin 99 => sumFin (fun u : Fin 3 =>
            if s^[u.val] (e.rep k) = w then f w else 0))) :=
          sumFin_congr (fun k => sumFin_swap_rect _)
      _ = sumFin (fun w : Fin 99 => sumFin (fun k : Fin 33 => sumFin (fun u : Fin 3 =>
            if s^[u.val] (e.rep k) = w then f w else 0))) :=
          sumFin_swap_rect _
  rw [hswap]
  apply sumFin_congr
  intro w
  have hfin : ∀ (k : Fin 33) (u : Fin 3),
      (if s^[u.val] (e.rep k) = w then f w else (0 : Nat)) =
      f w * (if s^[u.val] (e.rep k) = w then 1 else 0) := by
    intro k u
    by_cases h : s^[u.val] (e.rep k) = w <;> simp [h]
  rw [sumFin_congr (fun k => sumFin_congr (hfin k))]
  rw [sumFin_congr (fun k => sumFin_mul_left (f w) _), sumFin_mul_left, hcount w]
  exact Nat.mul_one _

/-- Invariance of the adjacency under simultaneous shift, in group-ring form. -/
theorem adj_shift (A : Matrix99 Nat) (g : Fin 99 → Fin 99) (h3 : g^[3] = id)
    (hpres : ∀ u v, A (g u) (g v) = A u v) (a b : Fin 3) (x y : Fin 99) :
    A (g^[a.val] x) (g^[b.val] y) = A x (g^[(b - a).val] y) := by
  have ht : 3 - a.val + a.val = 3 := by have := a.isLt; omega
  have hbv := fin3_sub_val b a
  have ha := a.isLt
  have hb := b.isLt
  calc A (g^[a.val] x) (g^[b.val] y)
      = A (g^[3 - a.val] (g^[a.val] x)) (g^[3 - a.val] (g^[b.val] y)) :=
        (iterate_preserves A g hpres (3 - a.val) _ _).symm
    _ = A (g^[3 - a.val + a.val] x) (g^[3 - a.val + b.val] y) := by
        rw [← iterate_add_apply, ← iterate_add_apply]
    _ = A x (g^[(b - a).val] y) := by
        rw [ht]
        have hx : g^[3] x = x := congrFun h3 x
        rw [hx]
        have hy : g^[3 - a.val + b.val] y = g^[(b - a).val] y := by
          rw [iterate_mod_period 3 (by decide) g h3 (3 - a.val + b.val) y]
          have hm : (3 - a.val + b.val) % 3 = (b - a).val := by
            rw [hbv]; omega
          rw [hm]
        rw [hy]

end Z3FpfGroupRing

open Z3FpfOrbitMatrix

/-- The group-ring frame induced by a fixed-point-free order-3 automorphism. -/
theorem conway_z3_fpf_induces_group_ring :
    HasZ3FpfSymmetry → Nonempty Z3FpfGroupRing := by
  rintro ⟨A, hA, g, hg⟩
  have h3 : g^[3] = id := hg.2.1
  have hfpf : ∀ v, g v ≠ v := hg.2.2.1
  have hpres : ∀ u v, A (g u) (g v) = A u v := hg.2.2.2
  have hbin : ∀ u v, A u v = 0 ∨ A u v = 1 := hA.2.2.1
  let e := enumerateZ3FpfOrbits g h3 hfpf
  have hinj := Z3FpfGroupRing.pairMap_injective g h3 hfpf e
  have hsum := Z3FpfGroupRing.sumFin_pair g h3 hfpf e
  refine ⟨⟨fun i j t => decide (A (e.rep i) (g^[t.val] (e.rep j)) = 1),
    ?_, ?_, ?_, ?_, ?_⟩⟩
  · -- sym
    intro i j s
    show decide (A (e.rep j) (g^[s.val] (e.rep i)) = 1) =
      decide (A (e.rep i) (g^[(-s).val] (e.rep j)) = 1)
    have hsum3 : s.val + (-s).val = 0 ∨ s.val + (-s).val = 3 := by
      have h := Z3FpfGroupRing.fin3_neg_val s
      have hs := s.isLt
      omega
    have key : A (e.rep i) (g^[(-s).val] (e.rep j)) =
        A (e.rep j) (g^[s.val] (e.rep i)) := by
      have step1 := (iterate_preserves A g hpres s.val (e.rep i)
        (g^[(-s).val] (e.rep j))).symm
      calc A (e.rep i) (g^[(-s).val] (e.rep j))
          = A (g^[s.val] (e.rep i)) (g^[s.val] (g^[(-s).val] (e.rep j))) := step1
        _ = A (g^[s.val] (e.rep i)) (g^[s.val + (-s).val] (e.rep j)) := by
            rw [← iterate_add_apply]
        _ = A (g^[s.val] (e.rep i)) (e.rep j) := by
            rcases hsum3 with h | h
            · rw [h]
              rfl
            · rw [h]
              have h3' : g^[3] (e.rep j) = e.rep j := congrFun h3 _
              rw [h3']
        _ = A (e.rep j) (g^[s.val] (e.rep i)) := hA.2.1 _ _
    rw [key]
  · -- loopless
    intro i
    show decide (A (e.rep i) (g^[(0 : Fin 3).val] (e.rep i)) = 1) = false
    have h0 : A (e.rep i) (e.rep i) = 0 := hA.1 _
    have hnot : ¬ (A (e.rep i) (e.rep i) = 1) := by omega
    exact decide_eq_false hnot
  · -- diag
    intro i
    show decide (A (e.rep i) (g^[(1 : Fin 3).val] (e.rep i)) = 1) =
      decide (A (e.rep i) (g^[(2 : Fin 3).val] (e.rep i)) = 1)
    have hstep : g (g^[2] (e.rep i)) = e.rep i := by
      have h32 : g^[1 + 2] (e.rep i) = g^[1] (g^[2] (e.rep i)) :=
        iterate_add_apply g 1 2 (e.rep i)
      have h3' : g^[3] (e.rep i) = e.rep i := congrFun h3 _
      have : g^[3] (e.rep i) = g (g^[2] (e.rep i)) := h32
      rw [h3'] at this
      exact this.symm
    have key : A (e.rep i) (g^[2] (e.rep i)) = A (e.rep i) (g (e.rep i)) := by
      calc A (e.rep i) (g^[2] (e.rep i))
          = A (g^[2] (e.rep i)) (e.rep i) := hA.2.1 _ _
        _ = A (g (g^[2] (e.rep i))) (g (e.rep i)) :=
            (iterate_preserves A g hpres 1 (g^[2] (e.rep i)) (e.rep i)).symm
        _ = A (e.rep i) (g (e.rep i)) := by rw [hstep]
    -- both sides: (1 : Fin 3).val reduces to 1, (2 : Fin 3).val to 2
    show decide (A (e.rep i) (g (e.rep i)) = 1) = decide (A (e.rep i) (g^[2] (e.rep i)) = 1)
    rw [key]
  · -- deg
    intro i
    show sumFin (fun j => sumFin (fun t : Fin 3 =>
      if decide (A (e.rep i) (g^[t.val] (e.rep j)) = 1) = true then 1 else 0)) = 14
    have hpt : ∀ j (t : Fin 3), (if decide (A (e.rep i) (g^[t.val] (e.rep j)) = 1) = true
        then (1 : Nat) else 0) = A (e.rep i) (g^[t.val] (e.rep j)) := by
      intro j t
      rcases hbin _ _ with h | h
      · rw [h]
        rw [if_neg (by decide : ¬ (decide ((0 : Nat) = 1) = true))]
      · rw [h]
        rw [if_pos (decide_eq_true rfl : decide ((1 : Nat) = 1) = true)]
    rw [sumFin_congr (fun j => sumFin_congr (hpt j))]
    rw [hsum]
    exact conway_row_sum A hA _
  · -- eq
    intro i j s
    show (sumFin (fun k => sumFin (fun u : Fin 3 =>
        if decide (A (e.rep i) (g^[u.val] (e.rep k)) = 1) = true ∧
           decide (A (e.rep k) (g^[(s - u).val] (e.rep j)) = 1) = true then 1 else 0))) +
        (if decide (A (e.rep i) (g^[s.val] (e.rep j)) = 1) = true then 1 else 0) =
        2 + 12 * (if i = j ∧ s = 0 then 1 else 0)
    have hpoly : sumFin (fun w => A (e.rep i) w * A w (g^[s.val] (e.rep j))) +
        A (e.rep i) (g^[s.val] (e.rep j)) =
        12 * (if e.rep i = g^[s.val] (e.rep j) then 1 else 0) + 2 := by
      rw [sumFin_eq_foldl]
      exact (hA.2.2.2 _ _).trans (conway_target_formula _ _)
    have hterm : ∀ (k : Fin 33) (u : Fin 3),
        (if decide (A (e.rep i) (g^[u.val] (e.rep k)) = 1) = true ∧
           decide (A (e.rep k) (g^[(s - u).val] (e.rep j)) = 1) = true
          then (1 : Nat) else 0) =
        A (e.rep i) (g^[u.val] (e.rep k)) * A (g^[u.val] (e.rep k)) (g^[s.val] (e.rep j)) := by
      intro k u
      have hshift : A (g^[u.val] (e.rep k)) (g^[s.val] (e.rep j)) =
          A (e.rep k) (g^[(s - u).val] (e.rep j)) :=
        Z3FpfGroupRing.adj_shift A g h3 hpres u s (e.rep k) (e.rep j)
      have hiff : (decide (A (e.rep i) (g^[u.val] (e.rep k)) = 1) = true ∧
          decide (A (e.rep k) (g^[(s - u).val] (e.rep j)) = 1) = true) ↔
          (A (e.rep i) (g^[u.val] (e.rep k)) = 1 ∧
            A (g^[u.val] (e.rep k)) (g^[s.val] (e.rep j)) = 1) :=
        ⟨fun ⟨h1, h2⟩ => ⟨of_decide_eq_true h1, hshift.symm ▸ of_decide_eq_true h2⟩,
         fun ⟨h1, h2⟩ => ⟨decide_eq_true h1, decide_eq_true (hshift ▸ h2)⟩⟩
      rw [Z3FpfGroupRing.if_congr_prop hiff]
      rcases hbin (e.rep i) (g^[u.val] (e.rep k)) with hA1 | hA1 <;>
        rcases hbin (g^[u.val] (e.rep k)) (g^[s.val] (e.rep j)) with hA2 | hA2 <;>
        rw [hA1, hA2] <;> decide
    have hL : sumFin (fun k => sumFin (fun u : Fin 3 =>
        if decide (A (e.rep i) (g^[u.val] (e.rep k)) = 1) = true ∧
           decide (A (e.rep k) (g^[(s - u).val] (e.rep j)) = 1) = true then 1 else 0)) =
        sumFin (fun w => A (e.rep i) w * A w (g^[s.val] (e.rep j))) := by
      rw [sumFin_congr (fun k => sumFin_congr (hterm k))]
      exact hsum (fun w => A (e.rep i) w * A w (g^[s.val] (e.rep j)))
    have hS : (if decide (A (e.rep i) (g^[s.val] (e.rep j)) = 1) = true then (1 : Nat) else 0) =
        A (e.rep i) (g^[s.val] (e.rep j)) := by
      rcases hbin (e.rep i) (g^[s.val] (e.rep j)) with h | h
      · rw [h]
        rw [if_neg (by decide : ¬ (decide ((0 : Nat) = 1) = true))]
      · rw [h]
        rw [if_pos (decide_eq_true rfl : decide ((1 : Nat) = 1) = true)]
    have hdelta : (e.rep i = g^[s.val] (e.rep j)) ↔ (i = j ∧ s = 0) := by
      constructor
      · intro h
        have h' := hinj i j ⟨0, by decide⟩ s h
        exact ⟨h'.1, (Z3FpfGroupRing.fin3_eq_zero_val s).mpr (congrArg Fin.val h'.2).symm⟩
      · rintro ⟨rfl, hs⟩
        rw [(Z3FpfGroupRing.fin3_eq_zero_val s).mp hs]
        rfl
    rw [hL, hS, hpoly, Z3FpfGroupRing.if_congr_prop hdelta]
    omega

#print axioms conway_z3_fpf_induces_group_ring
#print axioms Z3FpfGroupRing.toOrbitMatrix
#print axioms Z3FpfGroupRing.toOrbitMatrix_B
#print axioms Z3FpfGroupRing.pairMap_injective
#print axioms Z3FpfGroupRing.pairMap_surjective
#print axioms Z3FpfGroupRing.sumFin_pair

end Matrix99
