import Conway.Z7Root14
import Conway.Z7Root14Domains
import Conway.Z7UnaryCache3

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root14Domain_eq_3 : pinnedDomain z7Root14Row 3 = z7Root14Dom3 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_3]
  decide +kernel

#print axioms z7Root14Domain_eq_3

end Matrix99
