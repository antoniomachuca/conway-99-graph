import Conway.Z7Root11
import Conway.Z7Root11Domains
import Conway.Z7UnaryCache6

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root11Domain_eq_6 : pinnedDomain z7Root11Row 6 = z7Root11Dom6 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_6]
  decide +kernel

#print axioms z7Root11Domain_eq_6

end Matrix99
