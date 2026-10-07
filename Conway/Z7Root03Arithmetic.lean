import Conway.Z7Root22Arithmetic
namespace Matrix99

private theorem finRange12_parity : List.finRange 12=[0,1,2,3,4,5,6,7,8,9,10,11] := by decide +kernel
private theorem sum12_parity_expand (f : Fin 12 → Nat) :
    sum12 f=f 0+f 1+f 2+f 3+f 4+f 5+f 6+f 7+f 8+f 9+f 10+f 11 := by
  unfold sum12
  rw [finRange12_parity]
  simp only [List.map_cons,List.map_nil,List.sum_cons,List.sum_nil,Nat.add_zero]
  ac_rfl

theorem exterior_tail_sum_even (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) (i : Fin 12) :
    (C i 6+C i 7+C i 8+C i 9+C i 10+C i 11)%2=0 := by
  have hs := hC.2.2.2.1 i
  have hb := hC.2.2.2.2.1 i
  rw [sum12_parity_expand] at hs
  omega

private theorem even_mul_mod (a b : Nat) (ha : a≤4) (hb : b≤4) (hp : a%2=0) : (a*b)%2=0 := by
  have finite : ∀u v:Fin 5, u.val%2=0 → (u.val*v.val)%2=0 := by decide +kernel
  exact finite ⟨a,Nat.lt_succ_of_le ha⟩ ⟨b,Nat.lt_succ_of_le hb⟩ hp
private theorem odd_mul_mod (a b : Nat) (ha : a≤4) (hb : b≤4) (hp : a%2=1) : (a*b)%2=b%2 := by
  have finite : ∀u v:Fin 5, u.val%2=1 → (u.val*v.val)%2=v.val%2 := by decide +kernel
  exact finite ⟨a,Nat.lt_succ_of_le ha⟩ ⟨b,Nat.lt_succ_of_le hb⟩ hp

def Z7TailParityRow (r : Fin 12 → Nat) : Prop :=
  ∀j : Fin 12, r j%2 = if j.val<6 then 0 else 1
instance (r : Fin 12 → Nat) : Decidable (Z7TailParityRow r) :=
  inferInstanceAs (Decidable (∀j : Fin 12, r j%2 = if j.val<6 then 0 else 1))

private theorem parity_arithmetic (x y : Fin 12 → Nat) (v : Nat)
    (ht : (x 6+x 7+x 8+x 9+x 10+x 11)%2=0)
    (hd : sum12 y+v=12) (hv : v%2=1)
    (h0 : y 0%2=0) (h1 : y 1%2=0) (h2 : y 2%2=0)
    (h3 : y 3%2=0) (h4 : y 4%2=0) (h5 : y 5%2=0)
    (h6 : y 6%2=x 6%2) (h7 : y 7%2=x 7%2) (h8 : y 8%2=x 8%2)
    (h9 : y 9%2=x 9%2) (h10 : y 10%2=x 10%2) (h11 : y 11%2=x 11%2) : False := by
  rw [sum12_parity_expand] at hd
  omega

