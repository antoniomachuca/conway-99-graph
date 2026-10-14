import Conway.Z7GenSplit
import Conway.Z7UnaryCode1
namespace Matrix99

set_option maxHeartbeats 800000000
set_option maxRecDepth 100000
set_option Elab.async false

/-- Reached depth-4 generator states for index 1. -/
theorem states_1 : z7GenStates 4 12 (1 : Fin 12).val 0 [] 12
    (z7ExteriorTarget 1 1) 0 = [([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int)), ([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 2, 0, 0], 10, 16, (-2 : Int)), ([0, 2, 0, 1], 9, 15, (-1 : Int)), ([0, 2, 0, 2], 8, 12, (0 : Int)), ([0, 2, 0, 3], 7, 7, (1 : Int)), ([0, 2, 0, 4], 6, 0, (2 : Int)), ([0, 2, 1, 0], 9, 15, (-3 : Int)), ([0, 2, 1, 1], 8, 14, (-2 : Int)), ([0, 2, 1, 2], 7, 11, (-1 : Int)), ([0, 2, 1, 3], 6, 6, (0 : Int)), ([0, 2, 2, 0], 8, 12, (-4 : Int)), ([0, 2, 2, 1], 7, 11, (-3 : Int)), ([0, 2, 2, 2], 6, 8, (-2 : Int)), ([0, 2, 2, 3], 5, 3, (-1 : Int)), ([0, 2, 3, 0], 7, 7, (-5 : Int)), ([0, 2, 3, 1], 6, 6, (-4 : Int)), ([0, 2, 3, 2], 5, 3, (-3 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int)), ([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int)), ([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 2, 0, 0], 9, 15, (-3 : Int)), ([1, 2, 0, 1], 8, 14, (-2 : Int)), ([1, 2, 0, 2], 7, 11, (-1 : Int)), ([1, 2, 0, 3], 6, 6, (0 : Int)), ([1, 2, 1, 0], 8, 14, (-4 : Int)), ([1, 2, 1, 1], 7, 13, (-3 : Int)), ([1, 2, 1, 2], 6, 10, (-2 : Int)), ([1, 2, 1, 3], 5, 5, (-1 : Int)), ([1, 2, 2, 0], 7, 11, (-5 : Int)), ([1, 2, 2, 1], 6, 10, (-4 : Int)), ([1, 2, 2, 2], 5, 7, (-3 : Int)), ([1, 2, 2, 3], 4, 2, (-2 : Int)), ([1, 2, 3, 0], 6, 6, (-6 : Int)), ([1, 2, 3, 1], 5, 5, (-5 : Int)), ([1, 2, 3, 2], 4, 2, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int)), ([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int)), ([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 2, 0, 0], 8, 12, (-4 : Int)), ([2, 2, 0, 1], 7, 11, (-3 : Int)), ([2, 2, 0, 2], 6, 8, (-2 : Int)), ([2, 2, 0, 3], 5, 3, (-1 : Int)), ([2, 2, 1, 0], 7, 11, (-5 : Int)), ([2, 2, 1, 1], 6, 10, (-4 : Int)), ([2, 2, 1, 2], 5, 7, (-3 : Int)), ([2, 2, 1, 3], 4, 2, (-2 : Int)), ([2, 2, 2, 0], 6, 8, (-6 : Int)), ([2, 2, 2, 1], 5, 7, (-5 : Int)), ([2, 2, 2, 2], 4, 4, (-4 : Int)), ([2, 2, 3, 0], 5, 3, (-7 : Int)), ([2, 2, 3, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int)), ([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int)), ([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 2, 0, 0], 7, 7, (-5 : Int)), ([3, 2, 0, 1], 6, 6, (-4 : Int)), ([3, 2, 0, 2], 5, 3, (-3 : Int)), ([3, 2, 1, 0], 6, 6, (-6 : Int)), ([3, 2, 1, 1], 5, 5, (-5 : Int)), ([3, 2, 1, 2], 4, 2, (-4 : Int)), ([3, 2, 2, 0], 5, 3, (-7 : Int)), ([3, 2, 2, 1], 4, 2, (-6 : Int))] := by
  decide +kernel

theorem z7UnaryRows1_s0 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 0, 0] 12 22 (0 : Int))
    (z7UnaryCode1_s0.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s0_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 0, 0], 12, 22, (0 : Int)).1 ([0, 0, 0, 0], 12, 22, (0 : Int)).2.1
      ([0, 0, 0, 0], 12, 22, (0 : Int)).2.2.1 ([0, 0, 0, 0], 12, 22, (0 : Int)).2.2.2 =
    z7UnaryCode1_s0.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 0, 0] 12 22 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s0
theorem z7UnaryRows1_s1 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 0, 1] 11 21 (1 : Int))
    (z7UnaryCode1_s1.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s1_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 0, 1], 11, 21, (1 : Int)).1 ([0, 0, 0, 1], 11, 21, (1 : Int)).2.1
      ([0, 0, 0, 1], 11, 21, (1 : Int)).2.2.1 ([0, 0, 0, 1], 11, 21, (1 : Int)).2.2.2 =
    z7UnaryCode1_s1.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 0, 1] 11 21 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s1
theorem z7UnaryRows1_s2 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 0, 2] 10 18 (2 : Int))
    (z7UnaryCode1_s2.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s2_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 0, 2], 10, 18, (2 : Int)).1 ([0, 0, 0, 2], 10, 18, (2 : Int)).2.1
      ([0, 0, 0, 2], 10, 18, (2 : Int)).2.2.1 ([0, 0, 0, 2], 10, 18, (2 : Int)).2.2.2 =
    z7UnaryCode1_s2.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 0, 2] 10 18 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s2
theorem z7UnaryRows1_s3 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 0, 3] 9 13 (3 : Int))
    (z7UnaryCode1_s3.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s3_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 0, 3], 9, 13, (3 : Int)).1 ([0, 0, 0, 3], 9, 13, (3 : Int)).2.1
      ([0, 0, 0, 3], 9, 13, (3 : Int)).2.2.1 ([0, 0, 0, 3], 9, 13, (3 : Int)).2.2.2 =
    z7UnaryCode1_s3.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 0, 3] 9 13 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s3
theorem z7UnaryRows1_s4 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 0, 4] 8 6 (4 : Int))
    (z7UnaryCode1_s4.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s4_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 0, 4], 8, 6, (4 : Int)).1 ([0, 0, 0, 4], 8, 6, (4 : Int)).2.1
      ([0, 0, 0, 4], 8, 6, (4 : Int)).2.2.1 ([0, 0, 0, 4], 8, 6, (4 : Int)).2.2.2 =
    z7UnaryCode1_s4.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 0, 4] 8 6 (4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s4
theorem z7UnaryRows1_s5 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 1, 0] 11 21 (-1 : Int))
    (z7UnaryCode1_s5.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s5_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 1, 0], 11, 21, (-1 : Int)).1 ([0, 0, 1, 0], 11, 21, (-1 : Int)).2.1
      ([0, 0, 1, 0], 11, 21, (-1 : Int)).2.2.1 ([0, 0, 1, 0], 11, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s5.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 1, 0] 11 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s5
theorem z7UnaryRows1_s6 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 1, 1] 10 20 (0 : Int))
    (z7UnaryCode1_s6.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s6_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 1, 1], 10, 20, (0 : Int)).1 ([0, 0, 1, 1], 10, 20, (0 : Int)).2.1
      ([0, 0, 1, 1], 10, 20, (0 : Int)).2.2.1 ([0, 0, 1, 1], 10, 20, (0 : Int)).2.2.2 =
    z7UnaryCode1_s6.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 1, 1] 10 20 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s6
theorem z7UnaryRows1_s7 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 1, 2] 9 17 (1 : Int))
    (z7UnaryCode1_s7.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s7_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 1, 2], 9, 17, (1 : Int)).1 ([0, 0, 1, 2], 9, 17, (1 : Int)).2.1
      ([0, 0, 1, 2], 9, 17, (1 : Int)).2.2.1 ([0, 0, 1, 2], 9, 17, (1 : Int)).2.2.2 =
    z7UnaryCode1_s7.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 1, 2] 9 17 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s7
theorem z7UnaryRows1_s8 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 1, 3] 8 12 (2 : Int))
    (z7UnaryCode1_s8.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s8_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 1, 3], 8, 12, (2 : Int)).1 ([0, 0, 1, 3], 8, 12, (2 : Int)).2.1
      ([0, 0, 1, 3], 8, 12, (2 : Int)).2.2.1 ([0, 0, 1, 3], 8, 12, (2 : Int)).2.2.2 =
    z7UnaryCode1_s8.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 1, 3] 8 12 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s8
theorem z7UnaryRows1_s9 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 1, 4] 7 5 (3 : Int))
    (z7UnaryCode1_s9.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s9_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 1, 4], 7, 5, (3 : Int)).1 ([0, 0, 1, 4], 7, 5, (3 : Int)).2.1
      ([0, 0, 1, 4], 7, 5, (3 : Int)).2.2.1 ([0, 0, 1, 4], 7, 5, (3 : Int)).2.2.2 =
    z7UnaryCode1_s9.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 1, 4] 7 5 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s9
theorem z7UnaryRows1_s10 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 2, 0] 10 18 (-2 : Int))
    (z7UnaryCode1_s10.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s10_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 2, 0], 10, 18, (-2 : Int)).1 ([0, 0, 2, 0], 10, 18, (-2 : Int)).2.1
      ([0, 0, 2, 0], 10, 18, (-2 : Int)).2.2.1 ([0, 0, 2, 0], 10, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s10.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 2, 0] 10 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s10
theorem z7UnaryRows1_s11 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 2, 1] 9 17 (-1 : Int))
    (z7UnaryCode1_s11.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s11_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 2, 1], 9, 17, (-1 : Int)).1 ([0, 0, 2, 1], 9, 17, (-1 : Int)).2.1
      ([0, 0, 2, 1], 9, 17, (-1 : Int)).2.2.1 ([0, 0, 2, 1], 9, 17, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s11.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 2, 1] 9 17 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s11
theorem z7UnaryRows1_s12 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 2, 2] 8 14 (0 : Int))
    (z7UnaryCode1_s12.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s12_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 2, 2], 8, 14, (0 : Int)).1 ([0, 0, 2, 2], 8, 14, (0 : Int)).2.1
      ([0, 0, 2, 2], 8, 14, (0 : Int)).2.2.1 ([0, 0, 2, 2], 8, 14, (0 : Int)).2.2.2 =
    z7UnaryCode1_s12.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 2, 2] 8 14 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s12
theorem z7UnaryRows1_s13 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 2, 3] 7 9 (1 : Int))
    (z7UnaryCode1_s13.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s13_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 2, 3], 7, 9, (1 : Int)).1 ([0, 0, 2, 3], 7, 9, (1 : Int)).2.1
      ([0, 0, 2, 3], 7, 9, (1 : Int)).2.2.1 ([0, 0, 2, 3], 7, 9, (1 : Int)).2.2.2 =
    z7UnaryCode1_s13.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 2, 3] 7 9 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s13
