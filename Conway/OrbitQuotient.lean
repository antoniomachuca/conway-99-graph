import Conway.Structural
import Init.Data.List.Find
import Init.Data.List.Perm
import Init.Data.List.Nat.Sum

namespace ConwayOrbit

open Function

def sumFin {n : Nat} (f : Fin n → Nat) : Nat :=
  ((List.finRange n).map f).sum

theorem nodup_map_injective {α β : Type} (f : α → β)
    {l : List α} (hnd : l.Nodup) (hinj : ∀ a b, f a = f b → a = b) :
    (l.map f).Nodup := by
  induction l with
  | nil => exact List.nodup_nil
  | cons a t ih =>
    simp only [List.map_cons]
    rw [List.nodup_cons] at hnd ⊢
    refine ⟨?_, ih hnd.2⟩
    intro hb
    have ⟨c, hc, hfc⟩ := List.mem_map.mp hb
    have hab : a = c := hinj _ _ hfc.symm
    exact hnd.1 (hab ▸ hc)

theorem perm_of_nodup_same_members {α : Type} {l₁ l₂ : List α}
    (h₁ : l₁.Nodup) (hsub : ∀ x, x ∈ l₁ → x ∈ l₂)
    (hlen : l₁.length = l₂.length) : List.Perm l₁ l₂ := by
  induction l₁ generalizing l₂ with
  | nil =>
    have : l₂.length = 0 := by simpa using hlen.symm
    exact (List.eq_nil_of_length_eq_zero this).symm ▸ List.Perm.rfl
  | cons a t ih =>
    rw [List.nodup_cons] at h₁
    have ha : a ∈ l₂ := hsub a (List.mem_cons_self)
    obtain ⟨pre, post, hsplit⟩ := List.append_of_mem ha
    have htail_sub : ∀ x, x ∈ t → x ∈ pre ++ post := by
      intro x hx
      have hx₂ := hsub x (List.mem_cons_of_mem a hx)
      rw [hsplit] at hx₂
      simp at hx₂
      rcases hx₂ with hx₂ | hx₂
      · exact List.mem_append_left _ hx₂
      · rcases hx₂ with rfl | hx₂
        · exact False.elim (h₁.1 hx)
        · exact List.mem_append_right _ hx₂
    have htail_len : t.length = (pre ++ post).length := by
      rw [hsplit] at hlen
      simp only [List.length_cons, List.length_append] at hlen ⊢
      omega
    have htail_perm : List.Perm t (pre ++ post) := ih h₁.2 htail_sub htail_len
    rw [hsplit]
    exact htail_perm.cons a |>.trans (List.perm_middle.symm)

theorem perm_map_finRange {n : Nat} (f : Fin n → Fin n)
    (hinj : ∀ a b, f a = f b → a = b)
    (_hsurj : ∀ y, ∃ x, f x = y) :
    List.Perm ((List.finRange n).map f) (List.finRange n) := by
  apply perm_of_nodup_same_members
  · exact nodup_map_injective f (List.nodup_finRange n) hinj
  · intro x hx
    have ⟨a, ha, hax⟩ := List.mem_map.mp hx
    exact hax ▸ List.mem_finRange x
  · simp [List.length_map]

theorem sum_map_zero {α : Type} (l : List α) :
    (l.map (fun _ : α => 0)).sum = 0 := by
  induction l <;> simp_all

theorem sum_map_mul_right {α : Type} (l : List α) (f : α → Nat) (c : Nat) :
    (l.map (fun x => f x * c)).sum = (l.map f).sum * c := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    simp only [List.map_cons, List.sum_cons]
    rw [ih, Nat.add_mul]

theorem sum_map_mul_left {α : Type} (l : List α) (c : Nat) (f : α → Nat) :
    (l.map (fun x => c * f x)).sum = c * (l.map f).sum := by
  induction l with
  | nil => rfl
  | cons x xs ih =>
    simp only [List.map_cons, List.sum_cons]
    rw [ih, Nat.mul_add]

