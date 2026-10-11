import Conway.Z7GenSplit
import Conway.Z7UnaryCode5
namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 100000
set_option Elab.async false

/-- Reached depth-4 generator states for index 5. -/
theorem states_5 : z7GenStates 4 12 (5 : Fin 12).val 0 [] 12
    (z7ExteriorTarget 5 5) 0 = [([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int)), ([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 1, 0, 0], 11, 21, (-1 : Int)), ([0, 1, 0, 1], 10, 20, (0 : Int)), ([0, 1, 0, 2], 9, 17, (1 : Int)), ([0, 1, 0, 3], 8, 12, (2 : Int)), ([0, 1, 0, 4], 7, 5, (3 : Int)), ([0, 1, 1, 0], 10, 20, (-2 : Int)), ([0, 1, 1, 1], 9, 19, (-1 : Int)), ([0, 1, 1, 2], 8, 16, (0 : Int)), ([0, 1, 1, 3], 7, 11, (1 : Int)), ([0, 1, 1, 4], 6, 4, (2 : Int)), ([0, 1, 2, 0], 9, 17, (-3 : Int)), ([0, 1, 2, 1], 8, 16, (-2 : Int)), ([0, 1, 2, 2], 7, 13, (-1 : Int)), ([0, 1, 2, 3], 6, 8, (0 : Int)), ([0, 1, 2, 4], 5, 1, (1 : Int)), ([0, 1, 3, 0], 8, 12, (-4 : Int)), ([0, 1, 3, 1], 7, 11, (-3 : Int)), ([0, 1, 3, 2], 6, 8, (-2 : Int)), ([0, 1, 3, 3], 5, 3, (-1 : Int)), ([0, 2, 0, 0], 10, 18, (-2 : Int)), ([0, 2, 0, 1], 9, 17, (-1 : Int)), ([0, 2, 0, 2], 8, 14, (0 : Int)), ([0, 2, 0, 3], 7, 9, (1 : Int)), ([0, 2, 0, 4], 6, 2, (2 : Int)), ([0, 2, 1, 0], 9, 17, (-3 : Int)), ([0, 2, 1, 1], 8, 16, (-2 : Int)), ([0, 2, 1, 2], 7, 13, (-1 : Int)), ([0, 2, 1, 3], 6, 8, (0 : Int)), ([0, 2, 1, 4], 5, 1, (1 : Int)), ([0, 2, 2, 0], 8, 14, (-4 : Int)), ([0, 2, 2, 1], 7, 13, (-3 : Int)), ([0, 2, 2, 2], 6, 10, (-2 : Int)), ([0, 2, 2, 3], 5, 5, (-1 : Int)), ([0, 2, 3, 0], 7, 9, (-5 : Int)), ([0, 2, 3, 1], 6, 8, (-4 : Int)), ([0, 2, 3, 2], 5, 5, (-3 : Int)), ([0, 2, 3, 3], 4, 0, (-2 : Int)), ([0, 3, 0, 0], 9, 13, (-3 : Int)), ([0, 3, 0, 1], 8, 12, (-2 : Int)), ([0, 3, 0, 2], 7, 9, (-1 : Int)), ([0, 3, 0, 3], 6, 4, (0 : Int)), ([0, 3, 1, 0], 8, 12, (-4 : Int)), ([0, 3, 1, 1], 7, 11, (-3 : Int)), ([0, 3, 1, 2], 6, 8, (-2 : Int)), ([0, 3, 1, 3], 5, 3, (-1 : Int)), ([0, 3, 2, 0], 7, 9, (-5 : Int)), ([0, 3, 2, 1], 6, 8, (-4 : Int)), ([0, 3, 2, 2], 5, 5, (-3 : Int)), ([0, 3, 2, 3], 4, 0, (-2 : Int)), ([0, 3, 3, 0], 6, 4, (-6 : Int)), ([0, 3, 3, 1], 5, 3, (-5 : Int)), ([0, 3, 3, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int)), ([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int)), ([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 1, 0, 0], 10, 20, (-2 : Int)), ([1, 1, 0, 1], 9, 19, (-1 : Int)), ([1, 1, 0, 2], 8, 16, (0 : Int)), ([1, 1, 0, 3], 7, 11, (1 : Int)), ([1, 1, 0, 4], 6, 4, (2 : Int)), ([1, 1, 1, 0], 9, 19, (-3 : Int)), ([1, 1, 1, 1], 8, 18, (-2 : Int)), ([1, 1, 1, 2], 7, 15, (-1 : Int)), ([1, 1, 1, 3], 6, 10, (0 : Int)), ([1, 1, 1, 4], 5, 3, (1 : Int)), ([1, 1, 2, 0], 8, 16, (-4 : Int)), ([1, 1, 2, 1], 7, 15, (-3 : Int)), ([1, 1, 2, 2], 6, 12, (-2 : Int)), ([1, 1, 2, 3], 5, 7, (-1 : Int)), ([1, 1, 2, 4], 4, 0, (0 : Int)), ([1, 1, 3, 0], 7, 11, (-5 : Int)), ([1, 1, 3, 1], 6, 10, (-4 : Int)), ([1, 1, 3, 2], 5, 7, (-3 : Int)), ([1, 1, 3, 3], 4, 2, (-2 : Int)), ([1, 1, 4, 0], 6, 4, (-6 : Int)), ([1, 1, 4, 1], 5, 3, (-5 : Int)), ([1, 1, 4, 2], 4, 0, (-4 : Int)), ([1, 2, 0, 0], 9, 17, (-3 : Int)), ([1, 2, 0, 1], 8, 16, (-2 : Int)), ([1, 2, 0, 2], 7, 13, (-1 : Int)), ([1, 2, 0, 3], 6, 8, (0 : Int)), ([1, 2, 0, 4], 5, 1, (1 : Int)), ([1, 2, 1, 0], 8, 16, (-4 : Int)), ([1, 2, 1, 1], 7, 15, (-3 : Int)), ([1, 2, 1, 2], 6, 12, (-2 : Int)), ([1, 2, 1, 3], 5, 7, (-1 : Int)), ([1, 2, 1, 4], 4, 0, (0 : Int)), ([1, 2, 2, 0], 7, 13, (-5 : Int)), ([1, 2, 2, 1], 6, 12, (-4 : Int)), ([1, 2, 2, 2], 5, 9, (-3 : Int)), ([1, 2, 2, 3], 4, 4, (-2 : Int)), ([1, 2, 3, 0], 6, 8, (-6 : Int)), ([1, 2, 3, 1], 5, 7, (-5 : Int)), ([1, 2, 3, 2], 4, 4, (-4 : Int)), ([1, 3, 0, 0], 8, 12, (-4 : Int)), ([1, 3, 0, 1], 7, 11, (-3 : Int)), ([1, 3, 0, 2], 6, 8, (-2 : Int)), ([1, 3, 0, 3], 5, 3, (-1 : Int)), ([1, 3, 1, 0], 7, 11, (-5 : Int)), ([1, 3, 1, 1], 6, 10, (-4 : Int)), ([1, 3, 1, 2], 5, 7, (-3 : Int)), ([1, 3, 1, 3], 4, 2, (-2 : Int)), ([1, 3, 2, 0], 6, 8, (-6 : Int)), ([1, 3, 2, 1], 5, 7, (-5 : Int)), ([1, 3, 2, 2], 4, 4, (-4 : Int)), ([1, 3, 3, 0], 5, 3, (-7 : Int)), ([1, 3, 3, 1], 4, 2, (-6 : Int)), ([1, 4, 1, 0], 6, 4, (-6 : Int)), ([1, 4, 1, 1], 5, 3, (-5 : Int)), ([1, 4, 1, 2], 4, 0, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int)), ([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int)), ([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 1, 0, 0], 9, 17, (-3 : Int)), ([2, 1, 0, 1], 8, 16, (-2 : Int)), ([2, 1, 0, 2], 7, 13, (-1 : Int)), ([2, 1, 0, 3], 6, 8, (0 : Int)), ([2, 1, 0, 4], 5, 1, (1 : Int)), ([2, 1, 1, 0], 8, 16, (-4 : Int)), ([2, 1, 1, 1], 7, 15, (-3 : Int)), ([2, 1, 1, 2], 6, 12, (-2 : Int)), ([2, 1, 1, 3], 5, 7, (-1 : Int)), ([2, 1, 1, 4], 4, 0, (0 : Int)), ([2, 1, 2, 0], 7, 13, (-5 : Int)), ([2, 1, 2, 1], 6, 12, (-4 : Int)), ([2, 1, 2, 2], 5, 9, (-3 : Int)), ([2, 1, 2, 3], 4, 4, (-2 : Int)), ([2, 1, 3, 0], 6, 8, (-6 : Int)), ([2, 1, 3, 1], 5, 7, (-5 : Int)), ([2, 1, 3, 2], 4, 4, (-4 : Int)), ([2, 2, 0, 0], 8, 14, (-4 : Int)), ([2, 2, 0, 1], 7, 13, (-3 : Int)), ([2, 2, 0, 2], 6, 10, (-2 : Int)), ([2, 2, 0, 3], 5, 5, (-1 : Int)), ([2, 2, 1, 0], 7, 13, (-5 : Int)), ([2, 2, 1, 1], 6, 12, (-4 : Int)), ([2, 2, 1, 2], 5, 9, (-3 : Int)), ([2, 2, 1, 3], 4, 4, (-2 : Int)), ([2, 2, 2, 0], 6, 10, (-6 : Int)), ([2, 2, 2, 1], 5, 9, (-5 : Int)), ([2, 2, 2, 2], 4, 6, (-4 : Int)), ([2, 2, 2, 3], 3, 1, (-3 : Int)), ([2, 2, 3, 0], 5, 5, (-7 : Int)), ([2, 2, 3, 1], 4, 4, (-6 : Int)), ([2, 2, 3, 2], 3, 1, (-5 : Int)), ([2, 3, 0, 0], 7, 9, (-5 : Int)), ([2, 3, 0, 1], 6, 8, (-4 : Int)), ([2, 3, 0, 2], 5, 5, (-3 : Int)), ([2, 3, 0, 3], 4, 0, (-2 : Int)), ([2, 3, 1, 0], 6, 8, (-6 : Int)), ([2, 3, 1, 1], 5, 7, (-5 : Int)), ([2, 3, 1, 2], 4, 4, (-4 : Int)), ([2, 3, 2, 0], 5, 5, (-7 : Int)), ([2, 3, 2, 1], 4, 4, (-6 : Int)), ([2, 3, 2, 2], 3, 1, (-5 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int)), ([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int)), ([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 1, 0, 0], 8, 12, (-4 : Int)), ([3, 1, 0, 1], 7, 11, (-3 : Int)), ([3, 1, 0, 2], 6, 8, (-2 : Int)), ([3, 1, 0, 3], 5, 3, (-1 : Int)), ([3, 1, 1, 0], 7, 11, (-5 : Int)), ([3, 1, 1, 1], 6, 10, (-4 : Int)), ([3, 1, 1, 2], 5, 7, (-3 : Int)), ([3, 1, 1, 3], 4, 2, (-2 : Int)), ([3, 1, 2, 0], 6, 8, (-6 : Int)), ([3, 1, 2, 1], 5, 7, (-5 : Int)), ([3, 1, 2, 2], 4, 4, (-4 : Int)), ([3, 1, 3, 0], 5, 3, (-7 : Int)), ([3, 1, 3, 1], 4, 2, (-6 : Int)), ([3, 2, 0, 0], 7, 9, (-5 : Int)), ([3, 2, 0, 1], 6, 8, (-4 : Int)), ([3, 2, 0, 2], 5, 5, (-3 : Int)), ([3, 2, 0, 3], 4, 0, (-2 : Int)), ([3, 2, 1, 0], 6, 8, (-6 : Int)), ([3, 2, 1, 1], 5, 7, (-5 : Int)), ([3, 2, 1, 2], 4, 4, (-4 : Int)), ([3, 2, 2, 0], 5, 5, (-7 : Int)), ([3, 2, 2, 1], 4, 4, (-6 : Int)), ([3, 2, 2, 2], 3, 1, (-5 : Int)), ([3, 3, 0, 0], 6, 4, (-6 : Int)), ([3, 3, 0, 1], 5, 3, (-5 : Int)), ([3, 3, 0, 2], 4, 0, (-4 : Int)), ([3, 3, 1, 0], 5, 3, (-7 : Int)), ([3, 3, 1, 1], 4, 2, (-6 : Int)), ([4, 1, 1, 0], 6, 4, (-6 : Int)), ([4, 1, 1, 1], 5, 3, (-5 : Int)), ([4, 1, 1, 2], 4, 0, (-4 : Int))] := by
  decide +kernel

theorem z7UnaryRows5_s0 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 0, 0] 12 22 (0 : Int))
    (z7UnaryCode5_s0.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s0_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 0, 0], 12, 22, (0 : Int)).1 ([0, 0, 0, 0], 12, 22, (0 : Int)).2.1
      ([0, 0, 0, 0], 12, 22, (0 : Int)).2.2.1 ([0, 0, 0, 0], 12, 22, (0 : Int)).2.2.2 =
    z7UnaryCode5_s0.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 0, 0] 12 22 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s0
theorem z7UnaryRows5_s1 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 0, 1] 11 21 (1 : Int))
    (z7UnaryCode5_s1.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s1_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 0, 1], 11, 21, (1 : Int)).1 ([0, 0, 0, 1], 11, 21, (1 : Int)).2.1
      ([0, 0, 0, 1], 11, 21, (1 : Int)).2.2.1 ([0, 0, 0, 1], 11, 21, (1 : Int)).2.2.2 =
    z7UnaryCode5_s1.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 0, 1] 11 21 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s1
theorem z7UnaryRows5_s2 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 0, 2] 10 18 (2 : Int))
    (z7UnaryCode5_s2.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s2_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 0, 2], 10, 18, (2 : Int)).1 ([0, 0, 0, 2], 10, 18, (2 : Int)).2.1
      ([0, 0, 0, 2], 10, 18, (2 : Int)).2.2.1 ([0, 0, 0, 2], 10, 18, (2 : Int)).2.2.2 =
    z7UnaryCode5_s2.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 0, 2] 10 18 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s2
theorem z7UnaryRows5_s3 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 0, 3] 9 13 (3 : Int))
    (z7UnaryCode5_s3.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s3_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 0, 3], 9, 13, (3 : Int)).1 ([0, 0, 0, 3], 9, 13, (3 : Int)).2.1
      ([0, 0, 0, 3], 9, 13, (3 : Int)).2.2.1 ([0, 0, 0, 3], 9, 13, (3 : Int)).2.2.2 =
    z7UnaryCode5_s3.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 0, 3] 9 13 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s3
theorem z7UnaryRows5_s4 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 0, 4] 8 6 (4 : Int))
    (z7UnaryCode5_s4.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s4_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 0, 4], 8, 6, (4 : Int)).1 ([0, 0, 0, 4], 8, 6, (4 : Int)).2.1
      ([0, 0, 0, 4], 8, 6, (4 : Int)).2.2.1 ([0, 0, 0, 4], 8, 6, (4 : Int)).2.2.2 =
    z7UnaryCode5_s4.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 0, 4] 8 6 (4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s4
theorem z7UnaryRows5_s5 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 1, 0] 11 21 (-1 : Int))
    (z7UnaryCode5_s5.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s5_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 1, 0], 11, 21, (-1 : Int)).1 ([0, 0, 1, 0], 11, 21, (-1 : Int)).2.1
      ([0, 0, 1, 0], 11, 21, (-1 : Int)).2.2.1 ([0, 0, 1, 0], 11, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s5.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 1, 0] 11 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s5
theorem z7UnaryRows5_s6 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 1, 1] 10 20 (0 : Int))
    (z7UnaryCode5_s6.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s6_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 1, 1], 10, 20, (0 : Int)).1 ([0, 0, 1, 1], 10, 20, (0 : Int)).2.1
      ([0, 0, 1, 1], 10, 20, (0 : Int)).2.2.1 ([0, 0, 1, 1], 10, 20, (0 : Int)).2.2.2 =
    z7UnaryCode5_s6.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 1, 1] 10 20 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s6
theorem z7UnaryRows5_s7 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 1, 2] 9 17 (1 : Int))
    (z7UnaryCode5_s7.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s7_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 1, 2], 9, 17, (1 : Int)).1 ([0, 0, 1, 2], 9, 17, (1 : Int)).2.1
      ([0, 0, 1, 2], 9, 17, (1 : Int)).2.2.1 ([0, 0, 1, 2], 9, 17, (1 : Int)).2.2.2 =
    z7UnaryCode5_s7.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 1, 2] 9 17 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s7
theorem z7UnaryRows5_s8 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 1, 3] 8 12 (2 : Int))
    (z7UnaryCode5_s8.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s8_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 1, 3], 8, 12, (2 : Int)).1 ([0, 0, 1, 3], 8, 12, (2 : Int)).2.1
      ([0, 0, 1, 3], 8, 12, (2 : Int)).2.2.1 ([0, 0, 1, 3], 8, 12, (2 : Int)).2.2.2 =
    z7UnaryCode5_s8.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 1, 3] 8 12 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s8
theorem z7UnaryRows5_s9 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 1, 4] 7 5 (3 : Int))
    (z7UnaryCode5_s9.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s9_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 1, 4], 7, 5, (3 : Int)).1 ([0, 0, 1, 4], 7, 5, (3 : Int)).2.1
      ([0, 0, 1, 4], 7, 5, (3 : Int)).2.2.1 ([0, 0, 1, 4], 7, 5, (3 : Int)).2.2.2 =
    z7UnaryCode5_s9.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 1, 4] 7 5 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s9
theorem z7UnaryRows5_s10 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 2, 0] 10 18 (-2 : Int))
    (z7UnaryCode5_s10.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s10_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 2, 0], 10, 18, (-2 : Int)).1 ([0, 0, 2, 0], 10, 18, (-2 : Int)).2.1
      ([0, 0, 2, 0], 10, 18, (-2 : Int)).2.2.1 ([0, 0, 2, 0], 10, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s10.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 2, 0] 10 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s10
theorem z7UnaryRows5_s11 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 2, 1] 9 17 (-1 : Int))
    (z7UnaryCode5_s11.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s11_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 2, 1], 9, 17, (-1 : Int)).1 ([0, 0, 2, 1], 9, 17, (-1 : Int)).2.1
      ([0, 0, 2, 1], 9, 17, (-1 : Int)).2.2.1 ([0, 0, 2, 1], 9, 17, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s11.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 2, 1] 9 17 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s11
theorem z7UnaryRows5_s12 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 2, 2] 8 14 (0 : Int))
    (z7UnaryCode5_s12.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s12_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 2, 2], 8, 14, (0 : Int)).1 ([0, 0, 2, 2], 8, 14, (0 : Int)).2.1
      ([0, 0, 2, 2], 8, 14, (0 : Int)).2.2.1 ([0, 0, 2, 2], 8, 14, (0 : Int)).2.2.2 =
    z7UnaryCode5_s12.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 2, 2] 8 14 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s12
theorem z7UnaryRows5_s13 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 2, 3] 7 9 (1 : Int))
    (z7UnaryCode5_s13.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s13_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 2, 3], 7, 9, (1 : Int)).1 ([0, 0, 2, 3], 7, 9, (1 : Int)).2.1
      ([0, 0, 2, 3], 7, 9, (1 : Int)).2.2.1 ([0, 0, 2, 3], 7, 9, (1 : Int)).2.2.2 =
    z7UnaryCode5_s13.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 2, 3] 7 9 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s13
theorem z7UnaryRows5_s14 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 2, 4] 6 2 (2 : Int))
    (z7UnaryCode5_s14.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s14_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 2, 4], 6, 2, (2 : Int)).1 ([0, 0, 2, 4], 6, 2, (2 : Int)).2.1
      ([0, 0, 2, 4], 6, 2, (2 : Int)).2.2.1 ([0, 0, 2, 4], 6, 2, (2 : Int)).2.2.2 =
    z7UnaryCode5_s14.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 2, 4] 6 2 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s14
theorem z7UnaryRows5_s15 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 3, 0] 9 13 (-3 : Int))
    (z7UnaryCode5_s15.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s15_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 3, 0], 9, 13, (-3 : Int)).1 ([0, 0, 3, 0], 9, 13, (-3 : Int)).2.1
      ([0, 0, 3, 0], 9, 13, (-3 : Int)).2.2.1 ([0, 0, 3, 0], 9, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s15.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 3, 0] 9 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s15
theorem z7UnaryRows5_s16 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 3, 1] 8 12 (-2 : Int))
    (z7UnaryCode5_s16.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s16_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 3, 1], 8, 12, (-2 : Int)).1 ([0, 0, 3, 1], 8, 12, (-2 : Int)).2.1
      ([0, 0, 3, 1], 8, 12, (-2 : Int)).2.2.1 ([0, 0, 3, 1], 8, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s16.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 3, 1] 8 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s16
theorem z7UnaryRows5_s17 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 3, 2] 7 9 (-1 : Int))
    (z7UnaryCode5_s17.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s17_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 3, 2], 7, 9, (-1 : Int)).1 ([0, 0, 3, 2], 7, 9, (-1 : Int)).2.1
      ([0, 0, 3, 2], 7, 9, (-1 : Int)).2.2.1 ([0, 0, 3, 2], 7, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s17.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 3, 2] 7 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s17
theorem z7UnaryRows5_s18 : rowsBeq
    (z7GenRow 8 5 4 [0, 0, 3, 3] 6 4 (0 : Int))
    (z7UnaryCode5_s18.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s18_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 0, 3, 3], 6, 4, (0 : Int)).1 ([0, 0, 3, 3], 6, 4, (0 : Int)).2.1
      ([0, 0, 3, 3], 6, 4, (0 : Int)).2.2.1 ([0, 0, 3, 3], 6, 4, (0 : Int)).2.2.2 =
    z7UnaryCode5_s18.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 0, 3, 3] 6 4 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s18
theorem z7UnaryRows5_s19 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 0, 0] 11 21 (-1 : Int))
    (z7UnaryCode5_s19.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s19_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 0, 0], 11, 21, (-1 : Int)).1 ([0, 1, 0, 0], 11, 21, (-1 : Int)).2.1
      ([0, 1, 0, 0], 11, 21, (-1 : Int)).2.2.1 ([0, 1, 0, 0], 11, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s19.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 0, 0] 11 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s19
theorem z7UnaryRows5_s20 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 0, 1] 10 20 (0 : Int))
    (z7UnaryCode5_s20.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s20_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 0, 1], 10, 20, (0 : Int)).1 ([0, 1, 0, 1], 10, 20, (0 : Int)).2.1
      ([0, 1, 0, 1], 10, 20, (0 : Int)).2.2.1 ([0, 1, 0, 1], 10, 20, (0 : Int)).2.2.2 =
    z7UnaryCode5_s20.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 0, 1] 10 20 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s20
