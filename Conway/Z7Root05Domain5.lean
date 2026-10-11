import Conway.Z7Root05
import Conway.Z7Root05Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root05Domain_eq_5 : pinnedDomain z7Root05Row 5 = z7Root05Dom5 := by
  decide +kernel

#print axioms z7Root05Domain_eq_5

end Matrix99
