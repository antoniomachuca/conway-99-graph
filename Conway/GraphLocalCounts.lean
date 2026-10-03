import Conway.OrbitQuotient

namespace Matrix99

def localNeighbors (A : Matrix99 Nat) (x : Fin 99) : List (Fin 99) :=
  (List.finRange 99).filter (fun v => decide (A x v = 1))

def localCommon (A : Matrix99 Nat) (x y : Fin 99) : List (Fin 99) :=
  (List.finRange 99).filter (fun v => decide (A x v = 1 ∧ A y v = 1))

def localMate (A : Matrix99 Nat) (x u : Fin 99) : Fin 99 :=
  (localCommon A x u).headD u

theorem mem_localNeighbors (A : Matrix99 Nat) (x v : Fin 99) :
    v ∈ localNeighbors A x ↔ A x v = 1 := by
  simp [localNeighbors]

theorem mem_localCommon (A : Matrix99 Nat) (x y v : Fin 99) :
    v ∈ localCommon A x y ↔ A x v = 1 ∧ A y v = 1 := by
  simp [localCommon]

private theorem local_filter_nodup {α : Type} (p : α → Bool) (l : List α)
    (h : l.Nodup) : (l.filter p).Nodup := by
  induction l with
  | nil => exact List.nodup_nil
  | cons a l ih =>
    rw [List.nodup_cons] at h
    cases hp : p a with
    | false => simpa [List.filter_cons, hp] using ih h.2
    | true =>
      simp only [List.filter_cons, hp, if_true, List.nodup_cons]
      exact ⟨fun ha => h.1 (List.mem_filter.mp ha).1, ih h.2⟩

theorem localNeighbors_nodup (A : Matrix99 Nat) (x : Fin 99) :
    (localNeighbors A x).Nodup :=
  local_filter_nodup _ _ (List.nodup_finRange 99)

theorem localCommon_nodup (A : Matrix99 Nat) (x y : Fin 99) :
    (localCommon A x y).Nodup :=
  local_filter_nodup _ _ (List.nodup_finRange 99)

private theorem local_filter_length_sum {α : Type} (p : α → Bool) (l : List α) :
    (l.filter p).length = (l.map (fun v => if p v then 1 else 0)).sum := by
  induction l with
  | nil => rfl
  | cons a l ih =>
    cases hp : p a <;> simp [hp, ih, Nat.add_comm]

theorem conway_neighbor_count (A : Matrix99 Nat) (hA : ConwayAdj A) (x : Fin 99) :
    (localNeighbors A x).length = 14 := by
  have hind : (fun v => if decide (A x v = 1) then 1 else 0) = A x := by
    funext v
    rcases hA.2.2.1 x v with h0 | h1
    · simp [h0]
    · simp [h1]
  unfold localNeighbors
  rw [local_filter_length_sum, hind]
  exact conway_row_sum A hA x

theorem conway_common_count (A : Matrix99 Nat) (hA : ConwayAdj A)
    (x y : Fin 99) (hxy : x ≠ y) :
    (localCommon A x y).length + A x y = 2 := by
  have hind : (fun v => if decide (A x v = 1 ∧ A y v = 1) then 1 else 0) =
      (fun v => A x v * A v y) := by
    funext v
    rw [hA.2.1 v y]
    rcases hA.2.2.1 x v with hxv | hxv <;>
      rcases hA.2.2.1 y v with hyv | hyv <;> simp [hxv, hyv]
  have hlen : (localCommon A x y).length = mul A A x y := by
    unfold localCommon
    rw [local_filter_length_sum, hind]
    exact sumFin_eq_foldl (fun v => A x v * A v y)
  rw [hlen, hA.2.2.2 x y, conway_target_formula, if_neg hxy]

