import Conway.Z7ExteriorEncoding

namespace Matrix99

def listDot : List Nat → List Nat → Nat
  | x :: xs, y :: ys => x * y + listDot xs ys
  | _, _ => 0

private theorem finRange12_pinned : List.finRange 12 = [0,1,2,3,4,5,6,7,8,9,10,11] := by
  decide +kernel

theorem listDot_finRange (f g : Fin 12 → Nat) :
    listDot ((List.finRange 12).map f) ((List.finRange 12).map g) =
      sum12 (fun k => f k * g k) := by
  simp only [sum12, finRange12_pinned, List.map_cons, List.map_nil, listDot,
    List.sum_cons, List.sum_nil, Nat.add_zero]

def rowEntry (row : List Nat) (i : Fin 12) : Nat := row.getD i.val 0

def rowsAgree (a b : List Nat) (i j : Fin 12) : Bool :=
  rowEntry a j == rowEntry b i && listDot a b + rowEntry a j == z7ExteriorTarget i j

abbrev Domain := List (List Nat)

def prune (i : Fin 12) (a : List Nat) (j : Fin 12) (dom : Domain) : Domain :=
  dom.filter fun b => rowsAgree a b i j

/-- `true` when every branch through these row domains dies.
    Both lists empty means a complete selection was reached, so the search is not empty.
    Recursion is structural on `indices`, so the equation compiler does not use well-founded recursion. -/
def noExtension (indices : List (Fin 12)) (doms : List Domain) : Bool :=
  match indices with
  | [] =>
      match doms with
      | [] => false
      | _ :: _ => true
  | i :: is =>
      match doms with
      | [] => true
      | d :: ds =>
          d.all fun a => noExtension is (List.zipWith (fun j dom => prune i a j dom) is ds)

theorem mem_prune {i j : Fin 12} {a b : List Nat} {dom : Domain}
    (hmem : b ∈ dom) (hagree : rowsAgree a b i j = true) : b ∈ prune i a j dom := by
  unfold prune
  rw [List.mem_filter]
  exact ⟨hmem, hagree⟩

theorem all_of_mem {α : Type} {p : α → Bool} {l : List α} {a : α}
    (hall : l.all p = true) (ha : a ∈ l) : p a = true := by
  have := (List.all_eq_true (p := p) (l := l)).1 hall a ha
  simpa using this

def atMem (doms : List Domain) (k : Nat) (row : List Nat) : Prop :=
  match doms[k]? with
  | some dom => row ∈ dom
  | none => False

private theorem atMem_zero {d : Domain} {ds : List Domain} {row : List Nat}
    (h : atMem (d :: ds) 0 row) : row ∈ d := by
  simp [atMem] at h
  exact h

private theorem atMem_succ {d : Domain} {ds : List Domain} {k : Nat} {row : List Nat}
    (h : atMem (d :: ds) (k + 1) row) : atMem ds k row := by
  simp [atMem, List.getElem?_cons_succ] at h
  exact h

private theorem getD_cons_zero {a : List Nat} {rest : List (List Nat)} :
    (a :: rest).getD 0 [] = a := by simp

private theorem getD_cons_succ {a : List Nat} {rest : List (List Nat)} {k : Nat} :
    (a :: rest).getD (k + 1) [] = rest.getD k [] := by simp

private theorem getD_fin_cons_zero {i : Fin 12} {is : List (Fin 12)} :
    (i :: is).getD 0 0 = i := by simp

private theorem getD_fin_cons_succ {i : Fin 12} {is : List (Fin 12)} {k : Nat} :
    (i :: is).getD (k + 1) 0 = is.getD k 0 := by simp

