import Conway.Z3FpfRelabel

/-!
# CNF infrastructure and a sequential-counter encoder (WP7, stage 2)

`Lit`/`Clause`/`CNF` syntax, `evalLit`/`evalClause`/`evalCNF` semantics,
`Satisfiable`, and a Sinz-style sequential counter emitting a faithful
encoding of `Σ lits = b`.

Literals are nonzero `Int`: `l > 0` reads `τ l.toNat`, `l < 0` reads
`¬ τ (-l).toNat`.  A counter block for a constraint over `lits` (length `n`)
with bound `b` (`0 < b < n`) uses auxiliary variables
`s(i,j) = base + (i-1)*b + (j-1)` for `1 ≤ i ≤ n-1`, `1 ≤ j ≤ b`, which are
forced by the emitted clauses to equal `pcnt_i ≥ j` (the count of true
literals among the first `i`).  The bound is then enforced on the last row
and the last literal, in both directions.
-/

namespace ConwayCNF

abbrev Lit := Int
abbrev Clause := List Lit
abbrev CNF := List Clause

/-- Literal value: positive literals read `τ`, negative read `¬τ`. -/
def evalLit (τ : Nat → Bool) (l : Lit) : Bool :=
  if 0 < l then τ l.toNat else if l < 0 then !(τ (-l).toNat) else false

def evalClause (τ : Nat → Bool) (c : Clause) : Bool := c.any (evalLit τ)

def evalCNF (τ : Nat → Bool) (F : CNF) : Bool := F.all (evalClause τ)

def Satisfiable (F : CNF) : Prop := ∃ τ, evalCNF τ F = true

def litVal (τ : Nat → Bool) (l : Lit) : Nat := if evalLit τ l then 1 else 0

/-- Sum of literal values (with multiplicity) over a list. -/
theorem litVal_true (τ : Nat → Bool) (l : Lit) (h : evalLit τ l = true) :
    litVal τ l = 1 := by
  unfold litVal; rw [h, if_pos rfl]

theorem litVal_false (τ : Nat → Bool) (l : Lit) (h : evalLit τ l = false) :
    litVal τ l = 0 := by
  unfold litVal; rw [h, if_neg (by decide)]

theorem litVal_le (τ : Nat → Bool) (l : Lit) : litVal τ l ≤ 1 := by
  unfold litVal; split <;> omega

def countLits (τ : Nat → Bool) (lits : List Lit) : Nat :=
  lits.foldl (fun a l => a + litVal τ l) 0

/-- Count of true literals among the first `i`. -/
def pcnt (τ : Nat → Bool) (lits : List Lit) (i : Nat) : Nat :=
  countLits τ (lits.take i)

theorem evalLit_pos (τ : Nat → Bool) (v : Nat) (h : 0 < v) :
    evalLit τ (v : Int) = τ v := by
  unfold evalLit
  rw [if_pos (show (0 : Int) < (v : Int) from by exact_mod_cast h),
      Int.toNat_natCast]

theorem evalLit_negv (τ : Nat → Bool) (v : Nat) (h : 0 < v) :
    evalLit τ (-(v : Int)) = !τ v := by
  unfold evalLit
  rw [if_neg (show ¬((0 : Int) < -(v : Int)) from by omega),
      if_pos (show (-(v : Int)) < 0 from by omega),
      Int.neg_neg, Int.toNat_natCast]

theorem evalLit_neg (τ : Nat → Bool) (l : Lit) (h : l ≠ 0) :
    evalLit τ (-l) = !evalLit τ l := by
  unfold evalLit
  rcases Int.lt_or_gt_of_ne h with hl | hl
  · rw [if_pos (Int.neg_pos_of_neg hl),
        if_neg (Int.not_lt.mpr (Int.le_of_lt hl)), if_pos hl]
    exact (Bool.not_not _).symm
  · rw [if_neg (Int.not_lt.mpr (Int.le_of_lt (Int.neg_neg_of_pos hl))),
        if_pos (Int.neg_neg_of_pos hl), if_pos hl, Int.neg_neg]

-- ---------------------------------------------------------------------------
-- countLits / pcnt

theorem countLits_nil (τ : Nat → Bool) : countLits τ [] = 0 := rfl

theorem foldl_countLits_init (τ : Nat → Bool) (l : List Lit) (a b : Nat) :
    l.foldl (fun acc x => acc + litVal τ x) (a + b) =
      a + l.foldl (fun acc x => acc + litVal τ x) b := by
  induction l generalizing a b with
  | nil => rfl
  | cons x xs ih =>
      rw [List.foldl_cons, List.foldl_cons,
        show a + b + litVal τ x = a + (b + litVal τ x) from by omega, ih]

theorem countLits_cons (τ : Nat → Bool) (x : Lit) (l : List Lit) :
    countLits τ (x :: l) = litVal τ x + countLits τ l := by
  unfold countLits
  rw [List.foldl_cons, show (0 : Nat) + litVal τ x = litVal τ x from Nat.zero_add _]
  exact foldl_countLits_init τ l (litVal τ x) 0

theorem countLits_append (τ : Nat → Bool) (l₁ l₂ : List Lit) :
    countLits τ (l₁ ++ l₂) = countLits τ l₁ + countLits τ l₂ := by
  induction l₁ with
  | nil => rw [List.nil_append, countLits_nil, Nat.zero_add]
  | cons x xs ih =>
      rw [List.cons_append, countLits_cons, countLits_cons, ih]
      omega

theorem countLits_take_le (τ : Nat → Bool) (l : List Lit) (i : Nat) :
    countLits τ (l.take i) ≤ countLits τ l := by
  have := countLits_append τ (l.take i) (l.drop i)
  rw [List.take_append_drop] at this
  omega

theorem countLits_le_length (τ : Nat → Bool) (l : List Lit) :
    countLits τ l ≤ l.length := by
  induction l with
  | nil => exact Nat.le_refl _
  | cons x xs ih =>
      rw [countLits_cons, List.length_cons]
      unfold litVal; split <;> omega

