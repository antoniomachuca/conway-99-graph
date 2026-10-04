import Conway.Z3Cycles
import Conway.Z3FpfOrbitMatrix
import Conway.Z3Fixed3OrbitMatrix
import Conway.OrbitReindex
import Conway.Z7OrbitEnumeration

namespace ConwayOrbit

open Matrix99

/-! ## 1. Fixed-Point-Free (FPF) Orbit Enumeration (33 orbits of size 3) -/

theorem active3Labels_length_fpf (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (hfpf : ∀ v, s v ≠ v) :
    (active3Labels s).length = 33 := by
  have htotal : sumFin (fiberSize (orbitLabel 3 s)) = 99 := by
    unfold fiberSize
    rw [fiber_sum_partition]
    decide
  have hpoint : ∀ j : Fin 99,
      fiberSize (orbitLabel 3 s) j = 3 * (if orbitLabel 3 s j = j then 1 else 0) := by
    intro j
    by_cases hj : orbitLabel 3 s j = j
    · have hsize : fiberSize (orbitLabel 3 s) j = 3 := by
        have h := orbit3_fiber_size s h3 j
        rw [hj] at h
        rw [h]
        have hmove : s j ≠ j := hfpf j
        simp [hmove]
      simp [hj, hsize]
    · have hsize := orbit3_fiber_size_inactive s h3 j hj
      simp [hj, hsize]
  have hsums := congrArg sumFin (funext hpoint)
  have hcount : sumFin (fun j : Fin 99 => if orbitLabel 3 s j = j then 1 else 0) =
      (active3Labels s).length := by
    simpa [countSet, active3Labels] using
      countSet_eq_length_filter (fun j : Fin 99 => decide (orbitLabel 3 s j = j))
  rw [htotal, sumFin_mul_left, hcount] at hsums
  omega

structure Z3FpfOrbitEnumeration (s : Fin 99 → Fin 99) where
  rep : Fin 33 → Fin 99
  injective : ∀ i j, rep i = rep j → i = j
  active : ∀ i, orbitLabel 3 s (rep i) = rep i
  complete : ∀ u, orbitLabel 3 s u = u → ∃ i, rep i = u

def enumerateZ3FpfOrbits (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (hfpf : ∀ v, s v ≠ v) : Z3FpfOrbitEnumeration s := by
  let xs := active3Labels s
  have hlen : xs.length = 33 := active3Labels_length_fpf s h3 hfpf
  have hnd : xs.Nodup := active3Labels_nodup s
  have hmem : ∀ v, v ∈ xs ↔ orbitLabel 3 s v = v := active3Labels_member_iff s
  let rep : Fin 33 → Fin 99 := fun i => xs.get ⟨i.val, by rw [hlen]; exact i.isLt⟩
  refine ⟨rep, ?_, ?_, ?_⟩
  · intro i j hij
    apply Fin.ext
    exact (List.getElem_inj hnd).mp hij
  · intro i
    exact (hmem (rep i)).mp (List.get_mem xs _)
  · intro u hu
    obtain ⟨i, hi⟩ := List.get_of_mem ((hmem u).mpr hu)
    refine ⟨⟨i.val, by rw [← hlen]; exact i.isLt⟩, ?_⟩
    exact hi

def z3FpfOrbitIndexing (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (h3 : s^[3] = id) (hpres : ∀ u v, A (s u) (s v) = A u v)
    (hfpf : ∀ v, s v ≠ v) :
    OrbitIndexing (cyclicEquitableData 3 (by decide) A s h3 hpres) 33 :=
  let e := enumerateZ3FpfOrbits s h3 hfpf
  { rep := e.rep
    injective := e.injective
    active := e.active
    complete := e.complete }

theorem z3Fpf_orbit_sizes (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (h3 : s^[3] = id) (hpres : ∀ u v, A (s u) (s v) = A u v)
    (hfpf : ∀ v, s v ≠ v) (i : Fin 33) :
    (z3FpfOrbitIndexing A s h3 hpres hfpf).sizes i = z3FpfOrbitSizes i := by
  let e := enumerateZ3FpfOrbits s h3 hfpf
  change fiberSize (orbitLabel 3 s) (e.rep i) = 3
  have hact := e.active i
  have hsize := orbit3_fiber_size s h3 (e.rep i)
  rw [hact] at hsize
  rw [hsize]
  have hmove : s (e.rep i) ≠ e.rep i := hfpf _
  simp [hmove]


/-! ## 2. Fixed-3 Orbit Enumeration (3 fixed + 32 size-3 = 35 orbits) -/

theorem active3Labels_length_fixed3 (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (f1 f2 f3 : Fin 99) (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3)
    (hf1 : s f1 = f1) (hf2 : s f2 = f2) (hf3 : s f3 = f3)
    (hfixed_all : ∀ v, s v = v → v = f1 ∨ v = f2 ∨ v = f3) :
    (active3Labels s).length = 35 := by
  have hf1act : orbitLabel 3 s f1 = f1 := orbitLabel3_eq_self_of_fixed s h3 f1 hf1
  have hf2act : orbitLabel 3 s f2 = f2 := orbitLabel3_eq_self_of_fixed s h3 f2 hf2
  have hf3act : orbitLabel 3 s f3 = f3 := orbitLabel3_eq_self_of_fixed s h3 f3 hf3
  have htotal : sumFin (fiberSize (orbitLabel 3 s)) = 99 := by
    unfold fiberSize
    rw [fiber_sum_partition]
    decide
  have hpoint : ∀ j : Fin 99,
      fiberSize (orbitLabel 3 s) j + 2 * (if j = f1 ∨ j = f2 ∨ j = f3 then 1 else 0) =
        3 * (if orbitLabel 3 s j = j then 1 else 0) := by
    intro j
    by_cases hj : orbitLabel 3 s j = j
    · have hsize : fiberSize (orbitLabel 3 s) j = if s j = j then 1 else 3 := by
        simpa only [hj] using orbit3_fiber_size s h3 j
      by_cases hsj : s j = j
      · have hcases := hfixed_all j hsj
        rcases hcases with rfl | rfl | rfl
        · simp [hsize, hf1, hj]
        · simp [hsize, hf2, hj]
        · simp [hsize, hf3, hj]
      · have hnotf : ¬ (j = f1 ∨ j = f2 ∨ j = f3) := by
          intro h
          rcases h with rfl | rfl | rfl <;> exact hsj (by assumption)
        simp [hsize, hsj, hnotf, hj]
    · have hsize := orbit3_fiber_size_inactive s h3 j hj
      have hnotf : ¬ (j = f1 ∨ j = f2 ∨ j = f3) := by
        intro h
        rcases h with rfl | rfl | rfl
        · exact hj hf1act
        · exact hj hf2act
        · exact hj hf3act
      simp [hsize, hnotf, hj]
  have hadd : sumFin (fun j : Fin 99 =>
      fiberSize (orbitLabel 3 s) j + 2 * (if j = f1 ∨ j = f2 ∨ j = f3 then 1 else 0)) =
      sumFin (fiberSize (orbitLabel 3 s)) +
        2 * sumFin (fun j : Fin 99 => if j = f1 ∨ j = f2 ∨ j = f3 then 1 else 0) := by
    unfold sumFin
    rw [sum_map_add, sum_map_mul_left]
  have hsplit : ∀ j : Fin 99, (if j = f1 ∨ j = f2 ∨ j = f3 then 1 else 0) =
      (if j = f1 then 1 else 0) + (if j = f2 then 1 else 0) + (if j = f3 then 1 else 0) := by
    intro j
    by_cases h1 : j = f1
    · have hne2 : j ≠ f2 := fun hj => h12 (h1.symm.trans hj)
      have hne3 : j ≠ f3 := fun hj => h13 (h1.symm.trans hj)
      rw [if_pos (Or.inl h1)]
      rw [if_pos h1, if_neg hne2, if_neg hne3]
    · by_cases h2 : j = f2
      · have hne3 : j ≠ f3 := fun hj => h23 (h2.symm.trans hj)
        rw [if_pos (Or.inr (Or.inl h2))]
        rw [if_neg h1, if_pos h2, if_neg hne3]
      · by_cases h3 : j = f3
        · rw [if_pos (Or.inr (Or.inr h3))]
          rw [if_neg h1, if_neg h2, if_pos h3]
        · have hnot : ¬ (j = f1 ∨ j = f2 ∨ j = f3) := by
            intro h
            cases h with
            | inl ha => exact h1 ha
            | inr hb =>
              cases hb with
              | inl hc => exact h2 hc
              | inr hd => exact h3 hd
          rw [if_neg hnot, if_neg h1, if_neg h2, if_neg h3]
  have hsumeq : sumFin (fun j : Fin 99 => if j = f1 ∨ j = f2 ∨ j = f3 then 1 else 0) =
      sumFin (fun j => (if j = f1 then 1 else 0) + (if j = f2 then 1 else 0) + (if j = f3 then 1 else 0)) := by
    apply congrArg sumFin
    funext j
    exact hsplit j
  have hd1 : sumFin (fun j : Fin 99 => if j = f1 then 1 else 0) = 1 := by
    have hs := sum_indicator_list (List.nodup_finRange 99) f1 1
    have hm := List.mem_finRange f1
    unfold sumFin
    simpa [hm] using hs
  have hd2 : sumFin (fun j : Fin 99 => if j = f2 then 1 else 0) = 1 := by
    have hs := sum_indicator_list (List.nodup_finRange 99) f2 1
    have hm := List.mem_finRange f2
    unfold sumFin
    simpa [hm] using hs
  have hd3 : sumFin (fun j : Fin 99 => if j = f3 then 1 else 0) = 1 := by
    have hs := sum_indicator_list (List.nodup_finRange 99) f3 1
    have hm := List.mem_finRange f3
    unfold sumFin
    simpa [hm] using hs
  have hdelta3 : sumFin (fun j : Fin 99 => if j = f1 ∨ j = f2 ∨ j = f3 then 1 else 0) = 3 := by
    rw [hsumeq]
    unfold sumFin
    rw [sum_map_add, sum_map_add]
    change sumFin (fun j => if j = f1 then 1 else 0) +
      sumFin (fun j => if j = f2 then 1 else 0) +
      sumFin (fun j => if j = f3 then 1 else 0) = 3
    rw [hd1, hd2, hd3]
  have hsums := congrArg sumFin (funext hpoint)
  have hcount : sumFin (fun j : Fin 99 => if orbitLabel 3 s j = j then 1 else 0) =
      (active3Labels s).length := by
    simpa [countSet, active3Labels] using
      countSet_eq_length_filter (fun j : Fin 99 => decide (orbitLabel 3 s j = j))
  rw [hadd, htotal, hdelta3, sumFin_mul_left, hcount] at hsums
  omega

def rooted3Fixed3Labels (s : Fin 99 → Fin 99) (f1 f2 f3 : Fin 99) : List (Fin 99) :=
  [f1, f2, f3] ++ (((active3Labels s).erase f1).erase f2).erase f3

theorem rooted3Fixed3Labels_perm (s : Fin 99 → Fin 99) (f1 f2 f3 : Fin 99)
    (hf1 : orbitLabel 3 s f1 = f1) (hf2 : orbitLabel 3 s f2 = f2) (hf3 : orbitLabel 3 s f3 = f3)
    (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3) :
    (active3Labels s).Perm (rooted3Fixed3Labels s f1 f2 f3) := by
  have h1mem := (active3Labels_member_iff s f1).mpr hf1
  have h2mem : f2 ∈ (active3Labels s).erase f1 :=
    (mem_erase_of_ne_local (Ne.symm h12)).mpr ((active3Labels_member_iff s f2).mpr hf2)
  have h3mem : f3 ∈ ((active3Labels s).erase f1).erase f2 :=
    (mem_erase_of_ne_local (Ne.symm h23)).mpr
      ((mem_erase_of_ne_local (Ne.symm h13)).mpr ((active3Labels_member_iff s f3).mpr hf3))
  exact (perm_cons_erase_local h1mem).trans
    (((perm_cons_erase_local h2mem).trans ((perm_cons_erase_local h3mem).cons f2)).cons f1)

theorem rooted3Fixed3Labels_length (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (f1 f2 f3 : Fin 99) (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3)
    (hf1 : s f1 = f1) (hf2 : s f2 = f2) (hf3 : s f3 = f3)
    (hfixed_all : ∀ v, s v = v → v = f1 ∨ v = f2 ∨ v = f3) :
    (rooted3Fixed3Labels s f1 f2 f3).length = 35 := by
  have hf1act := orbitLabel3_eq_self_of_fixed s h3 f1 hf1
  have hf2act := orbitLabel3_eq_self_of_fixed s h3 f2 hf2
  have hf3act := orbitLabel3_eq_self_of_fixed s h3 f3 hf3
  have hp := rooted3Fixed3Labels_perm s f1 f2 f3 hf1act hf2act hf3act h12 h23 h13
  exact hp.length_eq.symm.trans (active3Labels_length_fixed3 s h3 f1 f2 f3 h12 h23 h13 hf1 hf2 hf3 hfixed_all)

theorem rooted3Fixed3Labels_nodup (s : Fin 99 → Fin 99) (f1 f2 f3 : Fin 99)
    (hf1 : orbitLabel 3 s f1 = f1) (hf2 : orbitLabel 3 s f2 = f2) (hf3 : orbitLabel 3 s f3 = f3)
    (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3) :
    (rooted3Fixed3Labels s f1 f2 f3).Nodup :=
  (rooted3Fixed3Labels_perm s f1 f2 f3 hf1 hf2 hf3 h12 h23 h13).nodup (active3Labels_nodup s)

theorem rooted3Fixed3Labels_member_iff (s : Fin 99 → Fin 99) (f1 f2 f3 : Fin 99)
    (hf1 : orbitLabel 3 s f1 = f1) (hf2 : orbitLabel 3 s f2 = f2) (hf3 : orbitLabel 3 s f3 = f3)
    (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3) (v : Fin 99) :
    v ∈ rooted3Fixed3Labels s f1 f2 f3 ↔ orbitLabel 3 s v = v :=
  (rooted3Fixed3Labels_perm s f1 f2 f3 hf1 hf2 hf3 h12 h23 h13).mem_iff.symm.trans
    (active3Labels_member_iff s v)

structure Z3Fixed3OrbitEnumeration (s : Fin 99 → Fin 99) (f1 f2 f3 : Fin 99) where
  rep : Fin 35 → Fin 99
  injective : ∀ i j, rep i = rep j → i = j
  active : ∀ i, orbitLabel 3 s (rep i) = rep i
  complete : ∀ u, orbitLabel 3 s u = u → ∃ i, rep i = u
  fixed0 : rep 0 = f1
  fixed1 : rep 1 = f2
  fixed2 : rep 2 = f3

def enumerateZ3Fixed3Orbits (s : Fin 99 → Fin 99) (h3 : s^[3] = id)
    (f1 f2 f3 : Fin 99) (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3)
    (hf1 : s f1 = f1) (hf2 : s f2 = f2) (hf3 : s f3 = f3)
    (hfixed_all : ∀ v, s v = v → v = f1 ∨ v = f2 ∨ v = f3) :
    Z3Fixed3OrbitEnumeration s f1 f2 f3 := by
  let xs := rooted3Fixed3Labels s f1 f2 f3
  have hlen : xs.length = 35 := rooted3Fixed3Labels_length s h3 f1 f2 f3 h12 h23 h13 hf1 hf2 hf3 hfixed_all
  have hf1act := orbitLabel3_eq_self_of_fixed s h3 f1 hf1
  have hf2act := orbitLabel3_eq_self_of_fixed s h3 f2 hf2
  have hf3act := orbitLabel3_eq_self_of_fixed s h3 f3 hf3
  have hnd := rooted3Fixed3Labels_nodup s f1 f2 f3 hf1act hf2act hf3act h12 h23 h13
  have hmem := rooted3Fixed3Labels_member_iff s f1 f2 f3 hf1act hf2act hf3act h12 h23 h13
  let rep : Fin 35 → Fin 99 := fun i => xs.get ⟨i.val, by rw [hlen]; exact i.isLt⟩
  refine ⟨rep, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro i j hij
    apply Fin.ext
    exact (List.getElem_inj hnd).mp hij
  · intro i
    exact (hmem (rep i)).mp (List.get_mem xs _)
  · intro u hu
    obtain ⟨i, hi⟩ := List.get_of_mem ((hmem u).mpr hu)
    refine ⟨⟨i.val, by rw [← hlen]; exact i.isLt⟩, ?_⟩
    exact hi
  · rfl
  · rfl
  · rfl

def z3Fixed3OrbitIndexing (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (h3 : s^[3] = id) (hpres : ∀ u v, A (s u) (s v) = A u v)
    (f1 f2 f3 : Fin 99) (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3)
    (hf1 : s f1 = f1) (hf2 : s f2 = f2) (hf3 : s f3 = f3)
    (hfixed_all : ∀ v, s v = v → v = f1 ∨ v = f2 ∨ v = f3) :
    OrbitIndexing (cyclicEquitableData 3 (by decide) A s h3 hpres) 35 :=
  let e := enumerateZ3Fixed3Orbits s h3 f1 f2 f3 h12 h23 h13 hf1 hf2 hf3 hfixed_all
  { rep := e.rep
    injective := e.injective
    active := e.active
    complete := e.complete }

theorem z3Fixed3_orbit_sizes (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (h3 : s^[3] = id) (hpres : ∀ u v, A (s u) (s v) = A u v)
    (f1 f2 f3 : Fin 99) (h12 : f1 ≠ f2) (h23 : f2 ≠ f3) (h13 : f1 ≠ f3)
    (hf1 : s f1 = f1) (hf2 : s f2 = f2) (hf3 : s f3 = f3)
    (hfixed_all : ∀ v, s v = v → v = f1 ∨ v = f2 ∨ v = f3) (i : Fin 35) :
    (z3Fixed3OrbitIndexing A s h3 hpres f1 f2 f3 h12 h23 h13 hf1 hf2 hf3 hfixed_all).sizes i =
      z3Fixed3OrbitSizes i := by
  let e := enumerateZ3Fixed3Orbits s h3 f1 f2 f3 h12 h23 h13 hf1 hf2 hf3 hfixed_all
  change fiberSize (orbitLabel 3 s) (e.rep i) = z3Fixed3OrbitSizes i
  have hact := e.active i
  have hsize := orbit3_fiber_size s h3 (e.rep i)
  rw [hact] at hsize
  rw [hsize]
  unfold z3Fixed3OrbitSizes
  by_cases hi : i.val < 3
  · rw [if_pos hi]
    have hcase : i.val = 0 ∨ i.val = 1 ∨ i.val = 2 := by omega
    rcases hcase with h0 | h1 | h2
    · have hi0 : i = 0 := Fin.ext h0
      rw [hi0, e.fixed0, hf1]
      simp
    · have hi1 : i = 1 := Fin.ext h1
      rw [hi1, e.fixed1, hf2]
      simp
    · have hi2 : i = 2 := Fin.ext h2
      rw [hi2, e.fixed2, hf3]
      simp
  · rw [if_neg hi]
    have hmove : s (e.rep i) ≠ e.rep i := by
      intro hfix
      have hor := hfixed_all (e.rep i) hfix
      rcases hor with h | h | h
      · have h0eq : e.rep i = e.rep 0 := by rw [e.fixed0, h]
        have := e.injective i 0 h0eq
        have : i.val = 0 := congrArg Fin.val this
        omega
      · have h1eq : e.rep i = e.rep 1 := by rw [e.fixed1, h]
        have := e.injective i 1 h1eq
        have : i.val = 1 := congrArg Fin.val this
        omega
      · have h2eq : e.rep i = e.rep 2 := by rw [e.fixed2, h]
        have := e.injective i 2 h2eq
        have : i.val = 2 := congrArg Fin.val this
        omega
    simp [hmove]

#print axioms active3Labels_length_fpf
#print axioms enumerateZ3FpfOrbits
#print axioms z3FpfOrbitIndexing
#print axioms z3Fpf_orbit_sizes
#print axioms active3Labels_length_fixed3
#print axioms enumerateZ3Fixed3Orbits
#print axioms z3Fixed3OrbitIndexing
#print axioms z3Fixed3_orbit_sizes

end ConwayOrbit
