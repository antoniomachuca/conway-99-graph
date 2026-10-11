import Conway.Z7Root09
import Conway.Z7Root09Domains
import Conway.Z7UnaryCache1

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root09Domain_eq_1 : pinnedDomain z7Root09Row 1 = z7Root09Dom1 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_1]
  decide +kernel

#print axioms z7Root09Domain_eq_1

end Matrix99