theorem z7UnaryRows1_s14 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 2, 4] 6 2 (2 : Int))
    (z7UnaryCode1_s14.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s14_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 2, 4], 6, 2, (2 : Int)).1 ([0, 0, 2, 4], 6, 2, (2 : Int)).2.1
      ([0, 0, 2, 4], 6, 2, (2 : Int)).2.2.1 ([0, 0, 2, 4], 6, 2, (2 : Int)).2.2.2 =
    z7UnaryCode1_s14.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 2, 4] 6 2 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s14
theorem z7UnaryRows1_s15 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 3, 0] 9 13 (-3 : Int))
    (z7UnaryCode1_s15.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s15_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 3, 0], 9, 13, (-3 : Int)).1 ([0, 0, 3, 0], 9, 13, (-3 : Int)).2.1
      ([0, 0, 3, 0], 9, 13, (-3 : Int)).2.2.1 ([0, 0, 3, 0], 9, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s15.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 3, 0] 9 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s15
theorem z7UnaryRows1_s16 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 3, 1] 8 12 (-2 : Int))
    (z7UnaryCode1_s16.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s16_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 3, 1], 8, 12, (-2 : Int)).1 ([0, 0, 3, 1], 8, 12, (-2 : Int)).2.1
      ([0, 0, 3, 1], 8, 12, (-2 : Int)).2.2.1 ([0, 0, 3, 1], 8, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s16.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 3, 1] 8 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s16
theorem z7UnaryRows1_s17 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 3, 2] 7 9 (-1 : Int))
    (z7UnaryCode1_s17.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s17_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 3, 2], 7, 9, (-1 : Int)).1 ([0, 0, 3, 2], 7, 9, (-1 : Int)).2.1
      ([0, 0, 3, 2], 7, 9, (-1 : Int)).2.2.1 ([0, 0, 3, 2], 7, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s17.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 3, 2] 7 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s17
theorem z7UnaryRows1_s18 : rowsBeq
    (z7GenRow 8 1 4 [0, 0, 3, 3] 6 4 (0 : Int))
    (z7UnaryCode1_s18.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s18_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 0, 3, 3], 6, 4, (0 : Int)).1 ([0, 0, 3, 3], 6, 4, (0 : Int)).2.1
      ([0, 0, 3, 3], 6, 4, (0 : Int)).2.2.1 ([0, 0, 3, 3], 6, 4, (0 : Int)).2.2.2 =
    z7UnaryCode1_s18.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 0, 3, 3] 6 4 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s18
theorem z7UnaryRows1_s19 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 0, 0] 10 16 (-2 : Int))
    (z7UnaryCode1_s19.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s19_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 0, 0], 10, 16, (-2 : Int)).1 ([0, 2, 0, 0], 10, 16, (-2 : Int)).2.1
      ([0, 2, 0, 0], 10, 16, (-2 : Int)).2.2.1 ([0, 2, 0, 0], 10, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s19.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 0, 0] 10 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s19
theorem z7UnaryRows1_s20 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 0, 1] 9 15 (-1 : Int))
    (z7UnaryCode1_s20.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s20_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 0, 1], 9, 15, (-1 : Int)).1 ([0, 2, 0, 1], 9, 15, (-1 : Int)).2.1
      ([0, 2, 0, 1], 9, 15, (-1 : Int)).2.2.1 ([0, 2, 0, 1], 9, 15, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s20.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 0, 1] 9 15 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s20
theorem z7UnaryRows1_s21 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 0, 2] 8 12 (0 : Int))
    (z7UnaryCode1_s21.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s21_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 0, 2], 8, 12, (0 : Int)).1 ([0, 2, 0, 2], 8, 12, (0 : Int)).2.1
      ([0, 2, 0, 2], 8, 12, (0 : Int)).2.2.1 ([0, 2, 0, 2], 8, 12, (0 : Int)).2.2.2 =
    z7UnaryCode1_s21.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 0, 2] 8 12 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s21
theorem z7UnaryRows1_s22 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 0, 3] 7 7 (1 : Int))
    (z7UnaryCode1_s22.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s22_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 0, 3], 7, 7, (1 : Int)).1 ([0, 2, 0, 3], 7, 7, (1 : Int)).2.1
      ([0, 2, 0, 3], 7, 7, (1 : Int)).2.2.1 ([0, 2, 0, 3], 7, 7, (1 : Int)).2.2.2 =
    z7UnaryCode1_s22.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 0, 3] 7 7 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s22
theorem z7UnaryRows1_s23 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 0, 4] 6 0 (2 : Int))
    (z7UnaryCode1_s23.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s23_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 0, 4], 6, 0, (2 : Int)).1 ([0, 2, 0, 4], 6, 0, (2 : Int)).2.1
      ([0, 2, 0, 4], 6, 0, (2 : Int)).2.2.1 ([0, 2, 0, 4], 6, 0, (2 : Int)).2.2.2 =
    z7UnaryCode1_s23.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 0, 4] 6 0 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s23
theorem z7UnaryRows1_s24 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 1, 0] 9 15 (-3 : Int))
    (z7UnaryCode1_s24.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s24_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 1, 0], 9, 15, (-3 : Int)).1 ([0, 2, 1, 0], 9, 15, (-3 : Int)).2.1
      ([0, 2, 1, 0], 9, 15, (-3 : Int)).2.2.1 ([0, 2, 1, 0], 9, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s24.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 1, 0] 9 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s24
theorem z7UnaryRows1_s25 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 1, 1] 8 14 (-2 : Int))
    (z7UnaryCode1_s25.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s25_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 1, 1], 8, 14, (-2 : Int)).1 ([0, 2, 1, 1], 8, 14, (-2 : Int)).2.1
      ([0, 2, 1, 1], 8, 14, (-2 : Int)).2.2.1 ([0, 2, 1, 1], 8, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s25.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 1, 1] 8 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s25
theorem z7UnaryRows1_s26 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 1, 2] 7 11 (-1 : Int))
    (z7UnaryCode1_s26.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s26_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 1, 2], 7, 11, (-1 : Int)).1 ([0, 2, 1, 2], 7, 11, (-1 : Int)).2.1
      ([0, 2, 1, 2], 7, 11, (-1 : Int)).2.2.1 ([0, 2, 1, 2], 7, 11, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s26.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 1, 2] 7 11 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s26
theorem z7UnaryRows1_s27 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 1, 3] 6 6 (0 : Int))
    (z7UnaryCode1_s27.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s27_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 1, 3], 6, 6, (0 : Int)).1 ([0, 2, 1, 3], 6, 6, (0 : Int)).2.1
      ([0, 2, 1, 3], 6, 6, (0 : Int)).2.2.1 ([0, 2, 1, 3], 6, 6, (0 : Int)).2.2.2 =
    z7UnaryCode1_s27.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 1, 3] 6 6 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s27
theorem z7UnaryRows1_s28 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 2, 0] 8 12 (-4 : Int))
    (z7UnaryCode1_s28.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s28_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 2, 0], 8, 12, (-4 : Int)).1 ([0, 2, 2, 0], 8, 12, (-4 : Int)).2.1
      ([0, 2, 2, 0], 8, 12, (-4 : Int)).2.2.1 ([0, 2, 2, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s28.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 2, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s28
theorem z7UnaryRows1_s29 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 2, 1] 7 11 (-3 : Int))
    (z7UnaryCode1_s29.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s29_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 2, 1], 7, 11, (-3 : Int)).1 ([0, 2, 2, 1], 7, 11, (-3 : Int)).2.1
      ([0, 2, 2, 1], 7, 11, (-3 : Int)).2.2.1 ([0, 2, 2, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s29.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 2, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s29
theorem z7UnaryRows1_s30 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 2, 2] 6 8 (-2 : Int))
    (z7UnaryCode1_s30.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s30_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 2, 2], 6, 8, (-2 : Int)).1 ([0, 2, 2, 2], 6, 8, (-2 : Int)).2.1
      ([0, 2, 2, 2], 6, 8, (-2 : Int)).2.2.1 ([0, 2, 2, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s30.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 2, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s30
theorem z7UnaryRows1_s31 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 2, 3] 5 3 (-1 : Int))
    (z7UnaryCode1_s31.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s31_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 2, 3], 5, 3, (-1 : Int)).1 ([0, 2, 2, 3], 5, 3, (-1 : Int)).2.1
      ([0, 2, 2, 3], 5, 3, (-1 : Int)).2.2.1 ([0, 2, 2, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s31.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 2, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s31
theorem z7UnaryRows1_s32 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 3, 0] 7 7 (-5 : Int))
    (z7UnaryCode1_s32.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s32_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 3, 0], 7, 7, (-5 : Int)).1 ([0, 2, 3, 0], 7, 7, (-5 : Int)).2.1
      ([0, 2, 3, 0], 7, 7, (-5 : Int)).2.2.1 ([0, 2, 3, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s32.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 3, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s32
theorem z7UnaryRows1_s33 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 3, 1] 6 6 (-4 : Int))
    (z7UnaryCode1_s33.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s33_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 3, 1], 6, 6, (-4 : Int)).1 ([0, 2, 3, 1], 6, 6, (-4 : Int)).2.1
      ([0, 2, 3, 1], 6, 6, (-4 : Int)).2.2.1 ([0, 2, 3, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s33.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 3, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s33
theorem z7UnaryRows1_s34 : rowsBeq
    (z7GenRow 8 1 4 [0, 2, 3, 2] 5 3 (-3 : Int))
    (z7UnaryCode1_s34.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s34_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([0, 2, 3, 2], 5, 3, (-3 : Int)).1 ([0, 2, 3, 2], 5, 3, (-3 : Int)).2.1
      ([0, 2, 3, 2], 5, 3, (-3 : Int)).2.2.1 ([0, 2, 3, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s34.map z7DecodeRow := by
  show z7GenRow 8 1 4 [0, 2, 3, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s34
theorem z7UnaryRows1_s35 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 0, 0] 11 21 (-1 : Int))
    (z7UnaryCode1_s35.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s35_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 0, 0], 11, 21, (-1 : Int)).1 ([1, 0, 0, 0], 11, 21, (-1 : Int)).2.1
      ([1, 0, 0, 0], 11, 21, (-1 : Int)).2.2.1 ([1, 0, 0, 0], 11, 21, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s35.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 0, 0] 11 21 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s35
theorem z7UnaryRows1_s36 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 0, 1] 10 20 (0 : Int))
    (z7UnaryCode1_s36.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s36_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 0, 1], 10, 20, (0 : Int)).1 ([1, 0, 0, 1], 10, 20, (0 : Int)).2.1
      ([1, 0, 0, 1], 10, 20, (0 : Int)).2.2.1 ([1, 0, 0, 1], 10, 20, (0 : Int)).2.2.2 =
    z7UnaryCode1_s36.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 0, 1] 10 20 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s36
theorem z7UnaryRows1_s37 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 0, 2] 9 17 (1 : Int))
    (z7UnaryCode1_s37.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s37_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 0, 2], 9, 17, (1 : Int)).1 ([1, 0, 0, 2], 9, 17, (1 : Int)).2.1
      ([1, 0, 0, 2], 9, 17, (1 : Int)).2.2.1 ([1, 0, 0, 2], 9, 17, (1 : Int)).2.2.2 =
    z7UnaryCode1_s37.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 0, 2] 9 17 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s37