theorem z7UnaryRows5_s21 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 0, 2] 9 17 (1 : Int))
    (z7UnaryCode5_s21.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s21_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 0, 2], 9, 17, (1 : Int)).1 ([0, 1, 0, 2], 9, 17, (1 : Int)).2.1
      ([0, 1, 0, 2], 9, 17, (1 : Int)).2.2.1 ([0, 1, 0, 2], 9, 17, (1 : Int)).2.2.2 =
    z7UnaryCode5_s21.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 0, 2] 9 17 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s21
theorem z7UnaryRows5_s22 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 0, 3] 8 12 (2 : Int))
    (z7UnaryCode5_s22.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s22_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 0, 3], 8, 12, (2 : Int)).1 ([0, 1, 0, 3], 8, 12, (2 : Int)).2.1
      ([0, 1, 0, 3], 8, 12, (2 : Int)).2.2.1 ([0, 1, 0, 3], 8, 12, (2 : Int)).2.2.2 =
    z7UnaryCode5_s22.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 0, 3] 8 12 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s22
theorem z7UnaryRows5_s23 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 0, 4] 7 5 (3 : Int))
    (z7UnaryCode5_s23.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s23_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 0, 4], 7, 5, (3 : Int)).1 ([0, 1, 0, 4], 7, 5, (3 : Int)).2.1
      ([0, 1, 0, 4], 7, 5, (3 : Int)).2.2.1 ([0, 1, 0, 4], 7, 5, (3 : Int)).2.2.2 =
    z7UnaryCode5_s23.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 0, 4] 7 5 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s23
theorem z7UnaryRows5_s24 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 1, 0] 10 20 (-2 : Int))
    (z7UnaryCode5_s24.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s24_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 1, 0], 10, 20, (-2 : Int)).1 ([0, 1, 1, 0], 10, 20, (-2 : Int)).2.1
      ([0, 1, 1, 0], 10, 20, (-2 : Int)).2.2.1 ([0, 1, 1, 0], 10, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s24.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 1, 0] 10 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s24
theorem z7UnaryRows5_s25 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 1, 1] 9 19 (-1 : Int))
    (z7UnaryCode5_s25.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s25_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 1, 1], 9, 19, (-1 : Int)).1 ([0, 1, 1, 1], 9, 19, (-1 : Int)).2.1
      ([0, 1, 1, 1], 9, 19, (-1 : Int)).2.2.1 ([0, 1, 1, 1], 9, 19, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s25.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 1, 1] 9 19 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s25
theorem z7UnaryRows5_s26 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 1, 2] 8 16 (0 : Int))
    (z7UnaryCode5_s26.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s26_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 1, 2], 8, 16, (0 : Int)).1 ([0, 1, 1, 2], 8, 16, (0 : Int)).2.1
      ([0, 1, 1, 2], 8, 16, (0 : Int)).2.2.1 ([0, 1, 1, 2], 8, 16, (0 : Int)).2.2.2 =
    z7UnaryCode5_s26.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 1, 2] 8 16 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s26
theorem z7UnaryRows5_s27 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 1, 3] 7 11 (1 : Int))
    (z7UnaryCode5_s27.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s27_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 1, 3], 7, 11, (1 : Int)).1 ([0, 1, 1, 3], 7, 11, (1 : Int)).2.1
      ([0, 1, 1, 3], 7, 11, (1 : Int)).2.2.1 ([0, 1, 1, 3], 7, 11, (1 : Int)).2.2.2 =
    z7UnaryCode5_s27.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 1, 3] 7 11 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s27
theorem z7UnaryRows5_s28 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 1, 4] 6 4 (2 : Int))
    (z7UnaryCode5_s28.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s28_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 1, 4], 6, 4, (2 : Int)).1 ([0, 1, 1, 4], 6, 4, (2 : Int)).2.1
      ([0, 1, 1, 4], 6, 4, (2 : Int)).2.2.1 ([0, 1, 1, 4], 6, 4, (2 : Int)).2.2.2 =
    z7UnaryCode5_s28.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 1, 4] 6 4 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s28
theorem z7UnaryRows5_s29 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 2, 0] 9 17 (-3 : Int))
    (z7UnaryCode5_s29.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s29_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 2, 0], 9, 17, (-3 : Int)).1 ([0, 1, 2, 0], 9, 17, (-3 : Int)).2.1
      ([0, 1, 2, 0], 9, 17, (-3 : Int)).2.2.1 ([0, 1, 2, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s29.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 2, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s29
theorem z7UnaryRows5_s30 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 2, 1] 8 16 (-2 : Int))
    (z7UnaryCode5_s30.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s30_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 2, 1], 8, 16, (-2 : Int)).1 ([0, 1, 2, 1], 8, 16, (-2 : Int)).2.1
      ([0, 1, 2, 1], 8, 16, (-2 : Int)).2.2.1 ([0, 1, 2, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s30.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 2, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s30
theorem z7UnaryRows5_s31 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 2, 2] 7 13 (-1 : Int))
    (z7UnaryCode5_s31.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s31_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 2, 2], 7, 13, (-1 : Int)).1 ([0, 1, 2, 2], 7, 13, (-1 : Int)).2.1
      ([0, 1, 2, 2], 7, 13, (-1 : Int)).2.2.1 ([0, 1, 2, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s31.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 2, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s31
theorem z7UnaryRows5_s32 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 2, 3] 6 8 (0 : Int))
    (z7UnaryCode5_s32.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s32_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 2, 3], 6, 8, (0 : Int)).1 ([0, 1, 2, 3], 6, 8, (0 : Int)).2.1
      ([0, 1, 2, 3], 6, 8, (0 : Int)).2.2.1 ([0, 1, 2, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode5_s32.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 2, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s32
theorem z7UnaryRows5_s33 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 2, 4] 5 1 (1 : Int))
    (z7UnaryCode5_s33.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s33_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 2, 4], 5, 1, (1 : Int)).1 ([0, 1, 2, 4], 5, 1, (1 : Int)).2.1
      ([0, 1, 2, 4], 5, 1, (1 : Int)).2.2.1 ([0, 1, 2, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode5_s33.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 2, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s33
theorem z7UnaryRows5_s34 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 3, 0] 8 12 (-4 : Int))
    (z7UnaryCode5_s34.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s34_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 3, 0], 8, 12, (-4 : Int)).1 ([0, 1, 3, 0], 8, 12, (-4 : Int)).2.1
      ([0, 1, 3, 0], 8, 12, (-4 : Int)).2.2.1 ([0, 1, 3, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s34.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 3, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s34
theorem z7UnaryRows5_s35 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 3, 1] 7 11 (-3 : Int))
    (z7UnaryCode5_s35.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s35_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 3, 1], 7, 11, (-3 : Int)).1 ([0, 1, 3, 1], 7, 11, (-3 : Int)).2.1
      ([0, 1, 3, 1], 7, 11, (-3 : Int)).2.2.1 ([0, 1, 3, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s35.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 3, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s35
theorem z7UnaryRows5_s36 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 3, 2] 6 8 (-2 : Int))
    (z7UnaryCode5_s36.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s36_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 3, 2], 6, 8, (-2 : Int)).1 ([0, 1, 3, 2], 6, 8, (-2 : Int)).2.1
      ([0, 1, 3, 2], 6, 8, (-2 : Int)).2.2.1 ([0, 1, 3, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s36.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 3, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s36
theorem z7UnaryRows5_s37 : rowsBeq
    (z7GenRow 8 5 4 [0, 1, 3, 3] 5 3 (-1 : Int))
    (z7UnaryCode5_s37.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s37_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 1, 3, 3], 5, 3, (-1 : Int)).1 ([0, 1, 3, 3], 5, 3, (-1 : Int)).2.1
      ([0, 1, 3, 3], 5, 3, (-1 : Int)).2.2.1 ([0, 1, 3, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s37.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 1, 3, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s37
theorem z7UnaryRows5_s38 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 0, 0] 10 18 (-2 : Int))
    (z7UnaryCode5_s38.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s38_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 0, 0], 10, 18, (-2 : Int)).1 ([0, 2, 0, 0], 10, 18, (-2 : Int)).2.1
      ([0, 2, 0, 0], 10, 18, (-2 : Int)).2.2.1 ([0, 2, 0, 0], 10, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s38.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 0, 0] 10 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s38
theorem z7UnaryRows5_s39 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 0, 1] 9 17 (-1 : Int))
    (z7UnaryCode5_s39.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s39_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 0, 1], 9, 17, (-1 : Int)).1 ([0, 2, 0, 1], 9, 17, (-1 : Int)).2.1
      ([0, 2, 0, 1], 9, 17, (-1 : Int)).2.2.1 ([0, 2, 0, 1], 9, 17, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s39.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 0, 1] 9 17 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s39
theorem z7UnaryRows5_s40 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 0, 2] 8 14 (0 : Int))
    (z7UnaryCode5_s40.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s40_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 0, 2], 8, 14, (0 : Int)).1 ([0, 2, 0, 2], 8, 14, (0 : Int)).2.1
      ([0, 2, 0, 2], 8, 14, (0 : Int)).2.2.1 ([0, 2, 0, 2], 8, 14, (0 : Int)).2.2.2 =
    z7UnaryCode5_s40.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 0, 2] 8 14 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s40
theorem z7UnaryRows5_s41 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 0, 3] 7 9 (1 : Int))
    (z7UnaryCode5_s41.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s41_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 0, 3], 7, 9, (1 : Int)).1 ([0, 2, 0, 3], 7, 9, (1 : Int)).2.1
      ([0, 2, 0, 3], 7, 9, (1 : Int)).2.2.1 ([0, 2, 0, 3], 7, 9, (1 : Int)).2.2.2 =
    z7UnaryCode5_s41.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 0, 3] 7 9 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s41
theorem z7UnaryRows5_s42 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 0, 4] 6 2 (2 : Int))
    (z7UnaryCode5_s42.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s42_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 0, 4], 6, 2, (2 : Int)).1 ([0, 2, 0, 4], 6, 2, (2 : Int)).2.1
      ([0, 2, 0, 4], 6, 2, (2 : Int)).2.2.1 ([0, 2, 0, 4], 6, 2, (2 : Int)).2.2.2 =
    z7UnaryCode5_s42.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 0, 4] 6 2 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s42
theorem z7UnaryRows5_s43 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 1, 0] 9 17 (-3 : Int))
    (z7UnaryCode5_s43.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s43_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 1, 0], 9, 17, (-3 : Int)).1 ([0, 2, 1, 0], 9, 17, (-3 : Int)).2.1
      ([0, 2, 1, 0], 9, 17, (-3 : Int)).2.2.1 ([0, 2, 1, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s43.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 1, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s43
theorem z7UnaryRows5_s44 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 1, 1] 8 16 (-2 : Int))
    (z7UnaryCode5_s44.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s44_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 1, 1], 8, 16, (-2 : Int)).1 ([0, 2, 1, 1], 8, 16, (-2 : Int)).2.1
      ([0, 2, 1, 1], 8, 16, (-2 : Int)).2.2.1 ([0, 2, 1, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s44.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 1, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s44
theorem z7UnaryRows5_s45 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 1, 2] 7 13 (-1 : Int))
    (z7UnaryCode5_s45.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s45_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 1, 2], 7, 13, (-1 : Int)).1 ([0, 2, 1, 2], 7, 13, (-1 : Int)).2.1
      ([0, 2, 1, 2], 7, 13, (-1 : Int)).2.2.1 ([0, 2, 1, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s45.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 1, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s45
theorem z7UnaryRows5_s46 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 1, 3] 6 8 (0 : Int))
    (z7UnaryCode5_s46.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s46_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 1, 3], 6, 8, (0 : Int)).1 ([0, 2, 1, 3], 6, 8, (0 : Int)).2.1
      ([0, 2, 1, 3], 6, 8, (0 : Int)).2.2.1 ([0, 2, 1, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode5_s46.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 1, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s46
theorem z7UnaryRows5_s47 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 1, 4] 5 1 (1 : Int))
    (z7UnaryCode5_s47.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s47_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 1, 4], 5, 1, (1 : Int)).1 ([0, 2, 1, 4], 5, 1, (1 : Int)).2.1
      ([0, 2, 1, 4], 5, 1, (1 : Int)).2.2.1 ([0, 2, 1, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode5_s47.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 1, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s47
theorem z7UnaryRows5_s48 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 2, 0] 8 14 (-4 : Int))
    (z7UnaryCode5_s48.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s48_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 2, 0], 8, 14, (-4 : Int)).1 ([0, 2, 2, 0], 8, 14, (-4 : Int)).2.1
      ([0, 2, 2, 0], 8, 14, (-4 : Int)).2.2.1 ([0, 2, 2, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s48.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 2, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s48
theorem z7UnaryRows5_s49 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 2, 1] 7 13 (-3 : Int))
    (z7UnaryCode5_s49.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s49_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 2, 1], 7, 13, (-3 : Int)).1 ([0, 2, 2, 1], 7, 13, (-3 : Int)).2.1
      ([0, 2, 2, 1], 7, 13, (-3 : Int)).2.2.1 ([0, 2, 2, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s49.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 2, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s49
theorem z7UnaryRows5_s50 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 2, 2] 6 10 (-2 : Int))
    (z7UnaryCode5_s50.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s50_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 2, 2], 6, 10, (-2 : Int)).1 ([0, 2, 2, 2], 6, 10, (-2 : Int)).2.1
      ([0, 2, 2, 2], 6, 10, (-2 : Int)).2.2.1 ([0, 2, 2, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s50.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 2, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s50
theorem z7UnaryRows5_s51 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 2, 3] 5 5 (-1 : Int))
    (z7UnaryCode5_s51.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s51_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 2, 3], 5, 5, (-1 : Int)).1 ([0, 2, 2, 3], 5, 5, (-1 : Int)).2.1
      ([0, 2, 2, 3], 5, 5, (-1 : Int)).2.2.1 ([0, 2, 2, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s51.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 2, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s51
theorem z7UnaryRows5_s52 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 3, 0] 7 9 (-5 : Int))
    (z7UnaryCode5_s52.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s52_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 3, 0], 7, 9, (-5 : Int)).1 ([0, 2, 3, 0], 7, 9, (-5 : Int)).2.1
      ([0, 2, 3, 0], 7, 9, (-5 : Int)).2.2.1 ([0, 2, 3, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s52.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 3, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s52
theorem z7UnaryRows5_s53 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 3, 1] 6 8 (-4 : Int))
    (z7UnaryCode5_s53.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s53_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 3, 1], 6, 8, (-4 : Int)).1 ([0, 2, 3, 1], 6, 8, (-4 : Int)).2.1
      ([0, 2, 3, 1], 6, 8, (-4 : Int)).2.2.1 ([0, 2, 3, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s53.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 3, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s53
theorem z7UnaryRows5_s54 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 3, 2] 5 5 (-3 : Int))
    (z7UnaryCode5_s54.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s54_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 3, 2], 5, 5, (-3 : Int)).1 ([0, 2, 3, 2], 5, 5, (-3 : Int)).2.1
      ([0, 2, 3, 2], 5, 5, (-3 : Int)).2.2.1 ([0, 2, 3, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s54.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 3, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s54
theorem z7UnaryRows5_s55 : rowsBeq
    (z7GenRow 8 5 4 [0, 2, 3, 3] 4 0 (-2 : Int))
    (z7UnaryCode5_s55.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s55_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 2, 3, 3], 4, 0, (-2 : Int)).1 ([0, 2, 3, 3], 4, 0, (-2 : Int)).2.1
      ([0, 2, 3, 3], 4, 0, (-2 : Int)).2.2.1 ([0, 2, 3, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s55.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 2, 3, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s55
theorem z7UnaryRows5_s56 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 0, 0] 9 13 (-3 : Int))
    (z7UnaryCode5_s56.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s56_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 0, 0], 9, 13, (-3 : Int)).1 ([0, 3, 0, 0], 9, 13, (-3 : Int)).2.1
      ([0, 3, 0, 0], 9, 13, (-3 : Int)).2.2.1 ([0, 3, 0, 0], 9, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s56.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 0, 0] 9 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s56
theorem z7UnaryRows5_s57 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 0, 1] 8 12 (-2 : Int))
    (z7UnaryCode5_s57.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s57_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 0, 1], 8, 12, (-2 : Int)).1 ([0, 3, 0, 1], 8, 12, (-2 : Int)).2.1
      ([0, 3, 0, 1], 8, 12, (-2 : Int)).2.2.1 ([0, 3, 0, 1], 8, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s57.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 0, 1] 8 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s57
theorem z7UnaryRows5_s58 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 0, 2] 7 9 (-1 : Int))
    (z7UnaryCode5_s58.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s58_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 0, 2], 7, 9, (-1 : Int)).1 ([0, 3, 0, 2], 7, 9, (-1 : Int)).2.1
      ([0, 3, 0, 2], 7, 9, (-1 : Int)).2.2.1 ([0, 3, 0, 2], 7, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s58.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 0, 2] 7 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s58
theorem z7UnaryRows5_s59 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 0, 3] 6 4 (0 : Int))
    (z7UnaryCode5_s59.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s59_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 0, 3], 6, 4, (0 : Int)).1 ([0, 3, 0, 3], 6, 4, (0 : Int)).2.1
      ([0, 3, 0, 3], 6, 4, (0 : Int)).2.2.1 ([0, 3, 0, 3], 6, 4, (0 : Int)).2.2.2 =
    z7UnaryCode5_s59.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 0, 3] 6 4 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s59
theorem z7UnaryRows5_s60 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 1, 0] 8 12 (-4 : Int))
    (z7UnaryCode5_s60.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s60_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 1, 0], 8, 12, (-4 : Int)).1 ([0, 3, 1, 0], 8, 12, (-4 : Int)).2.1
      ([0, 3, 1, 0], 8, 12, (-4 : Int)).2.2.1 ([0, 3, 1, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s60.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 1, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s60
theorem z7UnaryRows5_s61 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 1, 1] 7 11 (-3 : Int))
    (z7UnaryCode5_s61.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s61_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 1, 1], 7, 11, (-3 : Int)).1 ([0, 3, 1, 1], 7, 11, (-3 : Int)).2.1
      ([0, 3, 1, 1], 7, 11, (-3 : Int)).2.2.1 ([0, 3, 1, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s61.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 1, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s61
theorem z7UnaryRows5_s62 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 1, 2] 6 8 (-2 : Int))
    (z7UnaryCode5_s62.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s62_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 1, 2], 6, 8, (-2 : Int)).1 ([0, 3, 1, 2], 6, 8, (-2 : Int)).2.1
      ([0, 3, 1, 2], 6, 8, (-2 : Int)).2.2.1 ([0, 3, 1, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s62.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 1, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s62
theorem z7UnaryRows5_s63 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 1, 3] 5 3 (-1 : Int))
    (z7UnaryCode5_s63.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s63_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 1, 3], 5, 3, (-1 : Int)).1 ([0, 3, 1, 3], 5, 3, (-1 : Int)).2.1
      ([0, 3, 1, 3], 5, 3, (-1 : Int)).2.2.1 ([0, 3, 1, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s63.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 1, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s63
theorem z7UnaryRows5_s64 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 2, 0] 7 9 (-5 : Int))
    (z7UnaryCode5_s64.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s64_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 2, 0], 7, 9, (-5 : Int)).1 ([0, 3, 2, 0], 7, 9, (-5 : Int)).2.1
      ([0, 3, 2, 0], 7, 9, (-5 : Int)).2.2.1 ([0, 3, 2, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s64.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 2, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s64
theorem z7UnaryRows5_s65 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 2, 1] 6 8 (-4 : Int))
    (z7UnaryCode5_s65.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s65_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 2, 1], 6, 8, (-4 : Int)).1 ([0, 3, 2, 1], 6, 8, (-4 : Int)).2.1
      ([0, 3, 2, 1], 6, 8, (-4 : Int)).2.2.1 ([0, 3, 2, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s65.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 2, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s65
theorem z7UnaryRows5_s66 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 2, 2] 5 5 (-3 : Int))
    (z7UnaryCode5_s66.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s66_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 2, 2], 5, 5, (-3 : Int)).1 ([0, 3, 2, 2], 5, 5, (-3 : Int)).2.1
      ([0, 3, 2, 2], 5, 5, (-3 : Int)).2.2.1 ([0, 3, 2, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s66.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 2, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s66
theorem z7UnaryRows5_s67 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 2, 3] 4 0 (-2 : Int))
    (z7UnaryCode5_s67.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s67_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 2, 3], 4, 0, (-2 : Int)).1 ([0, 3, 2, 3], 4, 0, (-2 : Int)).2.1
      ([0, 3, 2, 3], 4, 0, (-2 : Int)).2.2.1 ([0, 3, 2, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s67.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 2, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s67
theorem z7UnaryRows5_s68 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 3, 0] 6 4 (-6 : Int))
    (z7UnaryCode5_s68.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s68_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 3, 0], 6, 4, (-6 : Int)).1 ([0, 3, 3, 0], 6, 4, (-6 : Int)).2.1
      ([0, 3, 3, 0], 6, 4, (-6 : Int)).2.2.1 ([0, 3, 3, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s68.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 3, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s68
theorem z7UnaryRows5_s69 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 3, 1] 5 3 (-5 : Int))
    (z7UnaryCode5_s69.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s69_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 3, 1], 5, 3, (-5 : Int)).1 ([0, 3, 3, 1], 5, 3, (-5 : Int)).2.1
      ([0, 3, 3, 1], 5, 3, (-5 : Int)).2.2.1 ([0, 3, 3, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s69.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 3, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s69
theorem z7UnaryRows5_s70 : rowsBeq
    (z7GenRow 8 5 4 [0, 3, 3, 2] 4 0 (-4 : Int))
    (z7UnaryCode5_s70.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s70_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([0, 3, 3, 2], 4, 0, (-4 : Int)).1 ([0, 3, 3, 2], 4, 0, (-4 : Int)).2.1
      ([0, 3, 3, 2], 4, 0, (-4 : Int)).2.2.1 ([0, 3, 3, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s70.map z7DecodeRow := by
  show z7GenRow 8 5 4 [0, 3, 3, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s70
theorem z7UnaryRows5_s71 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 0, 0] 11 21 (-1 : Int))
    (z7UnaryCode5_s71.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s71_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 0, 0], 11, 21, (-1 : Int)).1 ([1, 0, 0, 0], 11, 21, (-1 : Int)).2.1
      ([1, 0, 0, 0], 11, 21, (-1 : Int)).2.2.1 ([1, 0, 0, 0], 11, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s71.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 0, 0] 11 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s71
theorem z7UnaryRows5_s72 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 0, 1] 10 20 (0 : Int))
    (z7UnaryCode5_s72.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s72_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 0, 1], 10, 20, (0 : Int)).1 ([1, 0, 0, 1], 10, 20, (0 : Int)).2.1
      ([1, 0, 0, 1], 10, 20, (0 : Int)).2.2.1 ([1, 0, 0, 1], 10, 20, (0 : Int)).2.2.2 =
    z7UnaryCode5_s72.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 0, 1] 10 20 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s72
