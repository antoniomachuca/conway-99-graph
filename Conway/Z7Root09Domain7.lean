import Conway.Z7Root09
import Conway.Z7Root09Domains
import Conway.Z7UnaryCache7

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root09Domain_eq_7 : pinnedDomain z7Root09Row 7 = z7Root09Dom7 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_7]
  decide +kernel

#print axioms z7Root09Domain_eq_7

end Matrix99
