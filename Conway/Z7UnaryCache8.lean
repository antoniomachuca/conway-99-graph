import Conway.Z7GenSplit
import Conway.Z7UnaryCode8
namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 100000
set_option Elab.async false

/-- Reached depth-4 generator states for index 8. -/
theorem states_8 : z7GenStates 4 12 (8 : Fin 12).val 0 [] 12
    (z7ExteriorTarget 8 8) 0 = [([0, 0, 0, 0], 12, 24, (0 : Int)), ([0, 0, 0, 1], 11, 23, (1 : Int)), ([0, 0, 0, 2], 10, 20, (2 : Int)), ([0, 0, 0, 3], 9, 15, (3 : Int)), ([0, 0, 0, 4], 8, 8, (4 : Int)), ([0, 0, 1, 0], 11, 23, (-1 : Int)), ([0, 0, 1, 1], 10, 22, (0 : Int)), ([0, 0, 1, 2], 9, 19, (1 : Int)), ([0, 0, 1, 3], 8, 14, (2 : Int)), ([0, 0, 1, 4], 7, 7, (3 : Int)), ([0, 0, 2, 0], 10, 20, (-2 : Int)), ([0, 0, 2, 1], 9, 19, (-1 : Int)), ([0, 0, 2, 2], 8, 16, (0 : Int)), ([0, 0, 2, 3], 7, 11, (1 : Int)), ([0, 0, 2, 4], 6, 4, (2 : Int)), ([0, 0, 3, 0], 9, 15, (-3 : Int)), ([0, 0, 3, 1], 8, 14, (-2 : Int)), ([0, 0, 3, 2], 7, 11, (-1 : Int)), ([0, 0, 3, 3], 6, 6, (0 : Int)), ([0, 0, 4, 0], 8, 8, (-4 : Int)), ([0, 0, 4, 1], 7, 7, (-3 : Int)), ([0, 0, 4, 2], 6, 4, (-2 : Int)), ([0, 1, 0, 0], 11, 23, (-1 : Int)), ([0, 1, 0, 1], 10, 22, (0 : Int)), ([0, 1, 0, 2], 9, 19, (1 : Int)), ([0, 1, 0, 3], 8, 14, (2 : Int)), ([0, 1, 0, 4], 7, 7, (3 : Int)), ([0, 1, 1, 0], 10, 22, (-2 : Int)), ([0, 1, 1, 1], 9, 21, (-1 : Int)), ([0, 1, 1, 2], 8, 18, (0 : Int)), ([0, 1, 1, 3], 7, 13, (1 : Int)), ([0, 1, 1, 4], 6, 6, (2 : Int)), ([0, 1, 2, 0], 9, 19, (-3 : Int)), ([0, 1, 2, 1], 8, 18, (-2 : Int)), ([0, 1, 2, 2], 7, 15, (-1 : Int)), ([0, 1, 2, 3], 6, 10, (0 : Int)), ([0, 1, 2, 4], 5, 3, (1 : Int)), ([0, 1, 3, 0], 8, 14, (-4 : Int)), ([0, 1, 3, 1], 7, 13, (-3 : Int)), ([0, 1, 3, 2], 6, 10, (-2 : Int)), ([0, 1, 3, 3], 5, 5, (-1 : Int)), ([0, 1, 4, 0], 7, 7, (-5 : Int)), ([0, 1, 4, 1], 6, 6, (-4 : Int)), ([0, 1, 4, 2], 5, 3, (-3 : Int)), ([0, 2, 0, 0], 10, 20, (-2 : Int)), ([0, 2, 0, 1], 9, 19, (-1 : Int)), ([0, 2, 0, 2], 8, 16, (0 : Int)), ([0, 2, 0, 3], 7, 11, (1 : Int)), ([0, 2, 0, 4], 6, 4, (2 : Int)), ([0, 2, 1, 0], 9, 19, (-3 : Int)), ([0, 2, 1, 1], 8, 18, (-2 : Int)), ([0, 2, 1, 2], 7, 15, (-1 : Int)), ([0, 2, 1, 3], 6, 10, (0 : Int)), ([0, 2, 1, 4], 5, 3, (1 : Int)), ([0, 2, 2, 0], 8, 16, (-4 : Int)), ([0, 2, 2, 1], 7, 15, (-3 : Int)), ([0, 2, 2, 2], 6, 12, (-2 : Int)), ([0, 2, 2, 3], 5, 7, (-1 : Int)), ([0, 2, 2, 4], 4, 0, (0 : Int)), ([0, 2, 3, 0], 7, 11, (-5 : Int)), ([0, 2, 3, 1], 6, 10, (-4 : Int)), ([0, 2, 3, 2], 5, 7, (-3 : Int)), ([0, 2, 3, 3], 4, 2, (-2 : Int)), ([0, 2, 4, 0], 6, 4, (-6 : Int)), ([0, 2, 4, 1], 5, 3, (-5 : Int)), ([0, 2, 4, 2], 4, 0, (-4 : Int)), ([0, 3, 0, 0], 9, 15, (-3 : Int)), ([0, 3, 0, 1], 8, 14, (-2 : Int)), ([0, 3, 0, 2], 7, 11, (-1 : Int)), ([0, 3, 0, 3], 6, 6, (0 : Int)), ([0, 3, 1, 0], 8, 14, (-4 : Int)), ([0, 3, 1, 1], 7, 13, (-3 : Int)), ([0, 3, 1, 2], 6, 10, (-2 : Int)), ([0, 3, 1, 3], 5, 5, (-1 : Int)), ([0, 3, 2, 0], 7, 11, (-5 : Int)), ([0, 3, 2, 1], 6, 10, (-4 : Int)), ([0, 3, 2, 2], 5, 7, (-3 : Int)), ([0, 3, 2, 3], 4, 2, (-2 : Int)), ([0, 3, 3, 0], 6, 6, (-6 : Int)), ([0, 3, 3, 1], 5, 5, (-5 : Int)), ([0, 3, 3, 2], 4, 2, (-4 : Int)), ([0, 4, 0, 0], 8, 8, (-4 : Int)), ([0, 4, 0, 1], 7, 7, (-3 : Int)), ([0, 4, 0, 2], 6, 4, (-2 : Int)), ([0, 4, 1, 0], 7, 7, (-5 : Int)), ([0, 4, 1, 1], 6, 6, (-4 : Int)), ([0, 4, 1, 2], 5, 3, (-3 : Int)), ([0, 4, 2, 0], 6, 4, (-6 : Int)), ([0, 4, 2, 1], 5, 3, (-5 : Int)), ([0, 4, 2, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 23, (-1 : Int)), ([1, 0, 0, 1], 10, 22, (0 : Int)), ([1, 0, 0, 2], 9, 19, (1 : Int)), ([1, 0, 0, 3], 8, 14, (2 : Int)), ([1, 0, 0, 4], 7, 7, (3 : Int)), ([1, 0, 1, 0], 10, 22, (-2 : Int)), ([1, 0, 1, 1], 9, 21, (-1 : Int)), ([1, 0, 1, 2], 8, 18, (0 : Int)), ([1, 0, 1, 3], 7, 13, (1 : Int)), ([1, 0, 1, 4], 6, 6, (2 : Int)), ([1, 0, 2, 0], 9, 19, (-3 : Int)), ([1, 0, 2, 1], 8, 18, (-2 : Int)), ([1, 0, 2, 2], 7, 15, (-1 : Int)), ([1, 0, 2, 3], 6, 10, (0 : Int)), ([1, 0, 2, 4], 5, 3, (1 : Int)), ([1, 0, 3, 0], 8, 14, (-4 : Int)), ([1, 0, 3, 1], 7, 13, (-3 : Int)), ([1, 0, 3, 2], 6, 10, (-2 : Int)), ([1, 0, 3, 3], 5, 5, (-1 : Int)), ([1, 0, 4, 0], 7, 7, (-5 : Int)), ([1, 0, 4, 1], 6, 6, (-4 : Int)), ([1, 0, 4, 2], 5, 3, (-3 : Int)), ([1, 1, 0, 0], 10, 22, (-2 : Int)), ([1, 1, 0, 1], 9, 21, (-1 : Int)), ([1, 1, 0, 2], 8, 18, (0 : Int)), ([1, 1, 0, 3], 7, 13, (1 : Int)), ([1, 1, 0, 4], 6, 6, (2 : Int)), ([1, 1, 1, 0], 9, 21, (-3 : Int)), ([1, 1, 1, 1], 8, 20, (-2 : Int)), ([1, 1, 1, 2], 7, 17, (-1 : Int)), ([1, 1, 1, 3], 6, 12, (0 : Int)), ([1, 1, 1, 4], 5, 5, (1 : Int)), ([1, 1, 2, 0], 8, 18, (-4 : Int)), ([1, 1, 2, 1], 7, 17, (-3 : Int)), ([1, 1, 2, 2], 6, 14, (-2 : Int)), ([1, 1, 2, 3], 5, 9, (-1 : Int)), ([1, 1, 2, 4], 4, 2, (0 : Int)), ([1, 1, 3, 0], 7, 13, (-5 : Int)), ([1, 1, 3, 1], 6, 12, (-4 : Int)), ([1, 1, 3, 2], 5, 9, (-3 : Int)), ([1, 1, 3, 3], 4, 4, (-2 : Int)), ([1, 1, 4, 0], 6, 6, (-6 : Int)), ([1, 1, 4, 1], 5, 5, (-5 : Int)), ([1, 1, 4, 2], 4, 2, (-4 : Int)), ([1, 2, 0, 0], 9, 19, (-3 : Int)), ([1, 2, 0, 1], 8, 18, (-2 : Int)), ([1, 2, 0, 2], 7, 15, (-1 : Int)), ([1, 2, 0, 3], 6, 10, (0 : Int)), ([1, 2, 0, 4], 5, 3, (1 : Int)), ([1, 2, 1, 0], 8, 18, (-4 : Int)), ([1, 2, 1, 1], 7, 17, (-3 : Int)), ([1, 2, 1, 2], 6, 14, (-2 : Int)), ([1, 2, 1, 3], 5, 9, (-1 : Int)), ([1, 2, 1, 4], 4, 2, (0 : Int)), ([1, 2, 2, 0], 7, 15, (-5 : Int)), ([1, 2, 2, 1], 6, 14, (-4 : Int)), ([1, 2, 2, 2], 5, 11, (-3 : Int)), ([1, 2, 2, 3], 4, 6, (-2 : Int)), ([1, 2, 3, 0], 6, 10, (-6 : Int)), ([1, 2, 3, 1], 5, 9, (-5 : Int)), ([1, 2, 3, 2], 4, 6, (-4 : Int)), ([1, 2, 3, 3], 3, 1, (-3 : Int)), ([1, 2, 4, 0], 5, 3, (-7 : Int)), ([1, 2, 4, 1], 4, 2, (-6 : Int)), ([1, 3, 0, 0], 8, 14, (-4 : Int)), ([1, 3, 0, 1], 7, 13, (-3 : Int)), ([1, 3, 0, 2], 6, 10, (-2 : Int)), ([1, 3, 0, 3], 5, 5, (-1 : Int)), ([1, 3, 1, 0], 7, 13, (-5 : Int)), ([1, 3, 1, 1], 6, 12, (-4 : Int)), ([1, 3, 1, 2], 5, 9, (-3 : Int)), ([1, 3, 1, 3], 4, 4, (-2 : Int)), ([1, 3, 2, 0], 6, 10, (-6 : Int)), ([1, 3, 2, 1], 5, 9, (-5 : Int)), ([1, 3, 2, 2], 4, 6, (-4 : Int)), ([1, 3, 2, 3], 3, 1, (-3 : Int)), ([1, 3, 3, 0], 5, 5, (-7 : Int)), ([1, 3, 3, 1], 4, 4, (-6 : Int)), ([1, 3, 3, 2], 3, 1, (-5 : Int)), ([1, 4, 0, 0], 7, 7, (-5 : Int)), ([1, 4, 0, 1], 6, 6, (-4 : Int)), ([1, 4, 0, 2], 5, 3, (-3 : Int)), ([1, 4, 1, 0], 6, 6, (-6 : Int)), ([1, 4, 1, 1], 5, 5, (-5 : Int)), ([1, 4, 1, 2], 4, 2, (-4 : Int)), ([1, 4, 2, 0], 5, 3, (-7 : Int)), ([1, 4, 2, 1], 4, 2, (-6 : Int)), ([2, 0, 0, 0], 10, 20, (-2 : Int)), ([2, 0, 0, 1], 9, 19, (-1 : Int)), ([2, 0, 0, 2], 8, 16, (0 : Int)), ([2, 0, 0, 3], 7, 11, (1 : Int)), ([2, 0, 0, 4], 6, 4, (2 : Int)), ([2, 0, 1, 0], 9, 19, (-3 : Int)), ([2, 0, 1, 1], 8, 18, (-2 : Int)), ([2, 0, 1, 2], 7, 15, (-1 : Int)), ([2, 0, 1, 3], 6, 10, (0 : Int)), ([2, 0, 1, 4], 5, 3, (1 : Int)), ([2, 0, 2, 0], 8, 16, (-4 : Int)), ([2, 0, 2, 1], 7, 15, (-3 : Int)), ([2, 0, 2, 2], 6, 12, (-2 : Int)), ([2, 0, 2, 3], 5, 7, (-1 : Int)), ([2, 0, 2, 4], 4, 0, (0 : Int)), ([2, 0, 3, 0], 7, 11, (-5 : Int)), ([2, 0, 3, 1], 6, 10, (-4 : Int)), ([2, 0, 3, 2], 5, 7, (-3 : Int)), ([2, 0, 3, 3], 4, 2, (-2 : Int)), ([2, 0, 4, 0], 6, 4, (-6 : Int)), ([2, 0, 4, 1], 5, 3, (-5 : Int)), ([2, 0, 4, 2], 4, 0, (-4 : Int)), ([2, 1, 0, 0], 9, 19, (-3 : Int)), ([2, 1, 0, 1], 8, 18, (-2 : Int)), ([2, 1, 0, 2], 7, 15, (-1 : Int)), ([2, 1, 0, 3], 6, 10, (0 : Int)), ([2, 1, 0, 4], 5, 3, (1 : Int)), ([2, 1, 1, 0], 8, 18, (-4 : Int)), ([2, 1, 1, 1], 7, 17, (-3 : Int)), ([2, 1, 1, 2], 6, 14, (-2 : Int)), ([2, 1, 1, 3], 5, 9, (-1 : Int)), ([2, 1, 1, 4], 4, 2, (0 : Int)), ([2, 1, 2, 0], 7, 15, (-5 : Int)), ([2, 1, 2, 1], 6, 14, (-4 : Int)), ([2, 1, 2, 2], 5, 11, (-3 : Int)), ([2, 1, 2, 3], 4, 6, (-2 : Int)), ([2, 1, 3, 0], 6, 10, (-6 : Int)), ([2, 1, 3, 1], 5, 9, (-5 : Int)), ([2, 1, 3, 2], 4, 6, (-4 : Int)), ([2, 1, 3, 3], 3, 1, (-3 : Int)), ([2, 1, 4, 0], 5, 3, (-7 : Int)), ([2, 1, 4, 1], 4, 2, (-6 : Int)), ([2, 2, 0, 0], 8, 16, (-4 : Int)), ([2, 2, 0, 1], 7, 15, (-3 : Int)), ([2, 2, 0, 2], 6, 12, (-2 : Int)), ([2, 2, 0, 3], 5, 7, (-1 : Int)), ([2, 2, 0, 4], 4, 0, (0 : Int)), ([2, 2, 1, 0], 7, 15, (-5 : Int)), ([2, 2, 1, 1], 6, 14, (-4 : Int)), ([2, 2, 1, 2], 5, 11, (-3 : Int)), ([2, 2, 1, 3], 4, 6, (-2 : Int)), ([2, 2, 2, 0], 6, 12, (-6 : Int)), ([2, 2, 2, 1], 5, 11, (-5 : Int)), ([2, 2, 2, 2], 4, 8, (-4 : Int)), ([2, 2, 2, 3], 3, 3, (-3 : Int)), ([2, 2, 3, 0], 5, 7, (-7 : Int)), ([2, 2, 3, 1], 4, 6, (-6 : Int)), ([2, 2, 3, 2], 3, 3, (-5 : Int)), ([2, 3, 0, 0], 7, 11, (-5 : Int)), ([2, 3, 0, 1], 6, 10, (-4 : Int)), ([2, 3, 0, 2], 5, 7, (-3 : Int)), ([2, 3, 0, 3], 4, 2, (-2 : Int)), ([2, 3, 1, 0], 6, 10, (-6 : Int)), ([2, 3, 1, 1], 5, 9, (-5 : Int)), ([2, 3, 1, 2], 4, 6, (-4 : Int)), ([2, 3, 1, 3], 3, 1, (-3 : Int)), ([2, 3, 2, 0], 5, 7, (-7 : Int)), ([2, 3, 2, 1], 4, 6, (-6 : Int)), ([2, 3, 2, 2], 3, 3, (-5 : Int)), ([2, 3, 3, 0], 4, 2, (-8 : Int)), ([2, 3, 3, 1], 3, 1, (-7 : Int)), ([2, 4, 0, 0], 6, 4, (-6 : Int)), ([2, 4, 0, 1], 5, 3, (-5 : Int)), ([2, 4, 0, 2], 4, 0, (-4 : Int)), ([2, 4, 1, 0], 5, 3, (-7 : Int)), ([2, 4, 1, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 15, (-3 : Int)), ([3, 0, 0, 1], 8, 14, (-2 : Int)), ([3, 0, 0, 2], 7, 11, (-1 : Int)), ([3, 0, 0, 3], 6, 6, (0 : Int)), ([3, 0, 1, 0], 8, 14, (-4 : Int)), ([3, 0, 1, 1], 7, 13, (-3 : Int)), ([3, 0, 1, 2], 6, 10, (-2 : Int)), ([3, 0, 1, 3], 5, 5, (-1 : Int)), ([3, 0, 2, 0], 7, 11, (-5 : Int)), ([3, 0, 2, 1], 6, 10, (-4 : Int)), ([3, 0, 2, 2], 5, 7, (-3 : Int)), ([3, 0, 2, 3], 4, 2, (-2 : Int)), ([3, 0, 3, 0], 6, 6, (-6 : Int)), ([3, 0, 3, 1], 5, 5, (-5 : Int)), ([3, 0, 3, 2], 4, 2, (-4 : Int)), ([3, 1, 0, 0], 8, 14, (-4 : Int)), ([3, 1, 0, 1], 7, 13, (-3 : Int)), ([3, 1, 0, 2], 6, 10, (-2 : Int)), ([3, 1, 0, 3], 5, 5, (-1 : Int)), ([3, 1, 1, 0], 7, 13, (-5 : Int)), ([3, 1, 1, 1], 6, 12, (-4 : Int)), ([3, 1, 1, 2], 5, 9, (-3 : Int)), ([3, 1, 1, 3], 4, 4, (-2 : Int)), ([3, 1, 2, 0], 6, 10, (-6 : Int)), ([3, 1, 2, 1], 5, 9, (-5 : Int)), ([3, 1, 2, 2], 4, 6, (-4 : Int)), ([3, 1, 2, 3], 3, 1, (-3 : Int)), ([3, 1, 3, 0], 5, 5, (-7 : Int)), ([3, 1, 3, 1], 4, 4, (-6 : Int)), ([3, 1, 3, 2], 3, 1, (-5 : Int)), ([3, 2, 0, 0], 7, 11, (-5 : Int)), ([3, 2, 0, 1], 6, 10, (-4 : Int)), ([3, 2, 0, 2], 5, 7, (-3 : Int)), ([3, 2, 0, 3], 4, 2, (-2 : Int)), ([3, 2, 1, 0], 6, 10, (-6 : Int)), ([3, 2, 1, 1], 5, 9, (-5 : Int)), ([3, 2, 1, 2], 4, 6, (-4 : Int)), ([3, 2, 1, 3], 3, 1, (-3 : Int)), ([3, 2, 2, 0], 5, 7, (-7 : Int)), ([3, 2, 2, 1], 4, 6, (-6 : Int)), ([3, 2, 2, 2], 3, 3, (-5 : Int)), ([3, 2, 3, 0], 4, 2, (-8 : Int)), ([3, 2, 3, 1], 3, 1, (-7 : Int)), ([3, 3, 0, 0], 6, 6, (-6 : Int)), ([3, 3, 0, 1], 5, 5, (-5 : Int)), ([3, 3, 0, 2], 4, 2, (-4 : Int)), ([3, 3, 1, 0], 5, 5, (-7 : Int)), ([3, 3, 1, 1], 4, 4, (-6 : Int)), ([3, 3, 1, 2], 3, 1, (-5 : Int)), ([3, 3, 2, 0], 4, 2, (-8 : Int)), ([3, 3, 2, 1], 3, 1, (-7 : Int)), ([4, 0, 0, 0], 8, 8, (-4 : Int)), ([4, 0, 0, 1], 7, 7, (-3 : Int)), ([4, 0, 0, 2], 6, 4, (-2 : Int)), ([4, 0, 1, 0], 7, 7, (-5 : Int)), ([4, 0, 1, 1], 6, 6, (-4 : Int)), ([4, 0, 1, 2], 5, 3, (-3 : Int)), ([4, 0, 2, 0], 6, 4, (-6 : Int)), ([4, 0, 2, 1], 5, 3, (-5 : Int)), ([4, 0, 2, 2], 4, 0, (-4 : Int)), ([4, 1, 0, 0], 7, 7, (-5 : Int)), ([4, 1, 0, 1], 6, 6, (-4 : Int)), ([4, 1, 0, 2], 5, 3, (-3 : Int)), ([4, 1, 1, 0], 6, 6, (-6 : Int)), ([4, 1, 1, 1], 5, 5, (-5 : Int)), ([4, 1, 1, 2], 4, 2, (-4 : Int)), ([4, 1, 2, 0], 5, 3, (-7 : Int)), ([4, 1, 2, 1], 4, 2, (-6 : Int)), ([4, 2, 0, 0], 6, 4, (-6 : Int)), ([4, 2, 0, 1], 5, 3, (-5 : Int)), ([4, 2, 0, 2], 4, 0, (-4 : Int)), ([4, 2, 1, 0], 5, 3, (-7 : Int)), ([4, 2, 1, 1], 4, 2, (-6 : Int))] := by
  decide +kernel

theorem z7UnaryRows8_s0 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 0, 0] 12 24 (0 : Int))
    (z7UnaryCode8_s0.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s0_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 0, 0], 12, 24, (0 : Int)).1 ([0, 0, 0, 0], 12, 24, (0 : Int)).2.1
      ([0, 0, 0, 0], 12, 24, (0 : Int)).2.2.1 ([0, 0, 0, 0], 12, 24, (0 : Int)).2.2.2 =
    z7UnaryCode8_s0.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 0, 0] 12 24 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s0
theorem z7UnaryRows8_s1 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 0, 1] 11 23 (1 : Int))
    (z7UnaryCode8_s1.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s1_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 0, 1], 11, 23, (1 : Int)).1 ([0, 0, 0, 1], 11, 23, (1 : Int)).2.1
      ([0, 0, 0, 1], 11, 23, (1 : Int)).2.2.1 ([0, 0, 0, 1], 11, 23, (1 : Int)).2.2.2 =
    z7UnaryCode8_s1.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 0, 1] 11 23 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s1
theorem z7UnaryRows8_s2 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 0, 2] 10 20 (2 : Int))
    (z7UnaryCode8_s2.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s2_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 0, 2], 10, 20, (2 : Int)).1 ([0, 0, 0, 2], 10, 20, (2 : Int)).2.1
      ([0, 0, 0, 2], 10, 20, (2 : Int)).2.2.1 ([0, 0, 0, 2], 10, 20, (2 : Int)).2.2.2 =
    z7UnaryCode8_s2.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 0, 2] 10 20 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s2
theorem z7UnaryRows8_s3 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 0, 3] 9 15 (3 : Int))
    (z7UnaryCode8_s3.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s3_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 0, 3], 9, 15, (3 : Int)).1 ([0, 0, 0, 3], 9, 15, (3 : Int)).2.1
      ([0, 0, 0, 3], 9, 15, (3 : Int)).2.2.1 ([0, 0, 0, 3], 9, 15, (3 : Int)).2.2.2 =
    z7UnaryCode8_s3.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 0, 3] 9 15 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s3
theorem z7UnaryRows8_s4 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 0, 4] 8 8 (4 : Int))
    (z7UnaryCode8_s4.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s4_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 0, 4], 8, 8, (4 : Int)).1 ([0, 0, 0, 4], 8, 8, (4 : Int)).2.1
      ([0, 0, 0, 4], 8, 8, (4 : Int)).2.2.1 ([0, 0, 0, 4], 8, 8, (4 : Int)).2.2.2 =
    z7UnaryCode8_s4.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 0, 4] 8 8 (4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s4
theorem z7UnaryRows8_s5 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 1, 0] 11 23 (-1 : Int))
    (z7UnaryCode8_s5.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s5_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 1, 0], 11, 23, (-1 : Int)).1 ([0, 0, 1, 0], 11, 23, (-1 : Int)).2.1
      ([0, 0, 1, 0], 11, 23, (-1 : Int)).2.2.1 ([0, 0, 1, 0], 11, 23, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s5.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 1, 0] 11 23 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s5
theorem z7UnaryRows8_s6 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 1, 1] 10 22 (0 : Int))
    (z7UnaryCode8_s6.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s6_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 1, 1], 10, 22, (0 : Int)).1 ([0, 0, 1, 1], 10, 22, (0 : Int)).2.1
      ([0, 0, 1, 1], 10, 22, (0 : Int)).2.2.1 ([0, 0, 1, 1], 10, 22, (0 : Int)).2.2.2 =
    z7UnaryCode8_s6.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 1, 1] 10 22 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s6
theorem z7UnaryRows8_s7 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 1, 2] 9 19 (1 : Int))
    (z7UnaryCode8_s7.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s7_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 1, 2], 9, 19, (1 : Int)).1 ([0, 0, 1, 2], 9, 19, (1 : Int)).2.1
      ([0, 0, 1, 2], 9, 19, (1 : Int)).2.2.1 ([0, 0, 1, 2], 9, 19, (1 : Int)).2.2.2 =
    z7UnaryCode8_s7.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 1, 2] 9 19 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s7
theorem z7UnaryRows8_s8 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 1, 3] 8 14 (2 : Int))
    (z7UnaryCode8_s8.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s8_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 1, 3], 8, 14, (2 : Int)).1 ([0, 0, 1, 3], 8, 14, (2 : Int)).2.1
      ([0, 0, 1, 3], 8, 14, (2 : Int)).2.2.1 ([0, 0, 1, 3], 8, 14, (2 : Int)).2.2.2 =
    z7UnaryCode8_s8.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 1, 3] 8 14 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s8
theorem z7UnaryRows8_s9 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 1, 4] 7 7 (3 : Int))
    (z7UnaryCode8_s9.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s9_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 1, 4], 7, 7, (3 : Int)).1 ([0, 0, 1, 4], 7, 7, (3 : Int)).2.1
      ([0, 0, 1, 4], 7, 7, (3 : Int)).2.2.1 ([0, 0, 1, 4], 7, 7, (3 : Int)).2.2.2 =
    z7UnaryCode8_s9.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 1, 4] 7 7 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s9
theorem z7UnaryRows8_s10 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 2, 0] 10 20 (-2 : Int))
    (z7UnaryCode8_s10.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s10_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 2, 0], 10, 20, (-2 : Int)).1 ([0, 0, 2, 0], 10, 20, (-2 : Int)).2.1
      ([0, 0, 2, 0], 10, 20, (-2 : Int)).2.2.1 ([0, 0, 2, 0], 10, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s10.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 2, 0] 10 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s10
theorem z7UnaryRows8_s11 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 2, 1] 9 19 (-1 : Int))
    (z7UnaryCode8_s11.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s11_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 2, 1], 9, 19, (-1 : Int)).1 ([0, 0, 2, 1], 9, 19, (-1 : Int)).2.1
      ([0, 0, 2, 1], 9, 19, (-1 : Int)).2.2.1 ([0, 0, 2, 1], 9, 19, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s11.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 2, 1] 9 19 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s11
theorem z7UnaryRows8_s12 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 2, 2] 8 16 (0 : Int))
    (z7UnaryCode8_s12.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s12_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 2, 2], 8, 16, (0 : Int)).1 ([0, 0, 2, 2], 8, 16, (0 : Int)).2.1
      ([0, 0, 2, 2], 8, 16, (0 : Int)).2.2.1 ([0, 0, 2, 2], 8, 16, (0 : Int)).2.2.2 =
    z7UnaryCode8_s12.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 2, 2] 8 16 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s12
theorem z7UnaryRows8_s13 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 2, 3] 7 11 (1 : Int))
    (z7UnaryCode8_s13.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s13_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 2, 3], 7, 11, (1 : Int)).1 ([0, 0, 2, 3], 7, 11, (1 : Int)).2.1
      ([0, 0, 2, 3], 7, 11, (1 : Int)).2.2.1 ([0, 0, 2, 3], 7, 11, (1 : Int)).2.2.2 =
    z7UnaryCode8_s13.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 2, 3] 7 11 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s13
theorem z7UnaryRows8_s14 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 2, 4] 6 4 (2 : Int))
    (z7UnaryCode8_s14.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s14_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 2, 4], 6, 4, (2 : Int)).1 ([0, 0, 2, 4], 6, 4, (2 : Int)).2.1
      ([0, 0, 2, 4], 6, 4, (2 : Int)).2.2.1 ([0, 0, 2, 4], 6, 4, (2 : Int)).2.2.2 =
    z7UnaryCode8_s14.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 2, 4] 6 4 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s14
theorem z7UnaryRows8_s15 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 3, 0] 9 15 (-3 : Int))
    (z7UnaryCode8_s15.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s15_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 3, 0], 9, 15, (-3 : Int)).1 ([0, 0, 3, 0], 9, 15, (-3 : Int)).2.1
      ([0, 0, 3, 0], 9, 15, (-3 : Int)).2.2.1 ([0, 0, 3, 0], 9, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s15.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 3, 0] 9 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s15
theorem z7UnaryRows8_s16 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 3, 1] 8 14 (-2 : Int))
    (z7UnaryCode8_s16.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s16_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 3, 1], 8, 14, (-2 : Int)).1 ([0, 0, 3, 1], 8, 14, (-2 : Int)).2.1
      ([0, 0, 3, 1], 8, 14, (-2 : Int)).2.2.1 ([0, 0, 3, 1], 8, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s16.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 3, 1] 8 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s16
theorem z7UnaryRows8_s17 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 3, 2] 7 11 (-1 : Int))
    (z7UnaryCode8_s17.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s17_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 3, 2], 7, 11, (-1 : Int)).1 ([0, 0, 3, 2], 7, 11, (-1 : Int)).2.1
      ([0, 0, 3, 2], 7, 11, (-1 : Int)).2.2.1 ([0, 0, 3, 2], 7, 11, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s17.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 3, 2] 7 11 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s17
theorem z7UnaryRows8_s18 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 3, 3] 6 6 (0 : Int))
    (z7UnaryCode8_s18.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s18_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 3, 3], 6, 6, (0 : Int)).1 ([0, 0, 3, 3], 6, 6, (0 : Int)).2.1
      ([0, 0, 3, 3], 6, 6, (0 : Int)).2.2.1 ([0, 0, 3, 3], 6, 6, (0 : Int)).2.2.2 =
    z7UnaryCode8_s18.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 3, 3] 6 6 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s18
theorem z7UnaryRows8_s19 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 4, 0] 8 8 (-4 : Int))
    (z7UnaryCode8_s19.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s19_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 4, 0], 8, 8, (-4 : Int)).1 ([0, 0, 4, 0], 8, 8, (-4 : Int)).2.1
      ([0, 0, 4, 0], 8, 8, (-4 : Int)).2.2.1 ([0, 0, 4, 0], 8, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s19.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 4, 0] 8 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s19
theorem z7UnaryRows8_s20 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 4, 1] 7 7 (-3 : Int))
    (z7UnaryCode8_s20.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s20_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 4, 1], 7, 7, (-3 : Int)).1 ([0, 0, 4, 1], 7, 7, (-3 : Int)).2.1
      ([0, 0, 4, 1], 7, 7, (-3 : Int)).2.2.1 ([0, 0, 4, 1], 7, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s20.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 4, 1] 7 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s20
