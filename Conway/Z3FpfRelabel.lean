import Conway.Z3FpfGroupRing

/-!
# Relabelings of the Z3 fixed-point-free group-ring frame (WP4)

Two gauge transformations preserving `Z3FpfGroupRing`: permutation of the orbit
index set (`perm`) and per-orbit representative shifts (`shift`), plus the
`SysB`/`SysS10` system definitions used by the t = 27 branch.
-/

namespace Matrix99
open ConwayOrbit
namespace Z3FpfGroupRing

open Z3FpfOrbitMatrix

/-- Fin-3 group identities used by the relabeling proofs (all decidable). -/
theorem fin3_sub_self : ∀ a : Fin 3, a - a = 0 := by decide
theorem fin3_add_sub_cancel : ∀ (s a : Fin 3), s + a - a = s := by decide
theorem fin3_zero_sub_self : ∀ a : Fin 3, 0 + a - a = 0 := by decide
theorem fin3_add_sub_assoc : ∀ (a b c : Fin 3), a + b - c = a + (b - c) := by decide
theorem fin3_neg_shift : ∀ (s a b : Fin 3), -(s + a - b) = -s + b - a := by decide
theorem fin3_sub_shift : ∀ (s u a b e : Fin 3),
    s - u + a - b = (s + a - e) - (u + b - e) := by decide

/-- Translation `u ↦ u + d` is a bijection of `Fin 3`, so sums reindex. -/
theorem sumFin_add3 (d : Fin 3) (f : Fin 3 → Nat) :
    sumFin (fun u : Fin 3 => f (u + d)) = sumFin f := by
  apply sumFin_comp_eq (fun u : Fin 3 => u + d)
  · intro a b h
    have h2 := congrArg (fun x : Fin 3 => x - d) h
    rw [fin3_add_sub_cancel a d, fin3_add_sub_cancel b d] at h2
    exact h2
  · intro y
    exact ⟨y - d, fin3_sub_add y d⟩

/-- Triangle orbits sit on indices `< 27`. -/
def Tri27 (G : Z3FpfGroupRing) : Prop := ∀ i : Fin 33, G.S i i 1 = true ↔ i.val < 27

/-- Gauge condition: neighbours of orbit 0 have shift set `{0}` on the positive
    side; stated as: a nontrivial shift in row 0 forces the 0-shift. -/
def Gauge (G : Z3FpfGroupRing) : Prop :=
  ∀ j : Fin 33, 1 ≤ j.val → (G.S 0 j 1 = true ∨ G.S 0 j 2 = true) → G.S 0 j 0 = true

/-- Row 0 is fully fixed: `S_0j = {0}` exactly on the prescribed neighbour set. -/
def Row0 (n : Nat) (G : Z3FpfGroupRing) : Prop :=
  ∀ j : Fin 33, 1 ≤ j.val → ∀ s : Fin 3, G.S 0 j s = true ↔
    (s = 0 ∧ ((1 ≤ j.val ∧ j.val ≤ n) ∨ (27 ≤ j.val ∧ j.val < 27 + (12 - n))))

/-- The t = 27 counting normal form: each triangle orbit has exactly two
    non-triangle neighbours, and each non-triangle orbit has exactly five
    non-triangle neighbours besides itself. -/
def Count27 (G : Z3FpfGroupRing) : Prop :=
  (∀ k : Fin 33, k.val < 27 →
    sumFin (fun j : Fin 33 => if 27 ≤ j.val then sumFin (fun s : Fin 3 => if G.S k j s = true then 1 else 0) else 0) = 2) ∧
  (∀ j : Fin 33, 27 ≤ j.val →
    sumFin (fun k : Fin 33 => if 27 ≤ k.val ∧ k ≠ j then sumFin (fun s : Fin 3 => if G.S j k s = true then 1 else 0) else 0) = 5)

/-- System B at profile level `n`. -/
def SysB (n : Nat) (G : Z3FpfGroupRing) : Prop := G.Tri27 ∧ G.Gauge ∧ G.Row0 n

/-- System S10: system B at `n = 10` plus the counting normal form. -/
def SysS10 (G : Z3FpfGroupRing) : Prop := G.SysB 10 ∧ G.Count27