theorem z7UnaryRows5_s73 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 0, 2] 9 17 (1 : Int))
    (z7UnaryCode5_s73.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s73_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 0, 2], 9, 17, (1 : Int)).1 ([1, 0, 0, 2], 9, 17, (1 : Int)).2.1
      ([1, 0, 0, 2], 9, 17, (1 : Int)).2.2.1 ([1, 0, 0, 2], 9, 17, (1 : Int)).2.2.2 =
    z7UnaryCode5_s73.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 0, 2] 9 17 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s73
theorem z7UnaryRows5_s74 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 0, 3] 8 12 (2 : Int))
    (z7UnaryCode5_s74.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s74_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 0, 3], 8, 12, (2 : Int)).1 ([1, 0, 0, 3], 8, 12, (2 : Int)).2.1
      ([1, 0, 0, 3], 8, 12, (2 : Int)).2.2.1 ([1, 0, 0, 3], 8, 12, (2 : Int)).2.2.2 =
    z7UnaryCode5_s74.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 0, 3] 8 12 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s74
theorem z7UnaryRows5_s75 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 0, 4] 7 5 (3 : Int))
    (z7UnaryCode5_s75.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s75_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 0, 4], 7, 5, (3 : Int)).1 ([1, 0, 0, 4], 7, 5, (3 : Int)).2.1
      ([1, 0, 0, 4], 7, 5, (3 : Int)).2.2.1 ([1, 0, 0, 4], 7, 5, (3 : Int)).2.2.2 =
    z7UnaryCode5_s75.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 0, 4] 7 5 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s75
theorem z7UnaryRows5_s76 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 1, 0] 10 20 (-2 : Int))
    (z7UnaryCode5_s76.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s76_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 1, 0], 10, 20, (-2 : Int)).1 ([1, 0, 1, 0], 10, 20, (-2 : Int)).2.1
      ([1, 0, 1, 0], 10, 20, (-2 : Int)).2.2.1 ([1, 0, 1, 0], 10, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s76.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 1, 0] 10 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s76
theorem z7UnaryRows5_s77 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 1, 1] 9 19 (-1 : Int))
    (z7UnaryCode5_s77.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s77_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 1, 1], 9, 19, (-1 : Int)).1 ([1, 0, 1, 1], 9, 19, (-1 : Int)).2.1
      ([1, 0, 1, 1], 9, 19, (-1 : Int)).2.2.1 ([1, 0, 1, 1], 9, 19, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s77.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 1, 1] 9 19 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s77
theorem z7UnaryRows5_s78 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 1, 2] 8 16 (0 : Int))
    (z7UnaryCode5_s78.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s78_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 1, 2], 8, 16, (0 : Int)).1 ([1, 0, 1, 2], 8, 16, (0 : Int)).2.1
      ([1, 0, 1, 2], 8, 16, (0 : Int)).2.2.1 ([1, 0, 1, 2], 8, 16, (0 : Int)).2.2.2 =
    z7UnaryCode5_s78.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 1, 2] 8 16 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s78
theorem z7UnaryRows5_s79 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 1, 3] 7 11 (1 : Int))
    (z7UnaryCode5_s79.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s79_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 1, 3], 7, 11, (1 : Int)).1 ([1, 0, 1, 3], 7, 11, (1 : Int)).2.1
      ([1, 0, 1, 3], 7, 11, (1 : Int)).2.2.1 ([1, 0, 1, 3], 7, 11, (1 : Int)).2.2.2 =
    z7UnaryCode5_s79.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 1, 3] 7 11 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s79
theorem z7UnaryRows5_s80 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 1, 4] 6 4 (2 : Int))
    (z7UnaryCode5_s80.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s80_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 1, 4], 6, 4, (2 : Int)).1 ([1, 0, 1, 4], 6, 4, (2 : Int)).2.1
      ([1, 0, 1, 4], 6, 4, (2 : Int)).2.2.1 ([1, 0, 1, 4], 6, 4, (2 : Int)).2.2.2 =
    z7UnaryCode5_s80.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 1, 4] 6 4 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s80
theorem z7UnaryRows5_s81 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 2, 0] 9 17 (-3 : Int))
    (z7UnaryCode5_s81.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s81_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 2, 0], 9, 17, (-3 : Int)).1 ([1, 0, 2, 0], 9, 17, (-3 : Int)).2.1
      ([1, 0, 2, 0], 9, 17, (-3 : Int)).2.2.1 ([1, 0, 2, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s81.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 2, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s81
theorem z7UnaryRows5_s82 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 2, 1] 8 16 (-2 : Int))
    (z7UnaryCode5_s82.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s82_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 2, 1], 8, 16, (-2 : Int)).1 ([1, 0, 2, 1], 8, 16, (-2 : Int)).2.1
      ([1, 0, 2, 1], 8, 16, (-2 : Int)).2.2.1 ([1, 0, 2, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s82.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 2, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s82
theorem z7UnaryRows5_s83 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 2, 2] 7 13 (-1 : Int))
    (z7UnaryCode5_s83.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s83_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 2, 2], 7, 13, (-1 : Int)).1 ([1, 0, 2, 2], 7, 13, (-1 : Int)).2.1
      ([1, 0, 2, 2], 7, 13, (-1 : Int)).2.2.1 ([1, 0, 2, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s83.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 2, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s83
theorem z7UnaryRows5_s84 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 2, 3] 6 8 (0 : Int))
    (z7UnaryCode5_s84.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s84_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 2, 3], 6, 8, (0 : Int)).1 ([1, 0, 2, 3], 6, 8, (0 : Int)).2.1
      ([1, 0, 2, 3], 6, 8, (0 : Int)).2.2.1 ([1, 0, 2, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode5_s84.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 2, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s84
theorem z7UnaryRows5_s85 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 2, 4] 5 1 (1 : Int))
    (z7UnaryCode5_s85.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s85_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 2, 4], 5, 1, (1 : Int)).1 ([1, 0, 2, 4], 5, 1, (1 : Int)).2.1
      ([1, 0, 2, 4], 5, 1, (1 : Int)).2.2.1 ([1, 0, 2, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode5_s85.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 2, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s85
theorem z7UnaryRows5_s86 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 3, 0] 8 12 (-4 : Int))
    (z7UnaryCode5_s86.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s86_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 3, 0], 8, 12, (-4 : Int)).1 ([1, 0, 3, 0], 8, 12, (-4 : Int)).2.1
      ([1, 0, 3, 0], 8, 12, (-4 : Int)).2.2.1 ([1, 0, 3, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s86.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 3, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s86
theorem z7UnaryRows5_s87 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 3, 1] 7 11 (-3 : Int))
    (z7UnaryCode5_s87.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s87_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 3, 1], 7, 11, (-3 : Int)).1 ([1, 0, 3, 1], 7, 11, (-3 : Int)).2.1
      ([1, 0, 3, 1], 7, 11, (-3 : Int)).2.2.1 ([1, 0, 3, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s87.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 3, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s87
theorem z7UnaryRows5_s88 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 3, 2] 6 8 (-2 : Int))
    (z7UnaryCode5_s88.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s88_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 3, 2], 6, 8, (-2 : Int)).1 ([1, 0, 3, 2], 6, 8, (-2 : Int)).2.1
      ([1, 0, 3, 2], 6, 8, (-2 : Int)).2.2.1 ([1, 0, 3, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s88.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 3, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s88
theorem z7UnaryRows5_s89 : rowsBeq
    (z7GenRow 8 5 4 [1, 0, 3, 3] 5 3 (-1 : Int))
    (z7UnaryCode5_s89.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s89_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 0, 3, 3], 5, 3, (-1 : Int)).1 ([1, 0, 3, 3], 5, 3, (-1 : Int)).2.1
      ([1, 0, 3, 3], 5, 3, (-1 : Int)).2.2.1 ([1, 0, 3, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s89.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 0, 3, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s89
theorem z7UnaryRows5_s90 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 0, 0] 10 20 (-2 : Int))
    (z7UnaryCode5_s90.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s90_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 0, 0], 10, 20, (-2 : Int)).1 ([1, 1, 0, 0], 10, 20, (-2 : Int)).2.1
      ([1, 1, 0, 0], 10, 20, (-2 : Int)).2.2.1 ([1, 1, 0, 0], 10, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s90.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 0, 0] 10 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s90
theorem z7UnaryRows5_s91 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 0, 1] 9 19 (-1 : Int))
    (z7UnaryCode5_s91.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s91_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 0, 1], 9, 19, (-1 : Int)).1 ([1, 1, 0, 1], 9, 19, (-1 : Int)).2.1
      ([1, 1, 0, 1], 9, 19, (-1 : Int)).2.2.1 ([1, 1, 0, 1], 9, 19, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s91.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 0, 1] 9 19 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s91
theorem z7UnaryRows5_s92 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 0, 2] 8 16 (0 : Int))
    (z7UnaryCode5_s92.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s92_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 0, 2], 8, 16, (0 : Int)).1 ([1, 1, 0, 2], 8, 16, (0 : Int)).2.1
      ([1, 1, 0, 2], 8, 16, (0 : Int)).2.2.1 ([1, 1, 0, 2], 8, 16, (0 : Int)).2.2.2 =
    z7UnaryCode5_s92.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 0, 2] 8 16 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s92
theorem z7UnaryRows5_s93 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 0, 3] 7 11 (1 : Int))
    (z7UnaryCode5_s93.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s93_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 0, 3], 7, 11, (1 : Int)).1 ([1, 1, 0, 3], 7, 11, (1 : Int)).2.1
      ([1, 1, 0, 3], 7, 11, (1 : Int)).2.2.1 ([1, 1, 0, 3], 7, 11, (1 : Int)).2.2.2 =
    z7UnaryCode5_s93.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 0, 3] 7 11 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s93
theorem z7UnaryRows5_s94 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 0, 4] 6 4 (2 : Int))
    (z7UnaryCode5_s94.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s94_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 0, 4], 6, 4, (2 : Int)).1 ([1, 1, 0, 4], 6, 4, (2 : Int)).2.1
      ([1, 1, 0, 4], 6, 4, (2 : Int)).2.2.1 ([1, 1, 0, 4], 6, 4, (2 : Int)).2.2.2 =
    z7UnaryCode5_s94.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 0, 4] 6 4 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s94
theorem z7UnaryRows5_s95 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 1, 0] 9 19 (-3 : Int))
    (z7UnaryCode5_s95.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s95_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 1, 0], 9, 19, (-3 : Int)).1 ([1, 1, 1, 0], 9, 19, (-3 : Int)).2.1
      ([1, 1, 1, 0], 9, 19, (-3 : Int)).2.2.1 ([1, 1, 1, 0], 9, 19, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s95.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 1, 0] 9 19 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s95
theorem z7UnaryRows5_s96 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 1, 1] 8 18 (-2 : Int))
    (z7UnaryCode5_s96.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s96_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 1, 1], 8, 18, (-2 : Int)).1 ([1, 1, 1, 1], 8, 18, (-2 : Int)).2.1
      ([1, 1, 1, 1], 8, 18, (-2 : Int)).2.2.1 ([1, 1, 1, 1], 8, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s96.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 1, 1] 8 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s96
theorem z7UnaryRows5_s97 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 1, 2] 7 15 (-1 : Int))
    (z7UnaryCode5_s97.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s97_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 1, 2], 7, 15, (-1 : Int)).1 ([1, 1, 1, 2], 7, 15, (-1 : Int)).2.1
      ([1, 1, 1, 2], 7, 15, (-1 : Int)).2.2.1 ([1, 1, 1, 2], 7, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s97.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 1, 2] 7 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s97
theorem z7UnaryRows5_s98 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 1, 3] 6 10 (0 : Int))
    (z7UnaryCode5_s98.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s98_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 1, 3], 6, 10, (0 : Int)).1 ([1, 1, 1, 3], 6, 10, (0 : Int)).2.1
      ([1, 1, 1, 3], 6, 10, (0 : Int)).2.2.1 ([1, 1, 1, 3], 6, 10, (0 : Int)).2.2.2 =
    z7UnaryCode5_s98.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 1, 3] 6 10 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s98
theorem z7UnaryRows5_s99 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 1, 4] 5 3 (1 : Int))
    (z7UnaryCode5_s99.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s99_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 1, 4], 5, 3, (1 : Int)).1 ([1, 1, 1, 4], 5, 3, (1 : Int)).2.1
      ([1, 1, 1, 4], 5, 3, (1 : Int)).2.2.1 ([1, 1, 1, 4], 5, 3, (1 : Int)).2.2.2 =
    z7UnaryCode5_s99.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 1, 4] 5 3 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s99
theorem z7UnaryRows5_s100 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 2, 0] 8 16 (-4 : Int))
    (z7UnaryCode5_s100.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s100_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 2, 0], 8, 16, (-4 : Int)).1 ([1, 1, 2, 0], 8, 16, (-4 : Int)).2.1
      ([1, 1, 2, 0], 8, 16, (-4 : Int)).2.2.1 ([1, 1, 2, 0], 8, 16, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s100.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 2, 0] 8 16 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s100
theorem z7UnaryRows5_s101 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 2, 1] 7 15 (-3 : Int))
    (z7UnaryCode5_s101.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s101_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 2, 1], 7, 15, (-3 : Int)).1 ([1, 1, 2, 1], 7, 15, (-3 : Int)).2.1
      ([1, 1, 2, 1], 7, 15, (-3 : Int)).2.2.1 ([1, 1, 2, 1], 7, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s101.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 2, 1] 7 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s101
theorem z7UnaryRows5_s102 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 2, 2] 6 12 (-2 : Int))
    (z7UnaryCode5_s102.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s102_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 2, 2], 6, 12, (-2 : Int)).1 ([1, 1, 2, 2], 6, 12, (-2 : Int)).2.1
      ([1, 1, 2, 2], 6, 12, (-2 : Int)).2.2.1 ([1, 1, 2, 2], 6, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s102.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 2, 2] 6 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s102
theorem z7UnaryRows5_s103 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 2, 3] 5 7 (-1 : Int))
    (z7UnaryCode5_s103.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s103_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 2, 3], 5, 7, (-1 : Int)).1 ([1, 1, 2, 3], 5, 7, (-1 : Int)).2.1
      ([1, 1, 2, 3], 5, 7, (-1 : Int)).2.2.1 ([1, 1, 2, 3], 5, 7, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s103.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 2, 3] 5 7 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s103
theorem z7UnaryRows5_s104 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 2, 4] 4 0 (0 : Int))
    (z7UnaryCode5_s104.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s104_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 2, 4], 4, 0, (0 : Int)).1 ([1, 1, 2, 4], 4, 0, (0 : Int)).2.1
      ([1, 1, 2, 4], 4, 0, (0 : Int)).2.2.1 ([1, 1, 2, 4], 4, 0, (0 : Int)).2.2.2 =
    z7UnaryCode5_s104.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 2, 4] 4 0 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s104
theorem z7UnaryRows5_s105 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 3, 0] 7 11 (-5 : Int))
    (z7UnaryCode5_s105.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s105_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 3, 0], 7, 11, (-5 : Int)).1 ([1, 1, 3, 0], 7, 11, (-5 : Int)).2.1
      ([1, 1, 3, 0], 7, 11, (-5 : Int)).2.2.1 ([1, 1, 3, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s105.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 3, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s105
theorem z7UnaryRows5_s106 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 3, 1] 6 10 (-4 : Int))
    (z7UnaryCode5_s106.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s106_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 3, 1], 6, 10, (-4 : Int)).1 ([1, 1, 3, 1], 6, 10, (-4 : Int)).2.1
      ([1, 1, 3, 1], 6, 10, (-4 : Int)).2.2.1 ([1, 1, 3, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s106.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 3, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s106
theorem z7UnaryRows5_s107 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 3, 2] 5 7 (-3 : Int))
    (z7UnaryCode5_s107.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s107_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 3, 2], 5, 7, (-3 : Int)).1 ([1, 1, 3, 2], 5, 7, (-3 : Int)).2.1
      ([1, 1, 3, 2], 5, 7, (-3 : Int)).2.2.1 ([1, 1, 3, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s107.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 3, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s107
theorem z7UnaryRows5_s108 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 3, 3] 4 2 (-2 : Int))
    (z7UnaryCode5_s108.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s108_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 3, 3], 4, 2, (-2 : Int)).1 ([1, 1, 3, 3], 4, 2, (-2 : Int)).2.1
      ([1, 1, 3, 3], 4, 2, (-2 : Int)).2.2.1 ([1, 1, 3, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s108.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 3, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s108
theorem z7UnaryRows5_s109 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 4, 0] 6 4 (-6 : Int))
    (z7UnaryCode5_s109.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s109_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 4, 0], 6, 4, (-6 : Int)).1 ([1, 1, 4, 0], 6, 4, (-6 : Int)).2.1
      ([1, 1, 4, 0], 6, 4, (-6 : Int)).2.2.1 ([1, 1, 4, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s109.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 4, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s109
theorem z7UnaryRows5_s110 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 4, 1] 5 3 (-5 : Int))
    (z7UnaryCode5_s110.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s110_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 4, 1], 5, 3, (-5 : Int)).1 ([1, 1, 4, 1], 5, 3, (-5 : Int)).2.1
      ([1, 1, 4, 1], 5, 3, (-5 : Int)).2.2.1 ([1, 1, 4, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s110.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 4, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s110
theorem z7UnaryRows5_s111 : rowsBeq
    (z7GenRow 8 5 4 [1, 1, 4, 2] 4 0 (-4 : Int))
    (z7UnaryCode5_s111.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s111_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 1, 4, 2], 4, 0, (-4 : Int)).1 ([1, 1, 4, 2], 4, 0, (-4 : Int)).2.1
      ([1, 1, 4, 2], 4, 0, (-4 : Int)).2.2.1 ([1, 1, 4, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s111.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 1, 4, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s111
theorem z7UnaryRows5_s112 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 0, 0] 9 17 (-3 : Int))
    (z7UnaryCode5_s112.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s112_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 0, 0], 9, 17, (-3 : Int)).1 ([1, 2, 0, 0], 9, 17, (-3 : Int)).2.1
      ([1, 2, 0, 0], 9, 17, (-3 : Int)).2.2.1 ([1, 2, 0, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s112.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 0, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s112
theorem z7UnaryRows5_s113 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 0, 1] 8 16 (-2 : Int))
    (z7UnaryCode5_s113.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s113_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 0, 1], 8, 16, (-2 : Int)).1 ([1, 2, 0, 1], 8, 16, (-2 : Int)).2.1
      ([1, 2, 0, 1], 8, 16, (-2 : Int)).2.2.1 ([1, 2, 0, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s113.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 0, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s113
theorem z7UnaryRows5_s114 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 0, 2] 7 13 (-1 : Int))
    (z7UnaryCode5_s114.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s114_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 0, 2], 7, 13, (-1 : Int)).1 ([1, 2, 0, 2], 7, 13, (-1 : Int)).2.1
      ([1, 2, 0, 2], 7, 13, (-1 : Int)).2.2.1 ([1, 2, 0, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s114.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 0, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s114
theorem z7UnaryRows5_s115 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 0, 3] 6 8 (0 : Int))
    (z7UnaryCode5_s115.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s115_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 0, 3], 6, 8, (0 : Int)).1 ([1, 2, 0, 3], 6, 8, (0 : Int)).2.1
      ([1, 2, 0, 3], 6, 8, (0 : Int)).2.2.1 ([1, 2, 0, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode5_s115.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 0, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s115
theorem z7UnaryRows5_s116 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 0, 4] 5 1 (1 : Int))
    (z7UnaryCode5_s116.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s116_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 0, 4], 5, 1, (1 : Int)).1 ([1, 2, 0, 4], 5, 1, (1 : Int)).2.1
      ([1, 2, 0, 4], 5, 1, (1 : Int)).2.2.1 ([1, 2, 0, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode5_s116.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 0, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s116
theorem z7UnaryRows5_s117 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 1, 0] 8 16 (-4 : Int))
    (z7UnaryCode5_s117.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s117_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 1, 0], 8, 16, (-4 : Int)).1 ([1, 2, 1, 0], 8, 16, (-4 : Int)).2.1
      ([1, 2, 1, 0], 8, 16, (-4 : Int)).2.2.1 ([1, 2, 1, 0], 8, 16, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s117.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 1, 0] 8 16 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s117
theorem z7UnaryRows5_s118 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 1, 1] 7 15 (-3 : Int))
    (z7UnaryCode5_s118.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s118_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 1, 1], 7, 15, (-3 : Int)).1 ([1, 2, 1, 1], 7, 15, (-3 : Int)).2.1
      ([1, 2, 1, 1], 7, 15, (-3 : Int)).2.2.1 ([1, 2, 1, 1], 7, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s118.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 1, 1] 7 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s118
theorem z7UnaryRows5_s119 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 1, 2] 6 12 (-2 : Int))
    (z7UnaryCode5_s119.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s119_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 1, 2], 6, 12, (-2 : Int)).1 ([1, 2, 1, 2], 6, 12, (-2 : Int)).2.1
      ([1, 2, 1, 2], 6, 12, (-2 : Int)).2.2.1 ([1, 2, 1, 2], 6, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s119.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 1, 2] 6 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s119
theorem z7UnaryRows5_s120 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 1, 3] 5 7 (-1 : Int))
    (z7UnaryCode5_s120.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s120_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 1, 3], 5, 7, (-1 : Int)).1 ([1, 2, 1, 3], 5, 7, (-1 : Int)).2.1
      ([1, 2, 1, 3], 5, 7, (-1 : Int)).2.2.1 ([1, 2, 1, 3], 5, 7, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s120.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 1, 3] 5 7 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s120
theorem z7UnaryRows5_s121 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 1, 4] 4 0 (0 : Int))
    (z7UnaryCode5_s121.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s121_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 1, 4], 4, 0, (0 : Int)).1 ([1, 2, 1, 4], 4, 0, (0 : Int)).2.1
      ([1, 2, 1, 4], 4, 0, (0 : Int)).2.2.1 ([1, 2, 1, 4], 4, 0, (0 : Int)).2.2.2 =
    z7UnaryCode5_s121.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 1, 4] 4 0 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s121
theorem z7UnaryRows5_s122 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 2, 0] 7 13 (-5 : Int))
    (z7UnaryCode5_s122.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s122_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 2, 0], 7, 13, (-5 : Int)).1 ([1, 2, 2, 0], 7, 13, (-5 : Int)).2.1
      ([1, 2, 2, 0], 7, 13, (-5 : Int)).2.2.1 ([1, 2, 2, 0], 7, 13, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s122.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 2, 0] 7 13 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s122
