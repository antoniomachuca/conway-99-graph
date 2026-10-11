import Conway.Z7Root06
import Conway.Z7Root06Domains
import Conway.Z7Root06Domain1
import Conway.Z7Root06Domain2
import Conway.Z7Root06Domain3
import Conway.Z7Root06Domain4
import Conway.Z7Root06Domain5
import Conway.Z7Root06Domain6
import Conway.Z7Root06Domain7
import Conway.Z7Root06Domain8
import Conway.Z7Root06Domain9
import Conway.Z7Root06Domain10
import Conway.Z7Root06Domain11

namespace Matrix99

theorem z7Root06Doms_literals :
    pinnedDoms z7Root06Row = [z7Root06Dom1, z7Root06Dom2, z7Root06Dom3, z7Root06Dom4,
      z7Root06Dom5, z7Root06Dom6, z7Root06Dom7, z7Root06Dom8, z7Root06Dom9, z7Root06Dom10,
      z7Root06Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root06Domain_eq_1, z7Root06Domain_eq_2, z7Root06Domain_eq_3, z7Root06Domain_eq_4,
    z7Root06Domain_eq_5, z7Root06Domain_eq_6, z7Root06Domain_eq_7, z7Root06Domain_eq_8,
    z7Root06Domain_eq_9, z7Root06Domain_eq_10, z7Root06Domain_eq_11]

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root06_noExtension : noExtension pinnedTail (pinnedDoms z7Root06Row) = true := by
  rw [z7Root06Doms_literals]
  decide +kernel

#print axioms z7Root06Doms_literals
#print axioms z7Root06_noExtension

end Matrix99
