import Std

namespace Matrix99

set_option maxRecDepth 100000
set_option maxHeartbeats 8000000
set_option Elab.async false

def z7RootValues : List (List Nat) :=
  [[0, 0, 1, 0, 0, 1, 0, 2, 2, 2, 2, 2],
   [0, 0, 1, 0, 0, 1, 1, 1, 1, 2, 2, 3],
   [0, 0, 2, 0, 0, 2, 0, 1, 1, 2, 2, 2],
   [0, 0, 2, 0, 0, 2, 1, 1, 1, 1, 1, 3],
   [0, 0, 2, 0, 1, 1, 0, 0, 2, 2, 2, 2],
   [0, 0, 2, 0, 1, 1, 0, 1, 1, 1, 2, 3],
   [0, 0, 3, 0, 1, 2, 0, 1, 1, 1, 1, 2],
   [0, 0, 3, 1, 1, 1, 0, 0, 1, 1, 2, 2],
   [0, 1, 1, 0, 0, 2, 0, 0, 2, 2, 2, 2],
   [0, 1, 1, 0, 0, 2, 0, 1, 1, 1, 2, 3],
   [0, 1, 1, 0, 1, 1, 0, 0, 1, 2, 2, 3],
   [0, 1, 2, 0, 0, 3, 0, 1, 1, 1, 1, 2],
   [0, 1, 2, 0, 1, 2, 0, 0, 0, 2, 2, 2],
   [0, 1, 2, 0, 1, 2, 0, 0, 1, 1, 1, 3],
   [0, 1, 2, 1, 1, 1, 0, 0, 0, 1, 2, 3],
   [0, 1, 3, 0, 2, 2, 0, 0, 1, 1, 1, 1],
   [0, 1, 3, 1, 1, 2, 0, 0, 0, 1, 1, 2],
   [0, 2, 2, 0, 1, 3, 0, 0, 1, 1, 1, 1],
   [0, 2, 2, 0, 2, 2, 0, 0, 0, 1, 1, 2],
   [0, 2, 2, 1, 1, 2, 0, 0, 0, 0, 2, 2],
   [2, 0, 0, 0, 0, 2, 1, 1, 1, 1, 2, 2],
   [2, 0, 0, 0, 1, 1, 0, 1, 1, 2, 2, 2],
   [2, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 3],
   [2, 0, 1, 0, 0, 3, 1, 1, 1, 1, 1, 1],
   [2, 0, 1, 0, 1, 2, 0, 0, 1, 1, 2, 2],
   [2, 0, 1, 1, 1, 1, 0, 0, 0, 2, 2, 2],
   [2, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 3],
   [2, 0, 2, 0, 2, 2, 0, 0, 1, 1, 1, 1],
   [2, 0, 2, 1, 1, 2, 0, 0, 0, 1, 1, 2],
   [2, 1, 1, 0, 1, 3, 0, 0, 1, 1, 1, 1],
   [2, 1, 1, 0, 2, 2, 0, 0, 0, 1, 1, 2],
   [2, 1, 1, 1, 1, 2, 0, 0, 0, 0, 2, 2],
   [2, 1, 2, 1, 2, 2, 0, 0, 0, 0, 1, 1]]

def z7PairValues : List (List Nat) :=
  [[0, 0],
   [0, 1],
   [0, 2],
   [0, 3],
   [0, 4],
   [1, 1],
   [1, 2],
   [1, 3],
   [1, 4],
   [2, 2],
   [2, 3],
   [2, 4],
   [3, 3],
   [3, 4],
   [4, 4]]

def z7TripleValues : List (List Nat) :=
  [[0, 0, 0],
   [0, 0, 1],
   [0, 0, 2],
   [0, 0, 3],
   [0, 0, 4],
   [0, 1, 1],
   [0, 1, 2],
   [0, 1, 3],
   [0, 1, 4],
   [0, 2, 2],
   [0, 2, 3],
   [0, 2, 4],
   [0, 3, 3],
   [0, 3, 4],
   [0, 4, 4],
   [1, 1, 1],
   [1, 1, 2],
   [1, 1, 3],
   [1, 1, 4],
   [1, 2, 2],
   [1, 2, 3],
   [1, 2, 4],
   [1, 3, 3],
   [1, 3, 4],
   [1, 4, 4],
   [2, 2, 2],
   [2, 2, 3],
   [2, 2, 4],
   [2, 3, 3],
   [2, 3, 4],
   [2, 4, 4],
   [3, 3, 3],
   [3, 3, 4],
   [3, 4, 4],
   [4, 4, 4]]

