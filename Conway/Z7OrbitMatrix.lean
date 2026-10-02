/-
  Conway/Z7OrbitMatrix.lean
  Formalization of the 15x15 Orbit Quotient Matrix and Spectral Trace for Z_7
  in Conway's 99-Graph (srg(99, 14, 1, 2)).

  Mathematical background (Cesarz & Woldar 2025, Behbahani & Lam 2011):
  Let G = Aut(Γ) be the automorphism group of a putative strongly regular graph
  with parameters srg(99, 14, 1, 2).
  1. Orbit Structure under Z_7 (Lemma 2.2):
     Since |V| = 99 ≡ 1 (mod 7), any automorphism s of prime order 7 must fix
     at least one vertex x_0.
     In Γ_1(x_0), the action is fixed-point-free, yielding 2 orbits of size 7.
     In Γ_2(x_0), no vertex can be fixed (as μ = 2 and |s| = 7 is odd),
     yielding 12 orbits of size 7.
     The action of ⟨s⟩ on V(Γ) partitions the 99 vertices into 15 orbits:
     n = [1, 7, 7, ..., 7] with n_0 = 1 and n_1 = ... = n_14 = 7.

  2. 15x15 Orbit Quotient Matrix B:
     Entries B_{ij} represent the number of neighbors in orbit j of any vertex in orbit i.
     - Row sum regularity: ∑_j B_{ij} = k = 14.
     - Degree-weighted symmetry: n_i B_{ij} = n_j B_{ji}.
     - Strongly regular quotient equation: (B^2)_{ij} + B_{ij} = 12 δ_{ij} + 2 n_j.
     - Diagonal parity: B_{ii} ∈ {0, 2} for all i.
     - Orbit 0 (fixed vertex): B_{00} = 0, B_{01} = 7, B_{02} = 7, B_{0j} = 0 for j ≥ 3.
     - Orbits 1, 2 (subgraph Γ_1): B_{11} = 0, B_{22} = 0, B_{12} = 1, B_{21} = 1.

  3. Spectral Trace Theorem:
     The spectrum of the full adjacency matrix is {14^1, 3^54, (-4)^44}.
     The characteristic polynomial of B divides that of A, so the spectrum of B
     is {14^1, 3^a, (-4)^(14-a)} for some integer a with 0 ≤ a ≤ 14.
     - Spectral trace: Tr(B) = 14 + 3a - 4(14 - a) = 7a - 42.
     - Topological trace: Tr(B) = ∑_{i=0}^14 B_{ii}.
     - Since B_{00} = 0, B_{11} = 0, B_{22} = 0: Tr(B) = ∑_{i=3}^14 B_{ii}.
     - Under Lemma 4.12 (all B_{ii} = 0): 7a - 42 = 0 ⟹ 7a = 42 ⟹ a = 6,
       uniquely forcing the spectrum {14^1, 3^6, (-4)^8}.

  All theorems in this file are proved with 0 sorry, 0 sorryAx,
  and depend exclusively on standard Lean 4 axioms [propext, Quot.sound].
-/

import Conway.Basic
import Conway.Matrix

namespace Matrix99

/-! ## 1. Orbit Sizes and Indexing for Z_7 Action -/

abbrev Fin15 := Fin 15

/--
  Orbit sizes for the ⟨s⟩ ≅ Z_7 action on Conway-99:
  - Orbit 0 has size 1 (the unique fixed vertex x_0).
  - Orbits 1..14 have size 7 (2 orbits in Γ_1, 12 orbits in Γ_2).
-/
def z7OrbitSizes : Fin 15 → Nat :=
  fun i => if i.val == 0 then 1 else 7

/-- Sum of the 15 orbit sizes is 1 + 14 * 7 = 99 vertices. -/
theorem z7_orbit_sizes_sum :
    (List.finRange 15).foldl (fun acc i => acc + z7OrbitSizes i) 0 = 99 := by
  decide

/-! ## 2. Matrix Arithmetic on 15x15 Quotient Matrices -/

def Matrix15 (α : Type) := Fin 15 → Fin 15 → α

