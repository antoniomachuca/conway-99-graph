import Conway.Z7Root27
import Conway.Z7Root27Domains
import Conway.Z7UnaryCache7

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root27Domain_eq_7 : pinnedDomain z7Root27Row 7 = z7Root27Dom7 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_7]
  decide +kernel

#print axioms z7Root27Domain_eq_7

end Matrix99
