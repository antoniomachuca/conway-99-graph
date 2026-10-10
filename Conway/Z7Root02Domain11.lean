import Conway.Z7Root02
import Conway.Z7Root02Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root02Domain_eq_11 : pinnedDomain z7Root02Row 11 = z7Root02Dom11 := by
  decide +kernel

#print axioms z7Root02Domain_eq_11

end Matrix99
