import Conway.Z7RowGen

namespace Matrix99

/-- The states `(pref, total, squares, balance)` reached after `d` further
    column choices of `z7GenRow`, in generation order.  Mirrors `z7GenRow`
    exactly for `d` levels; below depth `d` generation is suspended and the
    reached state is returned instead. -/
def z7GenStates : Nat → Nat → Nat → Nat → List Nat → Nat → Nat → Int →
    List (List Nat × Nat × Nat × Int)
  | 0, _, _, _, pref, total, squares, balance =>
    [(pref, total, squares, balance)]
  | d + 1, fuel, index, j, pref, total, squares, balance =>
    if j = 12 then []
    else
      match fuel with
      | 0 => []
      | fuel + 1 =>
        if !z7RowPossible j total squares balance then []
        else
          (z7ColVals j index).flatMap fun v =>
            let diag := if j = index then v else 0
            if decide (v ≤ total ∧ v * v + diag ≤ squares) then
              z7GenStates d fuel index (j + 1) (pref ++ [v])
                (total - v) (squares - (v * v + diag)) (balance - z7ColWeight j * v)
            else []

theorem flatMap_append {α β : Type} (f : α → List β) (l₁ l₂ : List α) :
    (l₁ ++ l₂).flatMap f = l₁.flatMap f ++ l₂.flatMap f := by
  induction l₁ with
  | nil => rfl
  | cons a l ih =>
    rw [List.cons_append, List.flatMap_cons, List.flatMap_cons, ih,
        List.append_assoc]

theorem flatMap_flatMap {α β γ : Type} (f : α → List β) (g : β → List γ)
    (l : List α) :
    (l.flatMap f).flatMap g = l.flatMap (fun x => (f x).flatMap g) := by
  induction l with
  | nil => rfl
  | cons a l ih =>
    rw [List.flatMap_cons, flatMap_append, List.flatMap_cons, ih]

theorem flatMap_congr_fun {α β : Type} {f g : α → List β} {l : List α}
    (h : ∀ a, f a = g a) : l.flatMap f = l.flatMap g := by
  induction l with
  | nil => rfl
  | cons a l ih => rw [List.flatMap_cons, List.flatMap_cons, h a, ih]

/-- `z7GenRow` factors through the depth-`d` reached states. -/
theorem z7GenRow_split (d fuel index j : Nat) (pref : List Nat)
    (total squares : Nat) (balance : Int)
    (hd : d ≤ fuel) (hj : j + d ≤ 12) :
    z7GenRow fuel index j pref total squares balance =
      (z7GenStates d fuel index j pref total squares balance).flatMap
        (fun s => z7GenRow (fuel - d) index (j + d) s.1 s.2.1 s.2.2.1 s.2.2.2) := by
  induction d generalizing fuel j pref total squares balance with
  | zero =>
    show z7GenRow fuel index j pref total squares balance =
      ([(pref, total, squares, balance)] : List _).flatMap _
    rw [List.flatMap_cons, List.flatMap_nil, List.append_nil]
    rfl
  | succ d ih =>
    cases fuel with
    | zero => exact absurd hd (Nat.not_succ_le_zero _)
    | succ f =>
      have hfd : f - d = (f + 1) - (d + 1) := (Nat.succ_sub_succ f d).symm
      have hjd : j + (d + 1) = (j + 1) + d := by omega
      have hj12 : j ≠ 12 := by omega
      have eLHS : z7GenRow (f + 1) index j pref total squares balance =
          if !z7RowPossible j total squares balance then []
          else (z7ColVals j index).flatMap fun v =>
            let diag := if j = index then v else 0
            if decide (v ≤ total ∧ v * v + diag ≤ squares) then
              z7GenRow f index (j + 1) (pref ++ [v])
                (total - v) (squares - (v * v + diag)) (balance - z7ColWeight j * v)
            else [] := by
        simp only [z7GenRow]
        rw [if_neg hj12]
      have eRHS : z7GenStates (d + 1) (f + 1) index j pref total squares balance =
          if !z7RowPossible j total squares balance then []
          else (z7ColVals j index).flatMap fun v =>
            let diag := if j = index then v else 0
            if decide (v ≤ total ∧ v * v + diag ≤ squares) then
              z7GenStates d f index (j + 1) (pref ++ [v])
                (total - v) (squares - (v * v + diag)) (balance - z7ColWeight j * v)
            else [] := by
        simp only [z7GenStates]
        rw [if_neg hj12]
      rw [eLHS, eRHS]
      cases hp : !z7RowPossible j total squares balance
      · -- z7RowPossible = true: descend
        rw [if_neg Bool.false_ne_true, if_neg Bool.false_ne_true]
        rw [flatMap_flatMap]
        apply flatMap_congr_fun
        intro v
        dsimp only
        cases hv : decide (v ≤ total ∧ v * v + (if j = index then v else 0) ≤ squares)
        · rw [if_neg Bool.false_ne_true, if_neg Bool.false_ne_true]
          rfl
        · rw [if_pos rfl, if_pos rfl]
          have hcont : (fun s : List Nat × Nat × Nat × Int =>
                z7GenRow ((f + 1) - (d + 1)) index (j + (d + 1))
                  s.1 s.2.1 s.2.2.1 s.2.2.2) =
              (fun s : List Nat × Nat × Nat × Int =>
                z7GenRow (f - d) index ((j + 1) + d)
                  s.1 s.2.1 s.2.2.1 s.2.2.2) := by
            funext s
            rw [← hfd, hjd]
          rw [hcont]
          exact ih f (j + 1) (pref ++ [v])
            (total - v) (squares - (v * v + (if j = index then v else 0)))
            (balance - z7ColWeight j * v) (by omega) (by omega)
      · -- z7RowPossible = false: both sides empty
        rw [if_pos rfl, if_pos rfl]
        rfl

end Matrix99