def z7TailValues : List (List Nat) :=
  [[0, 0, 0, 0, 0, 0],
   [0, 0, 0, 0, 0, 1],
   [0, 0, 0, 0, 0, 2],
   [0, 0, 0, 0, 0, 3],
   [0, 0, 0, 0, 0, 4],
   [0, 0, 0, 0, 1, 1],
   [0, 0, 0, 0, 1, 2],
   [0, 0, 0, 0, 1, 3],
   [0, 0, 0, 0, 1, 4],
   [0, 0, 0, 0, 2, 2],
   [0, 0, 0, 0, 2, 3],
   [0, 0, 0, 0, 2, 4],
   [0, 0, 0, 0, 3, 3],
   [0, 0, 0, 0, 3, 4],
   [0, 0, 0, 0, 4, 4],
   [0, 0, 0, 1, 1, 1],
   [0, 0, 0, 1, 1, 2],
   [0, 0, 0, 1, 1, 3],
   [0, 0, 0, 1, 1, 4],
   [0, 0, 0, 1, 2, 2],
   [0, 0, 0, 1, 2, 3],
   [0, 0, 0, 1, 2, 4],
   [0, 0, 0, 1, 3, 3],
   [0, 0, 0, 1, 3, 4],
   [0, 0, 0, 1, 4, 4],
   [0, 0, 0, 2, 2, 2],
   [0, 0, 0, 2, 2, 3],
   [0, 0, 0, 2, 2, 4],
   [0, 0, 0, 2, 3, 3],
   [0, 0, 0, 2, 3, 4],
   [0, 0, 0, 2, 4, 4],
   [0, 0, 0, 3, 3, 3],
   [0, 0, 0, 3, 3, 4],
   [0, 0, 0, 3, 4, 4],
   [0, 0, 0, 4, 4, 4],
   [0, 0, 1, 1, 1, 1],
   [0, 0, 1, 1, 1, 2],
   [0, 0, 1, 1, 1, 3],
   [0, 0, 1, 1, 1, 4],
   [0, 0, 1, 1, 2, 2],
   [0, 0, 1, 1, 2, 3],
   [0, 0, 1, 1, 2, 4],
   [0, 0, 1, 1, 3, 3],
   [0, 0, 1, 1, 3, 4],
   [0, 0, 1, 1, 4, 4],
   [0, 0, 1, 2, 2, 2],
   [0, 0, 1, 2, 2, 3],
   [0, 0, 1, 2, 2, 4],
   [0, 0, 1, 2, 3, 3],
   [0, 0, 1, 2, 3, 4],
   [0, 0, 1, 2, 4, 4],
   [0, 0, 1, 3, 3, 3],
   [0, 0, 1, 3, 3, 4],
   [0, 0, 1, 3, 4, 4],
   [0, 0, 1, 4, 4, 4],
   [0, 0, 2, 2, 2, 2],
   [0, 0, 2, 2, 2, 3],
   [0, 0, 2, 2, 2, 4],
   [0, 0, 2, 2, 3, 3],
   [0, 0, 2, 2, 3, 4],
   [0, 0, 2, 2, 4, 4],
   [0, 0, 2, 3, 3, 3],
   [0, 0, 2, 3, 3, 4],
   [0, 0, 2, 3, 4, 4],
   [0, 0, 2, 4, 4, 4],
   [0, 0, 3, 3, 3, 3],
   [0, 0, 3, 3, 3, 4],
   [0, 0, 3, 3, 4, 4],
   [0, 0, 3, 4, 4, 4],
   [0, 0, 4, 4, 4, 4],
   [0, 1, 1, 1, 1, 1],
   [0, 1, 1, 1, 1, 2],
   [0, 1, 1, 1, 1, 3],
   [0, 1, 1, 1, 1, 4],
   [0, 1, 1, 1, 2, 2],
   [0, 1, 1, 1, 2, 3],
   [0, 1, 1, 1, 2, 4],
   [0, 1, 1, 1, 3, 3],
   [0, 1, 1, 1, 3, 4],
   [0, 1, 1, 1, 4, 4],
   [0, 1, 1, 2, 2, 2],
   [0, 1, 1, 2, 2, 3],
   [0, 1, 1, 2, 2, 4],
   [0, 1, 1, 2, 3, 3],
   [0, 1, 1, 2, 3, 4],
   [0, 1, 1, 2, 4, 4],
   [0, 1, 1, 3, 3, 3],
   [0, 1, 1, 3, 3, 4],
   [0, 1, 1, 3, 4, 4],
   [0, 1, 1, 4, 4, 4],
   [0, 1, 2, 2, 2, 2],
   [0, 1, 2, 2, 2, 3],
   [0, 1, 2, 2, 2, 4],
   [0, 1, 2, 2, 3, 3],
   [0, 1, 2, 2, 3, 4],
   [0, 1, 2, 2, 4, 4],
   [0, 1, 2, 3, 3, 3],
   [0, 1, 2, 3, 3, 4],
   [0, 1, 2, 3, 4, 4],
   [0, 1, 2, 4, 4, 4],
   [0, 1, 3, 3, 3, 3],
   [0, 1, 3, 3, 3, 4],
   [0, 1, 3, 3, 4, 4],
   [0, 1, 3, 4, 4, 4],
   [0, 1, 4, 4, 4, 4],
   [0, 2, 2, 2, 2, 2],
   [0, 2, 2, 2, 2, 3],
   [0, 2, 2, 2, 2, 4],
   [0, 2, 2, 2, 3, 3],
   [0, 2, 2, 2, 3, 4],
   [0, 2, 2, 2, 4, 4],
   [0, 2, 2, 3, 3, 3],
   [0, 2, 2, 3, 3, 4],
   [0, 2, 2, 3, 4, 4],
   [0, 2, 2, 4, 4, 4],
   [0, 2, 3, 3, 3, 3],
   [0, 2, 3, 3, 3, 4],
   [0, 2, 3, 3, 4, 4],
   [0, 2, 3, 4, 4, 4],
   [0, 2, 4, 4, 4, 4],
   [0, 3, 3, 3, 3, 3],
   [0, 3, 3, 3, 3, 4],
   [0, 3, 3, 3, 4, 4],
   [0, 3, 3, 4, 4, 4],
   [0, 3, 4, 4, 4, 4],
   [0, 4, 4, 4, 4, 4],
   [1, 1, 1, 1, 1, 1],
   [1, 1, 1, 1, 1, 2],
   [1, 1, 1, 1, 1, 3],
   [1, 1, 1, 1, 1, 4],
   [1, 1, 1, 1, 2, 2],
   [1, 1, 1, 1, 2, 3],
   [1, 1, 1, 1, 2, 4],
   [1, 1, 1, 1, 3, 3],
   [1, 1, 1, 1, 3, 4],
   [1, 1, 1, 1, 4, 4],
   [1, 1, 1, 2, 2, 2],
   [1, 1, 1, 2, 2, 3],
   [1, 1, 1, 2, 2, 4],
   [1, 1, 1, 2, 3, 3],
   [1, 1, 1, 2, 3, 4],
   [1, 1, 1, 2, 4, 4],
   [1, 1, 1, 3, 3, 3],
   [1, 1, 1, 3, 3, 4],
   [1, 1, 1, 3, 4, 4],
   [1, 1, 1, 4, 4, 4],
   [1, 1, 2, 2, 2, 2],
   [1, 1, 2, 2, 2, 3],
   [1, 1, 2, 2, 2, 4],
   [1, 1, 2, 2, 3, 3],
   [1, 1, 2, 2, 3, 4],
   [1, 1, 2, 2, 4, 4],
   [1, 1, 2, 3, 3, 3],
   [1, 1, 2, 3, 3, 4],
   [1, 1, 2, 3, 4, 4],
   [1, 1, 2, 4, 4, 4],
   [1, 1, 3, 3, 3, 3],
   [1, 1, 3, 3, 3, 4],
   [1, 1, 3, 3, 4, 4],
   [1, 1, 3, 4, 4, 4],
   [1, 1, 4, 4, 4, 4],
   [1, 2, 2, 2, 2, 2],
   [1, 2, 2, 2, 2, 3],
   [1, 2, 2, 2, 2, 4],
   [1, 2, 2, 2, 3, 3],
   [1, 2, 2, 2, 3, 4],
   [1, 2, 2, 2, 4, 4],
   [1, 2, 2, 3, 3, 3],
   [1, 2, 2, 3, 3, 4],
   [1, 2, 2, 3, 4, 4],
   [1, 2, 2, 4, 4, 4],
   [1, 2, 3, 3, 3, 3],
   [1, 2, 3, 3, 3, 4],
   [1, 2, 3, 3, 4, 4],
   [1, 2, 3, 4, 4, 4],
   [1, 2, 4, 4, 4, 4],
   [1, 3, 3, 3, 3, 3],
   [1, 3, 3, 3, 3, 4],
   [1, 3, 3, 3, 4, 4],
   [1, 3, 3, 4, 4, 4],
   [1, 3, 4, 4, 4, 4],
   [1, 4, 4, 4, 4, 4],
   [2, 2, 2, 2, 2, 2],
   [2, 2, 2, 2, 2, 3],
   [2, 2, 2, 2, 2, 4],
   [2, 2, 2, 2, 3, 3],
   [2, 2, 2, 2, 3, 4],
   [2, 2, 2, 2, 4, 4],
   [2, 2, 2, 3, 3, 3],
   [2, 2, 2, 3, 3, 4],
   [2, 2, 2, 3, 4, 4],
   [2, 2, 2, 4, 4, 4],
   [2, 2, 3, 3, 3, 3],
   [2, 2, 3, 3, 3, 4],
   [2, 2, 3, 3, 4, 4],
   [2, 2, 3, 4, 4, 4],
   [2, 2, 4, 4, 4, 4],
   [2, 3, 3, 3, 3, 3],
   [2, 3, 3, 3, 3, 4],
   [2, 3, 3, 3, 4, 4],
   [2, 3, 3, 4, 4, 4],
   [2, 3, 4, 4, 4, 4],
   [2, 4, 4, 4, 4, 4],
   [3, 3, 3, 3, 3, 3],
   [3, 3, 3, 3, 3, 4],
   [3, 3, 3, 3, 4, 4],
   [3, 3, 3, 4, 4, 4],
   [3, 3, 4, 4, 4, 4],
   [3, 4, 4, 4, 4, 4],
   [4, 4, 4, 4, 4, 4]]