theorem z7UnaryRows1_s38 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 0, 3] 8 12 (2 : Int))
    (z7UnaryCode1_s38.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s38_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 0, 3], 8, 12, (2 : Int)).1 ([1, 0, 0, 3], 8, 12, (2 : Int)).2.1
      ([1, 0, 0, 3], 8, 12, (2 : Int)).2.2.1 ([1, 0, 0, 3], 8, 12, (2 : Int)).2.2.2 =
    z7UnaryCode1_s38.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 0, 3] 8 12 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s38
theorem z7UnaryRows1_s39 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 0, 4] 7 5 (3 : Int))
    (z7UnaryCode1_s39.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s39_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 0, 4], 7, 5, (3 : Int)).1 ([1, 0, 0, 4], 7, 5, (3 : Int)).2.1
      ([1, 0, 0, 4], 7, 5, (3 : Int)).2.2.1 ([1, 0, 0, 4], 7, 5, (3 : Int)).2.2.2 =
    z7UnaryCode1_s39.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 0, 4] 7 5 (3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s39
theorem z7UnaryRows1_s40 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 1, 0] 10 20 (-2 : Int))
    (z7UnaryCode1_s40.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s40_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 1, 0], 10, 20, (-2 : Int)).1 ([1, 0, 1, 0], 10, 20, (-2 : Int)).2.1
      ([1, 0, 1, 0], 10, 20, (-2 : Int)).2.2.1 ([1, 0, 1, 0], 10, 20, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s40.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 1, 0] 10 20 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s40
theorem z7UnaryRows1_s41 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 1, 1] 9 19 (-1 : Int))
    (z7UnaryCode1_s41.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s41_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 1, 1], 9, 19, (-1 : Int)).1 ([1, 0, 1, 1], 9, 19, (-1 : Int)).2.1
      ([1, 0, 1, 1], 9, 19, (-1 : Int)).2.2.1 ([1, 0, 1, 1], 9, 19, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s41.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 1, 1] 9 19 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s41
theorem z7UnaryRows1_s42 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 1, 2] 8 16 (0 : Int))
    (z7UnaryCode1_s42.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s42_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 1, 2], 8, 16, (0 : Int)).1 ([1, 0, 1, 2], 8, 16, (0 : Int)).2.1
      ([1, 0, 1, 2], 8, 16, (0 : Int)).2.2.1 ([1, 0, 1, 2], 8, 16, (0 : Int)).2.2.2 =
    z7UnaryCode1_s42.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 1, 2] 8 16 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s42
theorem z7UnaryRows1_s43 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 1, 3] 7 11 (1 : Int))
    (z7UnaryCode1_s43.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s43_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 1, 3], 7, 11, (1 : Int)).1 ([1, 0, 1, 3], 7, 11, (1 : Int)).2.1
      ([1, 0, 1, 3], 7, 11, (1 : Int)).2.2.1 ([1, 0, 1, 3], 7, 11, (1 : Int)).2.2.2 =
    z7UnaryCode1_s43.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 1, 3] 7 11 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s43
theorem z7UnaryRows1_s44 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 1, 4] 6 4 (2 : Int))
    (z7UnaryCode1_s44.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s44_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 1, 4], 6, 4, (2 : Int)).1 ([1, 0, 1, 4], 6, 4, (2 : Int)).2.1
      ([1, 0, 1, 4], 6, 4, (2 : Int)).2.2.1 ([1, 0, 1, 4], 6, 4, (2 : Int)).2.2.2 =
    z7UnaryCode1_s44.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 1, 4] 6 4 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s44
theorem z7UnaryRows1_s45 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 2, 0] 9 17 (-3 : Int))
    (z7UnaryCode1_s45.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s45_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 2, 0], 9, 17, (-3 : Int)).1 ([1, 0, 2, 0], 9, 17, (-3 : Int)).2.1
      ([1, 0, 2, 0], 9, 17, (-3 : Int)).2.2.1 ([1, 0, 2, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s45.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 2, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s45
theorem z7UnaryRows1_s46 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 2, 1] 8 16 (-2 : Int))
    (z7UnaryCode1_s46.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s46_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 2, 1], 8, 16, (-2 : Int)).1 ([1, 0, 2, 1], 8, 16, (-2 : Int)).2.1
      ([1, 0, 2, 1], 8, 16, (-2 : Int)).2.2.1 ([1, 0, 2, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s46.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 2, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s46
theorem z7UnaryRows1_s47 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 2, 2] 7 13 (-1 : Int))
    (z7UnaryCode1_s47.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s47_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 2, 2], 7, 13, (-1 : Int)).1 ([1, 0, 2, 2], 7, 13, (-1 : Int)).2.1
      ([1, 0, 2, 2], 7, 13, (-1 : Int)).2.2.1 ([1, 0, 2, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s47.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 2, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s47
theorem z7UnaryRows1_s48 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 2, 3] 6 8 (0 : Int))
    (z7UnaryCode1_s48.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s48_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 2, 3], 6, 8, (0 : Int)).1 ([1, 0, 2, 3], 6, 8, (0 : Int)).2.1
      ([1, 0, 2, 3], 6, 8, (0 : Int)).2.2.1 ([1, 0, 2, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode1_s48.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 2, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s48
theorem z7UnaryRows1_s49 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 2, 4] 5 1 (1 : Int))
    (z7UnaryCode1_s49.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s49_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 2, 4], 5, 1, (1 : Int)).1 ([1, 0, 2, 4], 5, 1, (1 : Int)).2.1
      ([1, 0, 2, 4], 5, 1, (1 : Int)).2.2.1 ([1, 0, 2, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode1_s49.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 2, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s49
theorem z7UnaryRows1_s50 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 3, 0] 8 12 (-4 : Int))
    (z7UnaryCode1_s50.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s50_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 3, 0], 8, 12, (-4 : Int)).1 ([1, 0, 3, 0], 8, 12, (-4 : Int)).2.1
      ([1, 0, 3, 0], 8, 12, (-4 : Int)).2.2.1 ([1, 0, 3, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s50.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 3, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s50
theorem z7UnaryRows1_s51 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 3, 1] 7 11 (-3 : Int))
    (z7UnaryCode1_s51.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s51_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 3, 1], 7, 11, (-3 : Int)).1 ([1, 0, 3, 1], 7, 11, (-3 : Int)).2.1
      ([1, 0, 3, 1], 7, 11, (-3 : Int)).2.2.1 ([1, 0, 3, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s51.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 3, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s51
theorem z7UnaryRows1_s52 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 3, 2] 6 8 (-2 : Int))
    (z7UnaryCode1_s52.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s52_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 3, 2], 6, 8, (-2 : Int)).1 ([1, 0, 3, 2], 6, 8, (-2 : Int)).2.1
      ([1, 0, 3, 2], 6, 8, (-2 : Int)).2.2.1 ([1, 0, 3, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s52.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 3, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s52
theorem z7UnaryRows1_s53 : rowsBeq
    (z7GenRow 8 1 4 [1, 0, 3, 3] 5 3 (-1 : Int))
    (z7UnaryCode1_s53.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s53_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 0, 3, 3], 5, 3, (-1 : Int)).1 ([1, 0, 3, 3], 5, 3, (-1 : Int)).2.1
      ([1, 0, 3, 3], 5, 3, (-1 : Int)).2.2.1 ([1, 0, 3, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s53.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 0, 3, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s53
theorem z7UnaryRows1_s54 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 0, 0] 9 15 (-3 : Int))
    (z7UnaryCode1_s54.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s54_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 0, 0], 9, 15, (-3 : Int)).1 ([1, 2, 0, 0], 9, 15, (-3 : Int)).2.1
      ([1, 2, 0, 0], 9, 15, (-3 : Int)).2.2.1 ([1, 2, 0, 0], 9, 15, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s54.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 0, 0] 9 15 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s54
theorem z7UnaryRows1_s55 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 0, 1] 8 14 (-2 : Int))
    (z7UnaryCode1_s55.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s55_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 0, 1], 8, 14, (-2 : Int)).1 ([1, 2, 0, 1], 8, 14, (-2 : Int)).2.1
      ([1, 2, 0, 1], 8, 14, (-2 : Int)).2.2.1 ([1, 2, 0, 1], 8, 14, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s55.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 0, 1] 8 14 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s55
theorem z7UnaryRows1_s56 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 0, 2] 7 11 (-1 : Int))
    (z7UnaryCode1_s56.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s56_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 0, 2], 7, 11, (-1 : Int)).1 ([1, 2, 0, 2], 7, 11, (-1 : Int)).2.1
      ([1, 2, 0, 2], 7, 11, (-1 : Int)).2.2.1 ([1, 2, 0, 2], 7, 11, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s56.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 0, 2] 7 11 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s56
theorem z7UnaryRows1_s57 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 0, 3] 6 6 (0 : Int))
    (z7UnaryCode1_s57.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s57_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 0, 3], 6, 6, (0 : Int)).1 ([1, 2, 0, 3], 6, 6, (0 : Int)).2.1
      ([1, 2, 0, 3], 6, 6, (0 : Int)).2.2.1 ([1, 2, 0, 3], 6, 6, (0 : Int)).2.2.2 =
    z7UnaryCode1_s57.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 0, 3] 6 6 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s57