theorem exterior_not_tail_parity (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    ¬ Z7TailParityRow (C 0) := by
  intro hp
  have hd := hC.2.2.2.2.2 0 11
  have target : z7ExteriorTarget 0 11=12 := by decide +kernel
  rw [target] at hd
  have hv : C 0 11%2=1 := hp 11
  have b0 := even_mul_mod (C 0 0) (C 11 0) (hC.2.1 0 0) (hC.2.1 11 0) (hp 0)
  have b1 := even_mul_mod (C 0 1) (C 11 1) (hC.2.1 0 1) (hC.2.1 11 1) (hp 1)
  have b2 := even_mul_mod (C 0 2) (C 11 2) (hC.2.1 0 2) (hC.2.1 11 2) (hp 2)
  have b3 := even_mul_mod (C 0 3) (C 11 3) (hC.2.1 0 3) (hC.2.1 11 3) (hp 3)
  have b4 := even_mul_mod (C 0 4) (C 11 4) (hC.2.1 0 4) (hC.2.1 11 4) (hp 4)
  have b5 := even_mul_mod (C 0 5) (C 11 5) (hC.2.1 0 5) (hC.2.1 11 5) (hp 5)
  have b6 := odd_mul_mod (C 0 6) (C 11 6) (hC.2.1 0 6) (hC.2.1 11 6) (hp 6)
  have b7 := odd_mul_mod (C 0 7) (C 11 7) (hC.2.1 0 7) (hC.2.1 11 7) (hp 7)
  have b8 := odd_mul_mod (C 0 8) (C 11 8) (hC.2.1 0 8) (hC.2.1 11 8) (hp 8)
  have b9 := odd_mul_mod (C 0 9) (C 11 9) (hC.2.1 0 9) (hC.2.1 11 9) (hp 9)
  have b10 := odd_mul_mod (C 0 10) (C 11 10) (hC.2.1 0 10) (hC.2.1 11 10) (hp 10)
  have b11 := odd_mul_mod (C 0 11) (C 11 11) (hC.2.1 0 11) (hC.2.1 11 11) (hp 11)
  exact parity_arithmetic (C 11) (fun k => C 0 k*C 11 k) (C 0 11)
    (exterior_tail_sum_even C hC 11) hd hv b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11

def z7Root03Row (j : Fin 12) : Nat :=
  match j.val with
  | 2 | 5 => 2
  | 6 | 7 | 8 | 9 | 10 => 1
  | 11 => 3
  | _ => 0

theorem z7Root03Row_values : (List.finRange 12).map z7Root03Row =
    [0,0,2,0,0,2,1,1,1,1,1,3] := by decide +kernel

theorem z7Root03Row_manifest : (List.finRange 12).map z7Root03Row=z7RootValues[3]! := by decide +kernel

theorem z7Root03Row_parity : Z7TailParityRow z7Root03Row := by decide +kernel

theorem exterior_root03_false (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hrow : ∀j, C 0 j=z7Root03Row j) : False := by
  apply exterior_not_tail_parity C hC
  intro j
  rw [hrow j]
  exact z7Root03Row_parity j

theorem no_exterior_root03 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀j,C 0 j=z7Root03Row j) := by
  intro h
  obtain ⟨C,hC,hr⟩ := h
  exact exterior_root03_false C hC hr

def z7TailParityTest (r : List Nat) : Bool := decide (Z7TailParityRow (fun j => r[j.val]!))
def z7ParityExcludedRoots : List (List Nat) := z7NormRemainingRoots.filter z7TailParityTest
def z7ParityRemainingRoots : List (List Nat) := z7NormRemainingRoots.filter (fun r => !z7TailParityTest r)
theorem z7ParityExcludedRoots_values : z7ParityExcludedRoots=[z7RootValues[3]!] := by decide +kernel
theorem z7ParityRemainingRoots_length : z7ParityRemainingRoots.length=30 := by decide +kernel

theorem z7RowValues_get (r : Fin 12 → Nat) (j : Fin 12) :
    ((List.finRange 12).map r)[j.val]! = r j := by
  have cases12 : ∀i : Fin 12, i=0 ∨ i=1 ∨ i=2 ∨ i=3 ∨ i=4 ∨ i=5 ∨ i=6 ∨ i=7 ∨ i=8 ∨ i=9 ∨ i=10 ∨ i=11 := by decide +kernel
  rcases cases12 j with rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl
  all_goals rw [finRange12_parity]; rfl

theorem exterior_row_mem_parity_remaining (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (hr : (List.finRange 12).map (C 0) ∈ z7NormRemainingRoots) :
    (List.finRange 12).map (C 0) ∈ z7ParityRemainingRoots := by
  apply List.mem_filter.mpr
  refine ⟨hr,?_⟩
  have hn : ¬ Z7TailParityRow (fun j => ((List.finRange 12).map (C 0))[j.val]!) := by
    intro hp
    apply exterior_not_tail_parity C hC
    intro j
    simpa only [z7RowValues_get] using hp j
  have hf : z7TailParityTest ((List.finRange 12).map (C 0))=false := decide_eq_false hn
  exact congrArg Bool.not hf

theorem conway_z7_has_parity_remaining_root (h : HasZ7Symmetry) :
    ∃ C : Fin 12 → Fin 12 → Nat,
      ExteriorEquations C ∧ (List.finRange 12).map (C 0) ∈ z7ParityRemainingRoots := by
  obtain ⟨C,hC,hr⟩ := conway_z7_has_norm_remaining_root h
  exact ⟨C,hC,exterior_row_mem_parity_remaining C hC hr⟩

#print axioms finRange12_parity
#print axioms exterior_tail_sum_even
#print axioms even_mul_mod
#print axioms odd_mul_mod
#print axioms exterior_not_tail_parity
#print axioms z7Root03Row_values
#print axioms z7Root03Row_manifest
#print axioms z7Root03Row_parity
#print axioms exterior_root03_false
#print axioms no_exterior_root03
#print axioms z7ParityExcludedRoots_values
#print axioms z7ParityRemainingRoots_length
#print axioms exterior_row_mem_parity_remaining
#print axioms conway_z7_has_parity_remaining_root
end Matrix99
