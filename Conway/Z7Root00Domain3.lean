import Conway.Z7Root00
import Conway.Z7Root00Domains
import Conway.Z7UnaryCache3

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0Domain_eq_3 : z7Root0Domain 3 = z7Root0Dom3 := by
  unfold z7Root0Domain
  rw [z7UnaryRows_cached_3]
  decide +kernel

#print axioms z7Root0Domain_eq_3

end Matrix99
