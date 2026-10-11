import Conway.Z7Root01
import Conway.Z7Root01Domains
import Conway.Z7UnaryCache9

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root01Domain_eq_9 : pinnedDomain z7Root01Row 9 = z7Root01Dom9 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_9]
  decide +kernel

#print axioms z7Root01Domain_eq_9

end Matrix99