theorem z7UnaryRows5_s123 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 2, 1] 6 12 (-4 : Int))
    (z7UnaryCode5_s123.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s123_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 2, 1], 6, 12, (-4 : Int)).1 ([1, 2, 2, 1], 6, 12, (-4 : Int)).2.1
      ([1, 2, 2, 1], 6, 12, (-4 : Int)).2.2.1 ([1, 2, 2, 1], 6, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s123.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 2, 1] 6 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s123
theorem z7UnaryRows5_s124 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 2, 2] 5 9 (-3 : Int))
    (z7UnaryCode5_s124.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s124_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 2, 2], 5, 9, (-3 : Int)).1 ([1, 2, 2, 2], 5, 9, (-3 : Int)).2.1
      ([1, 2, 2, 2], 5, 9, (-3 : Int)).2.2.1 ([1, 2, 2, 2], 5, 9, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s124.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 2, 2] 5 9 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s124
theorem z7UnaryRows5_s125 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 2, 3] 4 4 (-2 : Int))
    (z7UnaryCode5_s125.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s125_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 2, 3], 4, 4, (-2 : Int)).1 ([1, 2, 2, 3], 4, 4, (-2 : Int)).2.1
      ([1, 2, 2, 3], 4, 4, (-2 : Int)).2.2.1 ([1, 2, 2, 3], 4, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s125.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 2, 3] 4 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s125
theorem z7UnaryRows5_s126 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 3, 0] 6 8 (-6 : Int))
    (z7UnaryCode5_s126.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s126_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 3, 0], 6, 8, (-6 : Int)).1 ([1, 2, 3, 0], 6, 8, (-6 : Int)).2.1
      ([1, 2, 3, 0], 6, 8, (-6 : Int)).2.2.1 ([1, 2, 3, 0], 6, 8, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s126.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 3, 0] 6 8 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s126
theorem z7UnaryRows5_s127 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 3, 1] 5 7 (-5 : Int))
    (z7UnaryCode5_s127.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s127_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 3, 1], 5, 7, (-5 : Int)).1 ([1, 2, 3, 1], 5, 7, (-5 : Int)).2.1
      ([1, 2, 3, 1], 5, 7, (-5 : Int)).2.2.1 ([1, 2, 3, 1], 5, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s127.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 3, 1] 5 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s127
theorem z7UnaryRows5_s128 : rowsBeq
    (z7GenRow 8 5 4 [1, 2, 3, 2] 4 4 (-4 : Int))
    (z7UnaryCode5_s128.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s128_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 2, 3, 2], 4, 4, (-4 : Int)).1 ([1, 2, 3, 2], 4, 4, (-4 : Int)).2.1
      ([1, 2, 3, 2], 4, 4, (-4 : Int)).2.2.1 ([1, 2, 3, 2], 4, 4, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s128.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 2, 3, 2] 4 4 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s128
theorem z7UnaryRows5_s129 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 0, 0] 8 12 (-4 : Int))
    (z7UnaryCode5_s129.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s129_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 0, 0], 8, 12, (-4 : Int)).1 ([1, 3, 0, 0], 8, 12, (-4 : Int)).2.1
      ([1, 3, 0, 0], 8, 12, (-4 : Int)).2.2.1 ([1, 3, 0, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s129.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 0, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s129
theorem z7UnaryRows5_s130 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 0, 1] 7 11 (-3 : Int))
    (z7UnaryCode5_s130.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s130_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 0, 1], 7, 11, (-3 : Int)).1 ([1, 3, 0, 1], 7, 11, (-3 : Int)).2.1
      ([1, 3, 0, 1], 7, 11, (-3 : Int)).2.2.1 ([1, 3, 0, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s130.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 0, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s130
theorem z7UnaryRows5_s131 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 0, 2] 6 8 (-2 : Int))
    (z7UnaryCode5_s131.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s131_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 0, 2], 6, 8, (-2 : Int)).1 ([1, 3, 0, 2], 6, 8, (-2 : Int)).2.1
      ([1, 3, 0, 2], 6, 8, (-2 : Int)).2.2.1 ([1, 3, 0, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s131.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 0, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s131
theorem z7UnaryRows5_s132 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 0, 3] 5 3 (-1 : Int))
    (z7UnaryCode5_s132.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s132_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 0, 3], 5, 3, (-1 : Int)).1 ([1, 3, 0, 3], 5, 3, (-1 : Int)).2.1
      ([1, 3, 0, 3], 5, 3, (-1 : Int)).2.2.1 ([1, 3, 0, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s132.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 0, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s132
theorem z7UnaryRows5_s133 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 1, 0] 7 11 (-5 : Int))
    (z7UnaryCode5_s133.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s133_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 1, 0], 7, 11, (-5 : Int)).1 ([1, 3, 1, 0], 7, 11, (-5 : Int)).2.1
      ([1, 3, 1, 0], 7, 11, (-5 : Int)).2.2.1 ([1, 3, 1, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s133.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 1, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s133
theorem z7UnaryRows5_s134 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 1, 1] 6 10 (-4 : Int))
    (z7UnaryCode5_s134.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s134_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 1, 1], 6, 10, (-4 : Int)).1 ([1, 3, 1, 1], 6, 10, (-4 : Int)).2.1
      ([1, 3, 1, 1], 6, 10, (-4 : Int)).2.2.1 ([1, 3, 1, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s134.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 1, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s134
theorem z7UnaryRows5_s135 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 1, 2] 5 7 (-3 : Int))
    (z7UnaryCode5_s135.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s135_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 1, 2], 5, 7, (-3 : Int)).1 ([1, 3, 1, 2], 5, 7, (-3 : Int)).2.1
      ([1, 3, 1, 2], 5, 7, (-3 : Int)).2.2.1 ([1, 3, 1, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s135.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 1, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s135
theorem z7UnaryRows5_s136 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 1, 3] 4 2 (-2 : Int))
    (z7UnaryCode5_s136.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s136_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 1, 3], 4, 2, (-2 : Int)).1 ([1, 3, 1, 3], 4, 2, (-2 : Int)).2.1
      ([1, 3, 1, 3], 4, 2, (-2 : Int)).2.2.1 ([1, 3, 1, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s136.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 1, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s136
theorem z7UnaryRows5_s137 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 2, 0] 6 8 (-6 : Int))
    (z7UnaryCode5_s137.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s137_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 2, 0], 6, 8, (-6 : Int)).1 ([1, 3, 2, 0], 6, 8, (-6 : Int)).2.1
      ([1, 3, 2, 0], 6, 8, (-6 : Int)).2.2.1 ([1, 3, 2, 0], 6, 8, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s137.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 2, 0] 6 8 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s137
theorem z7UnaryRows5_s138 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 2, 1] 5 7 (-5 : Int))
    (z7UnaryCode5_s138.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s138_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 2, 1], 5, 7, (-5 : Int)).1 ([1, 3, 2, 1], 5, 7, (-5 : Int)).2.1
      ([1, 3, 2, 1], 5, 7, (-5 : Int)).2.2.1 ([1, 3, 2, 1], 5, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s138.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 2, 1] 5 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s138
theorem z7UnaryRows5_s139 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 2, 2] 4 4 (-4 : Int))
    (z7UnaryCode5_s139.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s139_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 2, 2], 4, 4, (-4 : Int)).1 ([1, 3, 2, 2], 4, 4, (-4 : Int)).2.1
      ([1, 3, 2, 2], 4, 4, (-4 : Int)).2.2.1 ([1, 3, 2, 2], 4, 4, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s139.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 2, 2] 4 4 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s139
theorem z7UnaryRows5_s140 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 3, 0] 5 3 (-7 : Int))
    (z7UnaryCode5_s140.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s140_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 3, 0], 5, 3, (-7 : Int)).1 ([1, 3, 3, 0], 5, 3, (-7 : Int)).2.1
      ([1, 3, 3, 0], 5, 3, (-7 : Int)).2.2.1 ([1, 3, 3, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode5_s140.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 3, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s140
theorem z7UnaryRows5_s141 : rowsBeq
    (z7GenRow 8 5 4 [1, 3, 3, 1] 4 2 (-6 : Int))
    (z7UnaryCode5_s141.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s141_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 3, 3, 1], 4, 2, (-6 : Int)).1 ([1, 3, 3, 1], 4, 2, (-6 : Int)).2.1
      ([1, 3, 3, 1], 4, 2, (-6 : Int)).2.2.1 ([1, 3, 3, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s141.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 3, 3, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s141
theorem z7UnaryRows5_s142 : rowsBeq
    (z7GenRow 8 5 4 [1, 4, 1, 0] 6 4 (-6 : Int))
    (z7UnaryCode5_s142.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s142_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 4, 1, 0], 6, 4, (-6 : Int)).1 ([1, 4, 1, 0], 6, 4, (-6 : Int)).2.1
      ([1, 4, 1, 0], 6, 4, (-6 : Int)).2.2.1 ([1, 4, 1, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s142.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 4, 1, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s142
theorem z7UnaryRows5_s143 : rowsBeq
    (z7GenRow 8 5 4 [1, 4, 1, 1] 5 3 (-5 : Int))
    (z7UnaryCode5_s143.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s143_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 4, 1, 1], 5, 3, (-5 : Int)).1 ([1, 4, 1, 1], 5, 3, (-5 : Int)).2.1
      ([1, 4, 1, 1], 5, 3, (-5 : Int)).2.2.1 ([1, 4, 1, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s143.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 4, 1, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s143
theorem z7UnaryRows5_s144 : rowsBeq
    (z7GenRow 8 5 4 [1, 4, 1, 2] 4 0 (-4 : Int))
    (z7UnaryCode5_s144.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s144_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([1, 4, 1, 2], 4, 0, (-4 : Int)).1 ([1, 4, 1, 2], 4, 0, (-4 : Int)).2.1
      ([1, 4, 1, 2], 4, 0, (-4 : Int)).2.2.1 ([1, 4, 1, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s144.map z7DecodeRow := by
  show z7GenRow 8 5 4 [1, 4, 1, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s144
theorem z7UnaryRows5_s145 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 0, 0] 10 18 (-2 : Int))
    (z7UnaryCode5_s145.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s145_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 0, 0], 10, 18, (-2 : Int)).1 ([2, 0, 0, 0], 10, 18, (-2 : Int)).2.1
      ([2, 0, 0, 0], 10, 18, (-2 : Int)).2.2.1 ([2, 0, 0, 0], 10, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s145.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 0, 0] 10 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s145
theorem z7UnaryRows5_s146 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 0, 1] 9 17 (-1 : Int))
    (z7UnaryCode5_s146.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s146_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 0, 1], 9, 17, (-1 : Int)).1 ([2, 0, 0, 1], 9, 17, (-1 : Int)).2.1
      ([2, 0, 0, 1], 9, 17, (-1 : Int)).2.2.1 ([2, 0, 0, 1], 9, 17, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s146.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 0, 1] 9 17 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s146
theorem z7UnaryRows5_s147 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 0, 2] 8 14 (0 : Int))
    (z7UnaryCode5_s147.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s147_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 0, 2], 8, 14, (0 : Int)).1 ([2, 0, 0, 2], 8, 14, (0 : Int)).2.1
      ([2, 0, 0, 2], 8, 14, (0 : Int)).2.2.1 ([2, 0, 0, 2], 8, 14, (0 : Int)).2.2.2 =
    z7UnaryCode5_s147.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 0, 2] 8 14 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s147
theorem z7UnaryRows5_s148 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 0, 3] 7 9 (1 : Int))
    (z7UnaryCode5_s148.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s148_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 0, 3], 7, 9, (1 : Int)).1 ([2, 0, 0, 3], 7, 9, (1 : Int)).2.1
      ([2, 0, 0, 3], 7, 9, (1 : Int)).2.2.1 ([2, 0, 0, 3], 7, 9, (1 : Int)).2.2.2 =
    z7UnaryCode5_s148.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 0, 3] 7 9 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s148
theorem z7UnaryRows5_s149 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 0, 4] 6 2 (2 : Int))
    (z7UnaryCode5_s149.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s149_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 0, 4], 6, 2, (2 : Int)).1 ([2, 0, 0, 4], 6, 2, (2 : Int)).2.1
      ([2, 0, 0, 4], 6, 2, (2 : Int)).2.2.1 ([2, 0, 0, 4], 6, 2, (2 : Int)).2.2.2 =
    z7UnaryCode5_s149.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 0, 4] 6 2 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s149
theorem z7UnaryRows5_s150 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 1, 0] 9 17 (-3 : Int))
    (z7UnaryCode5_s150.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s150_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 1, 0], 9, 17, (-3 : Int)).1 ([2, 0, 1, 0], 9, 17, (-3 : Int)).2.1
      ([2, 0, 1, 0], 9, 17, (-3 : Int)).2.2.1 ([2, 0, 1, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s150.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 1, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s150
theorem z7UnaryRows5_s151 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 1, 1] 8 16 (-2 : Int))
    (z7UnaryCode5_s151.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s151_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 1, 1], 8, 16, (-2 : Int)).1 ([2, 0, 1, 1], 8, 16, (-2 : Int)).2.1
      ([2, 0, 1, 1], 8, 16, (-2 : Int)).2.2.1 ([2, 0, 1, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s151.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 1, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s151
theorem z7UnaryRows5_s152 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 1, 2] 7 13 (-1 : Int))
    (z7UnaryCode5_s152.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s152_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 1, 2], 7, 13, (-1 : Int)).1 ([2, 0, 1, 2], 7, 13, (-1 : Int)).2.1
      ([2, 0, 1, 2], 7, 13, (-1 : Int)).2.2.1 ([2, 0, 1, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s152.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 1, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s152
theorem z7UnaryRows5_s153 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 1, 3] 6 8 (0 : Int))
    (z7UnaryCode5_s153.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s153_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 1, 3], 6, 8, (0 : Int)).1 ([2, 0, 1, 3], 6, 8, (0 : Int)).2.1
      ([2, 0, 1, 3], 6, 8, (0 : Int)).2.2.1 ([2, 0, 1, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode5_s153.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 1, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s153
theorem z7UnaryRows5_s154 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 1, 4] 5 1 (1 : Int))
    (z7UnaryCode5_s154.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s154_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 1, 4], 5, 1, (1 : Int)).1 ([2, 0, 1, 4], 5, 1, (1 : Int)).2.1
      ([2, 0, 1, 4], 5, 1, (1 : Int)).2.2.1 ([2, 0, 1, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode5_s154.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 1, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s154
theorem z7UnaryRows5_s155 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 2, 0] 8 14 (-4 : Int))
    (z7UnaryCode5_s155.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s155_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 2, 0], 8, 14, (-4 : Int)).1 ([2, 0, 2, 0], 8, 14, (-4 : Int)).2.1
      ([2, 0, 2, 0], 8, 14, (-4 : Int)).2.2.1 ([2, 0, 2, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s155.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 2, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s155
theorem z7UnaryRows5_s156 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 2, 1] 7 13 (-3 : Int))
    (z7UnaryCode5_s156.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s156_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 2, 1], 7, 13, (-3 : Int)).1 ([2, 0, 2, 1], 7, 13, (-3 : Int)).2.1
      ([2, 0, 2, 1], 7, 13, (-3 : Int)).2.2.1 ([2, 0, 2, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s156.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 2, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s156
theorem z7UnaryRows5_s157 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 2, 2] 6 10 (-2 : Int))
    (z7UnaryCode5_s157.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s157_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 2, 2], 6, 10, (-2 : Int)).1 ([2, 0, 2, 2], 6, 10, (-2 : Int)).2.1
      ([2, 0, 2, 2], 6, 10, (-2 : Int)).2.2.1 ([2, 0, 2, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s157.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 2, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s157
theorem z7UnaryRows5_s158 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 2, 3] 5 5 (-1 : Int))
    (z7UnaryCode5_s158.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s158_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 2, 3], 5, 5, (-1 : Int)).1 ([2, 0, 2, 3], 5, 5, (-1 : Int)).2.1
      ([2, 0, 2, 3], 5, 5, (-1 : Int)).2.2.1 ([2, 0, 2, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s158.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 2, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s158
theorem z7UnaryRows5_s159 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 3, 0] 7 9 (-5 : Int))
    (z7UnaryCode5_s159.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s159_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 3, 0], 7, 9, (-5 : Int)).1 ([2, 0, 3, 0], 7, 9, (-5 : Int)).2.1
      ([2, 0, 3, 0], 7, 9, (-5 : Int)).2.2.1 ([2, 0, 3, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s159.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 3, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s159
theorem z7UnaryRows5_s160 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 3, 1] 6 8 (-4 : Int))
    (z7UnaryCode5_s160.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s160_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 3, 1], 6, 8, (-4 : Int)).1 ([2, 0, 3, 1], 6, 8, (-4 : Int)).2.1
      ([2, 0, 3, 1], 6, 8, (-4 : Int)).2.2.1 ([2, 0, 3, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s160.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 3, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s160
theorem z7UnaryRows5_s161 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 3, 2] 5 5 (-3 : Int))
    (z7UnaryCode5_s161.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s161_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 3, 2], 5, 5, (-3 : Int)).1 ([2, 0, 3, 2], 5, 5, (-3 : Int)).2.1
      ([2, 0, 3, 2], 5, 5, (-3 : Int)).2.2.1 ([2, 0, 3, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s161.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 3, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s161
theorem z7UnaryRows5_s162 : rowsBeq
    (z7GenRow 8 5 4 [2, 0, 3, 3] 4 0 (-2 : Int))
    (z7UnaryCode5_s162.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s162_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 0, 3, 3], 4, 0, (-2 : Int)).1 ([2, 0, 3, 3], 4, 0, (-2 : Int)).2.1
      ([2, 0, 3, 3], 4, 0, (-2 : Int)).2.2.1 ([2, 0, 3, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s162.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 0, 3, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s162
theorem z7UnaryRows5_s163 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 0, 0] 9 17 (-3 : Int))
    (z7UnaryCode5_s163.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s163_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 0, 0], 9, 17, (-3 : Int)).1 ([2, 1, 0, 0], 9, 17, (-3 : Int)).2.1
      ([2, 1, 0, 0], 9, 17, (-3 : Int)).2.2.1 ([2, 1, 0, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s163.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 0, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s163
theorem z7UnaryRows5_s164 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 0, 1] 8 16 (-2 : Int))
    (z7UnaryCode5_s164.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s164_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 0, 1], 8, 16, (-2 : Int)).1 ([2, 1, 0, 1], 8, 16, (-2 : Int)).2.1
      ([2, 1, 0, 1], 8, 16, (-2 : Int)).2.2.1 ([2, 1, 0, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s164.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 0, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s164
theorem z7UnaryRows5_s165 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 0, 2] 7 13 (-1 : Int))
    (z7UnaryCode5_s165.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s165_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 0, 2], 7, 13, (-1 : Int)).1 ([2, 1, 0, 2], 7, 13, (-1 : Int)).2.1
      ([2, 1, 0, 2], 7, 13, (-1 : Int)).2.2.1 ([2, 1, 0, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s165.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 0, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s165
theorem z7UnaryRows5_s166 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 0, 3] 6 8 (0 : Int))
    (z7UnaryCode5_s166.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s166_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 0, 3], 6, 8, (0 : Int)).1 ([2, 1, 0, 3], 6, 8, (0 : Int)).2.1
      ([2, 1, 0, 3], 6, 8, (0 : Int)).2.2.1 ([2, 1, 0, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode5_s166.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 0, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s166
theorem z7UnaryRows5_s167 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 0, 4] 5 1 (1 : Int))
    (z7UnaryCode5_s167.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s167_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 0, 4], 5, 1, (1 : Int)).1 ([2, 1, 0, 4], 5, 1, (1 : Int)).2.1
      ([2, 1, 0, 4], 5, 1, (1 : Int)).2.2.1 ([2, 1, 0, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode5_s167.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 0, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s167
theorem z7UnaryRows5_s168 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 1, 0] 8 16 (-4 : Int))
    (z7UnaryCode5_s168.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s168_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 1, 0], 8, 16, (-4 : Int)).1 ([2, 1, 1, 0], 8, 16, (-4 : Int)).2.1
      ([2, 1, 1, 0], 8, 16, (-4 : Int)).2.2.1 ([2, 1, 1, 0], 8, 16, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s168.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 1, 0] 8 16 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s168
theorem z7UnaryRows5_s169 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 1, 1] 7 15 (-3 : Int))
    (z7UnaryCode5_s169.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s169_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 1, 1], 7, 15, (-3 : Int)).1 ([2, 1, 1, 1], 7, 15, (-3 : Int)).2.1
      ([2, 1, 1, 1], 7, 15, (-3 : Int)).2.2.1 ([2, 1, 1, 1], 7, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s169.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 1, 1] 7 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s169
theorem z7UnaryRows5_s170 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 1, 2] 6 12 (-2 : Int))
    (z7UnaryCode5_s170.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s170_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 1, 2], 6, 12, (-2 : Int)).1 ([2, 1, 1, 2], 6, 12, (-2 : Int)).2.1
      ([2, 1, 1, 2], 6, 12, (-2 : Int)).2.2.1 ([2, 1, 1, 2], 6, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s170.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 1, 2] 6 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s170
theorem z7UnaryRows5_s171 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 1, 3] 5 7 (-1 : Int))
    (z7UnaryCode5_s171.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s171_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 1, 3], 5, 7, (-1 : Int)).1 ([2, 1, 1, 3], 5, 7, (-1 : Int)).2.1
      ([2, 1, 1, 3], 5, 7, (-1 : Int)).2.2.1 ([2, 1, 1, 3], 5, 7, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s171.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 1, 3] 5 7 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s171
theorem z7UnaryRows5_s172 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 1, 4] 4 0 (0 : Int))
    (z7UnaryCode5_s172.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s172_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 1, 4], 4, 0, (0 : Int)).1 ([2, 1, 1, 4], 4, 0, (0 : Int)).2.1
      ([2, 1, 1, 4], 4, 0, (0 : Int)).2.2.1 ([2, 1, 1, 4], 4, 0, (0 : Int)).2.2.2 =
    z7UnaryCode5_s172.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 1, 4] 4 0 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s172
theorem z7UnaryRows5_s173 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 2, 0] 7 13 (-5 : Int))
    (z7UnaryCode5_s173.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s173_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 2, 0], 7, 13, (-5 : Int)).1 ([2, 1, 2, 0], 7, 13, (-5 : Int)).2.1
      ([2, 1, 2, 0], 7, 13, (-5 : Int)).2.2.1 ([2, 1, 2, 0], 7, 13, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s173.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 2, 0] 7 13 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s173
theorem z7UnaryRows5_s174 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 2, 1] 6 12 (-4 : Int))
    (z7UnaryCode5_s174.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s174_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 2, 1], 6, 12, (-4 : Int)).1 ([2, 1, 2, 1], 6, 12, (-4 : Int)).2.1
      ([2, 1, 2, 1], 6, 12, (-4 : Int)).2.2.1 ([2, 1, 2, 1], 6, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s174.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 2, 1] 6 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s174
