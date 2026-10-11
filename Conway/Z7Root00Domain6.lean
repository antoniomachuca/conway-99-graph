import Conway.Z7Root00
import Conway.Z7Root00Domains
import Conway.Z7UnaryCache6

namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0Domain_eq_6 : z7Root0Domain 6 = z7Root0Dom6 := by
  unfold z7Root0Domain
  rw [z7UnaryRows_cached_6]
  decide +kernel

#print axioms z7Root0Domain_eq_6

end Matrix99