/-- Matrix multiplication for 15x15 matrices over Nat. -/
def mul15 (A B : Fin 15 → Fin 15 → Nat) : Fin 15 → Fin 15 → Nat :=
  fun i j => (List.finRange 15).foldl (fun acc k => acc + (A i k) * (B k j)) 0

/-- Row sum of the 15x15 matrix B at row i. -/
def rowSum15 (B : Fin 15 → Fin 15 → Nat) (i : Fin 15) : Nat :=
  (List.finRange 15).foldl (fun acc j => acc + B i j) 0

/-- Kronecker delta for Fin 15. -/
def delta15 (i j : Fin 15) : Nat :=
  if i = j then 1 else 0

/-- Topological trace: sum of diagonal entries B_{ii} for i ∈ [0, 14]. -/
def topologicalTrace (B : Fin 15 → Fin 15 → Nat) : Nat :=
  (List.finRange 15).foldl (fun acc i => acc + B i i) 0

/-- Partial diagonal sum over Γ_2(x_0): sum of B_{ii} for i ∈ [3, 14]. -/
def diagSumGamma2 (B : Fin 15 → Fin 15 → Nat) : Nat :=
  (List.drop 3 (List.finRange 15)).foldl (fun acc i => acc + B i i) 0

/-! ## 3. Definition of the Z_7 Orbit Quotient Matrix Structure -/

/--
  The 15x15 Orbit Quotient Matrix structure for Conway-99 under Z_7.
  Encodes all algebraic and combinatorial parameters of srg(99, 14, 1, 2)
  condensed by the action of an automorphism of order 7.
-/
structure Z7OrbitMatrix where
  /-- Matrix entries representing average edge counts from orbit i to orbit j. -/
  B : Fin 15 → Fin 15 → Nat
  /-- Row sum regularity: each vertex in orbit i has degree k = 14. -/
  row_sum : ∀ i : Fin 15, rowSum15 B i = 14
  /-- Degree-weighted symmetry (equitable partition condition): n_i * B_{ij} = n_j * B_{ji}. -/
  degree_symmetry : ∀ i j : Fin 15, z7OrbitSizes i * B i j = z7OrbitSizes j * B j i
  /-- Strongly regular quotient equation: (B^2)_{ij} + B_{ij} = 12 * delta_{ij} + 2 * n_j. -/
  srg_equation : ∀ i j : Fin 15, mul15 B B i j + B i j = 12 * delta15 i j + 2 * z7OrbitSizes j
  /-- Diagonal parity: internal orbit valencies satisfy B_{ii} ∈ {0, 2}. -/
  diag_parity : ∀ i : Fin 15, B i i = 0 ∨ B i i = 2
  /-- Orbit 0 is the fixed vertex: no self-loops, B_{00} = 0. -/
  diag_zero : B 0 0 = 0
  /-- Orbits 1 and 2 are in Γ_1(x_0): no internal edges, B_{11} = 0 and B_{22} = 0. -/
  diag_one : B 1 1 = 0
  diag_two : B 2 2 = 0

/-! ## 4. Trace Splitting and Foldl Lemmas -/

/--
  Topological trace decomposes into:
  Tr(B) = B_{00} + B_{11} + B_{22} + ∑_{i=3}^14 B_{ii}.
  When B_{00} = 0, B_{11} = 0, B_{22} = 0, Tr(B) = diagSumGamma2 B.
-/
theorem topologicalTrace_eq_diagSumGamma2 (B : Fin 15 → Fin 15 → Nat)
    (h0 : B 0 0 = 0) (h1 : B 1 1 = 0) (h2 : B 2 2 = 0) :
    topologicalTrace B = diagSumGamma2 B := by
  have hsplit : List.finRange 15 = (0 : Fin 15) :: (1 : Fin 15) :: (2 : Fin 15) :: List.drop 3 (List.finRange 15) := rfl
  dsimp [topologicalTrace, diagSumGamma2]
  rw [hsplit]
  dsimp [List.foldl]
  rw [h0, h1, h2]
  rfl

