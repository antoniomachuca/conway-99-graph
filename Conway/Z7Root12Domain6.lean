import Conway.Z7Root12
import Conway.Z7Root12Domains
import Conway.Z7UnaryCache6

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root12Domain_eq_6 : pinnedDomain z7Root12Row 6 = z7Root12Dom6 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_6]
  decide +kernel

#print axioms z7Root12Domain_eq_6

end Matrix99