theorem sum_map_add {α : Type} (l : List α) (f g : α → Nat) :
    (l.map (fun x => f x + g x)).sum = (l.map f).sum + (l.map g).sum := by
  induction l with
  | nil => rfl
  | cons x xs ih =>
    simp only [List.map_cons, List.sum_cons]
    rw [ih]
    omega

theorem sum_swap {α β : Type} (l₁ : List α) (l₂ : List β)
    (f : α → β → Nat) :
    (l₁.map (fun a => (l₂.map (fun b => f a b)).sum)).sum =
      (l₂.map (fun b => (l₁.map (fun a => f a b)).sum)).sum := by
  induction l₁ with
  | nil =>
    simp only [List.map_nil, List.sum_nil]
    induction l₂ with
    | nil => rfl
    | cons b bs ih =>
      simpa only [List.map_cons, List.sum_cons, List.map_nil, List.sum_nil,
        Nat.zero_add] using ih
  | cons a as ih =>
    simp only [List.map_cons, List.sum_cons]
    rw [ih]
    have hadd := sum_map_add l₂ (fun b => f a b)
      (fun b => (as.map (fun x => f x b)).sum)
    rw [← hadd]


def SameOrbit {n : Nat} (p : Nat) (s : Fin n → Fin n) (u v : Fin n) : Prop :=
  ∃ k : Fin p, s^[k.val] u = v

instance sameOrbitDecidable {n : Nat} (p : Nat) (s : Fin n → Fin n) (u v : Fin n) :
    Decidable (SameOrbit p s u v) := by
  unfold SameOrbit
  infer_instance

def orbitLabel {n : Nat} (p : Nat) (s : Fin n → Fin n) (u : Fin n) : Fin n :=
  ((List.finRange n).find? (fun v => decide (SameOrbit p s u v))).getD u

def fiberSum {n : Nat} (label : Fin n → Fin n) (f : Fin n → Nat) (j : Fin n) : Nat :=
  sumFin (fun v => if label v = j then f v else 0)

def fiberSize {n : Nat} (label : Fin n → Fin n) (j : Fin n) : Nat :=
  fiberSum label (fun _ => 1) j

