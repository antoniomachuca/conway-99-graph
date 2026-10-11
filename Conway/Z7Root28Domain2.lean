import Conway.Z7Root28
import Conway.Z7Root28Domains
import Conway.Z7UnaryCache2

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root28Domain_eq_2 : pinnedDomain z7Root28Row 2 = z7Root28Dom2 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_2]
  decide +kernel

#print axioms z7Root28Domain_eq_2

end Matrix99
