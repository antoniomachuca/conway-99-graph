import Conway.Z7Root03Arithmetic
namespace Matrix99

private theorem finRange12_complement : List.finRange 12=[0,1,2,3,4,5,6,7,8,9,10,11] := by decide +kernel
private theorem sum12_complement_expand (f:Fin 12→Nat) :
    sum12 f=f 0+f 1+f 2+f 3+f 4+f 5+f 6+f 7+f 8+f 9+f 10+f 11 := by
  unfold sum12
  rw [finRange12_complement]
  simp only [List.map_cons,List.map_nil,List.sum_cons,List.sum_nil,Nat.add_zero]
  ac_rfl

def firstSixExceptFlag (k i:Fin 12) : Bool := decide (i.val<6 ∧ i≠0 ∧ i≠k)
def Z7ComplementParityRow (r : Fin 12→Nat) (k : Fin 12) : Prop :=
  ∀i:Fin 12, r i%2 = if firstSixExceptFlag k i then 1 else 0
instance (r : Fin 12→Nat) (k : Fin 12) : Decidable (Z7ComplementParityRow r k) :=
  inferInstanceAs (Decidable (∀i : Fin 12, r i%2 = if firstSixExceptFlag k i then 1 else 0))

private theorem flagged_product_nat (a b:Nat) (e:Bool) (ha:a≤4) (hb:b≤4)
    (hp:a%2=if e then 1 else 0) : (a*b)%2=if e then b%2 else 0 := by
  have finite : ∀a b:Fin 5,∀e:Bool, a.val%2=(if e then 1 else 0) →
      (a.val*b.val)%2=(if e then b.val%2 else 0) := by decide +kernel
  exact finite ⟨a,Nat.lt_succ_of_le ha⟩ ⟨b,Nat.lt_succ_of_le hb⟩ e hp

private theorem even_square_nat (n:Nat) (hn:n≤4) (he:n%2=0) : 2*n≤n*n := by
  have finite : ∀n:Fin 5,n.val%2=0 → 2*n.val≤n.val*n.val := by decide +kernel
  exact finite ⟨n,Nat.lt_succ_of_le hn⟩ he

private theorem even_row_arithmetic (x:Fin 12→Nat) (d:Nat)
    (hx:∀i,x i≤4) (he:∀i,x i%2=0) (hs:sum12 x=12)
    (hn:sum12 (fun i=>x i*x i)+d=22) : False := by
  have b0 := even_square_nat (x 0) (hx 0) (he 0)
  have b1 := even_square_nat (x 1) (hx 1) (he 1)
  have b2 := even_square_nat (x 2) (hx 2) (he 2)
  have b3 := even_square_nat (x 3) (hx 3) (he 3)
  have b4 := even_square_nat (x 4) (hx 4) (he 4)
  have b5 := even_square_nat (x 5) (hx 5) (he 5)
  have b6 := even_square_nat (x 6) (hx 6) (he 6)
  have b7 := even_square_nat (x 7) (hx 7) (he 7)
  have b8 := even_square_nat (x 8) (hx 8) (he 8)
  have b9 := even_square_nat (x 9) (hx 9) (he 9)
  have b10 := even_square_nat (x 10) (hx 10) (he 10)
  have b11 := even_square_nat (x 11) (hx 11) (he 11)
  simp only [sum12_complement_expand] at hs hn
  omega

theorem exterior_first_six_not_all_even (C:Fin 12→Fin 12→Nat) (hC:ExteriorEquations C)
    (i:Fin 12) (hi:i.val<6) : ¬(∀j,C i j%2=0) := by
  intro he
  have hn := hC.2.2.2.2.2 i i
  have targets : ∀k:Fin 12,k.val<6 → z7ExteriorTarget k k=22 := by decide +kernel
  rw [targets i hi] at hn
  exact even_row_arithmetic (C i) (C i i) (hC.2.1 i) he (hC.2.2.2.1 i) hn

