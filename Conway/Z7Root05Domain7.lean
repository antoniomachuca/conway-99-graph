import Conway.Z7Root05
import Conway.Z7Root05Domains
import Conway.Z7UnaryCache7

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root05Domain_eq_7 : pinnedDomain z7Root05Row 7 = z7Root05Dom7 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_7]
  decide +kernel

#print axioms z7Root05Domain_eq_7

end Matrix99