theorem z7UnaryRows1_s58 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 1, 0] 8 14 (-4 : Int))
    (z7UnaryCode1_s58.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s58_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 1, 0], 8, 14, (-4 : Int)).1 ([1, 2, 1, 0], 8, 14, (-4 : Int)).2.1
      ([1, 2, 1, 0], 8, 14, (-4 : Int)).2.2.1 ([1, 2, 1, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s58.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 1, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s58
theorem z7UnaryRows1_s59 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 1, 1] 7 13 (-3 : Int))
    (z7UnaryCode1_s59.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s59_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 1, 1], 7, 13, (-3 : Int)).1 ([1, 2, 1, 1], 7, 13, (-3 : Int)).2.1
      ([1, 2, 1, 1], 7, 13, (-3 : Int)).2.2.1 ([1, 2, 1, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s59.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 1, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s59
theorem z7UnaryRows1_s60 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 1, 2] 6 10 (-2 : Int))
    (z7UnaryCode1_s60.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s60_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 1, 2], 6, 10, (-2 : Int)).1 ([1, 2, 1, 2], 6, 10, (-2 : Int)).2.1
      ([1, 2, 1, 2], 6, 10, (-2 : Int)).2.2.1 ([1, 2, 1, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s60.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 1, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s60
theorem z7UnaryRows1_s61 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 1, 3] 5 5 (-1 : Int))
    (z7UnaryCode1_s61.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s61_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 1, 3], 5, 5, (-1 : Int)).1 ([1, 2, 1, 3], 5, 5, (-1 : Int)).2.1
      ([1, 2, 1, 3], 5, 5, (-1 : Int)).2.2.1 ([1, 2, 1, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s61.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 1, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s61
theorem z7UnaryRows1_s62 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 2, 0] 7 11 (-5 : Int))
    (z7UnaryCode1_s62.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s62_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 2, 0], 7, 11, (-5 : Int)).1 ([1, 2, 2, 0], 7, 11, (-5 : Int)).2.1
      ([1, 2, 2, 0], 7, 11, (-5 : Int)).2.2.1 ([1, 2, 2, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s62.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 2, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s62
theorem z7UnaryRows1_s63 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 2, 1] 6 10 (-4 : Int))
    (z7UnaryCode1_s63.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s63_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 2, 1], 6, 10, (-4 : Int)).1 ([1, 2, 2, 1], 6, 10, (-4 : Int)).2.1
      ([1, 2, 2, 1], 6, 10, (-4 : Int)).2.2.1 ([1, 2, 2, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s63.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 2, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s63
theorem z7UnaryRows1_s64 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 2, 2] 5 7 (-3 : Int))
    (z7UnaryCode1_s64.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s64_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 2, 2], 5, 7, (-3 : Int)).1 ([1, 2, 2, 2], 5, 7, (-3 : Int)).2.1
      ([1, 2, 2, 2], 5, 7, (-3 : Int)).2.2.1 ([1, 2, 2, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s64.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 2, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s64
theorem z7UnaryRows1_s65 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 2, 3] 4 2 (-2 : Int))
    (z7UnaryCode1_s65.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s65_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 2, 3], 4, 2, (-2 : Int)).1 ([1, 2, 2, 3], 4, 2, (-2 : Int)).2.1
      ([1, 2, 2, 3], 4, 2, (-2 : Int)).2.2.1 ([1, 2, 2, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s65.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 2, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s65
theorem z7UnaryRows1_s66 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 3, 0] 6 6 (-6 : Int))
    (z7UnaryCode1_s66.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s66_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 3, 0], 6, 6, (-6 : Int)).1 ([1, 2, 3, 0], 6, 6, (-6 : Int)).2.1
      ([1, 2, 3, 0], 6, 6, (-6 : Int)).2.2.1 ([1, 2, 3, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode1_s66.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 3, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s66
theorem z7UnaryRows1_s67 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 3, 1] 5 5 (-5 : Int))
    (z7UnaryCode1_s67.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s67_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 3, 1], 5, 5, (-5 : Int)).1 ([1, 2, 3, 1], 5, 5, (-5 : Int)).2.1
      ([1, 2, 3, 1], 5, 5, (-5 : Int)).2.2.1 ([1, 2, 3, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s67.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 3, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s67
theorem z7UnaryRows1_s68 : rowsBeq
    (z7GenRow 8 1 4 [1, 2, 3, 2] 4 2 (-4 : Int))
    (z7UnaryCode1_s68.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s68_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([1, 2, 3, 2], 4, 2, (-4 : Int)).1 ([1, 2, 3, 2], 4, 2, (-4 : Int)).2.1
      ([1, 2, 3, 2], 4, 2, (-4 : Int)).2.2.1 ([1, 2, 3, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s68.map z7DecodeRow := by
  show z7GenRow 8 1 4 [1, 2, 3, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s68
theorem z7UnaryRows1_s69 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 0, 0] 10 18 (-2 : Int))
    (z7UnaryCode1_s69.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s69_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 0, 0], 10, 18, (-2 : Int)).1 ([2, 0, 0, 0], 10, 18, (-2 : Int)).2.1
      ([2, 0, 0, 0], 10, 18, (-2 : Int)).2.2.1 ([2, 0, 0, 0], 10, 18, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s69.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 0, 0] 10 18 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s69
theorem z7UnaryRows1_s70 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 0, 1] 9 17 (-1 : Int))
    (z7UnaryCode1_s70.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s70_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 0, 1], 9, 17, (-1 : Int)).1 ([2, 0, 0, 1], 9, 17, (-1 : Int)).2.1
      ([2, 0, 0, 1], 9, 17, (-1 : Int)).2.2.1 ([2, 0, 0, 1], 9, 17, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s70.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 0, 1] 9 17 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s70
theorem z7UnaryRows1_s71 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 0, 2] 8 14 (0 : Int))
    (z7UnaryCode1_s71.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s71_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 0, 2], 8, 14, (0 : Int)).1 ([2, 0, 0, 2], 8, 14, (0 : Int)).2.1
      ([2, 0, 0, 2], 8, 14, (0 : Int)).2.2.1 ([2, 0, 0, 2], 8, 14, (0 : Int)).2.2.2 =
    z7UnaryCode1_s71.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 0, 2] 8 14 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s71
theorem z7UnaryRows1_s72 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 0, 3] 7 9 (1 : Int))
    (z7UnaryCode1_s72.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s72_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 0, 3], 7, 9, (1 : Int)).1 ([2, 0, 0, 3], 7, 9, (1 : Int)).2.1
      ([2, 0, 0, 3], 7, 9, (1 : Int)).2.2.1 ([2, 0, 0, 3], 7, 9, (1 : Int)).2.2.2 =
    z7UnaryCode1_s72.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 0, 3] 7 9 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s72
theorem z7UnaryRows1_s73 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 0, 4] 6 2 (2 : Int))
    (z7UnaryCode1_s73.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s73_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 0, 4], 6, 2, (2 : Int)).1 ([2, 0, 0, 4], 6, 2, (2 : Int)).2.1
      ([2, 0, 0, 4], 6, 2, (2 : Int)).2.2.1 ([2, 0, 0, 4], 6, 2, (2 : Int)).2.2.2 =
    z7UnaryCode1_s73.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 0, 4] 6 2 (2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s73
theorem z7UnaryRows1_s74 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 1, 0] 9 17 (-3 : Int))
    (z7UnaryCode1_s74.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s74_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 1, 0], 9, 17, (-3 : Int)).1 ([2, 0, 1, 0], 9, 17, (-3 : Int)).2.1
      ([2, 0, 1, 0], 9, 17, (-3 : Int)).2.2.1 ([2, 0, 1, 0], 9, 17, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s74.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 1, 0] 9 17 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s74
theorem z7UnaryRows1_s75 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 1, 1] 8 16 (-2 : Int))
    (z7UnaryCode1_s75.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s75_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 1, 1], 8, 16, (-2 : Int)).1 ([2, 0, 1, 1], 8, 16, (-2 : Int)).2.1
      ([2, 0, 1, 1], 8, 16, (-2 : Int)).2.2.1 ([2, 0, 1, 1], 8, 16, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s75.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 1, 1] 8 16 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s75
theorem z7UnaryRows1_s76 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 1, 2] 7 13 (-1 : Int))
    (z7UnaryCode1_s76.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s76_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 1, 2], 7, 13, (-1 : Int)).1 ([2, 0, 1, 2], 7, 13, (-1 : Int)).2.1
      ([2, 0, 1, 2], 7, 13, (-1 : Int)).2.2.1 ([2, 0, 1, 2], 7, 13, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s76.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 1, 2] 7 13 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s76
theorem z7UnaryRows1_s77 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 1, 3] 6 8 (0 : Int))
    (z7UnaryCode1_s77.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s77_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 1, 3], 6, 8, (0 : Int)).1 ([2, 0, 1, 3], 6, 8, (0 : Int)).2.1
      ([2, 0, 1, 3], 6, 8, (0 : Int)).2.2.1 ([2, 0, 1, 3], 6, 8, (0 : Int)).2.2.2 =
    z7UnaryCode1_s77.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 1, 3] 6 8 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s77
theorem z7UnaryRows1_s78 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 1, 4] 5 1 (1 : Int))
    (z7UnaryCode1_s78.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s78_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 1, 4], 5, 1, (1 : Int)).1 ([2, 0, 1, 4], 5, 1, (1 : Int)).2.1
      ([2, 0, 1, 4], 5, 1, (1 : Int)).2.2.1 ([2, 0, 1, 4], 5, 1, (1 : Int)).2.2.2 =
    z7UnaryCode1_s78.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 1, 4] 5 1 (1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s78
theorem z7UnaryRows1_s79 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 2, 0] 8 14 (-4 : Int))
    (z7UnaryCode1_s79.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s79_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 2, 0], 8, 14, (-4 : Int)).1 ([2, 0, 2, 0], 8, 14, (-4 : Int)).2.1
      ([2, 0, 2, 0], 8, 14, (-4 : Int)).2.2.1 ([2, 0, 2, 0], 8, 14, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s79.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 2, 0] 8 14 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s79
theorem z7UnaryRows1_s80 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 2, 1] 7 13 (-3 : Int))
    (z7UnaryCode1_s80.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s80_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 2, 1], 7, 13, (-3 : Int)).1 ([2, 0, 2, 1], 7, 13, (-3 : Int)).2.1
      ([2, 0, 2, 1], 7, 13, (-3 : Int)).2.2.1 ([2, 0, 2, 1], 7, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s80.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 2, 1] 7 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s80
theorem z7UnaryRows1_s81 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 2, 2] 6 10 (-2 : Int))
    (z7UnaryCode1_s81.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s81_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 2, 2], 6, 10, (-2 : Int)).1 ([2, 0, 2, 2], 6, 10, (-2 : Int)).2.1
      ([2, 0, 2, 2], 6, 10, (-2 : Int)).2.2.1 ([2, 0, 2, 2], 6, 10, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s81.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 2, 2] 6 10 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s81
theorem z7UnaryRows1_s82 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 2, 3] 5 5 (-1 : Int))
    (z7UnaryCode1_s82.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s82_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 2, 3], 5, 5, (-1 : Int)).1 ([2, 0, 2, 3], 5, 5, (-1 : Int)).2.1
      ([2, 0, 2, 3], 5, 5, (-1 : Int)).2.2.1 ([2, 0, 2, 3], 5, 5, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s82.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 2, 3] 5 5 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s82
