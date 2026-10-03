import Conway.Z7Cycles
import Conway.OrbitReindex
import Conway.Z7OrbitMatrix

namespace ConwayOrbit

structure Z7OrbitEnumeration (s : Fin 99 → Fin 99) (x L R : Fin 99) where
  rep : Fin 15 → Fin 99
  injective : ∀ i j, rep i = rep j → i = j
  active : ∀ i, orbitLabel 7 s (rep i) = rep i
  complete : ∀ u, orbitLabel 7 s u = u → ∃ i, rep i = u
  root : rep 0 = x
  left : rep 1 = L
  right : rep 2 = R

def active7Labels (s : Fin 99 → Fin 99) : List (Fin 99) :=
  (List.finRange 99).filter (fun v => decide (orbitLabel 7 s v = v))

def rooted7Labels (s : Fin 99 → Fin 99) (x L R : Fin 99) : List (Fin 99) :=
  [x, L, R] ++ (((active7Labels s).erase x).erase L).erase R

theorem active7Labels_member_iff (s : Fin 99 → Fin 99) (v : Fin 99) :
    v ∈ active7Labels s ↔ orbitLabel 7 s v = v := by
  simp [active7Labels]

theorem active7Labels_nodup (s : Fin 99 → Fin 99) : (active7Labels s).Nodup := by
  exact List.Pairwise.filter _ (List.nodup_finRange 99)