def z7UnaryRow (r : List Nat) : Bool :=
  r.length == 12 && r.sum == 12 && (r.take 3).sum == ((r.drop 3).take 3).sum &&
    (r.map (fun x => x * x)).sum + r[0]! == 22

def z7Candidates (d : Nat) (p : List Nat) : List (List Nat) :=
  z7TripleValues.flatMap fun m =>
    z7TailValues.filterMap fun t =>
      let r := [d] ++ p ++ m ++ t
      if z7UnaryRow r then some r else none

theorem z7RootValues_length : z7RootValues.length = 33 := by decide

theorem z7RootValues_root26 : z7RootValues[26]! = [2,0,1,1,1,1,0,0,1,1,1,3] := by decide

theorem z7PairValues_complete : ∀ a b : Fin 5,
    a.val ≤ b.val → [a.val,b.val] ∈ z7PairValues := by decide +kernel

theorem z7TripleValues_complete : ∀ a b c : Fin 5,
    a.val ≤ b.val ∧ b.val ≤ c.val → [a.val,b.val,c.val] ∈ z7TripleValues := by decide +kernel

theorem z7TailValues_complete : ∀ a b c d e f : Fin 5,
    a.val ≤ b.val ∧ b.val ≤ c.val ∧ c.val ≤ d.val ∧ d.val ≤ e.val ∧ e.val ≤ f.val →
    [a.val,b.val,c.val,d.val,e.val,f.val] ∈ z7TailValues := by decide +kernel

