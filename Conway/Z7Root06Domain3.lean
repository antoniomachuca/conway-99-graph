import Conway.Z7Root06
import Conway.Z7Root06Domains
import Conway.Z7UnaryCache3

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root06Domain_eq_3 : pinnedDomain z7Root06Row 3 = z7Root06Dom3 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_3]
  decide +kernel

#print axioms z7Root06Domain_eq_3

end Matrix99