theorem pcnt_succ (τ : Nat → Bool) (lits : List Lit) (i : Nat) (hi : i < lits.length) :
    pcnt τ lits (i + 1) = pcnt τ lits i + litVal τ lits[i] := by
  unfold pcnt
  rw [List.take_succ_eq_append_getElem hi, countLits_append, countLits_cons,
      countLits_nil, Nat.add_zero]

theorem pcnt_zero (τ : Nat → Bool) (lits : List Lit) :
    pcnt τ lits 0 = 0 := rfl

theorem pcnt_le (τ : Nat → Bool) (lits : List Lit) (i : Nat) :
    pcnt τ lits i ≤ i := by
  have h : countLits τ (lits.take i) ≤ (lits.take i).length :=
    countLits_le_length τ _
  rw [List.length_take] at h
  show countLits τ (lits.take i) ≤ i
  omega

theorem pcnt_total (τ : Nat → Bool) (lits : List Lit) :
    pcnt τ lits lits.length = countLits τ lits := by
  unfold pcnt
  rw [List.take_of_length_le (Nat.le_refl _)]

theorem pcnt_succ2 (τ : Nat → Bool) (lits : List Lit) (i : Nat)
    (h : i + 1 < lits.length) :
    pcnt τ lits (i + 2) = pcnt τ lits (i + 1) + litVal τ lits[i + 1] :=
  pcnt_succ τ lits (i + 1) h

theorem pcnt_mono (τ : Nat → Bool) (lits : List Lit) {i j : Nat} (h : i ≤ j) :
    pcnt τ lits i ≤ pcnt τ lits j := by
  unfold pcnt
  have e : lits.take i = (lits.take j).take i := by
    rw [List.take_take, Nat.min_eq_left h]
  rw [e]
  exact countLits_take_le τ _ i

theorem countLits_eq_zero (τ : Nat → Bool) (l : List Lit) (h : countLits τ l = 0)
    {x : Lit} (hx : x ∈ l) : evalLit τ x = false := by
  induction l with
  | nil => exact absurd hx (by simp)
  | cons y ys ih =>
      rw [countLits_cons] at h
      have h1 : litVal τ y = 0 := by omega
      have h2 : countLits τ ys = 0 := by omega
      rcases List.mem_cons.mp hx with h' | hm
      · subst h'
        unfold litVal at h1
        cases hev : evalLit τ x <;> simp_all
      · exact ih h2 hm

theorem countLits_eq_length (τ : Nat → Bool) (l : List Lit) (h : countLits τ l = l.length)
    {x : Lit} (hx : x ∈ l) : evalLit τ x = true := by
  induction l with
  | nil => exact absurd hx (by simp)
  | cons y ys ih =>
      rw [countLits_cons, List.length_cons] at h
      have hb := countLits_le_length τ ys
      have hv1 : litVal τ y ≤ 1 := by unfold litVal; split <;> omega
      have h1 : litVal τ y = 1 := by omega
      have h2 : countLits τ ys = ys.length := by omega
      rcases List.mem_cons.mp hx with h' | hm
      · subst h'
        unfold litVal at h1
        cases hev : evalLit τ x <;> simp_all
      · exact ih h2 hm

-- ---------------------------------------------------------------------------
-- evalCNF over structure

theorem evalCNF_append (τ : Nat → Bool) (F G : CNF) :
    evalCNF τ (F ++ G) = (evalCNF τ F && evalCNF τ G) :=
  List.all_append

theorem evalCNF_map (τ : Nat → Bool) (xs : List α) (f : α → Clause) :
    evalCNF τ (xs.map f) = xs.all (fun x => evalClause τ (f x)) := by
  show (xs.map f).all _ = _
  rw [List.all_map]
  rfl

theorem evalCNF_flatMap (τ : Nat → Bool) (xs : List α) (f : α → CNF) :
    evalCNF τ (xs.flatMap f) = xs.all (fun x => evalCNF τ (f x)) :=
  List.all_flatMap

theorem evalClause_pair (τ : Nat → Bool) (x y : Lit) :
    evalClause τ [x, y] = (evalLit τ x || evalLit τ y) := by
  unfold evalClause
  rw [List.any_cons, List.any_cons, List.any_nil, Bool.or_false]

theorem evalClause_triple (τ : Nat → Bool) (x y z : Lit) :
    evalClause τ [x, y, z] = (evalLit τ x || (evalLit τ y || evalLit τ z)) := by
  unfold evalClause
  rw [List.any_cons, List.any_cons, List.any_cons, List.any_nil, Bool.or_false]

theorem evalClause_single (τ : Nat → Bool) (x : Lit) :
    evalClause τ [x] = evalLit τ x := by
  unfold evalClause
  rw [List.any_cons, List.any_nil, Bool.or_false]

theorem evalCNF_single (τ : Nat → Bool) (c : Clause) :
    evalCNF τ [c] = evalClause τ c := by
  show ([c].all _) = _
  rw [List.all_cons, List.all_nil, Bool.and_true]

theorem evalCNF_nil (τ : Nat → Bool) : evalCNF τ [] = true := rfl

-- ---------------------------------------------------------------------------
-- Sequential counter for `Σ lits = b`, `0 < b < n`.
--
-- aux s(i,j) = base + (i-1)*b + (j-1),  i ∈ 1..n-1,  j ∈ 1..b,
-- forced to equal `pcnt_i ≥ j` by forward clauses F1–F3 and converse
-- clauses B1–B2'.  Bound enforced: ≤ b via LE clauses, ≥ b via GE clauses.

def svar (base b i j : Nat) : Nat := base + (i - 1) * b + (j - 1)

def sv (base b i j : Nat) : Lit := (svar base b i j : Int)

/-- [-l_i, s_{i,1}]  i ∈ 1..n-1 -/
def eqF1 (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range (lits.length - 1)).map fun i0 =>
    [-(lits.getD i0 0), sv base b (i0 + 1) 1]

/-- [-s_{i,j}, s_{i+1,j}]  i ∈ 1..n-2, j ∈ 1..b -/
def eqF2 (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range (lits.length - 2)).flatMap fun i0 =>
    (List.range b).map fun j0 =>
      [-sv base b (i0 + 1) (j0 + 1), sv base b (i0 + 2) (j0 + 1)]

