import Conway.Z7Root29
import Conway.Z7Root29Domains
import Conway.Z7UnaryCache2

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root29Domain_eq_2 : pinnedDomain z7Root29Row 2 = z7Root29Dom2 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_2]
  decide +kernel

#print axioms z7Root29Domain_eq_2

end Matrix99