theorem orbit7_fiber_size_inactive (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (j : Fin 99) (hj : orbitLabel 7 s j ≠ j) :
    fiberSize (orbitLabel 7 s) j = 0 := by
  have hnone : ∀ v, orbitLabel 7 s v ≠ j := by
    intro v hv
    apply hj
    rw [← hv]
    exact orbitLabel_idempotent (by decide) s h7 v
  unfold fiberSize fiberSum sumFin
  simp only [hnone]
  exact sum_map_zero (List.finRange 99)

theorem active7Labels_length (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (x : Fin 99) (hx : s x = x) (hunique : ∀ v, s v = v → v = x) :
    (active7Labels s).length = 15 := by
  have hxactive := orbitLabel_eq_self_of_fixed s h7 x hx
  have htotal : sumFin (fiberSize (orbitLabel 7 s)) = 99 := by
    unfold fiberSize
    rw [fiber_sum_partition]
    decide
  have hpoint : ∀ j : Fin 99,
      fiberSize (orbitLabel 7 s) j + 6 * (if j = x then 1 else 0) =
        7 * (if orbitLabel 7 s j = j then 1 else 0) := by
    intro j
    by_cases hj : orbitLabel 7 s j = j
    · have hsize : fiberSize (orbitLabel 7 s) j = if s j = j then 1 else 7 := by
        simpa only [hj] using orbit7_fiber_size s h7 j
      by_cases hjx : j = x
      · subst j
        simp [hsize, hx, hxactive]
      · have hmove : s j ≠ j := fun h => hjx (hunique j h)
        simp [hsize, hmove, hjx, hj]
    · have hsize := orbit7_fiber_size_inactive s h7 j hj
      have hjx : j ≠ x := by
        intro h
        subst j
        exact hj hxactive
      simp [hsize, hjx, hj]
  have hadd : sumFin (fun j : Fin 99 =>
      fiberSize (orbitLabel 7 s) j + 6 * (if j = x then 1 else 0)) =
      sumFin (fiberSize (orbitLabel 7 s)) +
        6 * sumFin (fun j : Fin 99 => if j = x then 1 else 0) := by
    unfold sumFin
    rw [sum_map_add, sum_map_mul_left]
  have hdelta : sumFin (fun j : Fin 99 => if j = x then 1 else 0) = 1 := by
    simpa [eq_comm] using sumFin_indicator_value x (fun _ => 1)
  have hcount : sumFin (fun j : Fin 99 => if orbitLabel 7 s j = j then 1 else 0) =
      (active7Labels s).length := by
    simpa [countSet, active7Labels] using
      countSet_eq_length_filter (fun j : Fin 99 => decide (orbitLabel 7 s j = j))
  have hsums := congrArg sumFin (funext hpoint)
  rw [hadd, htotal, hdelta, sumFin_mul_left, hcount] at hsums
  omega

theorem perm_cons_erase_local {α : Type} [DecidableEq α] {l : List α} {a : α}
    (ha : a ∈ l) : l.Perm (a :: l.erase a) := by
  induction l with
  | nil => cases ha
  | cons b t ih =>
    by_cases hba : b = a
    · subst b
      simp
    · have hab : a ≠ b := Ne.symm hba
      have ht : a ∈ t := by simpa [List.mem_cons, hab] using ha
      have hbeq : ¬ b == a := fun h => hba (LawfulBEq.eq_of_beq h)
      rw [List.erase_cons, if_neg hbeq]
      exact ((ih ht).cons b).trans (List.Perm.swap _ _ _)

theorem rooted7Labels_perm (s : Fin 99 → Fin 99) (x L R : Fin 99)
    (hxactive : orbitLabel 7 s x = x)
    (hL : orbitLabel 7 s L = L) (hR : orbitLabel 7 s R = R)
    (hLx : L ≠ x) (hRx : R ≠ x) (hLR : L ≠ R) :
    (active7Labels s).Perm (rooted7Labels s x L R) := by
  have hxmem := (active7Labels_member_iff s x).mpr hxactive
  have hLmem : L ∈ (active7Labels s).erase x :=
    (mem_erase_of_ne_local hLx).mpr ((active7Labels_member_iff s L).mpr hL)
  have hRmem : R ∈ ((active7Labels s).erase x).erase L :=
    (mem_erase_of_ne_local (Ne.symm hLR)).mpr
      ((mem_erase_of_ne_local hRx).mpr ((active7Labels_member_iff s R).mpr hR))
  exact (perm_cons_erase_local hxmem).trans
    (((perm_cons_erase_local hLmem).trans ((perm_cons_erase_local hRmem).cons L)).cons x)

theorem rooted7Labels_length (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (x L R : Fin 99) (hx : s x = x) (hunique : ∀ v, s v = v → v = x)
    (hL : orbitLabel 7 s L = L) (hR : orbitLabel 7 s R = R)
    (hLx : L ≠ x) (hRx : R ≠ x) (hLR : L ≠ R) :
    (rooted7Labels s x L R).length = 15 := by
  have hp := rooted7Labels_perm s x L R (orbitLabel_eq_self_of_fixed s h7 x hx)
    hL hR hLx hRx hLR
  exact hp.length_eq.symm.trans (active7Labels_length s h7 x hx hunique)

theorem rooted7Labels_nodup (s : Fin 99 → Fin 99) (x L R : Fin 99)
    (hxactive : orbitLabel 7 s x = x)
    (hL : orbitLabel 7 s L = L) (hR : orbitLabel 7 s R = R)
    (hLx : L ≠ x) (hRx : R ≠ x) (hLR : L ≠ R) :
    (rooted7Labels s x L R).Nodup :=
  (rooted7Labels_perm s x L R hxactive hL hR hLx hRx hLR).nodup
    (active7Labels_nodup s)

theorem rooted7Labels_member_iff (s : Fin 99 → Fin 99) (x L R : Fin 99)
    (hxactive : orbitLabel 7 s x = x)
    (hL : orbitLabel 7 s L = L) (hR : orbitLabel 7 s R = R)
    (hLx : L ≠ x) (hRx : R ≠ x) (hLR : L ≠ R) (v : Fin 99) :
    v ∈ rooted7Labels s x L R ↔ orbitLabel 7 s v = v :=
  (rooted7Labels_perm s x L R hxactive hL hR hLx hRx hLR).mem_iff.symm.trans
    (active7Labels_member_iff s v)

def enumerateZ7Orbits (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (x L R : Fin 99) (hx : s x = x) (hunique : ∀ v, s v = v → v = x)
    (hL : orbitLabel 7 s L = L) (hR : orbitLabel 7 s R = R)
    (hLx : L ≠ x) (hRx : R ≠ x) (hLR : L ≠ R) : Z7OrbitEnumeration s x L R := by
  let xs := rooted7Labels s x L R
  have hlen : xs.length = 15 := rooted7Labels_length s h7 x L R hx hunique hL hR hLx hRx hLR
  have hxactive := orbitLabel_eq_self_of_fixed s h7 x hx
  have hnd := rooted7Labels_nodup s x L R hxactive hL hR hLx hRx hLR
  have hmem := rooted7Labels_member_iff s x L R hxactive hL hR hLx hRx hLR
  let rep : Fin 15 → Fin 99 := fun i => xs.get ⟨i.val, by rw [hlen]; exact i.isLt⟩
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

#print axioms active7Labels
#print axioms rooted7Labels
#print axioms active7Labels_member_iff
#print axioms active7Labels_nodup
#print axioms orbit7_fiber_size_inactive
#print axioms active7Labels_length
#print axioms perm_cons_erase_local
#print axioms rooted7Labels_perm
#print axioms rooted7Labels_length
#print axioms rooted7Labels_nodup
#print axioms rooted7Labels_member_iff
#print axioms enumerateZ7Orbits
#print axioms Z7OrbitEnumeration
#print axioms Z7OrbitEnumeration.rep
#print axioms Z7OrbitEnumeration.injective
#print axioms Z7OrbitEnumeration.active
#print axioms Z7OrbitEnumeration.complete
#print axioms Z7OrbitEnumeration.root
#print axioms Z7OrbitEnumeration.left
#print axioms Z7OrbitEnumeration.right

end ConwayOrbit