theorem z7UnaryRows8_s21 : rowsBeq
    (z7GenRow 8 8 4 [0, 0, 4, 2] 6 4 (-2 : Int))
    (z7UnaryCode8_s21.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s21_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 0, 4, 2], 6, 4, (-2 : Int)).1 ([0, 0, 4, 2], 6, 4, (-2 : Int)).2.1
      ([0, 0, 4, 2], 6, 4, (-2 : Int)).2.2.1 ([0, 0, 4, 2], 6, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s21.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 0, 4, 2] 6 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s21
theorem z7UnaryRows8_s22 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 0, 0] 11 23 (-1 : Int))
    (z7UnaryCode8_s22.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s22_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 0, 0], 11, 23, (-1 : Int)).1 ([0, 1, 0, 0], 11, 23, (-1 : Int)).2.1
      ([0, 1, 0, 0], 11, 23, (-1 : Int)).2.2.1 ([0, 1, 0, 0], 11, 23, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s22.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 0, 0] 11 23 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s22
theorem z7UnaryRows8_s23 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 0, 1] 10 22 (0 : Int))
    (z7UnaryCode8_s23.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s23_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 0, 1], 10, 22, (0 : Int)).1 ([0, 1, 0, 1], 10, 22, (0 : Int)).2.1
      ([0, 1, 0, 1], 10, 22, (0 : Int)).2.2.1 ([0, 1, 0, 1], 10, 22, (0 : Int)).2.2.2 =
    z7UnaryCode8_s23.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 0, 1] 10 22 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s23
theorem z7UnaryRows8_s24 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 0, 2] 9 19 (1 : Int))
    (z7UnaryCode8_s24.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s24_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 0, 2], 9, 19, (1 : Int)).1 ([0, 1, 0, 2], 9, 19, (1 : Int)).2.1
      ([0, 1, 0, 2], 9, 19, (1 : Int)).2.2.1 ([0, 1, 0, 2], 9, 19, (1 : Int)).2.2.2 =
    z7UnaryCode8_s24.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 0, 2] 9 19 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s24
theorem z7UnaryRows8_s25 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 0, 3] 8 14 (2 : Int))
    (z7UnaryCode8_s25.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s25_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 0, 3], 8, 14, (2 : Int)).1 ([0, 1, 0, 3], 8, 14, (2 : Int)).2.1
      ([0, 1, 0, 3], 8, 14, (2 : Int)).2.2.1 ([0, 1, 0, 3], 8, 14, (2 : Int)).2.2.2 =
    z7UnaryCode8_s25.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 0, 3] 8 14 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s25
theorem z7UnaryRows8_s26 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 0, 4] 7 7 (3 : Int))
    (z7UnaryCode8_s26.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s26_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 0, 4], 7, 7, (3 : Int)).1 ([0, 1, 0, 4], 7, 7, (3 : Int)).2.1
      ([0, 1, 0, 4], 7, 7, (3 : Int)).2.2.1 ([0, 1, 0, 4], 7, 7, (3 : Int)).2.2.2 =
    z7UnaryCode8_s26.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 0, 4] 7 7 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s26
theorem z7UnaryRows8_s27 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 1, 0] 10 22 (-2 : Int))
    (z7UnaryCode8_s27.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s27_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 1, 0], 10, 22, (-2 : Int)).1 ([0, 1, 1, 0], 10, 22, (-2 : Int)).2.1
      ([0, 1, 1, 0], 10, 22, (-2 : Int)).2.2.1 ([0, 1, 1, 0], 10, 22, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s27.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 1, 0] 10 22 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s27
theorem z7UnaryRows8_s28 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 1, 1] 9 21 (-1 : Int))
    (z7UnaryCode8_s28.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s28_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 1, 1], 9, 21, (-1 : Int)).1 ([0, 1, 1, 1], 9, 21, (-1 : Int)).2.1
      ([0, 1, 1, 1], 9, 21, (-1 : Int)).2.2.1 ([0, 1, 1, 1], 9, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s28.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 1, 1] 9 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s28
theorem z7UnaryRows8_s29 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 1, 2] 8 18 (0 : Int))
    (z7UnaryCode8_s29.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s29_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 1, 2], 8, 18, (0 : Int)).1 ([0, 1, 1, 2], 8, 18, (0 : Int)).2.1
      ([0, 1, 1, 2], 8, 18, (0 : Int)).2.2.1 ([0, 1, 1, 2], 8, 18, (0 : Int)).2.2.2 =
    z7UnaryCode8_s29.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 1, 2] 8 18 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s29
theorem z7UnaryRows8_s30 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 1, 3] 7 13 (1 : Int))
    (z7UnaryCode8_s30.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s30_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 1, 3], 7, 13, (1 : Int)).1 ([0, 1, 1, 3], 7, 13, (1 : Int)).2.1
      ([0, 1, 1, 3], 7, 13, (1 : Int)).2.2.1 ([0, 1, 1, 3], 7, 13, (1 : Int)).2.2.2 =
    z7UnaryCode8_s30.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 1, 3] 7 13 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s30
theorem z7UnaryRows8_s31 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 1, 4] 6 6 (2 : Int))
    (z7UnaryCode8_s31.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s31_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 1, 4], 6, 6, (2 : Int)).1 ([0, 1, 1, 4], 6, 6, (2 : Int)).2.1
      ([0, 1, 1, 4], 6, 6, (2 : Int)).2.2.1 ([0, 1, 1, 4], 6, 6, (2 : Int)).2.2.2 =
    z7UnaryCode8_s31.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 1, 4] 6 6 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s31
theorem z7UnaryRows8_s32 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 2, 0] 9 19 (-3 : Int))
    (z7UnaryCode8_s32.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s32_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 2, 0], 9, 19, (-3 : Int)).1 ([0, 1, 2, 0], 9, 19, (-3 : Int)).2.1
      ([0, 1, 2, 0], 9, 19, (-3 : Int)).2.2.1 ([0, 1, 2, 0], 9, 19, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s32.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 2, 0] 9 19 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s32
theorem z7UnaryRows8_s33 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 2, 1] 8 18 (-2 : Int))
    (z7UnaryCode8_s33.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s33_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 2, 1], 8, 18, (-2 : Int)).1 ([0, 1, 2, 1], 8, 18, (-2 : Int)).2.1
      ([0, 1, 2, 1], 8, 18, (-2 : Int)).2.2.1 ([0, 1, 2, 1], 8, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s33.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 2, 1] 8 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s33
theorem z7UnaryRows8_s34 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 2, 2] 7 15 (-1 : Int))
    (z7UnaryCode8_s34.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s34_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 2, 2], 7, 15, (-1 : Int)).1 ([0, 1, 2, 2], 7, 15, (-1 : Int)).2.1
      ([0, 1, 2, 2], 7, 15, (-1 : Int)).2.2.1 ([0, 1, 2, 2], 7, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s34.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 2, 2] 7 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s34
theorem z7UnaryRows8_s35 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 2, 3] 6 10 (0 : Int))
    (z7UnaryCode8_s35.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s35_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 2, 3], 6, 10, (0 : Int)).1 ([0, 1, 2, 3], 6, 10, (0 : Int)).2.1
      ([0, 1, 2, 3], 6, 10, (0 : Int)).2.2.1 ([0, 1, 2, 3], 6, 10, (0 : Int)).2.2.2 =
    z7UnaryCode8_s35.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 2, 3] 6 10 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s35
theorem z7UnaryRows8_s36 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 2, 4] 5 3 (1 : Int))
    (z7UnaryCode8_s36.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s36_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 2, 4], 5, 3, (1 : Int)).1 ([0, 1, 2, 4], 5, 3, (1 : Int)).2.1
      ([0, 1, 2, 4], 5, 3, (1 : Int)).2.2.1 ([0, 1, 2, 4], 5, 3, (1 : Int)).2.2.2 =
    z7UnaryCode8_s36.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 2, 4] 5 3 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s36
theorem z7UnaryRows8_s37 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 3, 0] 8 14 (-4 : Int))
    (z7UnaryCode8_s37.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s37_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 3, 0], 8, 14, (-4 : Int)).1 ([0, 1, 3, 0], 8, 14, (-4 : Int)).2.1
      ([0, 1, 3, 0], 8, 14, (-4 : Int)).2.2.1 ([0, 1, 3, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s37.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 3, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s37
theorem z7UnaryRows8_s38 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 3, 1] 7 13 (-3 : Int))
    (z7UnaryCode8_s38.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s38_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 3, 1], 7, 13, (-3 : Int)).1 ([0, 1, 3, 1], 7, 13, (-3 : Int)).2.1
      ([0, 1, 3, 1], 7, 13, (-3 : Int)).2.2.1 ([0, 1, 3, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s38.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 3, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s38
theorem z7UnaryRows8_s39 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 3, 2] 6 10 (-2 : Int))
    (z7UnaryCode8_s39.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s39_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 3, 2], 6, 10, (-2 : Int)).1 ([0, 1, 3, 2], 6, 10, (-2 : Int)).2.1
      ([0, 1, 3, 2], 6, 10, (-2 : Int)).2.2.1 ([0, 1, 3, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s39.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 3, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s39
theorem z7UnaryRows8_s40 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 3, 3] 5 5 (-1 : Int))
    (z7UnaryCode8_s40.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s40_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 3, 3], 5, 5, (-1 : Int)).1 ([0, 1, 3, 3], 5, 5, (-1 : Int)).2.1
      ([0, 1, 3, 3], 5, 5, (-1 : Int)).2.2.1 ([0, 1, 3, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s40.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 3, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s40
theorem z7UnaryRows8_s41 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 4, 0] 7 7 (-5 : Int))
    (z7UnaryCode8_s41.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s41_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 4, 0], 7, 7, (-5 : Int)).1 ([0, 1, 4, 0], 7, 7, (-5 : Int)).2.1
      ([0, 1, 4, 0], 7, 7, (-5 : Int)).2.2.1 ([0, 1, 4, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s41.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 4, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s41
theorem z7UnaryRows8_s42 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 4, 1] 6 6 (-4 : Int))
    (z7UnaryCode8_s42.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s42_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 4, 1], 6, 6, (-4 : Int)).1 ([0, 1, 4, 1], 6, 6, (-4 : Int)).2.1
      ([0, 1, 4, 1], 6, 6, (-4 : Int)).2.2.1 ([0, 1, 4, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s42.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 4, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s42
theorem z7UnaryRows8_s43 : rowsBeq
    (z7GenRow 8 8 4 [0, 1, 4, 2] 5 3 (-3 : Int))
    (z7UnaryCode8_s43.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s43_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 1, 4, 2], 5, 3, (-3 : Int)).1 ([0, 1, 4, 2], 5, 3, (-3 : Int)).2.1
      ([0, 1, 4, 2], 5, 3, (-3 : Int)).2.2.1 ([0, 1, 4, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s43.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 1, 4, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s43
theorem z7UnaryRows8_s44 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 0, 0] 10 20 (-2 : Int))
    (z7UnaryCode8_s44.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s44_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 0, 0], 10, 20, (-2 : Int)).1 ([0, 2, 0, 0], 10, 20, (-2 : Int)).2.1
      ([0, 2, 0, 0], 10, 20, (-2 : Int)).2.2.1 ([0, 2, 0, 0], 10, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s44.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 0, 0] 10 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s44
theorem z7UnaryRows8_s45 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 0, 1] 9 19 (-1 : Int))
    (z7UnaryCode8_s45.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s45_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 0, 1], 9, 19, (-1 : Int)).1 ([0, 2, 0, 1], 9, 19, (-1 : Int)).2.1
      ([0, 2, 0, 1], 9, 19, (-1 : Int)).2.2.1 ([0, 2, 0, 1], 9, 19, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s45.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 0, 1] 9 19 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s45
theorem z7UnaryRows8_s46 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 0, 2] 8 16 (0 : Int))
    (z7UnaryCode8_s46.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s46_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 0, 2], 8, 16, (0 : Int)).1 ([0, 2, 0, 2], 8, 16, (0 : Int)).2.1
      ([0, 2, 0, 2], 8, 16, (0 : Int)).2.2.1 ([0, 2, 0, 2], 8, 16, (0 : Int)).2.2.2 =
    z7UnaryCode8_s46.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 0, 2] 8 16 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s46
theorem z7UnaryRows8_s47 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 0, 3] 7 11 (1 : Int))
    (z7UnaryCode8_s47.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s47_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 0, 3], 7, 11, (1 : Int)).1 ([0, 2, 0, 3], 7, 11, (1 : Int)).2.1
      ([0, 2, 0, 3], 7, 11, (1 : Int)).2.2.1 ([0, 2, 0, 3], 7, 11, (1 : Int)).2.2.2 =
    z7UnaryCode8_s47.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 0, 3] 7 11 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s47
theorem z7UnaryRows8_s48 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 0, 4] 6 4 (2 : Int))
    (z7UnaryCode8_s48.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s48_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 0, 4], 6, 4, (2 : Int)).1 ([0, 2, 0, 4], 6, 4, (2 : Int)).2.1
      ([0, 2, 0, 4], 6, 4, (2 : Int)).2.2.1 ([0, 2, 0, 4], 6, 4, (2 : Int)).2.2.2 =
    z7UnaryCode8_s48.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 0, 4] 6 4 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s48
theorem z7UnaryRows8_s49 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 1, 0] 9 19 (-3 : Int))
    (z7UnaryCode8_s49.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s49_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 1, 0], 9, 19, (-3 : Int)).1 ([0, 2, 1, 0], 9, 19, (-3 : Int)).2.1
      ([0, 2, 1, 0], 9, 19, (-3 : Int)).2.2.1 ([0, 2, 1, 0], 9, 19, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s49.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 1, 0] 9 19 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s49
theorem z7UnaryRows8_s50 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 1, 1] 8 18 (-2 : Int))
    (z7UnaryCode8_s50.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s50_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 1, 1], 8, 18, (-2 : Int)).1 ([0, 2, 1, 1], 8, 18, (-2 : Int)).2.1
      ([0, 2, 1, 1], 8, 18, (-2 : Int)).2.2.1 ([0, 2, 1, 1], 8, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s50.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 1, 1] 8 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s50
theorem z7UnaryRows8_s51 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 1, 2] 7 15 (-1 : Int))
    (z7UnaryCode8_s51.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s51_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 1, 2], 7, 15, (-1 : Int)).1 ([0, 2, 1, 2], 7, 15, (-1 : Int)).2.1
      ([0, 2, 1, 2], 7, 15, (-1 : Int)).2.2.1 ([0, 2, 1, 2], 7, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s51.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 1, 2] 7 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s51
theorem z7UnaryRows8_s52 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 1, 3] 6 10 (0 : Int))
    (z7UnaryCode8_s52.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s52_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 1, 3], 6, 10, (0 : Int)).1 ([0, 2, 1, 3], 6, 10, (0 : Int)).2.1
      ([0, 2, 1, 3], 6, 10, (0 : Int)).2.2.1 ([0, 2, 1, 3], 6, 10, (0 : Int)).2.2.2 =
    z7UnaryCode8_s52.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 1, 3] 6 10 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s52
theorem z7UnaryRows8_s53 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 1, 4] 5 3 (1 : Int))
    (z7UnaryCode8_s53.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s53_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 1, 4], 5, 3, (1 : Int)).1 ([0, 2, 1, 4], 5, 3, (1 : Int)).2.1
      ([0, 2, 1, 4], 5, 3, (1 : Int)).2.2.1 ([0, 2, 1, 4], 5, 3, (1 : Int)).2.2.2 =
    z7UnaryCode8_s53.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 1, 4] 5 3 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s53
theorem z7UnaryRows8_s54 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 2, 0] 8 16 (-4 : Int))
    (z7UnaryCode8_s54.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s54_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 2, 0], 8, 16, (-4 : Int)).1 ([0, 2, 2, 0], 8, 16, (-4 : Int)).2.1
      ([0, 2, 2, 0], 8, 16, (-4 : Int)).2.2.1 ([0, 2, 2, 0], 8, 16, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s54.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 2, 0] 8 16 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s54
theorem z7UnaryRows8_s55 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 2, 1] 7 15 (-3 : Int))
    (z7UnaryCode8_s55.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s55_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 2, 1], 7, 15, (-3 : Int)).1 ([0, 2, 2, 1], 7, 15, (-3 : Int)).2.1
      ([0, 2, 2, 1], 7, 15, (-3 : Int)).2.2.1 ([0, 2, 2, 1], 7, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s55.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 2, 1] 7 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s55
theorem z7UnaryRows8_s56 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 2, 2] 6 12 (-2 : Int))
    (z7UnaryCode8_s56.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s56_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 2, 2], 6, 12, (-2 : Int)).1 ([0, 2, 2, 2], 6, 12, (-2 : Int)).2.1
      ([0, 2, 2, 2], 6, 12, (-2 : Int)).2.2.1 ([0, 2, 2, 2], 6, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s56.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 2, 2] 6 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s56
theorem z7UnaryRows8_s57 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 2, 3] 5 7 (-1 : Int))
    (z7UnaryCode8_s57.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s57_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 2, 3], 5, 7, (-1 : Int)).1 ([0, 2, 2, 3], 5, 7, (-1 : Int)).2.1
      ([0, 2, 2, 3], 5, 7, (-1 : Int)).2.2.1 ([0, 2, 2, 3], 5, 7, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s57.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 2, 3] 5 7 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s57
theorem z7UnaryRows8_s58 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 2, 4] 4 0 (0 : Int))
    (z7UnaryCode8_s58.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s58_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 2, 4], 4, 0, (0 : Int)).1 ([0, 2, 2, 4], 4, 0, (0 : Int)).2.1
      ([0, 2, 2, 4], 4, 0, (0 : Int)).2.2.1 ([0, 2, 2, 4], 4, 0, (0 : Int)).2.2.2 =
    z7UnaryCode8_s58.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 2, 4] 4 0 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s58
theorem z7UnaryRows8_s59 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 3, 0] 7 11 (-5 : Int))
    (z7UnaryCode8_s59.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s59_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 3, 0], 7, 11, (-5 : Int)).1 ([0, 2, 3, 0], 7, 11, (-5 : Int)).2.1
      ([0, 2, 3, 0], 7, 11, (-5 : Int)).2.2.1 ([0, 2, 3, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s59.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 3, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s59
theorem z7UnaryRows8_s60 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 3, 1] 6 10 (-4 : Int))
    (z7UnaryCode8_s60.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s60_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 3, 1], 6, 10, (-4 : Int)).1 ([0, 2, 3, 1], 6, 10, (-4 : Int)).2.1
      ([0, 2, 3, 1], 6, 10, (-4 : Int)).2.2.1 ([0, 2, 3, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s60.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 3, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s60
theorem z7UnaryRows8_s61 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 3, 2] 5 7 (-3 : Int))
    (z7UnaryCode8_s61.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s61_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 3, 2], 5, 7, (-3 : Int)).1 ([0, 2, 3, 2], 5, 7, (-3 : Int)).2.1
      ([0, 2, 3, 2], 5, 7, (-3 : Int)).2.2.1 ([0, 2, 3, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s61.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 3, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s61
theorem z7UnaryRows8_s62 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 3, 3] 4 2 (-2 : Int))
    (z7UnaryCode8_s62.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s62_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 3, 3], 4, 2, (-2 : Int)).1 ([0, 2, 3, 3], 4, 2, (-2 : Int)).2.1
      ([0, 2, 3, 3], 4, 2, (-2 : Int)).2.2.1 ([0, 2, 3, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s62.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 3, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s62
theorem z7UnaryRows8_s63 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 4, 0] 6 4 (-6 : Int))
    (z7UnaryCode8_s63.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s63_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 4, 0], 6, 4, (-6 : Int)).1 ([0, 2, 4, 0], 6, 4, (-6 : Int)).2.1
      ([0, 2, 4, 0], 6, 4, (-6 : Int)).2.2.1 ([0, 2, 4, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s63.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 4, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s63
theorem z7UnaryRows8_s64 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 4, 1] 5 3 (-5 : Int))
    (z7UnaryCode8_s64.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s64_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 4, 1], 5, 3, (-5 : Int)).1 ([0, 2, 4, 1], 5, 3, (-5 : Int)).2.1
      ([0, 2, 4, 1], 5, 3, (-5 : Int)).2.2.1 ([0, 2, 4, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s64.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 4, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s64
theorem z7UnaryRows8_s65 : rowsBeq
    (z7GenRow 8 8 4 [0, 2, 4, 2] 4 0 (-4 : Int))
    (z7UnaryCode8_s65.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s65_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 2, 4, 2], 4, 0, (-4 : Int)).1 ([0, 2, 4, 2], 4, 0, (-4 : Int)).2.1
      ([0, 2, 4, 2], 4, 0, (-4 : Int)).2.2.1 ([0, 2, 4, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s65.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 2, 4, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s65
theorem z7UnaryRows8_s66 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 0, 0] 9 15 (-3 : Int))
    (z7UnaryCode8_s66.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s66_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 0, 0], 9, 15, (-3 : Int)).1 ([0, 3, 0, 0], 9, 15, (-3 : Int)).2.1
      ([0, 3, 0, 0], 9, 15, (-3 : Int)).2.2.1 ([0, 3, 0, 0], 9, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s66.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 0, 0] 9 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s66
theorem z7UnaryRows8_s67 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 0, 1] 8 14 (-2 : Int))
    (z7UnaryCode8_s67.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s67_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 0, 1], 8, 14, (-2 : Int)).1 ([0, 3, 0, 1], 8, 14, (-2 : Int)).2.1
      ([0, 3, 0, 1], 8, 14, (-2 : Int)).2.2.1 ([0, 3, 0, 1], 8, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s67.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 0, 1] 8 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s67
theorem z7UnaryRows8_s68 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 0, 2] 7 11 (-1 : Int))
    (z7UnaryCode8_s68.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s68_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 0, 2], 7, 11, (-1 : Int)).1 ([0, 3, 0, 2], 7, 11, (-1 : Int)).2.1
      ([0, 3, 0, 2], 7, 11, (-1 : Int)).2.2.1 ([0, 3, 0, 2], 7, 11, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s68.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 0, 2] 7 11 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s68
theorem z7UnaryRows8_s69 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 0, 3] 6 6 (0 : Int))
    (z7UnaryCode8_s69.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s69_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 0, 3], 6, 6, (0 : Int)).1 ([0, 3, 0, 3], 6, 6, (0 : Int)).2.1
      ([0, 3, 0, 3], 6, 6, (0 : Int)).2.2.1 ([0, 3, 0, 3], 6, 6, (0 : Int)).2.2.2 =
    z7UnaryCode8_s69.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 0, 3] 6 6 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s69
theorem z7UnaryRows8_s70 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 1, 0] 8 14 (-4 : Int))
    (z7UnaryCode8_s70.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s70_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 1, 0], 8, 14, (-4 : Int)).1 ([0, 3, 1, 0], 8, 14, (-4 : Int)).2.1
      ([0, 3, 1, 0], 8, 14, (-4 : Int)).2.2.1 ([0, 3, 1, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s70.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 1, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s70
theorem z7UnaryRows8_s71 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 1, 1] 7 13 (-3 : Int))
    (z7UnaryCode8_s71.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s71_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 1, 1], 7, 13, (-3 : Int)).1 ([0, 3, 1, 1], 7, 13, (-3 : Int)).2.1
      ([0, 3, 1, 1], 7, 13, (-3 : Int)).2.2.1 ([0, 3, 1, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s71.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 1, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s71
theorem z7UnaryRows8_s72 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 1, 2] 6 10 (-2 : Int))
    (z7UnaryCode8_s72.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s72_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 1, 2], 6, 10, (-2 : Int)).1 ([0, 3, 1, 2], 6, 10, (-2 : Int)).2.1
      ([0, 3, 1, 2], 6, 10, (-2 : Int)).2.2.1 ([0, 3, 1, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s72.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 1, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s72
theorem z7UnaryRows8_s73 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 1, 3] 5 5 (-1 : Int))
    (z7UnaryCode8_s73.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s73_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 1, 3], 5, 5, (-1 : Int)).1 ([0, 3, 1, 3], 5, 5, (-1 : Int)).2.1
      ([0, 3, 1, 3], 5, 5, (-1 : Int)).2.2.1 ([0, 3, 1, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s73.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 1, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s73
theorem z7UnaryRows8_s74 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 2, 0] 7 11 (-5 : Int))
    (z7UnaryCode8_s74.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s74_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 2, 0], 7, 11, (-5 : Int)).1 ([0, 3, 2, 0], 7, 11, (-5 : Int)).2.1
      ([0, 3, 2, 0], 7, 11, (-5 : Int)).2.2.1 ([0, 3, 2, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s74.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 2, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s74
theorem z7UnaryRows8_s75 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 2, 1] 6 10 (-4 : Int))
    (z7UnaryCode8_s75.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s75_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 2, 1], 6, 10, (-4 : Int)).1 ([0, 3, 2, 1], 6, 10, (-4 : Int)).2.1
      ([0, 3, 2, 1], 6, 10, (-4 : Int)).2.2.1 ([0, 3, 2, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s75.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 2, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s75
theorem z7UnaryRows8_s76 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 2, 2] 5 7 (-3 : Int))
    (z7UnaryCode8_s76.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s76_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 2, 2], 5, 7, (-3 : Int)).1 ([0, 3, 2, 2], 5, 7, (-3 : Int)).2.1
      ([0, 3, 2, 2], 5, 7, (-3 : Int)).2.2.1 ([0, 3, 2, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s76.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 2, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s76
theorem z7UnaryRows8_s77 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 2, 3] 4 2 (-2 : Int))
    (z7UnaryCode8_s77.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s77_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 2, 3], 4, 2, (-2 : Int)).1 ([0, 3, 2, 3], 4, 2, (-2 : Int)).2.1
      ([0, 3, 2, 3], 4, 2, (-2 : Int)).2.2.1 ([0, 3, 2, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s77.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 2, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s77
theorem z7UnaryRows8_s78 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 3, 0] 6 6 (-6 : Int))
    (z7UnaryCode8_s78.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s78_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 3, 0], 6, 6, (-6 : Int)).1 ([0, 3, 3, 0], 6, 6, (-6 : Int)).2.1
      ([0, 3, 3, 0], 6, 6, (-6 : Int)).2.2.1 ([0, 3, 3, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s78.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 3, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s78
theorem z7UnaryRows8_s79 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 3, 1] 5 5 (-5 : Int))
    (z7UnaryCode8_s79.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s79_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 3, 1], 5, 5, (-5 : Int)).1 ([0, 3, 3, 1], 5, 5, (-5 : Int)).2.1
      ([0, 3, 3, 1], 5, 5, (-5 : Int)).2.2.1 ([0, 3, 3, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s79.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 3, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s79
theorem z7UnaryRows8_s80 : rowsBeq
    (z7GenRow 8 8 4 [0, 3, 3, 2] 4 2 (-4 : Int))
    (z7UnaryCode8_s80.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s80_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 3, 3, 2], 4, 2, (-4 : Int)).1 ([0, 3, 3, 2], 4, 2, (-4 : Int)).2.1
      ([0, 3, 3, 2], 4, 2, (-4 : Int)).2.2.1 ([0, 3, 3, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s80.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 3, 3, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s80
theorem z7UnaryRows8_s81 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 0, 0] 8 8 (-4 : Int))
    (z7UnaryCode8_s81.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s81_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 0, 0], 8, 8, (-4 : Int)).1 ([0, 4, 0, 0], 8, 8, (-4 : Int)).2.1
      ([0, 4, 0, 0], 8, 8, (-4 : Int)).2.2.1 ([0, 4, 0, 0], 8, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s81.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 0, 0] 8 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s81
theorem z7UnaryRows8_s82 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 0, 1] 7 7 (-3 : Int))
    (z7UnaryCode8_s82.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s82_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 0, 1], 7, 7, (-3 : Int)).1 ([0, 4, 0, 1], 7, 7, (-3 : Int)).2.1
      ([0, 4, 0, 1], 7, 7, (-3 : Int)).2.2.1 ([0, 4, 0, 1], 7, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s82.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 0, 1] 7 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s82
theorem z7UnaryRows8_s83 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 0, 2] 6 4 (-2 : Int))
    (z7UnaryCode8_s83.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s83_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 0, 2], 6, 4, (-2 : Int)).1 ([0, 4, 0, 2], 6, 4, (-2 : Int)).2.1
      ([0, 4, 0, 2], 6, 4, (-2 : Int)).2.2.1 ([0, 4, 0, 2], 6, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s83.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 0, 2] 6 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s83
theorem z7UnaryRows8_s84 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 1, 0] 7 7 (-5 : Int))
    (z7UnaryCode8_s84.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s84_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 1, 0], 7, 7, (-5 : Int)).1 ([0, 4, 1, 0], 7, 7, (-5 : Int)).2.1
      ([0, 4, 1, 0], 7, 7, (-5 : Int)).2.2.1 ([0, 4, 1, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s84.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 1, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s84
theorem z7UnaryRows8_s85 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 1, 1] 6 6 (-4 : Int))
    (z7UnaryCode8_s85.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s85_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 1, 1], 6, 6, (-4 : Int)).1 ([0, 4, 1, 1], 6, 6, (-4 : Int)).2.1
      ([0, 4, 1, 1], 6, 6, (-4 : Int)).2.2.1 ([0, 4, 1, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s85.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 1, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s85
theorem z7UnaryRows8_s86 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 1, 2] 5 3 (-3 : Int))
    (z7UnaryCode8_s86.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s86_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 1, 2], 5, 3, (-3 : Int)).1 ([0, 4, 1, 2], 5, 3, (-3 : Int)).2.1
      ([0, 4, 1, 2], 5, 3, (-3 : Int)).2.2.1 ([0, 4, 1, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s86.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 1, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s86
theorem z7UnaryRows8_s87 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 2, 0] 6 4 (-6 : Int))
    (z7UnaryCode8_s87.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s87_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 2, 0], 6, 4, (-6 : Int)).1 ([0, 4, 2, 0], 6, 4, (-6 : Int)).2.1
      ([0, 4, 2, 0], 6, 4, (-6 : Int)).2.2.1 ([0, 4, 2, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s87.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 2, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s87
theorem z7UnaryRows8_s88 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 2, 1] 5 3 (-5 : Int))
    (z7UnaryCode8_s88.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s88_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 2, 1], 5, 3, (-5 : Int)).1 ([0, 4, 2, 1], 5, 3, (-5 : Int)).2.1
      ([0, 4, 2, 1], 5, 3, (-5 : Int)).2.2.1 ([0, 4, 2, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s88.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 2, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s88
theorem z7UnaryRows8_s89 : rowsBeq
    (z7GenRow 8 8 4 [0, 4, 2, 2] 4 0 (-4 : Int))
    (z7UnaryCode8_s89.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s89_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([0, 4, 2, 2], 4, 0, (-4 : Int)).1 ([0, 4, 2, 2], 4, 0, (-4 : Int)).2.1
      ([0, 4, 2, 2], 4, 0, (-4 : Int)).2.2.1 ([0, 4, 2, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s89.map z7DecodeRow := by
  show z7GenRow 8 8 4 [0, 4, 2, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s89
theorem z7UnaryRows8_s90 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 0, 0] 11 23 (-1 : Int))
    (z7UnaryCode8_s90.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s90_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 0, 0], 11, 23, (-1 : Int)).1 ([1, 0, 0, 0], 11, 23, (-1 : Int)).2.1
      ([1, 0, 0, 0], 11, 23, (-1 : Int)).2.2.1 ([1, 0, 0, 0], 11, 23, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s90.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 0, 0] 11 23 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s90
theorem z7UnaryRows8_s91 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 0, 1] 10 22 (0 : Int))
    (z7UnaryCode8_s91.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s91_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 0, 1], 10, 22, (0 : Int)).1 ([1, 0, 0, 1], 10, 22, (0 : Int)).2.1
      ([1, 0, 0, 1], 10, 22, (0 : Int)).2.2.1 ([1, 0, 0, 1], 10, 22, (0 : Int)).2.2.2 =
    z7UnaryCode8_s91.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 0, 1] 10 22 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s91
theorem z7UnaryRows8_s92 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 0, 2] 9 19 (1 : Int))
    (z7UnaryCode8_s92.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s92_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 0, 2], 9, 19, (1 : Int)).1 ([1, 0, 0, 2], 9, 19, (1 : Int)).2.1
      ([1, 0, 0, 2], 9, 19, (1 : Int)).2.2.1 ([1, 0, 0, 2], 9, 19, (1 : Int)).2.2.2 =
    z7UnaryCode8_s92.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 0, 2] 9 19 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s92
theorem z7UnaryRows8_s93 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 0, 3] 8 14 (2 : Int))
    (z7UnaryCode8_s93.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s93_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 0, 3], 8, 14, (2 : Int)).1 ([1, 0, 0, 3], 8, 14, (2 : Int)).2.1
      ([1, 0, 0, 3], 8, 14, (2 : Int)).2.2.1 ([1, 0, 0, 3], 8, 14, (2 : Int)).2.2.2 =
    z7UnaryCode8_s93.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 0, 3] 8 14 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s93
