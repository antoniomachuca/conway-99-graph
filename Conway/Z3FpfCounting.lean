import Conway.Z3FpfOrbitMatrix
import Conway.OrbitQuotient

namespace Matrix99

open ConwayOrbit

namespace Z3FpfOrbitMatrix

section sum_helpers

theorem list_map_sum_le {α : Type} {l : List α} {f g : α → Nat}
    (h : ∀ x ∈ l, f x ≤ g x) : (l.map f).sum ≤ (l.map g).sum := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    rw [List.map_cons, List.map_cons, List.sum_cons, List.sum_cons]
    have hx := h x (List.mem_cons_self)
    have hxs := ih (fun y hy => h y (List.mem_cons_of_mem x hy))
    omega

theorem list_map_sum_lt {α : Type} {l : List α} {f g : α → Nat}
    (hle : ∀ x ∈ l, f x ≤ g x) (x : α) (hx : x ∈ l) (hlt : f x < g x) :
    (l.map f).sum < (l.map g).sum := by
  induction l with
  | nil => simp at hx
  | cons y ys ih =>
    rw [List.map_cons, List.map_cons, List.sum_cons, List.sum_cons]
    rcases List.mem_cons.mp hx with rfl | hmem
    · have hrest := list_map_sum_le (l := ys) (fun z hz => hle z (List.mem_cons_of_mem x hz))
      omega
    · have hle' := hle y (List.mem_cons_self)
      have hrec := ih (fun z hz => hle z (List.mem_cons_of_mem y hz)) hmem
      omega

theorem list_map_sum_eq_zero {α : Type} {l : List α} {f : α → Nat}
    (h : (l.map f).sum = 0) : ∀ x ∈ l, f x = 0 := by
  induction l with
  | nil => intro x hx; simp at hx
  | cons x xs ih =>
    rw [List.map_cons, List.sum_cons] at h
    intro y hy
    rcases List.mem_cons.mp hy with rfl | hmem
    · omega
    · exact ih (by omega) y hmem

theorem list_elem_le_map_sum {α : Type} {l : List α} {f : α → Nat} (x : α) (hx : x ∈ l) :
    f x ≤ (l.map f).sum := by
  induction l with
  | nil => simp at hx
  | cons y ys ih =>
    rw [List.map_cons, List.sum_cons]
    rcases List.mem_cons.mp hx with rfl | hmem
    · omega
    · have := ih hmem; omega

theorem sumFin_congr {n : Nat} {f g : Fin n → Nat} (h : ∀ j, f j = g j) :
    sumFin f = sumFin g := congrArg sumFin (funext h)

theorem sumFin_add {n : Nat} (f g : Fin n → Nat) :
    sumFin (fun j => f j + g j) = sumFin f + sumFin g := by
  unfold sumFin
  exact sum_map_add _ f g

theorem sumFin_le {n : Nat} {f g : Fin n → Nat} (h : ∀ j, f j ≤ g j) :
    sumFin f ≤ sumFin g := by
  unfold sumFin
  apply list_map_sum_le
  intro x _hx
  exact h x

theorem sumFin_lt_of_lt {n : Nat} {f g : Fin n → Nat} (hle : ∀ j, f j ≤ g j)
    (i : Fin n) (hlt : f i < g i) : sumFin f < sumFin g := by
  unfold sumFin
  exact list_map_sum_lt (fun x _hx => hle x) i (List.mem_finRange i) hlt

theorem sumFin_eq_zero_of {n : Nat} {f : Fin n → Nat} (h : sumFin f = 0) (j : Fin n) :
    f j = 0 := by
  exact list_map_sum_eq_zero (l := List.finRange n) (f := f) h j (List.mem_finRange j)

theorem sumFin_elem_le {n : Nat} (f : Fin n → Nat) (i : Fin n) : f i ≤ sumFin f := by
  unfold sumFin
  exact list_elem_le_map_sum i (List.mem_finRange i)

theorem sq_ge_self (b : Nat) : b ≤ b * b := by
  rcases Nat.eq_zero_or_pos b with h0 | hpos
  · omega
  · calc b = b * 1 := (Nat.mul_one b).symm
      _ ≤ b * b := Nat.mul_le_mul_left b hpos

theorem sumFin_indicator_const {n : Nat} (p : Fin n → Prop) [DecidablePred p] (c : Nat) :
    sumFin (fun j => if p j then c else 0) = sumFin (fun j => if p j then 1 else 0) * c := by
  rw [← sumFin_mul_right]
  apply sumFin_congr
  intro j
  by_cases h : p j <;> simp [h]

theorem sumFin_split {n : Nat} (f : Fin n → Nat) (p : Fin n → Prop) [DecidablePred p] :
    sumFin f = sumFin (fun j => if p j then f j else 0) +
      sumFin (fun j => if ¬ p j then f j else 0) := by
  rw [← sumFin_add]
  apply sumFin_congr
  intro j
  by_cases h : p j <;> simp [h]

theorem sumFin_ite_indep {n : Nat} (c : Prop) [Decidable c] (f : Fin n → Nat) :
    sumFin (fun j => if c then f j else 0) = if c then sumFin f else 0 := by
  by_cases h : c
  · rw [if_pos h]
    apply sumFin_congr
    intro j
    rw [if_pos h]
  · rw [if_neg h]
    have hz : (fun j : Fin n => if c then f j else 0) = fun _ => 0 := by
      funext j
      rw [if_neg h]
    rw [hz]
    unfold sumFin
    exact sum_map_zero _

