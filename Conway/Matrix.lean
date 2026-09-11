/-
  Conway's 99-Graph Problem Formalization in Lean 4
  Strongly Regular Graph srg(99, 14, 1, 2)
  Matrix definitions and verification functions.
-/

namespace Function

/-- Bijectivity definition for self-contained usage without Mathlib. -/
def Bijective {α β : Sort _} (f : α → β) : Prop :=
  Injective f ∧ Surjective f

/-- Function iteration f^[n] defined self-sufficiently for Lean 4 core. -/
def iterate {α : Sort _} (f : α → α) : Nat → (α → α)
  | 0 => id
  | n + 1 => f ∘ iterate f n

end Function

notation:max f "^[" n "]" => Function.iterate f n

abbrev Fin99 := Fin 99

def Matrix99 (α : Type) := Fin99 → Fin99 → α

namespace Matrix99

/-- Matrix multiplication on 99x99 matrices over Nat. -/
def mul (A B : Matrix99 Nat) : Matrix99 Nat :=
  fun i j => (List.finRange 99).foldl (fun acc k => acc + (A i k) * (B k j)) 0

/-- Matrix addition. -/
def add (A B : Matrix99 Nat) : Matrix99 Nat :=
  fun i j => A i j + B i j

/-- Identity matrix: 1 on diagonal, 0 elsewhere. -/
def eye : Matrix99 Nat :=
  fun i j => if i.val == j.val then 1 else 0

/-- All-ones matrix J. -/
def allOnes : Matrix99 Nat :=
  fun _ _ => 1

/-- Scalar multiplication. -/
def smul (c : Nat) (A : Matrix99 Nat) : Matrix99 Nat :=
  fun i j => c * A i j

/-- Target RHS of the SRG equation: 12*I + 2*J for srg(99, 14, 1, 2). -/
def targetRHS : Matrix99 Nat :=
  add (smul 12 eye) (smul 2 allOnes)

/-- Check that diagonal entries are all zero. -/
def isZeroDiagonal (A : Matrix99 Nat) : Bool :=
  (List.finRange 99).all (fun i => A i i == 0)

/-- Check that matrix is symmetric. -/
def isSymmetric (A : Matrix99 Nat) : Bool :=
  (List.finRange 99).all (fun i =>
    (List.finRange 99).all (fun j =>
      A i j == A j i))

/-- Check that all entries are binary (0 or 1). -/
def isBinary (A : Matrix99 Nat) : Bool :=
  (List.finRange 99).all (fun i =>
    (List.finRange 99).all (fun j =>
      let v := A i j
      v == 0 || v == 1))

/-- Check SRG equation: A^2 + A = 12*I + 2*J. -/
def satisfiesSRGEquation (A : Matrix99 Nat) : Bool :=
  let LHS := add (mul A A) A
  (List.finRange 99).all (fun i =>
    (List.finRange 99).all (fun j =>
      LHS i j == targetRHS i j))

/-- Combined decidable certificate checker for candidate adjacency matrices. -/
def checkConway (A : Matrix99 Nat) : Bool :=
  isZeroDiagonal A && isSymmetric A && isBinary A && satisfiesSRGEquation A

/-- Defining proposition for Conway's 99-graph adjacency matrix. -/
def ConwayAdj (A : Matrix99 Nat) : Prop :=
  (∀ i : Fin99, A i i = 0) ∧
  (∀ i j : Fin99, A i j = A j i) ∧
  (∀ i j : Fin99, A i j = 0 ∨ A i j = 1) ∧
  (∀ i j : Fin99, (mul A A i j) + A i j = targetRHS i j)

end Matrix99
