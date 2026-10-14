import Conway.Z7Root11
import Conway.Z7Root11Domains
import Conway.Z7UnaryCache5

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root11Domain_eq_5 : pinnedDomain z7Root11Row 5 = z7Root11Dom5 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_5]
  decide +kernel

#print axioms z7Root11Domain_eq_5

end Matrix99