/-- Helper lemma: folding addition over a list of zeros preserves the accumulator. -/
theorem foldl_add_zero {α : Type} (l : List α) (f : α → Nat) (h : ∀ x ∈ l, f x = 0) (acc : Nat) :
    l.foldl (fun a x => a + f x) acc = acc := by
  induction l generalizing acc with
  | nil => rfl
  | cons x xs ih =>
    dsimp [List.foldl]
    have hx : f x = 0 := h x (List.Mem.head xs)
    rw [hx, Nat.add_zero]
    exact ih (fun y hy => h y (List.Mem.tail x hy)) acc

/-- If all diagonal entries are zero, the topological trace is 0. -/
theorem topologicalTrace_eq_zero_of_diag_zero (B : Fin 15 → Fin 15 → Nat)
    (h_all : ∀ i : Fin 15, B i i = 0) :
    topologicalTrace B = 0 := by
  dsimp [topologicalTrace]
  apply foldl_add_zero
  intro x _hx
  exact h_all x

/-- If all diagonal entries are zero, the Γ_2 diagonal sum is 0. -/
theorem diagSumGamma2_eq_zero_of_diag_zero (B : Fin 15 → Fin 15 → Nat)
    (h_all : ∀ i : Fin 15, B i i = 0) :
    diagSumGamma2 B = 0 := by
  dsimp [diagSumGamma2]
  apply foldl_add_zero
  intro x _hx
  exact h_all x

/-- Helper lemma: folding addition of even terms preserves evenness. -/
theorem foldl_even (l : List (Fin 15)) (B : Fin 15 → Fin 15 → Nat)
    (h_even : ∀ i ∈ l, B i i % 2 = 0) (acc : Nat) (hacc : acc % 2 = 0) :
    (l.foldl (fun a i => a + B i i) acc) % 2 = 0 := by
  induction l generalizing acc with
  | nil => exact hacc
  | cons x xs ih =>
    dsimp [List.foldl]
    have hx : B x x % 2 = 0 := h_even x (List.Mem.head xs)
    have h_next_even : (acc + B x x) % 2 = 0 := by omega
    exact ih (fun y hy => h_even y (List.Mem.tail x hy)) (acc + B x x) h_next_even

/-- Parity theorem: diagSumGamma2 is always even under the diagonal parity condition. -/
theorem diagSumGamma2_even (B : Fin 15 → Fin 15 → Nat)
    (h_parity : ∀ i : Fin 15, B i i = 0 ∨ B i i = 2) :
    diagSumGamma2 B % 2 = 0 := by
  dsimp [diagSumGamma2]
  apply foldl_even
  · intro i _hi
    rcases h_parity i with h0 | h2
    · rw [h0]
    · rw [h2]
  · rfl

/-! ## 5. Spectral Trace Formalization -/

/--
  Spectral trace formula for quotient matrix B with multiplicity `a` of eigenvalue 3.
  Eigenvalues: 14 with multiplicity 1, 3 with multiplicity a, -4 with multiplicity (14 - a).
  Tr(B) = 14 + 3a - 4(14 - a).
-/
def spectralTrace (a : Int) : Int :=
  14 + 3 * a - 4 * (14 - a)

/-- Simplified linear form: Tr(B) = 7a - 42. -/
theorem spectral_trace_eq (a : Int) :
    spectralTrace a = 7 * a - 42 := by
  dsimp [spectralTrace]
  omega

/--
  Spectral trace theorem:
  Equating the spectral trace to the topological trace when B_{00} = B_{11} = B_{22} = 0
  yields 7a - 42 = ∑_{i=3}^14 B_{ii}.
-/
theorem z7_orbit_spectral_trace_eq_diagSum (B : Fin 15 → Fin 15 → Nat) (a : Int)
    (h0 : B 0 0 = 0) (h1 : B 1 1 = 0) (h2 : B 2 2 = 0)
    (h_bal : spectralTrace a = (topologicalTrace B : Int)) :
    7 * a - 42 = (diagSumGamma2 B : Int) := by
  have hspec : spectralTrace a = 7 * a - 42 := spectral_trace_eq a
  have htop : topologicalTrace B = diagSumGamma2 B :=
    topologicalTrace_eq_diagSumGamma2 B h0 h1 h2
  rw [hspec] at h_bal
  rw [htop] at h_bal
  exact h_bal

