import Conway.Z7Root24
import Conway.Z7Root24Domains
import Conway.Z7UnaryCache9

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root24Domain_eq_9 : pinnedDomain z7Root24Row 9 = z7Root24Dom9 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_9]
  decide +kernel

#print axioms z7Root24Domain_eq_9

end Matrix99
