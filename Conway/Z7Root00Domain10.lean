import Conway.Z7Root00
import Conway.Z7Root00Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0Domain_eq_10 : z7Root0Domain 10 = z7Root0Dom10 := by
  decide +kernel

#print axioms z7Root0Domain_eq_10

end Matrix99