private theorem local_list_eq_pair {α : Type} (l : List α) (h : l.length = 2) :
    ∃ a b, l = [a, b] := by
  cases l with
  | nil => simp at h
  | cons a t =>
    cases t with
    | nil => simp at h
    | cons b t =>
      have ht : t.length = 0 := by simp only [List.length_cons] at h; omega
      have ht' := List.eq_nil_of_length_eq_zero ht
      exact ⟨a, b, by rw [ht']⟩

private theorem local_list_eq_singleton {α : Type} (l : List α) (h : l.length = 1) :
    ∃ a, l = [a] := by
  cases l with
  | nil => simp at h
  | cons a t =>
    have ht : t.length = 0 := by simp only [List.length_cons] at h; omega
    have ht' := List.eq_nil_of_length_eq_zero ht
    exact ⟨a, by rw [ht']⟩

theorem conway_two_common (A : Matrix99 Nat) (hA : ConwayAdj A)
    (x y : Fin 99) (hxy : x ≠ y) (hnon : A x y = 0) :
    ∃ a b : Fin 99, a ≠ b ∧ A x a = 1 ∧ A y a = 1 ∧ A x b = 1 ∧ A y b = 1 := by
  have hc := conway_common_count A hA x y hxy
  have hlen : (localCommon A x y).length = 2 := by omega
  obtain ⟨a, b, hl⟩ := local_list_eq_pair _ hlen
  have hnd := localCommon_nodup A x y
  have hab : a ≠ b := by simpa [hl] using hnd
  have ha : A x a = 1 ∧ A y a = 1 :=
    (mem_localCommon A x y a).mp (by simp [hl])
  have hb : A x b = 1 ∧ A y b = 1 :=
    (mem_localCommon A x y b).mp (by simp [hl])
  exact ⟨a, b, hab, ha.1, ha.2, hb.1, hb.2⟩

private theorem local_no_three_of_length_le_two {α : Type} (l : List α)
    (hlen : l.length ≤ 2) (a b c : α) (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    (ha : a ∈ l) (hb : b ∈ l) (hc : c ∈ l) : False := by
  cases l with
  | nil => simp at ha
  | cons d t =>
    cases t with
    | nil =>
      have had : a = d := by simpa using ha
      have hbd : b = d := by simpa using hb
      exact hab (had.trans hbd.symm)
    | cons e t =>
      have ht : t.length = 0 := by simp only [List.length_cons] at hlen; omega
      have ht' := List.eq_nil_of_length_eq_zero ht
      rw [ht'] at ha hb hc
      simp only [List.mem_cons, List.not_mem_nil, or_false] at ha hb hc
      rcases ha with rfl | rfl <;> rcases hb with rfl | rfl <;>
        rcases hc with rfl | rfl <;> simp_all

theorem conway_no_three_common (A : Matrix99 Nat) (hA : ConwayAdj A)
    (x y : Fin 99) (hxy : x ≠ y) (a b c : Fin 99)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    (ha : A x a = 1 ∧ A y a = 1)
    (hb : A x b = 1 ∧ A y b = 1)
    (hc : A x c = 1 ∧ A y c = 1) : False := by
  have hcount := conway_common_count A hA x y hxy
  exact local_no_three_of_length_le_two (localCommon A x y) (by omega)
    a b c hab hac hbc ((mem_localCommon A x y a).mpr ha)
    ((mem_localCommon A x y b).mpr hb) ((mem_localCommon A x y c).mpr hc)

theorem localMate_spec (A : Matrix99 Nat) (hA : ConwayAdj A)
    (x u : Fin 99) (hu : A x u = 1) :
    A x (localMate A x u) = 1 ∧ A u (localMate A x u) = 1 ∧
      (∀ v : Fin 99, A x v = 1 ∧ A u v = 1 → v = localMate A x u) := by
  have hxu : x ≠ u := by
    intro h
    have hd := hA.1 x
    rw [← h] at hu
    omega
  have hcount := conway_common_count A hA x u hxu
  have hlen : (localCommon A x u).length = 1 := by omega
  obtain ⟨a, hl⟩ := local_list_eq_singleton _ hlen
  have hmate : localMate A x u = a := by simp [localMate, hl]
  have ha : A x a = 1 ∧ A u a = 1 :=
    (mem_localCommon A x u a).mp (by simp [hl])
  rw [hmate]
  refine ⟨ha.1, ha.2, ?_⟩
  intro v hv
  have hm := (mem_localCommon A x u v).mpr hv
  simpa [hl] using hm

theorem localMate_ne (A : Matrix99 Nat) (hA : ConwayAdj A)
    (x u : Fin 99) (hu : A x u = 1) : localMate A x u ≠ u := by
  intro heq
  have hm := (localMate_spec A hA x u hu).2.1
  rw [heq, hA.1 u] at hm
  contradiction

theorem localMate_involution (A : Matrix99 Nat) (hA : ConwayAdj A)
    (x u : Fin 99) (hu : A x u = 1) :
    localMate A x (localMate A x u) = u := by
  have hm := localMate_spec A hA x u hu
  have hm' := localMate_spec A hA x (localMate A x u) hm.1
  exact (hm'.2.2 u ⟨hu, (hA.2.1 _ _).trans hm.2.1⟩).symm

theorem localMate_commutes (A : Matrix99 Nat) (hA : ConwayAdj A) (s : Fin 99 → Fin 99)
    (hpres : ∀ a b, A (s a) (s b) = A a b) (x u : Fin 99) (hx : s x = x)
    (hu : A x u = 1) : localMate A x (s u) = s (localMate A x u) := by
  have hsu : A x (s u) = 1 := by rw [← hx, hpres]; exact hu
  have hm := localMate_spec A hA x u hu
  have hsmx : A x (s (localMate A x u)) = 1 := by
    have hp := hpres x (localMate A x u)
    rw [hx] at hp
    exact hp.trans hm.1
  have hsmu : A (s u) (s (localMate A x u)) = 1 := (hpres _ _).trans hm.2.1
  exact ((localMate_spec A hA x (s u) hsu).2.2 _ ⟨hsmx, hsmu⟩).symm

theorem conway_outer_coordinates_injective (A : Matrix99 Nat) (hA : ConwayAdj A)
    (x a b v w : Fin 99) (hab : a ≠ b)
    (hxa : A x a = 1) (hxb : A x b = 1)
    (hvx : v ≠ x) (hwx : w ≠ x)
    (hva : A v a = 1) (hvb : A v b = 1)
    (hwa : A w a = 1) (hwb : A w b = 1) : v = w := by
  cases (inferInstance : Decidable (v = w)) with
  | isTrue h => exact h
  | isFalse h =>
    exact False.elim (conway_no_three_common A hA a b hab x v w
      (Ne.symm hvx) (Ne.symm hwx) h
      ⟨(hA.2.1 _ _).trans hxa, (hA.2.1 _ _).trans hxb⟩
      ⟨(hA.2.1 _ _).trans hva, (hA.2.1 _ _).trans hvb⟩
      ⟨(hA.2.1 _ _).trans hwa, (hA.2.1 _ _).trans hwb⟩)

theorem conway_fix_neighborhood_faithful (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (hbij : Function.Bijective s)
    (hpres : ∀ a b, A (s a) (s b) = A a b)
    (x : Fin 99) (hx : s x = x) (hN : ∀ u, A x u = 1 → s u = u) :
    ∀ v, s v = v := by
  intro v
  cases (inferInstance : Decidable (v = x)) with
  | isTrue hv => exact hv ▸ hx
  | isFalse hv =>
    rcases hA.2.2.1 x v with h0 | h1
    · obtain ⟨a, b, hab, hxa, hva, hxb, hvb⟩ :=
        conway_two_common A hA x v (Ne.symm hv) h0
      have hsa := hN a hxa
      have hsb := hN b hxb
      have hsva : A (s v) a = 1 := by rw [← hsa, hpres]; exact hva
      have hsvb : A (s v) b = 1 := by rw [← hsb, hpres]; exact hvb
      have hsvx : s v ≠ x := by
        intro heq
        exact hv (hbij.1 (heq.trans hx.symm))
      exact conway_outer_coordinates_injective A hA x a b (s v) v hab
        hxa hxb hsvx hv hsva hsvb hva hvb
    · exact hN v h1

end Matrix99

#print axioms Matrix99.localNeighbors
#print axioms Matrix99.localCommon
#print axioms Matrix99.localMate
#print axioms Matrix99.mem_localNeighbors
#print axioms Matrix99.mem_localCommon
#print axioms Matrix99.localNeighbors_nodup
#print axioms Matrix99.localCommon_nodup
#print axioms Matrix99.conway_neighbor_count
#print axioms Matrix99.conway_common_count
#print axioms Matrix99.conway_two_common
#print axioms Matrix99.conway_no_three_common
#print axioms Matrix99.localMate_spec
#print axioms Matrix99.localMate_ne
#print axioms Matrix99.localMate_involution
#print axioms Matrix99.localMate_commutes
#print axioms Matrix99.conway_outer_coordinates_injective
#print axioms Matrix99.conway_fix_neighborhood_faithful
