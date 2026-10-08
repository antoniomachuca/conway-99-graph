import Conway.Z7Root00
import Conway.Z7Root00Domains

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0Domain_eq_5 : z7Root0Domain 5 = z7Root0Dom5 := by
  decide +kernel

#print axioms z7Root0Domain_eq_5

end Matrix99