theorem z7UnaryRows8_s94 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 0, 4] 7 7 (3 : Int))
    (z7UnaryCode8_s94.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s94_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 0, 4], 7, 7, (3 : Int)).1 ([1, 0, 0, 4], 7, 7, (3 : Int)).2.1
      ([1, 0, 0, 4], 7, 7, (3 : Int)).2.2.1 ([1, 0, 0, 4], 7, 7, (3 : Int)).2.2.2 =
    z7UnaryCode8_s94.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 0, 4] 7 7 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s94
theorem z7UnaryRows8_s95 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 1, 0] 10 22 (-2 : Int))
    (z7UnaryCode8_s95.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s95_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 1, 0], 10, 22, (-2 : Int)).1 ([1, 0, 1, 0], 10, 22, (-2 : Int)).2.1
      ([1, 0, 1, 0], 10, 22, (-2 : Int)).2.2.1 ([1, 0, 1, 0], 10, 22, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s95.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 1, 0] 10 22 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s95
theorem z7UnaryRows8_s96 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 1, 1] 9 21 (-1 : Int))
    (z7UnaryCode8_s96.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s96_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 1, 1], 9, 21, (-1 : Int)).1 ([1, 0, 1, 1], 9, 21, (-1 : Int)).2.1
      ([1, 0, 1, 1], 9, 21, (-1 : Int)).2.2.1 ([1, 0, 1, 1], 9, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s96.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 1, 1] 9 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s96
theorem z7UnaryRows8_s97 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 1, 2] 8 18 (0 : Int))
    (z7UnaryCode8_s97.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s97_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 1, 2], 8, 18, (0 : Int)).1 ([1, 0, 1, 2], 8, 18, (0 : Int)).2.1
      ([1, 0, 1, 2], 8, 18, (0 : Int)).2.2.1 ([1, 0, 1, 2], 8, 18, (0 : Int)).2.2.2 =
    z7UnaryCode8_s97.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 1, 2] 8 18 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s97
theorem z7UnaryRows8_s98 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 1, 3] 7 13 (1 : Int))
    (z7UnaryCode8_s98.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s98_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 1, 3], 7, 13, (1 : Int)).1 ([1, 0, 1, 3], 7, 13, (1 : Int)).2.1
      ([1, 0, 1, 3], 7, 13, (1 : Int)).2.2.1 ([1, 0, 1, 3], 7, 13, (1 : Int)).2.2.2 =
    z7UnaryCode8_s98.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 1, 3] 7 13 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s98
theorem z7UnaryRows8_s99 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 1, 4] 6 6 (2 : Int))
    (z7UnaryCode8_s99.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s99_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 1, 4], 6, 6, (2 : Int)).1 ([1, 0, 1, 4], 6, 6, (2 : Int)).2.1
      ([1, 0, 1, 4], 6, 6, (2 : Int)).2.2.1 ([1, 0, 1, 4], 6, 6, (2 : Int)).2.2.2 =
    z7UnaryCode8_s99.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 1, 4] 6 6 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s99
theorem z7UnaryRows8_s100 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 2, 0] 9 19 (-3 : Int))
    (z7UnaryCode8_s100.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s100_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 2, 0], 9, 19, (-3 : Int)).1 ([1, 0, 2, 0], 9, 19, (-3 : Int)).2.1
      ([1, 0, 2, 0], 9, 19, (-3 : Int)).2.2.1 ([1, 0, 2, 0], 9, 19, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s100.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 2, 0] 9 19 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s100
theorem z7UnaryRows8_s101 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 2, 1] 8 18 (-2 : Int))
    (z7UnaryCode8_s101.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s101_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 2, 1], 8, 18, (-2 : Int)).1 ([1, 0, 2, 1], 8, 18, (-2 : Int)).2.1
      ([1, 0, 2, 1], 8, 18, (-2 : Int)).2.2.1 ([1, 0, 2, 1], 8, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s101.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 2, 1] 8 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s101
theorem z7UnaryRows8_s102 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 2, 2] 7 15 (-1 : Int))
    (z7UnaryCode8_s102.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s102_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 2, 2], 7, 15, (-1 : Int)).1 ([1, 0, 2, 2], 7, 15, (-1 : Int)).2.1
      ([1, 0, 2, 2], 7, 15, (-1 : Int)).2.2.1 ([1, 0, 2, 2], 7, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s102.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 2, 2] 7 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s102
theorem z7UnaryRows8_s103 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 2, 3] 6 10 (0 : Int))
    (z7UnaryCode8_s103.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s103_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 2, 3], 6, 10, (0 : Int)).1 ([1, 0, 2, 3], 6, 10, (0 : Int)).2.1
      ([1, 0, 2, 3], 6, 10, (0 : Int)).2.2.1 ([1, 0, 2, 3], 6, 10, (0 : Int)).2.2.2 =
    z7UnaryCode8_s103.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 2, 3] 6 10 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s103
theorem z7UnaryRows8_s104 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 2, 4] 5 3 (1 : Int))
    (z7UnaryCode8_s104.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s104_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 2, 4], 5, 3, (1 : Int)).1 ([1, 0, 2, 4], 5, 3, (1 : Int)).2.1
      ([1, 0, 2, 4], 5, 3, (1 : Int)).2.2.1 ([1, 0, 2, 4], 5, 3, (1 : Int)).2.2.2 =
    z7UnaryCode8_s104.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 2, 4] 5 3 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s104
theorem z7UnaryRows8_s105 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 3, 0] 8 14 (-4 : Int))
    (z7UnaryCode8_s105.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s105_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 3, 0], 8, 14, (-4 : Int)).1 ([1, 0, 3, 0], 8, 14, (-4 : Int)).2.1
      ([1, 0, 3, 0], 8, 14, (-4 : Int)).2.2.1 ([1, 0, 3, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s105.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 3, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s105
theorem z7UnaryRows8_s106 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 3, 1] 7 13 (-3 : Int))
    (z7UnaryCode8_s106.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s106_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 3, 1], 7, 13, (-3 : Int)).1 ([1, 0, 3, 1], 7, 13, (-3 : Int)).2.1
      ([1, 0, 3, 1], 7, 13, (-3 : Int)).2.2.1 ([1, 0, 3, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s106.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 3, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s106
theorem z7UnaryRows8_s107 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 3, 2] 6 10 (-2 : Int))
    (z7UnaryCode8_s107.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s107_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 3, 2], 6, 10, (-2 : Int)).1 ([1, 0, 3, 2], 6, 10, (-2 : Int)).2.1
      ([1, 0, 3, 2], 6, 10, (-2 : Int)).2.2.1 ([1, 0, 3, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s107.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 3, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s107
theorem z7UnaryRows8_s108 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 3, 3] 5 5 (-1 : Int))
    (z7UnaryCode8_s108.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s108_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 3, 3], 5, 5, (-1 : Int)).1 ([1, 0, 3, 3], 5, 5, (-1 : Int)).2.1
      ([1, 0, 3, 3], 5, 5, (-1 : Int)).2.2.1 ([1, 0, 3, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s108.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 3, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s108
theorem z7UnaryRows8_s109 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 4, 0] 7 7 (-5 : Int))
    (z7UnaryCode8_s109.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s109_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 4, 0], 7, 7, (-5 : Int)).1 ([1, 0, 4, 0], 7, 7, (-5 : Int)).2.1
      ([1, 0, 4, 0], 7, 7, (-5 : Int)).2.2.1 ([1, 0, 4, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s109.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 4, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s109
theorem z7UnaryRows8_s110 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 4, 1] 6 6 (-4 : Int))
    (z7UnaryCode8_s110.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s110_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 4, 1], 6, 6, (-4 : Int)).1 ([1, 0, 4, 1], 6, 6, (-4 : Int)).2.1
      ([1, 0, 4, 1], 6, 6, (-4 : Int)).2.2.1 ([1, 0, 4, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s110.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 4, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s110
theorem z7UnaryRows8_s111 : rowsBeq
    (z7GenRow 8 8 4 [1, 0, 4, 2] 5 3 (-3 : Int))
    (z7UnaryCode8_s111.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s111_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 0, 4, 2], 5, 3, (-3 : Int)).1 ([1, 0, 4, 2], 5, 3, (-3 : Int)).2.1
      ([1, 0, 4, 2], 5, 3, (-3 : Int)).2.2.1 ([1, 0, 4, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s111.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 0, 4, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s111
theorem z7UnaryRows8_s112 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 0, 0] 10 22 (-2 : Int))
    (z7UnaryCode8_s112.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s112_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 0, 0], 10, 22, (-2 : Int)).1 ([1, 1, 0, 0], 10, 22, (-2 : Int)).2.1
      ([1, 1, 0, 0], 10, 22, (-2 : Int)).2.2.1 ([1, 1, 0, 0], 10, 22, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s112.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 0, 0] 10 22 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s112
theorem z7UnaryRows8_s113 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 0, 1] 9 21 (-1 : Int))
    (z7UnaryCode8_s113.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s113_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 0, 1], 9, 21, (-1 : Int)).1 ([1, 1, 0, 1], 9, 21, (-1 : Int)).2.1
      ([1, 1, 0, 1], 9, 21, (-1 : Int)).2.2.1 ([1, 1, 0, 1], 9, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s113.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 0, 1] 9 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s113
theorem z7UnaryRows8_s114 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 0, 2] 8 18 (0 : Int))
    (z7UnaryCode8_s114.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s114_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 0, 2], 8, 18, (0 : Int)).1 ([1, 1, 0, 2], 8, 18, (0 : Int)).2.1
      ([1, 1, 0, 2], 8, 18, (0 : Int)).2.2.1 ([1, 1, 0, 2], 8, 18, (0 : Int)).2.2.2 =
    z7UnaryCode8_s114.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 0, 2] 8 18 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s114
theorem z7UnaryRows8_s115 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 0, 3] 7 13 (1 : Int))
    (z7UnaryCode8_s115.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s115_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 0, 3], 7, 13, (1 : Int)).1 ([1, 1, 0, 3], 7, 13, (1 : Int)).2.1
      ([1, 1, 0, 3], 7, 13, (1 : Int)).2.2.1 ([1, 1, 0, 3], 7, 13, (1 : Int)).2.2.2 =
    z7UnaryCode8_s115.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 0, 3] 7 13 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s115
theorem z7UnaryRows8_s116 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 0, 4] 6 6 (2 : Int))
    (z7UnaryCode8_s116.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s116_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 0, 4], 6, 6, (2 : Int)).1 ([1, 1, 0, 4], 6, 6, (2 : Int)).2.1
      ([1, 1, 0, 4], 6, 6, (2 : Int)).2.2.1 ([1, 1, 0, 4], 6, 6, (2 : Int)).2.2.2 =
    z7UnaryCode8_s116.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 0, 4] 6 6 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s116
theorem z7UnaryRows8_s117 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 1, 0] 9 21 (-3 : Int))
    (z7UnaryCode8_s117.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s117_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 1, 0], 9, 21, (-3 : Int)).1 ([1, 1, 1, 0], 9, 21, (-3 : Int)).2.1
      ([1, 1, 1, 0], 9, 21, (-3 : Int)).2.2.1 ([1, 1, 1, 0], 9, 21, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s117.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 1, 0] 9 21 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s117
theorem z7UnaryRows8_s118 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 1, 1] 8 20 (-2 : Int))
    (z7UnaryCode8_s118.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s118_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 1, 1], 8, 20, (-2 : Int)).1 ([1, 1, 1, 1], 8, 20, (-2 : Int)).2.1
      ([1, 1, 1, 1], 8, 20, (-2 : Int)).2.2.1 ([1, 1, 1, 1], 8, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s118.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 1, 1] 8 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s118
theorem z7UnaryRows8_s119 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 1, 2] 7 17 (-1 : Int))
    (z7UnaryCode8_s119.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s119_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 1, 2], 7, 17, (-1 : Int)).1 ([1, 1, 1, 2], 7, 17, (-1 : Int)).2.1
      ([1, 1, 1, 2], 7, 17, (-1 : Int)).2.2.1 ([1, 1, 1, 2], 7, 17, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s119.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 1, 2] 7 17 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s119
theorem z7UnaryRows8_s120 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 1, 3] 6 12 (0 : Int))
    (z7UnaryCode8_s120.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s120_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 1, 3], 6, 12, (0 : Int)).1 ([1, 1, 1, 3], 6, 12, (0 : Int)).2.1
      ([1, 1, 1, 3], 6, 12, (0 : Int)).2.2.1 ([1, 1, 1, 3], 6, 12, (0 : Int)).2.2.2 =
    z7UnaryCode8_s120.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 1, 3] 6 12 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s120
theorem z7UnaryRows8_s121 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 1, 4] 5 5 (1 : Int))
    (z7UnaryCode8_s121.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s121_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 1, 4], 5, 5, (1 : Int)).1 ([1, 1, 1, 4], 5, 5, (1 : Int)).2.1
      ([1, 1, 1, 4], 5, 5, (1 : Int)).2.2.1 ([1, 1, 1, 4], 5, 5, (1 : Int)).2.2.2 =
    z7UnaryCode8_s121.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 1, 4] 5 5 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s121
theorem z7UnaryRows8_s122 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 2, 0] 8 18 (-4 : Int))
    (z7UnaryCode8_s122.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s122_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 2, 0], 8, 18, (-4 : Int)).1 ([1, 1, 2, 0], 8, 18, (-4 : Int)).2.1
      ([1, 1, 2, 0], 8, 18, (-4 : Int)).2.2.1 ([1, 1, 2, 0], 8, 18, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s122.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 2, 0] 8 18 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s122
theorem z7UnaryRows8_s123 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 2, 1] 7 17 (-3 : Int))
    (z7UnaryCode8_s123.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s123_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 2, 1], 7, 17, (-3 : Int)).1 ([1, 1, 2, 1], 7, 17, (-3 : Int)).2.1
      ([1, 1, 2, 1], 7, 17, (-3 : Int)).2.2.1 ([1, 1, 2, 1], 7, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s123.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 2, 1] 7 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s123
theorem z7UnaryRows8_s124 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 2, 2] 6 14 (-2 : Int))
    (z7UnaryCode8_s124.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s124_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 2, 2], 6, 14, (-2 : Int)).1 ([1, 1, 2, 2], 6, 14, (-2 : Int)).2.1
      ([1, 1, 2, 2], 6, 14, (-2 : Int)).2.2.1 ([1, 1, 2, 2], 6, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s124.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 2, 2] 6 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s124
theorem z7UnaryRows8_s125 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 2, 3] 5 9 (-1 : Int))
    (z7UnaryCode8_s125.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s125_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 2, 3], 5, 9, (-1 : Int)).1 ([1, 1, 2, 3], 5, 9, (-1 : Int)).2.1
      ([1, 1, 2, 3], 5, 9, (-1 : Int)).2.2.1 ([1, 1, 2, 3], 5, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s125.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 2, 3] 5 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s125
theorem z7UnaryRows8_s126 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 2, 4] 4 2 (0 : Int))
    (z7UnaryCode8_s126.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s126_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 2, 4], 4, 2, (0 : Int)).1 ([1, 1, 2, 4], 4, 2, (0 : Int)).2.1
      ([1, 1, 2, 4], 4, 2, (0 : Int)).2.2.1 ([1, 1, 2, 4], 4, 2, (0 : Int)).2.2.2 =
    z7UnaryCode8_s126.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 2, 4] 4 2 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s126
theorem z7UnaryRows8_s127 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 3, 0] 7 13 (-5 : Int))
    (z7UnaryCode8_s127.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s127_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 3, 0], 7, 13, (-5 : Int)).1 ([1, 1, 3, 0], 7, 13, (-5 : Int)).2.1
      ([1, 1, 3, 0], 7, 13, (-5 : Int)).2.2.1 ([1, 1, 3, 0], 7, 13, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s127.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 3, 0] 7 13 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s127
theorem z7UnaryRows8_s128 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 3, 1] 6 12 (-4 : Int))
    (z7UnaryCode8_s128.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s128_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 3, 1], 6, 12, (-4 : Int)).1 ([1, 1, 3, 1], 6, 12, (-4 : Int)).2.1
      ([1, 1, 3, 1], 6, 12, (-4 : Int)).2.2.1 ([1, 1, 3, 1], 6, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s128.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 3, 1] 6 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s128
theorem z7UnaryRows8_s129 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 3, 2] 5 9 (-3 : Int))
    (z7UnaryCode8_s129.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s129_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 3, 2], 5, 9, (-3 : Int)).1 ([1, 1, 3, 2], 5, 9, (-3 : Int)).2.1
      ([1, 1, 3, 2], 5, 9, (-3 : Int)).2.2.1 ([1, 1, 3, 2], 5, 9, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s129.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 3, 2] 5 9 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s129
theorem z7UnaryRows8_s130 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 3, 3] 4 4 (-2 : Int))
    (z7UnaryCode8_s130.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s130_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 3, 3], 4, 4, (-2 : Int)).1 ([1, 1, 3, 3], 4, 4, (-2 : Int)).2.1
      ([1, 1, 3, 3], 4, 4, (-2 : Int)).2.2.1 ([1, 1, 3, 3], 4, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s130.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 3, 3] 4 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s130
theorem z7UnaryRows8_s131 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 4, 0] 6 6 (-6 : Int))
    (z7UnaryCode8_s131.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s131_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 4, 0], 6, 6, (-6 : Int)).1 ([1, 1, 4, 0], 6, 6, (-6 : Int)).2.1
      ([1, 1, 4, 0], 6, 6, (-6 : Int)).2.2.1 ([1, 1, 4, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s131.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 4, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s131
theorem z7UnaryRows8_s132 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 4, 1] 5 5 (-5 : Int))
    (z7UnaryCode8_s132.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s132_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 4, 1], 5, 5, (-5 : Int)).1 ([1, 1, 4, 1], 5, 5, (-5 : Int)).2.1
      ([1, 1, 4, 1], 5, 5, (-5 : Int)).2.2.1 ([1, 1, 4, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s132.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 4, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s132
theorem z7UnaryRows8_s133 : rowsBeq
    (z7GenRow 8 8 4 [1, 1, 4, 2] 4 2 (-4 : Int))
    (z7UnaryCode8_s133.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s133_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 1, 4, 2], 4, 2, (-4 : Int)).1 ([1, 1, 4, 2], 4, 2, (-4 : Int)).2.1
      ([1, 1, 4, 2], 4, 2, (-4 : Int)).2.2.1 ([1, 1, 4, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s133.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 1, 4, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s133
theorem z7UnaryRows8_s134 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 0, 0] 9 19 (-3 : Int))
    (z7UnaryCode8_s134.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s134_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 0, 0], 9, 19, (-3 : Int)).1 ([1, 2, 0, 0], 9, 19, (-3 : Int)).2.1
      ([1, 2, 0, 0], 9, 19, (-3 : Int)).2.2.1 ([1, 2, 0, 0], 9, 19, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s134.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 0, 0] 9 19 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s134
theorem z7UnaryRows8_s135 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 0, 1] 8 18 (-2 : Int))
    (z7UnaryCode8_s135.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s135_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 0, 1], 8, 18, (-2 : Int)).1 ([1, 2, 0, 1], 8, 18, (-2 : Int)).2.1
      ([1, 2, 0, 1], 8, 18, (-2 : Int)).2.2.1 ([1, 2, 0, 1], 8, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s135.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 0, 1] 8 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s135
theorem z7UnaryRows8_s136 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 0, 2] 7 15 (-1 : Int))
    (z7UnaryCode8_s136.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s136_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 0, 2], 7, 15, (-1 : Int)).1 ([1, 2, 0, 2], 7, 15, (-1 : Int)).2.1
      ([1, 2, 0, 2], 7, 15, (-1 : Int)).2.2.1 ([1, 2, 0, 2], 7, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s136.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 0, 2] 7 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s136
theorem z7UnaryRows8_s137 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 0, 3] 6 10 (0 : Int))
    (z7UnaryCode8_s137.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s137_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 0, 3], 6, 10, (0 : Int)).1 ([1, 2, 0, 3], 6, 10, (0 : Int)).2.1
      ([1, 2, 0, 3], 6, 10, (0 : Int)).2.2.1 ([1, 2, 0, 3], 6, 10, (0 : Int)).2.2.2 =
    z7UnaryCode8_s137.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 0, 3] 6 10 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s137
theorem z7UnaryRows8_s138 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 0, 4] 5 3 (1 : Int))
    (z7UnaryCode8_s138.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s138_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 0, 4], 5, 3, (1 : Int)).1 ([1, 2, 0, 4], 5, 3, (1 : Int)).2.1
      ([1, 2, 0, 4], 5, 3, (1 : Int)).2.2.1 ([1, 2, 0, 4], 5, 3, (1 : Int)).2.2.2 =
    z7UnaryCode8_s138.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 0, 4] 5 3 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s138
theorem z7UnaryRows8_s139 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 1, 0] 8 18 (-4 : Int))
    (z7UnaryCode8_s139.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s139_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 1, 0], 8, 18, (-4 : Int)).1 ([1, 2, 1, 0], 8, 18, (-4 : Int)).2.1
      ([1, 2, 1, 0], 8, 18, (-4 : Int)).2.2.1 ([1, 2, 1, 0], 8, 18, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s139.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 1, 0] 8 18 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s139
theorem z7UnaryRows8_s140 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 1, 1] 7 17 (-3 : Int))
    (z7UnaryCode8_s140.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s140_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 1, 1], 7, 17, (-3 : Int)).1 ([1, 2, 1, 1], 7, 17, (-3 : Int)).2.1
      ([1, 2, 1, 1], 7, 17, (-3 : Int)).2.2.1 ([1, 2, 1, 1], 7, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s140.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 1, 1] 7 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s140
theorem z7UnaryRows8_s141 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 1, 2] 6 14 (-2 : Int))
    (z7UnaryCode8_s141.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s141_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 1, 2], 6, 14, (-2 : Int)).1 ([1, 2, 1, 2], 6, 14, (-2 : Int)).2.1
      ([1, 2, 1, 2], 6, 14, (-2 : Int)).2.2.1 ([1, 2, 1, 2], 6, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s141.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 1, 2] 6 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s141
theorem z7UnaryRows8_s142 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 1, 3] 5 9 (-1 : Int))
    (z7UnaryCode8_s142.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s142_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 1, 3], 5, 9, (-1 : Int)).1 ([1, 2, 1, 3], 5, 9, (-1 : Int)).2.1
      ([1, 2, 1, 3], 5, 9, (-1 : Int)).2.2.1 ([1, 2, 1, 3], 5, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s142.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 1, 3] 5 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s142
theorem z7UnaryRows8_s143 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 1, 4] 4 2 (0 : Int))
    (z7UnaryCode8_s143.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s143_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 1, 4], 4, 2, (0 : Int)).1 ([1, 2, 1, 4], 4, 2, (0 : Int)).2.1
      ([1, 2, 1, 4], 4, 2, (0 : Int)).2.2.1 ([1, 2, 1, 4], 4, 2, (0 : Int)).2.2.2 =
    z7UnaryCode8_s143.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 1, 4] 4 2 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s143
theorem z7UnaryRows8_s144 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 2, 0] 7 15 (-5 : Int))
    (z7UnaryCode8_s144.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s144_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 2, 0], 7, 15, (-5 : Int)).1 ([1, 2, 2, 0], 7, 15, (-5 : Int)).2.1
      ([1, 2, 2, 0], 7, 15, (-5 : Int)).2.2.1 ([1, 2, 2, 0], 7, 15, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s144.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 2, 0] 7 15 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s144
theorem z7UnaryRows8_s145 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 2, 1] 6 14 (-4 : Int))
    (z7UnaryCode8_s145.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s145_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 2, 1], 6, 14, (-4 : Int)).1 ([1, 2, 2, 1], 6, 14, (-4 : Int)).2.1
      ([1, 2, 2, 1], 6, 14, (-4 : Int)).2.2.1 ([1, 2, 2, 1], 6, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s145.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 2, 1] 6 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s145
theorem z7UnaryRows8_s146 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 2, 2] 5 11 (-3 : Int))
    (z7UnaryCode8_s146.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s146_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 2, 2], 5, 11, (-3 : Int)).1 ([1, 2, 2, 2], 5, 11, (-3 : Int)).2.1
      ([1, 2, 2, 2], 5, 11, (-3 : Int)).2.2.1 ([1, 2, 2, 2], 5, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s146.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 2, 2] 5 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s146
theorem z7UnaryRows8_s147 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 2, 3] 4 6 (-2 : Int))
    (z7UnaryCode8_s147.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s147_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 2, 3], 4, 6, (-2 : Int)).1 ([1, 2, 2, 3], 4, 6, (-2 : Int)).2.1
      ([1, 2, 2, 3], 4, 6, (-2 : Int)).2.2.1 ([1, 2, 2, 3], 4, 6, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s147.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 2, 3] 4 6 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s147
theorem z7UnaryRows8_s148 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 3, 0] 6 10 (-6 : Int))
    (z7UnaryCode8_s148.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s148_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 3, 0], 6, 10, (-6 : Int)).1 ([1, 2, 3, 0], 6, 10, (-6 : Int)).2.1
      ([1, 2, 3, 0], 6, 10, (-6 : Int)).2.2.1 ([1, 2, 3, 0], 6, 10, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s148.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 3, 0] 6 10 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s148
theorem z7UnaryRows8_s149 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 3, 1] 5 9 (-5 : Int))
    (z7UnaryCode8_s149.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s149_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 3, 1], 5, 9, (-5 : Int)).1 ([1, 2, 3, 1], 5, 9, (-5 : Int)).2.1
      ([1, 2, 3, 1], 5, 9, (-5 : Int)).2.2.1 ([1, 2, 3, 1], 5, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s149.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 3, 1] 5 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s149
theorem z7UnaryRows8_s150 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 3, 2] 4 6 (-4 : Int))
    (z7UnaryCode8_s150.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s150_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 3, 2], 4, 6, (-4 : Int)).1 ([1, 2, 3, 2], 4, 6, (-4 : Int)).2.1
      ([1, 2, 3, 2], 4, 6, (-4 : Int)).2.2.1 ([1, 2, 3, 2], 4, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s150.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 3, 2] 4 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s150
theorem z7UnaryRows8_s151 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 3, 3] 3 1 (-3 : Int))
    (z7UnaryCode8_s151.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s151_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 3, 3], 3, 1, (-3 : Int)).1 ([1, 2, 3, 3], 3, 1, (-3 : Int)).2.1
      ([1, 2, 3, 3], 3, 1, (-3 : Int)).2.2.1 ([1, 2, 3, 3], 3, 1, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s151.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 3, 3] 3 1 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s151
theorem z7UnaryRows8_s152 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 4, 0] 5 3 (-7 : Int))
    (z7UnaryCode8_s152.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s152_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 4, 0], 5, 3, (-7 : Int)).1 ([1, 2, 4, 0], 5, 3, (-7 : Int)).2.1
      ([1, 2, 4, 0], 5, 3, (-7 : Int)).2.2.1 ([1, 2, 4, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s152.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 4, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s152
theorem z7UnaryRows8_s153 : rowsBeq
    (z7GenRow 8 8 4 [1, 2, 4, 1] 4 2 (-6 : Int))
    (z7UnaryCode8_s153.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s153_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 2, 4, 1], 4, 2, (-6 : Int)).1 ([1, 2, 4, 1], 4, 2, (-6 : Int)).2.1
      ([1, 2, 4, 1], 4, 2, (-6 : Int)).2.2.1 ([1, 2, 4, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s153.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 2, 4, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s153
theorem z7UnaryRows8_s154 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 0, 0] 8 14 (-4 : Int))
    (z7UnaryCode8_s154.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s154_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 0, 0], 8, 14, (-4 : Int)).1 ([1, 3, 0, 0], 8, 14, (-4 : Int)).2.1
      ([1, 3, 0, 0], 8, 14, (-4 : Int)).2.2.1 ([1, 3, 0, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s154.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 0, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s154
theorem z7UnaryRows8_s155 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 0, 1] 7 13 (-3 : Int))
    (z7UnaryCode8_s155.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s155_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 0, 1], 7, 13, (-3 : Int)).1 ([1, 3, 0, 1], 7, 13, (-3 : Int)).2.1
      ([1, 3, 0, 1], 7, 13, (-3 : Int)).2.2.1 ([1, 3, 0, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s155.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 0, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s155
theorem z7UnaryRows8_s156 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 0, 2] 6 10 (-2 : Int))
    (z7UnaryCode8_s156.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s156_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 0, 2], 6, 10, (-2 : Int)).1 ([1, 3, 0, 2], 6, 10, (-2 : Int)).2.1
      ([1, 3, 0, 2], 6, 10, (-2 : Int)).2.2.1 ([1, 3, 0, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s156.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 0, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s156
theorem z7UnaryRows8_s157 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 0, 3] 5 5 (-1 : Int))
    (z7UnaryCode8_s157.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s157_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 0, 3], 5, 5, (-1 : Int)).1 ([1, 3, 0, 3], 5, 5, (-1 : Int)).2.1
      ([1, 3, 0, 3], 5, 5, (-1 : Int)).2.2.1 ([1, 3, 0, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s157.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 0, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s157
theorem z7UnaryRows8_s158 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 1, 0] 7 13 (-5 : Int))
    (z7UnaryCode8_s158.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s158_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 1, 0], 7, 13, (-5 : Int)).1 ([1, 3, 1, 0], 7, 13, (-5 : Int)).2.1
      ([1, 3, 1, 0], 7, 13, (-5 : Int)).2.2.1 ([1, 3, 1, 0], 7, 13, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s158.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 1, 0] 7 13 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s158
theorem z7UnaryRows8_s159 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 1, 1] 6 12 (-4 : Int))
    (z7UnaryCode8_s159.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s159_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 1, 1], 6, 12, (-4 : Int)).1 ([1, 3, 1, 1], 6, 12, (-4 : Int)).2.1
      ([1, 3, 1, 1], 6, 12, (-4 : Int)).2.2.1 ([1, 3, 1, 1], 6, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s159.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 1, 1] 6 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s159
theorem z7UnaryRows8_s160 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 1, 2] 5 9 (-3 : Int))
    (z7UnaryCode8_s160.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s160_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 1, 2], 5, 9, (-3 : Int)).1 ([1, 3, 1, 2], 5, 9, (-3 : Int)).2.1
      ([1, 3, 1, 2], 5, 9, (-3 : Int)).2.2.1 ([1, 3, 1, 2], 5, 9, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s160.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 1, 2] 5 9 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s160
theorem z7UnaryRows8_s161 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 1, 3] 4 4 (-2 : Int))
    (z7UnaryCode8_s161.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s161_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 1, 3], 4, 4, (-2 : Int)).1 ([1, 3, 1, 3], 4, 4, (-2 : Int)).2.1
      ([1, 3, 1, 3], 4, 4, (-2 : Int)).2.2.1 ([1, 3, 1, 3], 4, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s161.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 1, 3] 4 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s161
theorem z7UnaryRows8_s162 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 2, 0] 6 10 (-6 : Int))
    (z7UnaryCode8_s162.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s162_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 2, 0], 6, 10, (-6 : Int)).1 ([1, 3, 2, 0], 6, 10, (-6 : Int)).2.1
      ([1, 3, 2, 0], 6, 10, (-6 : Int)).2.2.1 ([1, 3, 2, 0], 6, 10, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s162.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 2, 0] 6 10 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s162
theorem z7UnaryRows8_s163 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 2, 1] 5 9 (-5 : Int))
    (z7UnaryCode8_s163.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s163_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 2, 1], 5, 9, (-5 : Int)).1 ([1, 3, 2, 1], 5, 9, (-5 : Int)).2.1
      ([1, 3, 2, 1], 5, 9, (-5 : Int)).2.2.1 ([1, 3, 2, 1], 5, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s163.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 2, 1] 5 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s163
theorem z7UnaryRows8_s164 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 2, 2] 4 6 (-4 : Int))
    (z7UnaryCode8_s164.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s164_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 2, 2], 4, 6, (-4 : Int)).1 ([1, 3, 2, 2], 4, 6, (-4 : Int)).2.1
      ([1, 3, 2, 2], 4, 6, (-4 : Int)).2.2.1 ([1, 3, 2, 2], 4, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s164.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 2, 2] 4 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s164
theorem z7UnaryRows8_s165 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 2, 3] 3 1 (-3 : Int))
    (z7UnaryCode8_s165.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s165_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 2, 3], 3, 1, (-3 : Int)).1 ([1, 3, 2, 3], 3, 1, (-3 : Int)).2.1
      ([1, 3, 2, 3], 3, 1, (-3 : Int)).2.2.1 ([1, 3, 2, 3], 3, 1, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s165.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 2, 3] 3 1 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s165
