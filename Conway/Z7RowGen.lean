import Conway.Z7PinnedRows
import Conway.Z7Cauchy

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

private theorem suffixTotal_le (f : Fin 12 → Nat) (hbound : ∀ i, f i ≤ 4)
    (j : Nat) (hj : j ≤ 12) : suffixTotal f j ≤ (12 - j) * 4 := by
  induction h : 12 - j generalizing j with
  | zero =>
      have hj12 : j = 12 := by omega
      subst hj12
      simp [suffixTotal, rowSuffix, finRange12_gen]
  | succ n ih =>
      have hjlt : j < 12 := by omega
      rw [suffixTotal_succ f j hjlt]
      have hf : f ⟨j, hjlt⟩ ≤ 4 := hbound _
      have hrest : suffixTotal f (j + 1) ≤ n * 4 :=
        ih (j + 1) (by omega) (by omega)
      have hn : n = 12 - (j + 1) := by omega
      omega

private def diagAhead (index j : Nat) : Nat :=
  if j ≤ index ∧ index < 12 then 4 else 0

private theorem sq16 (x : Nat) (hx : x ≤ 4) : x * x ≤ 16 := by
  have : x = 0 ∨ x = 1 ∨ x = 2 ∨ x = 3 ∨ x = 4 := by omega
  rcases this with rfl | rfl | rfl | rfl | rfl <;> decide

private theorem suffixSquares_le (f : Fin 12 → Nat) (hbound : ∀ i, f i ≤ 4)
    (index j : Nat) (hj : j ≤ 12) :
    suffixSquares f index (12 - j) j ≤ (12 - j) * 16 + diagAhead index j := by
  induction h : 12 - j generalizing j with
  | zero =>
      have hj12 : j = 12 := by omega
      subst hj12
      simp [suffixSquares, diagAhead]
  | succ n ih =>
      have hjlt : j < 12 := by omega
      have hfuel : 12 - (j + 1) = n := by omega
      rw [show n + 1 = n.succ by rfl]
      rw [suffixSquares_succ f index j hjlt n]
      have hrest := ih (j + 1) (by omega) hfuel
      have hff := sq16 _ (hbound ⟨j, hjlt⟩)
      have hdiag : (if j = index then f ⟨j, hjlt⟩ else 0) + diagAhead index (j + 1) ≤
          diagAhead index j := by
        by_cases hji : j = index
        · subst hji
          rw [if_pos rfl]
          have hhere : diagAhead j j = 4 := by simp [diagAhead, hjlt]
          have hnext : diagAhead j (j + 1) = 0 := by
            unfold diagAhead
            have : ¬ (j + 1 ≤ j) := by omega
            simp [this]
          have hf : f ⟨j, hjlt⟩ ≤ 4 := hbound _
          omega
        · rw [if_neg hji]
          by_cases hnext : j + 1 ≤ index
          · by_cases hlt : index < 12
            · have hjle : j ≤ index := Nat.le_of_succ_le hnext
              simp [diagAhead, hnext, hlt, hjle]
            · simp [diagAhead, hlt]
          · simp [diagAhead, hnext]
      refine Nat.le_trans ?_ (Nat.add_le_add_left hdiag ((n + 1) * 16))
      have hsum : f ⟨j, hjlt⟩ * f ⟨j, hjlt⟩ +
          (if j = index then f ⟨j, hjlt⟩ else 0) + suffixSquares f index n (j + 1) ≤
          16 + ((if j = index then f ⟨j, hjlt⟩ else 0) + diagAhead index (j + 1)) + n * 16 := by
        have h1 := Nat.add_le_add_right hff
          ((if j = index then f ⟨j, hjlt⟩ else 0) + suffixSquares f index n (j + 1))
        have h2 := Nat.add_le_add_left hrest
          (16 + (if j = index then f ⟨j, hjlt⟩ else 0))
        omega
      omega

private theorem cap196 (n d s : Nat) (hn : n ≤ 11) (hd : d ≤ 4) (hs : s ≤ n * 16 + d) :
    s ≤ 196 := by omega

