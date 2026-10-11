import Conway.Z7Root11
import Conway.Z7Root11Domains
import Conway.Z7UnaryCache8

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root11Domain_eq_8 : pinnedDomain z7Root11Row 8 = z7Root11Dom8 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_8]
  decide +kernel

#print axioms z7Root11Domain_eq_8

end Matrix99
