/-
  Conway/Z3Fixed3NonExistence.lean
  Formal Architecture and Reduction for Non-Existence of Order-3 Automorphisms
  with 3 Fixed Points on Conway's 99-Graph.

  Mathematical background (Crnkovic-Maksimovic 2020, Behbahani-Lam 2011):
  - 99 vertices partition into 3 fixed points and (99-3)/3 = 32 orbits of size 3.
  - Total 35 orbits.

  Taxonomy Status:
  - `conway_z3_fixed3_induces_orbit_matrix`: PROVED (0 sorry, [propext, Quot.sound]).
  - `conway_no_z3_fixed3_from_orbit_matrix_reduction`: PROVED conditional transfer (0 sorry, 0 axioms).
  - `conway_no_z3_fixed3_automorphism_of_orbit_matrix_nonexistence`: PROVED (0 sorry, [propext, Quot.sound]).
  - `z3_fixed3_orbit_matrix_nonexistence`: COMPILED (0 sorry, [Matrix99.z3_fixed3_orbit_matrix_certificate_obstruction]).
  - `conway_no_z3_fixed3_automorphism`: COMPILED (0 sorry, [Matrix99.z3_fixed3_orbit_matrix_certificate_obstruction]).
-/

import Conway.Matrix
import Conway.Z3Fixed3OrbitMatrix
import Conway.Z3OrbitEnumeration
import Conway.OrbitQuotient
import Conway.OrbitReindex

namespace Matrix99

open ConwayOrbit

def IsZ3Fixed3Automorphism (A : Matrix99 Nat) (g : Fin 99 → Fin 99) : Prop :=
  Function.Bijective g ∧
  g^[3] = id ∧
  (∃ (f1 f2 f3 : Fin 99), f1 ≠ f2 ∧ f2 ≠ f3 ∧ f1 ≠ f3 ∧
    g f1 = f1 ∧ g f2 = f2 ∧ g f3 = f3 ∧
    (∀ i, g i = i → i = f1 ∨ i = f2 ∨ i = f3)) ∧
  (∀ i j, A (g i) (g j) = A i j)

def HasZ3Fixed3Symmetry : Prop :=
  ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (g : Fin 99 → Fin 99), IsZ3Fixed3Automorphism A g

theorem hasZ3Fixed3Symmetry_iff :
    HasZ3Fixed3Symmetry ↔
    (∃ (A : Matrix99 Nat), ConwayAdj A ∧
      ∃ (g : Fin 99 → Fin 99),
        (Function.Bijective g) ∧
        (g^[3] = id) ∧
        (∃ (f1 f2 f3 : Fin 99), f1 ≠ f2 ∧ f2 ≠ f3 ∧ f1 ≠ f3 ∧
          g f1 = f1 ∧ g f2 = f2 ∧ g f3 = f3 ∧
          (∀ i, g i = i → i = f1 ∨ i = f2 ∨ i = f3)) ∧
        (∀ i j, A (g i) (g j) = A i j)) := by
  dsimp [HasZ3Fixed3Symmetry, IsZ3Fixed3Automorphism]
  rfl

def HasZ3Fixed3OrbitMatrix : Prop :=
  Nonempty Z3Fixed3OrbitMatrix

theorem conway_z3_fixed3_induces_orbit_matrix :
    HasZ3Fixed3Symmetry → HasZ3Fixed3OrbitMatrix := by
  intro ⟨A, hA, g, hg⟩
  have _hbij := hg.1
  have h3 := hg.2.1
  obtain ⟨f1, f2, f3, h12, h23, h13, hf1, hf2, hf3, hfixed_all⟩ := hg.2.2.1
  have hpres := hg.2.2.2
  let r := z3Fixed3OrbitIndexing A g h3 hpres f1 f2 f3 h12 h23 h13 hf1 hf2 hf3 hfixed_all
  have hw := z3Fixed3_orbit_sizes A g h3 hpres f1 f2 f3 h12 h23 h13 hf1 hf2 hf3 hfixed_all
  have hpoly : ∀ u v, sumFin (fun w => A u w * A w v) + A u v =
      12 * (if u = v then 1 else 0) + 2 := by
    intro u v
    rw [sumFin_eq_foldl]
    exact (hA.2.2.2 u v).trans (conway_target_formula u v)
  have h_even_all : ∀ i : Fin 35, r.matrix i i % 2 = 0 := by
    intro i
    have h := (cyclicEquitableData 3 (by decide) A g h3 hpres).diagonal_even_of_odd_size
      hA.2.1 hA.1 (r.rep i)
    have hodd : r.sizes i % 2 = 1 := by
      rw [hw i]
      unfold z3Fixed3OrbitSizes
      split <;> decide
    have heven := h hodd
    change r.matrix i i % 2 = 0 at heven
    exact heven
  have hB : Z3Fixed3OrbitMatrix := {
    B := r.matrix
    row_sum := by
      intro i
      change (List.finRange 35).foldl (fun acc j => acc + r.matrix i j) 0 = 14
      rw [← sumFin_eq_foldl]
      exact r.row_sum 14 (conway_row_sum A hA) i
    degree_symmetry := by
      intro i j
      have h := r.weighted_symmetry hA.2.1 i j
      rw [hw i, hw j] at h
      exact h
    srg_equation := by
      intro i j
      have h := r.quotient_equation 12 2 hpoly i j
      rw [hw j] at h
      rw [sumFin_eq_foldl] at h
      change mul35 r.matrix r.matrix i j + r.matrix i j = 12 * delta35 i j + 2 * z3Fixed3OrbitSizes j
      unfold delta35
      exact h
    diag_parity := h_even_all
    diag_fixed := by
      intro i hi
      have hle := (cyclicEquitableData 3 (by decide) A g h3 hpres).entry_le_size
        (fun u v => by rcases hA.2.2.1 u v with h0 | h1 <;> omega) (r.rep i) (r.rep i)
      change r.matrix i i ≤ r.sizes i at hle
      rw [hw i] at hle
      unfold z3Fixed3OrbitSizes at hle
      rw [if_pos hi] at hle
      have heven := h_even_all i
      omega
    entry_bound := by
      intro i j
      have hle := (cyclicEquitableData 3 (by decide) A g h3 hpres).entry_le_size
        (fun u v => by rcases hA.2.2.1 u v with h0 | h1 <;> omega) (r.rep i) (r.rep j)
      change r.matrix i j ≤ r.sizes j at hle
      rw [hw j] at hle
      exact hle
  }
  exact ⟨hB⟩

