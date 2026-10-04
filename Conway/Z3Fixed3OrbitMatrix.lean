/-
  Conway/Z3Fixed3OrbitMatrix.lean
  Formalization of the 35x35 Orbit Quotient Matrix for Z_3 with 3 Fixed Points
  in Conway's 99-Graph (srg(99, 14, 1, 2)).

  Mathematical background (Crnkovic-Maksimovic 2020, Behbahani-Lam 2011):
  Under an automorphism g of order 3 with exactly 3 fixed points f_0, f_1, f_2:
  - The 3 fixed points induce a triangle K_3:
      B_{01} = B_{10} = B_{02} = B_{20} = B_{12} = B_{21} = 1.
  - The remaining 96 vertices partition into 96 / 3 = 32 orbits of size 3.
  - Total orbits: 3 + 32 = 35 orbits.
  - Orbit sizes: n_0 = n_1 = n_2 = 1, and n_3 = ... = n_{34} = 3.
  - Row sum regularity: ∑_j B_{ij} = 14.
  - Degree-weighted symmetry: n_i B_{ij} = n_j B_{ji}.
  - Strongly regular quotient equations: (B^2)_{ij} + B_{ij} = 12 δ_{ij} + 2 n_j.
  - Diagonal parity: B_{ii} is even for all i (since all orbit sizes are odd: 1 or 3).
  - Fixed vertices have no self-loops: B_{00} = B_{11} = B_{22} = 0.
-/

import Conway.Basic
import Conway.Matrix

namespace Matrix99

abbrev Fin35 := Fin 35

def z3Fixed3OrbitSizes : Fin 35 → Nat :=
  fun i => if i.val < 3 then 1 else 3

theorem z3_fixed3_orbit_sizes_sum :
    (List.finRange 35).foldl (fun acc i => acc + z3Fixed3OrbitSizes i) 0 = 99 := by
  decide

def Matrix35 (α : Type) := Fin 35 → Fin 35 → α

def mul35 (A B : Fin 35 → Fin 35 → Nat) : Fin 35 → Fin 35 → Nat :=
  fun i j => (List.finRange 35).foldl (fun acc k => acc + (A i k) * (B k j)) 0

def rowSum35 (B : Fin 35 → Fin 35 → Nat) (i : Fin 35) : Nat :=
  (List.finRange 35).foldl (fun acc j => acc + B i j) 0

def delta35 (i j : Fin 35) : Nat :=
  if i = j then 1 else 0

def topologicalTrace35 (B : Fin 35 → Fin 35 → Nat) : Nat :=
  (List.finRange 35).foldl (fun acc i => acc + B i i) 0

def diagSumGamma32 (B : Fin 35 → Fin 35 → Nat) : Nat :=
  (List.drop 3 (List.finRange 35)).foldl (fun acc i => acc + B i i) 0

structure Z3Fixed3OrbitMatrix where
  B : Fin 35 → Fin 35 → Nat
  row_sum : ∀ i : Fin 35, rowSum35 B i = 14
  degree_symmetry : ∀ i j : Fin 35, z3Fixed3OrbitSizes i * B i j = z3Fixed3OrbitSizes j * B j i
  srg_equation : ∀ i j : Fin 35, mul35 B B i j + B i j = 12 * delta35 i j + 2 * z3Fixed3OrbitSizes j
  diag_parity : ∀ i : Fin 35, B i i % 2 = 0
  diag_fixed : ∀ i : Fin 35, i.val < 3 → B i i = 0
  entry_bound : ∀ i j : Fin 35, B i j ≤ z3Fixed3OrbitSizes j

theorem topologicalTrace35_eq_diagSumGamma32 (B : Fin 35 → Fin 35 → Nat)
    (h0 : B 0 0 = 0) (h1 : B 1 1 = 0) (h2 : B 2 2 = 0) :
    topologicalTrace35 B = diagSumGamma32 B := by
  have hsplit : List.finRange 35 = (0 : Fin 35) :: (1 : Fin 35) :: (2 : Fin 35) :: List.drop 3 (List.finRange 35) := rfl
  dsimp [topologicalTrace35, diagSumGamma32]
  rw [hsplit]
  dsimp [List.foldl]
  rw [h0, h1, h2]
  rfl

theorem foldl35_even (l : List (Fin 35)) (B : Fin 35 → Fin 35 → Nat)
    (h_even : ∀ i ∈ l, B i i % 2 = 0) (acc : Nat) (hacc : acc % 2 = 0) :
    (l.foldl (fun a i => a + B i i) acc) % 2 = 0 := by
  induction l generalizing acc with
  | nil => exact hacc
  | cons x xs ih =>
    dsimp [List.foldl]
    have hx : B x x % 2 = 0 := h_even x (List.Mem.head xs)
    have h_next_even : (acc + B x x) % 2 = 0 := by omega
    exact ih (fun y hy => h_even y (List.Mem.tail x hy)) (acc + B x x) h_next_even

theorem diagSumGamma32_even (B : Fin 35 → Fin 35 → Nat)
    (h_parity : ∀ i : Fin 35, B i i % 2 = 0) :
    diagSumGamma32 B % 2 = 0 := by
  dsimp [diagSumGamma32]
  apply foldl35_even
  · intro i _hi
    exact h_parity i
  · rfl

def spectralTrace35 (a : Int) : Int :=
  14 + 3 * a - 4 * (34 - a)

theorem spectral_trace35_eq (a : Int) :
    spectralTrace35 a = 7 * a - 122 := by
  dsimp [spectralTrace35]
  omega

#print axioms z3_fixed3_orbit_sizes_sum
#print axioms topologicalTrace35_eq_diagSumGamma32
#print axioms foldl35_even
#print axioms diagSumGamma32_even
#print axioms spectral_trace35_eq

end Matrix99
