import Conway.Z7PinnedRows

namespace Matrix99

set_option maxHeartbeats 200000000

/-- The Cauchy step on the range that occurs for a 12-entry row with entries at most 4. -/
private def cauchyCheckA (a : Nat) : Bool :=
  (List.range 49).all fun s =>
    (List.range 13).all fun k =>
      (List.range 197).all fun q =>
        !decide (s * s ≤ k * q) ||
          decide ((a + s) * (a + s) ≤ (k + 1) * (a * a + q))

private def cauchyCheck : Bool :=
  (List.range 5).all cauchyCheckA

private theorem cauchyCheck_ok_0 : cauchyCheckA 0 = true := by
  decide +kernel

private theorem cauchyCheck_ok_1 : cauchyCheckA 1 = true := by
  decide +kernel

private theorem cauchyCheck_ok_2 : cauchyCheckA 2 = true := by
  decide +kernel

private theorem cauchyCheck_ok_3 : cauchyCheckA 3 = true := by
  decide +kernel

private theorem cauchyCheck_ok_4 : cauchyCheckA 4 = true := by
  decide +kernel

private theorem cauchyCheck_ok : cauchyCheck = true := by
  unfold cauchyCheck
  rw [List.all_eq_true]
  intro a ha
  rw [List.mem_range] at ha
  have hc : a = 0 ∨ a = 1 ∨ a = 2 ∨ a = 3 ∨ a = 4 := by omega
  rcases hc with rfl | rfl | rfl | rfl | rfl
  · exact cauchyCheck_ok_0
  · exact cauchyCheck_ok_1
  · exact cauchyCheck_ok_2
  · exact cauchyCheck_ok_3
  · exact cauchyCheck_ok_4

theorem cauchy_step (a s q k : Nat) (ha : a ≤ 4) (hsb : s ≤ 48) (hq : q ≤ 196)
    (hk : k ≤ 12) (hs : s * s ≤ k * q) :
    (a + s) * (a + s) ≤ (k + 1) * (a * a + q) := by
  have haM : a ∈ List.range 5 := by rw [List.mem_range]; omega
  have hsM : s ∈ List.range 49 := by rw [List.mem_range]; omega
  have hkM : k ∈ List.range 13 := by rw [List.mem_range]; omega
  have hqM : q ∈ List.range 197 := by rw [List.mem_range]; omega
  have h1 := all_of_mem cauchyCheck_ok haM
  have h2 := all_of_mem h1 hsM
  have h3 := all_of_mem h2 hkM
  have h4 := all_of_mem h3 hqM
  have hdec : decide (s * s ≤ k * q) = true := decide_eq_true hs
  simp [hdec] at h4
  exact h4

#print axioms cauchy_step

end Matrix99
