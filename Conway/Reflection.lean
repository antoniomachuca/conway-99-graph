import Conway.Matrix
import Conway.Decidable

namespace Matrix99

/-- Computational reflection decision procedure instance for ConwayAdj. -/
def decidable_conway (A : Matrix99 Nat) : Decidable (ConwayAdj A) :=
  inferInstance

end Matrix99