theorem sumFin_eq_single {n : Nat} (i : Fin n) (f : Fin n → Nat) :
    sumFin (fun j => if j = i then f j else 0) = f i := by
  unfold sumFin
  have hs := sum_indicator_list (List.nodup_finRange n) i (f i)
  have hmap : ((List.finRange n).map (fun j => if j = i then f j else 0)).sum =
      ((List.finRange n).map (fun j => if j = i then f i else 0)).sum := by
    apply congrArg List.sum
    apply List.map_congr_left
    intro j _hj
    by_cases h : j = i
    · subst h; rfl
    · simp [h]
  rw [hmap]
  simpa [List.mem_finRange] using hs

theorem sumFin_sq_le {n : Nat} (f : Fin n → Nat) :
    sumFin (fun j => f j * f j) ≤ sumFin f * sumFin f := by
  have hle : ∀ j, f j * f j ≤ f j * sumFin f := fun j =>
    Nat.mul_le_mul_left _ (sumFin_elem_le f j)
  calc
    sumFin (fun j => f j * f j) ≤ sumFin (fun j => f j * sumFin f) := sumFin_le hle
    _ = sumFin f * sumFin f := sumFin_mul_right f (sumFin f)

theorem sumFin_mul_sum {n : Nat} (f g : Fin n → Nat) :
    sumFin (fun j => sumFin (fun j' => f j * g j')) = sumFin f * sumFin g := by
  have hinner : ∀ j, sumFin (fun j' => f j * g j') = f j * sumFin g :=
    fun j => sumFin_mul_left (f j) g
  calc
    sumFin (fun j => sumFin (fun j' => f j * g j')) = sumFin (fun j => f j * sumFin g) :=
      sumFin_congr hinner
    _ = sumFin f * sumFin g := sumFin_mul_right f (sumFin g)

end sum_helpers

variable (M : Z3FpfOrbitMatrix)

theorem row_sum_sf (i : Fin 33) : sumFin (fun j => M.B i j) = 14 := by
  have h := M.row_sum i
  rw [sumFin_eq_foldl]
  exact h

theorem row_sq_sum (i : Fin 33) :
    sumFin (fun j => M.B i j * M.B i j) + M.B i i = 18 := by
  have h := M.srg_equation i i
  have hmul : mul33 M.B M.B i i = sumFin (fun j => M.B i j * M.B i j) := by
    unfold mul33
    rw [← sumFin_eq_foldl]
    apply sumFin_congr
    intro j
    rw [M.degree_symmetry j i]
  rw [hmul] at h
  simpa [delta33] using h

theorem off_row_sum (i : Fin 33) :
    sumFin (fun j => if j ≠ i then M.B i j else 0) + M.B i i = 14 := by
  have hsplit := sumFin_split (fun j => M.B i j) (fun j => j = i)
  rw [sumFin_eq_single] at hsplit
  have h := row_sum_sf M i
  rw [hsplit] at h
  have heq : sumFin (fun j => if j ≠ i then M.B i j else 0) =
      sumFin (fun j => if ¬ j = i then M.B i j else 0) := by
    apply sumFin_congr
    intro j
    rfl
  omega

theorem off_sq_sum (i : Fin 33) :
    sumFin (fun j => if j ≠ i then M.B i j * M.B i j else 0) + M.B i i * M.B i i + M.B i i = 18 := by
  have hsplit := sumFin_split (fun j => M.B i j * M.B i j) (fun j => j = i)
  rw [sumFin_eq_single] at hsplit
  have h := row_sq_sum M i
  rw [hsplit] at h
  have heq : sumFin (fun j => if j ≠ i then M.B i j * M.B i j else 0) =
      sumFin (fun j => if ¬ j = i then M.B i j * M.B i j else 0) := by
    apply sumFin_congr
    intro j
    rfl
  omega