theorem conway_no_z3_fixed3_from_orbit_matrix_reduction
    (h_red : HasZ3Fixed3Symmetry → HasZ3Fixed3OrbitMatrix)
    (h_no_mat : ¬ HasZ3Fixed3OrbitMatrix) :
    ¬ HasZ3Fixed3Symmetry := by
  intro h_sym
  exact h_no_mat (h_red h_sym)

/--
  Conditional exclusion of order-3 automorphisms with 3 fixed points
  from non-existence of 35x35 orbit matrix.
  Status: PROVED (0 sorry, [propext, Quot.sound]).
-/
theorem conway_no_z3_fixed3_automorphism_of_orbit_matrix_nonexistence
    (h_no_mat : ¬ HasZ3Fixed3OrbitMatrix) :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (g : Fin 99 → Fin 99),
      (Function.Bijective g) ∧
      (g^[3] = id) ∧
      (∃ (f1 f2 f3 : Fin 99), f1 ≠ f2 ∧ f2 ≠ f3 ∧ f1 ≠ f3 ∧
        g f1 = f1 ∧ g f2 = f2 ∧ g f3 = f3 ∧
        (∀ i, g i = i → i = f1 ∨ i = f2 ∨ i = f3)) ∧
      (∀ i j, A (g i) (g j) = A i j) := by
  have h_not : ¬ HasZ3Fixed3Symmetry :=
    conway_no_z3_fixed3_from_orbit_matrix_reduction
      conway_z3_fixed3_induces_orbit_matrix
      h_no_mat
  intro h_ex
  rw [← hasZ3Fixed3Symmetry_iff] at h_ex
  exact h_not h_ex

/--
  Computational / Algebraic non-existence of 35x35 orbit matrix with 3 fixed points,
  certified by verified CaDiCaL + drat-trim DRAT refutation of the 35x35 orbit matrix
  search space under Conway spectral parameters (Tr(B) ∈ {4, 18, 32, 46, 60})
  and K_4-free exclusion (see proofs/z3_fixed3/audit_report.md).
  Status: COMPILED (relies on z3_fixed3_orbit_matrix_certificate_obstruction).
-/
axiom z3_fixed3_orbit_matrix_certificate_obstruction :
    ¬ HasZ3Fixed3OrbitMatrix

/--
  Computational / Algebraic non-existence of 35x35 orbit matrix with 3 fixed points.
  Status: COMPILED (relies on z3_fixed3_orbit_matrix_certificate_obstruction).
-/
theorem z3_fixed3_orbit_matrix_nonexistence :
    ¬ HasZ3Fixed3OrbitMatrix :=
  z3_fixed3_orbit_matrix_certificate_obstruction

/--
  Theorem (Crnkovic-Maksimovic 2020, Behbahani-Lam 2011):
  Strongly regular graph srg(99, 14, 1, 2) cannot admit
  an automorphism group isomorphic to Z_3 with 3 fixed points.
  Status: COMPILED (0 sorry, relies on z3_fixed3_orbit_matrix_certificate_obstruction).
-/
theorem conway_no_z3_fixed3_automorphism :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (g : Fin 99 → Fin 99),
      (Function.Bijective g) ∧
      (g^[3] = id) ∧
      (∃ (f1 f2 f3 : Fin 99), f1 ≠ f2 ∧ f2 ≠ f3 ∧ f1 ≠ f3 ∧
        g f1 = f1 ∧ g f2 = f2 ∧ g f3 = f3 ∧
        (∀ i, g i = i → i = f1 ∨ i = f2 ∨ i = f3)) ∧
      (∀ i j, A (g i) (g j) = A i j) :=
  conway_no_z3_fixed3_automorphism_of_orbit_matrix_nonexistence
    z3_fixed3_orbit_matrix_nonexistence

#print axioms hasZ3Fixed3Symmetry_iff
#print axioms conway_z3_fixed3_induces_orbit_matrix
#print axioms conway_no_z3_fixed3_from_orbit_matrix_reduction
#print axioms conway_no_z3_fixed3_automorphism_of_orbit_matrix_nonexistence
#print axioms z3_fixed3_orbit_matrix_nonexistence
#print axioms conway_no_z3_fixed3_automorphism

end Matrix99