theorem z7UnaryRows5_s175 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 2, 2] 5 9 (-3 : Int))
    (z7UnaryCode5_s175.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s175_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 2, 2], 5, 9, (-3 : Int)).1 ([2, 1, 2, 2], 5, 9, (-3 : Int)).2.1
      ([2, 1, 2, 2], 5, 9, (-3 : Int)).2.2.1 ([2, 1, 2, 2], 5, 9, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s175.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 2, 2] 5 9 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s175
theorem z7UnaryRows5_s176 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 2, 3] 4 4 (-2 : Int))
    (z7UnaryCode5_s176.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s176_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 2, 3], 4, 4, (-2 : Int)).1 ([2, 1, 2, 3], 4, 4, (-2 : Int)).2.1
      ([2, 1, 2, 3], 4, 4, (-2 : Int)).2.2.1 ([2, 1, 2, 3], 4, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s176.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 2, 3] 4 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s176
theorem z7UnaryRows5_s177 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 3, 0] 6 8 (-6 : Int))
    (z7UnaryCode5_s177.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s177_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 3, 0], 6, 8, (-6 : Int)).1 ([2, 1, 3, 0], 6, 8, (-6 : Int)).2.1
      ([2, 1, 3, 0], 6, 8, (-6 : Int)).2.2.1 ([2, 1, 3, 0], 6, 8, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s177.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 3, 0] 6 8 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s177
theorem z7UnaryRows5_s178 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 3, 1] 5 7 (-5 : Int))
    (z7UnaryCode5_s178.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s178_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 3, 1], 5, 7, (-5 : Int)).1 ([2, 1, 3, 1], 5, 7, (-5 : Int)).2.1
      ([2, 1, 3, 1], 5, 7, (-5 : Int)).2.2.1 ([2, 1, 3, 1], 5, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s178.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 3, 1] 5 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s178
theorem z7UnaryRows5_s179 : rowsBeq
    (z7GenRow 8 5 4 [2, 1, 3, 2] 4 4 (-4 : Int))
    (z7UnaryCode5_s179.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s179_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 1, 3, 2], 4, 4, (-4 : Int)).1 ([2, 1, 3, 2], 4, 4, (-4 : Int)).2.1
      ([2, 1, 3, 2], 4, 4, (-4 : Int)).2.2.1 ([2, 1, 3, 2], 4, 4, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s179.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 1, 3, 2] 4 4 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s179
theorem z7UnaryRows5_s180 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 0, 0] 8 14 (-4 : Int))
    (z7UnaryCode5_s180.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s180_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 0, 0], 8, 14, (-4 : Int)).1 ([2, 2, 0, 0], 8, 14, (-4 : Int)).2.1
      ([2, 2, 0, 0], 8, 14, (-4 : Int)).2.2.1 ([2, 2, 0, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s180.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 0, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s180
theorem z7UnaryRows5_s181 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 0, 1] 7 13 (-3 : Int))
    (z7UnaryCode5_s181.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s181_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 0, 1], 7, 13, (-3 : Int)).1 ([2, 2, 0, 1], 7, 13, (-3 : Int)).2.1
      ([2, 2, 0, 1], 7, 13, (-3 : Int)).2.2.1 ([2, 2, 0, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s181.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 0, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s181
theorem z7UnaryRows5_s182 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 0, 2] 6 10 (-2 : Int))
    (z7UnaryCode5_s182.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s182_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 0, 2], 6, 10, (-2 : Int)).1 ([2, 2, 0, 2], 6, 10, (-2 : Int)).2.1
      ([2, 2, 0, 2], 6, 10, (-2 : Int)).2.2.1 ([2, 2, 0, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s182.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 0, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s182
theorem z7UnaryRows5_s183 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 0, 3] 5 5 (-1 : Int))
    (z7UnaryCode5_s183.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s183_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 0, 3], 5, 5, (-1 : Int)).1 ([2, 2, 0, 3], 5, 5, (-1 : Int)).2.1
      ([2, 2, 0, 3], 5, 5, (-1 : Int)).2.2.1 ([2, 2, 0, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s183.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 0, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s183
theorem z7UnaryRows5_s184 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 1, 0] 7 13 (-5 : Int))
    (z7UnaryCode5_s184.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s184_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 1, 0], 7, 13, (-5 : Int)).1 ([2, 2, 1, 0], 7, 13, (-5 : Int)).2.1
      ([2, 2, 1, 0], 7, 13, (-5 : Int)).2.2.1 ([2, 2, 1, 0], 7, 13, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s184.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 1, 0] 7 13 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s184
theorem z7UnaryRows5_s185 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 1, 1] 6 12 (-4 : Int))
    (z7UnaryCode5_s185.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s185_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 1, 1], 6, 12, (-4 : Int)).1 ([2, 2, 1, 1], 6, 12, (-4 : Int)).2.1
      ([2, 2, 1, 1], 6, 12, (-4 : Int)).2.2.1 ([2, 2, 1, 1], 6, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s185.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 1, 1] 6 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s185
theorem z7UnaryRows5_s186 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 1, 2] 5 9 (-3 : Int))
    (z7UnaryCode5_s186.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s186_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 1, 2], 5, 9, (-3 : Int)).1 ([2, 2, 1, 2], 5, 9, (-3 : Int)).2.1
      ([2, 2, 1, 2], 5, 9, (-3 : Int)).2.2.1 ([2, 2, 1, 2], 5, 9, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s186.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 1, 2] 5 9 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s186
theorem z7UnaryRows5_s187 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 1, 3] 4 4 (-2 : Int))
    (z7UnaryCode5_s187.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s187_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 1, 3], 4, 4, (-2 : Int)).1 ([2, 2, 1, 3], 4, 4, (-2 : Int)).2.1
      ([2, 2, 1, 3], 4, 4, (-2 : Int)).2.2.1 ([2, 2, 1, 3], 4, 4, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s187.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 1, 3] 4 4 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s187
theorem z7UnaryRows5_s188 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 2, 0] 6 10 (-6 : Int))
    (z7UnaryCode5_s188.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s188_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 2, 0], 6, 10, (-6 : Int)).1 ([2, 2, 2, 0], 6, 10, (-6 : Int)).2.1
      ([2, 2, 2, 0], 6, 10, (-6 : Int)).2.2.1 ([2, 2, 2, 0], 6, 10, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s188.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 2, 0] 6 10 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s188
theorem z7UnaryRows5_s189 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 2, 1] 5 9 (-5 : Int))
    (z7UnaryCode5_s189.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s189_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 2, 1], 5, 9, (-5 : Int)).1 ([2, 2, 2, 1], 5, 9, (-5 : Int)).2.1
      ([2, 2, 2, 1], 5, 9, (-5 : Int)).2.2.1 ([2, 2, 2, 1], 5, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s189.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 2, 1] 5 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s189
theorem z7UnaryRows5_s190 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 2, 2] 4 6 (-4 : Int))
    (z7UnaryCode5_s190.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s190_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 2, 2], 4, 6, (-4 : Int)).1 ([2, 2, 2, 2], 4, 6, (-4 : Int)).2.1
      ([2, 2, 2, 2], 4, 6, (-4 : Int)).2.2.1 ([2, 2, 2, 2], 4, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s190.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 2, 2] 4 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s190
theorem z7UnaryRows5_s191 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 2, 3] 3 1 (-3 : Int))
    (z7UnaryCode5_s191.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s191_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 2, 3], 3, 1, (-3 : Int)).1 ([2, 2, 2, 3], 3, 1, (-3 : Int)).2.1
      ([2, 2, 2, 3], 3, 1, (-3 : Int)).2.2.1 ([2, 2, 2, 3], 3, 1, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s191.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 2, 3] 3 1 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s191
theorem z7UnaryRows5_s192 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 3, 0] 5 5 (-7 : Int))
    (z7UnaryCode5_s192.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s192_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 3, 0], 5, 5, (-7 : Int)).1 ([2, 2, 3, 0], 5, 5, (-7 : Int)).2.1
      ([2, 2, 3, 0], 5, 5, (-7 : Int)).2.2.1 ([2, 2, 3, 0], 5, 5, (-7 : Int)).2.2.2 =
    z7UnaryCode5_s192.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 3, 0] 5 5 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s192
theorem z7UnaryRows5_s193 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 3, 1] 4 4 (-6 : Int))
    (z7UnaryCode5_s193.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s193_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 3, 1], 4, 4, (-6 : Int)).1 ([2, 2, 3, 1], 4, 4, (-6 : Int)).2.1
      ([2, 2, 3, 1], 4, 4, (-6 : Int)).2.2.1 ([2, 2, 3, 1], 4, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s193.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 3, 1] 4 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s193
theorem z7UnaryRows5_s194 : rowsBeq
    (z7GenRow 8 5 4 [2, 2, 3, 2] 3 1 (-5 : Int))
    (z7UnaryCode5_s194.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s194_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 2, 3, 2], 3, 1, (-5 : Int)).1 ([2, 2, 3, 2], 3, 1, (-5 : Int)).2.1
      ([2, 2, 3, 2], 3, 1, (-5 : Int)).2.2.1 ([2, 2, 3, 2], 3, 1, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s194.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 2, 3, 2] 3 1 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s194
theorem z7UnaryRows5_s195 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 0, 0] 7 9 (-5 : Int))
    (z7UnaryCode5_s195.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s195_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 0, 0], 7, 9, (-5 : Int)).1 ([2, 3, 0, 0], 7, 9, (-5 : Int)).2.1
      ([2, 3, 0, 0], 7, 9, (-5 : Int)).2.2.1 ([2, 3, 0, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s195.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 0, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s195
theorem z7UnaryRows5_s196 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 0, 1] 6 8 (-4 : Int))
    (z7UnaryCode5_s196.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s196_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 0, 1], 6, 8, (-4 : Int)).1 ([2, 3, 0, 1], 6, 8, (-4 : Int)).2.1
      ([2, 3, 0, 1], 6, 8, (-4 : Int)).2.2.1 ([2, 3, 0, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s196.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 0, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s196
theorem z7UnaryRows5_s197 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 0, 2] 5 5 (-3 : Int))
    (z7UnaryCode5_s197.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s197_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 0, 2], 5, 5, (-3 : Int)).1 ([2, 3, 0, 2], 5, 5, (-3 : Int)).2.1
      ([2, 3, 0, 2], 5, 5, (-3 : Int)).2.2.1 ([2, 3, 0, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s197.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 0, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s197
theorem z7UnaryRows5_s198 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 0, 3] 4 0 (-2 : Int))
    (z7UnaryCode5_s198.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s198_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 0, 3], 4, 0, (-2 : Int)).1 ([2, 3, 0, 3], 4, 0, (-2 : Int)).2.1
      ([2, 3, 0, 3], 4, 0, (-2 : Int)).2.2.1 ([2, 3, 0, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s198.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 0, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s198
theorem z7UnaryRows5_s199 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 1, 0] 6 8 (-6 : Int))
    (z7UnaryCode5_s199.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s199_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 1, 0], 6, 8, (-6 : Int)).1 ([2, 3, 1, 0], 6, 8, (-6 : Int)).2.1
      ([2, 3, 1, 0], 6, 8, (-6 : Int)).2.2.1 ([2, 3, 1, 0], 6, 8, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s199.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 1, 0] 6 8 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s199
theorem z7UnaryRows5_s200 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 1, 1] 5 7 (-5 : Int))
    (z7UnaryCode5_s200.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s200_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 1, 1], 5, 7, (-5 : Int)).1 ([2, 3, 1, 1], 5, 7, (-5 : Int)).2.1
      ([2, 3, 1, 1], 5, 7, (-5 : Int)).2.2.1 ([2, 3, 1, 1], 5, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s200.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 1, 1] 5 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s200
theorem z7UnaryRows5_s201 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 1, 2] 4 4 (-4 : Int))
    (z7UnaryCode5_s201.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s201_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 1, 2], 4, 4, (-4 : Int)).1 ([2, 3, 1, 2], 4, 4, (-4 : Int)).2.1
      ([2, 3, 1, 2], 4, 4, (-4 : Int)).2.2.1 ([2, 3, 1, 2], 4, 4, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s201.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 1, 2] 4 4 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s201
theorem z7UnaryRows5_s202 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 2, 0] 5 5 (-7 : Int))
    (z7UnaryCode5_s202.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s202_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 2, 0], 5, 5, (-7 : Int)).1 ([2, 3, 2, 0], 5, 5, (-7 : Int)).2.1
      ([2, 3, 2, 0], 5, 5, (-7 : Int)).2.2.1 ([2, 3, 2, 0], 5, 5, (-7 : Int)).2.2.2 =
    z7UnaryCode5_s202.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 2, 0] 5 5 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s202
theorem z7UnaryRows5_s203 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 2, 1] 4 4 (-6 : Int))
    (z7UnaryCode5_s203.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s203_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 2, 1], 4, 4, (-6 : Int)).1 ([2, 3, 2, 1], 4, 4, (-6 : Int)).2.1
      ([2, 3, 2, 1], 4, 4, (-6 : Int)).2.2.1 ([2, 3, 2, 1], 4, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s203.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 2, 1] 4 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s203
theorem z7UnaryRows5_s204 : rowsBeq
    (z7GenRow 8 5 4 [2, 3, 2, 2] 3 1 (-5 : Int))
    (z7UnaryCode5_s204.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s204_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([2, 3, 2, 2], 3, 1, (-5 : Int)).1 ([2, 3, 2, 2], 3, 1, (-5 : Int)).2.1
      ([2, 3, 2, 2], 3, 1, (-5 : Int)).2.2.1 ([2, 3, 2, 2], 3, 1, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s204.map z7DecodeRow := by
  show z7GenRow 8 5 4 [2, 3, 2, 2] 3 1 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s204
theorem z7UnaryRows5_s205 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 0, 0] 9 13 (-3 : Int))
    (z7UnaryCode5_s205.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s205_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 0, 0], 9, 13, (-3 : Int)).1 ([3, 0, 0, 0], 9, 13, (-3 : Int)).2.1
      ([3, 0, 0, 0], 9, 13, (-3 : Int)).2.2.1 ([3, 0, 0, 0], 9, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s205.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 0, 0] 9 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s205
theorem z7UnaryRows5_s206 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 0, 1] 8 12 (-2 : Int))
    (z7UnaryCode5_s206.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s206_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 0, 1], 8, 12, (-2 : Int)).1 ([3, 0, 0, 1], 8, 12, (-2 : Int)).2.1
      ([3, 0, 0, 1], 8, 12, (-2 : Int)).2.2.1 ([3, 0, 0, 1], 8, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s206.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 0, 1] 8 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s206
theorem z7UnaryRows5_s207 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 0, 2] 7 9 (-1 : Int))
    (z7UnaryCode5_s207.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s207_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 0, 2], 7, 9, (-1 : Int)).1 ([3, 0, 0, 2], 7, 9, (-1 : Int)).2.1
      ([3, 0, 0, 2], 7, 9, (-1 : Int)).2.2.1 ([3, 0, 0, 2], 7, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s207.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 0, 2] 7 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s207
theorem z7UnaryRows5_s208 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 0, 3] 6 4 (0 : Int))
    (z7UnaryCode5_s208.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s208_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 0, 3], 6, 4, (0 : Int)).1 ([3, 0, 0, 3], 6, 4, (0 : Int)).2.1
      ([3, 0, 0, 3], 6, 4, (0 : Int)).2.2.1 ([3, 0, 0, 3], 6, 4, (0 : Int)).2.2.2 =
    z7UnaryCode5_s208.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 0, 3] 6 4 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s208
theorem z7UnaryRows5_s209 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 1, 0] 8 12 (-4 : Int))
    (z7UnaryCode5_s209.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s209_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 1, 0], 8, 12, (-4 : Int)).1 ([3, 0, 1, 0], 8, 12, (-4 : Int)).2.1
      ([3, 0, 1, 0], 8, 12, (-4 : Int)).2.2.1 ([3, 0, 1, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s209.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 1, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s209
theorem z7UnaryRows5_s210 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 1, 1] 7 11 (-3 : Int))
    (z7UnaryCode5_s210.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s210_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 1, 1], 7, 11, (-3 : Int)).1 ([3, 0, 1, 1], 7, 11, (-3 : Int)).2.1
      ([3, 0, 1, 1], 7, 11, (-3 : Int)).2.2.1 ([3, 0, 1, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s210.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 1, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s210
theorem z7UnaryRows5_s211 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 1, 2] 6 8 (-2 : Int))
    (z7UnaryCode5_s211.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s211_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 1, 2], 6, 8, (-2 : Int)).1 ([3, 0, 1, 2], 6, 8, (-2 : Int)).2.1
      ([3, 0, 1, 2], 6, 8, (-2 : Int)).2.2.1 ([3, 0, 1, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s211.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 1, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s211
theorem z7UnaryRows5_s212 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 1, 3] 5 3 (-1 : Int))
    (z7UnaryCode5_s212.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s212_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 1, 3], 5, 3, (-1 : Int)).1 ([3, 0, 1, 3], 5, 3, (-1 : Int)).2.1
      ([3, 0, 1, 3], 5, 3, (-1 : Int)).2.2.1 ([3, 0, 1, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s212.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 1, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s212
theorem z7UnaryRows5_s213 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 2, 0] 7 9 (-5 : Int))
    (z7UnaryCode5_s213.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s213_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 2, 0], 7, 9, (-5 : Int)).1 ([3, 0, 2, 0], 7, 9, (-5 : Int)).2.1
      ([3, 0, 2, 0], 7, 9, (-5 : Int)).2.2.1 ([3, 0, 2, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s213.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 2, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s213
theorem z7UnaryRows5_s214 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 2, 1] 6 8 (-4 : Int))
    (z7UnaryCode5_s214.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s214_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 2, 1], 6, 8, (-4 : Int)).1 ([3, 0, 2, 1], 6, 8, (-4 : Int)).2.1
      ([3, 0, 2, 1], 6, 8, (-4 : Int)).2.2.1 ([3, 0, 2, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s214.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 2, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s214
theorem z7UnaryRows5_s215 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 2, 2] 5 5 (-3 : Int))
    (z7UnaryCode5_s215.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s215_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 2, 2], 5, 5, (-3 : Int)).1 ([3, 0, 2, 2], 5, 5, (-3 : Int)).2.1
      ([3, 0, 2, 2], 5, 5, (-3 : Int)).2.2.1 ([3, 0, 2, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s215.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 2, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s215
theorem z7UnaryRows5_s216 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 2, 3] 4 0 (-2 : Int))
    (z7UnaryCode5_s216.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s216_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 2, 3], 4, 0, (-2 : Int)).1 ([3, 0, 2, 3], 4, 0, (-2 : Int)).2.1
      ([3, 0, 2, 3], 4, 0, (-2 : Int)).2.2.1 ([3, 0, 2, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s216.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 2, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s216
theorem z7UnaryRows5_s217 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 3, 0] 6 4 (-6 : Int))
    (z7UnaryCode5_s217.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s217_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 3, 0], 6, 4, (-6 : Int)).1 ([3, 0, 3, 0], 6, 4, (-6 : Int)).2.1
      ([3, 0, 3, 0], 6, 4, (-6 : Int)).2.2.1 ([3, 0, 3, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s217.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 3, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s217
theorem z7UnaryRows5_s218 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 3, 1] 5 3 (-5 : Int))
    (z7UnaryCode5_s218.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s218_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 3, 1], 5, 3, (-5 : Int)).1 ([3, 0, 3, 1], 5, 3, (-5 : Int)).2.1
      ([3, 0, 3, 1], 5, 3, (-5 : Int)).2.2.1 ([3, 0, 3, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s218.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 3, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s218
theorem z7UnaryRows5_s219 : rowsBeq
    (z7GenRow 8 5 4 [3, 0, 3, 2] 4 0 (-4 : Int))
    (z7UnaryCode5_s219.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s219_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 0, 3, 2], 4, 0, (-4 : Int)).1 ([3, 0, 3, 2], 4, 0, (-4 : Int)).2.1
      ([3, 0, 3, 2], 4, 0, (-4 : Int)).2.2.1 ([3, 0, 3, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s219.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 0, 3, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s219
theorem z7UnaryRows5_s220 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 0, 0] 8 12 (-4 : Int))
    (z7UnaryCode5_s220.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s220_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 0, 0], 8, 12, (-4 : Int)).1 ([3, 1, 0, 0], 8, 12, (-4 : Int)).2.1
      ([3, 1, 0, 0], 8, 12, (-4 : Int)).2.2.1 ([3, 1, 0, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s220.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 0, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s220
theorem z7UnaryRows5_s221 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 0, 1] 7 11 (-3 : Int))
    (z7UnaryCode5_s221.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s221_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 0, 1], 7, 11, (-3 : Int)).1 ([3, 1, 0, 1], 7, 11, (-3 : Int)).2.1
      ([3, 1, 0, 1], 7, 11, (-3 : Int)).2.2.1 ([3, 1, 0, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s221.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 0, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s221
theorem z7UnaryRows5_s222 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 0, 2] 6 8 (-2 : Int))
    (z7UnaryCode5_s222.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s222_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 0, 2], 6, 8, (-2 : Int)).1 ([3, 1, 0, 2], 6, 8, (-2 : Int)).2.1
      ([3, 1, 0, 2], 6, 8, (-2 : Int)).2.2.1 ([3, 1, 0, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s222.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 0, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s222
theorem z7UnaryRows5_s223 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 0, 3] 5 3 (-1 : Int))
    (z7UnaryCode5_s223.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s223_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 0, 3], 5, 3, (-1 : Int)).1 ([3, 1, 0, 3], 5, 3, (-1 : Int)).2.1
      ([3, 1, 0, 3], 5, 3, (-1 : Int)).2.2.1 ([3, 1, 0, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode5_s223.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 0, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s223
theorem z7UnaryRows5_s224 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 1, 0] 7 11 (-5 : Int))
    (z7UnaryCode5_s224.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s224_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 1, 0], 7, 11, (-5 : Int)).1 ([3, 1, 1, 0], 7, 11, (-5 : Int)).2.1
      ([3, 1, 1, 0], 7, 11, (-5 : Int)).2.2.1 ([3, 1, 1, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s224.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 1, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s224
theorem z7UnaryRows5_s225 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 1, 1] 6 10 (-4 : Int))
    (z7UnaryCode5_s225.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s225_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 1, 1], 6, 10, (-4 : Int)).1 ([3, 1, 1, 1], 6, 10, (-4 : Int)).2.1
      ([3, 1, 1, 1], 6, 10, (-4 : Int)).2.2.1 ([3, 1, 1, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s225.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 1, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s225
theorem z7UnaryRows5_s226 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 1, 2] 5 7 (-3 : Int))
    (z7UnaryCode5_s226.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s226_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 1, 2], 5, 7, (-3 : Int)).1 ([3, 1, 1, 2], 5, 7, (-3 : Int)).2.1
      ([3, 1, 1, 2], 5, 7, (-3 : Int)).2.2.1 ([3, 1, 1, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s226.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 1, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s226
theorem z7UnaryRows5_s227 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 1, 3] 4 2 (-2 : Int))
    (z7UnaryCode5_s227.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s227_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 1, 3], 4, 2, (-2 : Int)).1 ([3, 1, 1, 3], 4, 2, (-2 : Int)).2.1
      ([3, 1, 1, 3], 4, 2, (-2 : Int)).2.2.1 ([3, 1, 1, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s227.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 1, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s227
theorem z7UnaryRows5_s228 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 2, 0] 6 8 (-6 : Int))
    (z7UnaryCode5_s228.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s228_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 2, 0], 6, 8, (-6 : Int)).1 ([3, 1, 2, 0], 6, 8, (-6 : Int)).2.1
      ([3, 1, 2, 0], 6, 8, (-6 : Int)).2.2.1 ([3, 1, 2, 0], 6, 8, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s228.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 2, 0] 6 8 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s228
