import Conway.Z7Root32
import Conway.Z7Root32Domains
import Conway.Z7UnaryCache6

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root32Domain_eq_6 : pinnedDomain z7Root32Row 6 = z7Root32Dom6 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_6]
  decide +kernel

#print axioms z7Root32Domain_eq_6

end Matrix99
