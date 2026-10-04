/-
  Conway/Z3FpfOrbitMatrix.lean
  Formalization of the 33x33 Orbit Quotient Matrix for Fixed-Point-Free Z_3
  in Conway's 99-Graph (srg(99, 14, 1, 2)).

  Mathematical background:
  Under a fixed-point-free automorphism g of order 3, the 99 vertices partition
  into 99 / 3 = 33 orbits of size 3.
  All orbit sizes are equal to 3.
  The 33x33 orbit quotient matrix B has:
  - Row sums: ∑_j B_{ij} = 14.
  - Degree symmetry: since n_i = n_j = 3, B_{ij} = B_{ji} (symmetric).
  - SRG quotient equations: (B^2)_{ij} + B_{ij} = 12 δ_{ij} + 6.
  - Diagonal parity: B_{ii} ∈ {0, 2} (each orbit is either 3K_1 or K_3).
  - Entry bounds: B_{ij} ≤ 3.
-/

import Conway.Basic
import Conway.Matrix

namespace Matrix99

abbrev Fin33 := Fin 33

def z3FpfOrbitSizes : Fin 33 → Nat :=
  fun _ => 3

theorem z3_fpf_orbit_sizes_sum :
    (List.finRange 33).foldl (fun acc i => acc + z3FpfOrbitSizes i) 0 = 99 := by
  decide

def Matrix33 (α : Type) := Fin 33 → Fin 33 → α

def mul33 (A B : Fin 33 → Fin 33 → Nat) : Fin 33 → Fin 33 → Nat :=
  fun i j => (List.finRange 33).foldl (fun acc k => acc + (A i k) * (B k j)) 0

def rowSum33 (B : Fin 33 → Fin 33 → Nat) (i : Fin 33) : Nat :=
  (List.finRange 33).foldl (fun acc j => acc + B i j) 0

def delta33 (i j : Fin 33) : Nat :=
  if i = j then 1 else 0

def topologicalTrace33 (B : Fin 33 → Fin 33 → Nat) : Nat :=
  (List.finRange 33).foldl (fun acc i => acc + B i i) 0

structure Z3FpfOrbitMatrix where
  B : Fin 33 → Fin 33 → Nat
  row_sum : ∀ i : Fin 33, rowSum33 B i = 14
  degree_symmetry : ∀ i j : Fin 33, B i j = B j i
  srg_equation : ∀ i j : Fin 33, mul33 B B i j + B i j = 12 * delta33 i j + 6
  diag_parity : ∀ i : Fin 33, B i i = 0 ∨ B i i = 2
  entry_bound : ∀ i j : Fin 33, B i j ≤ 3

theorem foldl33_even (l : List (Fin 33)) (B : Fin 33 → Fin 33 → Nat)
    (h_even : ∀ i ∈ l, B i i % 2 = 0) (acc : Nat) (hacc : acc % 2 = 0) :
    (l.foldl (fun a i => a + B i i) acc) % 2 = 0 := by
  induction l generalizing acc with
  | nil => exact hacc
  | cons x xs ih =>
    dsimp [List.foldl]
    have hx : B x x % 2 = 0 := h_even x (List.Mem.head xs)
    have h_next_even : (acc + B x x) % 2 = 0 := by omega
    exact ih (fun y hy => h_even y (List.Mem.tail x hy)) (acc + B x x) h_next_even

theorem topologicalTrace33_even (B : Fin 33 → Fin 33 → Nat)
    (h_parity : ∀ i : Fin 33, B i i = 0 ∨ B i i = 2) :
    topologicalTrace33 B % 2 = 0 := by
  dsimp [topologicalTrace33]
  apply foldl33_even
  · intro i _hi
    rcases h_parity i with h0 | h2
    · rw [h0]
    · rw [h2]
  · rfl

def spectralTrace33 (a : Int) : Int :=
  14 + 3 * a - 4 * (32 - a)

theorem spectral_trace33_eq (a : Int) :
    spectralTrace33 a = 7 * a - 114 := by
  dsimp [spectralTrace33]
  omega

structure Z3FpfOrbitSpectrum (M : Z3FpfOrbitMatrix) (a : Int) where
  ha_bounds : 0 ≤ a ∧ a ≤ 32
  spectral_balance : spectralTrace33 a = (topologicalTrace33 M.B : Int)

theorem z3_fpf_orbit_spectrum_trace_equation (M : Z3FpfOrbitMatrix) (a : Int)
    (spec : Z3FpfOrbitSpectrum M a) :
    7 * a - 114 = (topologicalTrace33 M.B : Int) := by
  have h := spectral_trace33_eq a
  have hbal := spec.spectral_balance
  rw [h] at hbal
  exact hbal

#print axioms z3_fpf_orbit_sizes_sum
#print axioms foldl33_even
#print axioms topologicalTrace33_even
#print axioms spectral_trace33_eq
#print axioms z3_fpf_orbit_spectrum_trace_equation

end Matrix99
