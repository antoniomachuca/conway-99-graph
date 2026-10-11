import Conway.Z7Root12
import Conway.Z7Root12Domains
import Conway.Z7UnaryCache4

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root12Domain_eq_4 : pinnedDomain z7Root12Row 4 = z7Root12Dom4 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_4]
  decide +kernel

#print axioms z7Root12Domain_eq_4

end Matrix99
