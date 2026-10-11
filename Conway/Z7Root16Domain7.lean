import Conway.Z7Root16
import Conway.Z7Root16Domains
import Conway.Z7UnaryCache7

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root16Domain_eq_7 : pinnedDomain z7Root16Row 7 = z7Root16Dom7 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_7]
  decide +kernel

#print axioms z7Root16Domain_eq_7

end Matrix99
