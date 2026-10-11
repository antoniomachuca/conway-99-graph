import Conway.Z7RowGen
namespace Matrix99

def z7EncodeRow (row : List Nat) : Nat := row.foldl (fun acc x => acc * 5 + x) 0

def z7DecodeRow (n : Nat) : List Nat := (List.range 12).map fun k => n / 5 ^ (11 - k) % 5

/-- Structural row equality on Bool, avoiding DecidableEq resolution overhead. -/
def rowBeq : List Nat → List Nat → Bool
  | [], [] => true
  | a :: as, b :: bs => (a == b) && rowBeq as bs
  | _, _ => false

theorem rowBeq_sound {a b : List Nat} : rowBeq a b = true → a = b := by
  induction a generalizing b with
  | nil =>
    intro h
    cases b with
    | nil => rfl
    | cons b bs => exact Bool.noConfusion h
  | cons a as ih =>
    intro h
    cases b with
    | nil => exact Bool.noConfusion h
    | cons b bs =>
      have h' := Bool.and_eq_true_iff.mp h
      rw [beq_iff_eq.mp h'.1, ih h'.2]

/-- Structural list-of-rows equality on Bool. -/
def rowsBeq : List (List Nat) → List (List Nat) → Bool
  | [], [] => true
  | a :: as, b :: bs => rowBeq a b && rowsBeq as bs
  | _, _ => false

theorem rowsBeq_sound {a b : List (List Nat)} : rowsBeq a b = true → a = b := by
  induction a generalizing b with
  | nil =>
    intro h
    cases b with
    | nil => rfl
    | cons b bs => exact Bool.noConfusion h
  | cons a as ih =>
    intro h
    cases b with
    | nil => exact Bool.noConfusion h
    | cons b bs =>
      have h' := Bool.and_eq_true_iff.mp h
      rw [rowBeq_sound h'.1, ih h'.2]

end Matrix99
