import Conway.Z7Root20
import Conway.Z7Root20Domains
import Conway.Z7UnaryCache4

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root20Domain_eq_4 : pinnedDomain z7Root20Row 4 = z7Root20Dom4 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_4]
  decide +kernel

#print axioms z7Root20Domain_eq_4

end Matrix99