theorem z7UnaryRows8_s166 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 3, 0] 5 5 (-7 : Int))
    (z7UnaryCode8_s166.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s166_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 3, 0], 5, 5, (-7 : Int)).1 ([1, 3, 3, 0], 5, 5, (-7 : Int)).2.1
      ([1, 3, 3, 0], 5, 5, (-7 : Int)).2.2.1 ([1, 3, 3, 0], 5, 5, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s166.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 3, 0] 5 5 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s166
theorem z7UnaryRows8_s167 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 3, 1] 4 4 (-6 : Int))
    (z7UnaryCode8_s167.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s167_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 3, 1], 4, 4, (-6 : Int)).1 ([1, 3, 3, 1], 4, 4, (-6 : Int)).2.1
      ([1, 3, 3, 1], 4, 4, (-6 : Int)).2.2.1 ([1, 3, 3, 1], 4, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s167.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 3, 1] 4 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s167
theorem z7UnaryRows8_s168 : rowsBeq
    (z7GenRow 8 8 4 [1, 3, 3, 2] 3 1 (-5 : Int))
    (z7UnaryCode8_s168.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s168_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 3, 3, 2], 3, 1, (-5 : Int)).1 ([1, 3, 3, 2], 3, 1, (-5 : Int)).2.1
      ([1, 3, 3, 2], 3, 1, (-5 : Int)).2.2.1 ([1, 3, 3, 2], 3, 1, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s168.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 3, 3, 2] 3 1 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s168
theorem z7UnaryRows8_s169 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 0, 0] 7 7 (-5 : Int))
    (z7UnaryCode8_s169.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s169_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 0, 0], 7, 7, (-5 : Int)).1 ([1, 4, 0, 0], 7, 7, (-5 : Int)).2.1
      ([1, 4, 0, 0], 7, 7, (-5 : Int)).2.2.1 ([1, 4, 0, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s169.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 0, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s169
theorem z7UnaryRows8_s170 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 0, 1] 6 6 (-4 : Int))
    (z7UnaryCode8_s170.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s170_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 0, 1], 6, 6, (-4 : Int)).1 ([1, 4, 0, 1], 6, 6, (-4 : Int)).2.1
      ([1, 4, 0, 1], 6, 6, (-4 : Int)).2.2.1 ([1, 4, 0, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s170.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 0, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s170
theorem z7UnaryRows8_s171 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 0, 2] 5 3 (-3 : Int))
    (z7UnaryCode8_s171.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s171_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 0, 2], 5, 3, (-3 : Int)).1 ([1, 4, 0, 2], 5, 3, (-3 : Int)).2.1
      ([1, 4, 0, 2], 5, 3, (-3 : Int)).2.2.1 ([1, 4, 0, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s171.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 0, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s171
theorem z7UnaryRows8_s172 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 1, 0] 6 6 (-6 : Int))
    (z7UnaryCode8_s172.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s172_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 1, 0], 6, 6, (-6 : Int)).1 ([1, 4, 1, 0], 6, 6, (-6 : Int)).2.1
      ([1, 4, 1, 0], 6, 6, (-6 : Int)).2.2.1 ([1, 4, 1, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s172.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 1, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s172
theorem z7UnaryRows8_s173 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 1, 1] 5 5 (-5 : Int))
    (z7UnaryCode8_s173.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s173_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 1, 1], 5, 5, (-5 : Int)).1 ([1, 4, 1, 1], 5, 5, (-5 : Int)).2.1
      ([1, 4, 1, 1], 5, 5, (-5 : Int)).2.2.1 ([1, 4, 1, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s173.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 1, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s173
theorem z7UnaryRows8_s174 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 1, 2] 4 2 (-4 : Int))
    (z7UnaryCode8_s174.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s174_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 1, 2], 4, 2, (-4 : Int)).1 ([1, 4, 1, 2], 4, 2, (-4 : Int)).2.1
      ([1, 4, 1, 2], 4, 2, (-4 : Int)).2.2.1 ([1, 4, 1, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s174.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 1, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s174
theorem z7UnaryRows8_s175 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 2, 0] 5 3 (-7 : Int))
    (z7UnaryCode8_s175.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s175_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 2, 0], 5, 3, (-7 : Int)).1 ([1, 4, 2, 0], 5, 3, (-7 : Int)).2.1
      ([1, 4, 2, 0], 5, 3, (-7 : Int)).2.2.1 ([1, 4, 2, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s175.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 2, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s175
theorem z7UnaryRows8_s176 : rowsBeq
    (z7GenRow 8 8 4 [1, 4, 2, 1] 4 2 (-6 : Int))
    (z7UnaryCode8_s176.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s176_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([1, 4, 2, 1], 4, 2, (-6 : Int)).1 ([1, 4, 2, 1], 4, 2, (-6 : Int)).2.1
      ([1, 4, 2, 1], 4, 2, (-6 : Int)).2.2.1 ([1, 4, 2, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s176.map z7DecodeRow := by
  show z7GenRow 8 8 4 [1, 4, 2, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s176
theorem z7UnaryRows8_s177 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 0, 0] 10 20 (-2 : Int))
    (z7UnaryCode8_s177.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s177_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 0, 0], 10, 20, (-2 : Int)).1 ([2, 0, 0, 0], 10, 20, (-2 : Int)).2.1
      ([2, 0, 0, 0], 10, 20, (-2 : Int)).2.2.1 ([2, 0, 0, 0], 10, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s177.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 0, 0] 10 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s177
theorem z7UnaryRows8_s178 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 0, 1] 9 19 (-1 : Int))
    (z7UnaryCode8_s178.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s178_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 0, 1], 9, 19, (-1 : Int)).1 ([2, 0, 0, 1], 9, 19, (-1 : Int)).2.1
      ([2, 0, 0, 1], 9, 19, (-1 : Int)).2.2.1 ([2, 0, 0, 1], 9, 19, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s178.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 0, 1] 9 19 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s178
theorem z7UnaryRows8_s179 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 0, 2] 8 16 (0 : Int))
    (z7UnaryCode8_s179.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s179_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 0, 2], 8, 16, (0 : Int)).1 ([2, 0, 0, 2], 8, 16, (0 : Int)).2.1
      ([2, 0, 0, 2], 8, 16, (0 : Int)).2.2.1 ([2, 0, 0, 2], 8, 16, (0 : Int)).2.2.2 =
    z7UnaryCode8_s179.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 0, 2] 8 16 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s179
theorem z7UnaryRows8_s180 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 0, 3] 7 11 (1 : Int))
    (z7UnaryCode8_s180.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s180_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 0, 3], 7, 11, (1 : Int)).1 ([2, 0, 0, 3], 7, 11, (1 : Int)).2.1
      ([2, 0, 0, 3], 7, 11, (1 : Int)).2.2.1 ([2, 0, 0, 3], 7, 11, (1 : Int)).2.2.2 =
    z7UnaryCode8_s180.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 0, 3] 7 11 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s180
theorem z7UnaryRows8_s181 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 0, 4] 6 4 (2 : Int))
    (z7UnaryCode8_s181.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s181_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 0, 4], 6, 4, (2 : Int)).1 ([2, 0, 0, 4], 6, 4, (2 : Int)).2.1
      ([2, 0, 0, 4], 6, 4, (2 : Int)).2.2.1 ([2, 0, 0, 4], 6, 4, (2 : Int)).2.2.2 =
    z7UnaryCode8_s181.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 0, 4] 6 4 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s181
theorem z7UnaryRows8_s182 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 1, 0] 9 19 (-3 : Int))
    (z7UnaryCode8_s182.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s182_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 1, 0], 9, 19, (-3 : Int)).1 ([2, 0, 1, 0], 9, 19, (-3 : Int)).2.1
      ([2, 0, 1, 0], 9, 19, (-3 : Int)).2.2.1 ([2, 0, 1, 0], 9, 19, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s182.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 1, 0] 9 19 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s182
theorem z7UnaryRows8_s183 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 1, 1] 8 18 (-2 : Int))
    (z7UnaryCode8_s183.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s183_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 1, 1], 8, 18, (-2 : Int)).1 ([2, 0, 1, 1], 8, 18, (-2 : Int)).2.1
      ([2, 0, 1, 1], 8, 18, (-2 : Int)).2.2.1 ([2, 0, 1, 1], 8, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s183.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 1, 1] 8 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s183
theorem z7UnaryRows8_s184 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 1, 2] 7 15 (-1 : Int))
    (z7UnaryCode8_s184.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s184_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 1, 2], 7, 15, (-1 : Int)).1 ([2, 0, 1, 2], 7, 15, (-1 : Int)).2.1
      ([2, 0, 1, 2], 7, 15, (-1 : Int)).2.2.1 ([2, 0, 1, 2], 7, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s184.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 1, 2] 7 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s184
theorem z7UnaryRows8_s185 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 1, 3] 6 10 (0 : Int))
    (z7UnaryCode8_s185.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s185_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 1, 3], 6, 10, (0 : Int)).1 ([2, 0, 1, 3], 6, 10, (0 : Int)).2.1
      ([2, 0, 1, 3], 6, 10, (0 : Int)).2.2.1 ([2, 0, 1, 3], 6, 10, (0 : Int)).2.2.2 =
    z7UnaryCode8_s185.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 1, 3] 6 10 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s185
theorem z7UnaryRows8_s186 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 1, 4] 5 3 (1 : Int))
    (z7UnaryCode8_s186.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s186_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 1, 4], 5, 3, (1 : Int)).1 ([2, 0, 1, 4], 5, 3, (1 : Int)).2.1
      ([2, 0, 1, 4], 5, 3, (1 : Int)).2.2.1 ([2, 0, 1, 4], 5, 3, (1 : Int)).2.2.2 =
    z7UnaryCode8_s186.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 1, 4] 5 3 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s186
theorem z7UnaryRows8_s187 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 2, 0] 8 16 (-4 : Int))
    (z7UnaryCode8_s187.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s187_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 2, 0], 8, 16, (-4 : Int)).1 ([2, 0, 2, 0], 8, 16, (-4 : Int)).2.1
      ([2, 0, 2, 0], 8, 16, (-4 : Int)).2.2.1 ([2, 0, 2, 0], 8, 16, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s187.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 2, 0] 8 16 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s187
theorem z7UnaryRows8_s188 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 2, 1] 7 15 (-3 : Int))
    (z7UnaryCode8_s188.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s188_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 2, 1], 7, 15, (-3 : Int)).1 ([2, 0, 2, 1], 7, 15, (-3 : Int)).2.1
      ([2, 0, 2, 1], 7, 15, (-3 : Int)).2.2.1 ([2, 0, 2, 1], 7, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s188.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 2, 1] 7 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s188
theorem z7UnaryRows8_s189 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 2, 2] 6 12 (-2 : Int))
    (z7UnaryCode8_s189.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s189_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 2, 2], 6, 12, (-2 : Int)).1 ([2, 0, 2, 2], 6, 12, (-2 : Int)).2.1
      ([2, 0, 2, 2], 6, 12, (-2 : Int)).2.2.1 ([2, 0, 2, 2], 6, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s189.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 2, 2] 6 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s189
theorem z7UnaryRows8_s190 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 2, 3] 5 7 (-1 : Int))
    (z7UnaryCode8_s190.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s190_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 2, 3], 5, 7, (-1 : Int)).1 ([2, 0, 2, 3], 5, 7, (-1 : Int)).2.1
      ([2, 0, 2, 3], 5, 7, (-1 : Int)).2.2.1 ([2, 0, 2, 3], 5, 7, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s190.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 2, 3] 5 7 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s190
theorem z7UnaryRows8_s191 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 2, 4] 4 0 (0 : Int))
    (z7UnaryCode8_s191.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s191_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 2, 4], 4, 0, (0 : Int)).1 ([2, 0, 2, 4], 4, 0, (0 : Int)).2.1
      ([2, 0, 2, 4], 4, 0, (0 : Int)).2.2.1 ([2, 0, 2, 4], 4, 0, (0 : Int)).2.2.2 =
    z7UnaryCode8_s191.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 2, 4] 4 0 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s191
theorem z7UnaryRows8_s192 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 3, 0] 7 11 (-5 : Int))
    (z7UnaryCode8_s192.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s192_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 3, 0], 7, 11, (-5 : Int)).1 ([2, 0, 3, 0], 7, 11, (-5 : Int)).2.1
      ([2, 0, 3, 0], 7, 11, (-5 : Int)).2.2.1 ([2, 0, 3, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s192.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 3, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s192
theorem z7UnaryRows8_s193 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 3, 1] 6 10 (-4 : Int))
    (z7UnaryCode8_s193.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s193_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 3, 1], 6, 10, (-4 : Int)).1 ([2, 0, 3, 1], 6, 10, (-4 : Int)).2.1
      ([2, 0, 3, 1], 6, 10, (-4 : Int)).2.2.1 ([2, 0, 3, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s193.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 3, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s193
theorem z7UnaryRows8_s194 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 3, 2] 5 7 (-3 : Int))
    (z7UnaryCode8_s194.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s194_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 3, 2], 5, 7, (-3 : Int)).1 ([2, 0, 3, 2], 5, 7, (-3 : Int)).2.1
      ([2, 0, 3, 2], 5, 7, (-3 : Int)).2.2.1 ([2, 0, 3, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s194.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 3, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s194
theorem z7UnaryRows8_s195 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 3, 3] 4 2 (-2 : Int))
    (z7UnaryCode8_s195.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s195_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 3, 3], 4, 2, (-2 : Int)).1 ([2, 0, 3, 3], 4, 2, (-2 : Int)).2.1
      ([2, 0, 3, 3], 4, 2, (-2 : Int)).2.2.1 ([2, 0, 3, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s195.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 3, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s195
theorem z7UnaryRows8_s196 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 4, 0] 6 4 (-6 : Int))
    (z7UnaryCode8_s196.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s196_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 4, 0], 6, 4, (-6 : Int)).1 ([2, 0, 4, 0], 6, 4, (-6 : Int)).2.1
      ([2, 0, 4, 0], 6, 4, (-6 : Int)).2.2.1 ([2, 0, 4, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s196.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 4, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s196
theorem z7UnaryRows8_s197 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 4, 1] 5 3 (-5 : Int))
    (z7UnaryCode8_s197.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s197_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 4, 1], 5, 3, (-5 : Int)).1 ([2, 0, 4, 1], 5, 3, (-5 : Int)).2.1
      ([2, 0, 4, 1], 5, 3, (-5 : Int)).2.2.1 ([2, 0, 4, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s197.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 4, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s197
theorem z7UnaryRows8_s198 : rowsBeq
    (z7GenRow 8 8 4 [2, 0, 4, 2] 4 0 (-4 : Int))
    (z7UnaryCode8_s198.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s198_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 0, 4, 2], 4, 0, (-4 : Int)).1 ([2, 0, 4, 2], 4, 0, (-4 : Int)).2.1
      ([2, 0, 4, 2], 4, 0, (-4 : Int)).2.2.1 ([2, 0, 4, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s198.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 0, 4, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s198
theorem z7UnaryRows8_s199 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 0, 0] 9 19 (-3 : Int))
    (z7UnaryCode8_s199.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s199_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 0, 0], 9, 19, (-3 : Int)).1 ([2, 1, 0, 0], 9, 19, (-3 : Int)).2.1
      ([2, 1, 0, 0], 9, 19, (-3 : Int)).2.2.1 ([2, 1, 0, 0], 9, 19, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s199.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 0, 0] 9 19 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s199
theorem z7UnaryRows8_s200 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 0, 1] 8 18 (-2 : Int))
    (z7UnaryCode8_s200.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s200_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 0, 1], 8, 18, (-2 : Int)).1 ([2, 1, 0, 1], 8, 18, (-2 : Int)).2.1
      ([2, 1, 0, 1], 8, 18, (-2 : Int)).2.2.1 ([2, 1, 0, 1], 8, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s200.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 0, 1] 8 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s200
theorem z7UnaryRows8_s201 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 0, 2] 7 15 (-1 : Int))
    (z7UnaryCode8_s201.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s201_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 0, 2], 7, 15, (-1 : Int)).1 ([2, 1, 0, 2], 7, 15, (-1 : Int)).2.1
      ([2, 1, 0, 2], 7, 15, (-1 : Int)).2.2.1 ([2, 1, 0, 2], 7, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s201.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 0, 2] 7 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s201
theorem z7UnaryRows8_s202 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 0, 3] 6 10 (0 : Int))
    (z7UnaryCode8_s202.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s202_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 0, 3], 6, 10, (0 : Int)).1 ([2, 1, 0, 3], 6, 10, (0 : Int)).2.1
      ([2, 1, 0, 3], 6, 10, (0 : Int)).2.2.1 ([2, 1, 0, 3], 6, 10, (0 : Int)).2.2.2 =
    z7UnaryCode8_s202.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 0, 3] 6 10 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s202
theorem z7UnaryRows8_s203 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 0, 4] 5 3 (1 : Int))
    (z7UnaryCode8_s203.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s203_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 0, 4], 5, 3, (1 : Int)).1 ([2, 1, 0, 4], 5, 3, (1 : Int)).2.1
      ([2, 1, 0, 4], 5, 3, (1 : Int)).2.2.1 ([2, 1, 0, 4], 5, 3, (1 : Int)).2.2.2 =
    z7UnaryCode8_s203.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 0, 4] 5 3 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s203
theorem z7UnaryRows8_s204 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 1, 0] 8 18 (-4 : Int))
    (z7UnaryCode8_s204.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s204_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 1, 0], 8, 18, (-4 : Int)).1 ([2, 1, 1, 0], 8, 18, (-4 : Int)).2.1
      ([2, 1, 1, 0], 8, 18, (-4 : Int)).2.2.1 ([2, 1, 1, 0], 8, 18, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s204.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 1, 0] 8 18 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s204
theorem z7UnaryRows8_s205 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 1, 1] 7 17 (-3 : Int))
    (z7UnaryCode8_s205.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s205_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 1, 1], 7, 17, (-3 : Int)).1 ([2, 1, 1, 1], 7, 17, (-3 : Int)).2.1
      ([2, 1, 1, 1], 7, 17, (-3 : Int)).2.2.1 ([2, 1, 1, 1], 7, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s205.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 1, 1] 7 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s205
theorem z7UnaryRows8_s206 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 1, 2] 6 14 (-2 : Int))
    (z7UnaryCode8_s206.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s206_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 1, 2], 6, 14, (-2 : Int)).1 ([2, 1, 1, 2], 6, 14, (-2 : Int)).2.1
      ([2, 1, 1, 2], 6, 14, (-2 : Int)).2.2.1 ([2, 1, 1, 2], 6, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s206.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 1, 2] 6 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s206
theorem z7UnaryRows8_s207 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 1, 3] 5 9 (-1 : Int))
    (z7UnaryCode8_s207.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s207_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 1, 3], 5, 9, (-1 : Int)).1 ([2, 1, 1, 3], 5, 9, (-1 : Int)).2.1
      ([2, 1, 1, 3], 5, 9, (-1 : Int)).2.2.1 ([2, 1, 1, 3], 5, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s207.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 1, 3] 5 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s207
theorem z7UnaryRows8_s208 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 1, 4] 4 2 (0 : Int))
    (z7UnaryCode8_s208.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s208_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 1, 4], 4, 2, (0 : Int)).1 ([2, 1, 1, 4], 4, 2, (0 : Int)).2.1
      ([2, 1, 1, 4], 4, 2, (0 : Int)).2.2.1 ([2, 1, 1, 4], 4, 2, (0 : Int)).2.2.2 =
    z7UnaryCode8_s208.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 1, 4] 4 2 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s208
theorem z7UnaryRows8_s209 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 2, 0] 7 15 (-5 : Int))
    (z7UnaryCode8_s209.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s209_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 2, 0], 7, 15, (-5 : Int)).1 ([2, 1, 2, 0], 7, 15, (-5 : Int)).2.1
      ([2, 1, 2, 0], 7, 15, (-5 : Int)).2.2.1 ([2, 1, 2, 0], 7, 15, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s209.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 2, 0] 7 15 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s209
theorem z7UnaryRows8_s210 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 2, 1] 6 14 (-4 : Int))
    (z7UnaryCode8_s210.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s210_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 2, 1], 6, 14, (-4 : Int)).1 ([2, 1, 2, 1], 6, 14, (-4 : Int)).2.1
      ([2, 1, 2, 1], 6, 14, (-4 : Int)).2.2.1 ([2, 1, 2, 1], 6, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s210.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 2, 1] 6 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s210
theorem z7UnaryRows8_s211 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 2, 2] 5 11 (-3 : Int))
    (z7UnaryCode8_s211.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s211_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 2, 2], 5, 11, (-3 : Int)).1 ([2, 1, 2, 2], 5, 11, (-3 : Int)).2.1
      ([2, 1, 2, 2], 5, 11, (-3 : Int)).2.2.1 ([2, 1, 2, 2], 5, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s211.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 2, 2] 5 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s211
theorem z7UnaryRows8_s212 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 2, 3] 4 6 (-2 : Int))
    (z7UnaryCode8_s212.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s212_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 2, 3], 4, 6, (-2 : Int)).1 ([2, 1, 2, 3], 4, 6, (-2 : Int)).2.1
      ([2, 1, 2, 3], 4, 6, (-2 : Int)).2.2.1 ([2, 1, 2, 3], 4, 6, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s212.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 2, 3] 4 6 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s212
theorem z7UnaryRows8_s213 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 3, 0] 6 10 (-6 : Int))
    (z7UnaryCode8_s213.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s213_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 3, 0], 6, 10, (-6 : Int)).1 ([2, 1, 3, 0], 6, 10, (-6 : Int)).2.1
      ([2, 1, 3, 0], 6, 10, (-6 : Int)).2.2.1 ([2, 1, 3, 0], 6, 10, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s213.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 3, 0] 6 10 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s213
theorem z7UnaryRows8_s214 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 3, 1] 5 9 (-5 : Int))
    (z7UnaryCode8_s214.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s214_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 3, 1], 5, 9, (-5 : Int)).1 ([2, 1, 3, 1], 5, 9, (-5 : Int)).2.1
      ([2, 1, 3, 1], 5, 9, (-5 : Int)).2.2.1 ([2, 1, 3, 1], 5, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s214.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 3, 1] 5 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s214
theorem z7UnaryRows8_s215 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 3, 2] 4 6 (-4 : Int))
    (z7UnaryCode8_s215.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s215_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 3, 2], 4, 6, (-4 : Int)).1 ([2, 1, 3, 2], 4, 6, (-4 : Int)).2.1
      ([2, 1, 3, 2], 4, 6, (-4 : Int)).2.2.1 ([2, 1, 3, 2], 4, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s215.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 3, 2] 4 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s215
theorem z7UnaryRows8_s216 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 3, 3] 3 1 (-3 : Int))
    (z7UnaryCode8_s216.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s216_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 3, 3], 3, 1, (-3 : Int)).1 ([2, 1, 3, 3], 3, 1, (-3 : Int)).2.1
      ([2, 1, 3, 3], 3, 1, (-3 : Int)).2.2.1 ([2, 1, 3, 3], 3, 1, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s216.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 3, 3] 3 1 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s216
theorem z7UnaryRows8_s217 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 4, 0] 5 3 (-7 : Int))
    (z7UnaryCode8_s217.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s217_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 4, 0], 5, 3, (-7 : Int)).1 ([2, 1, 4, 0], 5, 3, (-7 : Int)).2.1
      ([2, 1, 4, 0], 5, 3, (-7 : Int)).2.2.1 ([2, 1, 4, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s217.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 4, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s217
theorem z7UnaryRows8_s218 : rowsBeq
    (z7GenRow 8 8 4 [2, 1, 4, 1] 4 2 (-6 : Int))
    (z7UnaryCode8_s218.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s218_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 1, 4, 1], 4, 2, (-6 : Int)).1 ([2, 1, 4, 1], 4, 2, (-6 : Int)).2.1
      ([2, 1, 4, 1], 4, 2, (-6 : Int)).2.2.1 ([2, 1, 4, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s218.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 1, 4, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s218
theorem z7UnaryRows8_s219 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 0, 0] 8 16 (-4 : Int))
    (z7UnaryCode8_s219.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s219_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 0, 0], 8, 16, (-4 : Int)).1 ([2, 2, 0, 0], 8, 16, (-4 : Int)).2.1
      ([2, 2, 0, 0], 8, 16, (-4 : Int)).2.2.1 ([2, 2, 0, 0], 8, 16, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s219.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 0, 0] 8 16 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s219
theorem z7UnaryRows8_s220 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 0, 1] 7 15 (-3 : Int))
    (z7UnaryCode8_s220.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s220_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 0, 1], 7, 15, (-3 : Int)).1 ([2, 2, 0, 1], 7, 15, (-3 : Int)).2.1
      ([2, 2, 0, 1], 7, 15, (-3 : Int)).2.2.1 ([2, 2, 0, 1], 7, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s220.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 0, 1] 7 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s220
theorem z7UnaryRows8_s221 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 0, 2] 6 12 (-2 : Int))
    (z7UnaryCode8_s221.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s221_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 0, 2], 6, 12, (-2 : Int)).1 ([2, 2, 0, 2], 6, 12, (-2 : Int)).2.1
      ([2, 2, 0, 2], 6, 12, (-2 : Int)).2.2.1 ([2, 2, 0, 2], 6, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s221.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 0, 2] 6 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s221
theorem z7UnaryRows8_s222 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 0, 3] 5 7 (-1 : Int))
    (z7UnaryCode8_s222.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s222_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 0, 3], 5, 7, (-1 : Int)).1 ([2, 2, 0, 3], 5, 7, (-1 : Int)).2.1
      ([2, 2, 0, 3], 5, 7, (-1 : Int)).2.2.1 ([2, 2, 0, 3], 5, 7, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s222.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 0, 3] 5 7 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s222
theorem z7UnaryRows8_s223 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 0, 4] 4 0 (0 : Int))
    (z7UnaryCode8_s223.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s223_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 0, 4], 4, 0, (0 : Int)).1 ([2, 2, 0, 4], 4, 0, (0 : Int)).2.1
      ([2, 2, 0, 4], 4, 0, (0 : Int)).2.2.1 ([2, 2, 0, 4], 4, 0, (0 : Int)).2.2.2 =
    z7UnaryCode8_s223.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 0, 4] 4 0 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s223
theorem z7UnaryRows8_s224 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 1, 0] 7 15 (-5 : Int))
    (z7UnaryCode8_s224.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s224_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 1, 0], 7, 15, (-5 : Int)).1 ([2, 2, 1, 0], 7, 15, (-5 : Int)).2.1
      ([2, 2, 1, 0], 7, 15, (-5 : Int)).2.2.1 ([2, 2, 1, 0], 7, 15, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s224.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 1, 0] 7 15 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s224
theorem z7UnaryRows8_s225 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 1, 1] 6 14 (-4 : Int))
    (z7UnaryCode8_s225.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s225_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 1, 1], 6, 14, (-4 : Int)).1 ([2, 2, 1, 1], 6, 14, (-4 : Int)).2.1
      ([2, 2, 1, 1], 6, 14, (-4 : Int)).2.2.1 ([2, 2, 1, 1], 6, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s225.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 1, 1] 6 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s225
theorem z7UnaryRows8_s226 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 1, 2] 5 11 (-3 : Int))
    (z7UnaryCode8_s226.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s226_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 1, 2], 5, 11, (-3 : Int)).1 ([2, 2, 1, 2], 5, 11, (-3 : Int)).2.1
      ([2, 2, 1, 2], 5, 11, (-3 : Int)).2.2.1 ([2, 2, 1, 2], 5, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s226.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 1, 2] 5 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s226
theorem z7UnaryRows8_s227 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 1, 3] 4 6 (-2 : Int))
    (z7UnaryCode8_s227.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s227_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 1, 3], 4, 6, (-2 : Int)).1 ([2, 2, 1, 3], 4, 6, (-2 : Int)).2.1
      ([2, 2, 1, 3], 4, 6, (-2 : Int)).2.2.1 ([2, 2, 1, 3], 4, 6, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s227.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 1, 3] 4 6 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s227
theorem z7UnaryRows8_s228 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 2, 0] 6 12 (-6 : Int))
    (z7UnaryCode8_s228.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s228_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 2, 0], 6, 12, (-6 : Int)).1 ([2, 2, 2, 0], 6, 12, (-6 : Int)).2.1
      ([2, 2, 2, 0], 6, 12, (-6 : Int)).2.2.1 ([2, 2, 2, 0], 6, 12, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s228.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 2, 0] 6 12 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s228
theorem z7UnaryRows8_s229 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 2, 1] 5 11 (-5 : Int))
    (z7UnaryCode8_s229.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s229_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 2, 1], 5, 11, (-5 : Int)).1 ([2, 2, 2, 1], 5, 11, (-5 : Int)).2.1
      ([2, 2, 2, 1], 5, 11, (-5 : Int)).2.2.1 ([2, 2, 2, 1], 5, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s229.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 2, 1] 5 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s229
theorem z7UnaryRows8_s230 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 2, 2] 4 8 (-4 : Int))
    (z7UnaryCode8_s230.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s230_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 2, 2], 4, 8, (-4 : Int)).1 ([2, 2, 2, 2], 4, 8, (-4 : Int)).2.1
      ([2, 2, 2, 2], 4, 8, (-4 : Int)).2.2.1 ([2, 2, 2, 2], 4, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s230.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 2, 2] 4 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s230
theorem z7UnaryRows8_s231 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 2, 3] 3 3 (-3 : Int))
    (z7UnaryCode8_s231.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s231_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 2, 3], 3, 3, (-3 : Int)).1 ([2, 2, 2, 3], 3, 3, (-3 : Int)).2.1
      ([2, 2, 2, 3], 3, 3, (-3 : Int)).2.2.1 ([2, 2, 2, 3], 3, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s231.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 2, 3] 3 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s231
theorem z7UnaryRows8_s232 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 3, 0] 5 7 (-7 : Int))
    (z7UnaryCode8_s232.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s232_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 3, 0], 5, 7, (-7 : Int)).1 ([2, 2, 3, 0], 5, 7, (-7 : Int)).2.1
      ([2, 2, 3, 0], 5, 7, (-7 : Int)).2.2.1 ([2, 2, 3, 0], 5, 7, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s232.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 3, 0] 5 7 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s232
theorem z7UnaryRows8_s233 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 3, 1] 4 6 (-6 : Int))
    (z7UnaryCode8_s233.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s233_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 3, 1], 4, 6, (-6 : Int)).1 ([2, 2, 3, 1], 4, 6, (-6 : Int)).2.1
      ([2, 2, 3, 1], 4, 6, (-6 : Int)).2.2.1 ([2, 2, 3, 1], 4, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s233.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 3, 1] 4 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s233
theorem z7UnaryRows8_s234 : rowsBeq
    (z7GenRow 8 8 4 [2, 2, 3, 2] 3 3 (-5 : Int))
    (z7UnaryCode8_s234.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s234_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 2, 3, 2], 3, 3, (-5 : Int)).1 ([2, 2, 3, 2], 3, 3, (-5 : Int)).2.1
      ([2, 2, 3, 2], 3, 3, (-5 : Int)).2.2.1 ([2, 2, 3, 2], 3, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s234.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 2, 3, 2] 3 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s234
theorem z7UnaryRows8_s235 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 0, 0] 7 11 (-5 : Int))
    (z7UnaryCode8_s235.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s235_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 0, 0], 7, 11, (-5 : Int)).1 ([2, 3, 0, 0], 7, 11, (-5 : Int)).2.1
      ([2, 3, 0, 0], 7, 11, (-5 : Int)).2.2.1 ([2, 3, 0, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s235.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 0, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s235
theorem z7UnaryRows8_s236 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 0, 1] 6 10 (-4 : Int))
    (z7UnaryCode8_s236.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s236_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 0, 1], 6, 10, (-4 : Int)).1 ([2, 3, 0, 1], 6, 10, (-4 : Int)).2.1
      ([2, 3, 0, 1], 6, 10, (-4 : Int)).2.2.1 ([2, 3, 0, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s236.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 0, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s236
theorem z7UnaryRows8_s237 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 0, 2] 5 7 (-3 : Int))
    (z7UnaryCode8_s237.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s237_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 0, 2], 5, 7, (-3 : Int)).1 ([2, 3, 0, 2], 5, 7, (-3 : Int)).2.1
      ([2, 3, 0, 2], 5, 7, (-3 : Int)).2.2.1 ([2, 3, 0, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s237.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 0, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s237
theorem z7UnaryRows8_s238 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 0, 3] 4 2 (-2 : Int))
    (z7UnaryCode8_s238.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s238_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 0, 3], 4, 2, (-2 : Int)).1 ([2, 3, 0, 3], 4, 2, (-2 : Int)).2.1
      ([2, 3, 0, 3], 4, 2, (-2 : Int)).2.2.1 ([2, 3, 0, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s238.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 0, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s238
theorem z7UnaryRows8_s239 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 1, 0] 6 10 (-6 : Int))
    (z7UnaryCode8_s239.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s239_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 1, 0], 6, 10, (-6 : Int)).1 ([2, 3, 1, 0], 6, 10, (-6 : Int)).2.1
      ([2, 3, 1, 0], 6, 10, (-6 : Int)).2.2.1 ([2, 3, 1, 0], 6, 10, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s239.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 1, 0] 6 10 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s239
