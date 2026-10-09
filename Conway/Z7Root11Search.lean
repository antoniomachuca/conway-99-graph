import Conway.Z7Root11
import Conway.Z7Root11Domains
import Conway.Z7Root11Domain1
import Conway.Z7Root11Domain2
import Conway.Z7Root11Domain3
import Conway.Z7Root11Domain4
import Conway.Z7Root11Domain5
import Conway.Z7Root11Domain6
import Conway.Z7Root11Domain7
import Conway.Z7Root11Domain8
import Conway.Z7Root11Domain9
import Conway.Z7Root11Domain10
import Conway.Z7Root11Domain11

namespace Matrix99

theorem z7Root11Doms_literals :
    pinnedDoms z7Root11Row = [z7Root11Dom1, z7Root11Dom2, z7Root11Dom3, z7Root11Dom4,
      z7Root11Dom5, z7Root11Dom6, z7Root11Dom7, z7Root11Dom8, z7Root11Dom9, z7Root11Dom10,
      z7Root11Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root11Domain_eq_1, z7Root11Domain_eq_2, z7Root11Domain_eq_3, z7Root11Domain_eq_4,
    z7Root11Domain_eq_5, z7Root11Domain_eq_6, z7Root11Domain_eq_7, z7Root11Domain_eq_8,
    z7Root11Domain_eq_9, z7Root11Domain_eq_10, z7Root11Domain_eq_11]

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root11_noExtension : noExtension pinnedTail (pinnedDoms z7Root11Row) = true := by
  rw [z7Root11Doms_literals]
  decide +kernel

#print axioms z7Root11Doms_literals
#print axioms z7Root11_noExtension

end Matrix99
