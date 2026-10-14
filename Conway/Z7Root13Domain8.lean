import Conway.Z7Root13
import Conway.Z7Root13Domains
import Conway.Z7UnaryCache8

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root13Domain_eq_8 : pinnedDomain z7Root13Row 8 = z7Root13Dom8 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_8]
  decide +kernel

#print axioms z7Root13Domain_eq_8

end Matrix99
