import Conway.Z7Root04
import Conway.Z7Root04Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root04Domain_eq_2 : pinnedDomain z7Root04Row 2 = z7Root04Dom2 := by
  decide +kernel

#print axioms z7Root04Domain_eq_2

end Matrix99
