import Conway.Z7Root12
import Conway.Z7Root12Domains
import Conway.Z7UnaryCache1

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root12Domain_eq_1 : pinnedDomain z7Root12Row 1 = z7Root12Dom1 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_1]
  decide +kernel

#print axioms z7Root12Domain_eq_1

end Matrix99
