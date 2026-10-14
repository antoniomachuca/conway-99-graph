import Conway.Z7Root27
import Conway.Z7Root27Domains
import Conway.Z7UnaryCache10

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root27Domain_eq_10 : pinnedDomain z7Root27Row 10 = z7Root27Dom10 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_10]
  decide +kernel

#print axioms z7Root27Domain_eq_10

end Matrix99
