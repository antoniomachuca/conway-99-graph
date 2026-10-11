import Conway.Z7Root30
import Conway.Z7Root30Domains
import Conway.Z7UnaryCache9

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root30Domain_eq_9 : pinnedDomain z7Root30Row 9 = z7Root30Dom9 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_9]
  decide +kernel

#print axioms z7Root30Domain_eq_9

end Matrix99