/-- Permute the orbit index set along a bijection `π` with inverse `σ`. -/
def perm (G : Z3FpfGroupRing) (π σ : Fin 33 → Fin 33)
    (h1 : ∀ i, σ (π i) = i) (h2 : ∀ i, π (σ i) = i) : Z3FpfGroupRing where
  S := fun i j s => G.S (π i) (π j) s
  sym := fun i j s => G.sym (π i) (π j) s
  loopless := fun i => G.loopless (π i)
  diag := fun i => G.diag (π i)
  deg := by
    intro i
    have hinj : ∀ a b : Fin 33, π a = π b → a = b := by
      intro a b h
      have h' := congrArg σ h
      rw [h1 a, h1 b] at h'
      exact h'
    have hsurj : ∀ y : Fin 33, ∃ x, π x = y := fun y => ⟨σ y, h2 y⟩
    calc sumFin (fun j => sumFin (fun s : Fin 3 => if G.S (π i) (π j) s = true then 1 else 0))
        = sumFin (fun j => sumFin (fun s : Fin 3 => if G.S (π i) j s = true then 1 else 0)) :=
          sumFin_comp_eq π hinj hsurj
            (fun j => sumFin (fun s : Fin 3 => if G.S (π i) j s = true then (1 : Nat) else 0))
      _ = 14 := G.deg (π i)
  eq := by
    intro i j s
    have hinj : ∀ a b : Fin 33, π a = π b → a = b := by
      intro a b h
      have h' := congrArg σ h
      rw [h1 a, h1 b] at h'
      exact h'
    have hsurj : ∀ y : Fin 33, ∃ x, π x = y := fun y => ⟨σ y, h2 y⟩
    show sumFin (fun k => sumFin (fun u : Fin 3 =>
        if G.S (π i) (π k) u = true ∧ G.S (π k) (π j) (s - u) = true then 1 else 0)) +
      (if G.S (π i) (π j) s = true then 1 else 0) =
      2 + 12 * (if i = j ∧ s = 0 then 1 else 0)
    rw [sumFin_comp_eq π hinj hsurj (fun k => sumFin (fun u : Fin 3 =>
        if G.S (π i) k u = true ∧ G.S k (π j) (s - u) = true then 1 else 0))]
    have he := G.eq (π i) (π j) s
    have hδ : (π i = π j ∧ s = 0) ↔ (i = j ∧ s = 0) :=
      ⟨fun ⟨h1', h2'⟩ => ⟨hinj _ _ h1', h2'⟩, fun ⟨h1', h2'⟩ => ⟨congrArg π h1', h2'⟩⟩
    rw [if_congr_prop hδ] at he
    exact he

