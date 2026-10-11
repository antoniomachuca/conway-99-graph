import Conway.Z7Root00
import Conway.Z7Root00Domains
import Conway.Z7UnaryCache2

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0Domain_eq_2 : z7Root0Domain 2 = z7Root0Dom2 := by
  unfold z7Root0Domain
  rw [z7UnaryRows_cached_2]
  decide +kernel

#print axioms z7Root0Domain_eq_2

end Matrix99