theorem z7UnaryRows5_s229 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 2, 1] 5 7 (-5 : Int))
    (z7UnaryCode5_s229.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s229_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 2, 1], 5, 7, (-5 : Int)).1 ([3, 1, 2, 1], 5, 7, (-5 : Int)).2.1
      ([3, 1, 2, 1], 5, 7, (-5 : Int)).2.2.1 ([3, 1, 2, 1], 5, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s229.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 2, 1] 5 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s229
theorem z7UnaryRows5_s230 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 2, 2] 4 4 (-4 : Int))
    (z7UnaryCode5_s230.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s230_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 2, 2], 4, 4, (-4 : Int)).1 ([3, 1, 2, 2], 4, 4, (-4 : Int)).2.1
      ([3, 1, 2, 2], 4, 4, (-4 : Int)).2.2.1 ([3, 1, 2, 2], 4, 4, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s230.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 2, 2] 4 4 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s230
theorem z7UnaryRows5_s231 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 3, 0] 5 3 (-7 : Int))
    (z7UnaryCode5_s231.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s231_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 3, 0], 5, 3, (-7 : Int)).1 ([3, 1, 3, 0], 5, 3, (-7 : Int)).2.1
      ([3, 1, 3, 0], 5, 3, (-7 : Int)).2.2.1 ([3, 1, 3, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode5_s231.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 3, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s231
theorem z7UnaryRows5_s232 : rowsBeq
    (z7GenRow 8 5 4 [3, 1, 3, 1] 4 2 (-6 : Int))
    (z7UnaryCode5_s232.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s232_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 1, 3, 1], 4, 2, (-6 : Int)).1 ([3, 1, 3, 1], 4, 2, (-6 : Int)).2.1
      ([3, 1, 3, 1], 4, 2, (-6 : Int)).2.2.1 ([3, 1, 3, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s232.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 1, 3, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s232
theorem z7UnaryRows5_s233 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 0, 0] 7 9 (-5 : Int))
    (z7UnaryCode5_s233.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s233_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 0, 0], 7, 9, (-5 : Int)).1 ([3, 2, 0, 0], 7, 9, (-5 : Int)).2.1
      ([3, 2, 0, 0], 7, 9, (-5 : Int)).2.2.1 ([3, 2, 0, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s233.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 0, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s233
theorem z7UnaryRows5_s234 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 0, 1] 6 8 (-4 : Int))
    (z7UnaryCode5_s234.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s234_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 0, 1], 6, 8, (-4 : Int)).1 ([3, 2, 0, 1], 6, 8, (-4 : Int)).2.1
      ([3, 2, 0, 1], 6, 8, (-4 : Int)).2.2.1 ([3, 2, 0, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s234.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 0, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s234
theorem z7UnaryRows5_s235 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 0, 2] 5 5 (-3 : Int))
    (z7UnaryCode5_s235.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s235_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 0, 2], 5, 5, (-3 : Int)).1 ([3, 2, 0, 2], 5, 5, (-3 : Int)).2.1
      ([3, 2, 0, 2], 5, 5, (-3 : Int)).2.2.1 ([3, 2, 0, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode5_s235.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 0, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s235
theorem z7UnaryRows5_s236 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 0, 3] 4 0 (-2 : Int))
    (z7UnaryCode5_s236.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s236_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 0, 3], 4, 0, (-2 : Int)).1 ([3, 2, 0, 3], 4, 0, (-2 : Int)).2.1
      ([3, 2, 0, 3], 4, 0, (-2 : Int)).2.2.1 ([3, 2, 0, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode5_s236.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 0, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s236
theorem z7UnaryRows5_s237 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 1, 0] 6 8 (-6 : Int))
    (z7UnaryCode5_s237.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s237_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 1, 0], 6, 8, (-6 : Int)).1 ([3, 2, 1, 0], 6, 8, (-6 : Int)).2.1
      ([3, 2, 1, 0], 6, 8, (-6 : Int)).2.2.1 ([3, 2, 1, 0], 6, 8, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s237.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 1, 0] 6 8 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s237
theorem z7UnaryRows5_s238 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 1, 1] 5 7 (-5 : Int))
    (z7UnaryCode5_s238.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s238_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 1, 1], 5, 7, (-5 : Int)).1 ([3, 2, 1, 1], 5, 7, (-5 : Int)).2.1
      ([3, 2, 1, 1], 5, 7, (-5 : Int)).2.2.1 ([3, 2, 1, 1], 5, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s238.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 1, 1] 5 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s238
theorem z7UnaryRows5_s239 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 1, 2] 4 4 (-4 : Int))
    (z7UnaryCode5_s239.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s239_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 1, 2], 4, 4, (-4 : Int)).1 ([3, 2, 1, 2], 4, 4, (-4 : Int)).2.1
      ([3, 2, 1, 2], 4, 4, (-4 : Int)).2.2.1 ([3, 2, 1, 2], 4, 4, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s239.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 1, 2] 4 4 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s239
theorem z7UnaryRows5_s240 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 2, 0] 5 5 (-7 : Int))
    (z7UnaryCode5_s240.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s240_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 2, 0], 5, 5, (-7 : Int)).1 ([3, 2, 2, 0], 5, 5, (-7 : Int)).2.1
      ([3, 2, 2, 0], 5, 5, (-7 : Int)).2.2.1 ([3, 2, 2, 0], 5, 5, (-7 : Int)).2.2.2 =
    z7UnaryCode5_s240.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 2, 0] 5 5 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s240
theorem z7UnaryRows5_s241 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 2, 1] 4 4 (-6 : Int))
    (z7UnaryCode5_s241.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s241_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 2, 1], 4, 4, (-6 : Int)).1 ([3, 2, 2, 1], 4, 4, (-6 : Int)).2.1
      ([3, 2, 2, 1], 4, 4, (-6 : Int)).2.2.1 ([3, 2, 2, 1], 4, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s241.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 2, 1] 4 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s241
theorem z7UnaryRows5_s242 : rowsBeq
    (z7GenRow 8 5 4 [3, 2, 2, 2] 3 1 (-5 : Int))
    (z7UnaryCode5_s242.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s242_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 2, 2, 2], 3, 1, (-5 : Int)).1 ([3, 2, 2, 2], 3, 1, (-5 : Int)).2.1
      ([3, 2, 2, 2], 3, 1, (-5 : Int)).2.2.1 ([3, 2, 2, 2], 3, 1, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s242.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 2, 2, 2] 3 1 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s242
