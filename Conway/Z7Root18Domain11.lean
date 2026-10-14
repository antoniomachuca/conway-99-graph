import Conway.Z7Root18
import Conway.Z7Root18Domains
import Conway.Z7UnaryCache11

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root18Domain_eq_11 : pinnedDomain z7Root18Row 11 = z7Root18Dom11 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_11]
  decide +kernel

#print axioms z7Root18Domain_eq_11

end Matrix99
