import Conway.Z7Root04
import Conway.Z7Root04Domains
import Conway.Z7UnaryCache4

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root04Domain_eq_4 : pinnedDomain z7Root04Row 4 = z7Root04Dom4 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_4]
  decide +kernel

#print axioms z7Root04Domain_eq_4

end Matrix99
