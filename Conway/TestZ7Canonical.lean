import Conway.Z7NonExistence

namespace Z7CanonicalTest

open ConwayOrbit

def blockCycle (u : Fin 99) : Fin 99 :=
  if u.val = 0 then 0 else
    ⟨1 + 7 * ((u.val - 1) / 7) + u.val % 7, by omega⟩

theorem blockCycle_period : blockCycle^[7] = id := by
  funext u
  exact (show ∀ v : Fin 99, (blockCycle^[7]) v = v from by decide) u

theorem blockCycle_fixed_zero : blockCycle 0 = 0 := by decide

theorem blockCycle_unique_fixed : ∀ v : Fin 99, blockCycle v = v → v = 0 := by decide

theorem blockCycle_nontrivial : ∃ v : Fin 99, blockCycle v ≠ v := ⟨1, by decide⟩

def enumeration : Z7OrbitEnumeration blockCycle 0 1 8 :=
  enumerateZ7Orbits blockCycle blockCycle_period 0 1 8 blockCycle_fixed_zero blockCycle_unique_fixed
    (by decide) (by decide) (by decide) (by decide) (by decide)

theorem enumeration_values : (List.finRange 15).map enumeration.rep =
    [0, 1, 8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92] := by decide

set_option maxRecDepth 4096 in
theorem enumeration_fixed_size : fiberSize (orbitLabel 7 blockCycle) (enumeration.rep 0) = 1 := by
  decide

set_option maxRecDepth 4096 in
theorem enumeration_moving_size : fiberSize (orbitLabel 7 blockCycle) (enumeration.rep 1) = 7 := by
  decide

set_option maxRecDepth 4096 in
theorem identity_has_99_orbits : (active7Labels (id : Fin 99 → Fin 99)).length = 99 := by decide

#print axioms blockCycle
#print axioms blockCycle_period
#print axioms blockCycle_fixed_zero
#print axioms blockCycle_unique_fixed
#print axioms blockCycle_nontrivial
#print axioms enumeration
#print axioms enumeration_values
#print axioms enumeration_fixed_size
#print axioms enumeration_moving_size
#print axioms identity_has_99_orbits

theorem graph_to_canonical_matrix : Matrix99.HasZ7Symmetry → Matrix99.HasZ7OrbitMatrix :=
  Matrix99.conway_z7_induces_orbit_matrix

#print axioms graph_to_canonical_matrix
#print axioms Matrix99.conway_z7_induces_orbit_matrix
#print axioms Matrix99.rootedMatrixOfOrbitIndexing
#print axioms Matrix99.Z7RootedMatrix.canonicalize
#print axioms Matrix99.conway_period7_graph_frame
#print axioms Matrix99.conway_period7_unique_fixed
#print axioms Matrix99.z7_orbit_matrix_nonexistence
#print axioms Matrix99.conway_no_z7_automorphism

end Z7CanonicalTest