private theorem complement_arithmetic (x y:Fin 12→Nat) (k:Fin 12)
    (hk0:1≤k.val) (hk6:k.val<6)
    (hs:(x 0+x 1+x 2+x 3+x 4+x 5)%2=0)
    (hd:(sum12 y+x 0)%2=0)
    (hp:∀i,y i%2=if firstSixExceptFlag k i then x i%2 else 0) : x k%2=0 := by
  have p0 := hp 0
  have p1 := hp 1
  have p2 := hp 2
  have p3 := hp 3
  have p4 := hp 4
  have p5 := hp 5
  have p6 := hp 6
  have p7 := hp 7
  have p8 := hp 8
  have p9 := hp 9
  have p10 := hp 10
  have p11 := hp 11
  rw [sum12_complement_expand] at hd
  have choices : ∀j:Fin 12,1≤j.val → j.val<6 → j=1 ∨ j=2 ∨ j=3 ∨ j=4 ∨ j=5 := by decide +kernel
  rcases choices k hk0 hk6 with rfl|rfl|rfl|rfl|rfl
  · change y 0 % 2 = 0 at p0
    change y 1 % 2 = 0 at p1
    change y 2 % 2 = x 2 % 2 at p2
    change y 3 % 2 = x 3 % 2 at p3
    change y 4 % 2 = x 4 % 2 at p4
    change y 5 % 2 = x 5 % 2 at p5
    change y 6 % 2 = 0 at p6
    change y 7 % 2 = 0 at p7
    change y 8 % 2 = 0 at p8
    change y 9 % 2 = 0 at p9
    change y 10 % 2 = 0 at p10
    change y 11 % 2 = 0 at p11
    omega
  · change y 0 % 2 = 0 at p0
    change y 1 % 2 = x 1 % 2 at p1
    change y 2 % 2 = 0 at p2
    change y 3 % 2 = x 3 % 2 at p3
    change y 4 % 2 = x 4 % 2 at p4
    change y 5 % 2 = x 5 % 2 at p5
    change y 6 % 2 = 0 at p6
    change y 7 % 2 = 0 at p7
    change y 8 % 2 = 0 at p8
    change y 9 % 2 = 0 at p9
    change y 10 % 2 = 0 at p10
    change y 11 % 2 = 0 at p11
    omega
  · change y 0 % 2 = 0 at p0
    change y 1 % 2 = x 1 % 2 at p1
    change y 2 % 2 = x 2 % 2 at p2
    change y 3 % 2 = 0 at p3
    change y 4 % 2 = x 4 % 2 at p4
    change y 5 % 2 = x 5 % 2 at p5
    change y 6 % 2 = 0 at p6
    change y 7 % 2 = 0 at p7
    change y 8 % 2 = 0 at p8
    change y 9 % 2 = 0 at p9
    change y 10 % 2 = 0 at p10
    change y 11 % 2 = 0 at p11
    omega
  · change y 0 % 2 = 0 at p0
    change y 1 % 2 = x 1 % 2 at p1
    change y 2 % 2 = x 2 % 2 at p2
    change y 3 % 2 = x 3 % 2 at p3
    change y 4 % 2 = 0 at p4
    change y 5 % 2 = x 5 % 2 at p5
    change y 6 % 2 = 0 at p6
    change y 7 % 2 = 0 at p7
    change y 8 % 2 = 0 at p8
    change y 9 % 2 = 0 at p9
    change y 10 % 2 = 0 at p10
    change y 11 % 2 = 0 at p11
    omega
  · change y 0 % 2 = 0 at p0
    change y 1 % 2 = x 1 % 2 at p1
    change y 2 % 2 = x 2 % 2 at p2
    change y 3 % 2 = x 3 % 2 at p3
    change y 4 % 2 = x 4 % 2 at p4
    change y 5 % 2 = 0 at p5
    change y 6 % 2 = 0 at p6
    change y 7 % 2 = 0 at p7
    change y 8 % 2 = 0 at p8
    change y 9 % 2 = 0 at p9
    change y 10 % 2 = 0 at p10
    change y 11 % 2 = 0 at p11
    omega

theorem exterior_complement_forces_even_row (C:Fin 12→Fin 12→Nat) (hC:ExteriorEquations C)
    (k:Fin 12) (hk0:1≤k.val) (hk6:k.val<6) (hp:Z7ComplementParityRow (C 0) k) :
    ∀j,C k j%2=0 := by
  intro j
  have hb := hC.2.2.2.2.1 j
  have hs : (C j 0+C j 1+C j 2+C j 3+C j 4+C j 5)%2=0 := by omega
  have hd0 := hC.2.2.2.2.2 0 j
  have targets : ∀i:Fin 12,z7ExteriorTarget 0 i%2=0 := by decide +kernel
  have hm : (sum12 (fun i=>C 0 i*C j i)+C 0 j)%2=0 :=
    (congrArg (fun n:Nat=>n%2) hd0).trans (targets j)
  have hd : (sum12 (fun i=>C 0 i*C j i)+C j 0)%2=0 := by
    simpa only [hC.1 0 j] using hm
  have hp' : ∀i,(C 0 i*C j i)%2=if firstSixExceptFlag k i then C j i%2 else 0 := by
    intro i
    exact flagged_product_nat (C 0 i) (C j i) (firstSixExceptFlag k i) (hC.2.1 0 i) (hC.2.1 j i) (hp i)
  have he := complement_arithmetic (C j) (fun i=>C 0 i*C j i) k hk0 hk6 hs hd hp'
  rw [hC.1 k j]
  exact he

theorem exterior_not_complement_parity (C:Fin 12→Fin 12→Nat) (hC:ExteriorEquations C)
    (k:Fin 12) (hk0:1≤k.val) (hk6:k.val<6) : ¬Z7ComplementParityRow (C 0) k := by
  intro hp
  exact exterior_first_six_not_all_even C hC k hk6 (exterior_complement_forces_even_row C hC k hk0 hk6 hp)

