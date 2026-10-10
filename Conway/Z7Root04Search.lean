import Conway.Z7Root04
import Conway.Z7Root04Domains
import Conway.Z7Root04Domain1
import Conway.Z7Root04Domain2
import Conway.Z7Root04Domain3
import Conway.Z7Root04Domain4
import Conway.Z7Root04Domain5
import Conway.Z7Root04Domain6
import Conway.Z7Root04Domain7
import Conway.Z7Root04Domain8
import Conway.Z7Root04Domain9
import Conway.Z7Root04Domain10
import Conway.Z7Root04Domain11

namespace Matrix99

theorem z7Root04Doms_literals :
    pinnedDoms z7Root04Row = [z7Root04Dom1, z7Root04Dom2, z7Root04Dom3, z7Root04Dom4,
      z7Root04Dom5, z7Root04Dom6, z7Root04Dom7, z7Root04Dom8, z7Root04Dom9, z7Root04Dom10,
      z7Root04Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root04Domain_eq_1, z7Root04Domain_eq_2, z7Root04Domain_eq_3, z7Root04Domain_eq_4,
    z7Root04Domain_eq_5, z7Root04Domain_eq_6, z7Root04Domain_eq_7, z7Root04Domain_eq_8,
    z7Root04Domain_eq_9, z7Root04Domain_eq_10, z7Root04Domain_eq_11]

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root04_noExtension : noExtension pinnedTail (pinnedDoms z7Root04Row) = true := by
  rw [z7Root04Doms_literals]
  decide +kernel

#print axioms z7Root04Doms_literals
#print axioms z7Root04_noExtension

end Matrix99
