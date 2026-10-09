import Conway.Z7Root11
import Conway.Z7Root11Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root11Domain_eq_10 : pinnedDomain z7Root11Row 10 = z7Root11Dom10 := by
  decide +kernel

#print axioms z7Root11Domain_eq_10

end Matrix99
