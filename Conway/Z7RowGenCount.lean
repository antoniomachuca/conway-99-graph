import Conway.Z7RowGen

namespace Matrix99

set_option maxHeartbeats 200000000

theorem z7UnaryRows_0_length : (z7UnaryRows 0).length = 7576 := by
  decide +kernel

#print axioms z7UnaryRows_0_length

end Matrix99
