import Conway.Z7Row0Symmetry
namespace Matrix99

private theorem finRange12_norm :
    List.finRange 12 = [0,1,2,3,4,5,6,7,8,9,10,11] := by decide +kernel

private theorem sum12_norm_expand (f : Fin 12 → Nat) :
    sum12 f = f 0+f 1+f 2+f 3+f 4+f 5+f 6+f 7+f 8+f 9+f 10+f 11 := by
  unfold sum12
  rw [finRange12_norm]
  simp only [List.map_cons,List.map_nil,List.sum_cons,List.sum_nil,Nat.add_zero]
  ac_rfl

private theorem bounded_mix_square (a b : Nat) (ha : a ≤ 4) (hb : b ≤ 4) :
    (2*a+b)*(2*a+b) = 4*(a*a)+4*(a*b)+b*b := by
  have finite : ∀ u v : Fin 5,
      (2*u.val+v.val)*(2*u.val+v.val) = 4*(u.val*u.val)+4*(u.val*v.val)+v.val*v.val := by decide +kernel
  exact finite ⟨a,Nat.lt_succ_of_le ha⟩ ⟨b,Nat.lt_succ_of_le hb⟩

private theorem scalar_square_bound : ∀ a : Fin 30, ∀ n : Fin 13,
    8*a.val*n.val ≤ a.val*a.val+16*(n.val*n.val) := by decide +kernel

private theorem scalar_square_nat (a n : Nat) (ha : a < 30) (hn : n ≤ 12) :
    8*a*n ≤ a*a+16*(n*n) :=
  scalar_square_bound ⟨a,ha⟩ ⟨n,Nat.lt_succ_of_le hn⟩

private def normWeight (t : Fin 12 → Nat) : Nat :=
  29*t 0+5*t 1+5*t 2+13*t 3+13*t 4+13*t 5+
    9*t 6+9*t 7+9*t 8+9*t 9+9*t 10+21*t 11

private theorem weighted_square_bound (t : Fin 12 → Nat) (ht : ∀ i, t i ≤ 12) :
    8*normWeight t ≤ 2244+16*sum12 (fun i => t i*t i) := by
  have b0 := scalar_square_nat 29 (t 0) (by decide) (ht 0)
  have b1 := scalar_square_nat 5 (t 1) (by decide) (ht 1)
  have b2 := scalar_square_nat 5 (t 2) (by decide) (ht 2)
  have b3 := scalar_square_nat 13 (t 3) (by decide) (ht 3)
  have b4 := scalar_square_nat 13 (t 4) (by decide) (ht 4)
  have b5 := scalar_square_nat 13 (t 5) (by decide) (ht 5)
  have b6 := scalar_square_nat 9 (t 6) (by decide) (ht 6)
  have b7 := scalar_square_nat 9 (t 7) (by decide) (ht 7)
  have b8 := scalar_square_nat 9 (t 8) (by decide) (ht 8)
  have b9 := scalar_square_nat 9 (t 9) (by decide) (ht 9)
  have b10 := scalar_square_nat 9 (t 10) (by decide) (ht 10)
  have b11 := scalar_square_nat 21 (t 11) (by decide) (ht 11)
  rw [sum12_norm_expand]
  unfold normWeight
  omega

private theorem sum12_mix (a b : Fin 12 → Nat) :
    sum12 (fun k => 2*a k+b k) = 2*sum12 a+sum12 b := by
  simp only [sum12_norm_expand,Nat.mul_add]
  ac_rfl

private theorem sum12_mix_square (a b : Fin 12 → Nat)
    (ha : ∀ k, a k ≤ 4) (hb : ∀ k, b k ≤ 4) :
    sum12 (fun k => (2*a k+b k)*(2*a k+b k)) =
      4*sum12 (fun k => a k*a k)+4*sum12 (fun k => a k*b k)+sum12 (fun k => b k*b k) := by
  calc
    _ = sum12 (fun k => 4*(a k*a k)+4*(a k*b k)+b k*b k) :=
      congrArg sum12 (funext (fun k => bounded_mix_square (a k) (b k) (ha k) (hb k)))
    _ = _ := by
      simp only [sum12_norm_expand,Nat.mul_add]
      ac_rfl

private theorem energy_arithmetic {S p q r a d v : Nat}
    (hm : S=4*p+4*r+q) (hp : p+a=22) (hq : q+d=24) (hr : r+v=12) :
    S+4*a+d+4*v=160 := by omega

private theorem mix_balance (a b : Fin 12 → Nat)
    (ha : a 0+a 1+a 2=a 3+a 4+a 5)
    (hb : b 0+b 1+b 2=b 3+b 4+b 5) :
    (2*a 0+b 0)+(2*a 1+b 1)+(2*a 2+b 2)=
      (2*a 3+b 3)+(2*a 4+b 4)+(2*a 5+b 5) := by omega

