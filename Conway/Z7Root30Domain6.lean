import Conway.Z7Root30
import Conway.Z7Root30Domains
import Conway.Z7UnaryCache6

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root30Domain_eq_6 : pinnedDomain z7Root30Row 6 = z7Root30Dom6 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_6]
  decide +kernel

#print axioms z7Root30Domain_eq_6

end Matrix99