/-- Shift each orbit representative: `rep_j ↦ g^{c_j} rep_j`. -/
def shift (G : Z3FpfGroupRing) (c : Fin 33 → Fin 3) : Z3FpfGroupRing where
  S := fun i j s => G.S i j (s + c j - c i)
  sym := by
    intro i j s
    show G.S j i (s + c i - c j) = G.S i j (-s + c j - c i)
    rw [G.sym i j (s + c i - c j), fin3_neg_shift s (c i) (c j)]
  loopless := by
    intro i
    show G.S i i (0 + c i - c i) = false
    rw [fin3_zero_sub_self (c i)]
    exact G.loopless i
  diag := by
    intro i
    show G.S i i (1 + c i - c i) = G.S i i (2 + c i - c i)
    rw [fin3_add_sub_cancel (1 : Fin 3) (c i), fin3_add_sub_cancel (2 : Fin 3) (c i)]
    exact G.diag i
  deg := by
    intro i
    have hpt : ∀ (j : Fin 33) (s : Fin 3),
        (if G.S i j (s + c j - c i) = true then (1 : Nat) else 0) =
        (if G.S i j (s + (c j - c i)) = true then 1 else 0) := by
      intro j s
      rw [fin3_add_sub_assoc s (c j) (c i)]
    calc sumFin (fun j => sumFin (fun s : Fin 3 => if G.S i j (s + c j - c i) = true then 1 else 0))
        = sumFin (fun j => sumFin (fun s : Fin 3 => if G.S i j s = true then 1 else 0)) :=
          sumFin_congr (fun j =>
            (sumFin_congr (hpt j)).trans
              (sumFin_add3 (c j - c i)
                (fun s : Fin 3 => if G.S i j s = true then (1 : Nat) else 0)))
      _ = 14 := G.deg i
  eq := by
    intro i j s
    show sumFin (fun k => sumFin (fun u : Fin 3 =>
        if G.S i k (u + c k - c i) = true ∧ G.S k j (s - u + c j - c k) = true then 1 else 0)) +
      (if G.S i j (s + c j - c i) = true then 1 else 0) =
      2 + 12 * (if i = j ∧ s = 0 then 1 else 0)
    have hδ : (i = j ∧ s + c j - c i = 0) ↔ (i = j ∧ s = 0) := by
      constructor
      · rintro ⟨rfl, hs⟩
        rw [fin3_add_sub_cancel] at hs
        exact ⟨rfl, hs⟩
      · rintro ⟨rfl, hs⟩
        rw [hs]
        exact ⟨rfl, fin3_zero_sub_self _⟩
    have hinner : ∀ k : Fin 33,
        sumFin (fun u : Fin 3 => if G.S i k (u + c k - c i) = true ∧
            G.S k j (s - u + c j - c k) = true then (1 : Nat) else 0) =
        sumFin (fun u : Fin 3 => if G.S i k u = true ∧
            G.S k j ((s + c j - c i) - u) = true then 1 else 0) := by
      intro k
      have hpt : ∀ u : Fin 3,
          (if G.S i k (u + c k - c i) = true ∧ G.S k j (s - u + c j - c k) = true
            then (1 : Nat) else 0) =
          (if G.S i k (u + (c k - c i)) = true ∧
              G.S k j ((s + c j - c i) - (u + (c k - c i))) = true then 1 else 0) := by
        intro u
        rw [fin3_add_sub_assoc u (c k) (c i)]
        have h2 : s - u + c j - c k = (s + c j - c i) - (u + (c k - c i)) := by
          rw [fin3_sub_shift s u (c j) (c k) (c i), fin3_add_sub_assoc u (c k) (c i)]
        rw [h2]
      rw [sumFin_congr hpt]
      exact sumFin_add3 (c k - c i) (fun u : Fin 3 =>
        if G.S i k u = true ∧ G.S k j ((s + c j - c i) - u) = true then (1 : Nat) else 0)
    rw [sumFin_congr hinner]
    have he := G.eq i j (s + c j - c i)
    rw [if_congr_prop hδ] at he
    exact he

/-- The orbit matrix sees the permutation directly. -/
theorem perm_B (G : Z3FpfGroupRing) (π σ : Fin 33 → Fin 33)
    (h1 : ∀ i, σ (π i) = i) (h2 : ∀ i, π (σ i) = i) (i j : Fin 33) :
    (G.perm π σ h1 h2).toOrbitMatrix.B i j = G.toOrbitMatrix.B (π i) (π j) := rfl

/-- Shifts preserve every orbit-matrix entry. -/
theorem shift_B (G : Z3FpfGroupRing) (c : Fin 33 → Fin 3) (i j : Fin 33) :
    (G.shift c).toOrbitMatrix.B i j = G.toOrbitMatrix.B i j := by
  show sumFin (fun s : Fin 3 => if G.S i j (s + c j - c i) = true then 1 else 0) =
    sumFin (fun s : Fin 3 => if G.S i j s = true then 1 else 0)
  have hpt : ∀ s : Fin 3,
      (if G.S i j (s + c j - c i) = true then (1 : Nat) else 0) =
      (if G.S i j (s + (c j - c i)) = true then 1 else 0) := by
    intro s
    rw [fin3_add_sub_assoc s (c j) (c i)]
  rw [sumFin_congr hpt]
  exact sumFin_add3 (c j - c i) (fun s : Fin 3 => if G.S i j s = true then (1 : Nat) else 0)

#print axioms Z3FpfGroupRing.perm
#print axioms Z3FpfGroupRing.shift
#print axioms Z3FpfGroupRing.perm_B
#print axioms Z3FpfGroupRing.shift_B
#print axioms Z3FpfGroupRing.sumFin_add3

end Z3FpfGroupRing
end Matrix99