/-- Modular constraint: any integer trace sum S = 7a - 42 is divisible by 7. -/
theorem trace_sum_mod7 (a : Int) (S : Int) (h : 7 * a - 42 = S) :
    S % 7 = 0 := by
  omega

/--
  Algebraic trace constraint:
  If S = ∑_{i=3}^14 B_{ii} satisfies 0 ≤ S ≤ 24, S is even, and S % 7 = 0,
  then necessarily S = 0 or S = 14.
-/
theorem trace_sum_candidates (S : Int) (h_ge : 0 ≤ S) (h_le : S ≤ 24)
    (h_even : S % 2 = 0) (h_mod7 : S % 7 = 0) :
    S = 0 ∨ S = 14 := by
  omega

/--
  If the trace is 0, the multiplicity `a` of eigenvalue 3 is uniquely forced to 6:
  7a - 42 = 0 ⟹ 7a = 42 ⟹ a = 6.
-/
theorem unique_multiplicity_of_zero_trace (a : Int)
    (h_trace : spectralTrace a = 0) :
    a = 6 := by
  have h := spectral_trace_eq a
  rw [h] at h_trace
  omega

/--
  Unique spectrum of quotient matrix B when trace is 0:
  Multiplicity of 3 is a = 6, and multiplicity of -4 is 14 - a = 8.
  Forced spectrum: {14^1, 3^6, (-4)^8}.
-/
theorem unique_spectrum_of_zero_trace (a : Int)
    (h_trace : spectralTrace a = 0) :
    a = 6 ∧ (14 - a) = 8 := by
  have ha : a = 6 := unique_multiplicity_of_zero_trace a h_trace
  subst ha
  decide

/--
  Theorem (Cesarz & Woldar 2025, Lemma 4.12):
  If all internal orbit degrees are zero (B_{ii} = 0 for all i),
  then the spectral trace equation forces uniquely:
  a = 6 (multiplicity of 3) and 14 - a = 8 (multiplicity of -4).
  Unique spectrum: {14^1, 3^6, (-4)^8}.
-/
theorem z7_orbit_unique_spectrum_of_lemma_4_12 (B : Fin 15 → Fin 15 → Nat) (a : Int)
    (h_all : ∀ i : Fin 15, B i i = 0)
    (h_bal : spectralTrace a = (topologicalTrace B : Int)) :
    a = 6 ∧ (14 - a) = 8 := by
  have htop_zero : topologicalTrace B = 0 := topologicalTrace_eq_zero_of_diag_zero B h_all
  have htrace_zero : spectralTrace a = 0 := by
    rw [h_bal, htop_zero]
    rfl
  exact unique_spectrum_of_zero_trace a htrace_zero

/-! ## 6. Structural Integration with Z7OrbitMatrix -/

/--
  Spectral assignment structure for a validated Z7OrbitMatrix:
  Associates the multiplicity `a` of eigenvalue 3 with the quotient matrix B.
-/
structure Z7OrbitSpectrum (M : Z7OrbitMatrix) (a : Int) where
  ha_bounds : 0 ≤ a ∧ a ≤ 14
  spectral_balance : spectralTrace a = (topologicalTrace M.B : Int)

/-- The trace equation specialized to a Z7OrbitMatrix instance. -/
theorem z7_orbit_spectrum_trace_equation (M : Z7OrbitMatrix) (a : Int)
    (spec : Z7OrbitSpectrum M a) :
    7 * a - 42 = (diagSumGamma2 M.B : Int) :=
  z7_orbit_spectral_trace_eq_diagSum M.B a M.diag_zero M.diag_one M.diag_two spec.spectral_balance

/--
  Unique spectrum theorem for a Z7OrbitMatrix satisfying Lemma 4.12:
  The spectrum of B is uniquely forced to {14^1, 3^6, (-4)^8}.
-/
theorem z7_orbit_spectrum_forced_by_lemma_4_12 (M : Z7OrbitMatrix) (a : Int)
    (spec : Z7OrbitSpectrum M a)
    (h_all_zero : ∀ i : Fin 15, M.B i i = 0) :
    a = 6 ∧ (14 - a) = 8 :=
  z7_orbit_unique_spectrum_of_lemma_4_12 M.B a h_all_zero spec.spectral_balance

end Matrix99