private theorem prune_atMem {is : List (Fin 12)} {ds : List Domain} {i : Fin 12}
    {a row : List Nat} {k : Nat}
    (hk : k < is.length) (hds : is.length = ds.length)
    (hmem : atMem ds k row) (hagree : rowsAgree a row i (is.getD k 0) = true) :
    atMem (List.zipWith (fun j dom => prune i a j dom) is ds) k row := by
  induction k generalizing is ds with
  | zero =>
      cases is with
      | nil => simp at hk
      | cons j js =>
          cases ds with
          | nil => simp at hds
          | cons d ds =>
              have hin : row ∈ d := atMem_zero hmem
              have hagree' : rowsAgree a row i j = true := by simpa using hagree
              simp [atMem, prune, List.mem_filter, hin, hagree']
  | succ k ih =>
      cases is with
      | nil => simp at hk
      | cons j js =>
          cases ds with
          | nil => simp at hds
          | cons d ds =>
              apply ih
              · simp at hk; omega
              · simp at hds; omega
              · exact atMem_succ hmem
              · simpa using hagree

theorem noExtension_sound :
    ∀ (indices : List (Fin 12)) (doms : List Domain) (pick : List (List Nat)),
      indices.length = doms.length →
      pick.length = indices.length →
      noExtension indices doms = true →
      (∀ k, k < indices.length → atMem doms k (pick.getD k [])) →
      (∀ a b, a < b → b < indices.length →
          rowsAgree (pick.getD a []) (pick.getD b [])
            (indices.getD a 0) (indices.getD b 0) = true) →
      False := by
  intro indices
  induction indices with
  | nil =>
      intro doms pick hlen hpick hfalse _ _
      cases doms with
      | nil =>
          cases pick with
          | nil =>
              unfold noExtension at hfalse
              cases hfalse
          | cons _ _ => cases hpick
      | cons _ _ => cases hlen
  | cons i is ih =>
      intro doms pick hlen hpick hfalse hmem hagree
      cases doms with
      | nil => cases hlen
      | cons d ds =>
          cases pick with
          | nil => cases hpick
          | cons a rest =>
              have hlen' : is.length = ds.length := by
                rw [List.length_cons, List.length_cons] at hlen
                exact Nat.succ.inj hlen
              have hrest : rest.length = is.length := by
                rw [List.length_cons, List.length_cons] at hpick
                exact Nat.succ.inj hpick
              have ha : a ∈ d := atMem_zero (hmem 0 (Nat.zero_lt_succ _))
              let pruned : List Domain := List.zipWith (fun j dom => prune i a j dom) is ds
              have hlenP : is.length = pruned.length := by
                change is.length = (List.zipWith (fun j dom => prune i a j dom) is ds).length
                rw [List.length_zipWith, hlen', Nat.min_self]
              have hrec : noExtension is pruned = true := by
                have hall : (d.all fun row =>
                    noExtension is (List.zipWith (fun j dom => prune i row j dom) is ds)) = true := by
                  rw [noExtension] at hfalse
                  exact hfalse
                have hrow := all_of_mem hall ha
                change noExtension is (List.zipWith (fun j dom => prune i a j dom) is ds) = true
                exact hrow
              apply ih pruned rest hlenP hrest hrec
              · intro k hk
                have hk1 : k + 1 < (i :: is).length := by
                  rw [List.length_cons]
                  omega
                exact prune_atMem hk hlen' (atMem_succ (hmem (k + 1) hk1))
                  (by
                    have hpair := hagree 0 (k + 1) (Nat.zero_lt_succ k) hk1
                    rw [getD_cons_zero, getD_cons_succ, getD_fin_cons_zero, getD_fin_cons_succ] at hpair
                    exact hpair)
              · intro x y hxy hy
                have hy1 : y + 1 < (i :: is).length := by
                  rw [List.length_cons]
                  omega
                have hxy1 : x + 1 < y + 1 := by omega
                have hpair := hagree (x + 1) (y + 1) hxy1 hy1
                rw [getD_cons_succ, getD_cons_succ, getD_fin_cons_succ, getD_fin_cons_succ] at hpair
                exact hpair

#print axioms all_of_mem
#print axioms atMem_zero
#print axioms atMem_succ
#print axioms prune_atMem
#print axioms noExtension_sound

end Matrix99
