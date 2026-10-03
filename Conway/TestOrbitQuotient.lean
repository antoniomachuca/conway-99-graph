import Conway.Z7NonExistence

namespace ConwayOrbitTest

open ConwayOrbit

def rookShift (u : Fin 9) : Fin 9 :=
  ⟨(u.val + 3) % 9, by omega⟩

def rookAdj (u v : Fin 9) : Nat :=
  if u ≠ v ∧ (u.val % 3 == v.val % 3 || u.val / 3 == v.val / 3) then 1 else 0

def rookData : EquitableData rookAdj :=
  cyclicEquitableData 3 (by decide) rookAdj rookShift
    (by funext u; exact (show ∀ v : Fin 9, (rookShift^[3]) v = v from by decide) u)
    (by decide)

theorem rook_labels : (List.finRange 9).map rookData.label = [0, 1, 2, 0, 1, 2, 0, 1, 2] := by decide
theorem rook_fiber_zero : fiberSize rookData.label 0 = 3 := by decide
theorem rook_fiber_one : fiberSize rookData.label 1 = 3 := by decide
theorem rook_fiber_two : fiberSize rookData.label 2 = 3 := by decide
theorem rook_diagonal : rookData.entry 0 0 = 2 := by decide
theorem rook_offdiag01 : rookData.entry 0 1 = 1 := by decide
theorem rook_offdiag12 : rookData.entry 1 2 = 1 := by decide
theorem rook_inactive_row : sumFin (rookData.entry 3) = 0 := by decide
theorem identity_labels : ∀ u : Fin 9, orbitLabel 1 id u = u := by decide

def starShift (u : Fin 8) : Fin 8 :=
  if u.val = 0 then 0 else ⟨u.val % 7 + 1, by omega⟩

def starAdj (u v : Fin 8) : Nat :=
  if (u.val = 0 ∧ v.val ≠ 0) ∨ (u.val ≠ 0 ∧ v.val = 0) then 1 else 0

def starData : EquitableData starAdj :=
  cyclicEquitableData 7 (by decide) starAdj starShift
    (by funext u; exact (show ∀ v : Fin 8, (starShift^[7]) v = v from by decide) u)
    (by decide)

theorem star_labels : (List.finRange 8).map starData.label = [0, 1, 1, 1, 1, 1, 1, 1] := by decide
theorem star_fixed_size : fiberSize starData.label 0 = 1 := by decide
theorem star_moving_size : fiberSize starData.label 1 = 7 := by decide
theorem star_forward : starData.entry 0 1 = 7 := by decide
theorem star_backward : starData.entry 1 0 = 1 := by decide

#print axioms ConwayOrbit.sumFin
#print axioms ConwayOrbit.SameOrbit
#print axioms ConwayOrbit.orbitLabel
#print axioms ConwayOrbit.cyclicEquitableData
#print axioms ConwayOrbit.EquitableData.row_sum
#print axioms ConwayOrbit.EquitableData.weighted_symmetry
#print axioms ConwayOrbit.EquitableData.quotient_equation
#print axioms Matrix99.sumFin_eq_foldl
#print axioms Matrix99.conway_target_formula
#print axioms Matrix99.conway_row_sum
#print axioms Matrix99.z7EquitableData
#print axioms Matrix99.conway_z7_quotient_row_sum
#print axioms Matrix99.conway_z7_quotient_weighted_symmetry
#print axioms Matrix99.conway_z7_quotient_equation
#print axioms Matrix99.conway_z7_induces_orbit_matrix
#print axioms Matrix99.conway_no_z7_automorphism
#print axioms rookData
#print axioms rook_labels
#print axioms rook_fiber_zero
#print axioms rook_fiber_one
#print axioms rook_fiber_two
#print axioms rook_diagonal
#print axioms rook_offdiag01
#print axioms rook_offdiag12
#print axioms rook_inactive_row
#print axioms identity_labels
#print axioms starData
#print axioms star_labels
#print axioms star_fixed_size
#print axioms star_moving_size
#print axioms star_forward
#print axioms star_backward

end ConwayOrbitTest
