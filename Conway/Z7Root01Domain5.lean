import Conway.Z7Root01
import Conway.Z7Root01Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root01Domain_eq_5 : pinnedDomain z7Root01Row 5 = z7Root01Dom5 := by
  decide +kernel

#print axioms z7Root01Domain_eq_5

end Matrix99
