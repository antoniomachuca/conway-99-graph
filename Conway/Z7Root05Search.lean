import Conway.Z7Root05
import Conway.Z7Root05Domains
import Conway.Z7Root05Domain1
import Conway.Z7Root05Domain2
import Conway.Z7Root05Domain3
import Conway.Z7Root05Domain4
import Conway.Z7Root05Domain5
import Conway.Z7Root05Domain6
import Conway.Z7Root05Domain7
import Conway.Z7Root05Domain8
import Conway.Z7Root05Domain9
import Conway.Z7Root05Domain10
import Conway.Z7Root05Domain11

namespace Matrix99

theorem z7Root05Doms_literals :
    pinnedDoms z7Root05Row = [z7Root05Dom1, z7Root05Dom2, z7Root05Dom3, z7Root05Dom4,
      z7Root05Dom5, z7Root05Dom6, z7Root05Dom7, z7Root05Dom8, z7Root05Dom9, z7Root05Dom10,
      z7Root05Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root05Domain_eq_1, z7Root05Domain_eq_2, z7Root05Domain_eq_3, z7Root05Domain_eq_4,
    z7Root05Domain_eq_5, z7Root05Domain_eq_6, z7Root05Domain_eq_7, z7Root05Domain_eq_8,
    z7Root05Domain_eq_9, z7Root05Domain_eq_10, z7Root05Domain_eq_11]

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root05_noExtension : noExtension pinnedTail (pinnedDoms z7Root05Row) = true := by
  rw [z7Root05Doms_literals]
  decide +kernel

#print axioms z7Root05Doms_literals
#print axioms z7Root05_noExtension

end Matrix99