theorem sum_indicator_list {α : Type} [DecidableEq α] {l : List α}
    (hnd : l.Nodup) (a : α) (z : Nat) :
    (l.map (fun x => if x = a then z else 0)).sum = if a ∈ l then z else 0 := by
  induction l with
  | nil => simp
  | cons x xs ih =>
    rw [List.nodup_cons] at hnd
    simp only [List.map_cons, List.sum_cons, List.mem_cons]
    by_cases hxa : x = a
    · subst hxa
      have ih' := ih hnd.2
      simp [hnd.1] at ih'
      simp [hnd.1, ih']
    · have hax : a ≠ x := Ne.symm hxa
      have ih' := ih hnd.2
      simp [hxa, hax, ih']

theorem fiber_sum_partition {n : Nat} (label : Fin n → Fin n)
    (f : Fin n → Nat) : sumFin (fiberSum label f) = sumFin f := by
  change ((List.finRange n).map (fun j =>
      ((List.finRange n).map (fun v => if label v = j then f v else 0)).sum)).sum =
    ((List.finRange n).map f).sum
  rw [← sum_swap]
  have hmap : ((List.finRange n).map (fun v =>
      ((List.finRange n).map (fun j => if label v = j then f v else 0)).sum)).sum =
      ((List.finRange n).map f).sum := by
    apply congrArg List.sum
    apply List.map_congr_left
    intro v hv
    have hs := sum_indicator_list (List.nodup_finRange n) (label v) (f v)
    simpa [eq_comm] using hs
  rw [hmap]

theorem sumFin_mul_right {n : Nat} (f : Fin n → Nat) (c : Nat) :
    sumFin (fun x => f x * c) = sumFin f * c := by
  unfold sumFin
  rw [sum_map_mul_right]

theorem sumFin_mul_left {n : Nat} (c : Nat) (f : Fin n → Nat) :
    sumFin (fun x => c * f x) = c * sumFin f := by
  unfold sumFin
  rw [sum_map_mul_left]

theorem sumFin_swap {n : Nat} (f : Fin n → Fin n → Nat) :
    sumFin (fun u => sumFin (fun v => f u v)) =
      sumFin (fun v => sumFin (fun u => f u v)) := by
  unfold sumFin
  exact sum_swap (List.finRange n) (List.finRange n) f

theorem fiberSum_add {n : Nat} (label : Fin n → Fin n) (f g : Fin n → Nat) (j : Fin n) :
    fiberSum label (fun v => f v + g v) j = fiberSum label f j + fiberSum label g j := by
  unfold fiberSum sumFin
  rw [← sum_map_add]
  apply congrArg List.sum
  apply List.map_congr_left
  intro v hv
  by_cases h : label v = j <;> simp [h]

theorem fiberSum_const {n : Nat} (label : Fin n → Fin n) (c : Nat) (j : Fin n) :
    fiberSum label (fun _ => c) j = fiberSize label j * c := by
  unfold fiberSize fiberSum sumFin
  rw [← sum_map_mul_right]
  apply congrArg List.sum
  apply List.map_congr_left
  intro v hv
  by_cases h : label v = j <;> simp [h]

theorem fiberSum_delta {n : Nat} (label : Fin n → Fin n) (i j : Fin n) (c : Nat) :
    fiberSum label (fun v => if i = v then c else 0) j =
      if label i = j then c else 0 := by
  unfold fiberSum sumFin
  by_cases hij : label i = j
  · rw [if_pos hij]
    have hs : ((List.finRange n).map (fun v => if i = v then c else 0)).sum = c := by
      have hs' := sum_indicator_list (List.nodup_finRange n) i c
      have hi : i ∈ List.finRange n := List.mem_finRange i
      have hmapeq : (List.finRange n).map (fun v => if i = v then c else 0) =
          (List.finRange n).map (fun v => if v = i then c else 0) := by
        apply List.map_congr_left
        intro v hv
        by_cases h : i = v
        · simp [h]
        · have hne : v ≠ i := fun hv => h hv.symm
          simp [h, hne]
      rw [hmapeq]
      simpa [hi] using hs'
    calc
      (List.map (fun v => if label v = j then (if i = v then c else 0) else 0)
        (List.finRange n)).sum =
          (List.map (fun v => if i = v then c else 0) (List.finRange n)).sum := by
            apply congrArg List.sum
            apply List.map_congr_left
            intro v hv
            by_cases hiv : i = v
            · subst hiv
              simp [hij]
            · simp [hiv]
      _ = c := hs
  · rw [if_neg hij]
    calc
      (List.map (fun v => if label v = j then (if i = v then c else 0) else 0)
        (List.finRange n)).sum =
          (List.map (fun _ : Fin n => 0) (List.finRange n)).sum := by
            apply congrArg List.sum
            apply List.map_congr_left
            intro v hv
            by_cases hiv : i = v
            · subst hiv
              simp [hij]
            · simp [hiv]
      _ = 0 := sum_map_zero (List.finRange n)

theorem fiberSum_weighted {n : Nat} (label : Fin n → Fin n)
    (f g : Fin n → Nat) :
    sumFin (fun r => fiberSum label f r * g r) =
      sumFin (fun w => f w * g (label w)) := by
  have hdist : sumFin (fun r => fiberSum label f r * g r) =
      sumFin (fun r => sumFin (fun w => if label w = r then f w else 0) * g r) := by
    apply congrArg sumFin
    funext r
    rw [fiberSum]
  rw [hdist]
  have hdouble : sumFin (fun r => sumFin (fun w => if label w = r then f w else 0) * g r) =
      sumFin (fun r => sumFin (fun w => (if label w = r then f w else 0) * g r)) := by
    apply congrArg sumFin
    funext r
    rw [sumFin_mul_right]
  rw [hdouble, sumFin_swap]
  apply congrArg sumFin
  funext w
  have hdelta : sumFin (fun r => (if label w = r then f w else 0) * g r) =
      f w * g (label w) := by
    unfold sumFin
    have hs : ((List.finRange n).map (fun r => if r = label w then f w * g (label w) else 0)).sum =
        f w * g (label w) := by
      simpa using sum_indicator_list (List.nodup_finRange n) (label w) (f w * g (label w))
    calc
      (List.map (fun r => (if label w = r then f w else 0) * g r) (List.finRange n)).sum =
          (List.map (fun r => if r = label w then f w * g (label w) else 0)
            (List.finRange n)).sum := by
              apply congrArg List.sum
              apply List.map_congr_left
              intro r hr
              by_cases h : r = label w
              · subst h
                simp
              · have h' : label w ≠ r := fun h'' => h h''.symm
                simp [h, h']
      _ = f w * g (label w) := hs
  exact hdelta

structure EquitableData {n : Nat} (A : Fin n → Fin n → Nat) where
  label : Fin n → Fin n
  idempotent : ∀ u, label (label u) = label u
  invariant_counts : ∀ u j, fiberSum label (A u) j = fiberSum label (A (label u)) j

def EquitableData.entry {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (i j : Fin n) : Nat :=
  if q.label i = i then fiberSum q.label (A i) j else 0

theorem iterate_succ_apply {α : Sort _} (f : α → α) (n : Nat) (x : α) :
    f^[n + 1] x = f^[n] (f x) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change f (f^[n + 1] x) = f (f^[n] (f x))
    rw [ih]

theorem iterate_add_apply {α : Sort _} (f : α → α) (m n : Nat) (x : α) :
    f^[m + n] x = f^[m] (f^[n] x) := by
  induction m with
  | zero => simp [Nat.zero_add, Function.iterate]
  | succ m ih =>
    rw [Nat.succ_add]
    change f (f^[m + n] x) = f (f^[m] (f^[n] x))
    rw [ih]

theorem iterate_mod_period {α : Sort _} (p : Nat) (hp : 0 < p) (f : α → α)
    (hperiod : f^[p] = id) (k : Nat) (x : α) :
    f^[k] x = f^[k % p] x := by
  induction k using Nat.strongRecOn with
  | ind k ih =>
    by_cases hk : k < p
    · rw [Nat.mod_eq_of_lt hk]
    · have hkp : p ≤ k := Nat.le_of_not_gt hk
      rw [← Nat.sub_add_cancel hkp, iterate_add_apply, hperiod]
      simp only [id_eq]
      rw [Nat.sub_add_cancel hkp, Nat.mod_eq_sub_mod hkp]
      exact ih (k - p) (by omega)

theorem sameOrbit_refl {n p : Nat} (hp : 0 < p) {s : Fin n → Fin n} (u : Fin n) :
    SameOrbit p s u u := ⟨⟨0, hp⟩, rfl⟩

theorem sameOrbit_symm {n p : Nat} (hp : 0 < p) {s : Fin n → Fin n}
    (hperiod : s^[p] = id) {u v : Fin n} :
    SameOrbit p s u v → SameOrbit p s v u := by
  intro huv
  obtain ⟨k, hk⟩ := huv
  let r := (p - k.val) % p
  have hru : s^[r] v = u := by
    calc
      s^[r] v = s^[r] (s^[k.val] u) := by rw [hk]
      _ = s^[r + k.val] u := (iterate_add_apply s r k.val u).symm
      _ = s^[(r + k.val) % p] u := iterate_mod_period p hp s hperiod (r + k.val) u
      _ = u := by
        have hklt : k.val < p := k.isLt
        by_cases hk0 : k.val = 0
        · simp [r, hk0, Function.iterate]
        · have hsublt : p - k.val < p := by omega
          have hr : r = p - k.val := by
            dsimp [r]
            rw [Nat.mod_eq_of_lt hsublt]
          have hrsum : r + k.val = p := by omega
          rw [hrsum, Nat.mod_self]
          rfl
  exact ⟨⟨r, Nat.mod_lt _ hp⟩, hru⟩

theorem sameOrbit_trans {n p : Nat} (hp : 0 < p) {s : Fin n → Fin n}
    (hperiod : s^[p] = id) {u v w : Fin n} :
    SameOrbit p s u v → SameOrbit p s v w → SameOrbit p s u w := by
  intro huv hvw
  obtain ⟨k, hk⟩ := huv
  obtain ⟨l, hl⟩ := hvw
  refine ⟨⟨(k.val + l.val) % p, Nat.mod_lt _ hp⟩, ?_⟩
  calc
    s^[(k.val + l.val) % p] u = s^[k.val + l.val] u :=
      (iterate_mod_period p hp s hperiod (k.val + l.val) u).symm
    _ = s^[l.val + k.val] u := by rw [Nat.add_comm]
    _ = s^[l.val] (s^[k.val] u) := iterate_add_apply s l.val k.val u
    _ = s^[l.val] v := by rw [hk]
    _ = w := hl

theorem orbitLabel_mem {n p : Nat} (hp : 0 < p) (s : Fin n → Fin n)
    (_hperiod : s^[p] = id) (u : Fin n) :
    SameOrbit p s u (orbitLabel p s u) := by
  unfold orbitLabel
  cases hfind : (List.finRange n).find? (fun v => decide (SameOrbit p s u v)) with
  | none => exact sameOrbit_refl hp u
  | some v =>
    have hpred := List.find?_some hfind
    simpa using hpred


theorem orbitLabel_eq_iff {n p : Nat} (hp : 0 < p) (s : Fin n → Fin n)
    (hperiod : s^[p] = id) (u v : Fin n) :
    orbitLabel p s u = orbitLabel p s v ↔ SameOrbit p s u v := by
  constructor
  · intro hlabel
    exact sameOrbit_trans hp hperiod (orbitLabel_mem hp s hperiod u)
      (hlabel ▸ sameOrbit_symm hp hperiod (orbitLabel_mem hp s hperiod v))
  · intro horbit
    have hpred : (fun x => decide (SameOrbit p s u x)) =
        (fun x => decide (SameOrbit p s v x)) := by
      funext x
      have hiff : SameOrbit p s u x ↔ SameOrbit p s v x := by
        constructor
        · intro hux
          exact sameOrbit_trans hp hperiod (sameOrbit_symm hp hperiod horbit) hux
        · intro hvx
          exact sameOrbit_trans hp hperiod horbit hvx
      by_cases hux : SameOrbit p s u x
      · have hvx := hiff.mp hux
        simp [hux, hvx]
      · have hvx : ¬ SameOrbit p s v x := by
          intro h
          exact hux (hiff.mpr h)
        simp [hux, hvx]
    unfold orbitLabel
    rw [hpred]
    let F := (List.finRange n).find? (fun x => decide (SameOrbit p s v x))
    have hF : F ≠ none := by
      intro hnone
      have hnone' := List.find?_eq_none.mp hnone
      have hu := hnone' v (List.mem_finRange v)
      have htrue : decide (SameOrbit p s v v) = true := by
        simp [sameOrbit_refl hp v]
      exact hu htrue
    change F.getD u = F.getD v
    cases h : F with
    | none => exact False.elim (hF h)
    | some x => rfl

theorem sameOrbit_succ {n p : Nat} (hp : 0 < p) (s : Fin n → Fin n)
    (hperiod : s^[p] = id) (u : Fin n) :
    SameOrbit p s u (s u) := by
  by_cases hpone : p = 1
  · subst hpone
    have hs : s = id := by
      funext x
      simpa [Function.iterate] using congrFun hperiod x
    rw [hs]
    exact sameOrbit_refl hp u
  · exact ⟨⟨1, by omega⟩, rfl⟩

theorem orbitLabel_idempotent {n p : Nat} (hp : 0 < p) (s : Fin n → Fin n)
    (hperiod : s^[p] = id) (u : Fin n) :
    orbitLabel p s (orbitLabel p s u) = orbitLabel p s u := by
  apply (orbitLabel_eq_iff hp s hperiod (orbitLabel p s u) u).mpr
  exact sameOrbit_symm hp hperiod (orbitLabel_mem hp s hperiod u)

theorem orbitLabel_succ {n p : Nat} (hp : 0 < p) (s : Fin n → Fin n)
    (hperiod : s^[p] = id) (u : Fin n) :
    orbitLabel p s (s u) = orbitLabel p s u := by
  apply (orbitLabel_eq_iff hp s hperiod (s u) u).mpr
  exact sameOrbit_symm hp hperiod (sameOrbit_succ hp s hperiod u)

theorem iterate_bijective {n p : Nat} (hp : 0 < p) (s : Fin n → Fin n)
    (hperiod : s^[p] = id) : Function.Bijective s := by
  let inv := s^[p - 1]
  have hleft : ∀ x, inv (s x) = x := by
    intro x
    dsimp [inv]
    change s^[p - 1] (s^[1] x) = x
    rw [← iterate_add_apply s (p - 1) 1 x]
    rw [show p - 1 + 1 = p by omega, hperiod]
    rfl
  have hright : ∀ x, s (inv x) = x := by
    intro x
    dsimp [inv]
    change s^[1] (s^[p - 1] x) = x
    rw [← iterate_add_apply s 1 (p - 1) x]
    rw [show 1 + (p - 1) = p by omega, hperiod]
    rfl
  refine ⟨?_, ?_⟩
  · intro x y hxy
    have := congrArg inv hxy
    simpa [hleft] using this
  · intro y
    exact ⟨inv y, hright y⟩

theorem sumFin_comp_eq {n : Nat} (s : Fin n → Fin n)
    (hinj : ∀ a b, s a = s b → a = b) (hsurj : ∀ y, ∃ x, s x = y)
    (f : Fin n → Nat) :
    sumFin (fun x => f (s x)) = sumFin f := by
  unfold sumFin
  have hmap : ((List.finRange n).map s).map f =
      (List.finRange n).map (fun x => f (s x)) := by
    simp [List.map_map, Function.comp_def]
  rw [← hmap]
  rw [List.sum_eq_foldl_nat, List.sum_eq_foldl_nat]
  apply (perm_map_finRange s hinj hsurj).map f |>.foldl_eq'
  · intro x _ y _ z
    omega

theorem iterate_preserves {n : Nat} (A : Fin n → Fin n → Nat) (s : Fin n → Fin n)
    (hpres : ∀ u v, A (s u) (s v) = A u v) (k : Nat) (u v : Fin n) :
    A (s^[k] u) (s^[k] v) = A u v := by
  induction k with
  | zero => rfl
  | succ k ih =>
    change A (s (s^[k] u)) (s (s^[k] v)) = A u v
    rw [hpres, ih]

def cyclicEquitableData {n : Nat} (p : Nat) (hp : 0 < p)
    (A : Fin n → Fin n → Nat) (s : Fin n → Fin n)
    (hperiod : s^[p] = id)
    (hpres : ∀ u v, A (s u) (s v) = A u v) : EquitableData A := by
  let label := orbitLabel p s
  have hbij : Function.Bijective s := iterate_bijective hp s hperiod
  refine { label := label, idempotent := ?_, invariant_counts := ?_ }
  · intro u
    exact orbitLabel_idempotent hp s hperiod u
  · intro u j
    have hcount_s : ∀ x, fiberSum label (A (s x)) j = fiberSum label (A x) j := by
      intro x
      have hsum := sumFin_comp_eq s hbij.1 hbij.2
        (fun v => if label v = j then A (s x) v else 0)
      symm
      simpa [label, fiberSum, Function.comp_apply, orbitLabel_succ hp s hperiod, hpres] using hsum
    have hcount_iter : ∀ k : Nat, fiberSum label (A (s^[k] u)) j = fiberSum label (A u) j := by
      intro k
      induction k with
      | zero => rfl
      | succ k ih =>
        change fiberSum label (A (s (s^[k] u))) j = fiberSum label (A u) j
        rw [hcount_s (s^[k] u)]
        exact ih
    obtain ⟨k, hk⟩ := orbitLabel_mem hp s hperiod u
    change fiberSum (orbitLabel p s) (A u) j =
      fiberSum (orbitLabel p s) (A (orbitLabel p s u)) j
    rw [← hk]
    exact (hcount_iter k.val).symm

theorem EquitableData.entry_at_label {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (u j : Fin n) :
    q.entry (q.label u) j = fiberSum q.label (A u) j := by
  unfold EquitableData.entry
  rw [if_pos (q.idempotent u)]
  exact (q.invariant_counts u j).symm

theorem EquitableData.weighted_count {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (i j : Fin n) :
    fiberSize q.label i * q.entry i j =
      sumFin (fun u => sumFin (fun v =>
        if q.label u = i then (if q.label v = j then A u v else 0) else 0)) := by
  rw [← fiberSum_const q.label (q.entry i j) i]
  unfold fiberSum sumFin
  apply congrArg List.sum
  apply List.map_congr_left
  intro u hu
  by_cases hui : q.label u = i
  · have hentry : q.entry i j = fiberSum q.label (A u) j := by
      rw [← hui]
      exact q.entry_at_label u j
    simp [fiberSum, sumFin, hui, hentry]
  · have hz := sum_map_zero (List.finRange n)
    simp [hui, sumFin, hz]

theorem EquitableData.weighted_symmetry {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (hsym : ∀ u v, A u v = A v u) (i j : Fin n) :
    fiberSize q.label i * q.entry i j = fiberSize q.label j * q.entry j i := by
  rw [q.weighted_count i j, q.weighted_count j i, sumFin_swap]
  apply congrArg sumFin
  funext u
  apply congrArg sumFin
  funext v
  by_cases hij : i = j
  · subst j
    by_cases hui : q.label u = i <;> by_cases huv : q.label v = i <;>
      simp [hui, huv, hsym u v]
  · by_cases hui : q.label u = i
    · by_cases huv : q.label v = j
      · simp [hui, huv, hij]
      · by_cases hvi : q.label v = i
        · simp [hui, huv, hvi, hij]
        · simp [hui, huv, hvi, hij]
    · by_cases huv : q.label v = j
      · by_cases huj : q.label u = j
        · simp [hui, huv, huj, hij, hsym u v]
        · simp [hui, huv, huj, hij, hsym u v]
      · by_cases hvi : q.label v = i <;> by_cases huj : q.label u = j <;>
          simp [hui, huv, hvi, huj, hij, hsym u v]

theorem EquitableData.product_as_fiber {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (i j : Fin n) (hi : q.label i = i) :
    sumFin (fun r => q.entry i r * q.entry r j) =
      fiberSum q.label (fun v => sumFin (fun w => A i w * A w v)) j := by
  have hentry : ∀ r, q.entry i r = fiberSum q.label (A i) r := by
    intro r
    unfold EquitableData.entry
    rw [if_pos hi]
  calc
    sumFin (fun r => q.entry i r * q.entry r j) =
        sumFin (fun r => fiberSum q.label (A i) r * q.entry r j) := by
          apply congrArg sumFin
          funext r
          rw [hentry r]
    _ = sumFin (fun w => A i w * q.entry (q.label w) j) :=
      fiberSum_weighted q.label (A i) (fun r => q.entry r j)
    _ = sumFin (fun w => A i w * fiberSum q.label (A w) j) := by
      apply congrArg sumFin
      funext w
      rw [q.entry_at_label w j]
    _ = sumFin (fun v => if q.label v = j then
          sumFin (fun w => A i w * A w v) else 0) := by
      have hdist : sumFin (fun w => A i w * fiberSum q.label (A w) j) =
          sumFin (fun w => sumFin (fun v => A i w *
            (if q.label v = j then A w v else 0))) := by
        apply congrArg sumFin
        funext w
        unfold fiberSum
        rw [← sumFin_mul_left]
      rw [hdist, sumFin_swap]
      apply congrArg sumFin
      funext v
      by_cases hv : q.label v = j
      · simp [hv]
      · have hz := sum_map_zero (List.finRange n)
        simp [hv, sumFin, hz]
    _ = fiberSum q.label (fun v => sumFin (fun w => A i w * A w v)) j := by
      rfl

theorem EquitableData.quotient_equation {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (c mu : Nat)
    (hpoly : ∀ u v, sumFin (fun w => A u w * A w v) + A u v =
      c * (if u = v then 1 else 0) + mu)
    (i j : Fin n) (hi : q.label i = i) :
    sumFin (fun r => q.entry i r * q.entry r j) + q.entry i j =
      c * (if i = j then 1 else 0) + mu * fiberSize q.label j := by
  have hentry : q.entry i j = fiberSum q.label (A i) j := by
    unfold EquitableData.entry
    rw [if_pos hi]
  rw [q.product_as_fiber i j hi, hentry]
  rw [← fiberSum_add]
  have hfun : (fun v => sumFin (fun w => A i w * A w v) + A i v) =
      (fun v => (if i = v then c else 0) + mu) := by
    funext v
    have hp := hpoly i v
    by_cases hiv : i = v <;> simp [hiv] at hp ⊢
    · exact hp
    · exact hp
  rw [hfun, fiberSum_add, fiberSum_delta, fiberSum_const]
  by_cases hij : i = j
  · subst j
    simp [hi, Nat.mul_comm]
  · have hli : ¬ q.label i = j := by
      intro h
      apply hij
      rw [← hi, h]
    simp [hli, hij, Nat.mul_comm]

theorem EquitableData.row_sum {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (k : Nat)
    (hdegree : ∀ u, sumFin (A u) = k) (i : Fin n) :
    sumFin (q.entry i) = if q.label i = i then k else 0 := by
  by_cases hi : q.label i = i
  · rw [if_pos hi]
    unfold EquitableData.entry
    simp only [hi, if_pos]
    change sumFin (fun j => fiberSum q.label (A i) j) = k
    rw [fiber_sum_partition, hdegree i]
  · rw [if_neg hi]
    unfold EquitableData.entry
    simp only [hi]
    change sumFin (fun _ => 0) = 0
    unfold sumFin
    exact sum_map_zero (List.finRange n)

end ConwayOrbit

namespace Matrix99

theorem sumFin_eq_foldl {n : Nat} (f : Fin n → Nat) :
    ConwayOrbit.sumFin f = (List.finRange n).foldl (fun a x => a + f x) 0 := by
  unfold ConwayOrbit.sumFin
  rw [List.sum_eq_foldl_nat, List.foldl_map]

theorem conway_target_formula (u v : Fin 99) :
    targetRHS u v = 12 * (if u = v then 1 else 0) + 2 := by
  unfold targetRHS add smul eye allOnes
  cases (inferInstance : Decidable (u = v)) with
  | isTrue h =>
    subst v
    have hb : (u.val == u.val) = true := by
      change decide (u.val = u.val) = true
      exact decide_eq_true rfl
    rw [hb, if_pos rfl, if_pos (Eq.refl u)]
  | isFalse h =>
    have hb : (u.val == v.val) = false := by
      apply decide_eq_false
      intro hv
      exact h (Fin.ext hv)
    rw [hb, if_neg h]
    rfl

theorem conway_row_sum (A : Matrix99 Nat) (hA : ConwayAdj A) (u : Fin 99) :
    ConwayOrbit.sumFin (A u) = 14 := by
  have hprod : (fun w => A u w * A w u) = A u := by
    funext w
    rw [hA.2.1 w u]
    rcases hA.2.2.1 u w with h0 | h1
    · simp only [h0, Nat.zero_mul]
    · simp only [h1, Nat.one_mul]
  have hsum : mul A A u u = ConwayOrbit.sumFin (A u) := by
    unfold mul
    rw [← sumFin_eq_foldl, hprod]
  have hsrg := hA.2.2.2 u u
  rw [hsum, hA.1 u, conway_target_formula, Nat.add_zero, if_pos rfl] at hsrg
  exact hsrg

end Matrix99
