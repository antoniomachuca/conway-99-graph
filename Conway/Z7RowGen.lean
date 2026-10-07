import Conway.Z7PinnedRows

namespace Matrix99

set_option maxHeartbeats 200000000
set_option maxRecDepth 10000

def z7ColWeight (j : Nat) : Int :=
  if j < 3 then 1 else if j < 6 then -1 else 0

def z7WeightLeft (j : Nat) : Nat :=
  if j < 3 then 6 - j else if j < 6 then 6 - j else 0

def z7ColVals (j : Nat) (index : Nat) : List Nat :=
  if j = index then [0, 2] else [0, 1, 2, 3, 4]

def z7RowPossible (j total squares : Nat) (balance : Int) : Bool :=
  let remaining := 12 - j
  0 ≤ total && total ≤ remaining * 4 &&
    total * total ≤ remaining * squares &&
    squares ≤ remaining * 16 + 4 &&
    balance.natAbs ≤ z7WeightLeft j * 4

/-- Rows of exterior index `index` obeying the unary sum, balance and diagonal quadratic. -/
def z7GenRow (fuel : Nat) (index j : Nat) (pref : List Nat)
    (total squares : Nat) (balance : Int) : List (List Nat) :=
  if j = 12 then
    if total == 0 && squares == 0 && balance == 0 then [pref] else []
  else
    match fuel with
    | 0 => []
    | fuel + 1 =>
      if !z7RowPossible j total squares balance then []
      else
        (z7ColVals j index).flatMap fun v =>
          let diag := if j = index then v else 0
          if decide (v ≤ total ∧ v * v + diag ≤ squares) then
            z7GenRow fuel index (j + 1) (pref ++ [v])
              (total - v) (squares - (v * v + diag)) (balance - z7ColWeight j * v)
          else []

def z7UnaryRows (index : Fin 12) : List (List Nat) :=
  z7GenRow 12 index.val 0 [] 12 (z7ExteriorTarget index index) 0

theorem z7UnaryRows_0_length : (z7UnaryRows 0).length = 7576 := by
  decide +kernel

#print axioms z7UnaryRows_0_length

def rowPrefix (f : Fin 12 → Nat) (j : Nat) : List Nat :=
  ((List.finRange 12).take j).map f

def rowSuffix (f : Fin 12 → Nat) (j : Nat) : List Nat :=
  ((List.finRange 12).drop j).map f

def suffixTotal (f : Fin 12 → Nat) (j : Nat) : Nat :=
  (rowSuffix f j).sum

def suffixSquares (f : Fin 12 → Nat) (index : Nat) : Nat → Nat → Nat
  | 0, _ => 0
  | fuel + 1, j =>
    if h : j < 12 then
      f ⟨j, h⟩ * f ⟨j, h⟩ + (if j = index then f ⟨j, h⟩ else 0) +
        suffixSquares f index fuel (j + 1)
    else 0

def suffixBalance (f : Fin 12 → Nat) : Nat → Nat → Int
  | 0, _ => 0
  | fuel + 1, j =>
    if h : j < 12 then
      z7ColWeight j * (f ⟨j, h⟩) + suffixBalance f fuel (j + 1)
    else 0

private theorem finRange12_gen : List.finRange 12 = [0,1,2,3,4,5,6,7,8,9,10,11] := by
  decide +kernel

private theorem nat_lt12 (j : Nat) (hj : j < 12) :
    j = 0 ∨ j = 1 ∨ j = 2 ∨ j = 3 ∨ j = 4 ∨ j = 5 ∨ j = 6 ∨ j = 7 ∨
      j = 8 ∨ j = 9 ∨ j = 10 ∨ j = 11 := by omega

private theorem rowPrefix_succ (f : Fin 12 → Nat) (j : Nat) (hj : j < 12) :
    rowPrefix f (j + 1) = rowPrefix f j ++ [f ⟨j, hj⟩] := by
  rcases nat_lt12 j hj with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  all_goals simp [rowPrefix, finRange12_gen]

private theorem suffixTotal_succ (f : Fin 12 → Nat) (j : Nat) (hj : j < 12) :
    suffixTotal f j = f ⟨j, hj⟩ + suffixTotal f (j + 1) := by
  rcases nat_lt12 j hj with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  all_goals simp [suffixTotal, rowSuffix, finRange12_gen]

private theorem suffixSquares_succ (f : Fin 12 → Nat) (index : Nat) (j : Nat)
    (hj : j < 12) (fuel : Nat) :
    suffixSquares f index (fuel + 1) j =
      f ⟨j, hj⟩ * f ⟨j, hj⟩ + (if j = index then f ⟨j, hj⟩ else 0) +
        suffixSquares f index fuel (j + 1) := by
  simp [suffixSquares, hj]

private theorem suffixBalance_succ (f : Fin 12 → Nat) (j : Nat) (hj : j < 12) (fuel : Nat) :
    suffixBalance f (fuel + 1) j =
      z7ColWeight j * (f ⟨j, hj⟩) + suffixBalance f fuel (j + 1) := by
  simp [suffixBalance, hj]

#print axioms rowPrefix_succ
#print axioms suffixTotal_succ
#print axioms suffixSquares_succ
#print axioms suffixBalance_succ

end Matrix99
