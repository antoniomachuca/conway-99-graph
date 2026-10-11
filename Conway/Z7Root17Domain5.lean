import Conway.Z7Root17
import Conway.Z7Root17Domains
import Conway.Z7UnaryCache5

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root17Domain_eq_5 : pinnedDomain z7Root17Row 5 = z7Root17Dom5 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_5]
  decide +kernel

#print axioms z7Root17Domain_eq_5

end Matrix99