private theorem z7Cover_0_0 :
    ((z7Candidates 0 [0, 0]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_1 :
    ((z7Candidates 0 [0, 1]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_2 :
    ((z7Candidates 0 [0, 2]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_3 :
    ((z7Candidates 0 [0, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_4 :
    ((z7Candidates 0 [0, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_5 :
    ((z7Candidates 0 [1, 1]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_6 :
    ((z7Candidates 0 [1, 2]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_7 :
    ((z7Candidates 0 [1, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_8 :
    ((z7Candidates 0 [1, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_9 :
    ((z7Candidates 0 [2, 2]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_10 :
    ((z7Candidates 0 [2, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_11 :
    ((z7Candidates 0 [2, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_12 :
    ((z7Candidates 0 [3, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_13 :
    ((z7Candidates 0 [3, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_0_14 :
    ((z7Candidates 0 [4, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_0 :
    ((z7Candidates 2 [0, 0]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_1 :
    ((z7Candidates 2 [0, 1]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_2 :
    ((z7Candidates 2 [0, 2]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_3 :
    ((z7Candidates 2 [0, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_4 :
    ((z7Candidates 2 [0, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_5 :
    ((z7Candidates 2 [1, 1]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_6 :
    ((z7Candidates 2 [1, 2]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_7 :
    ((z7Candidates 2 [1, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_8 :
    ((z7Candidates 2 [1, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_9 :
    ((z7Candidates 2 [2, 2]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_10 :
    ((z7Candidates 2 [2, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_11 :
    ((z7Candidates 2 [2, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_12 :
    ((z7Candidates 2 [3, 3]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_13 :
    ((z7Candidates 2 [3, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

private theorem z7Cover_2_14 :
    ((z7Candidates 2 [4, 4]).all fun r => decide (r ∈ z7RootValues)) = true := by
  decide +kernel

theorem z7Candidates_covered (d : Nat) (p : List Nat)
    (hd : d = 0 ∨ d = 2) (hp : p ∈ z7PairValues) :
    ((z7Candidates d p).all fun r => decide (r ∈ z7RootValues)) = true := by
  rcases hd with rfl | rfl
  · simp only [z7PairValues, List.mem_cons, List.mem_singleton] at hp
    rcases hp with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | h
    · exact z7Cover_0_0
    · exact z7Cover_0_1
    · exact z7Cover_0_2
    · exact z7Cover_0_3
    · exact z7Cover_0_4
    · exact z7Cover_0_5
    · exact z7Cover_0_6
    · exact z7Cover_0_7
    · exact z7Cover_0_8
    · exact z7Cover_0_9
    · exact z7Cover_0_10
    · exact z7Cover_0_11
    · exact z7Cover_0_12
    · exact z7Cover_0_13
    · exact z7Cover_0_14
    · cases h
  · simp only [z7PairValues, List.mem_cons, List.mem_singleton] at hp
    rcases hp with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | h
    · exact z7Cover_2_0
    · exact z7Cover_2_1
    · exact z7Cover_2_2
    · exact z7Cover_2_3
    · exact z7Cover_2_4
    · exact z7Cover_2_5
    · exact z7Cover_2_6
    · exact z7Cover_2_7
    · exact z7Cover_2_8
    · exact z7Cover_2_9
    · exact z7Cover_2_10
    · exact z7Cover_2_11
    · exact z7Cover_2_12
    · exact z7Cover_2_13
    · exact z7Cover_2_14
    · cases h

#print axioms z7RootValues_length
#print axioms z7PairValues_complete
#print axioms z7TripleValues_complete
#print axioms z7TailValues_complete
#print axioms z7Candidates_covered

end Matrix99
