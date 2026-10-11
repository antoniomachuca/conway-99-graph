import Conway.Z7PinnedRoot

namespace Matrix99

theorem noExtension_cons_cons (i : Fin 12) (is : List (Fin 12)) (d : Domain) (ds : List Domain) :
    noExtension (i :: is) (d :: ds) =
      d.all (fun a => noExtension is (List.zipWith (fun j dom => prune i a j dom) is ds)) := by
  rfl

theorem all_of_getD {α : Type} (p : α → Bool) (l : List α) (dflt : α)
    (h : ∀ k, k < l.length → p (l.getD k dflt) = true) : l.all p = true := by
  induction l with
  | nil => rfl
  | cons a as ih =>
      have h0 : p a = true := h 0 (Nat.zero_lt_succ _)
      have htl : ∀ k, k < as.length → p (as.getD k dflt) = true := by
        intro k hk
        have hk2 := h (k + 1) (Nat.succ_lt_succ hk)
        rwa [List.getD_cons_succ] at hk2
      rw [List.all_cons, h0, ih htl]
      rfl

end Matrix99
