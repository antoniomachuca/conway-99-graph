import Conway.Z7Root19
import Conway.Z7Root19Domains
import Conway.Z7UnaryCache1

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root19Domain_eq_1 : pinnedDomain z7Root19Row 1 = z7Root19Dom1 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_1]
  decide +kernel

#print axioms z7Root19Domain_eq_1

end Matrix99
