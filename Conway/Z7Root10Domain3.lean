import Conway.Z7Root10
import Conway.Z7Root10Domains
import Conway.Z7UnaryCache3

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root10Domain_eq_3 : pinnedDomain z7Root10Row 3 = z7Root10Dom3 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_3]
  decide +kernel

#print axioms z7Root10Domain_eq_3

end Matrix99