theorem z7UnaryRows1_s83 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 3, 0] 7 9 (-5 : Int))
    (z7UnaryCode1_s83.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s83_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 3, 0], 7, 9, (-5 : Int)).1 ([2, 0, 3, 0], 7, 9, (-5 : Int)).2.1
      ([2, 0, 3, 0], 7, 9, (-5 : Int)).2.2.1 ([2, 0, 3, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s83.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 3, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s83
theorem z7UnaryRows1_s84 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 3, 1] 6 8 (-4 : Int))
    (z7UnaryCode1_s84.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s84_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 3, 1], 6, 8, (-4 : Int)).1 ([2, 0, 3, 1], 6, 8, (-4 : Int)).2.1
      ([2, 0, 3, 1], 6, 8, (-4 : Int)).2.2.1 ([2, 0, 3, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s84.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 3, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s84
theorem z7UnaryRows1_s85 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 3, 2] 5 5 (-3 : Int))
    (z7UnaryCode1_s85.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s85_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 3, 2], 5, 5, (-3 : Int)).1 ([2, 0, 3, 2], 5, 5, (-3 : Int)).2.1
      ([2, 0, 3, 2], 5, 5, (-3 : Int)).2.2.1 ([2, 0, 3, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s85.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 3, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s85
theorem z7UnaryRows1_s86 : rowsBeq
    (z7GenRow 8 1 4 [2, 0, 3, 3] 4 0 (-2 : Int))
    (z7UnaryCode1_s86.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s86_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 0, 3, 3], 4, 0, (-2 : Int)).1 ([2, 0, 3, 3], 4, 0, (-2 : Int)).2.1
      ([2, 0, 3, 3], 4, 0, (-2 : Int)).2.2.1 ([2, 0, 3, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s86.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 0, 3, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s86
theorem z7UnaryRows1_s87 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 0, 0] 8 12 (-4 : Int))
    (z7UnaryCode1_s87.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s87_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 0, 0], 8, 12, (-4 : Int)).1 ([2, 2, 0, 0], 8, 12, (-4 : Int)).2.1
      ([2, 2, 0, 0], 8, 12, (-4 : Int)).2.2.1 ([2, 2, 0, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s87.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 0, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s87
theorem z7UnaryRows1_s88 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 0, 1] 7 11 (-3 : Int))
    (z7UnaryCode1_s88.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s88_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 0, 1], 7, 11, (-3 : Int)).1 ([2, 2, 0, 1], 7, 11, (-3 : Int)).2.1
      ([2, 2, 0, 1], 7, 11, (-3 : Int)).2.2.1 ([2, 2, 0, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s88.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 0, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s88
theorem z7UnaryRows1_s89 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 0, 2] 6 8 (-2 : Int))
    (z7UnaryCode1_s89.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s89_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 0, 2], 6, 8, (-2 : Int)).1 ([2, 2, 0, 2], 6, 8, (-2 : Int)).2.1
      ([2, 2, 0, 2], 6, 8, (-2 : Int)).2.2.1 ([2, 2, 0, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s89.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 0, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s89
theorem z7UnaryRows1_s90 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 0, 3] 5 3 (-1 : Int))
    (z7UnaryCode1_s90.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s90_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 0, 3], 5, 3, (-1 : Int)).1 ([2, 2, 0, 3], 5, 3, (-1 : Int)).2.1
      ([2, 2, 0, 3], 5, 3, (-1 : Int)).2.2.1 ([2, 2, 0, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s90.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 0, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s90
theorem z7UnaryRows1_s91 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 1, 0] 7 11 (-5 : Int))
    (z7UnaryCode1_s91.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s91_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 1, 0], 7, 11, (-5 : Int)).1 ([2, 2, 1, 0], 7, 11, (-5 : Int)).2.1
      ([2, 2, 1, 0], 7, 11, (-5 : Int)).2.2.1 ([2, 2, 1, 0], 7, 11, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s91.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 1, 0] 7 11 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s91
theorem z7UnaryRows1_s92 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 1, 1] 6 10 (-4 : Int))
    (z7UnaryCode1_s92.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s92_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 1, 1], 6, 10, (-4 : Int)).1 ([2, 2, 1, 1], 6, 10, (-4 : Int)).2.1
      ([2, 2, 1, 1], 6, 10, (-4 : Int)).2.2.1 ([2, 2, 1, 1], 6, 10, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s92.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 1, 1] 6 10 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s92
theorem z7UnaryRows1_s93 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 1, 2] 5 7 (-3 : Int))
    (z7UnaryCode1_s93.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s93_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 1, 2], 5, 7, (-3 : Int)).1 ([2, 2, 1, 2], 5, 7, (-3 : Int)).2.1
      ([2, 2, 1, 2], 5, 7, (-3 : Int)).2.2.1 ([2, 2, 1, 2], 5, 7, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s93.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 1, 2] 5 7 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s93
theorem z7UnaryRows1_s94 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 1, 3] 4 2 (-2 : Int))
    (z7UnaryCode1_s94.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s94_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 1, 3], 4, 2, (-2 : Int)).1 ([2, 2, 1, 3], 4, 2, (-2 : Int)).2.1
      ([2, 2, 1, 3], 4, 2, (-2 : Int)).2.2.1 ([2, 2, 1, 3], 4, 2, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s94.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 1, 3] 4 2 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s94
theorem z7UnaryRows1_s95 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 2, 0] 6 8 (-6 : Int))
    (z7UnaryCode1_s95.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s95_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 2, 0], 6, 8, (-6 : Int)).1 ([2, 2, 2, 0], 6, 8, (-6 : Int)).2.1
      ([2, 2, 2, 0], 6, 8, (-6 : Int)).2.2.1 ([2, 2, 2, 0], 6, 8, (-6 : Int)).2.2.2 =
    z7UnaryCode1_s95.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 2, 0] 6 8 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s95
theorem z7UnaryRows1_s96 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 2, 1] 5 7 (-5 : Int))
    (z7UnaryCode1_s96.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s96_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 2, 1], 5, 7, (-5 : Int)).1 ([2, 2, 2, 1], 5, 7, (-5 : Int)).2.1
      ([2, 2, 2, 1], 5, 7, (-5 : Int)).2.2.1 ([2, 2, 2, 1], 5, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s96.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 2, 1] 5 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s96
theorem z7UnaryRows1_s97 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 2, 2] 4 4 (-4 : Int))
    (z7UnaryCode1_s97.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s97_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 2, 2], 4, 4, (-4 : Int)).1 ([2, 2, 2, 2], 4, 4, (-4 : Int)).2.1
      ([2, 2, 2, 2], 4, 4, (-4 : Int)).2.2.1 ([2, 2, 2, 2], 4, 4, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s97.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 2, 2] 4 4 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s97
theorem z7UnaryRows1_s98 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 3, 0] 5 3 (-7 : Int))
    (z7UnaryCode1_s98.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s98_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 3, 0], 5, 3, (-7 : Int)).1 ([2, 2, 3, 0], 5, 3, (-7 : Int)).2.1
      ([2, 2, 3, 0], 5, 3, (-7 : Int)).2.2.1 ([2, 2, 3, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode1_s98.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 3, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s98
theorem z7UnaryRows1_s99 : rowsBeq
    (z7GenRow 8 1 4 [2, 2, 3, 1] 4 2 (-6 : Int))
    (z7UnaryCode1_s99.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s99_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([2, 2, 3, 1], 4, 2, (-6 : Int)).1 ([2, 2, 3, 1], 4, 2, (-6 : Int)).2.1
      ([2, 2, 3, 1], 4, 2, (-6 : Int)).2.2.1 ([2, 2, 3, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode1_s99.map z7DecodeRow := by
  show z7GenRow 8 1 4 [2, 2, 3, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s99
theorem z7UnaryRows1_s100 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 0, 0] 9 13 (-3 : Int))
    (z7UnaryCode1_s100.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s100_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 0, 0], 9, 13, (-3 : Int)).1 ([3, 0, 0, 0], 9, 13, (-3 : Int)).2.1
      ([3, 0, 0, 0], 9, 13, (-3 : Int)).2.2.1 ([3, 0, 0, 0], 9, 13, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s100.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 0, 0] 9 13 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s100
theorem z7UnaryRows1_s101 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 0, 1] 8 12 (-2 : Int))
    (z7UnaryCode1_s101.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s101_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 0, 1], 8, 12, (-2 : Int)).1 ([3, 0, 0, 1], 8, 12, (-2 : Int)).2.1
      ([3, 0, 0, 1], 8, 12, (-2 : Int)).2.2.1 ([3, 0, 0, 1], 8, 12, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s101.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 0, 1] 8 12 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s101
theorem z7UnaryRows1_s102 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 0, 2] 7 9 (-1 : Int))
    (z7UnaryCode1_s102.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s102_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 0, 2], 7, 9, (-1 : Int)).1 ([3, 0, 0, 2], 7, 9, (-1 : Int)).2.1
      ([3, 0, 0, 2], 7, 9, (-1 : Int)).2.2.1 ([3, 0, 0, 2], 7, 9, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s102.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 0, 2] 7 9 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s102
theorem z7UnaryRows1_s103 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 0, 3] 6 4 (0 : Int))
    (z7UnaryCode1_s103.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s103_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 0, 3], 6, 4, (0 : Int)).1 ([3, 0, 0, 3], 6, 4, (0 : Int)).2.1
      ([3, 0, 0, 3], 6, 4, (0 : Int)).2.2.1 ([3, 0, 0, 3], 6, 4, (0 : Int)).2.2.2 =
    z7UnaryCode1_s103.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 0, 3] 6 4 (0 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s103
theorem z7UnaryRows1_s104 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 1, 0] 8 12 (-4 : Int))
    (z7UnaryCode1_s104.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s104_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 1, 0], 8, 12, (-4 : Int)).1 ([3, 0, 1, 0], 8, 12, (-4 : Int)).2.1
      ([3, 0, 1, 0], 8, 12, (-4 : Int)).2.2.1 ([3, 0, 1, 0], 8, 12, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s104.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 1, 0] 8 12 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s104
theorem z7UnaryRows1_s105 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 1, 1] 7 11 (-3 : Int))
    (z7UnaryCode1_s105.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s105_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 1, 1], 7, 11, (-3 : Int)).1 ([3, 0, 1, 1], 7, 11, (-3 : Int)).2.1
      ([3, 0, 1, 1], 7, 11, (-3 : Int)).2.2.1 ([3, 0, 1, 1], 7, 11, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s105.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 1, 1] 7 11 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s105
theorem z7UnaryRows1_s106 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 1, 2] 6 8 (-2 : Int))
    (z7UnaryCode1_s106.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s106_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 1, 2], 6, 8, (-2 : Int)).1 ([3, 0, 1, 2], 6, 8, (-2 : Int)).2.1
      ([3, 0, 1, 2], 6, 8, (-2 : Int)).2.2.1 ([3, 0, 1, 2], 6, 8, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s106.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 1, 2] 6 8 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s106
theorem z7UnaryRows1_s107 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 1, 3] 5 3 (-1 : Int))
    (z7UnaryCode1_s107.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s107_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 1, 3], 5, 3, (-1 : Int)).1 ([3, 0, 1, 3], 5, 3, (-1 : Int)).2.1
      ([3, 0, 1, 3], 5, 3, (-1 : Int)).2.2.1 ([3, 0, 1, 3], 5, 3, (-1 : Int)).2.2.2 =
    z7UnaryCode1_s107.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 1, 3] 5 3 (-1 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s107
theorem z7UnaryRows1_s108 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 2, 0] 7 9 (-5 : Int))
    (z7UnaryCode1_s108.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s108_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 2, 0], 7, 9, (-5 : Int)).1 ([3, 0, 2, 0], 7, 9, (-5 : Int)).2.1
      ([3, 0, 2, 0], 7, 9, (-5 : Int)).2.2.1 ([3, 0, 2, 0], 7, 9, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s108.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 2, 0] 7 9 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s108
theorem z7UnaryRows1_s109 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 2, 1] 6 8 (-4 : Int))
    (z7UnaryCode1_s109.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s109_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 2, 1], 6, 8, (-4 : Int)).1 ([3, 0, 2, 1], 6, 8, (-4 : Int)).2.1
      ([3, 0, 2, 1], 6, 8, (-4 : Int)).2.2.1 ([3, 0, 2, 1], 6, 8, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s109.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 2, 1] 6 8 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s109
