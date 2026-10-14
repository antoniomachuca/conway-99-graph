import Conway.Z7Root15
import Conway.Z7Root15Domains
import Conway.Z7UnaryCache1

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root15Domain_eq_1 : pinnedDomain z7Root15Row 1 = z7Root15Dom1 := by
  unfold pinnedDomain
  rw [z7UnaryRows_cached_1]
  decide +kernel

#print axioms z7Root15Domain_eq_1

end Matrix99