/-- [-l_{i+1}, -s_{i,j}, s_{i+1,j+1}]  i ∈ 1..n-2, j ∈ 1..b-1 -/
def eqF3 (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range (lits.length - 2)).flatMap fun i0 =>
    (List.range (b - 1)).map fun j0 =>
      [-(lits.getD (i0 + 1) 0), -sv base b (i0 + 1) (j0 + 1), sv base b (i0 + 2) (j0 + 2)]

/-- [-s_{i,j}, l_i, s_{i-1,j}]  i ∈ 2..n-1, j ∈ 1..b -/
def eqB1 (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range (lits.length - 2)).flatMap fun i0 =>
    (List.range b).map fun j0 =>
      [-sv base b (i0 + 2) (j0 + 1), lits.getD (i0 + 1) 0, sv base b (i0 + 1) (j0 + 1)]

/-- [-s_{1,j}, l_1]  j ∈ 1..b -/
def eqB1' (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range b).map fun j0 => [-sv base b 1 (j0 + 1), lits.getD 0 0]

/-- [-l_i, -s_{i,j}, s_{i-1,j-1}]  i ∈ 2..n-1, j ∈ 2..b -/
def eqB2 (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range (lits.length - 2)).flatMap fun i0 =>
    (List.range (b - 1)).map fun j0 =>
      [-(lits.getD (i0 + 1) 0), -sv base b (i0 + 2) (j0 + 2), sv base b (i0 + 1) (j0 + 1)]

/-- [-l_1, -s_{1,j}]  j ∈ 2..b -/
def eqB2' (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range (b - 1)).map fun j0 => [-(lits.getD 0 0), -sv base b 1 (j0 + 2)]