theorem z7UnaryRows1_s110 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 2, 2] 5 5 (-3 : Int))
    (z7UnaryCode1_s110.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s110_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 2, 2], 5, 5, (-3 : Int)).1 ([3, 0, 2, 2], 5, 5, (-3 : Int)).2.1
      ([3, 0, 2, 2], 5, 5, (-3 : Int)).2.2.1 ([3, 0, 2, 2], 5, 5, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s110.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 2, 2] 5 5 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s110
theorem z7UnaryRows1_s111 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 2, 3] 4 0 (-2 : Int))
    (z7UnaryCode1_s111.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s111_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 2, 3], 4, 0, (-2 : Int)).1 ([3, 0, 2, 3], 4, 0, (-2 : Int)).2.1
      ([3, 0, 2, 3], 4, 0, (-2 : Int)).2.2.1 ([3, 0, 2, 3], 4, 0, (-2 : Int)).2.2.2 =
    z7UnaryCode1_s111.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 2, 3] 4 0 (-2 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s111
theorem z7UnaryRows1_s112 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 3, 0] 6 4 (-6 : Int))
    (z7UnaryCode1_s112.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s112_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 3, 0], 6, 4, (-6 : Int)).1 ([3, 0, 3, 0], 6, 4, (-6 : Int)).2.1
      ([3, 0, 3, 0], 6, 4, (-6 : Int)).2.2.1 ([3, 0, 3, 0], 6, 4, (-6 : Int)).2.2.2 =
    z7UnaryCode1_s112.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 3, 0] 6 4 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s112
theorem z7UnaryRows1_s113 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 3, 1] 5 3 (-5 : Int))
    (z7UnaryCode1_s113.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s113_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 3, 1], 5, 3, (-5 : Int)).1 ([3, 0, 3, 1], 5, 3, (-5 : Int)).2.1
      ([3, 0, 3, 1], 5, 3, (-5 : Int)).2.2.1 ([3, 0, 3, 1], 5, 3, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s113.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 3, 1] 5 3 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s113
theorem z7UnaryRows1_s114 : rowsBeq
    (z7GenRow 8 1 4 [3, 0, 3, 2] 4 0 (-4 : Int))
    (z7UnaryCode1_s114.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s114_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 0, 3, 2], 4, 0, (-4 : Int)).1 ([3, 0, 3, 2], 4, 0, (-4 : Int)).2.1
      ([3, 0, 3, 2], 4, 0, (-4 : Int)).2.2.1 ([3, 0, 3, 2], 4, 0, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s114.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 0, 3, 2] 4 0 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s114
theorem z7UnaryRows1_s115 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 0, 0] 7 7 (-5 : Int))
    (z7UnaryCode1_s115.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s115_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 0, 0], 7, 7, (-5 : Int)).1 ([3, 2, 0, 0], 7, 7, (-5 : Int)).2.1
      ([3, 2, 0, 0], 7, 7, (-5 : Int)).2.2.1 ([3, 2, 0, 0], 7, 7, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s115.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 0, 0] 7 7 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s115
theorem z7UnaryRows1_s116 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 0, 1] 6 6 (-4 : Int))
    (z7UnaryCode1_s116.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s116_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 0, 1], 6, 6, (-4 : Int)).1 ([3, 2, 0, 1], 6, 6, (-4 : Int)).2.1
      ([3, 2, 0, 1], 6, 6, (-4 : Int)).2.2.1 ([3, 2, 0, 1], 6, 6, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s116.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 0, 1] 6 6 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s116
theorem z7UnaryRows1_s117 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 0, 2] 5 3 (-3 : Int))
    (z7UnaryCode1_s117.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s117_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 0, 2], 5, 3, (-3 : Int)).1 ([3, 2, 0, 2], 5, 3, (-3 : Int)).2.1
      ([3, 2, 0, 2], 5, 3, (-3 : Int)).2.2.1 ([3, 2, 0, 2], 5, 3, (-3 : Int)).2.2.2 =
    z7UnaryCode1_s117.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 0, 2] 5 3 (-3 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s117
theorem z7UnaryRows1_s118 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 1, 0] 6 6 (-6 : Int))
    (z7UnaryCode1_s118.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s118_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 1, 0], 6, 6, (-6 : Int)).1 ([3, 2, 1, 0], 6, 6, (-6 : Int)).2.1
      ([3, 2, 1, 0], 6, 6, (-6 : Int)).2.2.1 ([3, 2, 1, 0], 6, 6, (-6 : Int)).2.2.2 =
    z7UnaryCode1_s118.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 1, 0] 6 6 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s118
theorem z7UnaryRows1_s119 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 1, 1] 5 5 (-5 : Int))
    (z7UnaryCode1_s119.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s119_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 1, 1], 5, 5, (-5 : Int)).1 ([3, 2, 1, 1], 5, 5, (-5 : Int)).2.1
      ([3, 2, 1, 1], 5, 5, (-5 : Int)).2.2.1 ([3, 2, 1, 1], 5, 5, (-5 : Int)).2.2.2 =
    z7UnaryCode1_s119.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 1, 1] 5 5 (-5 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s119
theorem z7UnaryRows1_s120 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 1, 2] 4 2 (-4 : Int))
    (z7UnaryCode1_s120.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s120_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 1, 2], 4, 2, (-4 : Int)).1 ([3, 2, 1, 2], 4, 2, (-4 : Int)).2.1
      ([3, 2, 1, 2], 4, 2, (-4 : Int)).2.2.1 ([3, 2, 1, 2], 4, 2, (-4 : Int)).2.2.2 =
    z7UnaryCode1_s120.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 1, 2] 4 2 (-4 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s120
theorem z7UnaryRows1_s121 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 2, 0] 5 3 (-7 : Int))
    (z7UnaryCode1_s121.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s121_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 2, 0], 5, 3, (-7 : Int)).1 ([3, 2, 2, 0], 5, 3, (-7 : Int)).2.1
      ([3, 2, 2, 0], 5, 3, (-7 : Int)).2.2.1 ([3, 2, 2, 0], 5, 3, (-7 : Int)).2.2.2 =
    z7UnaryCode1_s121.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 2, 0] 5 3 (-7 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s121
theorem z7UnaryRows1_s122 : rowsBeq
    (z7GenRow 8 1 4 [3, 2, 2, 1] 4 2 (-6 : Int))
    (z7UnaryCode1_s122.map z7DecodeRow) = true := by
  decide +kernel

theorem z7UnaryRows1_s122_eq :
    z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) ([3, 2, 2, 1], 4, 2, (-6 : Int)).1 ([3, 2, 2, 1], 4, 2, (-6 : Int)).2.1
      ([3, 2, 2, 1], 4, 2, (-6 : Int)).2.2.1 ([3, 2, 2, 1], 4, 2, (-6 : Int)).2.2.2 =
    z7UnaryCode1_s122.map z7DecodeRow := by
  show z7GenRow 8 1 4 [3, 2, 2, 1] 4 2 (-6 : Int) = _
  exact rowsBeq_sound z7UnaryRows1_s122

