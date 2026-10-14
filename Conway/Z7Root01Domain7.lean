import Conway.Z7Root01
import Conway.Z7Root01Domains
import Conway.Z7UnaryCache7

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root01Domain_eq_7 : pinnedDomain z7Root01Row 7 = z7Root01Dom7 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_7]
  decide +kernel

#print axioms z7Root01Domain_eq_7

end Matrix99
