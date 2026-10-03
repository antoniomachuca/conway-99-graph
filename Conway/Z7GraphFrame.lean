import Conway.Z7FixedGeometry
import Conway.Z7OrbitEnumeration

namespace Matrix99

open ConwayOrbit

structure Z7GraphFrame (A : Matrix99 Nat) (s : Fin 99 → Fin 99)
    (h7 : s^[7] = id) (hpres : ∀ u v, A (s u) (s v) = A u v) where
  indexing : OrbitIndexing (cyclicEquitableData 7 (by decide) A s h7 hpres) 15
  root_fixed : s (indexing.rep 0) = indexing.rep 0
  unique_fixed : ∀ v, s v = v → v = indexing.rep 0
  neighborhood : ∀ v, A (indexing.rep 0) v = 1 ↔
    orbitLabel 7 s v = indexing.rep 1 ∨ orbitLabel 7 s v = indexing.rep 2

theorem conway_period7_unique_fixed (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v) (hnontriv : ∃ v, s v ≠ v) :
    ∃ x, s x = x ∧ ∀ y, s y = y → y = x := by
  obtain ⟨x, hx⟩ := period7_has_fixed_on_99 s h7
  exact ⟨x, hx, conway_period7_unique_fixed_at A hA s h7 hpres hnontriv x hx⟩

theorem conway_period7_graph_frame (A : Matrix99 Nat) (hA : ConwayAdj A)
    (s : Fin 99 → Fin 99) (h7 : s^[7] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v) (hnontriv : ∃ v, s v ≠ v) :
    Nonempty (Z7GraphFrame A s h7 hpres) := by
  obtain ⟨x, hx, hunique⟩ := conway_period7_unique_fixed A hA s h7 hpres hnontriv
  obtain ⟨l, r, _, _, _, _, _, hsep, hpart⟩ :=
    conway_period7_rooted_pair A hA s h7 hpres hnontriv x hx
  let L := orbitLabel 7 s l
  let R := orbitLabel 7 s r
  have hL : orbitLabel 7 s L = L := orbitLabel_idempotent (by decide) s h7 l
  have hR : orbitLabel 7 s R = R := orbitLabel_idempotent (by decide) s h7 r
  have hLN : A x L = 1 := (hpart L).mpr (Or.inl (orbitLabel_mem (by decide) s h7 l))
  have hRN : A x R = 1 := (hpart R).mpr (Or.inr (orbitLabel_mem (by decide) s h7 r))
  have hLx : L ≠ x := by
    intro heq
    rw [heq, hA.1 x] at hLN
    contradiction
  have hRx : R ≠ x := by
    intro heq
    rw [heq, hA.1 x] at hRN
    contradiction
  have hLR : L ≠ R := by
    intro heq
    exact hsep ((orbitLabel_eq_iff (by decide) s h7 l r).mp heq)
  let e := enumerateZ7Orbits s h7 x L R hx hunique hL hR hLx hRx hLR
  let indexing : OrbitIndexing (cyclicEquitableData 7 (by decide) A s h7 hpres) 15 :=
    { rep := e.rep
      injective := e.injective
      active := e.active
      complete := e.complete }
  refine ⟨⟨indexing, ?_, ?_, ?_⟩⟩
  · change s (e.rep 0) = e.rep 0
    rw [e.root]
    exact hx
  · intro v hv
    change v = e.rep 0
    rw [e.root]
    exact hunique v hv
  · intro v
    change A (e.rep 0) v = 1 ↔ orbitLabel 7 s v = e.rep 1 ∨ orbitLabel 7 s v = e.rep 2
    rw [e.root, e.left, e.right, hpart v]
    exact or_congr
      ((orbitLabel_eq_iff (by decide) s h7 l v).symm.trans eq_comm)
      ((orbitLabel_eq_iff (by decide) s h7 r v).symm.trans eq_comm)

#print axioms Z7GraphFrame
#print axioms Z7GraphFrame.mk
#print axioms Z7GraphFrame.indexing
#print axioms Z7GraphFrame.root_fixed
#print axioms Z7GraphFrame.unique_fixed
#print axioms Z7GraphFrame.neighborhood
#print axioms conway_period7_unique_fixed
#print axioms conway_period7_graph_frame

end Matrix99
