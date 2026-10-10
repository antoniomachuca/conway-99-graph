import Conway.Z7Root02
import Conway.Z7Root02Domains
import Conway.Z7Root02Domain1
import Conway.Z7Root02Domain2
import Conway.Z7Root02Domain3
import Conway.Z7Root02Domain4
import Conway.Z7Root02Domain5
import Conway.Z7Root02Domain6
import Conway.Z7Root02Domain7
import Conway.Z7Root02Domain8
import Conway.Z7Root02Domain9
import Conway.Z7Root02Domain10
import Conway.Z7Root02Domain11

namespace Matrix99

theorem z7Root02Doms_literals :
    pinnedDoms z7Root02Row = [z7Root02Dom1, z7Root02Dom2, z7Root02Dom3, z7Root02Dom4,
      z7Root02Dom5, z7Root02Dom6, z7Root02Dom7, z7Root02Dom8, z7Root02Dom9, z7Root02Dom10,
      z7Root02Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root02Domain_eq_1, z7Root02Domain_eq_2, z7Root02Domain_eq_3, z7Root02Domain_eq_4,
    z7Root02Domain_eq_5, z7Root02Domain_eq_6, z7Root02Domain_eq_7, z7Root02Domain_eq_8,
    z7Root02Domain_eq_9, z7Root02Domain_eq_10, z7Root02Domain_eq_11]

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root02_noExtension : noExtension pinnedTail (pinnedDoms z7Root02Row) = true := by
  rw [z7Root02Doms_literals]
  decide +kernel

#print axioms z7Root02Doms_literals
#print axioms z7Root02_noExtension

end Matrix99
