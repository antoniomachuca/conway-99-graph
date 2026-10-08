import Conway.Z7Root00
import Conway.Z7Root00Domains
import Conway.Z7Root00Domain1
import Conway.Z7Root00Domain2
import Conway.Z7Root00Domain3
import Conway.Z7Root00Domain4
import Conway.Z7Root00Domain5
import Conway.Z7Root00Domain6
import Conway.Z7Root00Domain7
import Conway.Z7Root00Domain8
import Conway.Z7Root00Domain9
import Conway.Z7Root00Domain10
import Conway.Z7Root00Domain11

namespace Matrix99

theorem z7Root0Doms_literals :
    z7Root0Doms = [z7Root0Dom1, z7Root0Dom2, z7Root0Dom3, z7Root0Dom4, z7Root0Dom5,
      z7Root0Dom6, z7Root0Dom7, z7Root0Dom8, z7Root0Dom9, z7Root0Dom10, z7Root0Dom11] := by
  rw [z7Root0Doms, z7Root0Tail]
  dsimp only [List.map]
  rw [z7Root0Domain_eq_1, z7Root0Domain_eq_2, z7Root0Domain_eq_3, z7Root0Domain_eq_4,
    z7Root0Domain_eq_5, z7Root0Domain_eq_6, z7Root0Domain_eq_7, z7Root0Domain_eq_8,
    z7Root0Domain_eq_9, z7Root0Domain_eq_10, z7Root0Domain_eq_11]

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root0_noExtension : noExtension z7Root0Tail z7Root0Doms = true := by
  rw [z7Root0Doms_literals]
  decide +kernel

#print axioms z7Root0Doms_literals
#print axioms z7Root0_noExtension

end Matrix99
