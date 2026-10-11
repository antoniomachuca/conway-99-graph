import Conway.Z7Root02
import Conway.Z7Root02Domains
import Conway.Z7UnaryCache6

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root02Domain_eq_6 : pinnedDomain z7Root02Row 6 = z7Root02Dom6 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_6]
  decide +kernel

#print axioms z7Root02Domain_eq_6

end Matrix99