theorem z7UnaryRows5_s243 : rowsBeq
    (z7GenRow 8 5 4 [3, 3, 0, 0] 6 4 (-6 : Int))
    (z7UnaryCode5_s243.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s243_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 3, 0, 0], 6, 4, (-6 : Int)).1 ([3, 3, 0, 0], 6, 4, (-6 : Int)).2.1
      ([3, 3, 0, 0], 6, 4, (-6 : Int)).2.2.1 ([3, 3, 0, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s243.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 3, 0, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s243
theorem z7UnaryRows5_s244 : rowsBeq
    (z7GenRow 8 5 4 [3, 3, 0, 1] 5 3 (-5 : Int))
    (z7UnaryCode5_s244.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s244_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 3, 0, 1], 5, 3, (-5 : Int)).1 ([3, 3, 0, 1], 5, 3, (-5 : Int)).2.1
      ([3, 3, 0, 1], 5, 3, (-5 : Int)).2.2.1 ([3, 3, 0, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s244.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 3, 0, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s244
theorem z7UnaryRows5_s245 : rowsBeq
    (z7GenRow 8 5 4 [3, 3, 0, 2] 4 0 (-4 : Int))
    (z7UnaryCode5_s245.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s245_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 3, 0, 2], 4, 0, (-4 : Int)).1 ([3, 3, 0, 2], 4, 0, (-4 : Int)).2.1
      ([3, 3, 0, 2], 4, 0, (-4 : Int)).2.2.1 ([3, 3, 0, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s245.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 3, 0, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s245
theorem z7UnaryRows5_s246 : rowsBeq
    (z7GenRow 8 5 4 [3, 3, 1, 0] 5 3 (-7 : Int))
    (z7UnaryCode5_s246.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s246_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 3, 1, 0], 5, 3, (-7 : Int)).1 ([3, 3, 1, 0], 5, 3, (-7 : Int)).2.1
      ([3, 3, 1, 0], 5, 3, (-7 : Int)).2.2.1 ([3, 3, 1, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode5_s246.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 3, 1, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s246
theorem z7UnaryRows5_s247 : rowsBeq
    (z7GenRow 8 5 4 [3, 3, 1, 1] 4 2 (-6 : Int))
    (z7UnaryCode5_s247.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s247_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([3, 3, 1, 1], 4, 2, (-6 : Int)).1 ([3, 3, 1, 1], 4, 2, (-6 : Int)).2.1
      ([3, 3, 1, 1], 4, 2, (-6 : Int)).2.2.1 ([3, 3, 1, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s247.map z7DecodeRow := by
  show z7GenRow 8 5 4 [3, 3, 1, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s247
theorem z7UnaryRows5_s248 : rowsBeq
    (z7GenRow 8 5 4 [4, 1, 1, 0] 6 4 (-6 : Int))
    (z7UnaryCode5_s248.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s248_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([4, 1, 1, 0], 6, 4, (-6 : Int)).1 ([4, 1, 1, 0], 6, 4, (-6 : Int)).2.1
      ([4, 1, 1, 0], 6, 4, (-6 : Int)).2.2.1 ([4, 1, 1, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode5_s248.map z7DecodeRow := by
  show z7GenRow 8 5 4 [4, 1, 1, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s248
theorem z7UnaryRows5_s249 : rowsBeq
    (z7GenRow 8 5 4 [4, 1, 1, 1] 5 3 (-5 : Int))
    (z7UnaryCode5_s249.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s249_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([4, 1, 1, 1], 5, 3, (-5 : Int)).1 ([4, 1, 1, 1], 5, 3, (-5 : Int)).2.1
      ([4, 1, 1, 1], 5, 3, (-5 : Int)).2.2.1 ([4, 1, 1, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode5_s249.map z7DecodeRow := by
  show z7GenRow 8 5 4 [4, 1, 1, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s249
theorem z7UnaryRows5_s250 : rowsBeq
    (z7GenRow 8 5 4 [4, 1, 1, 2] 4 0 (-4 : Int))
    (z7UnaryCode5_s250.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows5_s250_eq :
    z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) ([4, 1, 1, 2], 4, 0, (-4 : Int)).1 ([4, 1, 1, 2], 4, 0, (-4 : Int)).2.1
      ([4, 1, 1, 2], 4, 0, (-4 : Int)).2.2.1 ([4, 1, 1, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode5_s250.map z7DecodeRow := by
  show z7GenRow 8 5 4 [4, 1, 1, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows5_s250

/-- flatMap of state group 0 equals the joined decoded slices. -/
theorem z7Grp_5_0 :
    ([([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s0.map z7DecodeRow ++ (z7UnaryCode5_s1.map z7DecodeRow ++ (z7UnaryCode5_s2.map z7DecodeRow ++ (z7UnaryCode5_s3.map z7DecodeRow ++ (z7UnaryCode5_s4.map z7DecodeRow ++ (z7UnaryCode5_s5.map z7DecodeRow ++ (z7UnaryCode5_s6.map z7DecodeRow ++ (z7UnaryCode5_s7.map z7DecodeRow ++ (z7UnaryCode5_s8.map z7DecodeRow ++ (z7UnaryCode5_s9.map z7DecodeRow ++ (z7UnaryCode5_s10.map z7DecodeRow ++ (z7UnaryCode5_s11.map z7DecodeRow ++ (z7UnaryCode5_s12.map z7DecodeRow ++ (z7UnaryCode5_s13.map z7DecodeRow ++ (z7UnaryCode5_s14.map z7DecodeRow ++ (z7UnaryCode5_s15.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s0_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s1_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s2_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s3_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s4_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s5_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s6_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s7_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s8_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s9_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s10_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s11_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s12_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s13_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s14_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s15_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 1 equals the joined decoded slices. -/
theorem z7Grp_5_1 :
    ([([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 1, 0, 0], 11, 21, (-1 : Int)), ([0, 1, 0, 1], 10, 20, (0 : Int)), ([0, 1, 0, 2], 9, 17, (1 : Int)), ([0, 1, 0, 3], 8, 12, (2 : Int)), ([0, 1, 0, 4], 7, 5, (3 : Int)), ([0, 1, 1, 0], 10, 20, (-2 : Int)), ([0, 1, 1, 1], 9, 19, (-1 : Int)), ([0, 1, 1, 2], 8, 16, (0 : Int)), ([0, 1, 1, 3], 7, 11, (1 : Int)), ([0, 1, 1, 4], 6, 4, (2 : Int)), ([0, 1, 2, 0], 9, 17, (-3 : Int)), ([0, 1, 2, 1], 8, 16, (-2 : Int)), ([0, 1, 2, 2], 7, 13, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s16.map z7DecodeRow ++ (z7UnaryCode5_s17.map z7DecodeRow ++ (z7UnaryCode5_s18.map z7DecodeRow ++ (z7UnaryCode5_s19.map z7DecodeRow ++ (z7UnaryCode5_s20.map z7DecodeRow ++ (z7UnaryCode5_s21.map z7DecodeRow ++ (z7UnaryCode5_s22.map z7DecodeRow ++ (z7UnaryCode5_s23.map z7DecodeRow ++ (z7UnaryCode5_s24.map z7DecodeRow ++ (z7UnaryCode5_s25.map z7DecodeRow ++ (z7UnaryCode5_s26.map z7DecodeRow ++ (z7UnaryCode5_s27.map z7DecodeRow ++ (z7UnaryCode5_s28.map z7DecodeRow ++ (z7UnaryCode5_s29.map z7DecodeRow ++ (z7UnaryCode5_s30.map z7DecodeRow ++ (z7UnaryCode5_s31.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s16_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s17_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s18_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s19_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s20_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s21_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s22_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s23_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s24_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s25_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s26_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s27_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s28_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s29_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s30_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s31_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 2 equals the joined decoded slices. -/
theorem z7Grp_5_2 :
    ([([0, 1, 2, 3], 6, 8, (0 : Int)), ([0, 1, 2, 4], 5, 1, (1 : Int)), ([0, 1, 3, 0], 8, 12, (-4 : Int)), ([0, 1, 3, 1], 7, 11, (-3 : Int)), ([0, 1, 3, 2], 6, 8, (-2 : Int)), ([0, 1, 3, 3], 5, 3, (-1 : Int)), ([0, 2, 0, 0], 10, 18, (-2 : Int)), ([0, 2, 0, 1], 9, 17, (-1 : Int)), ([0, 2, 0, 2], 8, 14, (0 : Int)), ([0, 2, 0, 3], 7, 9, (1 : Int)), ([0, 2, 0, 4], 6, 2, (2 : Int)), ([0, 2, 1, 0], 9, 17, (-3 : Int)), ([0, 2, 1, 1], 8, 16, (-2 : Int)), ([0, 2, 1, 2], 7, 13, (-1 : Int)), ([0, 2, 1, 3], 6, 8, (0 : Int)), ([0, 2, 1, 4], 5, 1, (1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s32.map z7DecodeRow ++ (z7UnaryCode5_s33.map z7DecodeRow ++ (z7UnaryCode5_s34.map z7DecodeRow ++ (z7UnaryCode5_s35.map z7DecodeRow ++ (z7UnaryCode5_s36.map z7DecodeRow ++ (z7UnaryCode5_s37.map z7DecodeRow ++ (z7UnaryCode5_s38.map z7DecodeRow ++ (z7UnaryCode5_s39.map z7DecodeRow ++ (z7UnaryCode5_s40.map z7DecodeRow ++ (z7UnaryCode5_s41.map z7DecodeRow ++ (z7UnaryCode5_s42.map z7DecodeRow ++ (z7UnaryCode5_s43.map z7DecodeRow ++ (z7UnaryCode5_s44.map z7DecodeRow ++ (z7UnaryCode5_s45.map z7DecodeRow ++ (z7UnaryCode5_s46.map z7DecodeRow ++ (z7UnaryCode5_s47.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s32_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s33_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s34_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s35_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s36_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s37_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s38_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s39_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s40_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s41_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s42_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s43_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s44_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s45_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s46_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s47_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 3 equals the joined decoded slices. -/
theorem z7Grp_5_3 :
    ([([0, 2, 2, 0], 8, 14, (-4 : Int)), ([0, 2, 2, 1], 7, 13, (-3 : Int)), ([0, 2, 2, 2], 6, 10, (-2 : Int)), ([0, 2, 2, 3], 5, 5, (-1 : Int)), ([0, 2, 3, 0], 7, 9, (-5 : Int)), ([0, 2, 3, 1], 6, 8, (-4 : Int)), ([0, 2, 3, 2], 5, 5, (-3 : Int)), ([0, 2, 3, 3], 4, 0, (-2 : Int)), ([0, 3, 0, 0], 9, 13, (-3 : Int)), ([0, 3, 0, 1], 8, 12, (-2 : Int)), ([0, 3, 0, 2], 7, 9, (-1 : Int)), ([0, 3, 0, 3], 6, 4, (0 : Int)), ([0, 3, 1, 0], 8, 12, (-4 : Int)), ([0, 3, 1, 1], 7, 11, (-3 : Int)), ([0, 3, 1, 2], 6, 8, (-2 : Int)), ([0, 3, 1, 3], 5, 3, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s48.map z7DecodeRow ++ (z7UnaryCode5_s49.map z7DecodeRow ++ (z7UnaryCode5_s50.map z7DecodeRow ++ (z7UnaryCode5_s51.map z7DecodeRow ++ (z7UnaryCode5_s52.map z7DecodeRow ++ (z7UnaryCode5_s53.map z7DecodeRow ++ (z7UnaryCode5_s54.map z7DecodeRow ++ (z7UnaryCode5_s55.map z7DecodeRow ++ (z7UnaryCode5_s56.map z7DecodeRow ++ (z7UnaryCode5_s57.map z7DecodeRow ++ (z7UnaryCode5_s58.map z7DecodeRow ++ (z7UnaryCode5_s59.map z7DecodeRow ++ (z7UnaryCode5_s60.map z7DecodeRow ++ (z7UnaryCode5_s61.map z7DecodeRow ++ (z7UnaryCode5_s62.map z7DecodeRow ++ (z7UnaryCode5_s63.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s48_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s49_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s50_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s51_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s52_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s53_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s54_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s55_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s56_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s57_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s58_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s59_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s60_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s61_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s62_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s63_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 4 equals the joined decoded slices. -/
theorem z7Grp_5_4 :
    ([([0, 3, 2, 0], 7, 9, (-5 : Int)), ([0, 3, 2, 1], 6, 8, (-4 : Int)), ([0, 3, 2, 2], 5, 5, (-3 : Int)), ([0, 3, 2, 3], 4, 0, (-2 : Int)), ([0, 3, 3, 0], 6, 4, (-6 : Int)), ([0, 3, 3, 1], 5, 3, (-5 : Int)), ([0, 3, 3, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s64.map z7DecodeRow ++ (z7UnaryCode5_s65.map z7DecodeRow ++ (z7UnaryCode5_s66.map z7DecodeRow ++ (z7UnaryCode5_s67.map z7DecodeRow ++ (z7UnaryCode5_s68.map z7DecodeRow ++ (z7UnaryCode5_s69.map z7DecodeRow ++ (z7UnaryCode5_s70.map z7DecodeRow ++ (z7UnaryCode5_s71.map z7DecodeRow ++ (z7UnaryCode5_s72.map z7DecodeRow ++ (z7UnaryCode5_s73.map z7DecodeRow ++ (z7UnaryCode5_s74.map z7DecodeRow ++ (z7UnaryCode5_s75.map z7DecodeRow ++ (z7UnaryCode5_s76.map z7DecodeRow ++ (z7UnaryCode5_s77.map z7DecodeRow ++ (z7UnaryCode5_s78.map z7DecodeRow ++ (z7UnaryCode5_s79.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s64_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s65_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s66_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s67_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s68_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s69_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s70_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s71_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s72_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s73_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s74_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s75_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s76_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s77_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s78_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s79_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 5 equals the joined decoded slices. -/
theorem z7Grp_5_5 :
    ([([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int)), ([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 1, 0, 0], 10, 20, (-2 : Int)), ([1, 1, 0, 1], 9, 19, (-1 : Int)), ([1, 1, 0, 2], 8, 16, (0 : Int)), ([1, 1, 0, 3], 7, 11, (1 : Int)), ([1, 1, 0, 4], 6, 4, (2 : Int)), ([1, 1, 1, 0], 9, 19, (-3 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s80.map z7DecodeRow ++ (z7UnaryCode5_s81.map z7DecodeRow ++ (z7UnaryCode5_s82.map z7DecodeRow ++ (z7UnaryCode5_s83.map z7DecodeRow ++ (z7UnaryCode5_s84.map z7DecodeRow ++ (z7UnaryCode5_s85.map z7DecodeRow ++ (z7UnaryCode5_s86.map z7DecodeRow ++ (z7UnaryCode5_s87.map z7DecodeRow ++ (z7UnaryCode5_s88.map z7DecodeRow ++ (z7UnaryCode5_s89.map z7DecodeRow ++ (z7UnaryCode5_s90.map z7DecodeRow ++ (z7UnaryCode5_s91.map z7DecodeRow ++ (z7UnaryCode5_s92.map z7DecodeRow ++ (z7UnaryCode5_s93.map z7DecodeRow ++ (z7UnaryCode5_s94.map z7DecodeRow ++ (z7UnaryCode5_s95.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s80_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s81_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s82_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s83_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s84_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s85_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s86_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s87_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s88_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s89_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s90_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s91_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s92_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s93_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s94_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s95_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 6 equals the joined decoded slices. -/
theorem z7Grp_5_6 :
    ([([1, 1, 1, 1], 8, 18, (-2 : Int)), ([1, 1, 1, 2], 7, 15, (-1 : Int)), ([1, 1, 1, 3], 6, 10, (0 : Int)), ([1, 1, 1, 4], 5, 3, (1 : Int)), ([1, 1, 2, 0], 8, 16, (-4 : Int)), ([1, 1, 2, 1], 7, 15, (-3 : Int)), ([1, 1, 2, 2], 6, 12, (-2 : Int)), ([1, 1, 2, 3], 5, 7, (-1 : Int)), ([1, 1, 2, 4], 4, 0, (0 : Int)), ([1, 1, 3, 0], 7, 11, (-5 : Int)), ([1, 1, 3, 1], 6, 10, (-4 : Int)), ([1, 1, 3, 2], 5, 7, (-3 : Int)), ([1, 1, 3, 3], 4, 2, (-2 : Int)), ([1, 1, 4, 0], 6, 4, (-6 : Int)), ([1, 1, 4, 1], 5, 3, (-5 : Int)), ([1, 1, 4, 2], 4, 0, (-4 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s96.map z7DecodeRow ++ (z7UnaryCode5_s97.map z7DecodeRow ++ (z7UnaryCode5_s98.map z7DecodeRow ++ (z7UnaryCode5_s99.map z7DecodeRow ++ (z7UnaryCode5_s100.map z7DecodeRow ++ (z7UnaryCode5_s101.map z7DecodeRow ++ (z7UnaryCode5_s102.map z7DecodeRow ++ (z7UnaryCode5_s103.map z7DecodeRow ++ (z7UnaryCode5_s104.map z7DecodeRow ++ (z7UnaryCode5_s105.map z7DecodeRow ++ (z7UnaryCode5_s106.map z7DecodeRow ++ (z7UnaryCode5_s107.map z7DecodeRow ++ (z7UnaryCode5_s108.map z7DecodeRow ++ (z7UnaryCode5_s109.map z7DecodeRow ++ (z7UnaryCode5_s110.map z7DecodeRow ++ (z7UnaryCode5_s111.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s96_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s97_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s98_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s99_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s100_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s101_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s102_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s103_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s104_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s105_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s106_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s107_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s108_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s109_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s110_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s111_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 7 equals the joined decoded slices. -/
theorem z7Grp_5_7 :
    ([([1, 2, 0, 0], 9, 17, (-3 : Int)), ([1, 2, 0, 1], 8, 16, (-2 : Int)), ([1, 2, 0, 2], 7, 13, (-1 : Int)), ([1, 2, 0, 3], 6, 8, (0 : Int)), ([1, 2, 0, 4], 5, 1, (1 : Int)), ([1, 2, 1, 0], 8, 16, (-4 : Int)), ([1, 2, 1, 1], 7, 15, (-3 : Int)), ([1, 2, 1, 2], 6, 12, (-2 : Int)), ([1, 2, 1, 3], 5, 7, (-1 : Int)), ([1, 2, 1, 4], 4, 0, (0 : Int)), ([1, 2, 2, 0], 7, 13, (-5 : Int)), ([1, 2, 2, 1], 6, 12, (-4 : Int)), ([1, 2, 2, 2], 5, 9, (-3 : Int)), ([1, 2, 2, 3], 4, 4, (-2 : Int)), ([1, 2, 3, 0], 6, 8, (-6 : Int)), ([1, 2, 3, 1], 5, 7, (-5 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s112.map z7DecodeRow ++ (z7UnaryCode5_s113.map z7DecodeRow ++ (z7UnaryCode5_s114.map z7DecodeRow ++ (z7UnaryCode5_s115.map z7DecodeRow ++ (z7UnaryCode5_s116.map z7DecodeRow ++ (z7UnaryCode5_s117.map z7DecodeRow ++ (z7UnaryCode5_s118.map z7DecodeRow ++ (z7UnaryCode5_s119.map z7DecodeRow ++ (z7UnaryCode5_s120.map z7DecodeRow ++ (z7UnaryCode5_s121.map z7DecodeRow ++ (z7UnaryCode5_s122.map z7DecodeRow ++ (z7UnaryCode5_s123.map z7DecodeRow ++ (z7UnaryCode5_s124.map z7DecodeRow ++ (z7UnaryCode5_s125.map z7DecodeRow ++ (z7UnaryCode5_s126.map z7DecodeRow ++ (z7UnaryCode5_s127.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s112_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s113_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s114_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s115_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s116_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s117_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s118_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s119_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s120_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s121_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s122_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s123_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s124_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s125_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s126_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s127_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 8 equals the joined decoded slices. -/
theorem z7Grp_5_8 :
    ([([1, 2, 3, 2], 4, 4, (-4 : Int)), ([1, 3, 0, 0], 8, 12, (-4 : Int)), ([1, 3, 0, 1], 7, 11, (-3 : Int)), ([1, 3, 0, 2], 6, 8, (-2 : Int)), ([1, 3, 0, 3], 5, 3, (-1 : Int)), ([1, 3, 1, 0], 7, 11, (-5 : Int)), ([1, 3, 1, 1], 6, 10, (-4 : Int)), ([1, 3, 1, 2], 5, 7, (-3 : Int)), ([1, 3, 1, 3], 4, 2, (-2 : Int)), ([1, 3, 2, 0], 6, 8, (-6 : Int)), ([1, 3, 2, 1], 5, 7, (-5 : Int)), ([1, 3, 2, 2], 4, 4, (-4 : Int)), ([1, 3, 3, 0], 5, 3, (-7 : Int)), ([1, 3, 3, 1], 4, 2, (-6 : Int)), ([1, 4, 1, 0], 6, 4, (-6 : Int)), ([1, 4, 1, 1], 5, 3, (-5 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s128.map z7DecodeRow ++ (z7UnaryCode5_s129.map z7DecodeRow ++ (z7UnaryCode5_s130.map z7DecodeRow ++ (z7UnaryCode5_s131.map z7DecodeRow ++ (z7UnaryCode5_s132.map z7DecodeRow ++ (z7UnaryCode5_s133.map z7DecodeRow ++ (z7UnaryCode5_s134.map z7DecodeRow ++ (z7UnaryCode5_s135.map z7DecodeRow ++ (z7UnaryCode5_s136.map z7DecodeRow ++ (z7UnaryCode5_s137.map z7DecodeRow ++ (z7UnaryCode5_s138.map z7DecodeRow ++ (z7UnaryCode5_s139.map z7DecodeRow ++ (z7UnaryCode5_s140.map z7DecodeRow ++ (z7UnaryCode5_s141.map z7DecodeRow ++ (z7UnaryCode5_s142.map z7DecodeRow ++ (z7UnaryCode5_s143.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s128_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s129_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s130_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s131_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s132_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s133_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s134_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s135_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s136_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s137_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s138_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s139_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s140_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s141_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s142_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s143_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 9 equals the joined decoded slices. -/
theorem z7Grp_5_9 :
    ([([1, 4, 1, 2], 4, 0, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int)), ([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s144.map z7DecodeRow ++ (z7UnaryCode5_s145.map z7DecodeRow ++ (z7UnaryCode5_s146.map z7DecodeRow ++ (z7UnaryCode5_s147.map z7DecodeRow ++ (z7UnaryCode5_s148.map z7DecodeRow ++ (z7UnaryCode5_s149.map z7DecodeRow ++ (z7UnaryCode5_s150.map z7DecodeRow ++ (z7UnaryCode5_s151.map z7DecodeRow ++ (z7UnaryCode5_s152.map z7DecodeRow ++ (z7UnaryCode5_s153.map z7DecodeRow ++ (z7UnaryCode5_s154.map z7DecodeRow ++ (z7UnaryCode5_s155.map z7DecodeRow ++ (z7UnaryCode5_s156.map z7DecodeRow ++ (z7UnaryCode5_s157.map z7DecodeRow ++ (z7UnaryCode5_s158.map z7DecodeRow ++ (z7UnaryCode5_s159.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s144_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s145_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s146_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s147_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s148_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s149_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s150_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s151_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s152_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s153_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s154_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s155_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s156_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s157_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s158_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s159_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 10 equals the joined decoded slices. -/
theorem z7Grp_5_10 :
    ([([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 1, 0, 0], 9, 17, (-3 : Int)), ([2, 1, 0, 1], 8, 16, (-2 : Int)), ([2, 1, 0, 2], 7, 13, (-1 : Int)), ([2, 1, 0, 3], 6, 8, (0 : Int)), ([2, 1, 0, 4], 5, 1, (1 : Int)), ([2, 1, 1, 0], 8, 16, (-4 : Int)), ([2, 1, 1, 1], 7, 15, (-3 : Int)), ([2, 1, 1, 2], 6, 12, (-2 : Int)), ([2, 1, 1, 3], 5, 7, (-1 : Int)), ([2, 1, 1, 4], 4, 0, (0 : Int)), ([2, 1, 2, 0], 7, 13, (-5 : Int)), ([2, 1, 2, 1], 6, 12, (-4 : Int)), ([2, 1, 2, 2], 5, 9, (-3 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s160.map z7DecodeRow ++ (z7UnaryCode5_s161.map z7DecodeRow ++ (z7UnaryCode5_s162.map z7DecodeRow ++ (z7UnaryCode5_s163.map z7DecodeRow ++ (z7UnaryCode5_s164.map z7DecodeRow ++ (z7UnaryCode5_s165.map z7DecodeRow ++ (z7UnaryCode5_s166.map z7DecodeRow ++ (z7UnaryCode5_s167.map z7DecodeRow ++ (z7UnaryCode5_s168.map z7DecodeRow ++ (z7UnaryCode5_s169.map z7DecodeRow ++ (z7UnaryCode5_s170.map z7DecodeRow ++ (z7UnaryCode5_s171.map z7DecodeRow ++ (z7UnaryCode5_s172.map z7DecodeRow ++ (z7UnaryCode5_s173.map z7DecodeRow ++ (z7UnaryCode5_s174.map z7DecodeRow ++ (z7UnaryCode5_s175.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s160_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s161_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s162_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s163_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s164_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s165_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s166_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s167_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s168_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s169_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s170_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s171_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s172_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s173_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s174_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s175_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 11 equals the joined decoded slices. -/
theorem z7Grp_5_11 :
    ([([2, 1, 2, 3], 4, 4, (-2 : Int)), ([2, 1, 3, 0], 6, 8, (-6 : Int)), ([2, 1, 3, 1], 5, 7, (-5 : Int)), ([2, 1, 3, 2], 4, 4, (-4 : Int)), ([2, 2, 0, 0], 8, 14, (-4 : Int)), ([2, 2, 0, 1], 7, 13, (-3 : Int)), ([2, 2, 0, 2], 6, 10, (-2 : Int)), ([2, 2, 0, 3], 5, 5, (-1 : Int)), ([2, 2, 1, 0], 7, 13, (-5 : Int)), ([2, 2, 1, 1], 6, 12, (-4 : Int)), ([2, 2, 1, 2], 5, 9, (-3 : Int)), ([2, 2, 1, 3], 4, 4, (-2 : Int)), ([2, 2, 2, 0], 6, 10, (-6 : Int)), ([2, 2, 2, 1], 5, 9, (-5 : Int)), ([2, 2, 2, 2], 4, 6, (-4 : Int)), ([2, 2, 2, 3], 3, 1, (-3 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s176.map z7DecodeRow ++ (z7UnaryCode5_s177.map z7DecodeRow ++ (z7UnaryCode5_s178.map z7DecodeRow ++ (z7UnaryCode5_s179.map z7DecodeRow ++ (z7UnaryCode5_s180.map z7DecodeRow ++ (z7UnaryCode5_s181.map z7DecodeRow ++ (z7UnaryCode5_s182.map z7DecodeRow ++ (z7UnaryCode5_s183.map z7DecodeRow ++ (z7UnaryCode5_s184.map z7DecodeRow ++ (z7UnaryCode5_s185.map z7DecodeRow ++ (z7UnaryCode5_s186.map z7DecodeRow ++ (z7UnaryCode5_s187.map z7DecodeRow ++ (z7UnaryCode5_s188.map z7DecodeRow ++ (z7UnaryCode5_s189.map z7DecodeRow ++ (z7UnaryCode5_s190.map z7DecodeRow ++ (z7UnaryCode5_s191.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s176_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s177_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s178_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s179_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s180_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s181_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s182_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s183_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s184_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s185_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s186_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s187_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s188_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s189_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s190_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s191_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 12 equals the joined decoded slices. -/
theorem z7Grp_5_12 :
    ([([2, 2, 3, 0], 5, 5, (-7 : Int)), ([2, 2, 3, 1], 4, 4, (-6 : Int)), ([2, 2, 3, 2], 3, 1, (-5 : Int)), ([2, 3, 0, 0], 7, 9, (-5 : Int)), ([2, 3, 0, 1], 6, 8, (-4 : Int)), ([2, 3, 0, 2], 5, 5, (-3 : Int)), ([2, 3, 0, 3], 4, 0, (-2 : Int)), ([2, 3, 1, 0], 6, 8, (-6 : Int)), ([2, 3, 1, 1], 5, 7, (-5 : Int)), ([2, 3, 1, 2], 4, 4, (-4 : Int)), ([2, 3, 2, 0], 5, 5, (-7 : Int)), ([2, 3, 2, 1], 4, 4, (-6 : Int)), ([2, 3, 2, 2], 3, 1, (-5 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s192.map z7DecodeRow ++ (z7UnaryCode5_s193.map z7DecodeRow ++ (z7UnaryCode5_s194.map z7DecodeRow ++ (z7UnaryCode5_s195.map z7DecodeRow ++ (z7UnaryCode5_s196.map z7DecodeRow ++ (z7UnaryCode5_s197.map z7DecodeRow ++ (z7UnaryCode5_s198.map z7DecodeRow ++ (z7UnaryCode5_s199.map z7DecodeRow ++ (z7UnaryCode5_s200.map z7DecodeRow ++ (z7UnaryCode5_s201.map z7DecodeRow ++ (z7UnaryCode5_s202.map z7DecodeRow ++ (z7UnaryCode5_s203.map z7DecodeRow ++ (z7UnaryCode5_s204.map z7DecodeRow ++ (z7UnaryCode5_s205.map z7DecodeRow ++ (z7UnaryCode5_s206.map z7DecodeRow ++ (z7UnaryCode5_s207.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s192_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s193_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s194_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s195_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s196_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s197_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s198_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s199_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s200_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s201_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s202_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s203_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s204_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s205_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s206_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s207_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 13 equals the joined decoded slices. -/
theorem z7Grp_5_13 :
    ([([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int)), ([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 1, 0, 0], 8, 12, (-4 : Int)), ([3, 1, 0, 1], 7, 11, (-3 : Int)), ([3, 1, 0, 2], 6, 8, (-2 : Int)), ([3, 1, 0, 3], 5, 3, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s208.map z7DecodeRow ++ (z7UnaryCode5_s209.map z7DecodeRow ++ (z7UnaryCode5_s210.map z7DecodeRow ++ (z7UnaryCode5_s211.map z7DecodeRow ++ (z7UnaryCode5_s212.map z7DecodeRow ++ (z7UnaryCode5_s213.map z7DecodeRow ++ (z7UnaryCode5_s214.map z7DecodeRow ++ (z7UnaryCode5_s215.map z7DecodeRow ++ (z7UnaryCode5_s216.map z7DecodeRow ++ (z7UnaryCode5_s217.map z7DecodeRow ++ (z7UnaryCode5_s218.map z7DecodeRow ++ (z7UnaryCode5_s219.map z7DecodeRow ++ (z7UnaryCode5_s220.map z7DecodeRow ++ (z7UnaryCode5_s221.map z7DecodeRow ++ (z7UnaryCode5_s222.map z7DecodeRow ++ (z7UnaryCode5_s223.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s208_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s209_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s210_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s211_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s212_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s213_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s214_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s215_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s216_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s217_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s218_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s219_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s220_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s221_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s222_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s223_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 14 equals the joined decoded slices. -/
theorem z7Grp_5_14 :
    ([([3, 1, 1, 0], 7, 11, (-5 : Int)), ([3, 1, 1, 1], 6, 10, (-4 : Int)), ([3, 1, 1, 2], 5, 7, (-3 : Int)), ([3, 1, 1, 3], 4, 2, (-2 : Int)), ([3, 1, 2, 0], 6, 8, (-6 : Int)), ([3, 1, 2, 1], 5, 7, (-5 : Int)), ([3, 1, 2, 2], 4, 4, (-4 : Int)), ([3, 1, 3, 0], 5, 3, (-7 : Int)), ([3, 1, 3, 1], 4, 2, (-6 : Int)), ([3, 2, 0, 0], 7, 9, (-5 : Int)), ([3, 2, 0, 1], 6, 8, (-4 : Int)), ([3, 2, 0, 2], 5, 5, (-3 : Int)), ([3, 2, 0, 3], 4, 0, (-2 : Int)), ([3, 2, 1, 0], 6, 8, (-6 : Int)), ([3, 2, 1, 1], 5, 7, (-5 : Int)), ([3, 2, 1, 2], 4, 4, (-4 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s224.map z7DecodeRow ++ (z7UnaryCode5_s225.map z7DecodeRow ++ (z7UnaryCode5_s226.map z7DecodeRow ++ (z7UnaryCode5_s227.map z7DecodeRow ++ (z7UnaryCode5_s228.map z7DecodeRow ++ (z7UnaryCode5_s229.map z7DecodeRow ++ (z7UnaryCode5_s230.map z7DecodeRow ++ (z7UnaryCode5_s231.map z7DecodeRow ++ (z7UnaryCode5_s232.map z7DecodeRow ++ (z7UnaryCode5_s233.map z7DecodeRow ++ (z7UnaryCode5_s234.map z7DecodeRow ++ (z7UnaryCode5_s235.map z7DecodeRow ++ (z7UnaryCode5_s236.map z7DecodeRow ++ (z7UnaryCode5_s237.map z7DecodeRow ++ (z7UnaryCode5_s238.map z7DecodeRow ++ (z7UnaryCode5_s239.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s224_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s225_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s226_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s227_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s228_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s229_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s230_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s231_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s232_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s233_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s234_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s235_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s236_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s237_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s238_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s239_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 15 equals the joined decoded slices. -/
theorem z7Grp_5_15 :
    ([([3, 2, 2, 0], 5, 5, (-7 : Int)), ([3, 2, 2, 1], 4, 4, (-6 : Int)), ([3, 2, 2, 2], 3, 1, (-5 : Int)), ([3, 3, 0, 0], 6, 4, (-6 : Int)), ([3, 3, 0, 1], 5, 3, (-5 : Int)), ([3, 3, 0, 2], 4, 0, (-4 : Int)), ([3, 3, 1, 0], 5, 3, (-7 : Int)), ([3, 3, 1, 1], 4, 2, (-6 : Int)), ([4, 1, 1, 0], 6, 4, (-6 : Int)), ([4, 1, 1, 1], 5, 3, (-5 : Int)), ([4, 1, 1, 2], 4, 0, (-4 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (5 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode5_s240.map z7DecodeRow ++ (z7UnaryCode5_s241.map z7DecodeRow ++ (z7UnaryCode5_s242.map z7DecodeRow ++ (z7UnaryCode5_s243.map z7DecodeRow ++ (z7UnaryCode5_s244.map z7DecodeRow ++ (z7UnaryCode5_s245.map z7DecodeRow ++ (z7UnaryCode5_s246.map z7DecodeRow ++ (z7UnaryCode5_s247.map z7DecodeRow ++ (z7UnaryCode5_s248.map z7DecodeRow ++ (z7UnaryCode5_s249.map z7DecodeRow ++ (z7UnaryCode5_s250.map z7DecodeRow)))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows5_s240_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s241_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s242_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s243_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s244_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s245_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s246_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s247_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s248_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s249_eq]
  rw [List.flatMap_cons, z7UnaryRows5_s250_eq]
  rw [List.flatMap_nil, List.append_nil]

theorem z7UnaryRows_cached_5 : z7UnaryRows 5 = z7UnaryCode5.map z7DecodeRow := by
  unfold z7UnaryRows z7UnaryCode5
  rw [z7GenRow_split 4 12 (5 : Fin 12).val 0 [] 12
      (z7ExteriorTarget 5 5) 0 (by decide) (by decide)]
  rw [states_5]
  rw [show [([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int)), ([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 1, 0, 0], 11, 21, (-1 : Int)), ([0, 1, 0, 1], 10, 20, (0 : Int)), ([0, 1, 0, 2], 9, 17, (1 : Int)), ([0, 1, 0, 3], 8, 12, (2 : Int)), ([0, 1, 0, 4], 7, 5, (3 : Int)), ([0, 1, 1, 0], 10, 20, (-2 : Int)), ([0, 1, 1, 1], 9, 19, (-1 : Int)), ([0, 1, 1, 2], 8, 16, (0 : Int)), ([0, 1, 1, 3], 7, 11, (1 : Int)), ([0, 1, 1, 4], 6, 4, (2 : Int)), ([0, 1, 2, 0], 9, 17, (-3 : Int)), ([0, 1, 2, 1], 8, 16, (-2 : Int)), ([0, 1, 2, 2], 7, 13, (-1 : Int)), ([0, 1, 2, 3], 6, 8, (0 : Int)), ([0, 1, 2, 4], 5, 1, (1 : Int)), ([0, 1, 3, 0], 8, 12, (-4 : Int)), ([0, 1, 3, 1], 7, 11, (-3 : Int)), ([0, 1, 3, 2], 6, 8, (-2 : Int)), ([0, 1, 3, 3], 5, 3, (-1 : Int)), ([0, 2, 0, 0], 10, 18, (-2 : Int)), ([0, 2, 0, 1], 9, 17, (-1 : Int)), ([0, 2, 0, 2], 8, 14, (0 : Int)), ([0, 2, 0, 3], 7, 9, (1 : Int)), ([0, 2, 0, 4], 6, 2, (2 : Int)), ([0, 2, 1, 0], 9, 17, (-3 : Int)), ([0, 2, 1, 1], 8, 16, (-2 : Int)), ([0, 2, 1, 2], 7, 13, (-1 : Int)), ([0, 2, 1, 3], 6, 8, (0 : Int)), ([0, 2, 1, 4], 5, 1, (1 : Int)), ([0, 2, 2, 0], 8, 14, (-4 : Int)), ([0, 2, 2, 1], 7, 13, (-3 : Int)), ([0, 2, 2, 2], 6, 10, (-2 : Int)), ([0, 2, 2, 3], 5, 5, (-1 : Int)), ([0, 2, 3, 0], 7, 9, (-5 : Int)), ([0, 2, 3, 1], 6, 8, (-4 : Int)), ([0, 2, 3, 2], 5, 5, (-3 : Int)), ([0, 2, 3, 3], 4, 0, (-2 : Int)), ([0, 3, 0, 0], 9, 13, (-3 : Int)), ([0, 3, 0, 1], 8, 12, (-2 : Int)), ([0, 3, 0, 2], 7, 9, (-1 : Int)), ([0, 3, 0, 3], 6, 4, (0 : Int)), ([0, 3, 1, 0], 8, 12, (-4 : Int)), ([0, 3, 1, 1], 7, 11, (-3 : Int)), ([0, 3, 1, 2], 6, 8, (-2 : Int)), ([0, 3, 1, 3], 5, 3, (-1 : Int)), ([0, 3, 2, 0], 7, 9, (-5 : Int)), ([0, 3, 2, 1], 6, 8, (-4 : Int)), ([0, 3, 2, 2], 5, 5, (-3 : Int)), ([0, 3, 2, 3], 4, 0, (-2 : Int)), ([0, 3, 3, 0], 6, 4, (-6 : Int)), ([0, 3, 3, 1], 5, 3, (-5 : Int)), ([0, 3, 3, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int)), ([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int)), ([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 1, 0, 0], 10, 20, (-2 : Int)), ([1, 1, 0, 1], 9, 19, (-1 : Int)), ([1, 1, 0, 2], 8, 16, (0 : Int)), ([1, 1, 0, 3], 7, 11, (1 : Int)), ([1, 1, 0, 4], 6, 4, (2 : Int)), ([1, 1, 1, 0], 9, 19, (-3 : Int)), ([1, 1, 1, 1], 8, 18, (-2 : Int)), ([1, 1, 1, 2], 7, 15, (-1 : Int)), ([1, 1, 1, 3], 6, 10, (0 : Int)), ([1, 1, 1, 4], 5, 3, (1 : Int)), ([1, 1, 2, 0], 8, 16, (-4 : Int)), ([1, 1, 2, 1], 7, 15, (-3 : Int)), ([1, 1, 2, 2], 6, 12, (-2 : Int)), ([1, 1, 2, 3], 5, 7, (-1 : Int)), ([1, 1, 2, 4], 4, 0, (0 : Int)), ([1, 1, 3, 0], 7, 11, (-5 : Int)), ([1, 1, 3, 1], 6, 10, (-4 : Int)), ([1, 1, 3, 2], 5, 7, (-3 : Int)), ([1, 1, 3, 3], 4, 2, (-2 : Int)), ([1, 1, 4, 0], 6, 4, (-6 : Int)), ([1, 1, 4, 1], 5, 3, (-5 : Int)), ([1, 1, 4, 2], 4, 0, (-4 : Int)), ([1, 2, 0, 0], 9, 17, (-3 : Int)), ([1, 2, 0, 1], 8, 16, (-2 : Int)), ([1, 2, 0, 2], 7, 13, (-1 : Int)), ([1, 2, 0, 3], 6, 8, (0 : Int)), ([1, 2, 0, 4], 5, 1, (1 : Int)), ([1, 2, 1, 0], 8, 16, (-4 : Int)), ([1, 2, 1, 1], 7, 15, (-3 : Int)), ([1, 2, 1, 2], 6, 12, (-2 : Int)), ([1, 2, 1, 3], 5, 7, (-1 : Int)), ([1, 2, 1, 4], 4, 0, (0 : Int)), ([1, 2, 2, 0], 7, 13, (-5 : Int)), ([1, 2, 2, 1], 6, 12, (-4 : Int)), ([1, 2, 2, 2], 5, 9, (-3 : Int)), ([1, 2, 2, 3], 4, 4, (-2 : Int)), ([1, 2, 3, 0], 6, 8, (-6 : Int)), ([1, 2, 3, 1], 5, 7, (-5 : Int)), ([1, 2, 3, 2], 4, 4, (-4 : Int)), ([1, 3, 0, 0], 8, 12, (-4 : Int)), ([1, 3, 0, 1], 7, 11, (-3 : Int)), ([1, 3, 0, 2], 6, 8, (-2 : Int)), ([1, 3, 0, 3], 5, 3, (-1 : Int)), ([1, 3, 1, 0], 7, 11, (-5 : Int)), ([1, 3, 1, 1], 6, 10, (-4 : Int)), ([1, 3, 1, 2], 5, 7, (-3 : Int)), ([1, 3, 1, 3], 4, 2, (-2 : Int)), ([1, 3, 2, 0], 6, 8, (-6 : Int)), ([1, 3, 2, 1], 5, 7, (-5 : Int)), ([1, 3, 2, 2], 4, 4, (-4 : Int)), ([1, 3, 3, 0], 5, 3, (-7 : Int)), ([1, 3, 3, 1], 4, 2, (-6 : Int)), ([1, 4, 1, 0], 6, 4, (-6 : Int)), ([1, 4, 1, 1], 5, 3, (-5 : Int)), ([1, 4, 1, 2], 4, 0, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int)), ([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int)), ([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 1, 0, 0], 9, 17, (-3 : Int)), ([2, 1, 0, 1], 8, 16, (-2 : Int)), ([2, 1, 0, 2], 7, 13, (-1 : Int)), ([2, 1, 0, 3], 6, 8, (0 : Int)), ([2, 1, 0, 4], 5, 1, (1 : Int)), ([2, 1, 1, 0], 8, 16, (-4 : Int)), ([2, 1, 1, 1], 7, 15, (-3 : Int)), ([2, 1, 1, 2], 6, 12, (-2 : Int)), ([2, 1, 1, 3], 5, 7, (-1 : Int)), ([2, 1, 1, 4], 4, 0, (0 : Int)), ([2, 1, 2, 0], 7, 13, (-5 : Int)), ([2, 1, 2, 1], 6, 12, (-4 : Int)), ([2, 1, 2, 2], 5, 9, (-3 : Int)), ([2, 1, 2, 3], 4, 4, (-2 : Int)), ([2, 1, 3, 0], 6, 8, (-6 : Int)), ([2, 1, 3, 1], 5, 7, (-5 : Int)), ([2, 1, 3, 2], 4, 4, (-4 : Int)), ([2, 2, 0, 0], 8, 14, (-4 : Int)), ([2, 2, 0, 1], 7, 13, (-3 : Int)), ([2, 2, 0, 2], 6, 10, (-2 : Int)), ([2, 2, 0, 3], 5, 5, (-1 : Int)), ([2, 2, 1, 0], 7, 13, (-5 : Int)), ([2, 2, 1, 1], 6, 12, (-4 : Int)), ([2, 2, 1, 2], 5, 9, (-3 : Int)), ([2, 2, 1, 3], 4, 4, (-2 : Int)), ([2, 2, 2, 0], 6, 10, (-6 : Int)), ([2, 2, 2, 1], 5, 9, (-5 : Int)), ([2, 2, 2, 2], 4, 6, (-4 : Int)), ([2, 2, 2, 3], 3, 1, (-3 : Int)), ([2, 2, 3, 0], 5, 5, (-7 : Int)), ([2, 2, 3, 1], 4, 4, (-6 : Int)), ([2, 2, 3, 2], 3, 1, (-5 : Int)), ([2, 3, 0, 0], 7, 9, (-5 : Int)), ([2, 3, 0, 1], 6, 8, (-4 : Int)), ([2, 3, 0, 2], 5, 5, (-3 : Int)), ([2, 3, 0, 3], 4, 0, (-2 : Int)), ([2, 3, 1, 0], 6, 8, (-6 : Int)), ([2, 3, 1, 1], 5, 7, (-5 : Int)), ([2, 3, 1, 2], 4, 4, (-4 : Int)), ([2, 3, 2, 0], 5, 5, (-7 : Int)), ([2, 3, 2, 1], 4, 4, (-6 : Int)), ([2, 3, 2, 2], 3, 1, (-5 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int)), ([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int)), ([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 1, 0, 0], 8, 12, (-4 : Int)), ([3, 1, 0, 1], 7, 11, (-3 : Int)), ([3, 1, 0, 2], 6, 8, (-2 : Int)), ([3, 1, 0, 3], 5, 3, (-1 : Int)), ([3, 1, 1, 0], 7, 11, (-5 : Int)), ([3, 1, 1, 1], 6, 10, (-4 : Int)), ([3, 1, 1, 2], 5, 7, (-3 : Int)), ([3, 1, 1, 3], 4, 2, (-2 : Int)), ([3, 1, 2, 0], 6, 8, (-6 : Int)), ([3, 1, 2, 1], 5, 7, (-5 : Int)), ([3, 1, 2, 2], 4, 4, (-4 : Int)), ([3, 1, 3, 0], 5, 3, (-7 : Int)), ([3, 1, 3, 1], 4, 2, (-6 : Int)), ([3, 2, 0, 0], 7, 9, (-5 : Int)), ([3, 2, 0, 1], 6, 8, (-4 : Int)), ([3, 2, 0, 2], 5, 5, (-3 : Int)), ([3, 2, 0, 3], 4, 0, (-2 : Int)), ([3, 2, 1, 0], 6, 8, (-6 : Int)), ([3, 2, 1, 1], 5, 7, (-5 : Int)), ([3, 2, 1, 2], 4, 4, (-4 : Int)), ([3, 2, 2, 0], 5, 5, (-7 : Int)), ([3, 2, 2, 1], 4, 4, (-6 : Int)), ([3, 2, 2, 2], 3, 1, (-5 : Int)), ([3, 3, 0, 0], 6, 4, (-6 : Int)), ([3, 3, 0, 1], 5, 3, (-5 : Int)), ([3, 3, 0, 2], 4, 0, (-4 : Int)), ([3, 3, 1, 0], 5, 3, (-7 : Int)), ([3, 3, 1, 1], 4, 2, (-6 : Int)), ([4, 1, 1, 0], 6, 4, (-6 : Int)), ([4, 1, 1, 1], 5, 3, (-5 : Int)), ([4, 1, 1, 2], 4, 0, (-4 : Int))] = [([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int))] ++ ([([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 1, 0, 0], 11, 21, (-1 : Int)), ([0, 1, 0, 1], 10, 20, (0 : Int)), ([0, 1, 0, 2], 9, 17, (1 : Int)), ([0, 1, 0, 3], 8, 12, (2 : Int)), ([0, 1, 0, 4], 7, 5, (3 : Int)), ([0, 1, 1, 0], 10, 20, (-2 : Int)), ([0, 1, 1, 1], 9, 19, (-1 : Int)), ([0, 1, 1, 2], 8, 16, (0 : Int)), ([0, 1, 1, 3], 7, 11, (1 : Int)), ([0, 1, 1, 4], 6, 4, (2 : Int)), ([0, 1, 2, 0], 9, 17, (-3 : Int)), ([0, 1, 2, 1], 8, 16, (-2 : Int)), ([0, 1, 2, 2], 7, 13, (-1 : Int))] ++ ([([0, 1, 2, 3], 6, 8, (0 : Int)), ([0, 1, 2, 4], 5, 1, (1 : Int)), ([0, 1, 3, 0], 8, 12, (-4 : Int)), ([0, 1, 3, 1], 7, 11, (-3 : Int)), ([0, 1, 3, 2], 6, 8, (-2 : Int)), ([0, 1, 3, 3], 5, 3, (-1 : Int)), ([0, 2, 0, 0], 10, 18, (-2 : Int)), ([0, 2, 0, 1], 9, 17, (-1 : Int)), ([0, 2, 0, 2], 8, 14, (0 : Int)), ([0, 2, 0, 3], 7, 9, (1 : Int)), ([0, 2, 0, 4], 6, 2, (2 : Int)), ([0, 2, 1, 0], 9, 17, (-3 : Int)), ([0, 2, 1, 1], 8, 16, (-2 : Int)), ([0, 2, 1, 2], 7, 13, (-1 : Int)), ([0, 2, 1, 3], 6, 8, (0 : Int)), ([0, 2, 1, 4], 5, 1, (1 : Int))] ++ ([([0, 2, 2, 0], 8, 14, (-4 : Int)), ([0, 2, 2, 1], 7, 13, (-3 : Int)), ([0, 2, 2, 2], 6, 10, (-2 : Int)), ([0, 2, 2, 3], 5, 5, (-1 : Int)), ([0, 2, 3, 0], 7, 9, (-5 : Int)), ([0, 2, 3, 1], 6, 8, (-4 : Int)), ([0, 2, 3, 2], 5, 5, (-3 : Int)), ([0, 2, 3, 3], 4, 0, (-2 : Int)), ([0, 3, 0, 0], 9, 13, (-3 : Int)), ([0, 3, 0, 1], 8, 12, (-2 : Int)), ([0, 3, 0, 2], 7, 9, (-1 : Int)), ([0, 3, 0, 3], 6, 4, (0 : Int)), ([0, 3, 1, 0], 8, 12, (-4 : Int)), ([0, 3, 1, 1], 7, 11, (-3 : Int)), ([0, 3, 1, 2], 6, 8, (-2 : Int)), ([0, 3, 1, 3], 5, 3, (-1 : Int))] ++ ([([0, 3, 2, 0], 7, 9, (-5 : Int)), ([0, 3, 2, 1], 6, 8, (-4 : Int)), ([0, 3, 2, 2], 5, 5, (-3 : Int)), ([0, 3, 2, 3], 4, 0, (-2 : Int)), ([0, 3, 3, 0], 6, 4, (-6 : Int)), ([0, 3, 3, 1], 5, 3, (-5 : Int)), ([0, 3, 3, 2], 4, 0, (-4 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int))] ++ ([([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int)), ([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 1, 0, 0], 10, 20, (-2 : Int)), ([1, 1, 0, 1], 9, 19, (-1 : Int)), ([1, 1, 0, 2], 8, 16, (0 : Int)), ([1, 1, 0, 3], 7, 11, (1 : Int)), ([1, 1, 0, 4], 6, 4, (2 : Int)), ([1, 1, 1, 0], 9, 19, (-3 : Int))] ++ ([([1, 1, 1, 1], 8, 18, (-2 : Int)), ([1, 1, 1, 2], 7, 15, (-1 : Int)), ([1, 1, 1, 3], 6, 10, (0 : Int)), ([1, 1, 1, 4], 5, 3, (1 : Int)), ([1, 1, 2, 0], 8, 16, (-4 : Int)), ([1, 1, 2, 1], 7, 15, (-3 : Int)), ([1, 1, 2, 2], 6, 12, (-2 : Int)), ([1, 1, 2, 3], 5, 7, (-1 : Int)), ([1, 1, 2, 4], 4, 0, (0 : Int)), ([1, 1, 3, 0], 7, 11, (-5 : Int)), ([1, 1, 3, 1], 6, 10, (-4 : Int)), ([1, 1, 3, 2], 5, 7, (-3 : Int)), ([1, 1, 3, 3], 4, 2, (-2 : Int)), ([1, 1, 4, 0], 6, 4, (-6 : Int)), ([1, 1, 4, 1], 5, 3, (-5 : Int)), ([1, 1, 4, 2], 4, 0, (-4 : Int))] ++ ([([1, 2, 0, 0], 9, 17, (-3 : Int)), ([1, 2, 0, 1], 8, 16, (-2 : Int)), ([1, 2, 0, 2], 7, 13, (-1 : Int)), ([1, 2, 0, 3], 6, 8, (0 : Int)), ([1, 2, 0, 4], 5, 1, (1 : Int)), ([1, 2, 1, 0], 8, 16, (-4 : Int)), ([1, 2, 1, 1], 7, 15, (-3 : Int)), ([1, 2, 1, 2], 6, 12, (-2 : Int)), ([1, 2, 1, 3], 5, 7, (-1 : Int)), ([1, 2, 1, 4], 4, 0, (0 : Int)), ([1, 2, 2, 0], 7, 13, (-5 : Int)), ([1, 2, 2, 1], 6, 12, (-4 : Int)), ([1, 2, 2, 2], 5, 9, (-3 : Int)), ([1, 2, 2, 3], 4, 4, (-2 : Int)), ([1, 2, 3, 0], 6, 8, (-6 : Int)), ([1, 2, 3, 1], 5, 7, (-5 : Int))] ++ ([([1, 2, 3, 2], 4, 4, (-4 : Int)), ([1, 3, 0, 0], 8, 12, (-4 : Int)), ([1, 3, 0, 1], 7, 11, (-3 : Int)), ([1, 3, 0, 2], 6, 8, (-2 : Int)), ([1, 3, 0, 3], 5, 3, (-1 : Int)), ([1, 3, 1, 0], 7, 11, (-5 : Int)), ([1, 3, 1, 1], 6, 10, (-4 : Int)), ([1, 3, 1, 2], 5, 7, (-3 : Int)), ([1, 3, 1, 3], 4, 2, (-2 : Int)), ([1, 3, 2, 0], 6, 8, (-6 : Int)), ([1, 3, 2, 1], 5, 7, (-5 : Int)), ([1, 3, 2, 2], 4, 4, (-4 : Int)), ([1, 3, 3, 0], 5, 3, (-7 : Int)), ([1, 3, 3, 1], 4, 2, (-6 : Int)), ([1, 4, 1, 0], 6, 4, (-6 : Int)), ([1, 4, 1, 1], 5, 3, (-5 : Int))] ++ ([([1, 4, 1, 2], 4, 0, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int)), ([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int))] ++ ([([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 1, 0, 0], 9, 17, (-3 : Int)), ([2, 1, 0, 1], 8, 16, (-2 : Int)), ([2, 1, 0, 2], 7, 13, (-1 : Int)), ([2, 1, 0, 3], 6, 8, (0 : Int)), ([2, 1, 0, 4], 5, 1, (1 : Int)), ([2, 1, 1, 0], 8, 16, (-4 : Int)), ([2, 1, 1, 1], 7, 15, (-3 : Int)), ([2, 1, 1, 2], 6, 12, (-2 : Int)), ([2, 1, 1, 3], 5, 7, (-1 : Int)), ([2, 1, 1, 4], 4, 0, (0 : Int)), ([2, 1, 2, 0], 7, 13, (-5 : Int)), ([2, 1, 2, 1], 6, 12, (-4 : Int)), ([2, 1, 2, 2], 5, 9, (-3 : Int))] ++ ([([2, 1, 2, 3], 4, 4, (-2 : Int)), ([2, 1, 3, 0], 6, 8, (-6 : Int)), ([2, 1, 3, 1], 5, 7, (-5 : Int)), ([2, 1, 3, 2], 4, 4, (-4 : Int)), ([2, 2, 0, 0], 8, 14, (-4 : Int)), ([2, 2, 0, 1], 7, 13, (-3 : Int)), ([2, 2, 0, 2], 6, 10, (-2 : Int)), ([2, 2, 0, 3], 5, 5, (-1 : Int)), ([2, 2, 1, 0], 7, 13, (-5 : Int)), ([2, 2, 1, 1], 6, 12, (-4 : Int)), ([2, 2, 1, 2], 5, 9, (-3 : Int)), ([2, 2, 1, 3], 4, 4, (-2 : Int)), ([2, 2, 2, 0], 6, 10, (-6 : Int)), ([2, 2, 2, 1], 5, 9, (-5 : Int)), ([2, 2, 2, 2], 4, 6, (-4 : Int)), ([2, 2, 2, 3], 3, 1, (-3 : Int))] ++ ([([2, 2, 3, 0], 5, 5, (-7 : Int)), ([2, 2, 3, 1], 4, 4, (-6 : Int)), ([2, 2, 3, 2], 3, 1, (-5 : Int)), ([2, 3, 0, 0], 7, 9, (-5 : Int)), ([2, 3, 0, 1], 6, 8, (-4 : Int)), ([2, 3, 0, 2], 5, 5, (-3 : Int)), ([2, 3, 0, 3], 4, 0, (-2 : Int)), ([2, 3, 1, 0], 6, 8, (-6 : Int)), ([2, 3, 1, 1], 5, 7, (-5 : Int)), ([2, 3, 1, 2], 4, 4, (-4 : Int)), ([2, 3, 2, 0], 5, 5, (-7 : Int)), ([2, 3, 2, 1], 4, 4, (-6 : Int)), ([2, 3, 2, 2], 3, 1, (-5 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int))] ++ ([([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int)), ([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 1, 0, 0], 8, 12, (-4 : Int)), ([3, 1, 0, 1], 7, 11, (-3 : Int)), ([3, 1, 0, 2], 6, 8, (-2 : Int)), ([3, 1, 0, 3], 5, 3, (-1 : Int))] ++ ([([3, 1, 1, 0], 7, 11, (-5 : Int)), ([3, 1, 1, 1], 6, 10, (-4 : Int)), ([3, 1, 1, 2], 5, 7, (-3 : Int)), ([3, 1, 1, 3], 4, 2, (-2 : Int)), ([3, 1, 2, 0], 6, 8, (-6 : Int)), ([3, 1, 2, 1], 5, 7, (-5 : Int)), ([3, 1, 2, 2], 4, 4, (-4 : Int)), ([3, 1, 3, 0], 5, 3, (-7 : Int)), ([3, 1, 3, 1], 4, 2, (-6 : Int)), ([3, 2, 0, 0], 7, 9, (-5 : Int)), ([3, 2, 0, 1], 6, 8, (-4 : Int)), ([3, 2, 0, 2], 5, 5, (-3 : Int)), ([3, 2, 0, 3], 4, 0, (-2 : Int)), ([3, 2, 1, 0], 6, 8, (-6 : Int)), ([3, 2, 1, 1], 5, 7, (-5 : Int)), ([3, 2, 1, 2], 4, 4, (-4 : Int))] ++ ([([3, 2, 2, 0], 5, 5, (-7 : Int)), ([3, 2, 2, 1], 4, 4, (-6 : Int)), ([3, 2, 2, 2], 3, 1, (-5 : Int)), ([3, 3, 0, 0], 6, 4, (-6 : Int)), ([3, 3, 0, 1], 5, 3, (-5 : Int)), ([3, 3, 0, 2], 4, 0, (-4 : Int)), ([3, 3, 1, 0], 5, 3, (-7 : Int)), ([3, 3, 1, 1], 4, 2, (-6 : Int)), ([4, 1, 1, 0], 6, 4, (-6 : Int)), ([4, 1, 1, 1], 5, 3, (-5 : Int)), ([4, 1, 1, 2], 4, 0, (-4 : Int))]))))))))))))))) from rfl]
  repeat rw [List.flatMap_append]
  rw [z7Grp_5_0, z7Grp_5_1, z7Grp_5_2, z7Grp_5_3, z7Grp_5_4, z7Grp_5_5, z7Grp_5_6, z7Grp_5_7, z7Grp_5_8, z7Grp_5_9, z7Grp_5_10, z7Grp_5_11, z7Grp_5_12, z7Grp_5_13, z7Grp_5_14, z7Grp_5_15]
  repeat rw [List.map_append]
  repeat rw [← List.append_assoc]

#print axioms z7UnaryRows_cached_5

end Matrix99