def z7Root25Row (j:Fin 12) : Nat := z7RootValues[25]![j.val]!
def z7Root31Row (j:Fin 12) : Nat := z7RootValues[31]![j.val]!
theorem z7Root25Row_values : (List.finRange 12).map z7Root25Row=[2,0,1,1,1,1,0,0,0,2,2,2] := by decide +kernel
theorem z7Root31Row_values : (List.finRange 12).map z7Root31Row=[2,1,1,1,1,2,0,0,0,0,2,2] := by decide +kernel
theorem z7Root25Row_pattern : Z7ComplementParityRow z7Root25Row 1 := by decide +kernel
theorem z7Root31Row_pattern : Z7ComplementParityRow z7Root31Row 5 := by decide +kernel

theorem exterior_root25_false (C:Fin 12→Fin 12→Nat) (hC:ExteriorEquations C)
    (hrow:∀j,C 0 j=z7Root25Row j) : False := by
  apply exterior_not_complement_parity C hC 1 (by decide) (by decide)
  intro j
  rw [hrow j]
  exact z7Root25Row_pattern j

theorem exterior_root31_false (C:Fin 12→Fin 12→Nat) (hC:ExteriorEquations C)
    (hrow:∀j,C 0 j=z7Root31Row j) : False := by
  apply exterior_not_complement_parity C hC 5 (by decide) (by decide)
  intro j
  rw [hrow j]
  exact z7Root31Row_pattern j

private def complementIndex (k:Fin 5) : Fin 12 := ⟨k.val+1,by omega⟩
def z7ComplementParityTest (r:List Nat) : Bool :=
  decide (∃k:Fin 5,Z7ComplementParityRow (fun i=>r[i.val]!) (complementIndex k))
def z7ComplementExcludedRoots : List (List Nat) := z7ParityRemainingRoots.filter z7ComplementParityTest
def z7ComplementRemainingRoots : List (List Nat) := z7ParityRemainingRoots.filter (fun r=>!z7ComplementParityTest r)
theorem no_exterior_root25 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root25Row j) := by
  intro h
  obtain ⟨C,hC,hr⟩ := h
  exact exterior_root25_false C hC hr

theorem no_exterior_root31 : ¬ ∃ C : Fin 12 → Fin 12 → Nat,
    ExteriorEquations C ∧ (∀ j, C 0 j = z7Root31Row j) := by
  intro h
  obtain ⟨C,hC,hr⟩ := h
  exact exterior_root31_false C hC hr

theorem z7ComplementExcludedRoots_values : z7ComplementExcludedRoots=[z7RootValues[25]!,z7RootValues[31]!] := by decide +kernel
theorem z7ComplementRemainingRoots_length : z7ComplementRemainingRoots.length=28 := by decide +kernel

theorem exterior_row_mem_complement_remaining (C:Fin 12→Fin 12→Nat) (hC:ExteriorEquations C)
    (hr:(List.finRange 12).map (C 0)∈z7ParityRemainingRoots) :
    (List.finRange 12).map (C 0)∈z7ComplementRemainingRoots := by
  apply List.mem_filter.mpr
  refine ⟨hr,?_⟩
  have hn : ¬∃k:Fin 5,Z7ComplementParityRow (fun i=>((List.finRange 12).map (C 0))[i.val]!) (complementIndex k) := by
    intro h
    obtain ⟨k,hp⟩ := h
    have hk0 : 1≤(complementIndex k).val := by dsimp [complementIndex]; omega
    have hk6 : (complementIndex k).val<6 := by dsimp [complementIndex]; omega
    apply exterior_not_complement_parity C hC (complementIndex k) hk0 hk6
    intro i
    simpa only [z7RowValues_get] using hp i
  have hf : z7ComplementParityTest ((List.finRange 12).map (C 0))=false := decide_eq_false hn
  exact congrArg Bool.not hf

theorem conway_z7_has_complement_remaining_root (h:HasZ7Symmetry) :
    ∃C:Fin 12→Fin 12→Nat,ExteriorEquations C ∧ (List.finRange 12).map (C 0)∈z7ComplementRemainingRoots := by
  obtain ⟨C,hC,hr⟩ := conway_z7_has_parity_remaining_root h
  exact ⟨C,hC,exterior_row_mem_complement_remaining C hC hr⟩

#print axioms exterior_first_six_not_all_even
#print axioms exterior_complement_forces_even_row
#print axioms exterior_not_complement_parity
#print axioms z7Root25Row_values
#print axioms z7Root31Row_values
#print axioms z7Root25Row_pattern
#print axioms z7Root31Row_pattern
#print axioms exterior_root25_false
#print axioms exterior_root31_false
#print axioms no_exterior_root25
#print axioms no_exterior_root31
#print axioms z7ComplementExcludedRoots_values
#print axioms z7ComplementRemainingRoots_length
#print axioms exterior_row_mem_complement_remaining
#print axioms conway_z7_has_complement_remaining_root
end Matrix99
