import Conway.Z7Root01
import Conway.Z7Root01Domains
import Conway.Z7Root01Domain1
import Conway.Z7Root01Domain2
import Conway.Z7Root01Domain3
import Conway.Z7Root01Domain4
import Conway.Z7Root01Domain5
import Conway.Z7Root01Domain6
import Conway.Z7Root01Domain7
import Conway.Z7Root01Domain8
import Conway.Z7Root01Domain9
import Conway.Z7Root01Domain10
import Conway.Z7Root01Domain11

namespace Matrix99

theorem z7Root01Doms_literals :
    pinnedDoms z7Root01Row = [z7Root01Dom1, z7Root01Dom2, z7Root01Dom3, z7Root01Dom4,
      z7Root01Dom5, z7Root01Dom6, z7Root01Dom7, z7Root01Dom8, z7Root01Dom9, z7Root01Dom10,
      z7Root01Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root01Domain_eq_1, z7Root01Domain_eq_2, z7Root01Domain_eq_3, z7Root01Domain_eq_4,
    z7Root01Domain_eq_5, z7Root01Domain_eq_6, z7Root01Domain_eq_7, z7Root01Domain_eq_8,
    z7Root01Domain_eq_9, z7Root01Domain_eq_10, z7Root01Domain_eq_11]

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root01_noExtension : noExtension pinnedTail (pinnedDoms z7Root01Row) = true := by
  rw [z7Root01Doms_literals]
  decide +kernel

#print axioms z7Root01Doms_literals
#print axioms z7Root01_noExtension

end Matrix99
