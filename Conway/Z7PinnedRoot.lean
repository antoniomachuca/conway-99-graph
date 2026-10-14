/-
  Pinned first-row search, parameterized by the canonical row.
  The kernel evaluation of each root's domains stays in that root's files.
-/

import Conway.Z7Root00

namespace Matrix99

def pinnedList (rootRow : Fin 12 → Nat) : List Nat :=
  (List.finRange 12).map rootRow

def pinnedTail : List (Fin 12) := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

def pinnedDomain (rootRow : Fin 12 → Nat) (i : Fin 12) : Domain :=
  (z7UnaryRows i).filter fun row => rowsAgree (pinnedList rootRow) row 0 i

def pinnedDoms (rootRow : Fin 12 → Nat) : List Domain :=
  pinnedTail.map (pinnedDomain rootRow)

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

private theorem pinned_tail_length : pinnedTail.length = 11 := by
  decide

private theorem pinned_tail_get (k : Nat) (hk : k < 11) :
    pinnedTail.getD k 0 = ⟨k + 1, by omega⟩ := by
  revert k hk
  decide

private theorem mem_pinned_domain (rootRow : Fin 12 → Nat)
    (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = rootRow j) (i : Fin 12) :
    (List.finRange 12).map (C i) ∈ pinnedDomain rootRow i := by
  unfold pinnedDomain
  rw [List.mem_filter]
  refine ⟨z7UnaryRows_of_row i (C i) (fun j => hC.2.1 i j) (hC.2.2.1 i) (hC.2.2.2.1 i)
      (hC.2.2.2.2.1 i) (hC.2.2.2.2.2 i i), ?_⟩
  have hlist : pinnedList rootRow = (List.finRange 12).map (C 0) := by
    unfold pinnedList
    exact List.map_congr_left fun j _ => (hrow j).symm
  rw [hlist]
  exact rowsAgree_exterior C hC 0 i

private theorem atMem_pinned (rootRow : Fin 12 → Nat) (l : List (Fin 12))
    (rowOf : Fin 12 → List Nat) (h : ∀ i, i ∈ l → rowOf i ∈ pinnedDomain rootRow i)
    (k : Nat) (hk : k < l.length) :
    atMem (l.map (pinnedDomain rootRow)) k ((l.map rowOf).getD k []) := by
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

theorem exterior_pinned_false_of_search (rootRow : Fin 12 → Nat)
    (hsearch : noExtension pinnedTail (pinnedDoms rootRow) = true)
    (C : Fin 12 → Fin 12 → Nat) (hC : ExteriorEquations C)
    (hrow : ∀ j, C 0 j = rootRow j) : False := by
  let rows : List (List Nat) := pinnedTail.map fun i => (List.finRange 12).map (C i)
  apply noExtension_sound pinnedTail (pinnedDoms rootRow) rows
  · rw [pinnedDoms, List.length_map]
  · rw [List.length_map]
  · exact hsearch
  · intro k hk
    simpa [rows, pinnedDoms] using
      atMem_pinned rootRow pinnedTail (fun i => (List.finRange 12).map (C i))
        (fun i _ => mem_pinned_domain rootRow C hC hrow i) k hk
  · intro a b hab hb
    have hb11 : b < 11 := by
      rw [pinned_tail_length] at hb
      exact hb
    have ha11 : a < 11 := by omega
    have hlena : a < pinnedTail.length := by omega
    have hlenb : b < pinnedTail.length := hb
    have hrowa : rows.getD a [] =
        (List.finRange 12).map (C (pinnedTail.getD a 0)) := by
      simpa [rows] using getD_map (fun i => (List.finRange 12).map (C i)) pinnedTail a 0 [] hlena
    have hrowb : rows.getD b [] =
        (List.finRange 12).map (C (pinnedTail.getD b 0)) := by
      simpa [rows] using getD_map (fun i => (List.finRange 12).map (C i)) pinnedTail b 0 [] hlenb
    rw [hrowa, hrowb, pinned_tail_get a ha11, pinned_tail_get b hb11]
    exact rowsAgree_exterior C hC _ _

#print axioms exterior_pinned_false_of_search

end Matrix99