/-- flatMap of state group 0 equals the joined decoded slices. -/
theorem z7Grp_1_0 :
    ([([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s0.map z7DecodeRow ++ (z7UnaryCode1_s1.map z7DecodeRow ++ (z7UnaryCode1_s2.map z7DecodeRow ++ (z7UnaryCode1_s3.map z7DecodeRow ++ (z7UnaryCode1_s4.map z7DecodeRow ++ (z7UnaryCode1_s5.map z7DecodeRow ++ (z7UnaryCode1_s6.map z7DecodeRow ++ (z7UnaryCode1_s7.map z7DecodeRow ++ (z7UnaryCode1_s8.map z7DecodeRow ++ (z7UnaryCode1_s9.map z7DecodeRow ++ (z7UnaryCode1_s10.map z7DecodeRow ++ (z7UnaryCode1_s11.map z7DecodeRow ++ (z7UnaryCode1_s12.map z7DecodeRow ++ (z7UnaryCode1_s13.map z7DecodeRow ++ (z7UnaryCode1_s14.map z7DecodeRow ++ (z7UnaryCode1_s15.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s0_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s1_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s2_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s3_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s4_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s5_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s6_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s7_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s8_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s9_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s10_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s11_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s12_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s13_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s14_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s15_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 1 equals the joined decoded slices. -/
theorem z7Grp_1_1 :
    ([([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 2, 0, 0], 10, 16, (-2 : Int)), ([0, 2, 0, 1], 9, 15, (-1 : Int)), ([0, 2, 0, 2], 8, 12, (0 : Int)), ([0, 2, 0, 3], 7, 7, (1 : Int)), ([0, 2, 0, 4], 6, 0, (2 : Int)), ([0, 2, 1, 0], 9, 15, (-3 : Int)), ([0, 2, 1, 1], 8, 14, (-2 : Int)), ([0, 2, 1, 2], 7, 11, (-1 : Int)), ([0, 2, 1, 3], 6, 6, (0 : Int)), ([0, 2, 2, 0], 8, 12, (-4 : Int)), ([0, 2, 2, 1], 7, 11, (-3 : Int)), ([0, 2, 2, 2], 6, 8, (-2 : Int)), ([0, 2, 2, 3], 5, 3, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s16.map z7DecodeRow ++ (z7UnaryCode1_s17.map z7DecodeRow ++ (z7UnaryCode1_s18.map z7DecodeRow ++ (z7UnaryCode1_s19.map z7DecodeRow ++ (z7UnaryCode1_s20.map z7DecodeRow ++ (z7UnaryCode1_s21.map z7DecodeRow ++ (z7UnaryCode1_s22.map z7DecodeRow ++ (z7UnaryCode1_s23.map z7DecodeRow ++ (z7UnaryCode1_s24.map z7DecodeRow ++ (z7UnaryCode1_s25.map z7DecodeRow ++ (z7UnaryCode1_s26.map z7DecodeRow ++ (z7UnaryCode1_s27.map z7DecodeRow ++ (z7UnaryCode1_s28.map z7DecodeRow ++ (z7UnaryCode1_s29.map z7DecodeRow ++ (z7UnaryCode1_s30.map z7DecodeRow ++ (z7UnaryCode1_s31.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s16_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s17_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s18_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s19_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s20_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s21_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s22_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s23_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s24_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s25_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s26_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s27_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s28_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s29_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s30_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s31_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 2 equals the joined decoded slices. -/
theorem z7Grp_1_2 :
    ([([0, 2, 3, 0], 7, 7, (-5 : Int)), ([0, 2, 3, 1], 6, 6, (-4 : Int)), ([0, 2, 3, 2], 5, 3, (-3 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int)), ([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s32.map z7DecodeRow ++ (z7UnaryCode1_s33.map z7DecodeRow ++ (z7UnaryCode1_s34.map z7DecodeRow ++ (z7UnaryCode1_s35.map z7DecodeRow ++ (z7UnaryCode1_s36.map z7DecodeRow ++ (z7UnaryCode1_s37.map z7DecodeRow ++ (z7UnaryCode1_s38.map z7DecodeRow ++ (z7UnaryCode1_s39.map z7DecodeRow ++ (z7UnaryCode1_s40.map z7DecodeRow ++ (z7UnaryCode1_s41.map z7DecodeRow ++ (z7UnaryCode1_s42.map z7DecodeRow ++ (z7UnaryCode1_s43.map z7DecodeRow ++ (z7UnaryCode1_s44.map z7DecodeRow ++ (z7UnaryCode1_s45.map z7DecodeRow ++ (z7UnaryCode1_s46.map z7DecodeRow ++ (z7UnaryCode1_s47.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s32_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s33_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s34_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s35_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s36_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s37_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s38_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s39_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s40_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s41_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s42_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s43_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s44_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s45_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s46_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s47_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 3 equals the joined decoded slices. -/
theorem z7Grp_1_3 :
    ([([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 2, 0, 0], 9, 15, (-3 : Int)), ([1, 2, 0, 1], 8, 14, (-2 : Int)), ([1, 2, 0, 2], 7, 11, (-1 : Int)), ([1, 2, 0, 3], 6, 6, (0 : Int)), ([1, 2, 1, 0], 8, 14, (-4 : Int)), ([1, 2, 1, 1], 7, 13, (-3 : Int)), ([1, 2, 1, 2], 6, 10, (-2 : Int)), ([1, 2, 1, 3], 5, 5, (-1 : Int)), ([1, 2, 2, 0], 7, 11, (-5 : Int)), ([1, 2, 2, 1], 6, 10, (-4 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s48.map z7DecodeRow ++ (z7UnaryCode1_s49.map z7DecodeRow ++ (z7UnaryCode1_s50.map z7DecodeRow ++ (z7UnaryCode1_s51.map z7DecodeRow ++ (z7UnaryCode1_s52.map z7DecodeRow ++ (z7UnaryCode1_s53.map z7DecodeRow ++ (z7UnaryCode1_s54.map z7DecodeRow ++ (z7UnaryCode1_s55.map z7DecodeRow ++ (z7UnaryCode1_s56.map z7DecodeRow ++ (z7UnaryCode1_s57.map z7DecodeRow ++ (z7UnaryCode1_s58.map z7DecodeRow ++ (z7UnaryCode1_s59.map z7DecodeRow ++ (z7UnaryCode1_s60.map z7DecodeRow ++ (z7UnaryCode1_s61.map z7DecodeRow ++ (z7UnaryCode1_s62.map z7DecodeRow ++ (z7UnaryCode1_s63.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s48_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s49_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s50_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s51_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s52_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s53_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s54_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s55_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s56_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s57_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s58_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s59_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s60_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s61_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s62_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s63_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 4 equals the joined decoded slices. -/
theorem z7Grp_1_4 :
    ([([1, 2, 2, 2], 5, 7, (-3 : Int)), ([1, 2, 2, 3], 4, 2, (-2 : Int)), ([1, 2, 3, 0], 6, 6, (-6 : Int)), ([1, 2, 3, 1], 5, 5, (-5 : Int)), ([1, 2, 3, 2], 4, 2, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s64.map z7DecodeRow ++ (z7UnaryCode1_s65.map z7DecodeRow ++ (z7UnaryCode1_s66.map z7DecodeRow ++ (z7UnaryCode1_s67.map z7DecodeRow ++ (z7UnaryCode1_s68.map z7DecodeRow ++ (z7UnaryCode1_s69.map z7DecodeRow ++ (z7UnaryCode1_s70.map z7DecodeRow ++ (z7UnaryCode1_s71.map z7DecodeRow ++ (z7UnaryCode1_s72.map z7DecodeRow ++ (z7UnaryCode1_s73.map z7DecodeRow ++ (z7UnaryCode1_s74.map z7DecodeRow ++ (z7UnaryCode1_s75.map z7DecodeRow ++ (z7UnaryCode1_s76.map z7DecodeRow ++ (z7UnaryCode1_s77.map z7DecodeRow ++ (z7UnaryCode1_s78.map z7DecodeRow ++ (z7UnaryCode1_s79.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s64_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s65_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s66_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s67_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s68_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s69_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s70_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s71_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s72_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s73_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s74_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s75_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s76_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s77_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s78_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s79_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 5 equals the joined decoded slices. -/
theorem z7Grp_1_5 :
    ([([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int)), ([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 2, 0, 0], 8, 12, (-4 : Int)), ([2, 2, 0, 1], 7, 11, (-3 : Int)), ([2, 2, 0, 2], 6, 8, (-2 : Int)), ([2, 2, 0, 3], 5, 3, (-1 : Int)), ([2, 2, 1, 0], 7, 11, (-5 : Int)), ([2, 2, 1, 1], 6, 10, (-4 : Int)), ([2, 2, 1, 2], 5, 7, (-3 : Int)), ([2, 2, 1, 3], 4, 2, (-2 : Int)), ([2, 2, 2, 0], 6, 8, (-6 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s80.map z7DecodeRow ++ (z7UnaryCode1_s81.map z7DecodeRow ++ (z7UnaryCode1_s82.map z7DecodeRow ++ (z7UnaryCode1_s83.map z7DecodeRow ++ (z7UnaryCode1_s84.map z7DecodeRow ++ (z7UnaryCode1_s85.map z7DecodeRow ++ (z7UnaryCode1_s86.map z7DecodeRow ++ (z7UnaryCode1_s87.map z7DecodeRow ++ (z7UnaryCode1_s88.map z7DecodeRow ++ (z7UnaryCode1_s89.map z7DecodeRow ++ (z7UnaryCode1_s90.map z7DecodeRow ++ (z7UnaryCode1_s91.map z7DecodeRow ++ (z7UnaryCode1_s92.map z7DecodeRow ++ (z7UnaryCode1_s93.map z7DecodeRow ++ (z7UnaryCode1_s94.map z7DecodeRow ++ (z7UnaryCode1_s95.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s80_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s81_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s82_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s83_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s84_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s85_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s86_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s87_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s88_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s89_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s90_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s91_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s92_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s93_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s94_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s95_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 6 equals the joined decoded slices. -/
theorem z7Grp_1_6 :
    ([([2, 2, 2, 1], 5, 7, (-5 : Int)), ([2, 2, 2, 2], 4, 4, (-4 : Int)), ([2, 2, 3, 0], 5, 3, (-7 : Int)), ([2, 2, 3, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int)), ([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s96.map z7DecodeRow ++ (z7UnaryCode1_s97.map z7DecodeRow ++ (z7UnaryCode1_s98.map z7DecodeRow ++ (z7UnaryCode1_s99.map z7DecodeRow ++ (z7UnaryCode1_s100.map z7DecodeRow ++ (z7UnaryCode1_s101.map z7DecodeRow ++ (z7UnaryCode1_s102.map z7DecodeRow ++ (z7UnaryCode1_s103.map z7DecodeRow ++ (z7UnaryCode1_s104.map z7DecodeRow ++ (z7UnaryCode1_s105.map z7DecodeRow ++ (z7UnaryCode1_s106.map z7DecodeRow ++ (z7UnaryCode1_s107.map z7DecodeRow ++ (z7UnaryCode1_s108.map z7DecodeRow ++ (z7UnaryCode1_s109.map z7DecodeRow ++ (z7UnaryCode1_s110.map z7DecodeRow ++ (z7UnaryCode1_s111.map z7DecodeRow))))))))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s96_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s97_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s98_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s99_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s100_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s101_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s102_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s103_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s104_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s105_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s106_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s107_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s108_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s109_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s110_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s111_eq]
  rw [List.flatMap_nil, List.append_nil]
/-- flatMap of state group 7 equals the joined decoded slices. -/
theorem z7Grp_1_7 :
    ([([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 2, 0, 0], 7, 7, (-5 : Int)), ([3, 2, 0, 1], 6, 6, (-4 : Int)), ([3, 2, 0, 2], 5, 3, (-3 : Int)), ([3, 2, 1, 0], 6, 6, (-6 : Int)), ([3, 2, 1, 1], 5, 5, (-5 : Int)), ([3, 2, 1, 2], 4, 2, (-4 : Int)), ([3, 2, 2, 0], 5, 3, (-7 : Int)), ([3, 2, 2, 1], 4, 2, (-6 : Int))]).flatMap (fun s => z7GenRow (12 - 4) (1 : Fin 12).val (0 + 4) s.1 s.2.1 s.2.2.1 s.2.2.2)
      = z7UnaryCode1_s112.map z7DecodeRow ++ (z7UnaryCode1_s113.map z7DecodeRow ++ (z7UnaryCode1_s114.map z7DecodeRow ++ (z7UnaryCode1_s115.map z7DecodeRow ++ (z7UnaryCode1_s116.map z7DecodeRow ++ (z7UnaryCode1_s117.map z7DecodeRow ++ (z7UnaryCode1_s118.map z7DecodeRow ++ (z7UnaryCode1_s119.map z7DecodeRow ++ (z7UnaryCode1_s120.map z7DecodeRow ++ (z7UnaryCode1_s121.map z7DecodeRow ++ (z7UnaryCode1_s122.map z7DecodeRow)))))))))) := by
  rw [List.flatMap_cons, z7UnaryRows1_s112_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s113_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s114_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s115_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s116_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s117_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s118_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s119_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s120_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s121_eq]
  rw [List.flatMap_cons, z7UnaryRows1_s122_eq]
  rw [List.flatMap_nil, List.append_nil]

theorem z7UnaryRows_cached_1 : z7UnaryRows 1 = z7UnaryCode1.map z7DecodeRow := by
  unfold z7UnaryRows z7UnaryCode1
  rw [z7GenRow_split 4 12 (1 : Fin 12).val 0 [] 12
      (z7ExteriorTarget 1 1) 0 (by decide) (by decide)]
  rw [states_1]
  rw [show [([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int)), ([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 2, 0, 0], 10, 16, (-2 : Int)), ([0, 2, 0, 1], 9, 15, (-1 : Int)), ([0, 2, 0, 2], 8, 12, (0 : Int)), ([0, 2, 0, 3], 7, 7, (1 : Int)), ([0, 2, 0, 4], 6, 0, (2 : Int)), ([0, 2, 1, 0], 9, 15, (-3 : Int)), ([0, 2, 1, 1], 8, 14, (-2 : Int)), ([0, 2, 1, 2], 7, 11, (-1 : Int)), ([0, 2, 1, 3], 6, 6, (0 : Int)), ([0, 2, 2, 0], 8, 12, (-4 : Int)), ([0, 2, 2, 1], 7, 11, (-3 : Int)), ([0, 2, 2, 2], 6, 8, (-2 : Int)), ([0, 2, 2, 3], 5, 3, (-1 : Int)), ([0, 2, 3, 0], 7, 7, (-5 : Int)), ([0, 2, 3, 1], 6, 6, (-4 : Int)), ([0, 2, 3, 2], 5, 3, (-3 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int)), ([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int)), ([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 2, 0, 0], 9, 15, (-3 : Int)), ([1, 2, 0, 1], 8, 14, (-2 : Int)), ([1, 2, 0, 2], 7, 11, (-1 : Int)), ([1, 2, 0, 3], 6, 6, (0 : Int)), ([1, 2, 1, 0], 8, 14, (-4 : Int)), ([1, 2, 1, 1], 7, 13, (-3 : Int)), ([1, 2, 1, 2], 6, 10, (-2 : Int)), ([1, 2, 1, 3], 5, 5, (-1 : Int)), ([1, 2, 2, 0], 7, 11, (-5 : Int)), ([1, 2, 2, 1], 6, 10, (-4 : Int)), ([1, 2, 2, 2], 5, 7, (-3 : Int)), ([1, 2, 2, 3], 4, 2, (-2 : Int)), ([1, 2, 3, 0], 6, 6, (-6 : Int)), ([1, 2, 3, 1], 5, 5, (-5 : Int)), ([1, 2, 3, 2], 4, 2, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int)), ([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int)), ([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 2, 0, 0], 8, 12, (-4 : Int)), ([2, 2, 0, 1], 7, 11, (-3 : Int)), ([2, 2, 0, 2], 6, 8, (-2 : Int)), ([2, 2, 0, 3], 5, 3, (-1 : Int)), ([2, 2, 1, 0], 7, 11, (-5 : Int)), ([2, 2, 1, 1], 6, 10, (-4 : Int)), ([2, 2, 1, 2], 5, 7, (-3 : Int)), ([2, 2, 1, 3], 4, 2, (-2 : Int)), ([2, 2, 2, 0], 6, 8, (-6 : Int)), ([2, 2, 2, 1], 5, 7, (-5 : Int)), ([2, 2, 2, 2], 4, 4, (-4 : Int)), ([2, 2, 3, 0], 5, 3, (-7 : Int)), ([2, 2, 3, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int)), ([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int)), ([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 2, 0, 0], 7, 7, (-5 : Int)), ([3, 2, 0, 1], 6, 6, (-4 : Int)), ([3, 2, 0, 2], 5, 3, (-3 : Int)), ([3, 2, 1, 0], 6, 6, (-6 : Int)), ([3, 2, 1, 1], 5, 5, (-5 : Int)), ([3, 2, 1, 2], 4, 2, (-4 : Int)), ([3, 2, 2, 0], 5, 3, (-7 : Int)), ([3, 2, 2, 1], 4, 2, (-6 : Int))] = [([0, 0, 0, 0], 12, 22, (0 : Int)), ([0, 0, 0, 1], 11, 21, (1 : Int)), ([0, 0, 0, 2], 10, 18, (2 : Int)), ([0, 0, 0, 3], 9, 13, (3 : Int)), ([0, 0, 0, 4], 8, 6, (4 : Int)), ([0, 0, 1, 0], 11, 21, (-1 : Int)), ([0, 0, 1, 1], 10, 20, (0 : Int)), ([0, 0, 1, 2], 9, 17, (1 : Int)), ([0, 0, 1, 3], 8, 12, (2 : Int)), ([0, 0, 1, 4], 7, 5, (3 : Int)), ([0, 0, 2, 0], 10, 18, (-2 : Int)), ([0, 0, 2, 1], 9, 17, (-1 : Int)), ([0, 0, 2, 2], 8, 14, (0 : Int)), ([0, 0, 2, 3], 7, 9, (1 : Int)), ([0, 0, 2, 4], 6, 2, (2 : Int)), ([0, 0, 3, 0], 9, 13, (-3 : Int))] ++ ([([0, 0, 3, 1], 8, 12, (-2 : Int)), ([0, 0, 3, 2], 7, 9, (-1 : Int)), ([0, 0, 3, 3], 6, 4, (0 : Int)), ([0, 2, 0, 0], 10, 16, (-2 : Int)), ([0, 2, 0, 1], 9, 15, (-1 : Int)), ([0, 2, 0, 2], 8, 12, (0 : Int)), ([0, 2, 0, 3], 7, 7, (1 : Int)), ([0, 2, 0, 4], 6, 0, (2 : Int)), ([0, 2, 1, 0], 9, 15, (-3 : Int)), ([0, 2, 1, 1], 8, 14, (-2 : Int)), ([0, 2, 1, 2], 7, 11, (-1 : Int)), ([0, 2, 1, 3], 6, 6, (0 : Int)), ([0, 2, 2, 0], 8, 12, (-4 : Int)), ([0, 2, 2, 1], 7, 11, (-3 : Int)), ([0, 2, 2, 2], 6, 8, (-2 : Int)), ([0, 2, 2, 3], 5, 3, (-1 : Int))] ++ ([([0, 2, 3, 0], 7, 7, (-5 : Int)), ([0, 2, 3, 1], 6, 6, (-4 : Int)), ([0, 2, 3, 2], 5, 3, (-3 : Int)), ([1, 0, 0, 0], 11, 21, (-1 : Int)), ([1, 0, 0, 1], 10, 20, (0 : Int)), ([1, 0, 0, 2], 9, 17, (1 : Int)), ([1, 0, 0, 3], 8, 12, (2 : Int)), ([1, 0, 0, 4], 7, 5, (3 : Int)), ([1, 0, 1, 0], 10, 20, (-2 : Int)), ([1, 0, 1, 1], 9, 19, (-1 : Int)), ([1, 0, 1, 2], 8, 16, (0 : Int)), ([1, 0, 1, 3], 7, 11, (1 : Int)), ([1, 0, 1, 4], 6, 4, (2 : Int)), ([1, 0, 2, 0], 9, 17, (-3 : Int)), ([1, 0, 2, 1], 8, 16, (-2 : Int)), ([1, 0, 2, 2], 7, 13, (-1 : Int))] ++ ([([1, 0, 2, 3], 6, 8, (0 : Int)), ([1, 0, 2, 4], 5, 1, (1 : Int)), ([1, 0, 3, 0], 8, 12, (-4 : Int)), ([1, 0, 3, 1], 7, 11, (-3 : Int)), ([1, 0, 3, 2], 6, 8, (-2 : Int)), ([1, 0, 3, 3], 5, 3, (-1 : Int)), ([1, 2, 0, 0], 9, 15, (-3 : Int)), ([1, 2, 0, 1], 8, 14, (-2 : Int)), ([1, 2, 0, 2], 7, 11, (-1 : Int)), ([1, 2, 0, 3], 6, 6, (0 : Int)), ([1, 2, 1, 0], 8, 14, (-4 : Int)), ([1, 2, 1, 1], 7, 13, (-3 : Int)), ([1, 2, 1, 2], 6, 10, (-2 : Int)), ([1, 2, 1, 3], 5, 5, (-1 : Int)), ([1, 2, 2, 0], 7, 11, (-5 : Int)), ([1, 2, 2, 1], 6, 10, (-4 : Int))] ++ ([([1, 2, 2, 2], 5, 7, (-3 : Int)), ([1, 2, 2, 3], 4, 2, (-2 : Int)), ([1, 2, 3, 0], 6, 6, (-6 : Int)), ([1, 2, 3, 1], 5, 5, (-5 : Int)), ([1, 2, 3, 2], 4, 2, (-4 : Int)), ([2, 0, 0, 0], 10, 18, (-2 : Int)), ([2, 0, 0, 1], 9, 17, (-1 : Int)), ([2, 0, 0, 2], 8, 14, (0 : Int)), ([2, 0, 0, 3], 7, 9, (1 : Int)), ([2, 0, 0, 4], 6, 2, (2 : Int)), ([2, 0, 1, 0], 9, 17, (-3 : Int)), ([2, 0, 1, 1], 8, 16, (-2 : Int)), ([2, 0, 1, 2], 7, 13, (-1 : Int)), ([2, 0, 1, 3], 6, 8, (0 : Int)), ([2, 0, 1, 4], 5, 1, (1 : Int)), ([2, 0, 2, 0], 8, 14, (-4 : Int))] ++ ([([2, 0, 2, 1], 7, 13, (-3 : Int)), ([2, 0, 2, 2], 6, 10, (-2 : Int)), ([2, 0, 2, 3], 5, 5, (-1 : Int)), ([2, 0, 3, 0], 7, 9, (-5 : Int)), ([2, 0, 3, 1], 6, 8, (-4 : Int)), ([2, 0, 3, 2], 5, 5, (-3 : Int)), ([2, 0, 3, 3], 4, 0, (-2 : Int)), ([2, 2, 0, 0], 8, 12, (-4 : Int)), ([2, 2, 0, 1], 7, 11, (-3 : Int)), ([2, 2, 0, 2], 6, 8, (-2 : Int)), ([2, 2, 0, 3], 5, 3, (-1 : Int)), ([2, 2, 1, 0], 7, 11, (-5 : Int)), ([2, 2, 1, 1], 6, 10, (-4 : Int)), ([2, 2, 1, 2], 5, 7, (-3 : Int)), ([2, 2, 1, 3], 4, 2, (-2 : Int)), ([2, 2, 2, 0], 6, 8, (-6 : Int))] ++ ([([2, 2, 2, 1], 5, 7, (-5 : Int)), ([2, 2, 2, 2], 4, 4, (-4 : Int)), ([2, 2, 3, 0], 5, 3, (-7 : Int)), ([2, 2, 3, 1], 4, 2, (-6 : Int)), ([3, 0, 0, 0], 9, 13, (-3 : Int)), ([3, 0, 0, 1], 8, 12, (-2 : Int)), ([3, 0, 0, 2], 7, 9, (-1 : Int)), ([3, 0, 0, 3], 6, 4, (0 : Int)), ([3, 0, 1, 0], 8, 12, (-4 : Int)), ([3, 0, 1, 1], 7, 11, (-3 : Int)), ([3, 0, 1, 2], 6, 8, (-2 : Int)), ([3, 0, 1, 3], 5, 3, (-1 : Int)), ([3, 0, 2, 0], 7, 9, (-5 : Int)), ([3, 0, 2, 1], 6, 8, (-4 : Int)), ([3, 0, 2, 2], 5, 5, (-3 : Int)), ([3, 0, 2, 3], 4, 0, (-2 : Int))] ++ ([([3, 0, 3, 0], 6, 4, (-6 : Int)), ([3, 0, 3, 1], 5, 3, (-5 : Int)), ([3, 0, 3, 2], 4, 0, (-4 : Int)), ([3, 2, 0, 0], 7, 7, (-5 : Int)), ([3, 2, 0, 1], 6, 6, (-4 : Int)), ([3, 2, 0, 2], 5, 3, (-3 : Int)), ([3, 2, 1, 0], 6, 6, (-6 : Int)), ([3, 2, 1, 1], 5, 5, (-5 : Int)), ([3, 2, 1, 2], 4, 2, (-4 : Int)), ([3, 2, 2, 0], 5, 3, (-7 : Int)), ([3, 2, 2, 1], 4, 2, (-6 : Int))]))))))) from rfl]
  repeat rw [List.flatMap_append]
  rw [z7Grp_1_0, z7Grp_1_1, z7Grp_1_2, z7Grp_1_3, z7Grp_1_4, z7Grp_1_5, z7Grp_1_6, z7Grp_1_7]
  repeat rw [List.map_append]
  repeat rw [← List.append_assoc]

#print axioms z7UnaryRows_cached_1

end Matrix99
