import Conway.Z3FpfCNF
import Conway.Z3FpfT27

/-!
# Concrete CNF generator for the `t = 27` group-ring systems (WP7, stage 2)

Mirrors `z3fpf_groupring_sat.py` with flags `--t 27 --gauge --row0-nT n
[--t27-counting]` (m = 33, k = 14, λ = 1, μ = 2), but emits DIMACS clauses
directly with a kernel-checked soundness proof.

Variable layout (all ranges disjoint and increasing):

* `xvar i j s` for `i < j`: `1 + 3·(i·33 + j) + s`  (1..3168, sparse);
* `dvar i`: `3169 + i`  (3169..3201);
* `andvar i j s k u` for `i ≤ j`: `3202 + (i·33+j)·297 + s·99 + 3k + u`
  (3202..326634);
* sequential-counter blocks from `baseVars = 326635` upward.

`litOf i j s` mirrors the Python `lit`: the constant-false `s = 0` diagonal
maps to literal `0` and is skipped wherever a literal list is built.
-/

namespace Matrix99
open ConwayOrbit ConwayCNF

namespace Z3FpfGroupRing
namespace CnfT27

-- ---------------------------------------------------------------------------
-- Variable layout

/-- primary variable `x(i,j,s)`, `i < j` -/
def xvar (i j : Fin 33) (s : Fin 3) : Nat := 1 + 3 * (i.val * 33 + j.val) + s.val

def xvarMax : Nat := 3168

/-- diagonal variable `d(i)` -/
def dvar (i : Fin 33) : Nat := 3169 + i.val

def dvarMax : Nat := 3201

/-- AND variable for the product term `(i,j,s,k,u)`, allocated only for `i ≤ j` -/
def andvar (i j : Fin 33) (s : Fin 3) (k : Fin 33) (u : Fin 3) : Nat :=
  3202 + (i.val * 33 + j.val) * 297 + s.val * 99 + k.val * 3 + u.val

/-- first counter-block variable -/
def baseVars : Nat := 326635

theorem xvar_le (i j : Fin 33) (s : Fin 3) (h : i.val < j.val) :
    xvar i j s ≤ xvarMax := by
  unfold xvar xvarMax
  have hi := i.isLt
  have hj := j.isLt
  omega

theorem one_le_xvar (i j : Fin 33) (s : Fin 3) : 1 ≤ xvar i j s := by
  unfold xvar; omega

theorem dvar_bounds (i : Fin 33) : xvarMax < dvar i ∧ dvar i ≤ dvarMax := by
  have h := i.isLt
  unfold dvar xvarMax dvarMax
  exact ⟨by omega, by omega⟩

theorem andvar_bounds (i j : Fin 33) (s : Fin 3) (k : Fin 33) (u : Fin 3) :
    dvarMax < andvar i j s k u ∧ andvar i j s k u < baseVars := by
  have hi := i.isLt; have hj := j.isLt; have hs := s.isLt
  have hk := k.isLt; have hu := u.isLt
  unfold andvar dvarMax baseVars
  exact ⟨by omega, by omega⟩

-- ---------------------------------------------------------------------------
-- Literal map

/-- literal of `S i j s`; the `i = j, s = 0` slot is the constant false `0` -/
def litOf (i j : Fin 33) (s : Fin 3) : Lit :=
  if i = j then (if s = 0 then 0 else dvar i)
  else if i.val < j.val then xvar i j s
  else xvar j i (-s)

theorem litOf_ne_zero {i j : Fin 33} {s : Fin 3} (h : i ≠ j) : litOf i j s ≠ 0 := by
  unfold litOf
  rw [if_neg h]
  split
  · exact Int.ne_of_gt (Int.natCast_pos.mpr (one_le_xvar i j s))
  · exact Int.ne_of_gt (Int.natCast_pos.mpr (one_le_xvar j i (-s)))

theorem litOf_zero {i j : Fin 33} {s : Fin 3} (h : litOf i j s = 0) :
    i = j ∧ s = 0 := by
  unfold litOf at h
  split at h
  · rename_i hij
    split at h
    · rename_i hs; exact ⟨hij, hs⟩
    · exact absurd h (Int.ne_of_gt (Int.natCast_pos.mpr (by unfold dvar; omega)))
  · split at h
    · exact absurd h (Int.ne_of_gt (Int.natCast_pos.mpr (one_le_xvar _ _ _)))
    · exact absurd h (Int.ne_of_gt (Int.natCast_pos.mpr (one_le_xvar _ _ _)))

-- ---------------------------------------------------------------------------
-- Base assignment

/-- decode of a primary-variable index (junk values are wrapped harmlessly) -/
def decX (v : Nat) : Fin 33 × Fin 33 × Fin 3 :=
  let q := (v - 1) / 3
  (⟨q / 33 % 33, by omega⟩, ⟨q % 33, by omega⟩, ⟨(v - 1) % 3, by omega⟩)

/-- decode of a diagonal-variable index -/
def decD (v : Nat) : Fin 33 := ⟨(v - 3169) % 33, by omega⟩

/-- decode of an AND-variable index: `(i, j, s, k, u)` -/
def decA (v : Nat) : Fin 33 × Fin 33 × Fin 3 × Fin 33 × Fin 3 :=
  let w := v - 3202
  (⟨w / 297 / 33 % 33, by omega⟩, ⟨(w / 297) % 33, by omega⟩, ⟨(w / 99) % 3, by omega⟩,
   ⟨(w % 99) / 3, by omega⟩, ⟨w % 3, by omega⟩)

/-- assignment on the primary, diagonal and AND variables -/
def baseAssign (G : Z3FpfGroupRing) (v : Nat) : Bool :=
  if 1 ≤ v ∧ v ≤ xvarMax ∧ (decX v).1.val < (decX v).2.1.val then
    G.S (decX v).1 (decX v).2.1 (decX v).2.2
  else if xvarMax < v ∧ v ≤ dvarMax then
    G.S (decD v) (decD v) 1
  else if dvarMax < v ∧ v < baseVars then
    let (i, j, s, k, u) := decA v
    (if G.S i k u then true else false) &&
      (if G.S k j (s - u) then true else false)
  else false

-- ---------------------------------------------------------------------------
-- Decode lemmas

