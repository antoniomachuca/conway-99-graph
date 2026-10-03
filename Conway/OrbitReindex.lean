import Conway.OrbitQuotient

namespace ConwayOrbit

/-- A finite enumeration of exactly the active labels of an equitable partition. -/
structure OrbitIndexing {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (m : Nat) where
  rep : Fin m → Fin n
  injective : ∀ i j, rep i = rep j → i = j
  active : ∀ i, q.label (rep i) = rep i
  complete : ∀ u, q.label u = u → ∃ i, rep i = u

def OrbitIndexing.matrix {n m : Nat} {A : Fin n → Fin n → Nat}
    {q : EquitableData A} (r : OrbitIndexing q m) (i j : Fin m) : Nat :=
  q.entry (r.rep i) (r.rep j)

def OrbitIndexing.sizes {n m : Nat} {A : Fin n → Fin n → Nat}
    {q : EquitableData A} (r : OrbitIndexing q m) (i : Fin m) : Nat :=
  fiberSize q.label (r.rep i)

theorem EquitableData.entry_inactive_column {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (i j : Fin n) (hj : q.label j ≠ j) :
    q.entry i j = 0 := by
  have hnone : ∀ v, q.label v ≠ j := by
    intro v hv
    apply hj
    calc
      q.label j = q.label (q.label v) := by rw [hv]
      _ = q.label v := q.idempotent v
      _ = j := hv
  unfold EquitableData.entry
  by_cases hi : q.label i = i
  · simp only [hi, if_pos, fiberSum, hnone, sumFin]
    exact sum_map_zero (List.finRange n)
  · simp [hi]

/-- Rectangular interchange: the two finite index types need not have equal size. -/
theorem sumFin_swap_rect {n m : Nat} (f : Fin n → Fin m → Nat) :
    sumFin (fun i => sumFin (fun j => f i j)) =
      sumFin (fun j => sumFin (fun i => f i j)) := by
  unfold sumFin
  exact sum_swap (List.finRange n) (List.finRange m) f

theorem sumFin_indicator_value {n : Nat} (a : Fin n) (f : Fin n → Nat) :
    sumFin (fun v => if a = v then f v else 0) = f a := by
  calc
    sumFin (fun v => if a = v then f v else 0) =
        sumFin (fun v => if v = a then f a else 0) := by
      apply congrArg sumFin
      funext v
      by_cases hv : v = a
      · subst v
        simp
      · simp [hv, Ne.symm hv]
    _ = f a := by
      simpa [sumFin] using
        sum_indicator_list (List.nodup_finRange n) a (f a)

/-- Injective reindexing is valid when the omitted terms vanish. -/
theorem sumFin_reindex_support {n m : Nat} (rep : Fin m → Fin n)
    (hinj : ∀ i j, rep i = rep j → i = j) (f : Fin n → Nat)
    (hzero : ∀ v, (∀ i, rep i ≠ v) → f v = 0) :
    sumFin (fun i => f (rep i)) = sumFin f := by
  have hinner : ∀ v, sumFin (fun i => if rep i = v then f v else 0) = f v := by
    intro v
    have hs := sum_indicator_list
      (nodup_map_injective rep (List.nodup_finRange m) hinj) v (f v)
    have hs' : sumFin (fun i => if rep i = v then f v else 0) =
        if v ∈ (List.finRange m).map rep then f v else 0 := by
      simpa only [sumFin, List.map_map, Function.comp_def] using hs
    rw [hs']
    by_cases hv : v ∈ (List.finRange m).map rep
    · simp [hv]
    · have hf : f v = 0 := hzero v (by
        intro i hi
        apply hv
        exact List.mem_map.mpr ⟨i, List.mem_finRange i, hi⟩)
      simp [hv, hf]
  calc
    sumFin (fun i => f (rep i)) =
        sumFin (fun i => sumFin (fun v => if rep i = v then f v else 0)) := by
      apply congrArg sumFin
      funext i
      exact (sumFin_indicator_value (rep i) f).symm
    _ = sumFin (fun v => sumFin (fun i => if rep i = v then f v else 0)) :=
      sumFin_swap_rect _
    _ = sumFin f := by
      apply congrArg sumFin
      funext v
      exact hinner v

/-- Completeness makes every omitted index an inactive label. -/
theorem OrbitIndexing.inactive_of_omitted {n m : Nat} {A : Fin n → Fin n → Nat}
    {q : EquitableData A} (r : OrbitIndexing q m) (v : Fin n)
    (hv : ∀ i, r.rep i ≠ v) : q.label v ≠ v := by
  intro hactive
  obtain ⟨i, hi⟩ := r.complete v hactive
  exact hv i hi

theorem OrbitIndexing.row_sum {n m : Nat} {A : Fin n → Fin n → Nat}
    {q : EquitableData A} (r : OrbitIndexing q m)
    (k : Nat) (hdegree : ∀ u, sumFin (A u) = k) (i : Fin m) :
    sumFin (r.matrix i) = k := by
  change sumFin (fun j => q.entry (r.rep i) (r.rep j)) = k
  rw [sumFin_reindex_support r.rep r.injective (q.entry (r.rep i)) (by
    intro v hv
    exact q.entry_inactive_column (r.rep i) v (r.inactive_of_omitted v hv))]
  simpa [r.active i] using q.row_sum k hdegree (r.rep i)

theorem OrbitIndexing.weighted_symmetry {n m : Nat} {A : Fin n → Fin n → Nat}
    {q : EquitableData A} (r : OrbitIndexing q m)
    (hsym : ∀ u v, A u v = A v u) (i j : Fin m) :
    r.sizes i * r.matrix i j = r.sizes j * r.matrix j i := by
  exact q.weighted_symmetry hsym (r.rep i) (r.rep j)

theorem OrbitIndexing.quotient_equation {n m : Nat} {A : Fin n → Fin n → Nat}
    {q : EquitableData A} (r : OrbitIndexing q m) (c mu : Nat)
    (hpoly : ∀ u v, sumFin (fun w => A u w * A w v) + A u v =
      c * (if u = v then 1 else 0) + mu) (i j : Fin m) :
    sumFin (fun t => r.matrix i t * r.matrix t j) + r.matrix i j =
      c * (if i = j then 1 else 0) + mu * r.sizes j := by
  have hdelta : (r.rep i = r.rep j) ↔ i = j :=
    ⟨r.injective i j, fun h => congrArg r.rep h⟩
  have hsum := sumFin_reindex_support r.rep r.injective
    (fun v => q.entry (r.rep i) v * q.entry v (r.rep j)) (by
      intro v hv
      have hinactive := r.inactive_of_omitted v hv
      simp [EquitableData.entry, hinactive])
  unfold OrbitIndexing.matrix OrbitIndexing.sizes
  rw [hsum]
  simpa only [hdelta] using
    q.quotient_equation c mu hpoly (r.rep i) (r.rep j) (r.active i)

/-- Pointwise comparison of natural-valued list sums. -/
theorem sum_map_le_of_pointwise {α : Type} (l : List α) (f g : α → Nat)
    (hle : ∀ x, f x ≤ g x) : (l.map f).sum ≤ (l.map g).sum := by
  induction l with
  | nil => exact Nat.le_refl 0
  | cons x xs ih =>
    simp only [List.map_cons, List.sum_cons]
    exact Nat.add_le_add (hle x) ih

theorem sumFin_mono {n : Nat} (f g : Fin n → Nat) (hle : ∀ x, f x ≤ g x) :
    sumFin f ≤ sumFin g :=
  sum_map_le_of_pointwise (List.finRange n) f g hle

theorem EquitableData.entry_le_size {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (hbin : ∀ u v, A u v ≤ 1) (i j : Fin n) :
    q.entry i j ≤ fiberSize q.label j := by
  unfold EquitableData.entry
  by_cases hi : q.label i = i
  · rw [if_pos hi]
    unfold fiberSize fiberSum
    apply sumFin_mono
    intro v
    by_cases hv : q.label v = j
    · simpa only [if_pos hv] using hbin i v
    · simp [hv]
  · rw [if_neg hi]
    exact Nat.zero_le _

/-- A symmetric zero-diagonal double sum is even, even if the list has repetitions. -/
theorem sum_map_double_even {α : Type} (l : List α) (f : α → α → Nat)
    (hsym : ∀ u v, f u v = f v u) (hdiag : ∀ u, f u u = 0) :
    (l.map (fun u => (l.map (fun v => f u v)).sum)).sum % 2 = 0 := by
  induction l with
  | nil => rfl
  | cons x xs ih =>
    simp only [List.map_cons, List.sum_cons]
    rw [sum_map_add, hdiag x]
    have hcross : (xs.map (fun u => f u x)).sum = (xs.map (fun u => f x u)).sum := by
      apply congrArg List.sum
      apply List.map_congr_left
      intro u _
      exact hsym u x
    rw [hcross]
    omega

theorem sumFin_double_even {n : Nat} (f : Fin n → Fin n → Nat)
    (hsym : ∀ u v, f u v = f v u) (hdiag : ∀ u, f u u = 0) :
    sumFin (fun u => sumFin (fun v => f u v)) % 2 = 0 :=
  sum_map_double_even (List.finRange n) f hsym hdiag

/-- The internal valency of an odd-sized equitable class is even. -/
theorem EquitableData.diagonal_even_of_odd_size {n : Nat} {A : Fin n → Fin n → Nat}
    (q : EquitableData A) (hsym : ∀ u v, A u v = A v u)
    (hdiag : ∀ u, A u u = 0) (i : Fin n)
    (hodd : fiberSize q.label i % 2 = 1) : q.entry i i % 2 = 0 := by
  have heven := sumFin_double_even
    (fun u v => if q.label u = i then (if q.label v = i then A u v else 0) else 0)
    (by
      intro u v
      by_cases hu : q.label u = i <;> by_cases hv : q.label v = i <;>
        simp [hu, hv, hsym u v])
    (by
      intro u
      simp [hdiag u])
  rw [← q.weighted_count i i, Nat.mul_mod, hodd, Nat.one_mul, Nat.mod_mod] at heven
  exact heven

#print axioms OrbitIndexing
#print axioms OrbitIndexing.matrix
#print axioms OrbitIndexing.sizes
#print axioms EquitableData.entry_inactive_column
#print axioms sumFin_swap_rect
#print axioms sumFin_indicator_value
#print axioms sumFin_reindex_support
#print axioms OrbitIndexing.inactive_of_omitted
#print axioms OrbitIndexing.row_sum
#print axioms OrbitIndexing.weighted_symmetry
#print axioms OrbitIndexing.quotient_equation
#print axioms sum_map_le_of_pointwise
#print axioms sumFin_mono
#print axioms EquitableData.entry_le_size
#print axioms sum_map_double_even
#print axioms sumFin_double_even
#print axioms EquitableData.diagonal_even_of_odd_size

end ConwayOrbit