private theorem suffixTotal_sq_le (f : Fin 12 → Nat) (hbound : ∀ i, f i ≤ 4)
    (index j : Nat) (hj : j ≤ 12) :
    suffixTotal f j * suffixTotal f j ≤
      (12 - j) * suffixSquares f index (12 - j) j := by
  induction h : 12 - j generalizing j with
  | zero =>
      have hj12 : j = 12 := by omega
      subst hj12
      simp [suffixTotal, rowSuffix, suffixSquares, finRange12_gen]
  | succ n ih =>
      have hjlt : j < 12 := by omega
      have hfuel : 12 - (j + 1) = n := by omega
      rw [suffixTotal_succ f j hjlt]
      rw [show n + 1 = n.succ by rfl, suffixSquares_succ f index j hjlt n]
      have hrest := ih (j + 1) (by omega) hfuel
      have ha : f ⟨j, hjlt⟩ ≤ 4 := hbound _
      have hsBound : suffixTotal f (j + 1) ≤ 48 := by
        have hle := suffixTotal_le f hbound (j + 1) (by omega)
        omega
      have hqBound : suffixSquares f index n (j + 1) ≤ 196 := by
        have hle := suffixSquares_le f hbound index (j + 1) (by omega)
        have hcap : diagAhead index (j + 1) ≤ 4 := by
          simp [diagAhead]; split <;> decide
        have hn : n ≤ 11 := by omega
        have hfuel' : 12 - (j + 1) = n := hfuel
        rw [hfuel'] at hle
        exact cap196 n _ _ hn hcap hle
      have hk : n ≤ 12 := by omega
      have hstep := cauchy_step (f ⟨j, hjlt⟩) (suffixTotal f (j + 1))
        (suffixSquares f index n (j + 1)) n ha hsBound hqBound hk hrest
      have hgrow : (n + 1) * (f ⟨j, hjlt⟩ * f ⟨j, hjlt⟩ + suffixSquares f index n (j + 1)) ≤
          (n + 1) * (f ⟨j, hjlt⟩ * f ⟨j, hjlt⟩ +
            (if j = index then f ⟨j, hjlt⟩ else 0) + suffixSquares f index n (j + 1)) := by
        apply Nat.mul_le_mul_left
        have : 0 ≤ if j = index then f ⟨j, hjlt⟩ else 0 := by split <;> omega
        omega
      exact Nat.le_trans hstep hgrow

private theorem weightAbs (j : Nat) : (z7ColWeight j).natAbs = if j < 6 then 1 else 0 := by
  by_cases h6 : j < 6
  · by_cases h3 : j < 3
    · simp [z7ColWeight, h3, h6]
    · simp [z7ColWeight, h3, h6]
  · have h3 : ¬ j < 3 := by omega
    simp [z7ColWeight, h3, h6]

private theorem weightLeft_succ (j : Nat) (hj : j < 12) :
    z7WeightLeft j = (z7ColWeight j).natAbs + z7WeightLeft (j + 1) := by
  rcases nat_lt12 j hj with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  all_goals simp [z7WeightLeft, z7ColWeight]

private theorem suffixBalance_le (f : Fin 12 → Nat) (hbound : ∀ i, f i ≤ 4)
    (j : Nat) (hj : j ≤ 12) :
    (suffixBalance f (12 - j) j).natAbs ≤ z7WeightLeft j * 4 := by
  induction h : 12 - j generalizing j with
  | zero =>
      have hj12 : j = 12 := by omega
      subst hj12
      simp [suffixBalance, z7WeightLeft]
  | succ n ih =>
      have hjlt : j < 12 := by omega
      have hfuel : 12 - (j + 1) = n := by omega
      rw [show n + 1 = n.succ by rfl, suffixBalance_succ f j hjlt n]
      have hrest := ih (j + 1) (by omega) hfuel
      have habs : (z7ColWeight j * (f ⟨j, hjlt⟩) + suffixBalance f n (j + 1)).natAbs ≤
          (z7ColWeight j).natAbs * f ⟨j, hjlt⟩ + (suffixBalance f n (j + 1)).natAbs := by
        have h1 := Int.natAbs_add_le (z7ColWeight j * (f ⟨j, hjlt⟩)) (suffixBalance f n (j + 1))
        rw [Int.natAbs_mul] at h1
        simpa using h1
      have hw := weightLeft_succ j hjlt
      have hf : f ⟨j, hjlt⟩ ≤ 4 := hbound _
      have hwf : (z7ColWeight j).natAbs * f ⟨j, hjlt⟩ ≤ (z7ColWeight j).natAbs * 4 :=
        Nat.mul_le_mul_left _ hf
      have hsum : (z7ColWeight j).natAbs * f ⟨j, hjlt⟩ +
          (suffixBalance f n (j + 1)).natAbs ≤
          (z7ColWeight j).natAbs * 4 + z7WeightLeft (j + 1) * 4 :=
        Nat.add_le_add hwf hrest
      have hdistrib : (z7ColWeight j).natAbs * 4 + z7WeightLeft (j + 1) * 4 =
          ((z7ColWeight j).natAbs + z7WeightLeft (j + 1)) * 4 :=
        (Nat.add_mul (z7ColWeight j).natAbs (z7WeightLeft (j + 1)) 4).symm
      exact Nat.le_trans habs (Nat.le_trans hsum (by
        rw [hdistrib, hw]
        exact Nat.le_refl _))

private theorem diagAhead_le (index j : Nat) : diagAhead index j ≤ 4 := by
  unfold diagAhead
  split <;> decide

private theorem squares_cap (n d s : Nat) (hd : d ≤ 4) (hs : s ≤ n * 16 + d) :
    s ≤ n * 16 + 4 := by omega

theorem z7GenRow_complete_from (index : Fin 12) (f : Fin 12 → Nat)
    (hbound : ∀ i, f i ≤ 4) (hdiag : f index = 0 ∨ f index = 2)
    (j : Nat) (hj : j ≤ 12) :
    rowPrefix f 12 ∈ z7GenRow (12 - j) index.val j (rowPrefix f j)
      (suffixTotal f j) (suffixSquares f index.val (12 - j) j)
      (suffixBalance f (12 - j) j) := by
  induction h : 12 - j generalizing j with
  | zero =>
      have hj12 : j = 12 := by omega
      subst hj12
      have hsq : suffixSquares f index.val 0 12 = 0 := rfl
      have hbal0 : suffixBalance f 0 12 = 0 := rfl
      have htot : suffixTotal f 12 = 0 := by
        unfold suffixTotal rowSuffix
        rw [finRange12_gen]
        rfl
      rw [hsq, hbal0, htot]
      unfold z7GenRow
      rw [if_pos rfl]
      have hcond : (0 == 0 && 0 == 0 && (0 : Int) == 0) = true := by decide
      rw [hcond, if_pos rfl]
      exact List.mem_cons_self
  | succ n ih =>
      have hjlt : j < 12 := by omega
      have hfuel : 12 - (j + 1) = n := by omega
      let v : Nat := f ⟨j, hjlt⟩
      have hv : v ≤ 4 := hbound _
      have hvals : v ∈ z7ColVals j index.val := by
        by_cases hji : j = index.val
        · rcases hdiag with h0 | h2
          · simp [v, z7ColVals, hji, h0]
          · simp [v, z7ColVals, hji, h2]
        · have : v = 0 ∨ v = 1 ∨ v = 2 ∨ v = 3 ∨ v = 4 := by omega
          simp [v, z7ColVals, hji]
          omega
      have htotal := suffixTotal_succ f j hjlt
      have hsqEq := suffixSquares_succ f index.val j hjlt n
      have hbalEq := suffixBalance_succ f j hjlt n
      have hpref := rowPrefix_succ f j hjlt
      have hnext := ih (j + 1) (by omega) hfuel
      have hpos : z7RowPossible j (suffixTotal f j)
          (suffixSquares f index.val (n + 1) j) (suffixBalance f (n + 1) j) = true := by
        have htot := suffixTotal_le f hbound j hj
        have hsqle := suffixTotal_sq_le f hbound index.val j hj
        have hcap0 := suffixSquares_le f hbound index.val j hj
        have hcap := squares_cap (12 - j) (diagAhead index.val j)
          (suffixSquares f index.val (12 - j) j) (diagAhead_le _ _) hcap0
        have hbal := suffixBalance_le f hbound j hj
        rw [h] at htot hsqle hcap hbal
        unfold z7RowPossible
        simp only [h]
        rw [Bool.and_eq_true]
        constructor
        · rw [Bool.and_eq_true]
          constructor
          · rw [Bool.and_eq_true]
            constructor
            · rw [Bool.and_eq_true]
              constructor
              · exact decide_eq_true (Nat.zero_le _)
              · exact decide_eq_true htot
            · exact decide_eq_true hsqle
          · exact decide_eq_true hcap
        · exact decide_eq_true hbal
      have hdec : decide (v ≤ suffixTotal f j ∧
          v * v + (if j = index.val then v else 0) ≤
            suffixSquares f index.val (n + 1) j) = true := by
        apply decide_eq_true
        refine ⟨?_, ?_⟩
        · rw [htotal]
          exact Nat.le_add_right _ _
        · rw [hsqEq]
          exact Nat.le_add_right _ _
      rw [show n + 1 = Nat.succ n from rfl]
      unfold z7GenRow
      rw [if_neg (show ¬ j = 12 by omega), hpos, Bool.not_true]
      dsimp only
      rw [if_neg Bool.false_ne_true]
      refine List.mem_flatMap.2 ⟨v, hvals, ?_⟩
      rw [hdec]
      simp only [ite_true]
      rw [← hpref, htotal, hsqEq, hbalEq]
      simp only [v, Nat.add_sub_cancel_left]
      rw [Int.add_comm (z7ColWeight j * ↑(f ⟨j, hjlt⟩)) (suffixBalance f n (j + 1)),
        Int.add_sub_cancel]
      exact hnext

#print axioms sq16
#print axioms suffixTotal_le
#print axioms suffixSquares_le
#print axioms suffixTotal_sq_le
#print axioms suffixBalance_le
#print axioms rowPrefix_succ
#print axioms suffixTotal_succ
#print axioms suffixSquares_succ
#print axioms suffixBalance_succ
#print axioms z7GenRow_complete_from

end Matrix99