theorem decX_xvar (i j : Fin 33) (s : Fin 3) :
    decX (xvar i j s) = (i, j, s) := by
  have hq : (xvar i j s - 1) / 3 = i.val * 33 + j.val := by unfold xvar; omega
  have hs : (xvar i j s - 1) % 3 = s.val := by unfold xvar; omega
  have hdiv : (i.val * 33 + j.val) / 33 = i.val := by
    have := j.isLt; omega
  have hmod : (i.val * 33 + j.val) % 33 = j.val := by
    have := j.isLt; omega
  refine Prod.ext (Fin.ext ?_) (Prod.ext (Fin.ext ?_) (Fin.ext ?_))
  · show (xvar i j s - 1) / 3 / 33 % 33 = i.val
    rw [hq, hdiv, Nat.mod_eq_of_lt i.isLt]
  · show (xvar i j s - 1) / 3 % 33 = j.val
    rw [hq, hmod]
  · show (xvar i j s - 1) % 3 = s.val
    rw [hs]

theorem decD_dvar (i : Fin 33) : decD (dvar i) = i := by
  apply Fin.ext
  show (dvar i - 3169) % 33 = i.val
  unfold dvar; omega

theorem decA_andvar (i j : Fin 33) (s : Fin 3) (k : Fin 33) (u : Fin 3) :
    decA (andvar i j s k u) = (i, j, s, k, u) := by
  have hs := s.isLt; have hk := k.isLt; have hu := u.isLt
  have hq : (andvar i j s k u - 3202) / 297 = i.val * 33 + j.val := by
    unfold andvar; omega
  have hs' : (andvar i j s k u - 3202) / 99 % 3 = s.val := by
    unfold andvar; omega
  have hk' : (andvar i j s k u - 3202) % 99 / 3 = k.val := by
    unfold andvar; omega
  have hu' : (andvar i j s k u - 3202) % 3 = u.val := by
    unfold andvar; omega
  have hdiv : (i.val * 33 + j.val) / 33 = i.val := by
    have := j.isLt; omega
  have hmod : (i.val * 33 + j.val) % 33 = j.val := by
    have := j.isLt; omega
  refine Prod.ext (Fin.ext ?_) (Prod.ext (Fin.ext ?_) (Prod.ext (Fin.ext ?_)
    (Prod.ext (Fin.ext ?_) (Fin.ext ?_))))
  · show (andvar i j s k u - 3202) / 297 / 33 % 33 = i.val
    rw [hq, hdiv, Nat.mod_eq_of_lt i.isLt]
  · show (andvar i j s k u - 3202) / 297 % 33 = j.val
    rw [hq, hmod]
  · show (andvar i j s k u - 3202) / 99 % 3 = s.val
    rw [hs']
  · show (andvar i j s k u - 3202) % 99 / 3 = k.val
    rw [hk']
  · show (andvar i j s k u - 3202) % 3 = u.val
    rw [hu']

-- ---------------------------------------------------------------------------
-- `evalLit` on the base assignment

theorem baseAssign_xvar (G : Z3FpfGroupRing) (i j : Fin 33) (s : Fin 3)
    (h : i.val < j.val) : baseAssign G (xvar i j s) = G.S i j s := by
  have hb := xvar_le i j s h
  have hb1 := one_le_xvar i j s
  have hdec := decX_xvar i j s
  unfold baseAssign
  rw [if_pos ⟨hb1, hb, by rw [hdec]; exact h⟩]
  rw [hdec]

theorem baseAssign_dvar (G : Z3FpfGroupRing) (i : Fin 33) :
    baseAssign G (dvar i) = G.S i i 1 := by
  have hb := dvar_bounds i
  have hdec := decD_dvar i
  unfold baseAssign
  rw [if_neg (fun hc => absurd hc.2.1 (Nat.not_le.mpr hb.1)),
      if_pos hb, hdec]

theorem baseAssign_andvar (G : Z3FpfGroupRing) (i j : Fin 33) (s : Fin 3)
    (k : Fin 33) (u : Fin 3) :
    baseAssign G (andvar i j s k u) =
      ((if G.S i k u then true else false) &&
        (if G.S k j (s - u) then true else false)) := by
  have hb := andvar_bounds i j s k u
  have hdec := decA_andvar i j s k u
  unfold baseAssign
  rw [if_neg (fun hc => absurd hc.2.1 (Nat.not_le.mpr
        (Nat.lt_trans (by unfold xvarMax dvarMax; omega) hb.1))),
      if_neg (fun hc => absurd hc.2 (Nat.not_le.mpr hb.1)),
      if_pos hb, hdec]

/-- Fin-3 trichotomy -/
theorem fin3_cases : ∀ s : Fin 3, s = 0 ∨ s = 1 ∨ s = 2 := by decide

/-- every concrete literal evaluates to its shift-set membership under `baseAssign` -/
theorem evalLit_litOf (G : Z3FpfGroupRing) (i j : Fin 33) (s : Fin 3) :
    evalLit (baseAssign G) (litOf i j s) = G.S i j s := by
  unfold litOf
  by_cases hij : i = j
  · rw [if_pos hij]
    by_cases hs : s = 0
    · rw [if_pos hs]
      subst hij; subst hs
      have h0 : evalLit (baseAssign G) 0 = false := by
        unfold evalLit; simp
      rw [h0, G.loopless i]
    · rw [if_neg hs]
      have hev : evalLit (baseAssign G) ((dvar i : Nat) : Int) = G.S i i 1 := by
        rw [evalLit_pos _ _ (by unfold dvar; omega)]
        exact baseAssign_dvar G i
      subst hij
      rcases fin3_cases s with h0 | h1 | h2
      · exact absurd h0 hs
      · subst h1; exact hev
      · subst h2; rw [hev]; exact G.diag i
  · rw [if_neg hij]
    by_cases hlt : i.val < j.val
    · rw [if_pos hlt]
      rw [evalLit_pos _ _ (by have := one_le_xvar i j s; omega)]
      exact baseAssign_xvar G i j s hlt
    · rw [if_neg hlt]
      have hlt' : j.val < i.val := by
        have hne : i.val ≠ j.val := fun hh => hij (Fin.ext hh)
        have hi := i.isLt; have hj := j.isLt; omega
      rw [evalLit_pos _ _ (by have := one_le_xvar j i (-s); omega)]
      rw [baseAssign_xvar G j i (-s) hlt']
      exact (G.sym i j (-s)).trans (by rw [fin3_neg_neg])

theorem evalLit_zero (τ : Nat → Bool) : evalLit τ 0 = false := by
  unfold evalLit; simp

/-- the AND literal for a product term; `0` when a factor is the constant false -/
def andLitOf (i j : Fin 33) (s : Fin 3) (k : Fin 33) (u : Fin 3) : Lit :=
  if litOf i k u = 0 ∨ litOf k j (s - u) = 0 then 0 else andvar i j s k u

/-- value of the AND literal equals the conjunction of the two factor values -/
theorem litVal_andLitOf (G : Z3FpfGroupRing) (i j : Fin 33) (s : Fin 3)
    (k : Fin 33) (u : Fin 3) :
    litVal (baseAssign G) (andLitOf i j s k u) =
      (if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0) := by
  unfold andLitOf
  by_cases hz : litOf i k u = 0 ∨ litOf k j (s - u) = 0
  · rw [if_pos hz, litVal_false _ _ (evalLit_zero _)]
    rcases hz with h | h
    · obtain ⟨hk, hu⟩ := litOf_zero h
      have hz1 : G.S i k u = false := by
        rw [← hk, hu]; exact G.loopless i
      have hf : (if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0) = 0 := by
        rw [if_neg]
        intro hc
        rw [hz1] at hc
        simp at hc
      rw [hf]
    · obtain ⟨hk, hu⟩ := litOf_zero h
      have hz2 : G.S k j (s - u) = false := by
        rw [hk, hu]; exact G.loopless j
      have hf : (if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0) = 0 := by
        rw [if_neg]
        intro hc
        rw [hz2] at hc
        simp at hc
      rw [hf]
  · rw [if_neg hz]
    have hv : evalLit (baseAssign G) ((andvar i j s k u : Nat) : Int) =
        ((if G.S i k u then true else false) &&
          (if G.S k j (s - u) then true else false)) := by
      rw [evalLit_pos _ _ (by have := (andvar_bounds i j s k u).1; omega)]
      exact baseAssign_andvar G i j s k u
    unfold litVal
    rw [hv]
    by_cases h1 : G.S i k u = true <;> by_cases h2 : G.S k j (s - u) = true <;>
      simp [h1, h2]

-- ---------------------------------------------------------------------------
-- countLits list lemmas

theorem countLits_map (τ : Nat → Bool) {α : Type} (g : α → Lit) (l : List α) :
    countLits τ (l.map g) = (l.map fun x => litVal τ (g x)).sum := by
  induction l with
  | nil => rfl
  | cons x t ih =>
      rw [List.map_cons, countLits_cons, List.map_cons, List.sum_cons, ih]

theorem countLits_flatMap {α : Type} (τ : Nat → Bool) (f : α → List Lit) (l : List α) :
    countLits τ (l.flatMap f) = (l.map fun x => countLits τ (f x)).sum := by
  induction l with
  | nil => rfl
  | cons x t ih =>
      rw [List.flatMap_cons, countLits_append, List.map_cons, List.sum_cons, ih]

theorem countLits_filter_ne (τ : Nat → Bool) (l : List Lit) :
    countLits τ (l.filter fun x => decide (x ≠ 0)) = countLits τ l := by
  induction l with
  | nil => rfl
  | cons x t ih =>
      rw [List.filter_cons]
      by_cases hx : x = 0
      · rw [if_neg (by simp [hx])]
        subst hx
        rw [countLits_cons, litVal_false _ _ (evalLit_zero _), Nat.zero_add]
        exact ih
      · rw [if_pos (by simp [hx]), countLits_cons, countLits_cons, ih]

theorem map_filter_sum {α : Type} (l : List α) (p : α → Prop) [DecidablePred p]
    (g : α → Nat) :
    ((l.filter fun x => decide (p x)).map g).sum =
      (l.map fun x => if p x then g x else 0).sum := by
  induction l with
  | nil => rfl
  | cons x t ih =>
      rw [List.filter_cons]
      by_cases hx : p x
      · rw [if_pos (by simp [hx]), List.map_cons, List.sum_cons, List.map_cons,
            List.sum_cons, if_pos hx, ih]
      · rw [if_neg (by simp [hx]), List.map_cons, List.sum_cons, if_neg hx,
            Nat.zero_add, ih]

theorem map_congr_mem {α β : Type} {l : List α} {f g : α → β}
    (h : ∀ x ∈ l, f x = g x) : l.map f = l.map g := by
  induction l with
  | nil => rfl
  | cons x t ih =>
      rw [List.map_cons, List.map_cons, h x List.mem_cons_self,
          ih fun y hy => h y (List.mem_cons_of_mem _ hy)]

-- ---------------------------------------------------------------------------
-- Equation constraints

/-- AND literals of the product terms, with the constant-false ones removed -/
def eqTermLits (i j : Fin 33) (s : Fin 3) : List Lit :=
  ((List.finRange 33).flatMap fun k =>
    ((List.finRange 3).map fun u => andLitOf i j s k u)).filter fun x => decide (x ≠ 0)

/-- one unit per product term plus `litOf i j s` itself (μ − λ = 1) -/
def eqUnits (i j : Fin 33) (s : Fin 3) : List Lit :=
  eqTermLits i j s ++ (if litOf i j s = 0 then [] else [litOf i j s])

def eqBound (i j : Fin 33) (s : Fin 3) : Nat :=
  2 + 12 * (if i = j ∧ s = 0 then 1 else 0)

/-- the `i ≤ j` orbit pairs -/
def eqIJ : List (Fin 33 × Fin 33) :=
  (List.finRange 33).flatMap fun i =>
    ((List.finRange 33).filter fun j => decide (i.val ≤ j.val)).map fun j => (i, j)

/-- (bound, literals) spec per group-ring equation -/
def eqSpecs : List (Nat × List Lit) :=
  eqIJ.flatMap fun (i, j) =>
    (List.finRange 3).map fun s => (eqBound i j s, eqUnits i j s)

/-- three AND-gadget clauses per surviving product term -/
def andClauses : CNF :=
  eqIJ.flatMap fun (i, j) =>
    (List.finRange 3).flatMap fun s =>
      (List.finRange 33).flatMap fun k =>
        (List.finRange 3).flatMap fun u =>
          let a := litOf i k u
          let b := litOf k j (s - u)
          let p := (andvar i j s k u : Int)
          if a = 0 ∨ b = 0 then [] else [[-p, a], [-p, b], [p, -a, -b]]

/-- `d(i)` for `i < 27`, `¬d(i)` for `i ≥ 27` -/
def triUnits : CNF :=
  (List.finRange 33).map fun i => [if i.val < 27 then (dvar i : Lit) else -(dvar i : Lit)]

/-- gauge clauses `[x0, ¬x1]`, `[x0, ¬x2]` on `S 0 j ·`, `j ≥ 1` -/
def gaugeClauses : CNF :=
  ((List.finRange 33).filter fun j => decide (1 ≤ j.val)).flatMap fun j =>
    [[litOf 0 j 0, -litOf 0 j 1], [litOf 0 j 0, -litOf 0 j 2]]

/-- row-0 unit clauses fixing `S 0 j s` for `j ≥ 1` -/
def row0Clauses (n : Nat) : CNF :=
  ((List.finRange 33).filter fun j => decide (1 ≤ j.val)).flatMap fun j =>
    (List.finRange 3).map fun s =>
      [if s = 0 ∧ ((1 ≤ j.val ∧ j.val ≤ n) ∨ (27 ≤ j.val ∧ j.val < 27 + (12 - n)))
        then litOf 0 j s else -litOf 0 j s]

/-- the two S10 counting families -/
def s10Specs : List (Nat × List Lit) :=
  (((List.finRange 33).filter fun k => decide (k.val < 27)).map fun k =>
    (2, ((List.finRange 33).filter fun j => decide (27 ≤ j.val)).flatMap fun j =>
      (List.finRange 3).map fun s => litOf k j s))
  ++
  (((List.finRange 33).filter fun j => decide (27 ≤ j.val)).map fun j =>
    (5, ((List.finRange 33).filter fun k => decide (27 ≤ k.val ∧ k ≠ j)).flatMap fun k =>
      (List.finRange 3).map fun s => litOf j k s))

/-- total aux-variable demand of a spec list -/
def auxTotal (l : List (Nat × List Lit)) : Nat :=
  (l.map fun pr => eqAuxSize pr.2 pr.1).sum

def cnfB (n : Nat) : Nat × CNF :=
  let specs := allocSpecs eqSpecs baseVars
  (baseVars - 1 + auxTotal eqSpecs,
   andClauses ++ triUnits ++ gaugeClauses ++ row0Clauses n ++
     specs.flatMap fun sp => eqEncode sp.base sp.lits sp.b)

def cnfS10 : Nat × CNF :=
  let l := eqSpecs ++ s10Specs
  let specs := allocSpecs l baseVars
  (baseVars - 1 + auxTotal l,
   andClauses ++ triUnits ++ gaugeClauses ++ row0Clauses 10 ++
     specs.flatMap fun sp => eqEncode sp.base sp.lits sp.b)

-- ---------------------------------------------------------------------------
-- Literal bounds

theorem litOf_natAbs_le (i j : Fin 33) (s : Fin 3) :
    (litOf i j s).natAbs ≤ 3201 := by
  unfold litOf
  split
  · split
    · simp
    · rw [Int.natAbs_natCast]
      exact (dvar_bounds _).2
  · split
    · rw [Int.natAbs_natCast]
      rename_i hlt
      exact Nat.le_trans (xvar_le _ _ _ hlt) (by unfold xvarMax; omega)
    · rw [Int.natAbs_natCast]
      rename_i hlt hlt'
      have : j.val < i.val := by
        have : i.val ≠ j.val := by
          intro he; exact hlt (Fin.ext he)
        omega
      exact Nat.le_trans (xvar_le _ _ _ this) (by unfold xvarMax; omega)

theorem litVal_litOf (G : Z3FpfGroupRing) (i j : Fin 33) (s : Fin 3) :
    litVal (baseAssign G) (litOf i j s) = (if G.S i j s = true then 1 else 0) := by
  unfold litVal
  rw [evalLit_litOf]

-- ---------------------------------------------------------------------------
-- Equation-sum lemma

theorem countLits_eqUnits (G : Z3FpfGroupRing) (i j : Fin 33) (s : Fin 3) :
    countLits (baseAssign G) (eqUnits i j s) = eqBound i j s := by
  have hterms : countLits (baseAssign G) (eqTermLits i j s) =
      sumFin (fun k => sumFin (fun u =>
        if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0)) := by
    unfold eqTermLits
    rw [countLits_filter_ne, countLits_flatMap]
    show ((List.finRange 33).map fun k =>
        countLits (baseAssign G) ((List.finRange 3).map (andLitOf i j s k))).sum =
      ((List.finRange 33).map fun k =>
        ((List.finRange 3).map fun u =>
          if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0).sum).sum
    rw [map_congr_mem (l := List.finRange 33) (g := fun k =>
        ((List.finRange 3).map fun u =>
          if G.S i k u = true ∧ G.S k j (s - u) = true then 1 else 0).sum)
        (f := fun k => countLits (baseAssign G) ((List.finRange 3).map (andLitOf i j s k)))
        (h := fun k _ => by
          rw [countLits_map]
          exact congrArg List.sum
            (map_congr_mem (h := fun u _ => litVal_andLitOf G i j s k u)))]
  have hself : countLits (baseAssign G)
        (if litOf i j s = 0 then [] else [litOf i j s]) =
      (if G.S i j s = true then 1 else 0) := by
    by_cases h0 : litOf i j s = 0
    · rw [if_pos h0, countLits_nil]
      obtain ⟨hij, hs0⟩ := litOf_zero h0
      subst hij; subst hs0
      rw [if_neg (show ¬ (G.S i i 0 = true) by rw [G.loopless i]; decide)]
    · rw [if_neg h0, countLits_cons, countLits_nil, Nat.add_zero]
      exact litVal_litOf G i j s
  unfold eqUnits eqBound
  rw [countLits_append, hterms, hself]
  exact G.eq i j s

-- ---------------------------------------------------------------------------
-- Membership lemmas

theorem eqIJ_mem (ij : Fin 33 × Fin 33) (hm : ij ∈ eqIJ) :
    ij.1.val ≤ ij.2.val := by
  unfold eqIJ at hm
  rcases List.mem_flatMap.mp hm with ⟨i, _, hm2⟩
  rcases List.mem_map.mp hm2 with ⟨j, hjf, hij⟩
  rcases List.mem_filter.mp hjf with ⟨_, hle⟩
  rw [← hij]
  exact of_decide_eq_true hle

theorem eqSpecs_mem (pr : Nat × List Lit) (hm : pr ∈ eqSpecs) :
    ∃ i j s, i.val ≤ j.val ∧ pr = (eqBound i j s, eqUnits i j s) := by
  unfold eqSpecs at hm
  rcases List.mem_flatMap.mp hm with ⟨ij, hij, hm2⟩
  rcases List.mem_map.mp hm2 with ⟨s, _, hs4⟩
  unfold eqIJ at hij
  rcases List.mem_flatMap.mp hij with ⟨i, _, hij2⟩
  rcases List.mem_map.mp hij2 with ⟨j, hjf, hij3⟩
  rcases List.mem_filter.mp hjf with ⟨_, hle⟩
  exact ⟨i, j, s, of_decide_eq_true hle, by rw [← hs4, ← hij3]⟩

theorem eqUnits_ne_zero (i j : Fin 33) (s : Fin 3) (x : Lit)
    (hx : x ∈ eqUnits i j s) : x ≠ 0 := by
  unfold eqUnits eqTermLits at hx
  rcases List.mem_append.mp hx with h | h
  · rcases List.mem_filter.mp h with ⟨_, hnz⟩
    exact of_decide_eq_true hnz
  · by_cases h0 : litOf i j s = 0
    · rw [if_pos h0] at h; simp at h
    · rw [if_neg h0] at h
      rcases List.mem_cons.mp h with rfl | hn
      · exact h0
      · simp at hn

theorem eqUnits_natAbs_lt (i j : Fin 33) (s : Fin 3) (x : Lit)
    (hx : x ∈ eqUnits i j s) : x.natAbs < baseVars := by
  unfold eqUnits eqTermLits at hx
  rcases List.mem_append.mp hx with h | h
  · rcases List.mem_filter.mp h with ⟨hm, hnz⟩
    rcases List.mem_flatMap.mp hm with ⟨k, _, hm2⟩
    rcases List.mem_map.mp hm2 with ⟨u, _, hu⟩
    subst hu
    have hnz' : andLitOf i j s k u ≠ 0 := of_decide_eq_true hnz
    unfold andLitOf at hnz' ⊢
    rw [if_neg (fun hc => hnz' (if_pos hc)), Int.natAbs_natCast]
    exact (andvar_bounds i j s k u).2
  · by_cases h0 : litOf i j s = 0
    · rw [if_pos h0] at h; simp at h
    · rw [if_neg h0] at h
      rcases List.mem_cons.mp h with rfl | hn
      · exact Nat.lt_of_le_of_lt (litOf_natAbs_le i j s)
          (by unfold baseVars; omega)
      · simp at hn

theorem andClauses_mem (c : Clause) (hm : c ∈ andClauses) :
    ∃ i j s k u, i.val ≤ j.val ∧ litOf i k u ≠ 0 ∧ litOf k j (s - u) ≠ 0 ∧
      (c = [-(andvar i j s k u : Int), litOf i k u] ∨
       c = [-(andvar i j s k u : Int), litOf k j (s - u)] ∨
       c = [(andvar i j s k u : Int), -litOf i k u, -litOf k j (s - u)]) := by
  unfold andClauses at hm
  rcases List.mem_flatMap.mp hm with ⟨ij, hij, hm2⟩
  rcases List.mem_flatMap.mp hm2 with ⟨s, _, hm3⟩
  rcases List.mem_flatMap.mp hm3 with ⟨k, _, hm4⟩
  rcases List.mem_flatMap.mp hm4 with ⟨u, _, hm5⟩
  have hle := eqIJ_mem ij hij
  obtain ⟨i, j⟩ := ij
  by_cases hz : litOf i k u = 0 ∨ litOf k j (s - u) = 0
  · rw [if_pos hz] at hm5; simp at hm5
  · rw [if_neg hz] at hm5
    simp only [List.mem_cons, List.not_mem_nil, or_false] at hm5
    rcases hm5 with rfl | rfl | rfl
    · exact ⟨i, j, s, k, u, hle, fun hh => hz (Or.inl hh), fun hh => hz (Or.inr hh),
        Or.inl rfl⟩
    · exact ⟨i, j, s, k, u, hle, fun hh => hz (Or.inl hh), fun hh => hz (Or.inr hh),
        Or.inr (Or.inl rfl)⟩
    · exact ⟨i, j, s, k, u, hle, fun hh => hz (Or.inl hh), fun hh => hz (Or.inr hh),
        Or.inr (Or.inr rfl)⟩

-- ---------------------------------------------------------------------------
-- S10 spec lemmas

theorem s10Specs_mem (pr : Nat × List Lit) (hm : pr ∈ s10Specs) :
    (∃ k : Fin 33, k.val < 27 ∧ pr.1 = 2 ∧
      pr.2 = ((List.finRange 33).filter fun j => decide (27 ≤ j.val)).flatMap
        fun j => (List.finRange 3).map fun s => litOf k j s) ∨
    (∃ j : Fin 33, 27 ≤ j.val ∧ pr.1 = 5 ∧
      pr.2 = ((List.finRange 33).filter fun k => decide (27 ≤ k.val ∧ k ≠ j)).flatMap
        fun k => (List.finRange 3).map fun s => litOf j k s) := by
  unfold s10Specs at hm
  rcases List.mem_append.mp hm with h | h
  · rcases List.mem_map.mp h with ⟨k, hkf, hk⟩
    rcases List.mem_filter.mp hkf with ⟨_, hlt⟩
    exact Or.inl ⟨k, of_decide_eq_true hlt, by rw [← hk], by rw [← hk]⟩
  · rcases List.mem_map.mp h with ⟨j, hjf, hj⟩
    rcases List.mem_filter.mp hjf with ⟨_, hge⟩
    exact Or.inr ⟨j, of_decide_eq_true hge, by rw [← hj], by rw [← hj]⟩

theorem s10Specs_lits_ne_zero (pr : Nat × List Lit) (hm : pr ∈ s10Specs)
    (x : Lit) (hx : x ∈ pr.2) : x ≠ 0 := by
  rcases s10Specs_mem pr hm with ⟨k, _, _, hl⟩ | ⟨j, _, _, hl⟩
  · rw [hl] at hx
    rcases List.mem_flatMap.mp hx with ⟨j', _, hm2⟩
    rcases List.mem_map.mp hm2 with ⟨s', _, h3⟩
    subst h3
    rcases List.mem_filter.mp (by assumption : j' ∈ (List.finRange 33).filter fun j =>
        decide (27 ≤ j.val)) |>.2 with h27
    have hge : 27 ≤ j'.val := of_decide_eq_true h27
    have hne : k ≠ j' := fun hh => by subst hh; omega
    exact litOf_ne_zero hne
  · rw [hl] at hx
    rcases List.mem_flatMap.mp hx with ⟨k', hkf, hm2⟩
    rcases List.mem_map.mp hm2 with ⟨s', _, h3⟩
    subst h3
    rcases List.mem_filter.mp hkf with ⟨_, hpred⟩
    have hne : j ≠ k' := fun hh => (of_decide_eq_true hpred).2 hh.symm
    exact litOf_ne_zero hne

theorem s10Specs_lits_natAbs (pr : Nat × List Lit) (hm : pr ∈ s10Specs)
    (x : Lit) (hx : x ∈ pr.2) : x.natAbs < baseVars := by
  rcases s10Specs_mem pr hm with ⟨k, _, _, hl⟩ | ⟨j, _, _, hl⟩
  · rw [hl] at hx
    rcases List.mem_flatMap.mp hx with ⟨j', _, hm2⟩
    rcases List.mem_map.mp hm2 with ⟨s', _, h3⟩
    subst h3
    exact Nat.lt_of_le_of_lt (litOf_natAbs_le k j' s') (by unfold baseVars; omega)
  · rw [hl] at hx
    rcases List.mem_flatMap.mp hx with ⟨k', _, hm2⟩
    rcases List.mem_map.mp hm2 with ⟨s', _, h3⟩
    subst h3
    exact Nat.lt_of_le_of_lt (litOf_natAbs_le j k' s') (by unfold baseVars; omega)

/-- countLits over a filtered flatMap of Fin-3 literal groups equals the sumFin form -/
theorem countLits_pred_flatMap3 (τ : Nat → Bool) (p : Fin 33 → Prop) [DecidablePred p]
    (g : Fin 33 → Fin 3 → Lit) :
    countLits τ (((List.finRange 33).filter fun j => decide (p j)).flatMap
        fun j => (List.finRange 3).map (g j)) =
      sumFin (fun j => if p j then
        ((List.finRange 3).map fun s => litVal τ (g j s)).sum else 0) := by
  rw [countLits_flatMap]
  show (((List.finRange 33).filter fun j => decide (p j)).map
      fun j => countLits τ ((List.finRange 3).map (g j))).sum = _
  rw [map_filter_sum]
  have e : (List.finRange 33).map (fun j =>
      if p j then countLits τ ((List.finRange 3).map (g j)) else 0) =
    (List.finRange 33).map (fun j =>
      if p j then ((List.finRange 3).map fun s => litVal τ (g j s)).sum else 0) := by
    apply map_congr_mem
    intro j _
    by_cases hj : p j
    · rw [if_pos hj, if_pos hj, countLits_map]
    · rw [if_neg hj, if_neg hj]
  rw [e]
  rfl

theorem countLits_s10Specs (G : Z3FpfGroupRing) (pr : Nat × List Lit)
    (hm : pr ∈ s10Specs) (h : G.Count27) :
    countLits (baseAssign G) pr.2 = pr.1 := by
  rcases s10Specs_mem pr hm with ⟨k, hk, hb, hl⟩ | ⟨j, hj, hb, hl⟩
  · rw [hl, hb]
    have e := countLits_pred_flatMap3 (baseAssign G)
      (fun j => 27 ≤ j.val) (fun j s => litOf k j s)
    rw [e]
    have h1 := h.1 k hk
    rw [← h1]
    apply Z3FpfOrbitMatrix.sumFin_congr
    intro j'
    by_cases h27 : 27 ≤ j'.val
    · rw [if_pos h27, if_pos h27]
      apply congrArg List.sum
      apply map_congr_mem
      intro s' _
      exact litVal_litOf G k j' s'
    · rw [if_neg h27, if_neg h27]
  · rw [hl, hb]
    have e := countLits_pred_flatMap3 (baseAssign G)
      (fun k => 27 ≤ k.val ∧ k ≠ j) (fun k s => litOf j k s)
    rw [e]
    have h2 := h.2 j hj
    rw [← h2]
    apply Z3FpfOrbitMatrix.sumFin_congr
    intro k'
    by_cases hk : 27 ≤ k'.val ∧ k' ≠ j
    · rw [if_pos hk, if_pos hk]
      apply congrArg List.sum
      apply map_congr_mem
      intro s' _
      exact litVal_litOf G j k' s'
    · rw [if_neg hk, if_neg hk]

-- ---------------------------------------------------------------------------
-- Clause-level truth

theorem evalLit_neg_nat (τ : Nat → Bool) (v : Nat) (h : 0 < v) :
    evalLit τ (-(v : Int)) = !τ v := by
  rw [evalLit_neg τ (v : Int) (Int.ne_of_gt (Int.natCast_pos.mpr h)),
      evalLit_pos τ v h]

/-- `evalLit` on literals below `baseVars` is unchanged by the counter extension -/
theorem evalLit_ext (G : Z3FpfGroupRing) (l : List (Nat × List Lit)) (lit : Lit)
    (h : lit.natAbs < baseVars) :
    evalLit (extAll (baseAssign G) (allocSpecs l baseVars)) lit =
      evalLit (baseAssign G) lit :=
  evalLit_agree _ _ _ (extAll_low _ _ _ _ h)

theorem evalLit_litOf_ext (G : Z3FpfGroupRing) (l : List (Nat × List Lit))
    (i j : Fin 33) (s : Fin 3) :
    evalLit (extAll (baseAssign G) (allocSpecs l baseVars)) (litOf i j s) =
      G.S i j s := by
  rw [evalLit_ext G l _ (Nat.lt_of_le_of_lt (litOf_natAbs_le i j s)
    (by unfold baseVars; omega))]
  exact evalLit_litOf G i j s

theorem andClauses_true (G : Z3FpfGroupRing) (l : List (Nat × List Lit)) :
    evalCNF (extAll (baseAssign G) (allocSpecs l baseVars)) andClauses = true := by
  rw [evalCNF, List.all_eq_true]
  intro c hm
  obtain ⟨i, j, s, k, u, hle, ha0, hb0, hc⟩ := andClauses_mem c hm
  have ha : evalLit (extAll (baseAssign G) (allocSpecs l baseVars)) (litOf i k u) =
      G.S i k u := evalLit_litOf_ext G l i k u
  have hb : evalLit (extAll (baseAssign G) (allocSpecs l baseVars)) (litOf k j (s - u)) =
      G.S k j (s - u) := evalLit_litOf_ext G l k j (s - u)
  have hp : evalLit (extAll (baseAssign G) (allocSpecs l baseVars))
        ((andvar i j s k u : Nat) : Int) =
      ((if G.S i k u then true else false) &&
        (if G.S k j (s - u) then true else false)) := by
    rw [evalLit_ext G l _ (by rw [Int.natAbs_natCast]; exact (andvar_bounds i j s k u).2)]
    rw [evalLit_pos _ _ (by have := (andvar_bounds i j s k u).1; omega)]
    exact baseAssign_andvar G i j s k u
  have hnp : evalLit (extAll (baseAssign G) (allocSpecs l baseVars))
        (-(andvar i j s k u : Int)) =
      !((if G.S i k u then true else false) &&
        (if G.S k j (s - u) then true else false)) := by
    rw [evalLit_neg _ _ (Int.ne_of_gt (Int.natCast_pos.mpr
          (by have := (andvar_bounds i j s k u).1; omega))), hp]
  rcases hc with rfl | rfl | rfl
  · rw [evalClause, List.any_eq_true]
    by_cases hva : G.S i k u = true
    · exact ⟨litOf i k u, by simp, by rw [ha]; exact hva⟩
    · refine ⟨-(↑(andvar i j s k u)), by simp, ?_⟩
      rw [hnp]; simp [hva]
  · rw [evalClause, List.any_eq_true]
    by_cases hvb : G.S k j (s - u) = true
    · exact ⟨litOf k j (s - u), by simp, by rw [hb]; exact hvb⟩
    · refine ⟨-(↑(andvar i j s k u)), by simp, ?_⟩
      rw [hnp]; simp [hvb]
  · rw [evalClause, List.any_eq_true]
    by_cases hva : G.S i k u = true
    · by_cases hvb : G.S k j (s - u) = true
      · refine ⟨(↑(andvar i j s k u)), by simp, ?_⟩
        rw [hp]; simp [hva, hvb]
      · refine ⟨-litOf k j (s - u), by simp, ?_⟩
        rw [evalLit_neg _ _ hb0, hb]; simp [hvb]
    · refine ⟨-litOf i k u, by simp, ?_⟩
      rw [evalLit_neg _ _ ha0, ha]; simp [hva]

theorem triUnits_true (G : Z3FpfGroupRing) (l : List (Nat × List Lit))
    (h : G.Tri27) :
    evalCNF (extAll (baseAssign G) (allocSpecs l baseVars)) triUnits = true := by
  rw [evalCNF, List.all_eq_true]
  intro c hm
  unfold triUnits at hm
  rcases List.mem_map.mp hm with ⟨i, _, hc⟩
  subst hc
  rw [evalClause, List.any_eq_true]
  have hd : extAll (baseAssign G) (allocSpecs l baseVars) (dvar i) = G.S i i 1 := by
    have e := evalLit_ext G l (dvar i : Int)
      (by rw [Int.natAbs_natCast]
          exact Nat.lt_of_le_of_lt (dvar_bounds i).2 (by unfold dvarMax baseVars; omega))
    rw [evalLit_pos _ _ (by unfold dvar; omega),
        evalLit_pos _ _ (by unfold dvar; omega)] at e
    exact e.trans (baseAssign_dvar G i)
  by_cases hlt : i.val < 27
  · refine ⟨(dvar i : Int), by rw [if_pos hlt]; simp, ?_⟩
    rw [evalLit_pos _ _ (by unfold dvar; omega), hd]
    exact (h i).mpr hlt
  · refine ⟨-(dvar i : Int), by rw [if_neg hlt]; simp, ?_⟩
    rw [evalLit_neg_nat _ _ (by unfold dvar; omega), hd]
    have hs : G.S i i 1 = false := by
      cases hsv : G.S i i 1
      · rfl
      · exact absurd ((h i).mp hsv) hlt
    rw [hs]
    rfl

theorem gaugeClauses_true (G : Z3FpfGroupRing) (l : List (Nat × List Lit))
    (h : G.Gauge) :
    evalCNF (extAll (baseAssign G) (allocSpecs l baseVars)) gaugeClauses = true := by
  rw [evalCNF, List.all_eq_true]
  intro c hm
  unfold gaugeClauses at hm
  rcases List.mem_flatMap.mp hm with ⟨j, hjf, hm2⟩
  rcases List.mem_filter.mp hjf with ⟨_, hj1⟩
  have hj : 1 ≤ j.val := of_decide_eq_true hj1
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hm2
  rcases hm2 with rfl | rfl
  · rw [evalClause, List.any_eq_true]
    by_cases h1 : G.S 0 j 1 = true
    · refine ⟨litOf 0 j 0, by simp, ?_⟩
      rw [evalLit_litOf_ext]
      exact h j hj (Or.inl h1)
    · refine ⟨-litOf 0 j 1, by simp, ?_⟩
      rw [evalLit_neg _ _ (litOf_ne_zero (Fin.ne_of_val_ne (by simp; omega))),
          evalLit_litOf_ext]
      cases hsv : G.S 0 j 1
      · rfl
      · exact absurd hsv h1
  · rw [evalClause, List.any_eq_true]
    by_cases h2 : G.S 0 j 2 = true
    · refine ⟨litOf 0 j 0, by simp, ?_⟩
      rw [evalLit_litOf_ext]
      exact h j hj (Or.inr h2)
    · refine ⟨-litOf 0 j 2, by simp, ?_⟩
      rw [evalLit_neg _ _ (litOf_ne_zero (Fin.ne_of_val_ne (by simp; omega))),
          evalLit_litOf_ext]
      cases hsv : G.S 0 j 2
      · rfl
      · exact absurd hsv h2

theorem row0Clauses_true (G : Z3FpfGroupRing) (l : List (Nat × List Lit)) (n : Nat)
    (h : G.Row0 n) :
    evalCNF (extAll (baseAssign G) (allocSpecs l baseVars)) (row0Clauses n) = true := by
  rw [evalCNF, List.all_eq_true]
  intro c hm
  unfold row0Clauses at hm
  rcases List.mem_flatMap.mp hm with ⟨j, hjf, hm2⟩
  rcases List.mem_filter.mp hjf with ⟨_, hj1⟩
  have hj : 1 ≤ j.val := of_decide_eq_true hj1
  rcases List.mem_map.mp hm2 with ⟨s, _, hc⟩
  subst hc
  rw [evalClause, List.any_eq_true]
  have hS := h j hj s
  have hev : evalLit (extAll (baseAssign G) (allocSpecs l baseVars)) (litOf 0 j s) =
      G.S 0 j s := evalLit_litOf_ext G l 0 j s
  by_cases hm' : s = 0 ∧
      ((1 ≤ j.val ∧ j.val ≤ n) ∨ (27 ≤ j.val ∧ j.val < 27 + (12 - n)))
  · refine ⟨litOf 0 j s, by rw [if_pos hm']; simp, ?_⟩
    rw [hev]
    exact hS.mpr hm'
  · refine ⟨-litOf 0 j s, by rw [if_neg hm']; simp, ?_⟩
    rw [evalLit_neg _ _ (litOf_ne_zero (Fin.ne_of_val_ne (by simp; omega))), hev]
    have hs : G.S 0 j s = false := by
      cases hsv : G.S 0 j s
      · rfl
      · exact absurd (hS.mp hsv) hm'
    rw [hs]
    rfl

-- ---------------------------------------------------------------------------
-- Spec-list hypotheses for `allocBlock_true`

theorem eqSpecs_lits_ne_zero (pr : Nat × List Lit) (hm : pr ∈ eqSpecs)
    (x : Lit) (hx : x ∈ pr.2) : x ≠ 0 := by
  obtain ⟨i, j, s, _, hpr⟩ := eqSpecs_mem pr hm
  rw [hpr] at hx
  exact eqUnits_ne_zero i j s x hx

theorem eqSpecs_lits_natAbs (pr : Nat × List Lit) (hm : pr ∈ eqSpecs)
    (x : Lit) (hx : x ∈ pr.2) : x.natAbs < baseVars := by
  obtain ⟨i, j, s, _, hpr⟩ := eqSpecs_mem pr hm
  rw [hpr] at hx
  exact eqUnits_natAbs_lt i j s x hx

theorem eqSpecs_count (G : Z3FpfGroupRing) (pr : Nat × List Lit) (hm : pr ∈ eqSpecs) :
    countLits (baseAssign G) pr.2 = pr.1 := by
  obtain ⟨i, j, s, _, hpr⟩ := eqSpecs_mem pr hm
  rw [hpr]
  exact countLits_eqUnits G i j s

-- ---------------------------------------------------------------------------
-- Soundness

theorem cnfB_sound (n : Nat) (G : Z3FpfGroupRing) (h : G.SysB n) :
    Satisfiable (cnfB n).2 := by
  obtain ⟨htri, hgauge, hrow⟩ := h
  refine ⟨extAll (baseAssign G) (allocSpecs eqSpecs baseVars), ?_⟩
  show evalCNF _ (andClauses ++ triUnits ++ gaugeClauses ++ row0Clauses n ++
      ((allocSpecs eqSpecs baseVars).flatMap
        fun sp => eqEncode sp.base sp.lits sp.b)) = true
  rw [evalCNF_append, evalCNF_append, evalCNF_append, evalCNF_append]
  simp only [Bool.and_eq_true]
  refine ⟨⟨⟨⟨andClauses_true G eqSpecs, triUnits_true G eqSpecs htri⟩,
    gaugeClauses_true G eqSpecs hgauge⟩, row0Clauses_true G eqSpecs n hrow⟩,
    allocBlock_true (baseAssign G) eqSpecs baseVars
      eqSpecs_lits_natAbs (by unfold baseVars; omega)
      eqSpecs_lits_ne_zero (fun pr hpr => eqSpecs_count G pr hpr)⟩

theorem cnfS10_sound (G : Z3FpfGroupRing) (h : G.SysS10) :
    Satisfiable cnfS10.2 := by
  obtain ⟨⟨htri, hgauge, hrow⟩, hcnt⟩ := h
  refine ⟨extAll (baseAssign G) (allocSpecs (eqSpecs ++ s10Specs) baseVars), ?_⟩
  show evalCNF _ (andClauses ++ triUnits ++ gaugeClauses ++ row0Clauses 10 ++
      ((allocSpecs (eqSpecs ++ s10Specs) baseVars).flatMap
        fun sp => eqEncode sp.base sp.lits sp.b)) = true
  rw [evalCNF_append, evalCNF_append, evalCNF_append, evalCNF_append]
  simp only [Bool.and_eq_true]
  refine ⟨⟨⟨⟨andClauses_true G (eqSpecs ++ s10Specs),
    triUnits_true G (eqSpecs ++ s10Specs) htri⟩,
    gaugeClauses_true G (eqSpecs ++ s10Specs) hgauge⟩,
    row0Clauses_true G (eqSpecs ++ s10Specs) 10 hrow⟩,
    allocBlock_true (baseAssign G) (eqSpecs ++ s10Specs) baseVars
       (fun pr hpr x hx => by
         rcases List.mem_append.mp hpr with he | hs
         · exact eqSpecs_lits_natAbs pr he x hx
         · exact s10Specs_lits_natAbs pr hs x hx)
       (by unfold baseVars; omega)
       (fun pr hpr x hx => by
         rcases List.mem_append.mp hpr with he | hs
         · exact eqSpecs_lits_ne_zero pr he x hx
         · exact s10Specs_lits_ne_zero pr hs x hx)
       (fun pr hpr => by
         rcases List.mem_append.mp hpr with he | hs
         · exact eqSpecs_count G pr he
         · exact countLits_s10Specs G pr hs hcnt)⟩

/-- Conditional exclusion of the `t = 27` fixed-point-free order-3 branch,
    reduced to the non-satisfiability of the six exported CNFs. -/
theorem conway_no_z3_fpf_t27_of_cnf
    (h6 : ¬ Satisfiable (cnfB 6).2) (h7 : ¬ Satisfiable (cnfB 7).2)
    (h8 : ¬ Satisfiable (cnfB 8).2) (h9 : ¬ Satisfiable (cnfB 9).2)
    (h11 : ¬ Satisfiable (cnfB 11).2) (h10 : ¬ Satisfiable cnfS10.2) :
    ¬ ∃ (A : Matrix99 Nat), ConwayAdj A ∧ ∃ g : Fin 99 → Fin 99,
      IsZ3FpfAutomorphism A g ∧
      sumFin (fun x : Fin 99 => if A x (g x) = 1 then (1 : Nat) else 0) = 81 :=
  conway_no_z3_fpf_t27
    (fun ⟨G, hG⟩ => h6 (cnfB_sound 6 G hG))
    (fun ⟨G, hG⟩ => h7 (cnfB_sound 7 G hG))
    (fun ⟨G, hG⟩ => h8 (cnfB_sound 8 G hG))
    (fun ⟨G, hG⟩ => h9 (cnfB_sound 9 G hG))
    (fun ⟨G, hG⟩ => h11 (cnfB_sound 11 G hG))
    (fun ⟨G, hG⟩ => h10 (cnfS10_sound G hG))

end CnfT27
end Z3FpfGroupRing
end Matrix99
