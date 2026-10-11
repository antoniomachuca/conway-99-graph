import Conway.Z7Root00
import Conway.Z7Root00Domains
import Conway.Z7UnaryCache5

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0Domain_eq_5 : z7Root0Domain 5 = z7Root0Dom5 := by
  unfold z7Root0Domain
  rw [z7UnaryRows_cached_5]
  decide +kernel

#print axioms z7Root0Domain_eq_5

end Matrix99
