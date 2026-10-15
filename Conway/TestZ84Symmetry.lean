import Conway.Z84Subconstituent
import Conway.Z84Relabel
import Conway.Z84Symmetry

namespace Matrix99

/-- Identity automorphism of M_val (7K2). -/
def id14 : Fin 14 → Fin 14 := id

theorem id14_isNbrAut : isNbrAut id14 = true := by
  decide +kernel

theorem id14_liftPerm84 (y : Fin 84) : liftPerm84 id14 y = y := by
  dsimp [id14, liftPerm84]
  exact mkPair84_fst84_snd84 y

/-- The fiber0 has exactly 12 vertices. -/
theorem test_fiber0_length : fiber0.length = 12 := fiber0_length

/-- The 11 partitions of 6 are valid and distinct. -/
theorem test_partitions6_count : Partitions6.length = 11 := partitions6_length
theorem test_partitions6_nodup : Partitions6.Nodup := partitions6_nodup
theorem test_partitions6_sum :
    Partitions6.all (fun p => p.foldl (· + ·) 0 == 6) = true := partitions6_sum

/-- All 11 canonical branch matchings are valid perfect matchings on the 12 fiber vertices. -/
theorem test_branch_matchings_valid :
    (List.finRange 11).all (fun i => isPerfectMatching12 (branchMatching i)) = true :=
  branchMatching_valid

/-- All 11 canonical branch matchings soundly induce the 11 partitions of 6. -/
theorem test_branch_matchings_partition_sound :
    (List.finRange 11).all (fun i =>
      cyclePartition (branchMatching i) == Partitions6[i.val]!) = true :=
  branchMatching_cyclePartition_sound

/-- The fiber matchings set contains exactly 10,395 matchings. -/
theorem test_fiber_matchings_length : FiberMatchings.length = 10395 :=
  fiber_matchings_length

/-- Full 11-branch orbit coverage holds for all matchings in FiberMatchings. -/
theorem test_fiber_matchings_orbit_coverage (m : List (Nat × Nat)) (hm : m ∈ FiberMatchings) :
    ∃ g : C2wrS6, isC2wrS6 g = true ∧ ∃ i : Fin 11, actMatching g m = branchMatching i :=
  fiber_matchings_orbit_coverage m hm

#print axioms Matrix99.block_A_conwayAdj_iff_residual84
#print axioms Matrix99.conway_exists_iff_residual84
#print axioms Matrix99.isNbrAut_M
#print axioms Matrix99.isNbrAut_B
#print axioms Matrix99.sigma99_bij
#print axioms Matrix99.block_A_relabel84
#print axioms Matrix99.residual84_relabel_of_nbrAut
#print axioms Matrix99.fiber0_length
#print axioms Matrix99.fiber0_eq_first12
#print axioms Matrix99.partitions6_length
#print axioms Matrix99.partitions6_nodup
#print axioms Matrix99.partitions6_sum
#print axioms Matrix99.branchMatching_valid
#print axioms Matrix99.branchMatching_cyclePartition_sound
#print axioms Matrix99.fiber_matchings_orbit_coverage
#print axioms Matrix99.fiber_matchings_length

end Matrix99
