import Conway.Z3FpfNonExistence
import Conway.Z3Fixed3NonExistence

namespace Z3QuotientTest

open Matrix99
open ConwayOrbit

theorem fpf_reduction_valid : Matrix99.HasZ3FpfSymmetry → Matrix99.HasZ3FpfOrbitMatrix :=
  Matrix99.conway_z3_fpf_induces_orbit_matrix

theorem fixed3_reduction_valid : Matrix99.HasZ3Fixed3Symmetry → Matrix99.HasZ3Fixed3OrbitMatrix :=
  Matrix99.conway_z3_fixed3_induces_orbit_matrix

#print axioms Matrix99.hasZ3FpfSymmetry_iff
#print axioms Matrix99.conway_z3_fpf_induces_orbit_matrix
#print axioms Matrix99.conway_no_z3_fpf_from_orbit_matrix_reduction
#print axioms Matrix99.z3_fpf_orbit_matrix_nonexistence
#print axioms Matrix99.conway_no_z3_fpf_automorphism

#print axioms Matrix99.hasZ3Fixed3Symmetry_iff
#print axioms Matrix99.conway_z3_fixed3_induces_orbit_matrix
#print axioms Matrix99.conway_no_z3_fixed3_from_orbit_matrix_reduction
#print axioms Matrix99.z3_fixed3_orbit_matrix_nonexistence
#print axioms Matrix99.conway_no_z3_fixed3_automorphism

#print axioms ConwayOrbit.active3Labels_length_fpf
#print axioms ConwayOrbit.enumerateZ3FpfOrbits
#print axioms ConwayOrbit.z3FpfOrbitIndexing
#print axioms ConwayOrbit.z3Fpf_orbit_sizes

#print axioms ConwayOrbit.active3Labels_length_fixed3
#print axioms ConwayOrbit.enumerateZ3Fixed3Orbits
#print axioms ConwayOrbit.z3Fixed3OrbitIndexing
#print axioms ConwayOrbit.z3Fixed3_orbit_sizes

end Z3QuotientTest
