import Conway.Z7Root28
import Conway.Z7Root28Domains
import Conway.Z7UnaryCache1

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root28Domain_eq_1 : pinnedDomain z7Root28Row 1 = z7Root28Dom1 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_1]
  decide +kernel

#print axioms z7Root28Domain_eq_1

end Matrix99
