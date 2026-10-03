import Conway.Z7Cycles
import Conway.GraphLocalCounts

namespace Matrix99

open ConwayOrbit

private theorem fixedGeometry_iterate_fixed (s : Fin 99 → Fin 99) (x : Fin 99)
    (hx : s x = x) (k : Nat) : s^[k] x = x := by
  induction k with
  | zero => rfl
  | succ k ih =>
    change s (s^[k] x) = x
    rw [ih, hx]

private theorem fixedGeometry_orbit_neighbor (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (hpres : ∀ u v, A (s u) (s v) = A u v) (x u v : Fin 99)
    (hx : s x = x) (hu : A x u = 1) (hv : SameOrbit 7 s u v) : A x v = 1 := by
  obtain ⟨k, hk⟩ := hv
  have hp := iterate_preserves A s hpres k.val x u
  rw [fixedGeometry_iterate_fixed s x hx k.val, hk] at hp
  exact hp.trans hu

private theorem fixedGeometry_orbit_moves (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (u : Fin 99) (hmove : s u ≠ u) (v : Fin 99) (hv : SameOrbit 7 s u v) :
    s v ≠ v := by
  intro hfix
  obtain ⟨k, hk⟩ := sameOrbit_symm (by decide) h7 hv
  have hvu : v = u := (fixedGeometry_iterate_fixed s v hfix k.val).symm.trans hk
  apply hmove
  rw [← hvu]
  exact hfix

theorem conway_period7_common_fixed (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (x y z : Fin 99) (hxy : x ≠ y) (hx : s x = x) (hy : s y = y)
    (hxz : A x z = 1) (hyz : A y z = 1) : s z = z := by
  cases (inferInstance : Decidable (s z = z)) with
  | isTrue h => exact h
  | isFalse hmove =>
    have hinj := (iterate_bijective (by decide) s h7).1
    have hz2 : z ≠ s (s z) := by
      intro heq
      exact hmove (cycle7_short_return s h7 z 2 (by decide) (by decide) heq.symm)
    have hz12 : s z ≠ s (s z) := by
      intro heq
      exact hmove (hinj heq).symm
    have hx1 : A x (s z) = 1 := by simpa only [hx] using (hpres x z).trans hxz
    have hy1 : A y (s z) = 1 := by simpa only [hy] using (hpres y z).trans hyz
    have hx2 : A x (s (s z)) = 1 := by simpa only [hx] using (hpres x (s z)).trans hx1
    have hy2 : A y (s (s z)) = 1 := by simpa only [hy] using (hpres y (s z)).trans hy1
    exact False.elim (conway_no_three_common A hA x y hxy z (s z) (s (s z))
      (Ne.symm hmove) hz2 hz12 ⟨hxz, hyz⟩ ⟨hx1, hy1⟩ ⟨hx2, hy2⟩)

theorem conway_period7_mate_moves (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (_h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (x u : Fin 99) (hx : s x = x) (hu : A x u = 1) (hmove : s u ≠ u) :
    s (localMate A x u) ≠ localMate A x u := by
  intro hfix
  have hm := localMate_spec A hA x u hu
  have hcomm := localMate_commutes A hA s hpres x (localMate A x u) hx hm.1
  rw [hfix, localMate_involution A hA x u hu] at hcomm
  exact hmove hcomm.symm

theorem conway_period7_mate_not_sameOrbit (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (x u : Fin 99) (hx : s x = x) (hu : A x u = 1) (hmove : s u ≠ u) :
    ¬ SameOrbit 7 s u (localMate A x u) := by
  intro horbit
  obtain ⟨k, hk⟩ := horbit
  have hkne : k.val ≠ 0 := by
    intro hk0
    have heq : u = localMate A x u := by
      simpa only [hk0, Function.iterate, id_eq] using hk
    exact localMate_ne A hA x u hu heq.symm
  have hkpos : 0 < k.val := by omega
  have hklt := k.isLt
  have hcomm := localMate_commutes A hA (s^[k.val])
    (iterate_preserves A s hpres k.val) x u (fixedGeometry_iterate_fixed s x hx k.val) hu
  rw [hk, localMate_involution A hA x u hu] at hcomm
  have hret : s^[k.val + k.val] u = u := by
    rw [iterate_add_apply, hk]
    exact hcomm.symm
  have hred : s^[(k.val + k.val) % 7] u = u :=
    (iterate_mod_period 7 (by decide) s h7 (k.val + k.val) u).symm.trans hret
  exact hmove (cycle7_short_return s h7 u ((k.val + k.val) % 7)
    (by omega) (Nat.mod_lt _ (by decide)) hred)

theorem conway_period7_pair_partition (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (x u : Fin 99) (hx : s x = x) (hu : A x u = 1) (hmove : s u ≠ u) :
    ∀ v, A x v = 1 ↔ SameOrbit 7 s u v ∨ SameOrbit 7 s (localMate A x u) v := by
  have hm := localMate_spec A hA x u hu
  have hrmove := conway_period7_mate_moves A hA s h7 hpres x u hx hu hmove
  have hsep := conway_period7_mate_not_sameOrbit A hA s h7 hpres x u hx hu hmove
  have hnd : (cycle7 s u ++ cycle7 s (localMate A x u)).Nodup := by
    apply List.nodup_append.mpr
    refine ⟨cycle7_nodup s h7 u hmove, cycle7_nodup s h7 _ hrmove, ?_⟩
    intro a ha b hb hab
    have hua := (mem_cycle7_iff s u a).mp ha
    have hra := (mem_cycle7_iff s (localMate A x u) a).mp (hab ▸ hb)
    exact hsep (sameOrbit_trans (by decide) h7 hua (sameOrbit_symm (by decide) h7 hra))
  have hsub : ∀ v, v ∈ cycle7 s u ++ cycle7 s (localMate A x u) →
      v ∈ localNeighbors A x := by
    intro v hv
    apply (mem_localNeighbors A x v).mpr
    rcases List.mem_append.mp hv with hv | hv
    · exact fixedGeometry_orbit_neighbor A s hpres x u v hx hu ((mem_cycle7_iff s u v).mp hv)
    · exact fixedGeometry_orbit_neighbor A s hpres x (localMate A x u) v hx hm.1
        ((mem_cycle7_iff s (localMate A x u) v).mp hv)
  have hlen : (cycle7 s u ++ cycle7 s (localMate A x u)).length =
      (localNeighbors A x).length := by
    rw [conway_neighbor_count A hA x]
    simp [cycle7]
  have hp := perm_of_nodup_same_members hnd hsub hlen
  intro v
  calc
    A x v = 1 ↔ v ∈ localNeighbors A x := (mem_localNeighbors A x v).symm
    _ ↔ v ∈ cycle7 s u ++ cycle7 s (localMate A x u) := hp.mem_iff.symm
    _ ↔ SameOrbit 7 s u v ∨ SameOrbit 7 s (localMate A x u) v := by
      rw [List.mem_append, mem_cycle7_iff, mem_cycle7_iff]

theorem conway_period7_rooted_pair (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (hnontriv : ∃ v, s v ≠ v) (x : Fin 99) (hx : s x = x) :
    ∃ l r : Fin 99, A x l = 1 ∧ A x r = 1 ∧ A l r = 1 ∧
      s l ≠ l ∧ s r ≠ r ∧ ¬ SameOrbit 7 s l r ∧
      (∀ v, A x v = 1 ↔ SameOrbit 7 s l v ∨ SameOrbit 7 s r v) := by
  have hmoving : ∃ u : Fin 99, A x u = 1 ∧ s u ≠ u := by
    cases (inferInstance : Decidable (∃ u : Fin 99, A x u = 1 ∧ s u ≠ u)) with
    | isTrue h => exact h
    | isFalse hnone =>
      have hN : ∀ u, A x u = 1 → s u = u := by
        intro u hu
        cases (inferInstance : Decidable (s u = u)) with
        | isTrue h => exact h
        | isFalse h => exact False.elim (hnone ⟨u, hu, h⟩)
      obtain ⟨v, hv⟩ := hnontriv
      exact False.elim (hv (conway_fix_neighborhood_faithful A hA s
        (iterate_bijective (by decide) s h7) hpres x hx hN v))
  obtain ⟨l, hl, hlmove⟩ := hmoving
  have hr := localMate_spec A hA x l hl
  exact ⟨l, localMate A x l, hl, hr.1, hr.2.1, hlmove,
    conway_period7_mate_moves A hA s h7 hpres x l hx hl hlmove,
    conway_period7_mate_not_sameOrbit A hA s h7 hpres x l hx hl hlmove,
    conway_period7_pair_partition A hA s h7 hpres x l hx hl hlmove⟩

theorem conway_period7_no_fixed_neighbor (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (hnontriv : ∃ v, s v ≠ v) (x u : Fin 99) (hx : s x = x) (hu : A x u = 1) :
    s u ≠ u := by
  obtain ⟨l, r, _, _, _, hl, hr, _, hp⟩ :=
    conway_period7_rooted_pair A hA s h7 hpres hnontriv x hx
  rcases (hp u).mp hu with hlu | hru
  · exact fixedGeometry_orbit_moves s h7 l hl u hlu
  · exact fixedGeometry_orbit_moves s h7 r hr u hru

theorem conway_period7_unique_fixed_at (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (hnontriv : ∃ v, s v ≠ v) (x : Fin 99) (hx : s x = x) :
    ∀ y, s y = y → y = x := by
  intro y hy
  cases (inferInstance : Decidable (y = x)) with
  | isTrue h => exact h
  | isFalse hne =>
    have hnon : A x y = 0 := by
      rcases hA.2.2.1 x y with h0 | h1
      · exact h0
      · exact False.elim (conway_period7_no_fixed_neighbor A hA s h7 hpres hnontriv x y hx h1 hy)
    obtain ⟨a, b, _, hxa, hya, _, _⟩ := conway_two_common A hA x y (Ne.symm hne) hnon
    have hfixa := conway_period7_common_fixed A hA s h7 hpres x y a (Ne.symm hne) hx hy hxa hya
    exact False.elim (conway_period7_no_fixed_neighbor A hA s h7 hpres hnontriv x a hx hxa hfixa)

theorem conway_period7_no_internal_neighbor_edge (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v)
    (x u v : Fin 99) (hx : s x = x) (hu : A x u = 1) (hmove : s u ≠ u)
    (hv : SameOrbit 7 s u v) : A u v = 0 := by
  rcases hA.2.2.1 u v with h0 | h1
  · exact h0
  · have hxv := fixedGeometry_orbit_neighbor A s hpres x u v hx hu hv
    have heq := (localMate_spec A hA x u hu).2.2 v ⟨hxv, h1⟩
    rw [heq] at hv
    exact False.elim (conway_period7_mate_not_sameOrbit A hA s h7 hpres x u hx hu hmove hv)

end Matrix99

#print axioms Matrix99.conway_period7_common_fixed
#print axioms Matrix99.conway_period7_mate_moves
#print axioms Matrix99.conway_period7_mate_not_sameOrbit
#print axioms Matrix99.conway_period7_pair_partition
#print axioms Matrix99.conway_period7_rooted_pair
#print axioms Matrix99.conway_period7_no_fixed_neighbor
#print axioms Matrix99.conway_period7_unique_fixed_at
#print axioms Matrix99.conway_period7_no_internal_neighbor_edge
