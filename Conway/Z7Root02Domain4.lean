import Conway.Z7Root02
import Conway.Z7Root02Domains
import Conway.Z7UnaryCache4

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root02Domain_eq_4 : pinnedDomain z7Root02Row 4 = z7Root02Dom4 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_4]
  decide +kernel

#print axioms z7Root02Domain_eq_4

end Matrix99
