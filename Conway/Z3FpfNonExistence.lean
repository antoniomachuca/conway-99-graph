/-
  Conway/Z3FpfNonExistence.lean
  Formal Architecture and Reduction for Non-Existence of
  Fixed-Point-Free Order-3 Automorphisms on Conway's 99-Graph.

  Mathematical background:
  - Behbahani–Lam (2011) examined order-3 automorphisms of srg(99, 14, 1, 2).
  - An order-3 automorphism with 0 fixed points partitions the 99 vertices into
    33 orbits of size 3.

  Taxonomy Status:
  - `conway_z3_fpf_induces_orbit_matrix`: PROVED (0 sorry, [propext, Quot.sound]).
  - `conway_no_z3_fpf_from_orbit_matrix_reduction`: PROVED conditional transfer.
  - `z3_fpf_orbit_matrix_nonexistence`: COMPILED placeholder (sorry).
  - `conway_no_z3_fpf_automorphism`: COMPILED (transitive sorryAx).
-/

import Conway.Matrix
import Conway.Z3FpfOrbitMatrix
import Conway.Z3OrbitEnumeration
import Conway.OrbitQuotient
import Conway.OrbitReindex

namespace Matrix99

open ConwayOrbit

def IsZ3FpfAutomorphism (A : Matrix99 Nat) (g : Fin 99 → Fin 99) : Prop :=
  Function.Bijective g ∧
  g^[3] = id ∧
  (∀ i, g i ≠ i) ∧
  (∀ i j, A (g i) (g j) = A i j)

def HasZ3FpfSymmetry : Prop :=
  ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (g : Fin 99 → Fin 99), IsZ3FpfAutomorphism A g

theorem hasZ3FpfSymmetry_iff :
    HasZ3FpfSymmetry ↔
    (∃ (A : Matrix99 Nat), ConwayAdj A ∧
      ∃ (g : Fin 99 → Fin 99),
        (Function.Bijective g) ∧
        (g^[3] = id) ∧
        (∀ i, g i ≠ i) ∧
        (∀ i j, A (g i) (g j) = A i j)) := by
  dsimp [HasZ3FpfSymmetry, IsZ3FpfAutomorphism]
  rfl

def HasZ3FpfOrbitMatrix : Prop :=
  Nonempty Z3FpfOrbitMatrix

theorem conway_z3_fpf_induces_orbit_matrix :
    HasZ3FpfSymmetry → HasZ3FpfOrbitMatrix := by
  intro ⟨A, hA, g, hg⟩
  have _hbij := hg.1
  have h3 := hg.2.1
  have hfpf := hg.2.2.1
  have hpres := hg.2.2.2
  let r := z3FpfOrbitIndexing A g h3 hpres hfpf
  have hw := z3Fpf_orbit_sizes A g h3 hpres hfpf
  have hpoly : ∀ u v, sumFin (fun w => A u w * A w v) + A u v =
      12 * (if u = v then 1 else 0) + 2 := by
    intro u v
    rw [sumFin_eq_foldl]
    exact (hA.2.2.2 u v).trans (conway_target_formula u v)
  have hB : Z3FpfOrbitMatrix := {
    B := r.matrix
    row_sum := by
      intro i
      change (List.finRange 33).foldl (fun acc j => acc + r.matrix i j) 0 = 14
      rw [← sumFin_eq_foldl]
      exact r.row_sum 14 (conway_row_sum A hA) i
    degree_symmetry := by
      intro i j
      have h := r.weighted_symmetry hA.2.1 i j
      rw [hw i, hw j] at h
      unfold z3FpfOrbitSizes at h
      omega
    srg_equation := by
      intro i j
      have h := r.quotient_equation 12 2 hpoly i j
      rw [hw j] at h
      unfold z3FpfOrbitSizes at h
      rw [sumFin_eq_foldl] at h
      change mul33 r.matrix r.matrix i j + r.matrix i j = 12 * delta33 i j + 6
      unfold delta33
      exact h
    diag_parity := by
      intro i
      have h := (cyclicEquitableData 3 (by decide) A g h3 hpres).diagonal_even_of_odd_size
        hA.2.1 hA.1 (r.rep i)
      have hodd : r.sizes i % 2 = 1 := by
        rw [hw i]
        unfold z3FpfOrbitSizes
        decide
      have heven := h hodd
      have hle := (cyclicEquitableData 3 (by decide) A g h3 hpres).entry_le_size
        (fun u v => by rcases hA.2.2.1 u v with h0 | h1 <;> omega) (r.rep i) (r.rep i)
      change r.matrix i i ≤ r.sizes i at hle
      rw [hw i] at hle
      unfold z3FpfOrbitSizes at hle
      change r.matrix i i % 2 = 0 at heven
      change r.matrix i i = 0 ∨ r.matrix i i = 2
      omega
    entry_bound := by
      intro i j
      have hle := (cyclicEquitableData 3 (by decide) A g h3 hpres).entry_le_size
        (fun u v => by rcases hA.2.2.1 u v with h0 | h1 <;> omega) (r.rep i) (r.rep j)
      change r.matrix i j ≤ r.sizes j at hle
      rw [hw j] at hle
      unfold z3FpfOrbitSizes at hle
      exact hle
  }
  exact ⟨hB⟩

theorem conway_no_z3_fpf_from_orbit_matrix_reduction
    (h_red : HasZ3FpfSymmetry → HasZ3FpfOrbitMatrix)
    (h_no_mat : ¬ HasZ3FpfOrbitMatrix) :
    ¬ HasZ3FpfSymmetry := by
  intro h_sym
  exact h_no_mat (h_red h_sym)

/--
  Computational / Algebraic non-existence of 33x33 FPF orbit matrix.
  Status: COMPILED placeholder (sorry).
-/
theorem z3_fpf_orbit_matrix_nonexistence :
    ¬ HasZ3FpfOrbitMatrix := by
  sorry

/--
  Theorem (Behbahani-Lam 2011):
  Strongly regular graph srg(99, 14, 1, 2) cannot admit
  a fixed-point-free automorphism of order 3.
-/
theorem conway_no_z3_fpf_automorphism :
  ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧
    ∃ (g : Fin 99 → Fin 99),
      (Function.Bijective g) ∧
      (g^[3] = id) ∧
      (∀ i, g i ≠ i) ∧
      (∀ i j, A (g i) (g j) = A i j) := by
  have h_not : ¬ HasZ3FpfSymmetry :=
    conway_no_z3_fpf_from_orbit_matrix_reduction
      conway_z3_fpf_induces_orbit_matrix
      z3_fpf_orbit_matrix_nonexistence
  intro h_ex
  rw [← hasZ3FpfSymmetry_iff] at h_ex
  exact h_not h_ex

#print axioms hasZ3FpfSymmetry_iff
#print axioms conway_z3_fpf_induces_orbit_matrix
#print axioms conway_no_z3_fpf_from_orbit_matrix_reduction
#print axioms z3_fpf_orbit_matrix_nonexistence
#print axioms conway_no_z3_fpf_automorphism

end Matrix99