private theorem weight_arithmetic (t : Fin 12 → Nat) (a v d : Nat)
    (hs : sum12 t=36) (hb : t 0+t 1+t 2=t 3+t 4+t 5)
    (h0 : t 0=2*a+v) (h11 : t 11=2*v+d) :
    normWeight t=324+48*a+48*v+12*d := by
  rw [sum12_norm_expand] at hs
  unfold normWeight
  omega

private theorem certificate_arithmetic {S W a v d : Nat}
    (hs : S+4*a+d+4*v=160)
    (hw : W=324+48*a+48*v+12*d)
    (hb : 8*W≤2244+16*S) : 16*a+16*v+4*d≤79 := by omega

theorem exterior_last_pair_norm_bound (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C) :
    16*C 0 0+16*C 0 11+4*C 11 11 ≤ 79 := by
  let t : Fin 12 → Nat := fun k => 2*C 0 k+C 11 k
  have ht : ∀ k, t k ≤ 12 := by
    intro k
    have ha := hC.2.1 0 k
    have hb := hC.2.1 11 k
    dsimp [t]
    omega
  have n0 := hC.2.2.2.2.2 0 0
  have n11 := hC.2.2.2.2.2 11 11
  have dot := hC.2.2.2.2.2 0 11
  have target0 : z7ExteriorTarget 0 0 = 22 := by decide +kernel
  have target11 : z7ExteriorTarget 11 11 = 24 := by decide +kernel
  have target01 : z7ExteriorTarget 0 11 = 12 := by decide +kernel
  rw [target0] at n0
  rw [target11] at n11
  rw [target01] at dot
  have hm := sum12_mix_square (C 0) (C 11) (hC.2.1 0) (hC.2.1 11)
  have energy : sum12 (fun k => t k*t k)+4*C 0 0+C 11 11+4*C 0 11=160 :=
    energy_arithmetic hm n0 n11 dot
  have tsum : sum12 t=36 := by
    change sum12 (fun k => 2*C 0 k+C 11 k)=36
    rw [sum12_mix,hC.2.2.2.1 0,hC.2.2.2.1 11]
  have tbal : t 0+t 1+t 2=t 3+t 4+t 5 :=
    mix_balance (C 0) (C 11) (hC.2.2.2.2.1 0) (hC.2.2.2.2.1 11)
  have t0 : t 0=2*C 0 0+C 0 11 := by
    dsimp [t]
    rw [hC.1 11 0]
  have t11 : t 11=2*C 0 11+C 11 11 := rfl
  have weight := weight_arithmetic t (C 0 0) (C 0 11) (C 11 11) tsum tbal t0 t11
  exact certificate_arithmetic energy weight (weighted_square_bound t ht)

theorem exterior_last_entry_diag_bound (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) : C 0 0+C 0 11 ≤ 4 := by
  have h := exterior_last_pair_norm_bound C hC
  omega

private def tailSwap (j i : Fin 12) : Fin 12 :=
  if i = j then 11 else if i = 11 then j else i

private theorem tailSwap_twice : ∀ j i : Fin 12, tailSwap j (tailSwap j i) = i := by decide +kernel
private theorem tailSwap_last : ∀ j : Fin 12, tailSwap j 11 = j := by decide +kernel
private theorem tailSwap_table : ∀ j : Fin 12, 6 ≤ j.val →
    tailSwap j 0=0 ∧ tailSwap j 1=1 ∧ tailSwap j 2=2 ∧
    tailSwap j 3=3 ∧ tailSwap j 4=4 ∧ tailSwap j 5=5 ∧
    (∀ i : Fin 12, 6 ≤ i.val → 6 ≤ (tailSwap j i).val) := by decide +kernel

private theorem tailSwap_blocks (j : Fin 12) (hj : 6 ≤ j.val) : FixesRow0Blocks (tailSwap j) := by
  obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := tailSwap_table j hj
  refine ⟨?_,?_,h0,Or.inl h1,Or.inr h2,Or.inl h3,Or.inr (Or.inl h4),Or.inr (Or.inr h5),h6⟩
  · intro a b hab
    have h := congrArg (tailSwap j) hab
    simpa only [tailSwap_twice] using h
  · intro y
    exact ⟨tailSwap j y,tailSwap_twice j y⟩

theorem exterior_tail_entry_diag_bound (C : Fin 12 → Fin 12 → Nat)
    (hC : ExteriorEquations C) (j : Fin 12) (hj : 6 ≤ j.val) : C 0 0+C 0 j ≤ 4 := by
  have hσ := tailSwap_blocks j hj
  have hD := conjPreserves C (tailSwap j) hσ hC
  have bound := exterior_last_entry_diag_bound (conjMatrix C (tailSwap j)) hD
  simpa only [conjMatrix,hσ.fix0,tailSwap_last] using bound

#print axioms exterior_last_pair_norm_bound
#print axioms exterior_last_entry_diag_bound
#print axioms exterior_tail_entry_diag_bound
end Matrix99
