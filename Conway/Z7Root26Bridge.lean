import Conway.Z7Root26Semantics
import Conway.Z7Root26Arithmetic

namespace Matrix99.Z7Root26Model

private theorem finRange12_bridge :
    List.finRange 12 = [0,1,2,3,4,5,6,7,8,9,10,11] := by decide

theorem facts_of_exterior (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hrow : ∀ j, C 0 j = z7Root26Row j) :
    Facts (fun j => C j 11) := by
  have hr0 : C 0 0 = 2 := hrow 0
  have hr1 : C 0 1 = 0 := hrow 1
  have hr2 : C 0 2 = 1 := hrow 2
  have hr3 : C 0 3 = 1 := hrow 3
  have hr4 : C 0 4 = 1 := hrow 4
  have hr5 : C 0 5 = 1 := hrow 5
  have hr6 : C 0 6 = 0 := hrow 6
  have hr7 : C 0 7 = 0 := hrow 7
  have hr8 : C 0 8 = 1 := hrow 8
  have hr9 : C 0 9 = 1 := hrow 9
  have hr10 : C 0 10 = 1 := hrow 10
  have hr11 : C 0 11 = 3 := hrow 11
  have sy0 : C 11 0 = C 0 11 := hC.1 11 0
  have sy1 : C 11 1 = C 1 11 := hC.1 11 1
  have sy2 : C 11 2 = C 2 11 := hC.1 11 2
  have sy3 : C 11 3 = C 3 11 := hC.1 11 3
  have sy4 : C 11 4 = C 4 11 := hC.1 11 4
  have sy5 : C 11 5 = C 5 11 := hC.1 11 5
  have sy6 : C 11 6 = C 6 11 := hC.1 11 6
  have sy7 : C 11 7 = C 7 11 := hC.1 11 7
  have sy8 : C 11 8 = C 8 11 := hC.1 11 8
  have sy9 : C 11 9 = C 9 11 := hC.1 11 9
  have sy10 : C 11 10 = C 10 11 := hC.1 11 10
  have hs := hC.2.2.2.1 11
  have hb := hC.2.2.2.2.1 11
  have hd := hC.2.2.2.2.2 0 11
  have hq := hC.2.2.2.2.2 11 11
  have td : z7ExteriorTarget 0 11 = 12 := by decide
  have tq : z7ExteriorTarget 11 11 = 24 := by decide
  simp only [sum12, finRange12_bridge, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil, sy0, sy1, sy2, sy3, sy4, sy5, sy6, sy7, sy8, sy9, sy10, td, tq] at hs hd hq
  simp only [sy0, sy1, sy2, sy3, sy4, sy5, sy6, sy7, sy8, sy9, sy10] at hb
  simp only [hr0, hr1, hr2, hr3, hr4, hr5, hr6, hr7, hr8, hr9, hr10, hr11, Nat.zero_mul, Nat.one_mul] at hd
  refine ⟨(fun j => hC.2.1 j 11), hC.2.2.1 11, hr11, ?_, ?_, ?_, ?_⟩
  · omega
  · omega
  · omega
  · omega

theorem exterior_root26_realizes_core (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hrow : ∀ j, C 0 j = z7Root26Row j) :
    ConwayRoot26Pilot.core.eval (assignment (fun j => C j 11)) = true :=
  core_satisfied _ (facts_of_exterior C hC hrow)

theorem exterior_root26_false_from_core (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hrow : ∀ j, C 0 j = z7Root26Row j) : False := by
  have hs := exterior_root26_realizes_core C hC hrow
  have hu := ConwayRoot26Pilot.root26_core_unsat (assignment (fun j => C j 11))
  exact Bool.noConfusion (hs.symm.trans hu)

#print axioms facts_of_exterior
#print axioms exterior_root26_realizes_core
#print axioms exterior_root26_false_from_core

end Matrix99.Z7Root26Model
