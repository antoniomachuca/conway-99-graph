import Conway.Z7Root00
import Conway.Z7Root00Domains
import Conway.Z7UnaryCache8

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0Domain_eq_8 : z7Root0Domain 8 = z7Root0Dom8 := by
  unfold z7Root0Domain
  rw [z7UnaryRows_cached_8]
  decide +kernel

#print axioms z7Root0Domain_eq_8

end Matrix99