theorem z7UnaryRows8_s240 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 1, 1] 5 9 (-5 : Int))
    (z7UnaryCode8_s240.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s240_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 1, 1], 5, 9, (-5 : Int)).1 ([2, 3, 1, 1], 5, 9, (-5 : Int)).2.1
      ([2, 3, 1, 1], 5, 9, (-5 : Int)).2.2.1 ([2, 3, 1, 1], 5, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s240.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 1, 1] 5 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s240
theorem z7UnaryRows8_s241 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 1, 2] 4 6 (-4 : Int))
    (z7UnaryCode8_s241.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s241_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 1, 2], 4, 6, (-4 : Int)).1 ([2, 3, 1, 2], 4, 6, (-4 : Int)).2.1
      ([2, 3, 1, 2], 4, 6, (-4 : Int)).2.2.1 ([2, 3, 1, 2], 4, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s241.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 1, 2] 4 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s241
theorem z7UnaryRows8_s242 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 1, 3] 3 1 (-3 : Int))
    (z7UnaryCode8_s242.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s242_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 1, 3], 3, 1, (-3 : Int)).1 ([2, 3, 1, 3], 3, 1, (-3 : Int)).2.1
      ([2, 3, 1, 3], 3, 1, (-3 : Int)).2.2.1 ([2, 3, 1, 3], 3, 1, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s242.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 1, 3] 3 1 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s242
theorem z7UnaryRows8_s243 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 2, 0] 5 7 (-7 : Int))
    (z7UnaryCode8_s243.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s243_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 2, 0], 5, 7, (-7 : Int)).1 ([2, 3, 2, 0], 5, 7, (-7 : Int)).2.1
      ([2, 3, 2, 0], 5, 7, (-7 : Int)).2.2.1 ([2, 3, 2, 0], 5, 7, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s243.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 2, 0] 5 7 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s243
theorem z7UnaryRows8_s244 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 2, 1] 4 6 (-6 : Int))
    (z7UnaryCode8_s244.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s244_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 2, 1], 4, 6, (-6 : Int)).1 ([2, 3, 2, 1], 4, 6, (-6 : Int)).2.1
      ([2, 3, 2, 1], 4, 6, (-6 : Int)).2.2.1 ([2, 3, 2, 1], 4, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s244.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 2, 1] 4 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s244
theorem z7UnaryRows8_s245 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 2, 2] 3 3 (-5 : Int))
    (z7UnaryCode8_s245.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s245_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 2, 2], 3, 3, (-5 : Int)).1 ([2, 3, 2, 2], 3, 3, (-5 : Int)).2.1
      ([2, 3, 2, 2], 3, 3, (-5 : Int)).2.2.1 ([2, 3, 2, 2], 3, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s245.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 2, 2] 3 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s245
theorem z7UnaryRows8_s246 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 3, 0] 4 2 (-8 : Int))
    (z7UnaryCode8_s246.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s246_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 3, 0], 4, 2, (-8 : Int)).1 ([2, 3, 3, 0], 4, 2, (-8 : Int)).2.1
      ([2, 3, 3, 0], 4, 2, (-8 : Int)).2.2.1 ([2, 3, 3, 0], 4, 2, (-8 : Int)).2.2.2 =
    z7UnaryCode8_s246.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 3, 0] 4 2 (-8 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s246
theorem z7UnaryRows8_s247 : rowsBeq
    (z7GenRow 8 8 4 [2, 3, 3, 1] 3 1 (-7 : Int))
    (z7UnaryCode8_s247.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s247_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 3, 3, 1], 3, 1, (-7 : Int)).1 ([2, 3, 3, 1], 3, 1, (-7 : Int)).2.1
      ([2, 3, 3, 1], 3, 1, (-7 : Int)).2.2.1 ([2, 3, 3, 1], 3, 1, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s247.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 3, 3, 1] 3 1 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s247
theorem z7UnaryRows8_s248 : rowsBeq
    (z7GenRow 8 8 4 [2, 4, 0, 0] 6 4 (-6 : Int))
    (z7UnaryCode8_s248.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s248_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 4, 0, 0], 6, 4, (-6 : Int)).1 ([2, 4, 0, 0], 6, 4, (-6 : Int)).2.1
      ([2, 4, 0, 0], 6, 4, (-6 : Int)).2.2.1 ([2, 4, 0, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s248.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 4, 0, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s248
theorem z7UnaryRows8_s249 : rowsBeq
    (z7GenRow 8 8 4 [2, 4, 0, 1] 5 3 (-5 : Int))
    (z7UnaryCode8_s249.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s249_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 4, 0, 1], 5, 3, (-5 : Int)).1 ([2, 4, 0, 1], 5, 3, (-5 : Int)).2.1
      ([2, 4, 0, 1], 5, 3, (-5 : Int)).2.2.1 ([2, 4, 0, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s249.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 4, 0, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s249
theorem z7UnaryRows8_s250 : rowsBeq
    (z7GenRow 8 8 4 [2, 4, 0, 2] 4 0 (-4 : Int))
    (z7UnaryCode8_s250.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s250_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 4, 0, 2], 4, 0, (-4 : Int)).1 ([2, 4, 0, 2], 4, 0, (-4 : Int)).2.1
      ([2, 4, 0, 2], 4, 0, (-4 : Int)).2.2.1 ([2, 4, 0, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s250.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 4, 0, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s250
theorem z7UnaryRows8_s251 : rowsBeq
    (z7GenRow 8 8 4 [2, 4, 1, 0] 5 3 (-7 : Int))
    (z7UnaryCode8_s251.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s251_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 4, 1, 0], 5, 3, (-7 : Int)).1 ([2, 4, 1, 0], 5, 3, (-7 : Int)).2.1
      ([2, 4, 1, 0], 5, 3, (-7 : Int)).2.2.1 ([2, 4, 1, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s251.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 4, 1, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s251
theorem z7UnaryRows8_s252 : rowsBeq
    (z7GenRow 8 8 4 [2, 4, 1, 1] 4 2 (-6 : Int))
    (z7UnaryCode8_s252.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s252_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([2, 4, 1, 1], 4, 2, (-6 : Int)).1 ([2, 4, 1, 1], 4, 2, (-6 : Int)).2.1
      ([2, 4, 1, 1], 4, 2, (-6 : Int)).2.2.1 ([2, 4, 1, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s252.map z7DecodeRow := by
  show z7GenRow 8 8 4 [2, 4, 1, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s252
theorem z7UnaryRows8_s253 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 0, 0] 9 15 (-3 : Int))
    (z7UnaryCode8_s253.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s253_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 0, 0], 9, 15, (-3 : Int)).1 ([3, 0, 0, 0], 9, 15, (-3 : Int)).2.1
      ([3, 0, 0, 0], 9, 15, (-3 : Int)).2.2.1 ([3, 0, 0, 0], 9, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s253.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 0, 0] 9 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s253
theorem z7UnaryRows8_s254 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 0, 1] 8 14 (-2 : Int))
    (z7UnaryCode8_s254.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s254_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 0, 1], 8, 14, (-2 : Int)).1 ([3, 0, 0, 1], 8, 14, (-2 : Int)).2.1
      ([3, 0, 0, 1], 8, 14, (-2 : Int)).2.2.1 ([3, 0, 0, 1], 8, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s254.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 0, 1] 8 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s254
theorem z7UnaryRows8_s255 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 0, 2] 7 11 (-1 : Int))
    (z7UnaryCode8_s255.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s255_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 0, 2], 7, 11, (-1 : Int)).1 ([3, 0, 0, 2], 7, 11, (-1 : Int)).2.1
      ([3, 0, 0, 2], 7, 11, (-1 : Int)).2.2.1 ([3, 0, 0, 2], 7, 11, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s255.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 0, 2] 7 11 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s255
theorem z7UnaryRows8_s256 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 0, 3] 6 6 (0 : Int))
    (z7UnaryCode8_s256.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s256_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 0, 3], 6, 6, (0 : Int)).1 ([3, 0, 0, 3], 6, 6, (0 : Int)).2.1
      ([3, 0, 0, 3], 6, 6, (0 : Int)).2.2.1 ([3, 0, 0, 3], 6, 6, (0 : Int)).2.2.2 =
    z7UnaryCode8_s256.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 0, 3] 6 6 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s256
theorem z7UnaryRows8_s257 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 1, 0] 8 14 (-4 : Int))
    (z7UnaryCode8_s257.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s257_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 1, 0], 8, 14, (-4 : Int)).1 ([3, 0, 1, 0], 8, 14, (-4 : Int)).2.1
      ([3, 0, 1, 0], 8, 14, (-4 : Int)).2.2.1 ([3, 0, 1, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s257.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 1, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s257
theorem z7UnaryRows8_s258 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 1, 1] 7 13 (-3 : Int))
    (z7UnaryCode8_s258.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s258_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 1, 1], 7, 13, (-3 : Int)).1 ([3, 0, 1, 1], 7, 13, (-3 : Int)).2.1
      ([3, 0, 1, 1], 7, 13, (-3 : Int)).2.2.1 ([3, 0, 1, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s258.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 1, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s258
theorem z7UnaryRows8_s259 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 1, 2] 6 10 (-2 : Int))
    (z7UnaryCode8_s259.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s259_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 1, 2], 6, 10, (-2 : Int)).1 ([3, 0, 1, 2], 6, 10, (-2 : Int)).2.1
      ([3, 0, 1, 2], 6, 10, (-2 : Int)).2.2.1 ([3, 0, 1, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s259.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 1, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s259
theorem z7UnaryRows8_s260 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 1, 3] 5 5 (-1 : Int))
    (z7UnaryCode8_s260.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s260_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 1, 3], 5, 5, (-1 : Int)).1 ([3, 0, 1, 3], 5, 5, (-1 : Int)).2.1
      ([3, 0, 1, 3], 5, 5, (-1 : Int)).2.2.1 ([3, 0, 1, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s260.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 1, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s260
theorem z7UnaryRows8_s261 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 2, 0] 7 11 (-5 : Int))
    (z7UnaryCode8_s261.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s261_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 2, 0], 7, 11, (-5 : Int)).1 ([3, 0, 2, 0], 7, 11, (-5 : Int)).2.1
      ([3, 0, 2, 0], 7, 11, (-5 : Int)).2.2.1 ([3, 0, 2, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s261.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 2, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s261
theorem z7UnaryRows8_s262 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 2, 1] 6 10 (-4 : Int))
    (z7UnaryCode8_s262.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s262_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 2, 1], 6, 10, (-4 : Int)).1 ([3, 0, 2, 1], 6, 10, (-4 : Int)).2.1
      ([3, 0, 2, 1], 6, 10, (-4 : Int)).2.2.1 ([3, 0, 2, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s262.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 2, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s262
theorem z7UnaryRows8_s263 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 2, 2] 5 7 (-3 : Int))
    (z7UnaryCode8_s263.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s263_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 2, 2], 5, 7, (-3 : Int)).1 ([3, 0, 2, 2], 5, 7, (-3 : Int)).2.1
      ([3, 0, 2, 2], 5, 7, (-3 : Int)).2.2.1 ([3, 0, 2, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s263.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 2, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s263
theorem z7UnaryRows8_s264 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 2, 3] 4 2 (-2 : Int))
    (z7UnaryCode8_s264.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s264_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 2, 3], 4, 2, (-2 : Int)).1 ([3, 0, 2, 3], 4, 2, (-2 : Int)).2.1
      ([3, 0, 2, 3], 4, 2, (-2 : Int)).2.2.1 ([3, 0, 2, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s264.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 2, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s264
theorem z7UnaryRows8_s265 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 3, 0] 6 6 (-6 : Int))
    (z7UnaryCode8_s265.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s265_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 3, 0], 6, 6, (-6 : Int)).1 ([3, 0, 3, 0], 6, 6, (-6 : Int)).2.1
      ([3, 0, 3, 0], 6, 6, (-6 : Int)).2.2.1 ([3, 0, 3, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s265.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 3, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s265
theorem z7UnaryRows8_s266 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 3, 1] 5 5 (-5 : Int))
    (z7UnaryCode8_s266.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s266_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 3, 1], 5, 5, (-5 : Int)).1 ([3, 0, 3, 1], 5, 5, (-5 : Int)).2.1
      ([3, 0, 3, 1], 5, 5, (-5 : Int)).2.2.1 ([3, 0, 3, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s266.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 3, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s266
theorem z7UnaryRows8_s267 : rowsBeq
    (z7GenRow 8 8 4 [3, 0, 3, 2] 4 2 (-4 : Int))
    (z7UnaryCode8_s267.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s267_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 0, 3, 2], 4, 2, (-4 : Int)).1 ([3, 0, 3, 2], 4, 2, (-4 : Int)).2.1
      ([3, 0, 3, 2], 4, 2, (-4 : Int)).2.2.1 ([3, 0, 3, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s267.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 0, 3, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s267
theorem z7UnaryRows8_s268 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 0, 0] 8 14 (-4 : Int))
    (z7UnaryCode8_s268.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s268_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 0, 0], 8, 14, (-4 : Int)).1 ([3, 1, 0, 0], 8, 14, (-4 : Int)).2.1
      ([3, 1, 0, 0], 8, 14, (-4 : Int)).2.2.1 ([3, 1, 0, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s268.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 0, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s268
theorem z7UnaryRows8_s269 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 0, 1] 7 13 (-3 : Int))
    (z7UnaryCode8_s269.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s269_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 0, 1], 7, 13, (-3 : Int)).1 ([3, 1, 0, 1], 7, 13, (-3 : Int)).2.1
      ([3, 1, 0, 1], 7, 13, (-3 : Int)).2.2.1 ([3, 1, 0, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s269.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 0, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s269
theorem z7UnaryRows8_s270 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 0, 2] 6 10 (-2 : Int))
    (z7UnaryCode8_s270.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s270_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 0, 2], 6, 10, (-2 : Int)).1 ([3, 1, 0, 2], 6, 10, (-2 : Int)).2.1
      ([3, 1, 0, 2], 6, 10, (-2 : Int)).2.2.1 ([3, 1, 0, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s270.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 0, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s270
theorem z7UnaryRows8_s271 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 0, 3] 5 5 (-1 : Int))
    (z7UnaryCode8_s271.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s271_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 0, 3], 5, 5, (-1 : Int)).1 ([3, 1, 0, 3], 5, 5, (-1 : Int)).2.1
      ([3, 1, 0, 3], 5, 5, (-1 : Int)).2.2.1 ([3, 1, 0, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode8_s271.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 0, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s271
theorem z7UnaryRows8_s272 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 1, 0] 7 13 (-5 : Int))
    (z7UnaryCode8_s272.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s272_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 1, 0], 7, 13, (-5 : Int)).1 ([3, 1, 1, 0], 7, 13, (-5 : Int)).2.1
      ([3, 1, 1, 0], 7, 13, (-5 : Int)).2.2.1 ([3, 1, 1, 0], 7, 13, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s272.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 1, 0] 7 13 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s272
theorem z7UnaryRows8_s273 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 1, 1] 6 12 (-4 : Int))
    (z7UnaryCode8_s273.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s273_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 1, 1], 6, 12, (-4 : Int)).1 ([3, 1, 1, 1], 6, 12, (-4 : Int)).2.1
      ([3, 1, 1, 1], 6, 12, (-4 : Int)).2.2.1 ([3, 1, 1, 1], 6, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s273.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 1, 1] 6 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s273
theorem z7UnaryRows8_s274 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 1, 2] 5 9 (-3 : Int))
    (z7UnaryCode8_s274.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s274_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 1, 2], 5, 9, (-3 : Int)).1 ([3, 1, 1, 2], 5, 9, (-3 : Int)).2.1
      ([3, 1, 1, 2], 5, 9, (-3 : Int)).2.2.1 ([3, 1, 1, 2], 5, 9, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s274.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 1, 2] 5 9 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s274
theorem z7UnaryRows8_s275 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 1, 3] 4 4 (-2 : Int))
    (z7UnaryCode8_s275.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s275_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 1, 3], 4, 4, (-2 : Int)).1 ([3, 1, 1, 3], 4, 4, (-2 : Int)).2.1
      ([3, 1, 1, 3], 4, 4, (-2 : Int)).2.2.1 ([3, 1, 1, 3], 4, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s275.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 1, 3] 4 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s275
theorem z7UnaryRows8_s276 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 2, 0] 6 10 (-6 : Int))
    (z7UnaryCode8_s276.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s276_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 2, 0], 6, 10, (-6 : Int)).1 ([3, 1, 2, 0], 6, 10, (-6 : Int)).2.1
      ([3, 1, 2, 0], 6, 10, (-6 : Int)).2.2.1 ([3, 1, 2, 0], 6, 10, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s276.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 2, 0] 6 10 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s276
theorem z7UnaryRows8_s277 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 2, 1] 5 9 (-5 : Int))
    (z7UnaryCode8_s277.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s277_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 2, 1], 5, 9, (-5 : Int)).1 ([3, 1, 2, 1], 5, 9, (-5 : Int)).2.1
      ([3, 1, 2, 1], 5, 9, (-5 : Int)).2.2.1 ([3, 1, 2, 1], 5, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s277.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 2, 1] 5 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s277
theorem z7UnaryRows8_s278 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 2, 2] 4 6 (-4 : Int))
    (z7UnaryCode8_s278.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s278_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 2, 2], 4, 6, (-4 : Int)).1 ([3, 1, 2, 2], 4, 6, (-4 : Int)).2.1
      ([3, 1, 2, 2], 4, 6, (-4 : Int)).2.2.1 ([3, 1, 2, 2], 4, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s278.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 2, 2] 4 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s278
theorem z7UnaryRows8_s279 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 2, 3] 3 1 (-3 : Int))
    (z7UnaryCode8_s279.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s279_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 2, 3], 3, 1, (-3 : Int)).1 ([3, 1, 2, 3], 3, 1, (-3 : Int)).2.1
      ([3, 1, 2, 3], 3, 1, (-3 : Int)).2.2.1 ([3, 1, 2, 3], 3, 1, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s279.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 2, 3] 3 1 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s279
theorem z7UnaryRows8_s280 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 3, 0] 5 5 (-7 : Int))
    (z7UnaryCode8_s280.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s280_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 3, 0], 5, 5, (-7 : Int)).1 ([3, 1, 3, 0], 5, 5, (-7 : Int)).2.1
      ([3, 1, 3, 0], 5, 5, (-7 : Int)).2.2.1 ([3, 1, 3, 0], 5, 5, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s280.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 3, 0] 5 5 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s280
theorem z7UnaryRows8_s281 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 3, 1] 4 4 (-6 : Int))
    (z7UnaryCode8_s281.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s281_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 3, 1], 4, 4, (-6 : Int)).1 ([3, 1, 3, 1], 4, 4, (-6 : Int)).2.1
      ([3, 1, 3, 1], 4, 4, (-6 : Int)).2.2.1 ([3, 1, 3, 1], 4, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s281.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 3, 1] 4 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s281
theorem z7UnaryRows8_s282 : rowsBeq
    (z7GenRow 8 8 4 [3, 1, 3, 2] 3 1 (-5 : Int))
    (z7UnaryCode8_s282.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s282_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 1, 3, 2], 3, 1, (-5 : Int)).1 ([3, 1, 3, 2], 3, 1, (-5 : Int)).2.1
      ([3, 1, 3, 2], 3, 1, (-5 : Int)).2.2.1 ([3, 1, 3, 2], 3, 1, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s282.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 1, 3, 2] 3 1 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s282
theorem z7UnaryRows8_s283 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 0, 0] 7 11 (-5 : Int))
    (z7UnaryCode8_s283.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s283_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 0, 0], 7, 11, (-5 : Int)).1 ([3, 2, 0, 0], 7, 11, (-5 : Int)).2.1
      ([3, 2, 0, 0], 7, 11, (-5 : Int)).2.2.1 ([3, 2, 0, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s283.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 0, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s283
theorem z7UnaryRows8_s284 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 0, 1] 6 10 (-4 : Int))
    (z7UnaryCode8_s284.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s284_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 0, 1], 6, 10, (-4 : Int)).1 ([3, 2, 0, 1], 6, 10, (-4 : Int)).2.1
      ([3, 2, 0, 1], 6, 10, (-4 : Int)).2.2.1 ([3, 2, 0, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s284.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 0, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s284
theorem z7UnaryRows8_s285 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 0, 2] 5 7 (-3 : Int))
    (z7UnaryCode8_s285.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s285_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 0, 2], 5, 7, (-3 : Int)).1 ([3, 2, 0, 2], 5, 7, (-3 : Int)).2.1
      ([3, 2, 0, 2], 5, 7, (-3 : Int)).2.2.1 ([3, 2, 0, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s285.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 0, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s285
theorem z7UnaryRows8_s286 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 0, 3] 4 2 (-2 : Int))
    (z7UnaryCode8_s286.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s286_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 0, 3], 4, 2, (-2 : Int)).1 ([3, 2, 0, 3], 4, 2, (-2 : Int)).2.1
      ([3, 2, 0, 3], 4, 2, (-2 : Int)).2.2.1 ([3, 2, 0, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s286.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 0, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s286
theorem z7UnaryRows8_s287 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 1, 0] 6 10 (-6 : Int))
    (z7UnaryCode8_s287.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s287_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 1, 0], 6, 10, (-6 : Int)).1 ([3, 2, 1, 0], 6, 10, (-6 : Int)).2.1
      ([3, 2, 1, 0], 6, 10, (-6 : Int)).2.2.1 ([3, 2, 1, 0], 6, 10, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s287.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 1, 0] 6 10 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s287
theorem z7UnaryRows8_s288 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 1, 1] 5 9 (-5 : Int))
    (z7UnaryCode8_s288.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s288_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 1, 1], 5, 9, (-5 : Int)).1 ([3, 2, 1, 1], 5, 9, (-5 : Int)).2.1
      ([3, 2, 1, 1], 5, 9, (-5 : Int)).2.2.1 ([3, 2, 1, 1], 5, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s288.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 1, 1] 5 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s288
theorem z7UnaryRows8_s289 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 1, 2] 4 6 (-4 : Int))
    (z7UnaryCode8_s289.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s289_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 1, 2], 4, 6, (-4 : Int)).1 ([3, 2, 1, 2], 4, 6, (-4 : Int)).2.1
      ([3, 2, 1, 2], 4, 6, (-4 : Int)).2.2.1 ([3, 2, 1, 2], 4, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s289.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 1, 2] 4 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s289
theorem z7UnaryRows8_s290 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 1, 3] 3 1 (-3 : Int))
    (z7UnaryCode8_s290.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s290_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 1, 3], 3, 1, (-3 : Int)).1 ([3, 2, 1, 3], 3, 1, (-3 : Int)).2.1
      ([3, 2, 1, 3], 3, 1, (-3 : Int)).2.2.1 ([3, 2, 1, 3], 3, 1, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s290.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 1, 3] 3 1 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s290
theorem z7UnaryRows8_s291 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 2, 0] 5 7 (-7 : Int))
    (z7UnaryCode8_s291.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s291_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 2, 0], 5, 7, (-7 : Int)).1 ([3, 2, 2, 0], 5, 7, (-7 : Int)).2.1
      ([3, 2, 2, 0], 5, 7, (-7 : Int)).2.2.1 ([3, 2, 2, 0], 5, 7, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s291.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 2, 0] 5 7 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s291
theorem z7UnaryRows8_s292 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 2, 1] 4 6 (-6 : Int))
    (z7UnaryCode8_s292.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s292_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 2, 1], 4, 6, (-6 : Int)).1 ([3, 2, 2, 1], 4, 6, (-6 : Int)).2.1
      ([3, 2, 2, 1], 4, 6, (-6 : Int)).2.2.1 ([3, 2, 2, 1], 4, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s292.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 2, 1] 4 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s292
theorem z7UnaryRows8_s293 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 2, 2] 3 3 (-5 : Int))
    (z7UnaryCode8_s293.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s293_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 2, 2], 3, 3, (-5 : Int)).1 ([3, 2, 2, 2], 3, 3, (-5 : Int)).2.1
      ([3, 2, 2, 2], 3, 3, (-5 : Int)).2.2.1 ([3, 2, 2, 2], 3, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s293.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 2, 2] 3 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s293
theorem z7UnaryRows8_s294 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 3, 0] 4 2 (-8 : Int))
    (z7UnaryCode8_s294.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s294_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 3, 0], 4, 2, (-8 : Int)).1 ([3, 2, 3, 0], 4, 2, (-8 : Int)).2.1
      ([3, 2, 3, 0], 4, 2, (-8 : Int)).2.2.1 ([3, 2, 3, 0], 4, 2, (-8 : Int)).2.2.2 =
    z7UnaryCode8_s294.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 3, 0] 4 2 (-8 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s294
theorem z7UnaryRows8_s295 : rowsBeq
    (z7GenRow 8 8 4 [3, 2, 3, 1] 3 1 (-7 : Int))
    (z7UnaryCode8_s295.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s295_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 2, 3, 1], 3, 1, (-7 : Int)).1 ([3, 2, 3, 1], 3, 1, (-7 : Int)).2.1
      ([3, 2, 3, 1], 3, 1, (-7 : Int)).2.2.1 ([3, 2, 3, 1], 3, 1, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s295.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 2, 3, 1] 3 1 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s295
theorem z7UnaryRows8_s296 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 0, 0] 6 6 (-6 : Int))
    (z7UnaryCode8_s296.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s296_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 0, 0], 6, 6, (-6 : Int)).1 ([3, 3, 0, 0], 6, 6, (-6 : Int)).2.1
      ([3, 3, 0, 0], 6, 6, (-6 : Int)).2.2.1 ([3, 3, 0, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s296.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 0, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s296
theorem z7UnaryRows8_s297 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 0, 1] 5 5 (-5 : Int))
    (z7UnaryCode8_s297.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s297_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 0, 1], 5, 5, (-5 : Int)).1 ([3, 3, 0, 1], 5, 5, (-5 : Int)).2.1
      ([3, 3, 0, 1], 5, 5, (-5 : Int)).2.2.1 ([3, 3, 0, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s297.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 0, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s297
theorem z7UnaryRows8_s298 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 0, 2] 4 2 (-4 : Int))
    (z7UnaryCode8_s298.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s298_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 0, 2], 4, 2, (-4 : Int)).1 ([3, 3, 0, 2], 4, 2, (-4 : Int)).2.1
      ([3, 3, 0, 2], 4, 2, (-4 : Int)).2.2.1 ([3, 3, 0, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s298.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 0, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s298
theorem z7UnaryRows8_s299 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 1, 0] 5 5 (-7 : Int))
    (z7UnaryCode8_s299.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s299_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 1, 0], 5, 5, (-7 : Int)).1 ([3, 3, 1, 0], 5, 5, (-7 : Int)).2.1
      ([3, 3, 1, 0], 5, 5, (-7 : Int)).2.2.1 ([3, 3, 1, 0], 5, 5, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s299.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 1, 0] 5 5 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s299
theorem z7UnaryRows8_s300 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 1, 1] 4 4 (-6 : Int))
    (z7UnaryCode8_s300.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s300_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 1, 1], 4, 4, (-6 : Int)).1 ([3, 3, 1, 1], 4, 4, (-6 : Int)).2.1
      ([3, 3, 1, 1], 4, 4, (-6 : Int)).2.2.1 ([3, 3, 1, 1], 4, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s300.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 1, 1] 4 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s300
theorem z7UnaryRows8_s301 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 1, 2] 3 1 (-5 : Int))
    (z7UnaryCode8_s301.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s301_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 1, 2], 3, 1, (-5 : Int)).1 ([3, 3, 1, 2], 3, 1, (-5 : Int)).2.1
      ([3, 3, 1, 2], 3, 1, (-5 : Int)).2.2.1 ([3, 3, 1, 2], 3, 1, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s301.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 1, 2] 3 1 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s301
theorem z7UnaryRows8_s302 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 2, 0] 4 2 (-8 : Int))
    (z7UnaryCode8_s302.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s302_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 2, 0], 4, 2, (-8 : Int)).1 ([3, 3, 2, 0], 4, 2, (-8 : Int)).2.1
      ([3, 3, 2, 0], 4, 2, (-8 : Int)).2.2.1 ([3, 3, 2, 0], 4, 2, (-8 : Int)).2.2.2 =
    z7UnaryCode8_s302.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 2, 0] 4 2 (-8 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s302
theorem z7UnaryRows8_s303 : rowsBeq
    (z7GenRow 8 8 4 [3, 3, 2, 1] 3 1 (-7 : Int))
    (z7UnaryCode8_s303.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s303_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([3, 3, 2, 1], 3, 1, (-7 : Int)).1 ([3, 3, 2, 1], 3, 1, (-7 : Int)).2.1
      ([3, 3, 2, 1], 3, 1, (-7 : Int)).2.2.1 ([3, 3, 2, 1], 3, 1, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s303.map z7DecodeRow := by
  show z7GenRow 8 8 4 [3, 3, 2, 1] 3 1 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s303
theorem z7UnaryRows8_s304 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 0, 0] 8 8 (-4 : Int))
    (z7UnaryCode8_s304.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s304_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 0, 0], 8, 8, (-4 : Int)).1 ([4, 0, 0, 0], 8, 8, (-4 : Int)).2.1
      ([4, 0, 0, 0], 8, 8, (-4 : Int)).2.2.1 ([4, 0, 0, 0], 8, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s304.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 0, 0] 8 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s304
theorem z7UnaryRows8_s305 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 0, 1] 7 7 (-3 : Int))
    (z7UnaryCode8_s305.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s305_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 0, 1], 7, 7, (-3 : Int)).1 ([4, 0, 0, 1], 7, 7, (-3 : Int)).2.1
      ([4, 0, 0, 1], 7, 7, (-3 : Int)).2.2.1 ([4, 0, 0, 1], 7, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s305.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 0, 1] 7 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s305
theorem z7UnaryRows8_s306 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 0, 2] 6 4 (-2 : Int))
    (z7UnaryCode8_s306.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s306_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 0, 2], 6, 4, (-2 : Int)).1 ([4, 0, 0, 2], 6, 4, (-2 : Int)).2.1
      ([4, 0, 0, 2], 6, 4, (-2 : Int)).2.2.1 ([4, 0, 0, 2], 6, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode8_s306.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 0, 2] 6 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s306