/-- [-l_{i+1}, -s_{i,b}]  i ∈ 1..n-1  (Σ ≤ b) -/
def eqLE (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  (List.range (lits.length - 1)).map fun i0 =>
    [-(lits.getD (i0 + 1) 0), -sv base b (i0 + 1) b]

/-- [s_{n-1,b}, l_n]  (Σ ≥ b) -/
def eqGE1 (base : Nat) (lits : List Lit) (b : Nat) : Clause :=
  [sv base b (lits.length - 1) b, lits.getD (lits.length - 1) 0]

/-- [s_{n-1,b}, s_{n-1,b-1}]  (Σ ≥ b, only if b ≥ 2) -/
def eqGE2 (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  if 2 ≤ b then [[sv base b (lits.length - 1) b, sv base b (lits.length - 1) (b - 1)]]
  else []

/-- all counter clauses for `Σ lits = b` when `0 < b < n` -/
def eqClauses (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  eqF1 base lits b ++ eqF2 base lits b ++ eqF3 base lits b ++
  eqB1 base lits b ++ eqB1' base lits b ++ eqB2 base lits b ++ eqB2' base lits b ++
  eqLE base lits b ++ [eqGE1 base lits b] ++ eqGE2 base lits b

/-- number of aux variables allocated for the block -/
def eqAuxSize (lits : List Lit) (b : Nat) : Nat :=
  (lits.length - 1) * b

/-- encoding of `Σ lits = b` for all bounds (degenerate cases handled) -/
def eqEncode (base : Nat) (lits : List Lit) (b : Nat) : CNF :=
  if b = lits.length then lits.map (fun l => [l])
  else if b = 0 then lits.map (fun l => [-l])
  else if 0 < b ∧ b < lits.length then eqClauses base lits b
  else [[]]

-- ---------------------------------------------------------------------------
-- Soundness of the counter block

section CounterSound

variable {τ : Nat → Bool} {lits : List Lit} {b base : Nat}

/-- hypothesis form of the counter assignment agreement -/
abbrev auxAgree (τ : Nat → Bool) (lits : List Lit) (base b : Nat) : Prop :=
  ∀ i j, 1 ≤ i → i ≤ lits.length - 1 → 1 ≤ j → j ≤ b →
    τ (svar base b i j) = decide (j ≤ pcnt τ lits i)

private theorem svar_pos (hbase : 0 < base) (i j : Nat) : 0 < svar base b i j := by
  unfold svar; omega

theorem eval_sv (hbase : 0 < base) (i j : Nat) :
    evalLit τ (sv base b i j) = τ (svar base b i j) :=
  evalLit_pos τ _ (svar_pos hbase i j)

theorem eval_negsv (hbase : 0 < base) (i j : Nat) :
    evalLit τ (-sv base b i j) = !τ (svar base b i j) :=
  evalLit_negv τ _ (svar_pos hbase i j)

theorem getD_eq (i : Nat) (hi : i < lits.length) :
    lits.getD i 0 = lits[i] := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hi]
  rfl

theorem evalLit_getD (i : Nat) (hi : i < lits.length) :
    evalLit τ (lits.getD i 0) = evalLit τ lits[i] := by
  rw [getD_eq i hi]

theorem getD_ne (h0 : ∀ l ∈ lits, l ≠ 0) (i : Nat) (hi : i < lits.length) :
    lits.getD i 0 ≠ 0 := by
  rw [getD_eq i hi]
  exact h0 _ (List.getElem_mem _)

theorem eqF1_true (h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (hb : 0 < b) :
    evalCNF τ (eqF1 base lits b) = true := by
  rw [eqF1, evalCNF_map, List.all_eq_true]
  intro i0 hi0
  have hi0' : i0 < lits.length - 1 := List.mem_range.mp hi0
  have hi0l : i0 < lits.length := by omega
  rw [evalClause_pair, evalLit_neg _ _ (getD_ne h0 _ hi0l), eval_sv hbase,
      evalLit_getD _ hi0l, haux (i0 + 1) 1 (by omega) (by omega) (by omega) (by omega)]
  cases hv : evalLit τ lits[i0] with
  | false => rfl
  | true =>
      have hsucc := pcnt_succ τ lits i0 hi0l
      have hle : 1 ≤ pcnt τ lits (i0 + 1) := by
        rw [hsucc, litVal_true _ _ hv]; omega
      simpa using hle

theorem eqF2_true (_h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (_hb : 0 < b) :
    evalCNF τ (eqF2 base lits b) = true := by
  rw [eqF2, evalCNF_flatMap, List.all_eq_true]
  intro i0 hi0
  have hi0' : i0 < lits.length - 2 := List.mem_range.mp hi0
  rw [evalCNF_map, List.all_eq_true]
  intro j0 hj0
  have hj0' : j0 < b := List.mem_range.mp hj0
  rw [evalClause_pair, eval_negsv hbase, eval_sv hbase,
      haux (i0 + 1) (j0 + 1) (by omega) (by omega) (by omega) (by omega),
      haux (i0 + 2) (j0 + 1) (by omega) (by omega) (by omega) (by omega)]
  cases hs : decide (j0 + 1 ≤ pcnt τ lits (i0 + 1)) with
  | false => rfl
  | true =>
      have hp : j0 + 1 ≤ pcnt τ lits (i0 + 1) := of_decide_eq_true hs
      have hle : j0 + 1 ≤ pcnt τ lits (i0 + 2) :=
        Nat.le_trans hp (pcnt_mono τ lits (Nat.le_succ _))
      simpa using hle

theorem eqF3_true (h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (hb : 0 < b) :
    evalCNF τ (eqF3 base lits b) = true := by
  rw [eqF3, evalCNF_flatMap, List.all_eq_true]
  intro i0 hi0
  have hi0' : i0 < lits.length - 2 := List.mem_range.mp hi0
  have hi0l : i0 + 1 < lits.length := by omega
  rw [evalCNF_map, List.all_eq_true]
  intro j0 hj0
  have hj0' : j0 < b - 1 := List.mem_range.mp hj0
  rw [evalClause_triple, evalLit_neg _ _ (getD_ne h0 _ hi0l), eval_negsv hbase,
      eval_sv hbase, evalLit_getD _ hi0l,
      haux (i0 + 1) (j0 + 1) (by omega) (by omega) (by omega) (by omega),
      haux (i0 + 2) (j0 + 2) (by omega) (by omega) (by omega) (by omega)]
  cases hv : evalLit τ lits[i0 + 1] with
  | false => rfl
  | true =>
      cases hs : decide (j0 + 1 ≤ pcnt τ lits (i0 + 1)) with
      | false => rfl
      | true =>
          have hp : j0 + 1 ≤ pcnt τ lits (i0 + 1) := of_decide_eq_true hs
          have hsucc := pcnt_succ2 τ lits i0 hi0l
          have hle : j0 + 2 ≤ pcnt τ lits (i0 + 2) := by
            rw [hsucc, litVal_true _ _ hv]; omega
          simpa using hle

theorem eqB1_true (_h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (_hb : 0 < b) :
    evalCNF τ (eqB1 base lits b) = true := by
  rw [eqB1, evalCNF_flatMap, List.all_eq_true]
  intro i0 hi0
  have hi0' : i0 < lits.length - 2 := List.mem_range.mp hi0
  have hi0l : i0 + 1 < lits.length := by omega
  rw [evalCNF_map, List.all_eq_true]
  intro j0 hj0
  have hj0' : j0 < b := List.mem_range.mp hj0
  rw [evalClause_triple, eval_negsv hbase, evalLit_getD _ hi0l, eval_sv hbase,
      haux (i0 + 2) (j0 + 1) (by omega) (by omega) (by omega) (by omega),
      haux (i0 + 1) (j0 + 1) (by omega) (by omega) (by omega) (by omega)]
  cases hs : decide (j0 + 1 ≤ pcnt τ lits (i0 + 2)) with
  | false => rfl
  | true =>
      cases hv : evalLit τ lits[i0 + 1] with
      | true => rfl
      | false =>
          have hp : j0 + 1 ≤ pcnt τ lits (i0 + 2) := of_decide_eq_true hs
          have hsucc := pcnt_succ2 τ lits i0 hi0l
          have hle : j0 + 1 ≤ pcnt τ lits (i0 + 1) := by
            have e := hsucc
            rw [litVal_false _ _ hv] at e; omega
          simpa using hle

theorem eqB1'_true (_h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (_hb : 0 < b) (hn : 1 < lits.length) :
    evalCNF τ (eqB1' base lits b) = true := by
  rw [eqB1', evalCNF_map, List.all_eq_true]
  intro j0 hj0
  have hj0' : j0 < b := List.mem_range.mp hj0
  rw [evalClause_pair, eval_negsv hbase, evalLit_getD _ (by omega),
      haux 1 (j0 + 1) (by omega) (by omega) (by omega) (by omega)]
  cases hs : decide (j0 + 1 ≤ pcnt τ lits 1) with
  | false => rfl
  | true =>
      have hp : j0 + 1 ≤ pcnt τ lits 1 := of_decide_eq_true hs
      have hsucc := pcnt_succ τ lits 0 (by omega)
      have e : pcnt τ lits 1 = litVal τ lits[0] := by
        simpa only [pcnt_zero, Nat.zero_add] using hsucc
      have hv : evalLit τ lits[0] = true := by
        have hl : litVal τ lits[0] = 1 := by
          have hb1 := litVal_le τ lits[0]; omega
        cases hev : evalLit τ lits[0]
        · rw [litVal_false _ _ hev] at hl; exact absurd hl (by decide)
        · rfl
      simp [hv]

theorem eqB2_true (h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (hb : 0 < b) :
    evalCNF τ (eqB2 base lits b) = true := by
  rw [eqB2, evalCNF_flatMap, List.all_eq_true]
  intro i0 hi0
  have hi0' : i0 < lits.length - 2 := List.mem_range.mp hi0
  have hi0l : i0 + 1 < lits.length := by omega
  rw [evalCNF_map, List.all_eq_true]
  intro j0 hj0
  have hj0' : j0 < b - 1 := List.mem_range.mp hj0
  rw [evalClause_triple, evalLit_neg _ _ (getD_ne h0 _ hi0l), eval_negsv hbase,
      eval_sv hbase, evalLit_getD _ hi0l,
      haux (i0 + 2) (j0 + 2) (by omega) (by omega) (by omega) (by omega),
      haux (i0 + 1) (j0 + 1) (by omega) (by omega) (by omega) (by omega)]
  cases hv : evalLit τ lits[i0 + 1] with
  | false => rfl
  | true =>
      cases hs : decide (j0 + 2 ≤ pcnt τ lits (i0 + 2)) with
      | false => rfl
      | true =>
          have hp : j0 + 2 ≤ pcnt τ lits (i0 + 2) := of_decide_eq_true hs
          have hsucc := pcnt_succ2 τ lits i0 hi0l
          have hle : j0 + 1 ≤ pcnt τ lits (i0 + 1) := by
            have e := hsucc
            rw [litVal_true _ _ hv] at e; omega
          simpa using hle

theorem eqB2'_true (h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (hb : 0 < b) (hn : 1 < lits.length) :
    evalCNF τ (eqB2' base lits b) = true := by
  rw [eqB2', evalCNF_map, List.all_eq_true]
  intro j0 hj0
  have hj0' : j0 < b - 1 := List.mem_range.mp hj0
  rw [evalClause_pair, evalLit_neg _ _ (getD_ne h0 _ (by omega)), eval_negsv hbase,
      evalLit_getD _ (by omega),
      haux 1 (j0 + 2) (by omega) (by omega) (by omega) (by omega)]
  cases hv : evalLit τ lits[0] with
  | false => rfl
  | true =>
      have hsucc := pcnt_succ τ lits 0 (by omega)
      have e : pcnt τ lits 1 = litVal τ lits[0] := by
        simpa only [pcnt_zero, Nat.zero_add] using hsucc
      have hle : ¬ (j0 + 2 ≤ pcnt τ lits 1) := by
        rw [e]; rw [litVal_true _ _ hv]; omega
      cases hd : decide (j0 + 2 ≤ pcnt τ lits 1) with
      | true => exact absurd (of_decide_eq_true hd) hle
      | false => rfl

theorem eqLE_true (h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (hb : 0 < b) (hsum : countLits τ lits = b) :
    evalCNF τ (eqLE base lits b) = true := by
  rw [eqLE, evalCNF_map, List.all_eq_true]
  intro i0 hi0
  have hi0' : i0 < lits.length - 1 := List.mem_range.mp hi0
  have hi0l : i0 + 1 < lits.length := by omega
  rw [evalClause_pair, evalLit_neg _ _ (getD_ne h0 _ hi0l), eval_negsv hbase,
      evalLit_getD _ hi0l, haux (i0 + 1) b (by omega) (by omega) (by omega) (by omega)]
  cases hv : evalLit τ lits[i0 + 1] with
  | false => rfl
  | true =>
      have hsucc := pcnt_succ2 τ lits i0 hi0l
      have hle := pcnt_mono τ lits (show i0 + 2 ≤ lits.length by omega)
      have htot := pcnt_total τ lits
      have hneg : ¬ (b ≤ pcnt τ lits (i0 + 1)) := by
        intro hbb
        have hge : pcnt τ lits (i0 + 2) ≥ b + 1 := by
          rw [hsucc, litVal_true _ _ hv]; omega
        omega
      cases hd : decide (b ≤ pcnt τ lits (i0 + 1)) with
      | true => exact absurd (of_decide_eq_true hd) hneg
      | false => rfl

theorem eqGE1_true (_h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (hb : 0 < b) (hbn : b < lits.length)
    (hsum : countLits τ lits = b) :
    evalClause τ (eqGE1 base lits b) = true := by
  have hnl : lits.length - 1 < lits.length := by omega
  have hn1 : 1 ≤ lits.length - 1 := by omega
  rw [eqGE1, evalClause_pair, eval_sv hbase, evalLit_getD _ hnl,
      haux (lits.length - 1) b hn1 (by omega) (by omega) (by omega)]
  cases hs : decide (b ≤ pcnt τ lits (lits.length - 1)) with
  | true => rfl
  | false =>
      have hp : ¬ (b ≤ pcnt τ lits (lits.length - 1)) := of_decide_eq_false hs
      have hsucc : pcnt τ lits lits.length =
          pcnt τ lits (lits.length - 1) + litVal τ lits[lits.length - 1] := by
        have h2 := pcnt_succ τ lits (lits.length - 1) hnl
        rwa [show lits.length - 1 + 1 = lits.length by omega] at h2
      have htot := pcnt_total τ lits
      have hv : evalLit τ lits[lits.length - 1] = true := by
        have hl : litVal τ lits[lits.length - 1] = 1 := by
          have hb1 := litVal_le τ lits[lits.length - 1]; omega
        cases hev : evalLit τ lits[lits.length - 1]
        · rw [litVal_false _ _ hev] at hl; exact absurd hl (by decide)
        · rfl
      simp [hv]

theorem eqGE2_true (_h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (_hb : 0 < b) (hbn : b < lits.length)
    (hsum : countLits τ lits = b) :
    evalCNF τ (eqGE2 base lits b) = true := by
  rw [eqGE2]
  split
  · rename_i hb2
    rw [evalCNF_single, evalClause_pair, eval_sv hbase, eval_sv hbase,
        haux (lits.length - 1) b (by omega) (by omega) (by omega) (by omega),
        haux (lits.length - 1) (b - 1) (by omega) (by omega) (by omega) (by omega)]
    have hnl : lits.length - 1 < lits.length := by omega
    cases hs : decide (b ≤ pcnt τ lits (lits.length - 1)) with
    | true => rfl
    | false =>
        have hp : ¬ (b ≤ pcnt τ lits (lits.length - 1)) := of_decide_eq_false hs
        have hsucc : pcnt τ lits lits.length =
            pcnt τ lits (lits.length - 1) + litVal τ lits[lits.length - 1] := by
          have h2 := pcnt_succ τ lits (lits.length - 1) hnl
          rwa [show lits.length - 1 + 1 = lits.length by omega] at h2
        have htot := pcnt_total τ lits
        have hbv : litVal τ lits[lits.length - 1] ≤ 1 := by
          unfold litVal; split <;> omega
        have hle : b - 1 ≤ pcnt τ lits (lits.length - 1) := by omega
        simpa using hle
  · rfl

theorem eqClauses_true (h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (haux : auxAgree τ lits base b) (hb : 0 < b) (hbn : b < lits.length)
    (hsum : countLits τ lits = b) :
    evalCNF τ (eqClauses base lits b) = true := by
  have hn : 1 < lits.length := by omega
  unfold eqClauses
  repeat rw [evalCNF_append]
  simp only [Bool.and_eq_true]
  refine ⟨?_, eqGE2_true h0 hbase haux hb hbn hsum⟩
  refine ⟨?_, by rw [evalCNF_single]; exact eqGE1_true h0 hbase haux hb hbn hsum⟩
  refine ⟨?_, eqLE_true h0 hbase haux hb hsum⟩
  refine ⟨?_, eqB2'_true h0 hbase haux hb hn⟩
  refine ⟨?_, eqB2_true h0 hbase haux hb⟩
  refine ⟨?_, eqB1'_true h0 hbase haux hb hn⟩
  refine ⟨?_, eqB1_true h0 hbase haux hb⟩
  refine ⟨?_, eqF3_true h0 hbase haux hb⟩
  refine ⟨?_, eqF2_true h0 hbase haux hb⟩
  exact eqF1_true h0 hbase haux hb

theorem eqEncode_true (τ : Nat → Bool) (lits : List Lit) (b base : Nat)
    (h0 : ∀ l ∈ lits, l ≠ 0) (hbase : 0 < base)
    (hsum : countLits τ lits = b)
    (haux : auxAgree τ lits base b) :
    evalCNF τ (eqEncode base lits b) = true := by
  rw [eqEncode]
  split
  · rename_i hbn
    rw [evalCNF_map, List.all_eq_true]
    intro l hl
    rw [evalClause_single]
    have hsum' : countLits τ lits = lits.length := by omega
    exact countLits_eq_length τ lits hsum' hl
  · rename_i hbn
    split
    · rename_i hb0
      rw [evalCNF_map, List.all_eq_true]
      intro l hl
      rw [evalClause_single, evalLit_neg _ _ (h0 l hl)]
      have hsum' : countLits τ lits = 0 := by omega
      rw [countLits_eq_zero τ lits hsum' hl]
      rfl
    · rename_i hb0
      split
      · rename_i hbb
        exact eqClauses_true h0 hbase haux hbb.1 hbb.2 hsum
      · rename_i hbb
        exfalso
        have hb : b ≤ lits.length := by
          rw [← hsum]; exact countLits_le_length τ lits
        have h1 : 0 < b := Nat.pos_of_ne_zero hb0
        have h2 : b < lits.length := Nat.lt_of_le_of_ne hb hbn
        exact hbb ⟨h1, h2⟩

theorem countLits_congr (τ0 τ1 : Nat → Bool) (lits : List Lit)
    (h : ∀ l ∈ lits, evalLit τ0 l = evalLit τ1 l) :
    countLits τ0 lits = countLits τ1 lits := by
  induction lits with
  | nil => rfl
  | cons x t ih =>
      rw [countLits_cons, countLits_cons, ih (fun l hl => h l (List.mem_cons_of_mem _ hl))]
      congr 1
      unfold litVal; rw [h x List.mem_cons_self]

theorem pcnt_congr (τ0 τ1 : Nat → Bool) (lits : List Lit)
    (h : ∀ l ∈ lits, evalLit τ0 l = evalLit τ1 l) (i : Nat) :
    pcnt τ0 lits i = pcnt τ1 lits i := by
  unfold pcnt
  apply countLits_congr
  intro l hl
  exact h l (List.take_sublist i lits |>.subset hl)

-- ---------------------------------------------------------------------------
-- Sequential allocation of counter blocks

private theorem evalLit_succ (t : Nat → Bool) (m : Nat) :
    evalLit t (Int.ofNat (m + 1)) = t (m + 1) := by
  unfold evalLit
  have h1 : (0 : Int) < Int.ofNat (m + 1) := Int.natCast_succ_pos m
  rw [if_pos h1]; rfl

private theorem evalLit_negSucc (t : Nat → Bool) (m : Nat) :
    evalLit t (Int.negSucc m) = !t (m + 1) := by
  unfold evalLit
  rw [if_neg (Int.negSucc_not_pos m |>.mp),
      if_pos (Int.negSucc_lt_zero m)]
  rfl

/-- `evalLit` depends only on the assignment at `l.natAbs` -/
theorem evalLit_agree (t t' : Nat → Bool) (l : Lit)
    (h : t l.natAbs = t' l.natAbs) : evalLit t l = evalLit t' l := by
  cases l with
  | ofNat n =>
      cases n with
      | zero => rfl
      | succ m =>
          rw [evalLit_succ, evalLit_succ]
          exact h
  | negSucc m =>
      have h' : t (m + 1) = t' (m + 1) := h
      rw [evalLit_negSucc, evalLit_negSucc, h']

/-- counter block spec: variables `base + (i-1)*b + (j-1)` for `Σ lits = b` -/
structure Spec where
  base : Nat
  b : Nat
  lits : List Lit

def specRange (sp : Spec) (v : Nat) : Prop :=
  sp.base ≤ v ∧ v < sp.base + eqAuxSize sp.lits sp.b

instance (sp : Spec) : DecidablePred (specRange sp) :=
  fun v => inferInstanceAs (Decidable (_ ∧ _))

/-- set the aux variables of `sp` to the partial-sum thresholds -/
def auxOf (τ0 : Nat → Bool) (sp : Spec) (v : Nat) : Bool :=
  if specRange sp v then
    decide ((v - sp.base) % sp.b + 1 ≤ pcnt τ0 sp.lits ((v - sp.base) / sp.b + 1))
  else τ0 v

/-- apply all spec blocks' aux assignments in order -/
def extAll (τ0 : Nat → Bool) : List Spec → Nat → Bool
  | [] => τ0
  | sp :: rest => extAll (auxOf τ0 sp) rest

/-- allocate a spec per `(bound, lits)` starting at `p` -/
def allocSpecs : List (Nat × List Lit) → Nat → List Spec
  | [], _ => []
  | (b, lits) :: t, p => ⟨p, b, lits⟩ :: allocSpecs t (p + eqAuxSize lits b)

theorem extAll_out (τ0 : Nat → Bool) (specs : List Spec) (v : Nat)
    (h : ∀ sp ∈ specs, ¬ specRange sp v) :
    extAll τ0 specs v = τ0 v := by
  induction specs generalizing τ0 with
  | nil => rfl
  | cons sp rest ih =>
      rw [extAll, ih _ (fun s' hs' => h s' (List.mem_cons_of_mem _ hs'))]
      exact if_neg (h sp List.mem_cons_self)

theorem allocSpecs_base_ge (l : List (Nat × List Lit)) (p : Nat)
    (sp : Spec) (hm : sp ∈ allocSpecs l p) : p ≤ sp.base := by
  induction l generalizing p with
  | nil => simp [allocSpecs] at hm
  | cons x t ih =>
      simp only [allocSpecs] at hm
      rcases List.mem_cons.mp hm with rfl | hm'
      · exact Nat.le_refl _
      · have := ih (p + eqAuxSize x.2 x.1) hm'
        omega

/-- values of literals below the block's base are untouched by `auxOf` -/
theorem auxOf_evalLit_lt (τ0 : Nat → Bool) (sp : Spec) (l : Lit)
    (h : l.natAbs < sp.base) :
    evalLit (auxOf τ0 sp) l = evalLit τ0 l := by
  apply evalLit_agree
  unfold auxOf
  rw [if_neg (show ¬ specRange sp l.natAbs from fun hr => Nat.not_le.mpr h hr.1)]

/-- every allocated spec stores its `(bound, lits)` pair -/
theorem allocSpecs_lits (l : List (Nat × List Lit)) (p : Nat)
    (sp : Spec) (hm : sp ∈ allocSpecs l p) :
    ∃ pr ∈ l, sp.b = pr.1 ∧ sp.lits = pr.2 := by
  induction l generalizing p with
  | nil => simp [allocSpecs] at hm
  | cons x t ih =>
      simp only [allocSpecs] at hm
      rcases List.mem_cons.mp hm with rfl | hm'
      · exact ⟨x, List.mem_cons_self, rfl, rfl⟩
      · obtain ⟨pr, hpr, hb, hls⟩ := ih (p + eqAuxSize x.2 x.1) hm'
        exact ⟨pr, List.mem_cons_of_mem _ hpr, hb, hls⟩

theorem extAll_low (τ0 : Nat → Bool) (l : List (Nat × List Lit)) (p : Nat)
    (v : Nat) (hv : v < p) :
    extAll τ0 (allocSpecs l p) v = τ0 v := by
  apply extAll_out
  intro sp hm hr
  have hb := allocSpecs_base_ge l p sp hm
  unfold specRange at hr
  omega

theorem extAll_alloc (l : List (Nat × List Lit)) :
    ∀ (p : Nat) (τ0 : Nat → Bool),
    (∀ pr ∈ l, ∀ x ∈ pr.2, x.natAbs < p) →
    ∀ (sp : Spec), sp ∈ allocSpecs l p → ∀ (v : Nat), specRange sp v →
    extAll τ0 (allocSpecs l p) v =
      decide ((v - sp.base) % sp.b + 1 ≤ pcnt τ0 sp.lits ((v - sp.base) / sp.b + 1)) := by
  induction l with
  | nil => intro p τ0 hpre sp hm; simp [allocSpecs] at hm
  | cons x t ih =>
      intro p τ0 hpre sp hm v hv
      simp only [allocSpecs] at hm
      show extAll (auxOf τ0 ⟨p, x.1, x.2⟩) (allocSpecs t (p + eqAuxSize x.2 x.1)) v = _
      rcases List.mem_cons.mp hm with rfl | hm'
      · have hout : ∀ s' ∈ allocSpecs t (p + eqAuxSize x.2 x.1), ¬ specRange s' v := by
          intro s' hs' hr
          have hb := allocSpecs_base_ge t _ s' hs'
          have hlt : v < p + eqAuxSize x.2 x.1 := hv.2
          unfold specRange at hr
          omega
        rw [extAll_out _ _ _ hout]
        unfold auxOf
        rw [if_pos hv]
      · have hb := allocSpecs_base_ge t _ _ hm'
        have hnot : ¬ specRange ⟨p, x.1, x.2⟩ v := by
          intro hr
          have hge : sp.base ≤ v := hv.1
          have hlt : v < p + eqAuxSize x.2 x.1 := hr.2
          omega
        have hpre' : ∀ pr ∈ t, ∀ x' ∈ pr.2, x'.natAbs < p + eqAuxSize x.2 x.1 := by
          intro pr hpr x' hx'
          have hlt := hpre pr (List.mem_cons_of_mem _ hpr) x' hx'
          omega
        have e := ih (p + eqAuxSize x.2 x.1) (auxOf τ0 ⟨p, x.1, x.2⟩) hpre' sp hm' v hv
        rw [e]
        obtain ⟨pr, hpr, _hb2, hl2⟩ := allocSpecs_lits t _ sp hm'
        have hagree : ∀ y ∈ sp.lits,
            evalLit (auxOf τ0 ⟨p, x.1, x.2⟩) y = evalLit τ0 y := by
          intro y hy
          apply auxOf_evalLit_lt
          have hlt := hpre pr (List.mem_cons_of_mem _ hpr) y (by rw [← hl2]; exact hy)
          omega
        have hpc : pcnt (auxOf τ0 ⟨p, x.1, x.2⟩) sp.lits
              ((v - sp.base) / sp.b + 1) =
            pcnt τ0 sp.lits ((v - sp.base) / sp.b + 1) :=
          pcnt_congr _ _ _ hagree _
        rw [hpc]

/-- `svar` always lies inside its spec's allocated range -/
theorem svar_mem_range (sp : Spec) (i j : Nat)
    (hi : 1 ≤ i) (hil : i ≤ sp.lits.length - 1) (hj : 1 ≤ j) (hjb : j ≤ sp.b) :
    specRange sp (svar sp.base sp.b i j) := by
  have hb1 : 1 ≤ sp.b := by omega
  have hn2 : 2 ≤ sp.lits.length := by omega
  have hmul : (sp.lits.length - 2) * sp.b + sp.b = (sp.lits.length - 1) * sp.b := by
    have h2 : sp.lits.length - 2 + 1 = sp.lits.length - 1 := by omega
    rw [← h2, Nat.add_mul, Nat.one_mul]
  constructor
  · unfold svar; omega
  · unfold eqAuxSize svar
    have h1 : (i - 1) * sp.b ≤ (sp.lits.length - 2) * sp.b :=
      Nat.mul_le_mul_right _ (by omega)
    have h2 : j - 1 ≤ sp.b - 1 := by omega
    omega

/-- decode of `svar` inside its range -/
theorem svar_decode (sp : Spec) (i j : Nat)
    (hi : 1 ≤ i) (hj : 1 ≤ j) (hjb : j ≤ sp.b) :
    ((svar sp.base sp.b i j - sp.base) / sp.b + 1 = i) ∧
    ((svar sp.base sp.b i j - sp.base) % sp.b + 1 = j) := by
  have hb1 : 1 ≤ sp.b := by omega
  have h1 : j - 1 < sp.b := by omega
  constructor
  · have e : svar sp.base sp.b i j - sp.base = (i - 1) * sp.b + (j - 1) := by
      unfold svar; omega
    rw [e]
    have hd : ((i - 1) * sp.b + (j - 1)) / sp.b = i - 1 := by
      apply Nat.div_eq_of_lt_le
      · exact Nat.le_add_right _ _
      · have e2 : (i - 1 + 1) * sp.b = (i - 1) * sp.b + sp.b := by
          rw [Nat.add_mul, Nat.one_mul]
        rw [e2]; omega
    omega
  · have e : svar sp.base sp.b i j - sp.base = (j - 1) + (i - 1) * sp.b := by
      unfold svar; omega
    rw [e, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt h1]
    omega

theorem extAll_auxAgree (τ0 : Nat → Bool) (l : List (Nat × List Lit)) (p : Nat)
    (hpre : ∀ pr ∈ l, ∀ x ∈ pr.2, x.natAbs < p)
    (sp : Spec) (hm : sp ∈ allocSpecs l p) :
    auxAgree (extAll τ0 (allocSpecs l p)) sp.lits sp.base sp.b := by
  intro i j hi hil hj hjb
  have hv := svar_mem_range sp i j hi hil hj hjb
  have e := extAll_alloc l p τ0 hpre sp hm _ hv
  have hd := svar_decode sp i j hi hj hjb
  rw [e, hd.1, hd.2]
  have hlow : ∀ x ∈ sp.lits, x.natAbs < p := by
    obtain ⟨pr, hpr, _, hl2⟩ := allocSpecs_lits l p sp hm
    intro x hx
    exact hpre pr hpr x (by rw [← hl2]; exact hx)
  have hpc : pcnt τ0 sp.lits i =
      pcnt (extAll τ0 (allocSpecs l p)) sp.lits i := by
    apply pcnt_congr
    intro x hx
    exact evalLit_agree _ _ _ (extAll_low τ0 l p _ (hlow x hx)).symm
  rw [hpc]

/-- one spec's encoded clauses are satisfied by the extended assignment -/
theorem spec_true (τ0 : Nat → Bool) (l : List (Nat × List Lit)) (p : Nat)
    (hpre : ∀ pr ∈ l, ∀ x ∈ pr.2, x.natAbs < p) (hp : 0 < p)
    (sp : Spec) (hm : sp ∈ allocSpecs l p)
    (h0 : ∀ x ∈ sp.lits, x ≠ 0)
    (hsum : countLits τ0 sp.lits = sp.b) :
    evalCNF (extAll τ0 (allocSpecs l p)) (eqEncode sp.base sp.lits sp.b) = true := by
  apply eqEncode_true _ _ _ _ h0 (Nat.lt_of_lt_of_le hp (allocSpecs_base_ge l p sp hm)) _
    (extAll_auxAgree τ0 l p hpre sp hm)
  have hcl : countLits (extAll τ0 (allocSpecs l p)) sp.lits =
      countLits τ0 sp.lits := by
    apply countLits_congr
    intro x hx
    apply evalLit_agree
    obtain ⟨pr, hpr, _, hl2⟩ := allocSpecs_lits l p sp hm
    have hxp : x.natAbs < p := hpre pr hpr x (by rw [← hl2]; exact hx)
    exact extAll_low τ0 l p _ hxp
  rwa [hcl]

/-- the whole allocated block of eq-encoded constraints is satisfied -/
theorem allocBlock_true (τ0 : Nat → Bool) (l : List (Nat × List Lit)) (p : Nat)
    (hpre : ∀ pr ∈ l, ∀ x ∈ pr.2, x.natAbs < p) (hp : 0 < p)
    (h0 : ∀ pr ∈ l, ∀ x ∈ pr.2, x ≠ 0)
    (hsum : ∀ pr ∈ l, countLits τ0 pr.2 = pr.1) :
    evalCNF (extAll τ0 (allocSpecs l p))
      ((allocSpecs l p).flatMap fun sp => eqEncode sp.base sp.lits sp.b) = true := by
  rw [evalCNF_flatMap, List.all_eq_true]
  intro sp hm
  obtain ⟨pr, hpr, hb2, hl2⟩ := allocSpecs_lits l p sp hm
  have h0' : ∀ x ∈ sp.lits, x ≠ 0 := fun x hx => h0 pr hpr x (by rw [← hl2]; exact hx)
  have hsum' : countLits τ0 sp.lits = sp.b := by
    have := hsum pr hpr
    rwa [← hl2, ← hb2] at this
  exact spec_true τ0 l p hpre hp sp hm h0' hsum'

-- ---------------------------------------------------------------------------
-- DIMACS serialization

def clauseToDimacs (c : Clause) : String :=
  c.foldl (fun s l => s ++ toString l ++ " ") "" ++ "0"

def toDimacs (nvars : Nat) (F : CNF) : String :=
  "p cnf " ++ toString nvars ++ " " ++ toString F.length ++ "\n" ++
    String.intercalate "\n" (F.map clauseToDimacs) ++ "\n"

end CounterSound
end ConwayCNF
