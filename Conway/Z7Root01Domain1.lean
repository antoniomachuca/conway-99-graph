import Conway.Z7Root01
import Conway.Z7Root01Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root01Domain_eq_1 : pinnedDomain z7Root01Row 1 = z7Root01Dom1 := by
  decide +kernel

#print axioms z7Root01Domain_eq_1

end Matrix99