theorem z7UnaryRows8_s307 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 1, 0] 7 7 (-5 : Int))
    (z7UnaryCode8_s307.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s307_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 1, 0], 7, 7, (-5 : Int)).1 ([4, 0, 1, 0], 7, 7, (-5 : Int)).2.1
      ([4, 0, 1, 0], 7, 7, (-5 : Int)).2.2.1 ([4, 0, 1, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s307.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 1, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s307
theorem z7UnaryRows8_s308 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 1, 1] 6 6 (-4 : Int))
    (z7UnaryCode8_s308.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s308_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 1, 1], 6, 6, (-4 : Int)).1 ([4, 0, 1, 1], 6, 6, (-4 : Int)).2.1
      ([4, 0, 1, 1], 6, 6, (-4 : Int)).2.2.1 ([4, 0, 1, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s308.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 1, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s308
theorem z7UnaryRows8_s309 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 1, 2] 5 3 (-3 : Int))
    (z7UnaryCode8_s309.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s309_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 1, 2], 5, 3, (-3 : Int)).1 ([4, 0, 1, 2], 5, 3, (-3 : Int)).2.1
      ([4, 0, 1, 2], 5, 3, (-3 : Int)).2.2.1 ([4, 0, 1, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s309.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 1, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s309
theorem z7UnaryRows8_s310 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 2, 0] 6 4 (-6 : Int))
    (z7UnaryCode8_s310.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s310_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 2, 0], 6, 4, (-6 : Int)).1 ([4, 0, 2, 0], 6, 4, (-6 : Int)).2.1
      ([4, 0, 2, 0], 6, 4, (-6 : Int)).2.2.1 ([4, 0, 2, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s310.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 2, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s310
theorem z7UnaryRows8_s311 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 2, 1] 5 3 (-5 : Int))
    (z7UnaryCode8_s311.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s311_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 2, 1], 5, 3, (-5 : Int)).1 ([4, 0, 2, 1], 5, 3, (-5 : Int)).2.1
      ([4, 0, 2, 1], 5, 3, (-5 : Int)).2.2.1 ([4, 0, 2, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s311.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 2, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s311
theorem z7UnaryRows8_s312 : rowsBeq
    (z7GenRow 8 8 4 [4, 0, 2, 2] 4 0 (-4 : Int))
    (z7UnaryCode8_s312.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s312_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 0, 2, 2], 4, 0, (-4 : Int)).1 ([4, 0, 2, 2], 4, 0, (-4 : Int)).2.1
      ([4, 0, 2, 2], 4, 0, (-4 : Int)).2.2.1 ([4, 0, 2, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s312.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 0, 2, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s312
theorem z7UnaryRows8_s313 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 0, 0] 7 7 (-5 : Int))
    (z7UnaryCode8_s313.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s313_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 0, 0], 7, 7, (-5 : Int)).1 ([4, 1, 0, 0], 7, 7, (-5 : Int)).2.1
      ([4, 1, 0, 0], 7, 7, (-5 : Int)).2.2.1 ([4, 1, 0, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s313.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 0, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s313
theorem z7UnaryRows8_s314 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 0, 1] 6 6 (-4 : Int))
    (z7UnaryCode8_s314.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s314_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 0, 1], 6, 6, (-4 : Int)).1 ([4, 1, 0, 1], 6, 6, (-4 : Int)).2.1
      ([4, 1, 0, 1], 6, 6, (-4 : Int)).2.2.1 ([4, 1, 0, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s314.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 0, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s314
theorem z7UnaryRows8_s315 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 0, 2] 5 3 (-3 : Int))
    (z7UnaryCode8_s315.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s315_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 0, 2], 5, 3, (-3 : Int)).1 ([4, 1, 0, 2], 5, 3, (-3 : Int)).2.1
      ([4, 1, 0, 2], 5, 3, (-3 : Int)).2.2.1 ([4, 1, 0, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode8_s315.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 0, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s315
theorem z7UnaryRows8_s316 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 1, 0] 6 6 (-6 : Int))
    (z7UnaryCode8_s316.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s316_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 1, 0], 6, 6, (-6 : Int)).1 ([4, 1, 1, 0], 6, 6, (-6 : Int)).2.1
      ([4, 1, 1, 0], 6, 6, (-6 : Int)).2.2.1 ([4, 1, 1, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s316.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 1, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s316
theorem z7UnaryRows8_s317 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 1, 1] 5 5 (-5 : Int))
    (z7UnaryCode8_s317.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s317_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 1, 1], 5, 5, (-5 : Int)).1 ([4, 1, 1, 1], 5, 5, (-5 : Int)).2.1
      ([4, 1, 1, 1], 5, 5, (-5 : Int)).2.2.1 ([4, 1, 1, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s317.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 1, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s317
theorem z7UnaryRows8_s318 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 1, 2] 4 2 (-4 : Int))
    (z7UnaryCode8_s318.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s318_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 1, 2], 4, 2, (-4 : Int)).1 ([4, 1, 1, 2], 4, 2, (-4 : Int)).2.1
      ([4, 1, 1, 2], 4, 2, (-4 : Int)).2.2.1 ([4, 1, 1, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s318.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 1, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s318
theorem z7UnaryRows8_s319 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 2, 0] 5 3 (-7 : Int))
    (z7UnaryCode8_s319.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s319_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 2, 0], 5, 3, (-7 : Int)).1 ([4, 1, 2, 0], 5, 3, (-7 : Int)).2.1
      ([4, 1, 2, 0], 5, 3, (-7 : Int)).2.2.1 ([4, 1, 2, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s319.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 2, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s319
theorem z7UnaryRows8_s320 : rowsBeq
    (z7GenRow 8 8 4 [4, 1, 2, 1] 4 2 (-6 : Int))
    (z7UnaryCode8_s320.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s320_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 1, 2, 1], 4, 2, (-6 : Int)).1 ([4, 1, 2, 1], 4, 2, (-6 : Int)).2.1
      ([4, 1, 2, 1], 4, 2, (-6 : Int)).2.2.1 ([4, 1, 2, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s320.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 1, 2, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s320
theorem z7UnaryRows8_s321 : rowsBeq
    (z7GenRow 8 8 4 [4, 2, 0, 0] 6 4 (-6 : Int))
    (z7UnaryCode8_s321.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s321_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 2, 0, 0], 6, 4, (-6 : Int)).1 ([4, 2, 0, 0], 6, 4, (-6 : Int)).2.1
      ([4, 2, 0, 0], 6, 4, (-6 : Int)).2.2.1 ([4, 2, 0, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s321.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 2, 0, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s321
theorem z7UnaryRows8_s322 : rowsBeq
    (z7GenRow 8 8 4 [4, 2, 0, 1] 5 3 (-5 : Int))
    (z7UnaryCode8_s322.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s322_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 2, 0, 1], 5, 3, (-5 : Int)).1 ([4, 2, 0, 1], 5, 3, (-5 : Int)).2.1
      ([4, 2, 0, 1], 5, 3, (-5 : Int)).2.2.1 ([4, 2, 0, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode8_s322.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 2, 0, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s322
theorem z7UnaryRows8_s323 : rowsBeq
    (z7GenRow 8 8 4 [4, 2, 0, 2] 4 0 (-4 : Int))
    (z7UnaryCode8_s323.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s323_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 2, 0, 2], 4, 0, (-4 : Int)).1 ([4, 2, 0, 2], 4, 0, (-4 : Int)).2.1
      ([4, 2, 0, 2], 4, 0, (-4 : Int)).2.2.1 ([4, 2, 0, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode8_s323.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 2, 0, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s323
theorem z7UnaryRows8_s324 : rowsBeq
    (z7GenRow 8 8 4 [4, 2, 1, 0] 5 3 (-7 : Int))
    (z7UnaryCode8_s324.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s324_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 2, 1, 0], 5, 3, (-7 : Int)).1 ([4, 2, 1, 0], 5, 3, (-7 : Int)).2.1
      ([4, 2, 1, 0], 5, 3, (-7 : Int)).2.2.1 ([4, 2, 1, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode8_s324.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 2, 1, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s324
theorem z7UnaryRows8_s325 : rowsBeq
    (z7GenRow 8 8 4 [4, 2, 1, 1] 4 2 (-6 : Int))
    (z7UnaryCode8_s325.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows8_s325_eq :
    z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) ([4, 2, 1, 1], 4, 2, (-6 : Int)).1 ([4, 2, 1, 1], 4, 2, (-6 : Int)).2.1
      ([4, 2, 1, 1], 4, 2, (-6 : Int)).2.2.1 ([4, 2, 1, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode8_s325.map z7DecodeRow := by
  show z7GenRow 8 8 4 [4, 2, 1, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows8_s325

/-- flatMap of state group 0 equals the joined decoded slices. -/
theorem z7Grp_8_0 :
    ([([0, 0, 0, 0], 12, 24, (0 : Int)), ([0, 0, 0, 1], 11, 23, (1 : Int)), ([0, 0, 0, 2], 10, 20, (2 : Int)), ([0, 0, 0, 3], 9, 15, (3 : Int)), ([0, 0, 0, 4], 8, 8, (4 : Int)), ([0, 0, 1, 0], 11, 23, (-1 : Int)), ([0, 0, 1, 1], 10, 22, (0 : Int)), ([0, 0, 1, 2], 9, 19, (1 : Int)), ([0, 0, 1, 3], 8, 14, (2 : Int)), ([0, 0, 1, 4], 7, 7, (3 : Int)), ([0, 0, 2, 0], 10, 20, (-2 : Int)), ([0, 0, 2, 1], 9, 19, (-1 : Int)), ([0, 0, 2, 2], 8, 16, (0 : Int)), ([0, 0, 2, 3], 7, 11, (1 : Int)), ([0, 0, 2, 4], 6, 4, (2 : Int)), ([0, 0, 3, 0], 9, 15, (-3 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s0.map z7DecodeRow ++ (z7UnaryCode8_s1.map z7DecodeRow ++ (z7UnaryCode8_s2.map z7DecodeRow ++ (z7UnaryCode8_s3.map z7DecodeRow ++ (z7UnaryCode8_s4.map z7DecodeRow ++ (z7UnaryCode8_s5.map z7DecodeRow ++ (z7UnaryCode8_s6.map z7DecodeRow ++ (z7UnaryCode8_s7.map z7DecodeRow ++ (z7UnaryCode8_s8.map z7DecodeRow ++ (z7UnaryCode8_s9.map z7DecodeRow ++ (z7UnaryCode8_s10.map z7DecodeRow ++ (z7UnaryCode8_s11.map z7DecodeRow ++ (z7UnaryCode8_s12.map z7DecodeRow ++ (z7UnaryCode8_s13.map z7DecodeRow ++ (z7UnaryCode8_s14.map z7DecodeRow ++ (z7UnaryCode8_s15.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s0_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s1_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s2_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s3_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s4_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s5_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s6_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s7_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s8_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s9_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s10_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s11_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s12_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s13_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s14_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s15_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 1 equals the joined decoded slices. -/
theorem z7Grp_8_1 :
    ([([0, 0, 3, 1], 8, 14, (-2 : Int)), ([0, 0, 3, 2], 7, 11, (-1 : Int)), ([0, 0, 3, 3], 6, 6, (0 : Int)), ([0, 0, 4, 0], 8, 8, (-4 : Int)), ([0, 0, 4, 1], 7, 7, (-3 : Int)), ([0, 0, 4, 2], 6, 4, (-2 : Int)), ([0, 1, 0, 0], 11, 23, (-1 : Int)), ([0, 1, 0, 1], 10, 22, (0 : Int)), ([0, 1, 0, 2], 9, 19, (1 : Int)), ([0, 1, 0, 3], 8, 14, (2 : Int)), ([0, 1, 0, 4], 7, 7, (3 : Int)), ([0, 1, 1, 0], 10, 22, (-2 : Int)), ([0, 1, 1, 1], 9, 21, (-1 : Int)), ([0, 1, 1, 2], 8, 18, (0 : Int)), ([0, 1, 1, 3], 7, 13, (1 : Int)), ([0, 1, 1, 4], 6, 6, (2 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s16.map z7DecodeRow ++ (z7UnaryCode8_s17.map z7DecodeRow ++ (z7UnaryCode8_s18.map z7DecodeRow ++ (z7UnaryCode8_s19.map z7DecodeRow ++ (z7UnaryCode8_s20.map z7DecodeRow ++ (z7UnaryCode8_s21.map z7DecodeRow ++ (z7UnaryCode8_s22.map z7DecodeRow ++ (z7UnaryCode8_s23.map z7DecodeRow ++ (z7UnaryCode8_s24.map z7DecodeRow ++ (z7UnaryCode8_s25.map z7DecodeRow ++ (z7UnaryCode8_s26.map z7DecodeRow ++ (z7UnaryCode8_s27.map z7DecodeRow ++ (z7UnaryCode8_s28.map z7DecodeRow ++ (z7UnaryCode8_s29.map z7DecodeRow ++ (z7UnaryCode8_s30.map z7DecodeRow ++ (z7UnaryCode8_s31.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s16_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s17_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s18_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s19_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s20_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s21_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s22_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s23_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s24_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s25_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s26_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s27_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s28_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s29_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s30_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s31_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 2 equals the joined decoded slices. -/
theorem z7Grp_8_2 :
    ([([0, 1, 2, 0], 9, 19, (-3 : Int)), ([0, 1, 2, 1], 8, 18, (-2 : Int)), ([0, 1, 2, 2], 7, 15, (-1 : Int)), ([0, 1, 2, 3], 6, 10, (0 : Int)), ([0, 1, 2, 4], 5, 3, (1 : Int)), ([0, 1, 3, 0], 8, 14, (-4 : Int)), ([0, 1, 3, 1], 7, 13, (-3 : Int)), ([0, 1, 3, 2], 6, 10, (-2 : Int)), ([0, 1, 3, 3], 5, 5, (-1 : Int)), ([0, 1, 4, 0], 7, 7, (-5 : Int)), ([0, 1, 4, 1], 6, 6, (-4 : Int)), ([0, 1, 4, 2], 5, 3, (-3 : Int)), ([0, 2, 0, 0], 10, 20, (-2 : Int)), ([0, 2, 0, 1], 9, 19, (-1 : Int)), ([0, 2, 0, 2], 8, 16, (0 : Int)), ([0, 2, 0, 3], 7, 11, (1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s32.map z7DecodeRow ++ (z7UnaryCode8_s33.map z7DecodeRow ++ (z7UnaryCode8_s34.map z7DecodeRow ++ (z7UnaryCode8_s35.map z7DecodeRow ++ (z7UnaryCode8_s36.map z7DecodeRow ++ (z7UnaryCode8_s37.map z7DecodeRow ++ (z7UnaryCode8_s38.map z7DecodeRow ++ (z7UnaryCode8_s39.map z7DecodeRow ++ (z7UnaryCode8_s40.map z7DecodeRow ++ (z7UnaryCode8_s41.map z7DecodeRow ++ (z7UnaryCode8_s42.map z7DecodeRow ++ (z7UnaryCode8_s43.map z7DecodeRow ++ (z7UnaryCode8_s44.map z7DecodeRow ++ (z7UnaryCode8_s45.map z7DecodeRow ++ (z7UnaryCode8_s46.map z7DecodeRow ++ (z7UnaryCode8_s47.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s32_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s33_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s34_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s35_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s36_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s37_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s38_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s39_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s40_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s41_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s42_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s43_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s44_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s45_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s46_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s47_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 3 equals the joined decoded slices. -/
theorem z7Grp_8_3 :
    ([([0, 2, 0, 4], 6, 4, (2 : Int)), ([0, 2, 1, 0], 9, 19, (-3 : Int)), ([0, 2, 1, 1], 8, 18, (-2 : Int)), ([0, 2, 1, 2], 7, 15, (-1 : Int)), ([0, 2, 1, 3], 6, 10, (0 : Int)), ([0, 2, 1, 4], 5, 3, (1 : Int)), ([0, 2, 2, 0], 8, 16, (-4 : Int)), ([0, 2, 2, 1], 7, 15, (-3 : Int)), ([0, 2, 2, 2], 6, 12, (-2 : Int)), ([0, 2, 2, 3], 5, 7, (-1 : Int)), ([0, 2, 2, 4], 4, 0, (0 : Int)), ([0, 2, 3, 0], 7, 11, (-5 : Int)), ([0, 2, 3, 1], 6, 10, (-4 : Int)), ([0, 2, 3, 2], 5, 7, (-3 : Int)), ([0, 2, 3, 3], 4, 2, (-2 : Int)), ([0, 2, 4, 0], 6, 4, (-6 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s48.map z7DecodeRow ++ (z7UnaryCode8_s49.map z7DecodeRow ++ (z7UnaryCode8_s50.map z7DecodeRow ++ (z7UnaryCode8_s51.map z7DecodeRow ++ (z7UnaryCode8_s52.map z7DecodeRow ++ (z7UnaryCode8_s53.map z7DecodeRow ++ (z7UnaryCode8_s54.map z7DecodeRow ++ (z7UnaryCode8_s55.map z7DecodeRow ++ (z7UnaryCode8_s56.map z7DecodeRow ++ (z7UnaryCode8_s57.map z7DecodeRow ++ (z7UnaryCode8_s58.map z7DecodeRow ++ (z7UnaryCode8_s59.map z7DecodeRow ++ (z7UnaryCode8_s60.map z7DecodeRow ++ (z7UnaryCode8_s61.map z7DecodeRow ++ (z7UnaryCode8_s62.map z7DecodeRow ++ (z7UnaryCode8_s63.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s48_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s49_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s50_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s51_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s52_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s53_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s54_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s55_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s56_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s57_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s58_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s59_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s60_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s61_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s62_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s63_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 4 equals the joined decoded slices. -/
theorem z7Grp_8_4 :
    ([([0, 2, 4, 1], 5, 3, (-5 : Int)), ([0, 2, 4, 2], 4, 0, (-4 : Int)), ([0, 3, 0, 0], 9, 15, (-3 : Int)), ([0, 3, 0, 1], 8, 14, (-2 : Int)), ([0, 3, 0, 2], 7, 11, (-1 : Int)), ([0, 3, 0, 3], 6, 6, (0 : Int)), ([0, 3, 1, 0], 8, 14, (-4 : Int)), ([0, 3, 1, 1], 7, 13, (-3 : Int)), ([0, 3, 1, 2], 6, 10, (-2 : Int)), ([0, 3, 1, 3], 5, 5, (-1 : Int)), ([0, 3, 2, 0], 7, 11, (-5 : Int)), ([0, 3, 2, 1], 6, 10, (-4 : Int)), ([0, 3, 2, 2], 5, 7, (-3 : Int)), ([0, 3, 2, 3], 4, 2, (-2 : Int)), ([0, 3, 3, 0], 6, 6, (-6 : Int)), ([0, 3, 3, 1], 5, 5, (-5 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s64.map z7DecodeRow ++ (z7UnaryCode8_s65.map z7DecodeRow ++ (z7UnaryCode8_s66.map z7DecodeRow ++ (z7UnaryCode8_s67.map z7DecodeRow ++ (z7UnaryCode8_s68.map z7DecodeRow ++ (z7UnaryCode8_s69.map z7DecodeRow ++ (z7UnaryCode8_s70.map z7DecodeRow ++ (z7UnaryCode8_s71.map z7DecodeRow ++ (z7UnaryCode8_s72.map z7DecodeRow ++ (z7UnaryCode8_s73.map z7DecodeRow ++ (z7UnaryCode8_s74.map z7DecodeRow ++ (z7UnaryCode8_s75.map z7DecodeRow ++ (z7UnaryCode8_s76.map z7DecodeRow ++ (z7UnaryCode8_s77.map z7DecodeRow ++ (z7UnaryCode8_s78.map z7DecodeRow ++ (z7UnaryCode8_s79.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s64_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s65_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s66_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s67_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s68_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s69_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s70_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s71_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s72_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s73_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s74_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s75_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s76_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s77_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s78_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s79_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 5 equals the joined decoded slices. -/
theorem z7Grp_8_5 :
    ([([0, 3, 3, 2], 4, 2, (-4 : Int)), ([0, 4, 0, 0], 8, 8, (-4 : Int)), ([0, 4, 0, 1], 7, 7, (-3 : Int)), ([0, 4, 0, 2], 6, 4, (-2 : Int)), ([0, 4, 1, 0], 7, 7, (-5 : Int)), ([0, 4, 1, 1], 6, 6, (-4 : Int)), ([0, 4, 1, 2], 5, 3, (-3 : Int)), ([0, 4, 2, 0], 6, 4, (-6 : Int)), ([0, 4, 2, 1], 5, 3, (-5 : Int)), ([0, 4, 2, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 23, (-1 : Int)), ([1, 0, 0, 1], 10, 22, (0 : Int)), ([1, 0, 0, 2], 9, 19, (1 : Int)), ([1, 0, 0, 3], 8, 14, (2 : Int)), ([1, 0, 0, 4], 7, 7, (3 : Int)), ([1, 0, 1, 0], 10, 22, (-2 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s80.map z7DecodeRow ++ (z7UnaryCode8_s81.map z7DecodeRow ++ (z7UnaryCode8_s82.map z7DecodeRow ++ (z7UnaryCode8_s83.map z7DecodeRow ++ (z7UnaryCode8_s84.map z7DecodeRow ++ (z7UnaryCode8_s85.map z7DecodeRow ++ (z7UnaryCode8_s86.map z7DecodeRow ++ (z7UnaryCode8_s87.map z7DecodeRow ++ (z7UnaryCode8_s88.map z7DecodeRow ++ (z7UnaryCode8_s89.map z7DecodeRow ++ (z7UnaryCode8_s90.map z7DecodeRow ++ (z7UnaryCode8_s91.map z7DecodeRow ++ (z7UnaryCode8_s92.map z7DecodeRow ++ (z7UnaryCode8_s93.map z7DecodeRow ++ (z7UnaryCode8_s94.map z7DecodeRow ++ (z7UnaryCode8_s95.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s80_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s81_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s82_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s83_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s84_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s85_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s86_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s87_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s88_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s89_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s90_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s91_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s92_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s93_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s94_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s95_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 6 equals the joined decoded slices. -/
theorem z7Grp_8_6 :
    ([([1, 0, 1, 1], 9, 21, (-1 : Int)), ([1, 0, 1, 2], 8, 18, (0 : Int)), ([1, 0, 1, 3], 7, 13, (1 : Int)), ([1, 0, 1, 4], 6, 6, (2 : Int)), ([1, 0, 2, 0], 9, 19, (-3 : Int)), ([1, 0, 2, 1], 8, 18, (-2 : Int)), ([1, 0, 2, 2], 7, 15, (-1 : Int)), ([1, 0, 2, 3], 6, 10, (0 : Int)), ([1, 0, 2, 4], 5, 3, (1 : Int)), ([1, 0, 3, 0], 8, 14, (-4 : Int)), ([1, 0, 3, 1], 7, 13, (-3 : Int)), ([1, 0, 3, 2], 6, 10, (-2 : Int)), ([1, 0, 3, 3], 5, 5, (-1 : Int)), ([1, 0, 4, 0], 7, 7, (-5 : Int)), ([1, 0, 4, 1], 6, 6, (-4 : Int)), ([1, 0, 4, 2], 5, 3, (-3 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s96.map z7DecodeRow ++ (z7UnaryCode8_s97.map z7DecodeRow ++ (z7UnaryCode8_s98.map z7DecodeRow ++ (z7UnaryCode8_s99.map z7DecodeRow ++ (z7UnaryCode8_s100.map z7DecodeRow ++ (z7UnaryCode8_s101.map z7DecodeRow ++ (z7UnaryCode8_s102.map z7DecodeRow ++ (z7UnaryCode8_s103.map z7DecodeRow ++ (z7UnaryCode8_s104.map z7DecodeRow ++ (z7UnaryCode8_s105.map z7DecodeRow ++ (z7UnaryCode8_s106.map z7DecodeRow ++ (z7UnaryCode8_s107.map z7DecodeRow ++ (z7UnaryCode8_s108.map z7DecodeRow ++ (z7UnaryCode8_s109.map z7DecodeRow ++ (z7UnaryCode8_s110.map z7DecodeRow ++ (z7UnaryCode8_s111.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s96_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s97_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s98_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s99_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s100_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s101_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s102_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s103_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s104_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s105_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s106_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s107_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s108_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s109_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s110_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s111_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 7 equals the joined decoded slices. -/
theorem z7Grp_8_7 :
    ([([1, 1, 0, 0], 10, 22, (-2 : Int)), ([1, 1, 0, 1], 9, 21, (-1 : Int)), ([1, 1, 0, 2], 8, 18, (0 : Int)), ([1, 1, 0, 3], 7, 13, (1 : Int)), ([1, 1, 0, 4], 6, 6, (2 : Int)), ([1, 1, 1, 0], 9, 21, (-3 : Int)), ([1, 1, 1, 1], 8, 20, (-2 : Int)), ([1, 1, 1, 2], 7, 17, (-1 : Int)), ([1, 1, 1, 3], 6, 12, (0 : Int)), ([1, 1, 1, 4], 5, 5, (1 : Int)), ([1, 1, 2, 0], 8, 18, (-4 : Int)), ([1, 1, 2, 1], 7, 17, (-3 : Int)), ([1, 1, 2, 2], 6, 14, (-2 : Int)), ([1, 1, 2, 3], 5, 9, (-1 : Int)), ([1, 1, 2, 4], 4, 2, (0 : Int)), ([1, 1, 3, 0], 7, 13, (-5 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s112.map z7DecodeRow ++ (z7UnaryCode8_s113.map z7DecodeRow ++ (z7UnaryCode8_s114.map z7DecodeRow ++ (z7UnaryCode8_s115.map z7DecodeRow ++ (z7UnaryCode8_s116.map z7DecodeRow ++ (z7UnaryCode8_s117.map z7DecodeRow ++ (z7UnaryCode8_s118.map z7DecodeRow ++ (z7UnaryCode8_s119.map z7DecodeRow ++ (z7UnaryCode8_s120.map z7DecodeRow ++ (z7UnaryCode8_s121.map z7DecodeRow ++ (z7UnaryCode8_s122.map z7DecodeRow ++ (z7UnaryCode8_s123.map z7DecodeRow ++ (z7UnaryCode8_s124.map z7DecodeRow ++ (z7UnaryCode8_s125.map z7DecodeRow ++ (z7UnaryCode8_s126.map z7DecodeRow ++ (z7UnaryCode8_s127.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s112_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s113_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s114_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s115_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s116_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s117_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s118_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s119_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s120_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s121_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s122_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s123_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s124_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s125_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s126_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s127_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 8 equals the joined decoded slices. -/
theorem z7Grp_8_8 :
    ([([1, 1, 3, 1], 6, 12, (-4 : Int)), ([1, 1, 3, 2], 5, 9, (-3 : Int)), ([1, 1, 3, 3], 4, 4, (-2 : Int)), ([1, 1, 4, 0], 6, 6, (-6 : Int)), ([1, 1, 4, 1], 5, 5, (-5 : Int)), ([1, 1, 4, 2], 4, 2, (-4 : Int)), ([1, 2, 0, 0], 9, 19, (-3 : Int)), ([1, 2, 0, 1], 8, 18, (-2 : Int)), ([1, 2, 0, 2], 7, 15, (-1 : Int)), ([1, 2, 0, 3], 6, 10, (0 : Int)), ([1, 2, 0, 4], 5, 3, (1 : Int)), ([1, 2, 1, 0], 8, 18, (-4 : Int)), ([1, 2, 1, 1], 7, 17, (-3 : Int)), ([1, 2, 1, 2], 6, 14, (-2 : Int)), ([1, 2, 1, 3], 5, 9, (-1 : Int)), ([1, 2, 1, 4], 4, 2, (0 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s128.map z7DecodeRow ++ (z7UnaryCode8_s129.map z7DecodeRow ++ (z7UnaryCode8_s130.map z7DecodeRow ++ (z7UnaryCode8_s131.map z7DecodeRow ++ (z7UnaryCode8_s132.map z7DecodeRow ++ (z7UnaryCode8_s133.map z7DecodeRow ++ (z7UnaryCode8_s134.map z7DecodeRow ++ (z7UnaryCode8_s135.map z7DecodeRow ++ (z7UnaryCode8_s136.map z7DecodeRow ++ (z7UnaryCode8_s137.map z7DecodeRow ++ (z7UnaryCode8_s138.map z7DecodeRow ++ (z7UnaryCode8_s139.map z7DecodeRow ++ (z7UnaryCode8_s140.map z7DecodeRow ++ (z7UnaryCode8_s141.map z7DecodeRow ++ (z7UnaryCode8_s142.map z7DecodeRow ++ (z7UnaryCode8_s143.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s128_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s129_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s130_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s131_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s132_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s133_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s134_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s135_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s136_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s137_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s138_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s139_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s140_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s141_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s142_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s143_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 9 equals the joined decoded slices. -/
theorem z7Grp_8_9 :
    ([([1, 2, 2, 0], 7, 15, (-5 : Int)), ([1, 2, 2, 1], 6, 14, (-4 : Int)), ([1, 2, 2, 2], 5, 11, (-3 : Int)), ([1, 2, 2, 3], 4, 6, (-2 : Int)), ([1, 2, 3, 0], 6, 10, (-6 : Int)), ([1, 2, 3, 1], 5, 9, (-5 : Int)), ([1, 2, 3, 2], 4, 6, (-4 : Int)), ([1, 2, 3, 3], 3, 1, (-3 : Int)), ([1, 2, 4, 0], 5, 3, (-7 : Int)), ([1, 2, 4, 1], 4, 2, (-6 : Int)), ([1, 3, 0, 0], 8, 14, (-4 : Int)), ([1, 3, 0, 1], 7, 13, (-3 : Int)), ([1, 3, 0, 2], 6, 10, (-2 : Int)), ([1, 3, 0, 3], 5, 5, (-1 : Int)), ([1, 3, 1, 0], 7, 13, (-5 : Int)), ([1, 3, 1, 1], 6, 12, (-4 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s144.map z7DecodeRow ++ (z7UnaryCode8_s145.map z7DecodeRow ++ (z7UnaryCode8_s146.map z7DecodeRow ++ (z7UnaryCode8_s147.map z7DecodeRow ++ (z7UnaryCode8_s148.map z7DecodeRow ++ (z7UnaryCode8_s149.map z7DecodeRow ++ (z7UnaryCode8_s150.map z7DecodeRow ++ (z7UnaryCode8_s151.map z7DecodeRow ++ (z7UnaryCode8_s152.map z7DecodeRow ++ (z7UnaryCode8_s153.map z7DecodeRow ++ (z7UnaryCode8_s154.map z7DecodeRow ++ (z7UnaryCode8_s155.map z7DecodeRow ++ (z7UnaryCode8_s156.map z7DecodeRow ++ (z7UnaryCode8_s157.map z7DecodeRow ++ (z7UnaryCode8_s158.map z7DecodeRow ++ (z7UnaryCode8_s159.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s144_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s145_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s146_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s147_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s148_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s149_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s150_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s151_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s152_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s153_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s154_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s155_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s156_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s157_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s158_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s159_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 10 equals the joined decoded slices. -/
theorem z7Grp_8_10 :
    ([([1, 3, 1, 2], 5, 9, (-3 : Int)), ([1, 3, 1, 3], 4, 4, (-2 : Int)), ([1, 3, 2, 0], 6, 10, (-6 : Int)), ([1, 3, 2, 1], 5, 9, (-5 : Int)), ([1, 3, 2, 2], 4, 6, (-4 : Int)), ([1, 3, 2, 3], 3, 1, (-3 : Int)), ([1, 3, 3, 0], 5, 5, (-7 : Int)), ([1, 3, 3, 1], 4, 4, (-6 : Int)), ([1, 3, 3, 2], 3, 1, (-5 : Int)), ([1, 4, 0, 0], 7, 7, (-5 : Int)), ([1, 4, 0, 1], 6, 6, (-4 : Int)), ([1, 4, 0, 2], 5, 3, (-3 : Int)), ([1, 4, 1, 0], 6, 6, (-6 : Int)), ([1, 4, 1, 1], 5, 5, (-5 : Int)), ([1, 4, 1, 2], 4, 2, (-4 : Int)), ([1, 4, 2, 0], 5, 3, (-7 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s160.map z7DecodeRow ++ (z7UnaryCode8_s161.map z7DecodeRow ++ (z7UnaryCode8_s162.map z7DecodeRow ++ (z7UnaryCode8_s163.map z7DecodeRow ++ (z7UnaryCode8_s164.map z7DecodeRow ++ (z7UnaryCode8_s165.map z7DecodeRow ++ (z7UnaryCode8_s166.map z7DecodeRow ++ (z7UnaryCode8_s167.map z7DecodeRow ++ (z7UnaryCode8_s168.map z7DecodeRow ++ (z7UnaryCode8_s169.map z7DecodeRow ++ (z7UnaryCode8_s170.map z7DecodeRow ++ (z7UnaryCode8_s171.map z7DecodeRow ++ (z7UnaryCode8_s172.map z7DecodeRow ++ (z7UnaryCode8_s173.map z7DecodeRow ++ (z7UnaryCode8_s174.map z7DecodeRow ++ (z7UnaryCode8_s175.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s160_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s161_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s162_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s163_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s164_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s165_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s166_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s167_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s168_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s169_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s170_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s171_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s172_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s173_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s174_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s175_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 11 equals the joined decoded slices. -/
theorem z7Grp_8_11 :
    ([([1, 4, 2, 1], 4, 2, (-6 : Int)), ([2, 0, 0, 0], 10, 20, (-2 : Int)), ([2, 0, 0, 1], 9, 19, (-1 : Int)), ([2, 0, 0, 2], 8, 16, (0 : Int)), ([2, 0, 0, 3], 7, 11, (1 : Int)), ([2, 0, 0, 4], 6, 4, (2 : Int)), ([2, 0, 1, 0], 9, 19, (-3 : Int)), ([2, 0, 1, 1], 8, 18, (-2 : Int)), ([2, 0, 1, 2], 7, 15, (-1 : Int)), ([2, 0, 1, 3], 6, 10, (0 : Int)), ([2, 0, 1, 4], 5, 3, (1 : Int)), ([2, 0, 2, 0], 8, 16, (-4 : Int)), ([2, 0, 2, 1], 7, 15, (-3 : Int)), ([2, 0, 2, 2], 6, 12, (-2 : Int)), ([2, 0, 2, 3], 5, 7, (-1 : Int)), ([2, 0, 2, 4], 4, 0, (0 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s176.map z7DecodeRow ++ (z7UnaryCode8_s177.map z7DecodeRow ++ (z7UnaryCode8_s178.map z7DecodeRow ++ (z7UnaryCode8_s179.map z7DecodeRow ++ (z7UnaryCode8_s180.map z7DecodeRow ++ (z7UnaryCode8_s181.map z7DecodeRow ++ (z7UnaryCode8_s182.map z7DecodeRow ++ (z7UnaryCode8_s183.map z7DecodeRow ++ (z7UnaryCode8_s184.map z7DecodeRow ++ (z7UnaryCode8_s185.map z7DecodeRow ++ (z7UnaryCode8_s186.map z7DecodeRow ++ (z7UnaryCode8_s187.map z7DecodeRow ++ (z7UnaryCode8_s188.map z7DecodeRow ++ (z7UnaryCode8_s189.map z7DecodeRow ++ (z7UnaryCode8_s190.map z7DecodeRow ++ (z7UnaryCode8_s191.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s176_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s177_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s178_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s179_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s180_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s181_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s182_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s183_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s184_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s185_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s186_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s187_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s188_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s189_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s190_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s191_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 12 equals the joined decoded slices. -/
theorem z7Grp_8_12 :
    ([([2, 0, 3, 0], 7, 11, (-5 : Int)), ([2, 0, 3, 1], 6, 10, (-4 : Int)), ([2, 0, 3, 2], 5, 7, (-3 : Int)), ([2, 0, 3, 3], 4, 2, (-2 : Int)), ([2, 0, 4, 0], 6, 4, (-6 : Int)), ([2, 0, 4, 1], 5, 3, (-5 : Int)), ([2, 0, 4, 2], 4, 0, (-4 : Int)), ([2, 1, 0, 0], 9, 19, (-3 : Int)), ([2, 1, 0, 1], 8, 18, (-2 : Int)), ([2, 1, 0, 2], 7, 15, (-1 : Int)), ([2, 1, 0, 3], 6, 10, (0 : Int)), ([2, 1, 0, 4], 5, 3, (1 : Int)), ([2, 1, 1, 0], 8, 18, (-4 : Int)), ([2, 1, 1, 1], 7, 17, (-3 : Int)), ([2, 1, 1, 2], 6, 14, (-2 : Int)), ([2, 1, 1, 3], 5, 9, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s192.map z7DecodeRow ++ (z7UnaryCode8_s193.map z7DecodeRow ++ (z7UnaryCode8_s194.map z7DecodeRow ++ (z7UnaryCode8_s195.map z7DecodeRow ++ (z7UnaryCode8_s196.map z7DecodeRow ++ (z7UnaryCode8_s197.map z7DecodeRow ++ (z7UnaryCode8_s198.map z7DecodeRow ++ (z7UnaryCode8_s199.map z7DecodeRow ++ (z7UnaryCode8_s200.map z7DecodeRow ++ (z7UnaryCode8_s201.map z7DecodeRow ++ (z7UnaryCode8_s202.map z7DecodeRow ++ (z7UnaryCode8_s203.map z7DecodeRow ++ (z7UnaryCode8_s204.map z7DecodeRow ++ (z7UnaryCode8_s205.map z7DecodeRow ++ (z7UnaryCode8_s206.map z7DecodeRow ++ (z7UnaryCode8_s207.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s192_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s193_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s194_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s195_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s196_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s197_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s198_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s199_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s200_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s201_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s202_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s203_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s204_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s205_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s206_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s207_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 13 equals the joined decoded slices. -/
theorem z7Grp_8_13 :
    ([([2, 1, 1, 4], 4, 2, (0 : Int)), ([2, 1, 2, 0], 7, 15, (-5 : Int)), ([2, 1, 2, 1], 6, 14, (-4 : Int)), ([2, 1, 2, 2], 5, 11, (-3 : Int)), ([2, 1, 2, 3], 4, 6, (-2 : Int)), ([2, 1, 3, 0], 6, 10, (-6 : Int)), ([2, 1, 3, 1], 5, 9, (-5 : Int)), ([2, 1, 3, 2], 4, 6, (-4 : Int)), ([2, 1, 3, 3], 3, 1, (-3 : Int)), ([2, 1, 4, 0], 5, 3, (-7 : Int)), ([2, 1, 4, 1], 4, 2, (-6 : Int)), ([2, 2, 0, 0], 8, 16, (-4 : Int)), ([2, 2, 0, 1], 7, 15, (-3 : Int)), ([2, 2, 0, 2], 6, 12, (-2 : Int)), ([2, 2, 0, 3], 5, 7, (-1 : Int)), ([2, 2, 0, 4], 4, 0, (0 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s208.map z7DecodeRow ++ (z7UnaryCode8_s209.map z7DecodeRow ++ (z7UnaryCode8_s210.map z7DecodeRow ++ (z7UnaryCode8_s211.map z7DecodeRow ++ (z7UnaryCode8_s212.map z7DecodeRow ++ (z7UnaryCode8_s213.map z7DecodeRow ++ (z7UnaryCode8_s214.map z7DecodeRow ++ (z7UnaryCode8_s215.map z7DecodeRow ++ (z7UnaryCode8_s216.map z7DecodeRow ++ (z7UnaryCode8_s217.map z7DecodeRow ++ (z7UnaryCode8_s218.map z7DecodeRow ++ (z7UnaryCode8_s219.map z7DecodeRow ++ (z7UnaryCode8_s220.map z7DecodeRow ++ (z7UnaryCode8_s221.map z7DecodeRow ++ (z7UnaryCode8_s222.map z7DecodeRow ++ (z7UnaryCode8_s223.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s208_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s209_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s210_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s211_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s212_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s213_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s214_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s215_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s216_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s217_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s218_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s219_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s220_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s221_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s222_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s223_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 14 equals the joined decoded slices. -/
theorem z7Grp_8_14 :
    ([([2, 2, 1, 0], 7, 15, (-5 : Int)), ([2, 2, 1, 1], 6, 14, (-4 : Int)), ([2, 2, 1, 2], 5, 11, (-3 : Int)), ([2, 2, 1, 3], 4, 6, (-2 : Int)), ([2, 2, 2, 0], 6, 12, (-6 : Int)), ([2, 2, 2, 1], 5, 11, (-5 : Int)), ([2, 2, 2, 2], 4, 8, (-4 : Int)), ([2, 2, 2, 3], 3, 3, (-3 : Int)), ([2, 2, 3, 0], 5, 7, (-7 : Int)), ([2, 2, 3, 1], 4, 6, (-6 : Int)), ([2, 2, 3, 2], 3, 3, (-5 : Int)), ([2, 3, 0, 0], 7, 11, (-5 : Int)), ([2, 3, 0, 1], 6, 10, (-4 : Int)), ([2, 3, 0, 2], 5, 7, (-3 : Int)), ([2, 3, 0, 3], 4, 2, (-2 : Int)), ([2, 3, 1, 0], 6, 10, (-6 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s224.map z7DecodeRow ++ (z7UnaryCode8_s225.map z7DecodeRow ++ (z7UnaryCode8_s226.map z7DecodeRow ++ (z7UnaryCode8_s227.map z7DecodeRow ++ (z7UnaryCode8_s228.map z7DecodeRow ++ (z7UnaryCode8_s229.map z7DecodeRow ++ (z7UnaryCode8_s230.map z7DecodeRow ++ (z7UnaryCode8_s231.map z7DecodeRow ++ (z7UnaryCode8_s232.map z7DecodeRow ++ (z7UnaryCode8_s233.map z7DecodeRow ++ (z7UnaryCode8_s234.map z7DecodeRow ++ (z7UnaryCode8_s235.map z7DecodeRow ++ (z7UnaryCode8_s236.map z7DecodeRow ++ (z7UnaryCode8_s237.map z7DecodeRow ++ (z7UnaryCode8_s238.map z7DecodeRow ++ (z7UnaryCode8_s239.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s224_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s225_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s226_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s227_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s228_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s229_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s230_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s231_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s232_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s233_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s234_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s235_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s236_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s237_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s238_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s239_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 15 equals the joined decoded slices. -/
theorem z7Grp_8_15 :
    ([([2, 3, 1, 1], 5, 9, (-5 : Int)), ([2, 3, 1, 2], 4, 6, (-4 : Int)), ([2, 3, 1, 3], 3, 1, (-3 : Int)), ([2, 3, 2, 0], 5, 7, (-7 : Int)), ([2, 3, 2, 1], 4, 6, (-6 : Int)), ([2, 3, 2, 2], 3, 3, (-5 : Int)), ([2, 3, 3, 0], 4, 2, (-8 : Int)), ([2, 3, 3, 1], 3, 1, (-7 : Int)), ([2, 4, 0, 0], 6, 4, (-6 : Int)), ([2, 4, 0, 1], 5, 3, (-5 : Int)), ([2, 4, 0, 2], 4, 0, (-4 : Int)), ([2, 4, 1, 0], 5, 3, (-7 : Int)), ([2, 4, 1, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 15, (-3 : Int)), ([3, 0, 0, 1], 8, 14, (-2 : Int)), ([3, 0, 0, 2], 7, 11, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s240.map z7DecodeRow ++ (z7UnaryCode8_s241.map z7DecodeRow ++ (z7UnaryCode8_s242.map z7DecodeRow ++ (z7UnaryCode8_s243.map z7DecodeRow ++ (z7UnaryCode8_s244.map z7DecodeRow ++ (z7UnaryCode8_s245.map z7DecodeRow ++ (z7UnaryCode8_s246.map z7DecodeRow ++ (z7UnaryCode8_s247.map z7DecodeRow ++ (z7UnaryCode8_s248.map z7DecodeRow ++ (z7UnaryCode8_s249.map z7DecodeRow ++ (z7UnaryCode8_s250.map z7DecodeRow ++ (z7UnaryCode8_s251.map z7DecodeRow ++ (z7UnaryCode8_s252.map z7DecodeRow ++ (z7UnaryCode8_s253.map z7DecodeRow ++ (z7UnaryCode8_s254.map z7DecodeRow ++ (z7UnaryCode8_s255.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s240_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s241_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s242_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s243_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s244_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s245_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s246_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s247_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s248_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s249_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s250_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s251_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s252_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s253_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s254_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s255_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 16 equals the joined decoded slices. -/
theorem z7Grp_8_16 :
    ([([3, 0, 0, 3], 6, 6, (0 : Int)), ([3, 0, 1, 0], 8, 14, (-4 : Int)), ([3, 0, 1, 1], 7, 13, (-3 : Int)), ([3, 0, 1, 2], 6, 10, (-2 : Int)), ([3, 0, 1, 3], 5, 5, (-1 : Int)), ([3, 0, 2, 0], 7, 11, (-5 : Int)), ([3, 0, 2, 1], 6, 10, (-4 : Int)), ([3, 0, 2, 2], 5, 7, (-3 : Int)), ([3, 0, 2, 3], 4, 2, (-2 : Int)), ([3, 0, 3, 0], 6, 6, (-6 : Int)), ([3, 0, 3, 1], 5, 5, (-5 : Int)), ([3, 0, 3, 2], 4, 2, (-4 : Int)), ([3, 1, 0, 0], 8, 14, (-4 : Int)), ([3, 1, 0, 1], 7, 13, (-3 : Int)), ([3, 1, 0, 2], 6, 10, (-2 : Int)), ([3, 1, 0, 3], 5, 5, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s256.map z7DecodeRow ++ (z7UnaryCode8_s257.map z7DecodeRow ++ (z7UnaryCode8_s258.map z7DecodeRow ++ (z7UnaryCode8_s259.map z7DecodeRow ++ (z7UnaryCode8_s260.map z7DecodeRow ++ (z7UnaryCode8_s261.map z7DecodeRow ++ (z7UnaryCode8_s262.map z7DecodeRow ++ (z7UnaryCode8_s263.map z7DecodeRow ++ (z7UnaryCode8_s264.map z7DecodeRow ++ (z7UnaryCode8_s265.map z7DecodeRow ++ (z7UnaryCode8_s266.map z7DecodeRow ++ (z7UnaryCode8_s267.map z7DecodeRow ++ (z7UnaryCode8_s268.map z7DecodeRow ++ (z7UnaryCode8_s269.map z7DecodeRow ++ (z7UnaryCode8_s270.map z7DecodeRow ++ (z7UnaryCode8_s271.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s256_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s257_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s258_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s259_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s260_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s261_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s262_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s263_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s264_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s265_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s266_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s267_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s268_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s269_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s270_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s271_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 17 equals the joined decoded slices. -/
theorem z7Grp_8_17 :
    ([([3, 1, 1, 0], 7, 13, (-5 : Int)), ([3, 1, 1, 1], 6, 12, (-4 : Int)), ([3, 1, 1, 2], 5, 9, (-3 : Int)), ([3, 1, 1, 3], 4, 4, (-2 : Int)), ([3, 1, 2, 0], 6, 10, (-6 : Int)), ([3, 1, 2, 1], 5, 9, (-5 : Int)), ([3, 1, 2, 2], 4, 6, (-4 : Int)), ([3, 1, 2, 3], 3, 1, (-3 : Int)), ([3, 1, 3, 0], 5, 5, (-7 : Int)), ([3, 1, 3, 1], 4, 4, (-6 : Int)), ([3, 1, 3, 2], 3, 1, (-5 : Int)), ([3, 2, 0, 0], 7, 11, (-5 : Int)), ([3, 2, 0, 1], 6, 10, (-4 : Int)), ([3, 2, 0, 2], 5, 7, (-3 : Int)), ([3, 2, 0, 3], 4, 2, (-2 : Int)), ([3, 2, 1, 0], 6, 10, (-6 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s272.map z7DecodeRow ++ (z7UnaryCode8_s273.map z7DecodeRow ++ (z7UnaryCode8_s274.map z7DecodeRow ++ (z7UnaryCode8_s275.map z7DecodeRow ++ (z7UnaryCode8_s276.map z7DecodeRow ++ (z7UnaryCode8_s277.map z7DecodeRow ++ (z7UnaryCode8_s278.map z7DecodeRow ++ (z7UnaryCode8_s279.map z7DecodeRow ++ (z7UnaryCode8_s280.map z7DecodeRow ++ (z7UnaryCode8_s281.map z7DecodeRow ++ (z7UnaryCode8_s282.map z7DecodeRow ++ (z7UnaryCode8_s283.map z7DecodeRow ++ (z7UnaryCode8_s284.map z7DecodeRow ++ (z7UnaryCode8_s285.map z7DecodeRow ++ (z7UnaryCode8_s286.map z7DecodeRow ++ (z7UnaryCode8_s287.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s272_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s273_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s274_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s275_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s276_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s277_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s278_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s279_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s280_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s281_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s282_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s283_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s284_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s285_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s286_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s287_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 18 equals the joined decoded slices. -/
theorem z7Grp_8_18 :
    ([([3, 2, 1, 1], 5, 9, (-5 : Int)), ([3, 2, 1, 2], 4, 6, (-4 : Int)), ([3, 2, 1, 3], 3, 1, (-3 : Int)), ([3, 2, 2, 0], 5, 7, (-7 : Int)), ([3, 2, 2, 1], 4, 6, (-6 : Int)), ([3, 2, 2, 2], 3, 3, (-5 : Int)), ([3, 2, 3, 0], 4, 2, (-8 : Int)), ([3, 2, 3, 1], 3, 1, (-7 : Int)), ([3, 3, 0, 0], 6, 6, (-6 : Int)), ([3, 3, 0, 1], 5, 5, (-5 : Int)), ([3, 3, 0, 2], 4, 2, (-4 : Int)), ([3, 3, 1, 0], 5, 5, (-7 : Int)), ([3, 3, 1, 1], 4, 4, (-6 : Int)), ([3, 3, 1, 2], 3, 1, (-5 : Int)), ([3, 3, 2, 0], 4, 2, (-8 : Int)), ([3, 3, 2, 1], 3, 1, (-7 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s288.map z7DecodeRow ++ (z7UnaryCode8_s289.map z7DecodeRow ++ (z7UnaryCode8_s290.map z7DecodeRow ++ (z7UnaryCode8_s291.map z7DecodeRow ++ (z7UnaryCode8_s292.map z7DecodeRow ++ (z7UnaryCode8_s293.map z7DecodeRow ++ (z7UnaryCode8_s294.map z7DecodeRow ++ (z7UnaryCode8_s295.map z7DecodeRow ++ (z7UnaryCode8_s296.map z7DecodeRow ++ (z7UnaryCode8_s297.map z7DecodeRow ++ (z7UnaryCode8_s298.map z7DecodeRow ++ (z7UnaryCode8_s299.map z7DecodeRow ++ (z7UnaryCode8_s300.map z7DecodeRow ++ (z7UnaryCode8_s301.map z7DecodeRow ++ (z7UnaryCode8_s302.map z7DecodeRow ++ (z7UnaryCode8_s303.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s288_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s289_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s290_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s291_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s292_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s293_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s294_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s295_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s296_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s297_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s298_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s299_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s300_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s301_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s302_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s303_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 19 equals the joined decoded slices. -/
theorem z7Grp_8_19 :
    ([([4, 0, 0, 0], 8, 8, (-4 : Int)), ([4, 0, 0, 1], 7, 7, (-3 : Int)), ([4, 0, 0, 2], 6, 4, (-2 : Int)), ([4, 0, 1, 0], 7, 7, (-5 : Int)), ([4, 0, 1, 1], 6, 6, (-4 : Int)), ([4, 0, 1, 2], 5, 3, (-3 : Int)), ([4, 0, 2, 0], 6, 4, (-6 : Int)), ([4, 0, 2, 1], 5, 3, (-5 : Int)), ([4, 0, 2, 2], 4, 0, (-4 : Int)), ([4, 1, 0, 0], 7, 7, (-5 : Int)), ([4, 1, 0, 1], 6, 6, (-4 : Int)), ([4, 1, 0, 2], 5, 3, (-3 : Int)), ([4, 1, 1, 0], 6, 6, (-6 : Int)), ([4, 1, 1, 1], 5, 5, (-5 : Int)), ([4, 1, 1, 2], 4, 2, (-4 : Int)), ([4, 1, 2, 0], 5, 3, (-7 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s304.map z7DecodeRow ++ (z7UnaryCode8_s305.map z7DecodeRow ++ (z7UnaryCode8_s306.map z7DecodeRow ++ (z7UnaryCode8_s307.map z7DecodeRow ++ (z7UnaryCode8_s308.map z7DecodeRow ++ (z7UnaryCode8_s309.map z7DecodeRow ++ (z7UnaryCode8_s310.map z7DecodeRow ++ (z7UnaryCode8_s311.map z7DecodeRow ++ (z7UnaryCode8_s312.map z7DecodeRow ++ (z7UnaryCode8_s313.map z7DecodeRow ++ (z7UnaryCode8_s314.map z7DecodeRow ++ (z7UnaryCode8_s315.map z7DecodeRow ++ (z7UnaryCode8_s316.map z7DecodeRow ++ (z7UnaryCode8_s317.map z7DecodeRow ++ (z7UnaryCode8_s318.map z7DecodeRow ++ (z7UnaryCode8_s319.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s304_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s305_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s306_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s307_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s308_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s309_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s310_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s311_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s312_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s313_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s314_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s315_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s316_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s317_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s318_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s319_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 20 equals the joined decoded slices. -/
theorem z7Grp_8_20 :
    ([([4, 1, 2, 1], 4, 2, (-6 : Int)), ([4, 2, 0, 0], 6, 4, (-6 : Int)), ([4, 2, 0, 1], 5, 3, (-5 : Int)), ([4, 2, 0, 2], 4, 0, (-4 : Int)), ([4, 2, 1, 0], 5, 3, (-7 : Int)), ([4, 2, 1, 1], 4, 2, (-6 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (8 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode8_s320.map z7DecodeRow ++ (z7UnaryCode8_s321.map z7DecodeRow ++ (z7UnaryCode8_s322.map z7DecodeRow ++ (z7UnaryCode8_s323.map z7DecodeRow ++ (z7UnaryCode8_s324.map z7DecodeRow ++ (z7UnaryCode8_s325.map z7DecodeRow))))) := by
  rw [List.flatMap_cons, z7UnaryRows8_s320_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s321_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s322_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s323_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s324_eq]
  rw [List.flatMap_cons, z7UnaryRows8_s325_eq]
  rw [List.flatMap_nil, List.append_nil]

theorem z7UnaryRows_cached_8 : z7UnaryRows 8 = z7UnaryCode8.map z7DecodeRow := by
  unfold z7UnaryRows z7UnaryCode8
  rw [z7GenRow_split 4 12 (8 : Fin 12).val 0 [] 12
      (z7ExteriorTarget 8 8) 0 (by decide) (by decide)]
  rw [states_8]
  rw [show [([0, 0, 0, 0], 12, 24, (0 : Int)), ([0, 0, 0, 1], 11, 23, (1 : Int)), ([0, 0, 0, 2], 10, 20, (2 : Int)), ([0, 0, 0, 3], 9, 15, (3 : Int)), ([0, 0, 0, 4], 8, 8, (4 : Int)), ([0, 0, 1, 0], 11, 23, (-1 : Int)), ([0, 0, 1, 1], 10, 22, (0 : Int)), ([0, 0, 1, 2], 9, 19, (1 : Int)), ([0, 0, 1, 3], 8, 14, (2 : Int)), ([0, 0, 1, 4], 7, 7, (3 : Int)), ([0, 0, 2, 0], 10, 20, (-2 : Int)), ([0, 0, 2, 1], 9, 19, (-1 : Int)), ([0, 0, 2, 2], 8, 16, (0 : Int)), ([0, 0, 2, 3], 7, 11, (1 : Int)), ([0, 0, 2, 4], 6, 4, (2 : Int)), ([0, 0, 3, 0], 9, 15, (-3 : Int)), ([0, 0, 3, 1], 8, 14, (-2 : Int)), ([0, 0, 3, 2], 7, 11, (-1 : Int)), ([0, 0, 3, 3], 6, 6, (0 : Int)), ([0, 0, 4, 0], 8, 8, (-4 : Int)), ([0, 0, 4, 1], 7, 7, (-3 : Int)), ([0, 0, 4, 2], 6, 4, (-2 : Int)), ([0, 1, 0, 0], 11, 23, (-1 : Int)), ([0, 1, 0, 1], 10, 22, (0 : Int)), ([0, 1, 0, 2], 9, 19, (1 : Int)), ([0, 1, 0, 3], 8, 14, (2 : Int)), ([0, 1, 0, 4], 7, 7, (3 : Int)), ([0, 1, 1, 0], 10, 22, (-2 : Int)), ([0, 1, 1, 1], 9, 21, (-1 : Int)), ([0, 1, 1, 2], 8, 18, (0 : Int)), ([0, 1, 1, 3], 7, 13, (1 : Int)), ([0, 1, 1, 4], 6, 6, (2 : Int)), ([0, 1, 2, 0], 9, 19, (-3 : Int)), ([0, 1, 2, 1], 8, 18, (-2 : Int)), ([0, 1, 2, 2], 7, 15, (-1 : Int)), ([0, 1, 2, 3], 6, 10, (0 : Int)), ([0, 1, 2, 4], 5, 3, (1 : Int)), ([0, 1, 3, 0], 8, 14, (-4 : Int)), ([0, 1, 3, 1], 7, 13, (-3 : Int)), ([0, 1, 3, 2], 6, 10, (-2 : Int)), ([0, 1, 3, 3], 5, 5, (-1 : Int)), ([0, 1, 4, 0], 7, 7, (-5 : Int)), ([0, 1, 4, 1], 6, 6, (-4 : Int)), ([0, 1, 4, 2], 5, 3, (-3 : Int)), ([0, 2, 0, 0], 10, 20, (-2 : Int)), ([0, 2, 0, 1], 9, 19, (-1 : Int)), ([0, 2, 0, 2], 8, 16, (0 : Int)), ([0, 2, 0, 3], 7, 11, (1 : Int)), ([0, 2, 0, 4], 6, 4, (2 : Int)), ([0, 2, 1, 0], 9, 19, (-3 : Int)), ([0, 2, 1, 1], 8, 18, (-2 : Int)), ([0, 2, 1, 2], 7, 15, (-1 : Int)), ([0, 2, 1, 3], 6, 10, (0 : Int)), ([0, 2, 1, 4], 5, 3, (1 : Int)), ([0, 2, 2, 0], 8, 16, (-4 : Int)), ([0, 2, 2, 1], 7, 15, (-3 : Int)), ([0, 2, 2, 2], 6, 12, (-2 : Int)), ([0, 2, 2, 3], 5, 7, (-1 : Int)), ([0, 2, 2, 4], 4, 0, (0 : Int)), ([0, 2, 3, 0], 7, 11, (-5 : Int)), ([0, 2, 3, 1], 6, 10, (-4 : Int)), ([0, 2, 3, 2], 5, 7, (-3 : Int)), ([0, 2, 3, 3], 4, 2, (-2 : Int)), ([0, 2, 4, 0], 6, 4, (-6 : Int)), ([0, 2, 4, 1], 5, 3, (-5 : Int)), ([0, 2, 4, 2], 4, 0, (-4 : Int)), ([0, 3, 0, 0], 9, 15, (-3 : Int)), ([0, 3, 0, 1], 8, 14, (-2 : Int)), ([0, 3, 0, 2], 7, 11, (-1 : Int)), ([0, 3, 0, 3], 6, 6, (0 : Int)), ([0, 3, 1, 0], 8, 14, (-4 : Int)), ([0, 3, 1, 1], 7, 13, (-3 : Int)), ([0, 3, 1, 2], 6, 10, (-2 : Int)), ([0, 3, 1, 3], 5, 5, (-1 : Int)), ([0, 3, 2, 0], 7, 11, (-5 : Int)), ([0, 3, 2, 1], 6, 10, (-4 : Int)), ([0, 3, 2, 2], 5, 7, (-3 : Int)), ([0, 3, 2, 3], 4, 2, (-2 : Int)), ([0, 3, 3, 0], 6, 6, (-6 : Int)), ([0, 3, 3, 1], 5, 5, (-5 : Int)), ([0, 3, 3, 2], 4, 2, (-4 : Int)), ([0, 4, 0, 0], 8, 8, (-4 : Int)), ([0, 4, 0, 1], 7, 7, (-3 : Int)), ([0, 4, 0, 2], 6, 4, (-2 : Int)), ([0, 4, 1, 0], 7, 7, (-5 : Int)), ([0, 4, 1, 1], 6, 6, (-4 : Int)), ([0, 4, 1, 2], 5, 3, (-3 : Int)), ([0, 4, 2, 0], 6, 4, (-6 : Int)), ([0, 4, 2, 1], 5, 3, (-5 : Int)), ([0, 4, 2, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 23, (-1 : Int)), ([1, 0, 0, 1], 10, 22, (0 : Int)), ([1, 0, 0, 2], 9, 19, (1 : Int)), ([1, 0, 0, 3], 8, 14, (2 : Int)), ([1, 0, 0, 4], 7, 7, (3 : Int)), ([1, 0, 1, 0], 10, 22, (-2 : Int)), ([1, 0, 1, 1], 9, 21, (-1 : Int)), ([1, 0, 1, 2], 8, 18, (0 : Int)), ([1, 0, 1, 3], 7, 13, (1 : Int)), ([1, 0, 1, 4], 6, 6, (2 : Int)), ([1, 0, 2, 0], 9, 19, (-3 : Int)), ([1, 0, 2, 1], 8, 18, (-2 : Int)), ([1, 0, 2, 2], 7, 15, (-1 : Int)), ([1, 0, 2, 3], 6, 10, (0 : Int)), ([1, 0, 2, 4], 5, 3, (1 : Int)), ([1, 0, 3, 0], 8, 14, (-4 : Int)), ([1, 0, 3, 1], 7, 13, (-3 : Int)), ([1, 0, 3, 2], 6, 10, (-2 : Int)), ([1, 0, 3, 3], 5, 5, (-1 : Int)), ([1, 0, 4, 0], 7, 7, (-5 : Int)), ([1, 0, 4, 1], 6, 6, (-4 : Int)), ([1, 0, 4, 2], 5, 3, (-3 : Int)), ([1, 1, 0, 0], 10, 22, (-2 : Int)), ([1, 1, 0, 1], 9, 21, (-1 : Int)), ([1, 1, 0, 2], 8, 18, (0 : Int)), ([1, 1, 0, 3], 7, 13, (1 : Int)), ([1, 1, 0, 4], 6, 6, (2 : Int)), ([1, 1, 1, 0], 9, 21, (-3 : Int)), ([1, 1, 1, 1], 8, 20, (-2 : Int)), ([1, 1, 1, 2], 7, 17, (-1 : Int)), ([1, 1, 1, 3], 6, 12, (0 : Int)), ([1, 1, 1, 4], 5, 5, (1 : Int)), ([1, 1, 2, 0], 8, 18, (-4 : Int)), ([1, 1, 2, 1], 7, 17, (-3 : Int)), ([1, 1, 2, 2], 6, 14, (-2 : Int)), ([1, 1, 2, 3], 5, 9, (-1 : Int)), ([1, 1, 2, 4], 4, 2, (0 : Int)), ([1, 1, 3, 0], 7, 13, (-5 : Int)), ([1, 1, 3, 1], 6, 12, (-4 : Int)), ([1, 1, 3, 2], 5, 9, (-3 : Int)), ([1, 1, 3, 3], 4, 4, (-2 : Int)), ([1, 1, 4, 0], 6, 6, (-6 : Int)), ([1, 1, 4, 1], 5, 5, (-5 : Int)), ([1, 1, 4, 2], 4, 2, (-4 : Int)), ([1, 2, 0, 0], 9, 19, (-3 : Int)), ([1, 2, 0, 1], 8, 18, (-2 : Int)), ([1, 2, 0, 2], 7, 15, (-1 : Int)), ([1, 2, 0, 3], 6, 10, (0 : Int)), ([1, 2, 0, 4], 5, 3, (1 : Int)), ([1, 2, 1, 0], 8, 18, (-4 : Int)), ([1, 2, 1, 1], 7, 17, (-3 : Int)), ([1, 2, 1, 2], 6, 14, (-2 : Int)), ([1, 2, 1, 3], 5, 9, (-1 : Int)), ([1, 2, 1, 4], 4, 2, (0 : Int)), ([1, 2, 2, 0], 7, 15, (-5 : Int)), ([1, 2, 2, 1], 6, 14, (-4 : Int)), ([1, 2, 2, 2], 5, 11, (-3 : Int)), ([1, 2, 2, 3], 4, 6, (-2 : Int)), ([1, 2, 3, 0], 6, 10, (-6 : Int)), ([1, 2, 3, 1], 5, 9, (-5 : Int)), ([1, 2, 3, 2], 4, 6, (-4 : Int)), ([1, 2, 3, 3], 3, 1, (-3 : Int)), ([1, 2, 4, 0], 5, 3, (-7 : Int)), ([1, 2, 4, 1], 4, 2, (-6 : Int)), ([1, 3, 0, 0], 8, 14, (-4 : Int)), ([1, 3, 0, 1], 7, 13, (-3 : Int)), ([1, 3, 0, 2], 6, 10, (-2 : Int)), ([1, 3, 0, 3], 5, 5, (-1 : Int)), ([1, 3, 1, 0], 7, 13, (-5 : Int)), ([1, 3, 1, 1], 6, 12, (-4 : Int)), ([1, 3, 1, 2], 5, 9, (-3 : Int)), ([1, 3, 1, 3], 4, 4, (-2 : Int)), ([1, 3, 2, 0], 6, 10, (-6 : Int)), ([1, 3, 2, 1], 5, 9, (-5 : Int)), ([1, 3, 2, 2], 4, 6, (-4 : Int)), ([1, 3, 2, 3], 3, 1, (-3 : Int)), ([1, 3, 3, 0], 5, 5, (-7 : Int)), ([1, 3, 3, 1], 4, 4, (-6 : Int)), ([1, 3, 3, 2], 3, 1, (-5 : Int)), ([1, 4, 0, 0], 7, 7, (-5 : Int)), ([1, 4, 0, 1], 6, 6, (-4 : Int)), ([1, 4, 0, 2], 5, 3, (-3 : Int)), ([1, 4, 1, 0], 6, 6, (-6 : Int)), ([1, 4, 1, 1], 5, 5, (-5 : Int)), ([1, 4, 1, 2], 4, 2, (-4 : Int)), ([1, 4, 2, 0], 5, 3, (-7 : Int)), ([1, 4, 2, 1], 4, 2, (-6 : Int)), ([2, 0, 0, 0], 10, 20, (-2 : Int)), ([2, 0, 0, 1], 9, 19, (-1 : Int)), ([2, 0, 0, 2], 8, 16, (0 : Int)), ([2, 0, 0, 3], 7, 11, (1 : Int)), ([2, 0, 0, 4], 6, 4, (2 : Int)), ([2, 0, 1, 0], 9, 19, (-3 : Int)), ([2, 0, 1, 1], 8, 18, (-2 : Int)), ([2, 0, 1, 2], 7, 15, (-1 : Int)), ([2, 0, 1, 3], 6, 10, (0 : Int)), ([2, 0, 1, 4], 5, 3, (1 : Int)), ([2, 0, 2, 0], 8, 16, (-4 : Int)), ([2, 0, 2, 1], 7, 15, (-3 : Int)), ([2, 0, 2, 2], 6, 12, (-2 : Int)), ([2, 0, 2, 3], 5, 7, (-1 : Int)), ([2, 0, 2, 4], 4, 0, (0 : Int)), ([2, 0, 3, 0], 7, 11, (-5 : Int)), ([2, 0, 3, 1], 6, 10, (-4 : Int)), ([2, 0, 3, 2], 5, 7, (-3 : Int)), ([2, 0, 3, 3], 4, 2, (-2 : Int)), ([2, 0, 4, 0], 6, 4, (-6 : Int)), ([2, 0, 4, 1], 5, 3, (-5 : Int)), ([2, 0, 4, 2], 4, 0, (-4 : Int)), ([2, 1, 0, 0], 9, 19, (-3 : Int)), ([2, 1, 0, 1], 8, 18, (-2 : Int)), ([2, 1, 0, 2], 7, 15, (-1 : Int)), ([2, 1, 0, 3], 6, 10, (0 : Int)), ([2, 1, 0, 4], 5, 3, (1 : Int)), ([2, 1, 1, 0], 8, 18, (-4 : Int)), ([2, 1, 1, 1], 7, 17, (-3 : Int)), ([2, 1, 1, 2], 6, 14, (-2 : Int)), ([2, 1, 1, 3], 5, 9, (-1 : Int)), ([2, 1, 1, 4], 4, 2, (0 : Int)), ([2, 1, 2, 0], 7, 15, (-5 : Int)), ([2, 1, 2, 1], 6, 14, (-4 : Int)), ([2, 1, 2, 2], 5, 11, (-3 : Int)), ([2, 1, 2, 3], 4, 6, (-2 : Int)), ([2, 1, 3, 0], 6, 10, (-6 : Int)), ([2, 1, 3, 1], 5, 9, (-5 : Int)), ([2, 1, 3, 2], 4, 6, (-4 : Int)), ([2, 1, 3, 3], 3, 1, (-3 : Int)), ([2, 1, 4, 0], 5, 3, (-7 : Int)), ([2, 1, 4, 1], 4, 2, (-6 : Int)), ([2, 2, 0, 0], 8, 16, (-4 : Int)), ([2, 2, 0, 1], 7, 15, (-3 : Int)), ([2, 2, 0, 2], 6, 12, (-2 : Int)), ([2, 2, 0, 3], 5, 7, (-1 : Int)), ([2, 2, 0, 4], 4, 0, (0 : Int)), ([2, 2, 1, 0], 7, 15, (-5 : Int)), ([2, 2, 1, 1], 6, 14, (-4 : Int)), ([2, 2, 1, 2], 5, 11, (-3 : Int)), ([2, 2, 1, 3], 4, 6, (-2 : Int)), ([2, 2, 2, 0], 6, 12, (-6 : Int)), ([2, 2, 2, 1], 5, 11, (-5 : Int)), ([2, 2, 2, 2], 4, 8, (-4 : Int)), ([2, 2, 2, 3], 3, 3, (-3 : Int)), ([2, 2, 3, 0], 5, 7, (-7 : Int)), ([2, 2, 3, 1], 4, 6, (-6 : Int)), ([2, 2, 3, 2], 3, 3, (-5 : Int)), ([2, 3, 0, 0], 7, 11, (-5 : Int)), ([2, 3, 0, 1], 6, 10, (-4 : Int)), ([2, 3, 0, 2], 5, 7, (-3 : Int)), ([2, 3, 0, 3], 4, 2, (-2 : Int)), ([2, 3, 1, 0], 6, 10, (-6 : Int)), ([2, 3, 1, 1], 5, 9, (-5 : Int)), ([2, 3, 1, 2], 4, 6, (-4 : Int)), ([2, 3, 1, 3], 3, 1, (-3 : Int)), ([2, 3, 2, 0], 5, 7, (-7 : Int)), ([2, 3, 2, 1], 4, 6, (-6 : Int)), ([2, 3, 2, 2], 3, 3, (-5 : Int)), ([2, 3, 3, 0], 4, 2, (-8 : Int)), ([2, 3, 3, 1], 3, 1, (-7 : Int)), ([2, 4, 0, 0], 6, 4, (-6 : Int)), ([2, 4, 0, 1], 5, 3, (-5 : Int)), ([2, 4, 0, 2], 4, 0, (-4 : Int)), ([2, 4, 1, 0], 5, 3, (-7 : Int)), ([2, 4, 1, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 15, (-3 : Int)), ([3, 0, 0, 1], 8, 14, (-2 : Int)), ([3, 0, 0, 2], 7, 11, (-1 : Int)), ([3, 0, 0, 3], 6, 6, (0 : Int)), ([3, 0, 1, 0], 8, 14, (-4 : Int)), ([3, 0, 1, 1], 7, 13, (-3 : Int)), ([3, 0, 1, 2], 6, 10, (-2 : Int)), ([3, 0, 1, 3], 5, 5, (-1 : Int)), ([3, 0, 2, 0], 7, 11, (-5 : Int)), ([3, 0, 2, 1], 6, 10, (-4 : Int)), ([3, 0, 2, 2], 5, 7, (-3 : Int)), ([3, 0, 2, 3], 4, 2, (-2 : Int)), ([3, 0, 3, 0], 6, 6, (-6 : Int)), ([3, 0, 3, 1], 5, 5, (-5 : Int)), ([3, 0, 3, 2], 4, 2, (-4 : Int)), ([3, 1, 0, 0], 8, 14, (-4 : Int)), ([3, 1, 0, 1], 7, 13, (-3 : Int)), ([3, 1, 0, 2], 6, 10, (-2 : Int)), ([3, 1, 0, 3], 5, 5, (-1 : Int)), ([3, 1, 1, 0], 7, 13, (-5 : Int)), ([3, 1, 1, 1], 6, 12, (-4 : Int)), ([3, 1, 1, 2], 5, 9, (-3 : Int)), ([3, 1, 1, 3], 4, 4, (-2 : Int)), ([3, 1, 2, 0], 6, 10, (-6 : Int)), ([3, 1, 2, 1], 5, 9, (-5 : Int)), ([3, 1, 2, 2], 4, 6, (-4 : Int)), ([3, 1, 2, 3], 3, 1, (-3 : Int)), ([3, 1, 3, 0], 5, 5, (-7 : Int)), ([3, 1, 3, 1], 4, 4, (-6 : Int)), ([3, 1, 3, 2], 3, 1, (-5 : Int)), ([3, 2, 0, 0], 7, 11, (-5 : Int)), ([3, 2, 0, 1], 6, 10, (-4 : Int)), ([3, 2, 0, 2], 5, 7, (-3 : Int)), ([3, 2, 0, 3], 4, 2, (-2 : Int)), ([3, 2, 1, 0], 6, 10, (-6 : Int)), ([3, 2, 1, 1], 5, 9, (-5 : Int)), ([3, 2, 1, 2], 4, 6, (-4 : Int)), ([3, 2, 1, 3], 3, 1, (-3 : Int)), ([3, 2, 2, 0], 5, 7, (-7 : Int)), ([3, 2, 2, 1], 4, 6, (-6 : Int)), ([3, 2, 2, 2], 3, 3, (-5 : Int)), ([3, 2, 3, 0], 4, 2, (-8 : Int)), ([3, 2, 3, 1], 3, 1, (-7 : Int)), ([3, 3, 0, 0], 6, 6, (-6 : Int)), ([3, 3, 0, 1], 5, 5, (-5 : Int)), ([3, 3, 0, 2], 4, 2, (-4 : Int)), ([3, 3, 1, 0], 5, 5, (-7 : Int)), ([3, 3, 1, 1], 4, 4, (-6 : Int)), ([3, 3, 1, 2], 3, 1, (-5 : Int)), ([3, 3, 2, 0], 4, 2, (-8 : Int)), ([3, 3, 2, 1], 3, 1, (-7 : Int)), ([4, 0, 0, 0], 8, 8, (-4 : Int)), ([4, 0, 0, 1], 7, 7, (-3 : Int)), ([4, 0, 0, 2], 6, 4, (-2 : Int)), ([4, 0, 1, 0], 7, 7, (-5 : Int)), ([4, 0, 1, 1], 6, 6, (-4 : Int)), ([4, 0, 1, 2], 5, 3, (-3 : Int)), ([4, 0, 2, 0], 6, 4, (-6 : Int)), ([4, 0, 2, 1], 5, 3, (-5 : Int)), ([4, 0, 2, 2], 4, 0, (-4 : Int)), ([4, 1, 0, 0], 7, 7, (-5 : Int)), ([4, 1, 0, 1], 6, 6, (-4 : Int)), ([4, 1, 0, 2], 5, 3, (-3 : Int)), ([4, 1, 1, 0], 6, 6, (-6 : Int)), ([4, 1, 1, 1], 5, 5, (-5 : Int)), ([4, 1, 1, 2], 4, 2, (-4 : Int)), ([4, 1, 2, 0], 5, 3, (-7 : Int)), ([4, 1, 2, 1], 4, 2, (-6 : Int)), ([4, 2, 0, 0], 6, 4, (-6 : Int)), ([4, 2, 0, 1], 5, 3, (-5 : Int)), ([4, 2, 0, 2], 4, 0, (-4 : Int)), ([4, 2, 1, 0], 5, 3, (-7 : Int)), ([4, 2, 1, 1], 4, 2, (-6 : Int))] = [([0, 0, 0, 0], 12, 24, (0 : Int)), ([0, 0, 0, 1], 11, 23, (1 : Int)), ([0, 0, 0, 2], 10, 20, (2 : Int)), ([0, 0, 0, 3], 9, 15, (3 : Int)), ([0, 0, 0, 4], 8, 8, (4 : Int)), ([0, 0, 1, 0], 11, 23, (-1 : Int)), ([0, 0, 1, 1], 10, 22, (0 : Int)), ([0, 0, 1, 2], 9, 19, (1 : Int)), ([0, 0, 1, 3], 8, 14, (2 : Int)), ([0, 0, 1, 4], 7, 7, (3 : Int)), ([0, 0, 2, 0], 10, 20, (-2 : Int)), ([0, 0, 2, 1], 9, 19, (-1 : Int)), ([0, 0, 2, 2], 8, 16, (0 : Int)), ([0, 0, 2, 3], 7, 11, (1 : Int)), ([0, 0, 2, 4], 6, 4, (2 : Int)), ([0, 0, 3, 0], 9, 15, (-3 : Int))] ++ ([([0, 0, 3, 1], 8, 14, (-2 : Int)), ([0, 0, 3, 2], 7, 11, (-1 : Int)), ([0, 0, 3, 3], 6, 6, (0 : Int)), ([0, 0, 4, 0], 8, 8, (-4 : Int)), ([0, 0, 4, 1], 7, 7, (-3 : Int)), ([0, 0, 4, 2], 6, 4, (-2 : Int)), ([0, 1, 0, 0], 11, 23, (-1 : Int)), ([0, 1, 0, 1], 10, 22, (0 : Int)), ([0, 1, 0, 2], 9, 19, (1 : Int)), ([0, 1, 0, 3], 8, 14, (2 : Int)), ([0, 1, 0, 4], 7, 7, (3 : Int)), ([0, 1, 1, 0], 10, 22, (-2 : Int)), ([0, 1, 1, 1], 9, 21, (-1 : Int)), ([0, 1, 1, 2], 8, 18, (0 : Int)), ([0, 1, 1, 3], 7, 13, (1 : Int)), ([0, 1, 1, 4], 6, 6, (2 : Int))] ++ ([([0, 1, 2, 0], 9, 19, (-3 : Int)), ([0, 1, 2, 1], 8, 18, (-2 : Int)), ([0, 1, 2, 2], 7, 15, (-1 : Int)), ([0, 1, 2, 3], 6, 10, (0 : Int)), ([0, 1, 2, 4], 5, 3, (1 : Int)), ([0, 1, 3, 0], 8, 14, (-4 : Int)), ([0, 1, 3, 1], 7, 13, (-3 : Int)), ([0, 1, 3, 2], 6, 10, (-2 : Int)), ([0, 1, 3, 3], 5, 5, (-1 : Int)), ([0, 1, 4, 0], 7, 7, (-5 : Int)), ([0, 1, 4, 1], 6, 6, (-4 : Int)), ([0, 1, 4, 2], 5, 3, (-3 : Int)), ([0, 2, 0, 0], 10, 20, (-2 : Int)), ([0, 2, 0, 1], 9, 19, (-1 : Int)), ([0, 2, 0, 2], 8, 16, (0 : Int)), ([0, 2, 0, 3], 7, 11, (1 : Int))] ++ ([([0, 2, 0, 4], 6, 4, (2 : Int)), ([0, 2, 1, 0], 9, 19, (-3 : Int)), ([0, 2, 1, 1], 8, 18, (-2 : Int)), ([0, 2, 1, 2], 7, 15, (-1 : Int)), ([0, 2, 1, 3], 6, 10, (0 : Int)), ([0, 2, 1, 4], 5, 3, (1 : Int)), ([0, 2, 2, 0], 8, 16, (-4 : Int)), ([0, 2, 2, 1], 7, 15, (-3 : Int)), ([0, 2, 2, 2], 6, 12, (-2 : Int)), ([0, 2, 2, 3], 5, 7, (-1 : Int)), ([0, 2, 2, 4], 4, 0, (0 : Int)), ([0, 2, 3, 0], 7, 11, (-5 : Int)), ([0, 2, 3, 1], 6, 10, (-4 : Int)), ([0, 2, 3, 2], 5, 7, (-3 : Int)), ([0, 2, 3, 3], 4, 2, (-2 : Int)), ([0, 2, 4, 0], 6, 4, (-6 : Int))] ++ ([([0, 2, 4, 1], 5, 3, (-5 : Int)), ([0, 2, 4, 2], 4, 0, (-4 : Int)), ([0, 3, 0, 0], 9, 15, (-3 : Int)), ([0, 3, 0, 1], 8, 14, (-2 : Int)), ([0, 3, 0, 2], 7, 11, (-1 : Int)), ([0, 3, 0, 3], 6, 6, (0 : Int)), ([0, 3, 1, 0], 8, 14, (-4 : Int)), ([0, 3, 1, 1], 7, 13, (-3 : Int)), ([0, 3, 1, 2], 6, 10, (-2 : Int)), ([0, 3, 1, 3], 5, 5, (-1 : Int)), ([0, 3, 2, 0], 7, 11, (-5 : Int)), ([0, 3, 2, 1], 6, 10, (-4 : Int)), ([0, 3, 2, 2], 5, 7, (-3 : Int)), ([0, 3, 2, 3], 4, 2, (-2 : Int)), ([0, 3, 3, 0], 6, 6, (-6 : Int)), ([0, 3, 3, 1], 5, 5, (-5 : Int))] ++ ([([0, 3, 3, 2], 4, 2, (-4 : Int)), ([0, 4, 0, 0], 8, 8, (-4 : Int)), ([0, 4, 0, 1], 7, 7, (-3 : Int)), ([0, 4, 0, 2], 6, 4, (-2 : Int)), ([0, 4, 1, 0], 7, 7, (-5 : Int)), ([0, 4, 1, 1], 6, 6, (-4 : Int)), ([0, 4, 1, 2], 5, 3, (-3 : Int)), ([0, 4, 2, 0], 6, 4, (-6 : Int)), ([0, 4, 2, 1], 5, 3, (-5 : Int)), ([0, 4, 2, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 23, (-1 : Int)), ([1, 0, 0, 1], 10, 22, (0 : Int)), ([1, 0, 0, 2], 9, 19, (1 : Int)), ([1, 0, 0, 3], 8, 14, (2 : Int)), ([1, 0, 0, 4], 7, 7, (3 : Int)), ([1, 0, 1, 0], 10, 22, (-2 : Int))] ++ ([([1, 0, 1, 1], 9, 21, (-1 : Int)), ([1, 0, 1, 2], 8, 18, (0 : Int)), ([1, 0, 1, 3], 7, 13, (1 : Int)), ([1, 0, 1, 4], 6, 6, (2 : Int)), ([1, 0, 2, 0], 9, 19, (-3 : Int)), ([1, 0, 2, 1], 8, 18, (-2 : Int)), ([1, 0, 2, 2], 7, 15, (-1 : Int)), ([1, 0, 2, 3], 6, 10, (0 : Int)), ([1, 0, 2, 4], 5, 3, (1 : Int)), ([1, 0, 3, 0], 8, 14, (-4 : Int)), ([1, 0, 3, 1], 7, 13, (-3 : Int)), ([1, 0, 3, 2], 6, 10, (-2 : Int)), ([1, 0, 3, 3], 5, 5, (-1 : Int)), ([1, 0, 4, 0], 7, 7, (-5 : Int)), ([1, 0, 4, 1], 6, 6, (-4 : Int)), ([1, 0, 4, 2], 5, 3, (-3 : Int))] ++ ([([1, 1, 0, 0], 10, 22, (-2 : Int)), ([1, 1, 0, 1], 9, 21, (-1 : Int)), ([1, 1, 0, 2], 8, 18, (0 : Int)), ([1, 1, 0, 3], 7, 13, (1 : Int)), ([1, 1, 0, 4], 6, 6, (2 : Int)), ([1, 1, 1, 0], 9, 21, (-3 : Int)), ([1, 1, 1, 1], 8, 20, (-2 : Int)), ([1, 1, 1, 2], 7, 17, (-1 : Int)), ([1, 1, 1, 3], 6, 12, (0 : Int)), ([1, 1, 1, 4], 5, 5, (1 : Int)), ([1, 1, 2, 0], 8, 18, (-4 : Int)), ([1, 1, 2, 1], 7, 17, (-3 : Int)), ([1, 1, 2, 2], 6, 14, (-2 : Int)), ([1, 1, 2, 3], 5, 9, (-1 : Int)), ([1, 1, 2, 4], 4, 2, (0 : Int)), ([1, 1, 3, 0], 7, 13, (-5 : Int))] ++ ([([1, 1, 3, 1], 6, 12, (-4 : Int)), ([1, 1, 3, 2], 5, 9, (-3 : Int)), ([1, 1, 3, 3], 4, 4, (-2 : Int)), ([1, 1, 4, 0], 6, 6, (-6 : Int)), ([1, 1, 4, 1], 5, 5, (-5 : Int)), ([1, 1, 4, 2], 4, 2, (-4 : Int)), ([1, 2, 0, 0], 9, 19, (-3 : Int)), ([1, 2, 0, 1], 8, 18, (-2 : Int)), ([1, 2, 0, 2], 7, 15, (-1 : Int)), ([1, 2, 0, 3], 6, 10, (0 : Int)), ([1, 2, 0, 4], 5, 3, (1 : Int)), ([1, 2, 1, 0], 8, 18, (-4 : Int)), ([1, 2, 1, 1], 7, 17, (-3 : Int)), ([1, 2, 1, 2], 6, 14, (-2 : Int)), ([1, 2, 1, 3], 5, 9, (-1 : Int)), ([1, 2, 1, 4], 4, 2, (0 : Int))] ++ ([([1, 2, 2, 0], 7, 15, (-5 : Int)), ([1, 2, 2, 1], 6, 14, (-4 : Int)), ([1, 2, 2, 2], 5, 11, (-3 : Int)), ([1, 2, 2, 3], 4, 6, (-2 : Int)), ([1, 2, 3, 0], 6, 10, (-6 : Int)), ([1, 2, 3, 1], 5, 9, (-5 : Int)), ([1, 2, 3, 2], 4, 6, (-4 : Int)), ([1, 2, 3, 3], 3, 1, (-3 : Int)), ([1, 2, 4, 0], 5, 3, (-7 : Int)), ([1, 2, 4, 1], 4, 2, (-6 : Int)), ([1, 3, 0, 0], 8, 14, (-4 : Int)), ([1, 3, 0, 1], 7, 13, (-3 : Int)), ([1, 3, 0, 2], 6, 10, (-2 : Int)), ([1, 3, 0, 3], 5, 5, (-1 : Int)), ([1, 3, 1, 0], 7, 13, (-5 : Int)), ([1, 3, 1, 1], 6, 12, (-4 : Int))] ++ ([([1, 3, 1, 2], 5, 9, (-3 : Int)), ([1, 3, 1, 3], 4, 4, (-2 : Int)), ([1, 3, 2, 0], 6, 10, (-6 : Int)), ([1, 3, 2, 1], 5, 9, (-5 : Int)), ([1, 3, 2, 2], 4, 6, (-4 : Int)), ([1, 3, 2, 3], 3, 1, (-3 : Int)), ([1, 3, 3, 0], 5, 5, (-7 : Int)), ([1, 3, 3, 1], 4, 4, (-6 : Int)), ([1, 3, 3, 2], 3, 1, (-5 : Int)), ([1, 4, 0, 0], 7, 7, (-5 : Int)), ([1, 4, 0, 1], 6, 6, (-4 : Int)), ([1, 4, 0, 2], 5, 3, (-3 : Int)), ([1, 4, 1, 0], 6, 6, (-6 : Int)), ([1, 4, 1, 1], 5, 5, (-5 : Int)), ([1, 4, 1, 2], 4, 2, (-4 : Int)), ([1, 4, 2, 0], 5, 3, (-7 : Int))] ++ ([([1, 4, 2, 1], 4, 2, (-6 : Int)), ([2, 0, 0, 0], 10, 20, (-2 : Int)), ([2, 0, 0, 1], 9, 19, (-1 : Int)), ([2, 0, 0, 2], 8, 16, (0 : Int)), ([2, 0, 0, 3], 7, 11, (1 : Int)), ([2, 0, 0, 4], 6, 4, (2 : Int)), ([2, 0, 1, 0], 9, 19, (-3 : Int)), ([2, 0, 1, 1], 8, 18, (-2 : Int)), ([2, 0, 1, 2], 7, 15, (-1 : Int)), ([2, 0, 1, 3], 6, 10, (0 : Int)), ([2, 0, 1, 4], 5, 3, (1 : Int)), ([2, 0, 2, 0], 8, 16, (-4 : Int)), ([2, 0, 2, 1], 7, 15, (-3 : Int)), ([2, 0, 2, 2], 6, 12, (-2 : Int)), ([2, 0, 2, 3], 5, 7, (-1 : Int)), ([2, 0, 2, 4], 4, 0, (0 : Int))] ++ ([([2, 0, 3, 0], 7, 11, (-5 : Int)), ([2, 0, 3, 1], 6, 10, (-4 : Int)), ([2, 0, 3, 2], 5, 7, (-3 : Int)), ([2, 0, 3, 3], 4, 2, (-2 : Int)), ([2, 0, 4, 0], 6, 4, (-6 : Int)), ([2, 0, 4, 1], 5, 3, (-5 : Int)), ([2, 0, 4, 2], 4, 0, (-4 : Int)), ([2, 1, 0, 0], 9, 19, (-3 : Int)), ([2, 1, 0, 1], 8, 18, (-2 : Int)), ([2, 1, 0, 2], 7, 15, (-1 : Int)), ([2, 1, 0, 3], 6, 10, (0 : Int)), ([2, 1, 0, 4], 5, 3, (1 : Int)), ([2, 1, 1, 0], 8, 18, (-4 : Int)), ([2, 1, 1, 1], 7, 17, (-3 : Int)), ([2, 1, 1, 2], 6, 14, (-2 : Int)), ([2, 1, 1, 3], 5, 9, (-1 : Int))] ++ ([([2, 1, 1, 4], 4, 2, (0 : Int)), ([2, 1, 2, 0], 7, 15, (-5 : Int)), ([2, 1, 2, 1], 6, 14, (-4 : Int)), ([2, 1, 2, 2], 5, 11, (-3 : Int)), ([2, 1, 2, 3], 4, 6, (-2 : Int)), ([2, 1, 3, 0], 6, 10, (-6 : Int)), ([2, 1, 3, 1], 5, 9, (-5 : Int)), ([2, 1, 3, 2], 4, 6, (-4 : Int)), ([2, 1, 3, 3], 3, 1, (-3 : Int)), ([2, 1, 4, 0], 5, 3, (-7 : Int)), ([2, 1, 4, 1], 4, 2, (-6 : Int)), ([2, 2, 0, 0], 8, 16, (-4 : Int)), ([2, 2, 0, 1], 7, 15, (-3 : Int)), ([2, 2, 0, 2], 6, 12, (-2 : Int)), ([2, 2, 0, 3], 5, 7, (-1 : Int)), ([2, 2, 0, 4], 4, 0, (0 : Int))] ++ ([([2, 2, 1, 0], 7, 15, (-5 : Int)), ([2, 2, 1, 1], 6, 14, (-4 : Int)), ([2, 2, 1, 2], 5, 11, (-3 : Int)), ([2, 2, 1, 3], 4, 6, (-2 : Int)), ([2, 2, 2, 0], 6, 12, (-6 : Int)), ([2, 2, 2, 1], 5, 11, (-5 : Int)), ([2, 2, 2, 2], 4, 8, (-4 : Int)), ([2, 2, 2, 3], 3, 3, (-3 : Int)), ([2, 2, 3, 0], 5, 7, (-7 : Int)), ([2, 2, 3, 1], 4, 6, (-6 : Int)), ([2, 2, 3, 2], 3, 3, (-5 : Int)), ([2, 3, 0, 0], 7, 11, (-5 : Int)), ([2, 3, 0, 1], 6, 10, (-4 : Int)), ([2, 3, 0, 2], 5, 7, (-3 : Int)), ([2, 3, 0, 3], 4, 2, (-2 : Int)), ([2, 3, 1, 0], 6, 10, (-6 : Int))] ++ ([([2, 3, 1, 1], 5, 9, (-5 : Int)), ([2, 3, 1, 2], 4, 6, (-4 : Int)), ([2, 3, 1, 3], 3, 1, (-3 : Int)), ([2, 3, 2, 0], 5, 7, (-7 : Int)), ([2, 3, 2, 1], 4, 6, (-6 : Int)), ([2, 3, 2, 2], 3, 3, (-5 : Int)), ([2, 3, 3, 0], 4, 2, (-8 : Int)), ([2, 3, 3, 1], 3, 1, (-7 : Int)), ([2, 4, 0, 0], 6, 4, (-6 : Int)), ([2, 4, 0, 1], 5, 3, (-5 : Int)), ([2, 4, 0, 2], 4, 0, (-4 : Int)), ([2, 4, 1, 0], 5, 3, (-7 : Int)), ([2, 4, 1, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 15, (-3 : Int)), ([3, 0, 0, 1], 8, 14, (-2 : Int)), ([3, 0, 0, 2], 7, 11, (-1 : Int))] ++ ([([3, 0, 0, 3], 6, 6, (0 : Int)), ([3, 0, 1, 0], 8, 14, (-4 : Int)), ([3, 0, 1, 1], 7, 13, (-3 : Int)), ([3, 0, 1, 2], 6, 10, (-2 : Int)), ([3, 0, 1, 3], 5, 5, (-1 : Int)), ([3, 0, 2, 0], 7, 11, (-5 : Int)), ([3, 0, 2, 1], 6, 10, (-4 : Int)), ([3, 0, 2, 2], 5, 7, (-3 : Int)), ([3, 0, 2, 3], 4, 2, (-2 : Int)), ([3, 0, 3, 0], 6, 6, (-6 : Int)), ([3, 0, 3, 1], 5, 5, (-5 : Int)), ([3, 0, 3, 2], 4, 2, (-4 : Int)), ([3, 1, 0, 0], 8, 14, (-4 : Int)), ([3, 1, 0, 1], 7, 13, (-3 : Int)), ([3, 1, 0, 2], 6, 10, (-2 : Int)), ([3, 1, 0, 3], 5, 5, (-1 : Int))] ++ ([([3, 1, 1, 0], 7, 13, (-5 : Int)), ([3, 1, 1, 1], 6, 12, (-4 : Int)), ([3, 1, 1, 2], 5, 9, (-3 : Int)), ([3, 1, 1, 3], 4, 4, (-2 : Int)), ([3, 1, 2, 0], 6, 10, (-6 : Int)), ([3, 1, 2, 1], 5, 9, (-5 : Int)), ([3, 1, 2, 2], 4, 6, (-4 : Int)), ([3, 1, 2, 3], 3, 1, (-3 : Int)), ([3, 1, 3, 0], 5, 5, (-7 : Int)), ([3, 1, 3, 1], 4, 4, (-6 : Int)), ([3, 1, 3, 2], 3, 1, (-5 : Int)), ([3, 2, 0, 0], 7, 11, (-5 : Int)), ([3, 2, 0, 1], 6, 10, (-4 : Int)), ([3, 2, 0, 2], 5, 7, (-3 : Int)), ([3, 2, 0, 3], 4, 2, (-2 : Int)), ([3, 2, 1, 0], 6, 10, (-6 : Int))] ++ ([([3, 2, 1, 1], 5, 9, (-5 : Int)), ([3, 2, 1, 2], 4, 6, (-4 : Int)), ([3, 2, 1, 3], 3, 1, (-3 : Int)), ([3, 2, 2, 0], 5, 7, (-7 : Int)), ([3, 2, 2, 1], 4, 6, (-6 : Int)), ([3, 2, 2, 2], 3, 3, (-5 : Int)), ([3, 2, 3, 0], 4, 2, (-8 : Int)), ([3, 2, 3, 1], 3, 1, (-7 : Int)), ([3, 3, 0, 0], 6, 6, (-6 : Int)), ([3, 3, 0, 1], 5, 5, (-5 : Int)), ([3, 3, 0, 2], 4, 2, (-4 : Int)), ([3, 3, 1, 0], 5, 5, (-7 : Int)), ([3, 3, 1, 1], 4, 4, (-6 : Int)), ([3, 3, 1, 2], 3, 1, (-5 : Int)), ([3, 3, 2, 0], 4, 2, (-8 : Int)), ([3, 3, 2, 1], 3, 1, (-7 : Int))] ++ ([([4, 0, 0, 0], 8, 8, (-4 : Int)), ([4, 0, 0, 1], 7, 7, (-3 : Int)), ([4, 0, 0, 2], 6, 4, (-2 : Int)), ([4, 0, 1, 0], 7, 7, (-5 : Int)), ([4, 0, 1, 1], 6, 6, (-4 : Int)), ([4, 0, 1, 2], 5, 3, (-3 : Int)), ([4, 0, 2, 0], 6, 4, (-6 : Int)), ([4, 0, 2, 1], 5, 3, (-5 : Int)), ([4, 0, 2, 2], 4, 0, (-4 : Int)), ([4, 1, 0, 0], 7, 7, (-5 : Int)), ([4, 1, 0, 1], 6, 6, (-4 : Int)), ([4, 1, 0, 2], 5, 3, (-3 : Int)), ([4, 1, 1, 0], 6, 6, (-6 : Int)), ([4, 1, 1, 1], 5, 5, (-5 : Int)), ([4, 1, 1, 2], 4, 2, (-4 : Int)), ([4, 1, 2, 0], 5, 3, (-7 : Int))] ++ ([([4, 1, 2, 1], 4, 2, (-6 : Int)), ([4, 2, 0, 0], 6, 4, (-6 : Int)), ([4, 2, 0, 1], 5, 3, (-5 : Int)), ([4, 2, 0, 2], 4, 0, (-4 : Int)), ([4, 2, 1, 0], 5, 3, (-7 : Int)), ([4, 2, 1, 1], 4, 2, (-6 : Int))])))))))))))))))))))) from rfl]
  repeat rw [List.flatMap_append]
  rw [z7Grp_8_0, z7Grp_8_1, z7Grp_8_2, z7Grp_8_3, z7Grp_8_4, z7Grp_8_5, z7Grp_8_6, z7Grp_8_7, z7Grp_8_8, z7Grp_8_9, z7Grp_8_10, z7Grp_8_11, z7Grp_8_12, z7Grp_8_13, z7Grp_8_14, z7Grp_8_15, z7Grp_8_16, z7Grp_8_17, z7Grp_8_18, z7Grp_8_19, z7Grp_8_20]
  repeat rw [List.map_append]
  repeat rw [← List.append_assoc]

#print axioms z7UnaryRows_cached_8

end Matrix99
