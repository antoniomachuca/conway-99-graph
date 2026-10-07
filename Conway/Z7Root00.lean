/-
  Root 0 of the canonical exterior list, pinned.

  `exterior_root0_false_of_search` turns a kernel evaluation of `noExtension`
  into a contradiction with `ExteriorEquations`. The evaluation itself is not
  in this file: computing the eleven filtered domains is a separate decide.
-/

import Conway.Z7RootData
import Conway.Z7RowGen

namespace Matrix99

def z7Root0Row (j : Fin 12) : Nat := z7RootValues[0]![j.val]!

def z7Root0List : List Nat := (List.finRange 12).map z7Root0Row

def z7Root0Tail : List (Fin 12) := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

def z7Root0Domain (i : Fin 12) : Domain :=
  (z7UnaryRows i).filter fun row => rowsAgree z7Root0List row 0 i

def z7Root0Doms : List Domain := z7Root0Tail.map z7Root0Domain

private theorem getD_eq_getElem {α : Type} (l : List α) (k : Nat) (hk : k < l.length) (d : α) :
    l.getD k d = l[k] := by
  induction l generalizing k with
  | nil => simp at hk
  | cons a as ih =>
      cases k with
      | zero => rfl
      | succ k =>
          apply ih

private theorem getD_map {α β : Type} (f : α → β) (l : List α) (k : Nat) (d : α) (d' : β)
    (hk : k < l.length) : (l.map f).getD k d' = f (l.getD k d) := by
  induction l generalizing k with
  | nil => simp at hk
  | cons a as ih =>
      cases k with
      | zero => rfl
      | succ k =>
          apply ih
          simp at hk
          omega

private theorem beq_rfl (n : Nat) : (n == n) = true := by
  exact (beq_iff_eq).2 rfl

theorem rowEntry_map (f : Fin 12 → Nat) (i : Fin 12) :
    rowEntry ((List.finRange 12).map f) i = f i := by
  unfold rowEntry
  have hk : i.val < (List.finRange 12).length := by
    rw [List.length_finRange]
    exact i.isLt
  rw [getD_map f (List.finRange 12) i.val i 0 hk]
  rw [getD_eq_getElem (List.finRange 12) i.val hk i, List.getElem_finRange]
  exact congrArg f (Fin.ext rfl)

theorem rowsAgree_exterior (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (i j : Fin 12) :
    rowsAgree ((List.finRange 12).map (C i)) ((List.finRange 12).map (C j)) i j = true := by
  unfold rowsAgree
  have hent : rowEntry ((List.finRange 12).map (C i)) j =
      rowEntry ((List.finRange 12).map (C j)) i := by
    rw [rowEntry_map, rowEntry_map, hC.1 i j]
  have hdot : listDot ((List.finRange 12).map (C i)) ((List.finRange 12).map (C j))
      + rowEntry ((List.finRange 12).map (C i)) j = z7ExteriorTarget i j := by
    rw [listDot_finRange, rowEntry_map]
    exact hC.2.2.2.2.2 i j
  rw [hent] at hdot
  rw [hent, hdot, beq_rfl, beq_rfl, Bool.and_self]

theorem mem_root0_domain (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root0Row j) (i : Fin 12) :
    (List.finRange 12).map (C i) ∈ z7Root0Domain i := by
  unfold z7Root0Domain
  rw [List.mem_filter]
  refine ⟨z7UnaryRows_of_row i (C i) (fun j => hC.2.1 i j) (hC.2.2.1 i) (hC.2.2.2.1 i)
      (hC.2.2.2.2.1 i) (hC.2.2.2.2.2 i i), ?_⟩
  have hlist : z7Root0List = (List.finRange 12).map (C 0) := by
    unfold z7Root0List
    exact List.map_congr_left fun j _ => (hrow j).symm
  rw [hlist]
  exact rowsAgree_exterior C hC 0 i

private theorem atMem_of_map (l : List (Fin 12)) (rowOf : Fin 12 → List Nat)
    (h : ∀ i, i ∈ l → rowOf i ∈ z7Root0Domain i) (k : Nat) (hk : k < l.length) :
    atMem (l.map z7Root0Domain) k ((l.map rowOf).getD k []) := by
  induction l generalizing k with
  | nil => simp at hk
  | cons i is ih =>
      cases k with
      | zero =>
          simp [atMem, h i List.mem_cons_self]
      | succ k =>
          have hk' : k < is.length := by
            simp at hk
            omega
          simpa [atMem] using ih (fun j hj => h j (List.mem_cons_of_mem i hj)) k hk'

private theorem tail_length : z7Root0Tail.length = 11 := by
  decide

private theorem tail_get (k : Nat) (hk : k < 11) :
    z7Root0Tail.getD k 0 = ⟨k + 1, by omega⟩ := by
  revert k hk
  decide

theorem exterior_root0_false_of_search
    (hsearch : noExtension z7Root0Tail z7Root0Doms = true)
    (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = z7Root0Row j) : False := by
  let rows : List (List Nat) := z7Root0Tail.map fun i => (List.finRange 12).map (C i)
  apply noExtension_sound z7Root0Tail z7Root0Doms rows
  · rw [z7Root0Doms, List.length_map]
  · rw [List.length_map]
  · exact hsearch
  · intro k hk
    simpa [rows, z7Root0Doms] using
      atMem_of_map z7Root0Tail (fun i => (List.finRange 12).map (C i))
        (fun i _ => mem_root0_domain C hC hrow i) k hk
  · intro a b hab hb
    have hb11 : b < 11 := by
      rw [tail_length] at hb
      exact hb
    have ha11 : a < 11 := by omega
    have hlena : a < z7Root0Tail.length := by omega
    have hlenb : b < z7Root0Tail.length := hb
    have hrowa : rows.getD a [] =
        (List.finRange 12).map (C (z7Root0Tail.getD a 0)) := by
      simpa [rows] using getD_map (fun i => (List.finRange 12).map (C i)) z7Root0Tail a 0 [] hlena
    have hrowb : rows.getD b [] =
        (List.finRange 12).map (C (z7Root0Tail.getD b 0)) := by
      simpa [rows] using getD_map (fun i => (List.finRange 12).map (C i)) z7Root0Tail b 0 [] hlenb
    rw [hrowa, hrowb, tail_get a ha11, tail_get b hb11]
    exact rowsAgree_exterior C hC _ _

#print axioms rowEntry_map
#print axioms rowsAgree_exterior
#print axioms mem_root0_domain
#print axioms exterior_root0_false_of_search

end Matrix99
