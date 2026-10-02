import Conway.Matrix
import Conway.Z2Classification
import Conway.CesarzWoldarTheorems
import Conway.GrandClassification
import Conway.Z7OrbitMatrix
import Conway.Z7NonExistence

namespace Matrix99

def testA : Matrix99 Nat := fun _ _ => 0

#eval mul testA testA 0 0

#print axioms conway_z2_f5_case_a_spectral_contradiction
#print axioms conway_z2_f5_case_b_spectral_contradiction
#print axioms conway_z2_f5_spectral_arithmetic_contradiction
#print axioms conway_z2_f5_spectral_formula_contradiction
#print axioms conway_z2_f5_eps1_candidates
#print axioms conway_z2_f5_case_a_refutation
#print axioms conway_z2_f5_case_b_refutation
#print axioms conway_no_z2_f5_case_a_automorphism
#print axioms conway_no_z2_f5_case_b_automorphism
#print axioms conway_no_z2_f5_automorphism
#print axioms conway_no_z2_f5_formula_automorphism
#print axioms conway_no_z2_f7_automorphism
#print axioms conway_no_z2_f7_formula_automorphism

-- Cesarz & Woldar (2025) Key Analytical Theorems
#print axioms cesarz_woldar_thm_3_11_trace_int
#print axioms cesarz_woldar_thm_3_11_simplified_int
#print axioms cesarz_woldar_thm_3_11_linear_int
#print axioms cesarz_woldar_thm_3_11_mod7_eq
#print axioms cesarz_woldar_thm_3_11_modular_contradiction
#print axioms cesarz_woldar_order14_spectral_impossible
#print axioms cesarz_woldar_prop_4_14_parity_nat
#print axioms cesarz_woldar_prop_4_14_parity_int
#print axioms cesarz_woldar_prop_4_14_equation_5_nat
#print axioms cesarz_woldar_prop_4_14_even_nat
#print axioms cesarz_woldar_prop_4_14_orbit_partition_impossible
#print axioms cesarz_woldar_divisible_by_7_reduces_to_z7
#print axioms conway_no_order_14_analytical_trace_deduction
#print axioms conway_no_frob21_orbit_row4_deduction
#print axioms conway_divisible_by_7_excluded

-- Parity Rigidity Corollary (Corollary 1.3, Cesarz & Woldar 2025 + Crnković & Maksimović 2020)
#print axioms even_divides_six_and_not_six_eq_two
#print axioms conway_no_order_4_subgroup
#print axioms conway_no_order_4_when_order_two
#print axioms conway_no_dihedral_subgroup
#print axioms conway_no_even_order_gt_two
#print axioms conway_parity_rigidity
#print axioms conway_parity_rigidity_subgroup_bound
#print axioms conway_parity_rigidity_no_order_4
#print axioms conway_parity_rigidity_no_dihedral
#print axioms conway_parity_rigidity_not_divisible_by_6
#print axioms conway_parity_rigidity_no_order_14
#print axioms conway_parity_rigidity_deduction
#print axioms conway_no_order_4_group_deduction
#print axioms conway_no_dihedral_group_deduction

-- Z_7 Orbit Matrix and Trace Theorems (Conway/Z7OrbitMatrix.lean)
#print axioms z7_orbit_sizes_sum
#print axioms topologicalTrace_eq_diagSumGamma2
#print axioms foldl_add_zero
#print axioms topologicalTrace_eq_zero_of_diag_zero
#print axioms diagSumGamma2_eq_zero_of_diag_zero
#print axioms foldl_even
#print axioms diagSumGamma2_even
#print axioms spectral_trace_eq
#print axioms z7_orbit_spectral_trace_eq_diagSum
#print axioms trace_sum_mod7
#print axioms trace_sum_candidates
#print axioms unique_multiplicity_of_zero_trace
#print axioms unique_spectrum_of_zero_trace
#print axioms z7_orbit_unique_spectrum_of_lemma_4_12
#print axioms z7_orbit_spectrum_trace_equation
#print axioms z7_orbit_spectrum_forced_by_lemma_4_12

-- Z_7 Non-Existence and Orbit Reduction (Conway/Z7NonExistence.lean)
#print axioms hasZ7Symmetry_iff
#print axioms conway_no_z7_from_orbit_matrix_reduction
#print axioms conway_z7_induces_orbit_matrix
#print axioms z7_orbit_matrix_nonexistence
#print axioms conway_no_z7_automorphism
#print axioms conway_no_z7_from_spectrum_refutation

end Matrix99