theorem tri_offdiag_le_one (i j : Fin 33) (hi : M.B i i = 2) (hij : j ≠ i) : M.B i j ≤ 1 := by
  have hlin := off_row_sum M i
  have hsq := off_sq_sum M i
  rw [hi] at hlin hsq
  rcases Nat.lt_or_ge (M.B i j) 2 with hlt | hge
  · omega
  · exfalso
    have hpoint : ∀ j', (if j' ≠ i then M.B i j' else 0) ≤
        (if j' ≠ i then M.B i j' * M.B i j' else 0) := by
      intro j'
      by_cases hji : j' ≠ i
      · rw [if_pos hji, if_pos hji]
        exact sq_ge_self _
      · rw [if_neg hji, if_neg hji]
        exact Nat.le.refl
    have hstrict : (if j ≠ i then M.B i j else 0) <
        (if j ≠ i then M.B i j * M.B i j else 0) := by
      rw [if_pos hij, if_pos hij]
      have h2 : 2 * M.B i j ≤ M.B i j * M.B i j := Nat.mul_le_mul_right _ hge
      omega
    have hlt' := sumFin_lt_of_lt hpoint j hstrict
    omega

theorem tri_ones (i : Fin 33) (hi : M.B i i = 2) :
    sumFin (fun j => if j ≠ i ∧ M.B i j = 1 then 1 else 0) = 12 := by
  have hpt : ∀ j, (if j ≠ i ∧ M.B i j = 1 then 1 else 0) =
      (if j ≠ i then M.B i j else 0) := by
    intro j
    by_cases hj : j ≠ i
    · rw [if_pos hj]
      by_cases hb : M.B i j = 1
      · rw [if_pos (And.intro hj hb)]
        exact hb.symm
      · rw [if_neg (fun h => hb h.2)]
        have hle := tri_offdiag_le_one M i j hi hj
        omega
    · rw [if_neg hj, if_neg (fun h => hj h.1)]
  rw [sumFin_congr hpt]
  have hlin := off_row_sum M i
  omega

theorem non_le_two (i j : Fin 33) (hi : M.B i i = 0) : M.B i j ≤ 2 := by
  have hlin := off_row_sum M i
  have hsq := off_sq_sum M i
  rw [hi] at hlin hsq
  -- h j' := (if j' ≠ i then b j' else 0) with b j' = B i j' * B i j' - B i j'
  -- sum of h over all j' is 4
  have hsqh : sumFin (fun j' => if j' ≠ i then M.B i j' * M.B i j' else 0) =
      sumFin (fun j' => if j' ≠ i then M.B i j' else 0) +
        sumFin (fun j' => if j' ≠ i then M.B i j' * M.B i j' - M.B i j' else 0) := by
    rw [← sumFin_add]
    apply sumFin_congr
    intro j'
    by_cases hji : j' ≠ i
    · rw [if_pos hji, if_pos hji, if_pos hji]
      have hb : M.B i j' ≤ M.B i j' * M.B i j' := sq_ge_self _
      omega
    · rw [if_neg hji, if_neg hji, if_neg hji]
  have hsum : sumFin (fun j' => if j' ≠ i then M.B i j' * M.B i j' - M.B i j' else 0) = 4 := by
    omega
  rcases Nat.lt_or_ge (M.B i j) 3 with hlt | hge
  · omega
  · exfalso
    by_cases hji : j ≠ i
    · have hmem := sumFin_elem_le
        (fun j' => if j' ≠ i then M.B i j' * M.B i j' - M.B i j' else 0) j
      rw [if_pos hji] at hmem
      have hb3 : M.B i j * 3 ≤ M.B i j * M.B i j := Nat.mul_le_mul_left _ hge
      omega
    · by_cases hjeq : j = i
      · subst hjeq
        omega
      · exact absurd hjeq hji

theorem non_twos (i : Fin 33) (hi : M.B i i = 0) :
    sumFin (fun j => if M.B i j = 2 then 1 else 0) = 2 := by
  have hlin := off_row_sum M i
  have hsq := off_sq_sum M i
  -- Σ_j g j = 4 where g j = if B i j = 2 then 2 else 0 = b² - b (since b ≤ 2)
  have hpt : ∀ j, (if M.B i j = 2 then 2 else 0) = M.B i j * M.B i j - M.B i j := by
    intro j
    by_cases hb : M.B i j = 2
    · rw [if_pos hb, hb]
    · rw [if_neg hb]
      have hle := non_le_two M i j hi
      rcases Nat.lt_or_ge (M.B i j) 1 with hlt1 | hge1
      · have h0 : M.B i j = 0 := by omega
        rw [h0]
      · have h1 : M.B i j = 1 := by omega
        rw [h1]
  have hg : sumFin (fun j => if M.B i j = 2 then 2 else 0) = 4 := by
    have hsplit2 : sumFin (fun j => M.B i j * M.B i j) =
        sumFin (fun j => M.B i j) + sumFin (fun j => M.B i j * M.B i j - M.B i j) := by
      rw [← sumFin_add]
      apply sumFin_congr
      intro j
      have hle := sq_ge_self (M.B i j)
      omega
    have hb := row_sum_sf M i
    have hb2 := row_sq_sum M i
    have hsub : sumFin (fun j => M.B i j * M.B i j - M.B i j) =
        sumFin (fun j => if M.B i j = 2 then 2 else 0) :=
      sumFin_congr (fun j => (hpt j).symm)
    omega
  have hcnt : sumFin (fun j => if M.B i j = 2 then 2 else 0) =
      sumFin (fun j => if M.B i j = 2 then 1 else 0) * 2 :=
    sumFin_indicator_const (fun j => M.B i j = 2) 2
  omega

theorem non_ones (i : Fin 33) (hi : M.B i i = 0) :
    sumFin (fun j => if M.B i j = 1 then 1 else 0) = 10 := by
  have hlin := row_sum_sf M i
  have h2 := non_twos M i hi
  have hpt : ∀ j, M.B i j = (if M.B i j = 1 then 1 else 0) + (if M.B i j = 2 then 2 else 0) := by
    intro j
    have hle := non_le_two M i j hi
    by_cases h1 : M.B i j = 1 <;> by_cases h2' : M.B i j = 2 <;> simp [h1, h2'] <;> omega
  have hsum := sumFin_add (fun j => if M.B i j = 1 then 1 else 0)
    (fun j => if M.B i j = 2 then 2 else 0)
  rw [← sumFin_congr hpt, hlin] at hsum
  have hcnt : sumFin (fun j => if M.B i j = 2 then 2 else 0) =
      sumFin (fun j => if M.B i j = 2 then 1 else 0) * 2 :=
    sumFin_indicator_const (fun j => M.B i j = 2) 2
  omega

theorem two_entry_non (i j : Fin 33) (hij : i ≠ j) (h : M.B i j = 2) :
    M.B i i = 0 ∧ M.B j j = 0 := by
  constructor
  · rcases M.diag_parity i with h0 | h2
    · exact h0
    · exfalso
      have hle := tri_offdiag_le_one M i j h2 (Ne.symm hij)
      omega
  · rcases M.diag_parity j with h0 | h2
    · exact h0
    · exfalso
      have hsym : M.B j i = 2 := by
        have h' := M.degree_symmetry i j
        omega
      have hle := tri_offdiag_le_one M j i h2 hij
      omega

-- WP2: counting identity (T = {k | B k k = 2}, I = {j | B j j = 0})

def nI : Nat := sumFin (fun j => if M.B j j = 0 then 1 else 0)

def xT (k : Fin 33) : Nat := sumFin (fun j => if M.B j j = 0 then M.B k j else 0)

def aI (j : Fin 33) : Nat := sumFin (fun k => if M.B k k = 0 ∧ M.B j k = 1 then 1 else 0)

def bigA : Nat := sumFin (fun j => if M.B j j = 0 then M.aI j else 0)

theorem zero_fun_sumFin {n : Nat} {f : Fin n → Nat} (h : ∀ j, f j = 0) :
    sumFin f = 0 := by
  have hz : f = fun _ => 0 := funext h
  rw [hz]
  unfold sumFin
  exact sum_map_zero _

theorem ite_add {c : Prop} [Decidable c] (a b : Nat) :
    (if c then a + b else 0) = (if c then a else 0) + (if c then b else 0) := by
  by_cases h : c <;> simp [h]

theorem sq4 (a : Nat) : (4 + a) * (4 + a) = 16 + (8 * a + a * a) := by
  rw [Nat.mul_add, Nat.add_mul, Nat.add_mul]
  omega

theorem sq_sub_one (a : Nat) :
    a * a + 1 = 2 * a + ((a - 1) * (a - 1) + (if a = 0 then 1 else 0)) := by
  rcases Nat.eq_zero_or_pos a with h0 | hpos
  · rw [h0]
    decide
  · have hb : a - 1 + 1 = a := Nat.sub_add_cancel hpos
    rw [if_neg (by omega : a ≠ 0)]
    have hstep : a * a = (a - 1 + 1) * (a - 1 + 1) := by rw [hb]
    rw [hstep]
    rw [Nat.mul_add, Nat.add_mul, Nat.add_mul, Nat.mul_one, Nat.one_mul]
    omega

theorem mul33_sf (j j' : Fin 33) :
    mul33 M.B M.B j j' = sumFin (fun k => M.B j k * M.B k j') := by
  unfold mul33
  rw [← sumFin_eq_foldl]

theorem srg_sf (j j' : Fin 33) :
    sumFin (fun k => M.B j k * M.B k j') + M.B j j' = 12 * delta33 j j' + 6 := by
  have h := M.srg_equation j j'
  rw [mul33_sf] at h
  exact h

-- For a non-triangle row k, the I-part of the row is 4 + aI k:
-- the two entries equal to 2 both lie in I (two_entry_non).
theorem xT_eq_of_I (k : Fin 33) (hk : M.B k k = 0) :
    M.xT k = 4 + M.aI k := by
  have hpt : ∀ j, (if M.B j j = 0 then M.B k j else 0) =
      (if M.B j j = 0 ∧ M.B k j = 2 then 2 else 0) +
        (if M.B j j = 0 ∧ M.B k j = 1 then 1 else 0) := by
    intro j
    have hle := non_le_two M k j hk
    by_cases h0 : M.B j j = 0
    · rw [if_pos h0]
      by_cases h2 : M.B k j = 2
      · rw [if_pos ⟨h0, h2⟩,
          if_neg (fun hc => by omega : ¬ (M.B j j = 0 ∧ M.B k j = 1))]
        omega
      · rw [if_neg (fun hc => h2 hc.2)]
        by_cases h1 : M.B k j = 1
        · rw [if_pos ⟨h0, h1⟩]
          omega
        · rw [if_neg (fun hc => h1 hc.2)]
          omega
    · rw [if_neg h0, if_neg (fun hc => h0 hc.1), if_neg (fun hc => h0 hc.1)]
  have hcnt : sumFin (fun j => if M.B j j = 0 ∧ M.B k j = 2 then (1 : Nat) else 0) = 2 := by
    have hp : ∀ j, (if M.B j j = 0 ∧ M.B k j = 2 then (1 : Nat) else 0) =
        (if M.B k j = 2 then 1 else 0) := by
      intro j
      by_cases h2 : M.B k j = 2
      · have hkj : k ≠ j := fun e => by subst e; omega
        have hI := (two_entry_non M k j hkj h2).2
        rw [if_pos ⟨hI, h2⟩, if_pos h2]
      · rw [if_neg h2, if_neg (fun hc => h2 hc.2)]
    rw [sumFin_congr hp]
    exact non_twos M k hk
  have h2sum : sumFin (fun j => if M.B j j = 0 ∧ M.B k j = 2 then (2 : Nat) else 0) = 4 := by
    rw [sumFin_indicator_const, hcnt]
  have hopen : M.xT k = sumFin (fun j => if M.B j j = 0 then M.B k j else 0) := rfl
  calc
    M.xT k = sumFin (fun j => if M.B j j = 0 then M.B k j else 0) := hopen
    _ = sumFin (fun j => (if M.B j j = 0 ∧ M.B k j = 2 then 2 else 0) +
          (if M.B j j = 0 ∧ M.B k j = 1 then 1 else 0)) := sumFin_congr hpt
    _ = sumFin (fun j => if M.B j j = 0 ∧ M.B k j = 2 then 2 else 0) +
          sumFin (fun j => if M.B j j = 0 ∧ M.B k j = 1 then 1 else 0) :=
        sumFin_add _ _
    _ = 4 + M.aI k := by
        rw [h2sum]
        rfl

-- For a non-triangle row j, the T-part of the row is 10 - aI j (in additive form).
theorem tpart (j : Fin 33) (hj : M.B j j = 0) :
    sumFin (fun k => if M.B k k = 2 then M.B j k else 0) + M.aI j = 10 := by
  have hsplit : sumFin (fun k => M.B j k) =
      sumFin (fun k => if M.B k k = 0 then M.B j k else 0) +
        sumFin (fun k => if M.B k k = 2 then M.B j k else 0) := by
    rw [← sumFin_add]
    apply sumFin_congr
    intro k
    rcases M.diag_parity k with h0 | h2
    · rw [if_pos h0, if_neg (by omega : M.B k k ≠ 2)]
      omega
    · rw [if_neg (by omega : M.B k k ≠ 0), if_pos h2]
      omega
  have hr := row_sum_sf M j
  have hx : sumFin (fun k => if M.B k k = 0 then M.B j k else 0) = 4 + M.aI j :=
    xT_eq_of_I M j hj
  omega

theorem linear_count :
    sumFin (fun k => if M.B k k = 2 then M.xT k else 0) + M.bigA = 10 * M.nI := by
  have key : sumFin (fun j => (if M.B j j = 0 then
        sumFin (fun k => if M.B k k = 2 then M.B j k else 0) else 0) +
      (if M.B j j = 0 then M.aI j else 0)) =
      sumFin (fun j => if M.B j j = 0 then 10 else 0) := by
    apply sumFin_congr
    intro j
    by_cases hj : M.B j j = 0
    · rw [if_pos hj, if_pos hj, if_pos hj]
      exact tpart M j hj
    · rw [if_neg hj, if_neg hj, if_neg hj]
  rw [sumFin_add] at key
  have hrhs : sumFin (fun j => if M.B j j = 0 then (10 : Nat) else 0) = 10 * M.nI := by
    rw [sumFin_indicator_const]
    rw [Nat.mul_comm]
    try rfl
  have hswap : sumFin (fun j => if M.B j j = 0 then
        sumFin (fun k => if M.B k k = 2 then M.B j k else 0) else 0) =
      sumFin (fun k => if M.B k k = 2 then M.xT k else 0) := by
    have h1 : ∀ j, (if M.B j j = 0 then
          sumFin (fun k => if M.B k k = 2 then M.B j k else 0) else 0) =
        sumFin (fun k => if M.B j j = 0 ∧ M.B k k = 2 then M.B j k else 0) := by
      intro j
      by_cases hj : M.B j j = 0
      · rw [if_pos hj]
        apply sumFin_congr
        intro k
        by_cases hk : M.B k k = 2
        · rw [if_pos hk, if_pos ⟨hj, hk⟩]
        · rw [if_neg hk, if_neg (fun hc => hk hc.2)]
      · rw [if_neg hj]
        symm
        apply zero_fun_sumFin
        intro k
        rw [if_neg (fun hc => hj hc.1)]
    rw [sumFin_congr h1]
    rw [sumFin_swap (fun j k => if M.B j j = 0 ∧ M.B k k = 2 then M.B j k else 0)]
    apply sumFin_congr
    intro k
    by_cases hk : M.B k k = 2
    · rw [if_pos hk]
      have h2 : ∀ j, (if M.B j j = 0 ∧ M.B k k = 2 then M.B j k else 0) =
          (if M.B j j = 0 then M.B k j else 0) := by
        intro j
        by_cases hj : M.B j j = 0
        · rw [if_pos ⟨hj, hk⟩, if_pos hj]
          exact M.degree_symmetry j k
        · rw [if_neg (fun hc => hj hc.1), if_neg hj]
      exact sumFin_congr h2
    · rw [if_neg hk]
      apply zero_fun_sumFin
      intro j
      rw [if_neg (fun hc => hk hc.2)]
  have hbA : M.bigA = sumFin (fun j => if M.B j j = 0 then M.aI j else 0) := rfl
  rw [← hswap, hbA]
  omega

-- Double sums of the SRG equation over I x I.

theorem double_sum_delta :
    sumFin (fun j => sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then delta33 j j' else 0)) = M.nI := by
  have hinner : ∀ j, sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then delta33 j j' else 0) =
      (if M.B j j = 0 then 1 else 0) := by
    intro j
    by_cases hj : M.B j j = 0
    · rw [if_pos hj]
      have hpt : ∀ j', (if M.B j j = 0 ∧ M.B j' j' = 0 then delta33 j j' else 0) =
          (if j' = j then (1 : Nat) else 0) := by
        intro j'
        by_cases hje : j' = j
        · subst hje
          rw [if_pos ⟨hj, hj⟩]
          unfold delta33
          rw [if_pos rfl]
        · have hδ : delta33 j j' = 0 := by
            unfold delta33
            exact if_neg (fun h => hje h.symm)
          by_cases hc : M.B j j = 0 ∧ M.B j' j' = 0
          · rw [if_pos hc, hδ, if_neg hje]
          · rw [if_neg hc, if_neg hje]
      rw [sumFin_congr hpt, sumFin_eq_single]
    · rw [if_neg hj]
      apply zero_fun_sumFin
      intro j'
      rw [if_neg (fun hc => hj hc.1)]
  rw [sumFin_congr hinner]
  rfl

theorem double_sum_six :
    sumFin (fun j => sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then (6 : Nat) else 0)) = 6 * M.nI * M.nI := by
  have hinner : ∀ j, sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then (6 : Nat) else 0) =
      (if M.B j j = 0 then 6 * M.nI else 0) := by
    intro j
    by_cases hj : M.B j j = 0
    · rw [if_pos hj]
      have hpt : ∀ j', (if M.B j j = 0 ∧ M.B j' j' = 0 then (6 : Nat) else 0) =
          (if M.B j' j' = 0 then 6 else 0) := by
        intro j'
        by_cases hj' : M.B j' j' = 0
        · rw [if_pos ⟨hj, hj'⟩, if_pos hj']
        · rw [if_neg (fun hc => hj' hc.2), if_neg hj']
      rw [sumFin_congr hpt, sumFin_indicator_const]
      exact Nat.mul_comm _ _
    · rw [if_neg hj]
      apply zero_fun_sumFin
      intro j'
      rw [if_neg (fun hc => hj hc.1)]
  rw [sumFin_congr hinner, sumFin_indicator_const]
  exact Nat.mul_comm _ _

theorem double_sum_B :
    sumFin (fun j => sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j j' else 0)) =
      4 * M.nI + M.bigA := by
  have hinner : ∀ j, sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j j' else 0) =
      (if M.B j j = 0 then M.xT j else 0) := by
    intro j
    by_cases hj : M.B j j = 0
    · rw [if_pos hj]
      have hpt : ∀ j', (if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j j' else 0) =
          (if M.B j' j' = 0 then M.B j j' else 0) := by
        intro j'
        by_cases hj' : M.B j' j' = 0
        · rw [if_pos ⟨hj, hj'⟩, if_pos hj']
        · rw [if_neg (fun hc => hj' hc.2), if_neg hj']
      exact sumFin_congr hpt
    · rw [if_neg hj]
      apply zero_fun_sumFin
      intro j'
      rw [if_neg (fun hc => hj hc.1)]
  rw [sumFin_congr hinner]
  have h2 : ∀ j, (if M.B j j = 0 then M.xT j else 0) =
      (if M.B j j = 0 then (4 : Nat) else 0) +
        (if M.B j j = 0 then M.aI j else 0) := by
    intro j
    by_cases hj : M.B j j = 0
    · rw [if_pos hj, if_pos hj, if_pos hj]
      exact xT_eq_of_I M j hj
    · rw [if_neg hj, if_neg hj, if_neg hj]
  rw [sumFin_congr h2, sumFin_add, sumFin_indicator_const]
  rw [Nat.mul_comm]
  rfl

theorem double_sum_mul :
    sumFin (fun j => sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then sumFin (fun k => M.B j k * M.B k j') else 0)) =
      sumFin (fun k => M.xT k * M.xT k) := by
  calc
    _ = sumFin (fun j => sumFin (fun j' => sumFin (fun k =>
          if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j k * M.B k j' else 0))) := by
      apply sumFin_congr
      intro j
      apply sumFin_congr
      intro j'
      by_cases hc : M.B j j = 0 ∧ M.B j' j' = 0
      · rw [if_pos hc]
        apply sumFin_congr
        intro k
        rw [if_pos hc]
      · rw [if_neg hc]
        symm
        apply zero_fun_sumFin
        intro k
        rw [if_neg hc]
    _ = sumFin (fun j => sumFin (fun k => sumFin (fun j' =>
          if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j k * M.B k j' else 0))) := by
      apply sumFin_congr
      intro j
      exact sumFin_swap _
    _ = sumFin (fun k => sumFin (fun j => sumFin (fun j' =>
          if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j k * M.B k j' else 0))) := by
      exact sumFin_swap _
    _ = sumFin (fun k => M.xT k * M.xT k) := by
      apply sumFin_congr
      intro k
      have hpt : ∀ j j', (if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j k * M.B k j' else 0) =
          (if M.B j j = 0 then M.B k j else 0) *
            (if M.B j' j' = 0 then M.B k j' else 0) := by
        intro j j'
        by_cases hj : M.B j j = 0
        · by_cases hj' : M.B j' j' = 0
          · rw [if_pos ⟨hj, hj'⟩, if_pos hj, if_pos hj', M.degree_symmetry j k]
          · rw [if_neg (fun hc => hj' hc.2), if_neg hj']
            rfl
        · rw [if_neg (fun hc => hj hc.1), if_neg hj, Nat.zero_mul]
      rw [sumFin_congr (fun j => sumFin_congr (hpt j)), sumFin_mul_sum]
      rfl

theorem double_sum_srg :
    sumFin (fun j => sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then
        sumFin (fun k => M.B j k * M.B k j') + M.B j j' else 0)) =
    12 * M.nI + 6 * M.nI * M.nI := by
  have hpt : ∀ j j', (if M.B j j = 0 ∧ M.B j' j' = 0 then
        sumFin (fun k => M.B j k * M.B k j') + M.B j j' else 0) =
      (if M.B j j = 0 ∧ M.B j' j' = 0 then 12 * delta33 j j' else 0) +
        (if M.B j j = 0 ∧ M.B j' j' = 0 then (6 : Nat) else 0) := by
    intro j j'
    by_cases hc : M.B j j = 0 ∧ M.B j' j' = 0
    · rw [if_pos hc, if_pos hc, if_pos hc]
      exact srg_sf M j j'
    · rw [if_neg hc, if_neg hc, if_neg hc]
  rw [sumFin_congr (fun j => sumFin_congr (hpt j))]
  rw [sumFin_congr (fun j => sumFin_add _ _), sumFin_add]
  have hdel12 : sumFin (fun j => sumFin (fun j' =>
      if M.B j j = 0 ∧ M.B j' j' = 0 then 12 * delta33 j j' else 0)) = 12 * M.nI := by
    have hpt2 : ∀ j j', (if M.B j j = 0 ∧ M.B j' j' = 0 then 12 * delta33 j j' else 0) =
        12 * (if M.B j j = 0 ∧ M.B j' j' = 0 then delta33 j j' else 0) := by
      intro j j'
      by_cases hc : M.B j j = 0 ∧ M.B j' j' = 0 <;> simp [hc]
    rw [sumFin_congr (fun j => sumFin_congr (hpt2 j))]
    rw [sumFin_congr (fun j => sumFin_mul_left 12 _)]
    rw [sumFin_mul_left]
    rw [double_sum_delta M]
  rw [hdel12, double_sum_six M]

theorem counting_identity :
    sumFin (fun k => if M.B k k = 2 then M.xT k * M.xT k else 0)
      + sumFin (fun j => if M.B j j = 0 then M.aI j * M.aI j else 0)
      + 9 * M.bigA + 8 * M.nI = 6 * M.nI * M.nI := by
  have htot := double_sum_srg M
  have hsplit : sumFin (fun j => sumFin (fun j' =>
        if M.B j j = 0 ∧ M.B j' j' = 0 then
          sumFin (fun k => M.B j k * M.B k j') + M.B j j' else 0)) =
      sumFin (fun j => sumFin (fun j' =>
        if M.B j j = 0 ∧ M.B j' j' = 0 then sumFin (fun k => M.B j k * M.B k j') else 0)) +
        sumFin (fun j => sumFin (fun j' =>
        if M.B j j = 0 ∧ M.B j' j' = 0 then M.B j j' else 0)) := by
    rw [← sumFin_add]
    apply sumFin_congr
    intro j
    rw [← sumFin_add]
    apply sumFin_congr
    intro j'
    exact ite_add _ _
  rw [hsplit, double_sum_mul M, double_sum_B M] at htot
  have hxsplit : sumFin (fun k => M.xT k * M.xT k) =
      sumFin (fun k => if M.B k k = 2 then M.xT k * M.xT k else 0) +
        sumFin (fun k => if M.B k k = 0 then M.xT k * M.xT k else 0) := by
    rw [← sumFin_add]
    apply sumFin_congr
    intro k
    rcases M.diag_parity k with h0 | h2
    · rw [if_neg (by omega : M.B k k ≠ 2), if_pos h0]
      omega
    · rw [if_pos h2, if_neg (by omega : M.B k k ≠ 0)]
      omega
  have hIexp : sumFin (fun k => if M.B k k = 0 then M.xT k * M.xT k else 0) =
      16 * M.nI + 8 * M.bigA +
        sumFin (fun k => if M.B k k = 0 then M.aI k * M.aI k else 0) := by
    have hpt : ∀ k, (if M.B k k = 0 then M.xT k * M.xT k else 0) =
        (if M.B k k = 0 then (16 : Nat) else 0) +
        ((if M.B k k = 0 then 8 * M.aI k else 0) +
          (if M.B k k = 0 then M.aI k * M.aI k else 0)) := by
      intro k
      by_cases hk : M.B k k = 0
      · rw [if_pos hk, if_pos hk, if_pos hk, if_pos hk]
        rw [xT_eq_of_I M k hk]
        exact sq4 _
      · rw [if_neg hk, if_neg hk, if_neg hk, if_neg hk]
    rw [sumFin_congr hpt, sumFin_add, sumFin_add]
    have h16 : sumFin (fun k => if M.B k k = 0 then (16 : Nat) else 0) = 16 * M.nI := by
      rw [sumFin_indicator_const]
      exact Nat.mul_comm _ _
    have h8 : sumFin (fun k => if M.B k k = 0 then 8 * M.aI k else 0) = 8 * M.bigA := by
      have hpt2 : ∀ k, (if M.B k k = 0 then 8 * M.aI k else 0) =
          8 * (if M.B k k = 0 then M.aI k else 0) := by
        intro k
        by_cases hkk : M.B k k = 0 <;> simp [hkk]
      rw [sumFin_congr hpt2, sumFin_mul_left]
      rfl
    rw [h16, h8, ← Nat.add_assoc]
  omega

theorem t27_forces (hn : M.nI = 6)
    (hx : ∀ k, M.B k k = 2 → M.xT k = 0 ∨ M.xT k = 2) :
    (∀ k, M.B k k = 2 → M.xT k = 2) ∧ (∀ j, M.B j j = 0 → M.aI j = 1) := by
  have hlin := linear_count M
  have hid := counting_identity M
  rw [hn] at hlin hid
  have hnI' : sumFin (fun j => if M.B j j = 0 then (1 : Nat) else 0) = 6 := hn
  have hnT : sumFin (fun k => if M.B k k = 2 then (1 : Nat) else 0) = 27 := by
    have h1 : ∀ k, (if M.B k k = 0 then (1 : Nat) else 0) +
        (if M.B k k = 2 then 1 else 0) = 1 := by
      intro k
      rcases M.diag_parity k with h0 | h2
      · rw [if_pos h0, if_neg (by omega : M.B k k ≠ 2)]
      · rw [if_neg (by omega : M.B k k ≠ 0), if_pos h2]
    have hsum : sumFin (fun k => (if M.B k k = 0 then (1 : Nat) else 0) +
        (if M.B k k = 2 then 1 else 0)) = 33 := by
      rw [sumFin_congr h1]
      decide
    rw [sumFin_add] at hsum
    omega
  -- xT values are even on T, so S = sum over T of xT is even
  have hQ : sumFin (fun k => if M.B k k = 2 then M.xT k * M.xT k else 0) =
      2 * sumFin (fun k => if M.B k k = 2 then M.xT k else 0) := by
    rw [← sumFin_mul_left]
    apply sumFin_congr
    intro k
    by_cases hk : M.B k k = 2
    · rw [if_pos hk, if_pos hk]
      rcases hx k hk with h0 | h2
      · rw [h0]
      · rw [h2]
    · rw [if_neg hk, if_neg hk]
  obtain ⟨c, hc⟩ : ∃ c, sumFin (fun k => if M.B k k = 2 then M.xT k else 0) = 2 * c := by
    refine ⟨sumFin (fun k => if M.B k k = 2 ∧ M.xT k = 2 then (1 : Nat) else 0), ?_⟩
    rw [← sumFin_mul_left]
    apply sumFin_congr
    intro k
    by_cases hk : M.B k k = 2
    · rw [if_pos hk]
      rcases hx k hk with h0 | h2
      · rw [h0, if_neg (fun hca => (by decide : ¬ ((0 : Nat) = 2)) hca.2)]
      · rw [h2, if_pos ⟨hk, rfl⟩]
    · rw [if_neg hk, if_neg (fun hca => hk hca.1)]
  -- every non-triangle row satisfies aI j ≤ nI - 2
  have ha4 : ∀ j, M.B j j = 0 → M.aI j ≤ 4 := by
    intro j hj
    have hc2 : sumFin (fun k => if M.B k k = 0 ∧ M.B j k = 2 then (1 : Nat) else 0) = 2 := by
      have hp : ∀ k, (if M.B k k = 0 ∧ M.B j k = 2 then (1 : Nat) else 0) =
          (if M.B j k = 2 then 1 else 0) := by
        intro k
        by_cases h2 : M.B j k = 2
        · have hjk : j ≠ k := fun e => by subst e; omega
          have hI := (two_entry_non M j k hjk h2).2
          rw [if_pos ⟨hI, h2⟩, if_pos h2]
        · rw [if_neg h2, if_neg (fun hca => h2 hca.2)]
      rw [sumFin_congr hp]
      exact non_twos M j hj
    have hle : ∀ k, (if M.B k k = 0 ∧ M.B j k = 1 then (1 : Nat) else 0) +
        (if M.B k k = 0 ∧ M.B j k = 2 then 1 else 0) ≤
        (if M.B k k = 0 then 1 else 0) := by
      intro k
      by_cases h0 : M.B k k = 0
      · rw [if_pos h0]
        by_cases h1 : M.B j k = 1
        · rw [if_pos ⟨h0, h1⟩]
          rw [if_neg (fun hca => by omega : ¬ (M.B k k = 0 ∧ M.B j k = 2))]
          decide
        · rw [if_neg (fun hca => h1 hca.2)]
          by_cases h2 : M.B j k = 2
          · rw [if_pos ⟨h0, h2⟩]
            decide
          · rw [if_neg (fun hca => h2 hca.2)]
            decide
      · rw [if_neg h0, if_neg (fun hca => h0 hca.1), if_neg (fun hca => h0 hca.1)]
        decide
    have hsum := sumFin_le hle
    rw [sumFin_add] at hsum
    have haI : M.aI j = sumFin (fun k => if M.B k k = 0 ∧ M.B j k = 1 then 1 else 0) := rfl
    omega
  have hZ4 : sumFin (fun j => if M.B j j = 0 then M.aI j * M.aI j else 0) ≤
      4 * M.bigA := by
    have hpt : ∀ j, (if M.B j j = 0 then M.aI j * M.aI j else 0) ≤
        4 * (if M.B j j = 0 then M.aI j else 0) := by
      intro j
      by_cases hj : M.B j j = 0
      · rw [if_pos hj, if_pos hj]
        exact Nat.mul_le_mul_right _ (ha4 j hj)
      · rw [if_neg hj]
        exact Nat.zero_le _
    have hsum := sumFin_le hpt
    rw [sumFin_mul_left] at hsum
    exact hsum
  have hX : sumFin (fun j => if M.B j j = 0 then M.aI j * M.aI j else 0) + M.nI =
      2 * M.bigA +
        sumFin (fun j => if M.B j j = 0 then
          (M.aI j - 1) * (M.aI j - 1) + (if M.aI j = 0 then 1 else 0) else 0) := by
    rw [hn]
    have hn1 : (6 : Nat) = sumFin (fun j => if M.B j j = 0 then (1 : Nat) else 0) :=
      hn.symm
    rw [hn1]
    rw [← sumFin_add]
    have hA2 : 2 * M.bigA = sumFin (fun j => if M.B j j = 0 then 2 * M.aI j else 0) := by
      have hb : M.bigA = sumFin (fun j => if M.B j j = 0 then M.aI j else 0) := rfl
      rw [hb, ← sumFin_mul_left]
      apply sumFin_congr
      intro j
      by_cases hjj : M.B j j = 0 <;> simp [hjj]
    rw [hA2, ← sumFin_add]
    apply sumFin_congr
    intro j
    by_cases hj : M.B j j = 0
    · rw [if_pos hj, if_pos hj, if_pos hj, if_pos hj]
      exact sq_sub_one _
    · rw [if_neg hj, if_neg hj, if_neg hj, if_neg hj]
  have hA6 : M.bigA = 6 := by omega
  have hX0 : sumFin (fun j => if M.B j j = 0 then
      (M.aI j - 1) * (M.aI j - 1) + (if M.aI j = 0 then 1 else 0) else 0) = 0 := by
    omega
  have haI_eq1 : ∀ j, M.B j j = 0 → M.aI j = 1 := by
    intro j hj
    have hz := sumFin_eq_zero_of hX0 j
    rw [if_pos hj] at hz
    obtain ⟨h1, h2⟩ := Nat.add_eq_zero_iff.mp hz
    have hne : M.aI j ≠ 0 := by
      intro h
      rw [if_pos h] at h2
      exact absurd h2 (by decide)
    have hle : M.aI j ≤ 1 := by
      rcases Nat.mul_eq_zero.mp h1 with h | h <;> omega
    omega
  constructor
  · intro k hk
    rcases hx k hk with h0 | h2
    · exfalso
      have hle : ∀ k', (if M.B k' k' = 2 then M.xT k' else 0) ≤
          (if M.B k' k' = 2 then 2 else 0) := by
        intro k'
        by_cases hk' : M.B k' k' = 2
        · rw [if_pos hk', if_pos hk']
          rcases hx k' hk' with h | h <;> omega
        · rw [if_neg hk', if_neg hk']
          exact Nat.le.refl
      have hlt : (if M.B k k = 2 then M.xT k else 0) <
          (if M.B k k = 2 then 2 else 0) := by
        rw [if_pos hk, if_pos hk, h0]
        decide
      have hstrict := sumFin_lt_of_lt hle k hlt
      have h54 : sumFin (fun k' => if M.B k' k' = 2 then (2 : Nat) else 0) = 54 := by
        rw [sumFin_indicator_const]
        omega
      omega
    · exact h2
  · intro j hj
    exact haI_eq1 j hj

end Z3FpfOrbitMatrix

#print axioms Z3FpfOrbitMatrix.row_sq_sum
#print axioms Z3FpfOrbitMatrix.tri_offdiag_le_one
#print axioms Z3FpfOrbitMatrix.tri_ones
#print axioms Z3FpfOrbitMatrix.non_le_two
#print axioms Z3FpfOrbitMatrix.non_twos
#print axioms Z3FpfOrbitMatrix.non_ones
#print axioms Z3FpfOrbitMatrix.two_entry_non
#print axioms Z3FpfOrbitMatrix.linear_count
#print axioms Z3FpfOrbitMatrix.counting_identity
#print axioms Z3FpfOrbitMatrix.t27_forces

end Matrix99
