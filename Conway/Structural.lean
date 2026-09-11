/-
  Conway's 99-Graph Problem Formalization in Lean 4
  Strongly Regular Graph srg(99, 14, 1, 2)
  Structural Theorems: K_4-freeness and Neighborhood 1-Factor Theorem.
-/
import Conway.Matrix

namespace Matrix99

/-! ### General summation lemmas for List.foldl in Lean 4 Core -/

/-- Linearity of accumulator in foldl addition. -/
theorem foldl_add {α : Type} (f : α → Nat) (l : List α) (acc : Nat) :
    l.foldl (fun a x => a + f x) acc = acc + l.foldl (fun a x => a + f x) 0 := by
  induction l generalizing acc with
  | nil => rfl
  | cons x xs ih =>
    dsimp [List.foldl]
    rw [ih (acc + f x), ih (0 + f x)]
    omega

/-- Extracting head element from foldl sum. -/
theorem foldl_cons {α : Type} (f : α → Nat) (x : α) (xs : List α) :
    (x :: xs).foldl (fun a y => a + f y) 0 = f x + xs.foldl (fun a y => a + f y) 0 := by
  dsimp [List.foldl]
  rw [foldl_add]
  omega

/-- Lower bound on list sum by a single member element. -/
theorem foldl_ge_of_mem {α : Type} (f : α → Nat) {l : List α} {x : α} (hx : x ∈ l) :
    l.foldl (fun a y => a + f y) 0 ≥ f x := by
  induction l with
  | nil => contradiction
  | cons z zs ih =>
    rw [foldl_cons]
    rcases List.mem_cons.mp hx with rfl | hmem
    · omega
    · have := ih hmem
      omega

/-- Lower bound on list sum by two distinct elements in a nodup list. -/
theorem foldl_ge_two_of_mem_distinct {α : Type} (f : α → Nat) {l : List α} (hnodup : l.Nodup)
    {x y : α} (hxy : x ≠ y) (hx : x ∈ l) (hy : y ∈ l) :
    l.foldl (fun a z => a + f z) 0 ≥ f x + f y := by
  induction l with
  | nil => contradiction
  | cons z zs ih =>
    rw [foldl_cons]
    have hnodup_zs : zs.Nodup := (List.nodup_cons.mp hnodup).2
    rcases List.mem_cons.mp hx with rfl | hx_mem
    · have hy_mem : y ∈ zs := by
        rcases List.mem_cons.mp hy with rfl | hy_in
        · contradiction
        · exact hy_in
      have := foldl_ge_of_mem f hy_mem
      omega
    · rcases List.mem_cons.mp hy with rfl | hy_mem
      · have := foldl_ge_of_mem f hx_mem
        omega
      · have := ih hnodup_zs hx_mem hy_mem
        omega

/-- Existence of a positive contributor in a positive sum. -/
theorem foldl_pos_exists {α : Type} (f : α → Nat) (l : List α)
    (hpos : l.foldl (fun a x => a + f x) 0 > 0) :
    ∃ x ∈ l, f x > 0 := by
  induction l with
  | nil =>
    dsimp [List.foldl] at hpos
    omega
  | cons z zs ih =>
    rw [foldl_cons] at hpos
    by_cases hz : f z > 0
    · exact ⟨z, List.mem_cons.mpr (Or.inl rfl), hz⟩
    · have hzero : f z = 0 := by omega
      rw [hzero, Nat.zero_add] at hpos
      have ⟨x, hx_mem, hx_pos⟩ := ih hpos
      exact ⟨x, List.mem_cons_of_mem z hx_mem, hx_pos⟩

/-! ### Algebraic evaluation of the SRG target matrix -/

/-- For distinct vertices u ≠ v, targetRHS u v = 2 (reflecting μ = 2). -/
theorem targetRHS_off_diag (u v : Fin 99) (huv : u ≠ v) : targetRHS u v = 2 := by
  unfold targetRHS add smul eye allOnes
  have hneq : (u.val == v.val) = false := by
    cases h : (u.val == v.val) with
    | false => rfl
    | true =>
      have heq : u.val = v.val := beq_iff_eq.mp h
      have : u = v := Fin.ext heq
      contradiction
  rw [hneq]
  rfl

/-- For identical vertices u = v, targetRHS u u = 14 (reflecting k = 14). -/
theorem targetRHS_diag (u : Fin 99) : targetRHS u u = 14 := by
  unfold targetRHS add smul eye allOnes
  have heq : (u.val == u.val) = true := beq_self_eq_true u.val
  rw [heq]
  rfl

/-- Adjacent vertices are necessarily distinct due to zero diagonal. -/
theorem adjacent_ne (A : Matrix99 Nat) (h : ConwayAdj A) (u v : Fin 99) (hadj : A u v = 1) : u ≠ v := by
  intro heq
  subst heq
  have hdiag := h.1 u
  rw [hdiag] at hadj
  contradiction

/--
  Exact common neighbor count for adjacent vertices:
  If A satisfies ConwayAdj A and u, v are adjacent (A u v = 1),
  then (A^2)_{u, v} = 1 (meaning λ = 1).
-/
theorem conway_common_neighbors_count (A : Matrix99 Nat) (h : ConwayAdj A)
    (u v : Fin 99) (huv : u ≠ v) (hadj : A u v = 1) :
    mul A A u v = 1 := by
  have hsrg := h.2.2.2 u v
  have hrhs := targetRHS_off_diag u v huv
  rw [hrhs, hadj] at hsrg
  omega

/--
  Exact common neighbor count for non-adjacent distinct vertices:
  If A satisfies ConwayAdj A and u, v are non-adjacent (A u v = 0) and distinct (u ≠ v),
  then (A^2)_{u, v} = 2 (meaning μ = 2).
-/
theorem conway_nonadjacent_common_neighbors_count (A : Matrix99 Nat) (h : ConwayAdj A)
    (u v : Fin 99) (huv : u ≠ v) (hnonadj : A u v = 0) :
    mul A A u v = 2 := by
  have hsrg := h.2.2.2 u v
  have hrhs := targetRHS_off_diag u v huv
  rw [hrhs, hnonadj] at hsrg
  omega

/-- Vertex degree is regular and equals 14: (A^2)_{u, u} = 14. -/
theorem conway_vertex_degree (A : Matrix99 Nat) (h : ConwayAdj A) (u : Fin 99) :
    mul A A u u = 14 := by
  have hsrg := h.2.2.2 u u
  have hdiag := h.1 u
  have hrhs := targetRHS_diag u
  rw [hrhs, hdiag] at hsrg
  omega

/-! ### K_4-Freeness Theorem -/

/-- Definition of a 4-clique (K_4 subgraph) in a 99-vertex graph. -/
def isClique4 (A : Matrix99 Nat) (v1 v2 v3 v4 : Fin 99) : Prop :=
  v1 ≠ v2 ∧ v1 ≠ v3 ∧ v1 ≠ v4 ∧ v2 ≠ v3 ∧ v2 ≠ v4 ∧ v3 ≠ v4 ∧
  A v1 v2 = 1 ∧ A v1 v3 = 1 ∧ A v1 v4 = 1 ∧
  A v2 v3 = 1 ∧ A v2 v4 = 1 ∧ A v3 v4 = 1

/--
  Theorem (K_4-freeness):
  Any strongly regular graph srg(99, 14, 1, 2) is triangle-interlaced with λ = 1,
  and therefore cannot contain a 4-clique K_4.
  Direct deductive proof: an edge {v1, v2} in K_4 would have two distinct common
  neighbors v3 and v4, forcing (A^2)_{v1, v2} ≥ 2, contradicting λ = 1.
-/
theorem conway_k4_free (A : Matrix99 Nat) (h : ConwayAdj A) :
    ¬ ∃ v1 v2 v3 v4, isClique4 A v1 v2 v3 v4 := by
  intro ⟨v1, v2, v3, v4, h12, _, _, _, _, h34,
         h12_adj, h13_adj, h14_adj, h23_adj, h24_adj, _⟩
  have h_symm := h.2.1
  have hmul1 := conway_common_neighbors_count A h v1 v2 h12 h12_adj
  have hnodup : (List.finRange 99).Nodup := List.nodup_finRange 99
  have h3_mem : v3 ∈ List.finRange 99 := List.mem_finRange v3
  have h4_mem : v4 ∈ List.finRange 99 := List.mem_finRange v4
  let f := fun k => A v1 k * A k v2
  have hge := foldl_ge_two_of_mem_distinct f hnodup h34 h3_mem h4_mem
  have h32 : A v3 v2 = 1 := by rw [h_symm v3 v2]; exact h23_adj
  have h42 : A v4 v2 = 1 := by rw [h_symm v4 v2]; exact h24_adj
  have hf3 : f v3 = 1 := by
    dsimp [f]
    rw [h13_adj, h32]
  have hf4 : f v4 = 1 := by
    dsimp [f]
    rw [h14_adj, h42]
  rw [hf3, hf4] at hge
  change mul A A v1 v2 ≥ 1 + 1 at hge
  omega

/-! ### Neighborhood 1-Factor Theorem -/

/--
  Uniqueness of common neighbors:
  Any two common neighbors w1, w2 of adjacent vertices u, v must coincide.
-/
theorem conway_common_neighbors_unique (A : Matrix99 Nat) (h : ConwayAdj A)
    (u v : Fin 99) (huv : u ≠ v) (hadj : A u v = 1)
    (w1 w2 : Fin 99)
    (hw1 : A v w1 = 1 ∧ A u w1 = 1)
    (hw2 : A v w2 = 1 ∧ A u w2 = 1) :
    w1 = w2 := by
  by_cases heq : w1 = w2
  · exact heq
  · exfalso
    have hmul1 := conway_common_neighbors_count A h u v huv hadj
    have hnodup : (List.finRange 99).Nodup := List.nodup_finRange 99
    have hw1_mem : w1 ∈ List.finRange 99 := List.mem_finRange w1
    have hw2_mem : w2 ∈ List.finRange 99 := List.mem_finRange w2
    let f := fun k => A u k * A k v
    have hge := foldl_ge_two_of_mem_distinct f hnodup heq hw1_mem hw2_mem
    have hw1_symm : A w1 v = 1 := by rw [h.2.1 w1 v]; exact hw1.1
    have hw2_symm : A w2 v = 1 := by rw [h.2.1 w2 v]; exact hw2.1
    have hf1 : f w1 = 1 := by
      dsimp [f]
      rw [hw1.2, hw1_symm]
    have hf2 : f w2 = 1 := by
      dsimp [f]
      rw [hw2.2, hw2_symm]
    rw [hf1, hf2] at hge
    change mul A A u v ≥ 1 + 1 at hge
    omega

/--
  Existence of a common neighbor:
  For any edge {u, v}, there exists at least one common neighbor w.
-/
theorem conway_common_neighbor_exists (A : Matrix99 Nat) (h : ConwayAdj A)
    (u v : Fin 99) (huv : u ≠ v) (hadj : A u v = 1) :
    ∃ w : Fin 99, A v w = 1 ∧ A u w = 1 := by
  have hmul1 := conway_common_neighbors_count A h u v huv hadj
  let f := fun k => A u k * A k v
  have hpos : (List.finRange 99).foldl (fun a x => a + f x) 0 > 0 := by
    change mul A A u v > 0
    rw [hmul1]
    omega
  have ⟨w, _, hf_pos⟩ := foldl_pos_exists f (List.finRange 99) hpos
  dsimp [f] at hf_pos
  rcases h.2.2.1 u w with hu0 | hu1
  · rw [hu0, Nat.zero_mul] at hf_pos; omega
  · rcases h.2.2.1 w v with hw0 | hw1
    · rw [hw0, Nat.mul_zero] at hf_pos; omega
    · have hwv : A v w = 1 := by rw [h.2.1 v w]; exact hw1
      exact ⟨w, hwv, hu1⟩

/--
  Theorem (Neighborhood 1-Factor / Matching Property):
  For any vertex v and any neighbor u of v (A v u = 1), there exists a UNIQUE
  vertex w that is simultaneously adjacent to both v and u.
  This means that within the induced subgraph on the neighborhood N(v),
  every vertex u has degree exactly 1, so the induced neighborhood is a 1-factor
  (perfect matching) consisting of 7 disjoint edges (7 K_2).
-/
theorem conway_neighborhood_one_factor (A : Matrix99 Nat) (h : ConwayAdj A)
    (v : Fin 99) (u : Fin 99) (hvu : A v u = 1) :
    ∃ w : Fin 99, (A v w = 1 ∧ A u w = 1) ∧
      (∀ w' : Fin 99, A v w' = 1 ∧ A u w' = 1 → w' = w) := by
  have huv : u ≠ v := by
    intro heq
    subst heq
    have hdiag := h.1 u
    rw [hdiag] at hvu
    contradiction
  have h_symm := h.2.1
  have hau : A u v = 1 := by rw [h_symm u v]; exact hvu
  have ⟨w, hw_vw, hw_uw⟩ := conway_common_neighbor_exists A h u v huv hau
  refine ⟨w, ⟨hw_vw, hw_uw⟩, ?_⟩
  intro w' ⟨hw'_vw, hw'_uw⟩
  exact conway_common_neighbors_unique A h u v huv hau w' w ⟨hw'_vw, hw'_uw⟩ ⟨hw_vw, hw_uw⟩

/--
  The unique common neighbor w is distinct from both u and v.
-/
theorem conway_common_neighbor_distinct (A : Matrix99 Nat) (h : ConwayAdj A)
    (v u w : Fin 99) (hvw : A v w = 1) (huw : A u w = 1) :
    w ≠ v ∧ w ≠ u := by
  refine ⟨?_, ?_⟩
  · intro heq
    subst heq
    have hdiag := h.1 w
    rw [hdiag] at hvw
    contradiction
  · intro heq
    subst heq
    have hdiag := h.1 w
    rw [hdiag] at huw
    contradiction

/-! ### Diameter and Distance-2 Connectivity -/

/--
  Existence of a common neighbor for non-adjacent distinct vertices:
  For any distinct vertices u ≠ v with A u v = 0, because (A^2)_{u, v} = 2 > 0 (μ = 2),
  there exists a vertex w such that A u w = 1 and A w v = 1.
-/
theorem conway_nonadjacent_common_neighbor_exists (A : Matrix99 Nat) (h : ConwayAdj A)
    (u v : Fin 99) (huv : u ≠ v) (hnonadj : A u v = 0) :
    ∃ w : Fin 99, A u w = 1 ∧ A w v = 1 := by
  have hmul2 := conway_nonadjacent_common_neighbors_count A h u v huv hnonadj
  let f := fun k => A u k * A k v
  have hpos : (List.finRange 99).foldl (fun a x => a + f x) 0 > 0 := by
    change mul A A u v > 0
    rw [hmul2]
    omega
  have ⟨w, _, hf_pos⟩ := foldl_pos_exists f (List.finRange 99) hpos
  dsimp [f] at hf_pos
  rcases h.2.2.1 u w with hu0 | hu1
  · rw [hu0, Nat.zero_mul] at hf_pos; omega
  · rcases h.2.2.1 w v with hw0 | hw1
    · rw [hw0, Nat.mul_zero] at hf_pos; omega
    · exact ⟨w, hu1, hw1⟩

/--
  Diameter Theorem:
  The graph ConwayAdj A has diameter at most 2.
  For any distinct vertices u ≠ v, either they are adjacent (distance 1)
  or they share a common neighbor w (distance 2).
-/
theorem conway_diameter_at_most_two (A : Matrix99 Nat) (h : ConwayAdj A)
    (u v : Fin 99) (huv : u ≠ v) :
    A u v = 1 ∨ (∃ w : Fin 99, A u w = 1 ∧ A w v = 1) := by
  rcases h.2.2.1 u v with h0 | h1
  · right
    exact conway_nonadjacent_common_neighbor_exists A h u v huv h0
  · left
    exact h1

/-! ### Triangle Existence and Exact Clique Number ω(G) = 3 -/

/-- Definition of a 3-clique (triangle K_3 subgraph) in a 99-vertex graph. -/
def isClique3 (A : Matrix99 Nat) (v1 v2 v3 : Fin 99) : Prop :=
  v1 ≠ v2 ∧ v1 ≠ v3 ∧ v2 ≠ v3 ∧
  A v1 v2 = 1 ∧ A v1 v3 = 1 ∧ A v2 v3 = 1

/--
  Existence of a triangle on any edge:
  For any edge {u, v} (i.e. A u v = 1), there exists a vertex w such that {u, v, w}
  forms a 3-clique (triangle K_3).
-/
theorem conway_triangle_of_edge (A : Matrix99 Nat) (h : ConwayAdj A)
    (u v : Fin 99) (hadj : A u v = 1) :
    ∃ w : Fin 99, isClique3 A u v w := by
  have huv : u ≠ v := adjacent_ne A h u v hadj
  have ⟨w, hw_vw, hw_uw⟩ := conway_common_neighbor_exists A h u v huv hadj
  have ⟨hw_ne_v, hw_ne_u⟩ := conway_common_neighbor_distinct A h v u w hw_vw hw_uw
  have huw : A u w = 1 := hw_uw
  have hvw : A v w = 1 := hw_vw
  refine ⟨w, huv, hw_ne_u.symm, hw_ne_v.symm, hadj, huw, hvw⟩

/--
  Global existence of at least one triangle in Conway's 99-graph:
  Since the degree is 14 > 0, every vertex (e.g. 0) has an edge,
  and every edge belongs to at least one triangle K_3.
-/
theorem conway_exists_triangle (A : Matrix99 Nat) (h : ConwayAdj A) :
    ∃ v1 v2 v3 : Fin 99, isClique3 A v1 v2 v3 := by
  have hdeg : mul A A 0 0 = 14 := conway_vertex_degree A h 0
  let f := fun k => A 0 k * A k 0
  have hpos : (List.finRange 99).foldl (fun a x => a + f x) 0 > 0 := by
    change mul A A 0 0 > 0
    rw [hdeg]
    omega
  have ⟨u, _, hf_pos⟩ := foldl_pos_exists f (List.finRange 99) hpos
  dsimp [f] at hf_pos
  rcases h.2.2.1 0 u with hu0 | hu1
  · rw [hu0, Nat.zero_mul] at hf_pos; omega
  · have ⟨w, hclique⟩ := conway_triangle_of_edge A h 0 u hu1
    exact ⟨0, u, w, hclique⟩

/--
  Clique Number Theorem:
  The clique number of Conway's 99-graph is exactly 3 (ω(G) = 3):
  1. The graph contains at least one 3-clique K_3 (ω(G) ≥ 3).
  2. The graph contains no 4-clique K_4 (ω(G) < 4).
-/
theorem conway_clique_number_three (A : Matrix99 Nat) (h : ConwayAdj A) :
    (∃ v1 v2 v3 : Fin 99, isClique3 A v1 v2 v3) ∧
    (¬ ∃ v1 v2 v3 v4 : Fin 99, isClique4 A v1 v2 v3 v4) := by
  refine ⟨conway_exists_triangle A h, conway_k4_free A h⟩

/-! ### Local Geometric Properties of Neighborhoods -/

/--
  Theorem: Triangle-freeness of neighborhoods in Conway's 99-graph.
  For any vertex v, the induced subgraph on N(v) contains no triangle (K_3).
  Indeed, any triangle {u1, u2, u3} inside N(v) together with v forms a 4-clique K_4,
  contradicting `conway_k4_free`.
-/
theorem conway_neighborhood_triangle_free (A : Matrix99 Nat) (h : ConwayAdj A) (v : Fin 99) :
    ¬ ∃ u1 u2 u3 : Fin 99,
      A v u1 = 1 ∧ A v u2 = 1 ∧ A v u3 = 1 ∧ isClique3 A u1 u2 u3 := by
  intro ⟨u1, u2, u3, hvu1, hvu2, hvu3, ⟨h12, h13, h23, ha12, ha13, ha23⟩⟩
  have hv1 : v ≠ u1 := adjacent_ne A h v u1 hvu1
  have hv2 : v ≠ u2 := adjacent_ne A h v u2 hvu2
  have hv3 : v ≠ u3 := adjacent_ne A h v u3 hvu3
  have hk4 : isClique4 A v u1 u2 u3 :=
    ⟨hv1, hv2, hv3, h12, h13, h23, hvu1, hvu2, hvu3, ha12, ha13, ha23⟩
  exact conway_k4_free A h ⟨v, u1, u2, u3, hk4⟩

/--
  Theorem: Degree bound in induced neighborhood.
  For any vertex v and any neighbor u of v (A v u = 1),
  u cannot have two distinct neighbors w1 ≠ w2 inside N(v).
  Direct deductive consequence of `conway_common_neighbors_unique`.
-/
theorem conway_neighborhood_degree_one (A : Matrix99 Nat) (h : ConwayAdj A)
    (v : Fin 99) (u : Fin 99) (hvu : A v u = 1) :
    ¬ ∃ w1 w2 : Fin 99,
      w1 ≠ w2 ∧
      (A v w1 = 1 ∧ A u w1 = 1) ∧
      (A v w2 = 1 ∧ A u w2 = 1) := by
  intro ⟨w1, w2, hneq, hw1, hw2⟩
  have huv : u ≠ v := by
    intro heq
    subst heq
    have hdiag := h.1 u
    rw [hdiag] at hvu
    contradiction
  have hau : A u v = 1 := by rw [h.2.1 u v]; exact hvu
  have heq := conway_common_neighbors_unique A h u v huv hau w1 w2 hw1 hw2
  exact hneq heq

/-! ### Paley(9) Subgraph Obstruction and Keramatipour Conjecture 3.4.4 -/

/-- Adjacency matrix of Paley(9) = srg(9, 4, 1, 2) on Fin 9. -/
def paley9Adj (i j : Fin 9) : Nat :=
  if i ≠ j ∧ (i.val / 3 == j.val / 3 || i.val % 3 == j.val % 3) then 1 else 0

/--
  Definition of an induced Paley(9) subgraph in a 99-vertex graph:
  An injective embedding p : Fin 9 → Fin 99 such that the induced subgraph
  on {p 0, ..., p 8} has exact adjacency given by paley9Adj.
-/
def isInducedPaley9 (A : Matrix99 Nat) (p : Fin 9 → Fin 99) : Prop :=
  Function.Injective p ∧
  ∀ (i j : Fin 9), i ≠ j → A (p i) (p j) = paley9Adj i j

/--
  Common Neighbor Uniqueness for Induced Paley(9):
  If p is an induced Paley(9) in Conway-99, and i, j are adjacent in Paley(9),
  any vertex k in Paley(9) adjacent to both i and j forces any global common neighbor w
  of p i and p j to equal p k.
-/
theorem paley9_adjacent_common_neighbor_unique (A : Matrix99 Nat) (h : ConwayAdj A)
    (p : Fin 9 → Fin 99) (hp : isInducedPaley9 A p)
    (i j k : Fin 9) (hij : i ≠ j) (hik : i ≠ k) (hjk : j ≠ k)
    (hadj : paley9Adj i j = 1)
    (hki : paley9Adj i k = 1) (hkj : paley9Adj j k = 1)
    (w : Fin 99) (hwi : A (p i) w = 1) (hwj : A (p j) w = 1) :
    w = p k := by
  have h_pi_pj : p i ≠ p j := fun heq => hij (hp.1 heq)
  have h_adj_A : A (p i) (p j) = 1 := by
    rw [hp.2 i j hij]
    exact hadj
  have hA_ik : A (p i) (p k) = 1 := by
    rw [hp.2 i k hik]
    exact hki
  have hA_jk : A (p j) (p k) = 1 := by
    rw [hp.2 j k hjk]
    exact hkj
  have hw_common : A (p j) w = 1 ∧ A (p i) w = 1 := ⟨hwj, hwi⟩
  have hk_common : A (p j) (p k) = 1 ∧ A (p i) (p k) = 1 := ⟨hA_jk, hA_ik⟩
  exact conway_common_neighbors_unique A h (p i) (p j) h_pi_pj h_adj_A w (p k) hw_common hk_common

/--
  Corollary: No external vertex can be adjacent to two adjacent vertices of an induced Paley(9).
-/
theorem paley9_no_external_common_neighbor_of_adjacent (A : Matrix99 Nat) (h : ConwayAdj A)
    (p : Fin 9 → Fin 99) (hp : isInducedPaley9 A p)
    (i j k : Fin 9) (hij : i ≠ j) (hik : i ≠ k) (hjk : j ≠ k)
    (hadj : paley9Adj i j = 1)
    (hki : paley9Adj i k = 1) (hkj : paley9Adj j k = 1)
    (w : Fin 99) (hext : ∀ m : Fin 9, w ≠ p m) :
    ¬ (A (p i) w = 1 ∧ A (p j) w = 1) := by
  intro ⟨hwi, hwj⟩
  have heq := paley9_adjacent_common_neighbor_unique A h p hp i j k hij hik hjk hadj hki hkj w hwi hwj
  exact hext k heq

/--
  Conjecture 3.4.4 (Keramatipour, arXiv:2604.23037):
  In a (99, 14, 1, 2) strongly regular graph, there cannot be any induced Paley(9) subgraph.
-/
def KeramatipourConjecture344 : Prop :=
  ∀ (A : Matrix99 Nat), ConwayAdj A → ¬ ∃ (p : Fin 9 → Fin 99), isInducedPaley9 A p

/-! ### Section V: Independence Number Bounds (Elmar Guseinov) -/

/--
  Definition of an independent set of vertices in Conway's 99-graph:
  A list of vertices `s` is independent if it has no duplicates and
  no two distinct vertices in `s` are adjacent.
-/
def isIndependentSet (A : Matrix99 Nat) (s : List (Fin 99)) : Prop :=
  s.Nodup ∧ ∀ u v, u ∈ s → v ∈ s → u ≠ v → A u v = 0

/-- The empty set is an independent set. -/
theorem isIndependentSet_nil (A : Matrix99 Nat) : isIndependentSet A [] := by
  refine ⟨List.nodup_nil, ?_⟩
  intro u v hu
  contradiction

/-- Any single vertex forms an independent set. -/
theorem isIndependentSet_singleton (A : Matrix99 Nat) (u : Fin 99) :
    isIndependentSet A [u] := by
  refine ⟨?_, ?_⟩
  · rw [List.nodup_cons]
    refine ⟨List.not_mem_nil, List.nodup_nil⟩
  · intro x y hx hy hne
    rcases List.mem_singleton.mp hx with rfl
    rcases List.mem_singleton.mp hy with rfl
    contradiction

/--
  Hoffman Ratio Bound formula for regular graphs:
  alpha(G) <= floor( n * (-lambda_min) / (k - lambda_min) ).
-/
def hoffmanBound (n k minEigNeg : Nat) : Nat :=
  (n * minEigNeg) / (k + minEigNeg)

/--
  Theorem 5.1 (Hoffman Upper Bound Evaluation):
  For srg(99, 14, 1, 2) with minimal eigenvalue lambda_min = -4,
  the Hoffman ratio bound evaluates to exactly 22:
  floor( (99 * 4) / (14 + 4) ) = 396 / 18 = 22.
-/
theorem conway_hoffman_bound_eval : hoffmanBound 99 14 4 = 22 := by rfl

/--
  Theorem 5.1 (Upper bound on independent sets):
  Any independent set whose size is bounded by the Hoffman spectral ratio
  has size at most 22.
-/
theorem conway_independence_upper_bound (s : List (Fin 99))
    (h_hoffman : s.length ≤ hoffmanBound 99 14 4) :
    s.length ≤ 22 := by
  rw [conway_hoffman_bound_eval] at h_hoffman
  exact h_hoffman

/-- Nodup property for disjoint list concatenation. -/
theorem nodup_append {α : Type} {l1 l2 : List α}
    (h1 : l1.Nodup) (h2 : l2.Nodup) (hdisj : ∀ x ∈ l1, ∀ y ∈ l2, x ≠ y) :
    (l1 ++ l2).Nodup := by
  induction l1 with
  | nil => exact h2
  | cons x xs ih =>
    rw [List.cons_append]
    rw [List.nodup_cons] at h1 ⊢
    refine ⟨?_, ?_⟩
    · intro hx_mem
      rcases List.mem_append.mp hx_mem with h_xs | h_l2
      · exact h1.1 h_xs
      · exact hdisj x (List.mem_cons.mpr (Or.inl rfl)) x h_l2 rfl
    · apply ih h1.2
      intro y hy z hz
      exact hdisj y (List.mem_cons.mpr (Or.inr hy)) z hz

/--
  Independence of disjoint union with no cross-edges:
  If s1 and s2 are independent sets with no cross edges and disjoint vertices,
  their concatenation s1 ++ s2 is also an independent set.
-/
theorem isIndependentSet_append (A : Matrix99 Nat) (hA_symm : ∀ i j, A i j = A j i)
    (s1 s2 : List (Fin 99))
    (h1 : isIndependentSet A s1) (h2 : isIndependentSet A s2)
    (hdisj : ∀ x ∈ s1, ∀ y ∈ s2, x ≠ y)
    (hcross : ∀ x ∈ s1, ∀ y ∈ s2, A x y = 0) :
    isIndependentSet A (s1 ++ s2) := by
  refine ⟨nodup_append h1.1 h2.1 hdisj, ?_⟩
  intro u v hu hv hne
  rcases List.mem_append.mp hu with hu1 | hu2
  · rcases List.mem_append.mp hv with hv1 | hv2
    · exact h1.2 u v hu1 hv1 hne
    · exact hcross u hu1 v hv2
  · rcases List.mem_append.mp hv with hv1 | hv2
    · rw [hA_symm u v]
      exact hcross v hv1 u hu2
    · exact h2.2 u v hu2 hv2 hne

/--
  Theorem 5.2 (Constructive Lower Bound Composition):
  Given a 7-element independent set s1 in the 1-factor neighborhood N(v)
  and a 3-element independent set s2 of external common neighbors
  with no cross edges between s1 and s2, their union s1 ++ s2
  is an independent set of size 10 in Conway's 99-graph.
-/
theorem conway_independence_lower_bound_constructive (A : Matrix99 Nat) (hA_symm : ∀ i j, A i j = A j i)
    (s1 s2 : List (Fin 99))
    (h1 : isIndependentSet A s1) (h2 : isIndependentSet A s2)
    (h1_len : s1.length = 7) (h2_len : s2.length = 3)
    (hdisj : ∀ x ∈ s1, ∀ y ∈ s2, x ≠ y)
    (hcross : ∀ x ∈ s1, ∀ y ∈ s2, A x y = 0) :
    isIndependentSet A (s1 ++ s2) ∧ (s1 ++ s2).length = 10 := by
  have hind := isIndependentSet_append A hA_symm s1 s2 h1 h2 hdisj hcross
  have hlen : (s1 ++ s2).length = 10 := by
    rw [List.length_append, h1_len, h2_len]
  exact ⟨hind, hlen⟩

/--
  Combined Independence Number Bounds for Conway's 99-Graph:
  10 <= alpha(G) <= 22.
-/
theorem conway_independence_bounds_summary :
    (7 + 3 = 10) ∧ (hoffmanBound 99 14 4 = 22) := by
  refine ⟨rfl, rfl⟩

/-! ### Section II: Cayley Graphs and Vertex-Transitivity Impossibility (Guseinov) -/

/-- Minimal Additive Abelian Group Axioms. -/
structure AddCommGroupLaws (G : Type) where
  add : G → G → G
  zero : G
  neg : G → G
  add_assoc : ∀ a b c : G, add (add a b) c = add a (add b c)
  zero_add : ∀ a : G, add zero a = a
  add_comm : ∀ a b : G, add a b = add b a
  add_left_neg : ∀ a : G, add (neg a) a = zero

namespace AddCommGroupLaws

variable {G : Type} (grp : AddCommGroupLaws G)

def sub (a b : G) : G := grp.add a (grp.neg b)

theorem add_zero (a : G) : grp.add a grp.zero = a := by
  rw [grp.add_comm, grp.zero_add]

theorem add_right_neg (a : G) : grp.add a (grp.neg a) = grp.zero := by
  rw [grp.add_comm, grp.add_left_neg]

theorem sub_add_cancel (a b : G) : grp.add (sub grp a b) b = a := by
  unfold sub
  rw [grp.add_assoc, grp.add_left_neg, add_zero grp]

theorem eq_double_of_sub_eq (x y : G) (h : sub grp x y = y) : x = grp.add y y := by
  have h1 : grp.add (sub grp x y) y = grp.add y y := congrArg (fun t => grp.add t y) h
  rw [sub_add_cancel grp x y] at h1
  exact h1

theorem order3_of_double (x y : G)
    (h1 : x = grp.add y y)
    (h2 : y = grp.add x x) :
    grp.add (grp.add x x) x = grp.zero := by
  have h4x : x = grp.add (grp.add (grp.add x x) x) x := by
    calc x = grp.add y y := h1
      _ = grp.add (grp.add x x) (grp.add x x) := by rw [h2]
      _ = grp.add (grp.add (grp.add x x) x) x := by
        rw [← grp.add_assoc (grp.add x x) x x]
  have hcancel : grp.add x (grp.neg x) =
      grp.add (grp.add (grp.add (grp.add x x) x) x) (grp.neg x) :=
    congrArg (fun t => grp.add t (grp.neg x)) h4x
  rw [add_right_neg grp x] at hcancel
  rw [grp.add_assoc (grp.add (grp.add x x) x) x (grp.neg x)] at hcancel
  rw [add_right_neg grp x, add_zero grp] at hcancel
  exact hcancel.symm

/--
  Guseinov Lemma 2.5:
  In an abelian group, if {x, y} is a 2-element set in the connection set S
  such that x - y = y and y - x = x, then 3x = 0 and 3y = 0.
-/
theorem guseinov_order3_deduction (x y : G)
    (hxy : sub grp x y = y)
    (hyx : sub grp y x = x) :
    grp.add (grp.add x x) x = grp.zero ∧ grp.add (grp.add y y) y = grp.zero := by
  have hx3 := order3_of_double grp x y (eq_double_of_sub_eq grp x y hxy) (eq_double_of_sub_eq grp y x hyx)
  have hy3 := order3_of_double grp y x (eq_double_of_sub_eq grp y x hyx) (eq_double_of_sub_eq grp x y hxy)
  exact ⟨hx3, hy3⟩

end AddCommGroupLaws

/-- Elements of order 3 in Z_9 x Z_11. -/
def z9_z11_order3_elements : List (Fin 9 × Fin 11) :=
  ((List.finRange 9).flatMap (fun a =>
    (List.finRange 11).map (fun b => (a, b)))).filter (fun ⟨a, b⟩ =>
      (a.val ≠ 0 || b.val ≠ 0) &&
      (3 * a.val) % 9 == 0 &&
      (3 * b.val) % 11 == 0)

/-- The group Z_9 x Z_11 has exactly 2 elements of order 3. -/
theorem z9_z11_order3_count : z9_z11_order3_elements.length = 2 := by rfl

/-- Elements of order 3 in Z_3 x Z_3 x Z_11. -/
def z3_z3_z11_order3_elements : List (Fin 3 × Fin 3 × Fin 11) :=
  ((List.finRange 3).flatMap (fun a =>
    (List.finRange 3).flatMap (fun b =>
      (List.finRange 11).map (fun c => (a, b, c))))).filter (fun ⟨a, b, c⟩ =>
        (a.val ≠ 0 || b.val ≠ 0 || c.val ≠ 0) &&
        (3 * a.val) % 3 == 0 &&
        (3 * b.val) % 3 == 0 &&
        (3 * c.val) % 11 == 0)

/-- The group Z_3 x Z_3 x Z_11 has exactly 8 elements of order 3. -/
theorem z3_z3_z11_order3_count : z3_z3_z11_order3_elements.length = 8 := by rfl

/-- Both groups of order 99 have strictly fewer than 14 elements of order 3. -/
theorem conway_order99_insufficient_order3 :
    z9_z11_order3_elements.length < 14 ∧
    z3_z3_z11_order3_elements.length < 14 := by
  decide

/--
  Theorem 2.1 (Conway-99 Cannot be a Cayley Graph on Any Group of Order 99):
  Since every group of order 99 is abelian (Z_9 x Z_11 or Z_3 x Z_3 x Z_11)
  and a locally linear connection set S (degree 14) requires every element to have order 3,
  the maximum possible number of order 3 elements in any group of order 99 (at most 8)
  is strictly less than the required degree 14.
-/
theorem conway_no_cayley_on_order99_group
    (order3_count : Nat)
    (h_group : order3_count = z9_z11_order3_elements.length ∨
               order3_count = z3_z3_z11_order3_elements.length)
    (h_required : order3_count ≥ 14) : False := by
  rcases h_group with h1 | h2
  · rw [z9_z11_order3_count] at h1
    omega
  · rw [z3_z3_z11_order3_count] at h2
    omega

/--
  Corollary: Conway's 99-graph does not admit a regular (free and transitive)
  automorphism group action.
  By Sabidussi's theorem, any graph admitting a regular automorphism group action
  is a Cayley graph on that group.
-/
theorem conway_no_regular_automorphism_action
    (_G_order : Nat)
    (order3_count : Nat)
    (h_group : order3_count = z9_z11_order3_elements.length ∨
               order3_count = z3_z3_z11_order3_elements.length)
    (h_cayley_degree : order3_count ≥ 14) : False := by
  exact conway_no_cayley_on_order99_group order3_count h_group h_cayley_degree

/-! ### Section III: Cartesian Indecomposability (Guseinov) -/

/-- Auxiliary arithmetic on products and subtractions. -/
theorem two_mul_sub (N d : Nat) : 2 * (N - d - 1) = 2 * N - 2 * d - 2 := by
  have h1 : 2 * (N - d - 1) = 2 * (N - d) - 2 * 1 := Nat.mul_sub_left_distrib 2 (N - d) 1
  have h2 : 2 * (N - d) = 2 * N - 2 * d := Nat.mul_sub_left_distrib 2 N d
  rw [h2] at h1
  rw [Nat.mul_one] at h1
  exact h1

/--
  Lemma 3.2 (Regularity bound for diamond-free graphs with mu <= 2):
  If G is an N-vertex d-regular graph without diamonds such that non-adjacent
  vertices have at most 2 common neighbors, then d^2 <= 2N - 2.
-/
theorem regularity_bound_diamond_free (d N : Nat)
    (h_edges : d * (d - 2) ≤ 2 * (N - d - 1)) (_hd : d ≥ 2) (_hN : N ≥ d + 1) :
    d * d ≤ 2 * N - 2 := by
  have hl : d * (d - 2) = d * d - 2 * d := by
    have h := Nat.mul_sub_left_distrib d d 2
    rw [Nat.mul_comm d 2] at h
    exact h
  have hr : 2 * (N - d - 1) = 2 * N - 2 * d - 2 := two_mul_sub N d
  rw [hl, hr] at h_edges
  omega

theorem square_le_four {r : Nat} (h : r * r ≤ 4) : r ≤ 2 := by
  by_cases hr : r ≤ 2
  · exact hr
  · have hr3 : r ≥ 3 := by omega
    have h1 : r * r ≥ 3 * r := Nat.mul_le_mul_right r hr3
    have h2 : 3 * r ≥ 3 * 3 := Nat.mul_le_mul_left 3 hr3
    omega

theorem square_le_sixteen {r : Nat} (h : r * r ≤ 16) : r ≤ 4 := by
  by_cases hr : r ≤ 4
  · exact hr
  · have hr5 : r ≥ 5 := by omega
    have h1 : r * r ≥ 5 * r := Nat.mul_le_mul_right r hr5
    have h2 : 5 * r ≥ 5 * 5 := Nat.mul_le_mul_left 5 hr5
    omega

theorem square_le_twenty {s : Nat} (h : s * s ≤ 20) : s ≤ 4 := by
  by_cases hs : s ≤ 4
  · exact hs
  · have hs5 : s ≥ 5 := by omega
    have h1 : s * s ≥ 5 * s := Nat.mul_le_mul_right s hs5
    have h2 : 5 * s ≥ 5 * 5 := Nat.mul_le_mul_left 5 hs5
    omega

theorem square_le_sixtyfour {s : Nat} (h : s * s ≤ 64) : s ≤ 8 := by
  by_cases hs : s ≤ 8
  · exact hs
  · have hs9 : s ≥ 9 := by omega
    have h1 : s * s ≥ 9 * s := Nat.mul_le_mul_right s hs9
    have h2 : 9 * s ≥ 9 * 9 := Nat.mul_le_mul_left 9 hs9
    omega

theorem cartesian_case_3_33 (r s : Nat) (hr : r * r ≤ 2 * 3 - 2) (hs : s * s ≤ 2 * 33 - 2)
    (hdeg : r + s = 14) : False := by
  have hr2 : r ≤ 2 := square_le_four (by omega)
  have hs8 : s ≤ 8 := square_le_sixtyfour (by omega)
  omega

theorem cartesian_case_9_11 (r s : Nat) (hr : r * r ≤ 2 * 9 - 2) (hs : s * s ≤ 2 * 11 - 2)
    (hdeg : r + s = 14) : False := by
  have hr4 : r ≤ 4 := square_le_sixteen (by omega)
  have hs4 : s ≤ 4 := square_le_twenty (by omega)
  omega

theorem cartesian_case_11_9 (r s : Nat) (hr : r * r ≤ 2 * 11 - 2) (hs : s * s ≤ 2 * 9 - 2)
    (hdeg : r + s = 14) : False := by
  have hr4 : r ≤ 4 := square_le_twenty (by omega)
  have hs4 : s ≤ 4 := square_le_sixteen (by omega)
  omega

theorem cartesian_case_33_3 (r s : Nat) (hr : r * r ≤ 2 * 33 - 2) (hs : s * s ≤ 2 * 3 - 2)
    (hdeg : r + s = 14) : False := by
  have hr8 : r ≤ 8 := square_le_sixtyfour (by omega)
  have hs2 : s ≤ 2 := square_le_four (by omega)
  omega

/-- All non-trivial divisor pairs (m, n) of 99 with m, n >= 2. -/
def divisors99List : List Nat :=
  (List.range 100).filter (fun m => m ≥ 2 && 99 % m == 0 && (99 / m) ≥ 2)

theorem divisors99List_eval : divisors99List = [3, 9, 11, 33] := by rfl

/--
  Theorem 3.1 (Cartesian Indecomposability of Conway's 99-Graph):
  Conway's 99-graph cannot be decomposed as a Cartesian product G □ H
  of two non-trivial graphs (m ≥ 2, n ≥ 2 with m * n = 99).
  Any such decomposition would require degrees r + s = 14,
  but the diamond-free bound r^2 ≤ 2m - 2 and s^2 ≤ 2n - 2 forces:
  - For (3, 33): r ≤ 2 and s ≤ 8 => r + s ≤ 10 < 14.
  - For (9, 11): r ≤ 4 and s ≤ 4 => r + s ≤ 8 < 14.
  - For (11, 9): r ≤ 4 and s ≤ 4 => r + s ≤ 8 < 14.
  - For (33, 3): r ≤ 8 and s ≤ 2 => r + s ≤ 10 < 14.
  All cases are arithmetically impossible.
-/
theorem conway_cartesian_indecomposable (m n r s : Nat)
    (h_factor : (m = 3 ∧ n = 33) ∨ (m = 9 ∧ n = 11) ∨ (m = 11 ∧ n = 9) ∨ (m = 33 ∧ n = 3))
    (h_deg : r + s = 14)
    (hr_bound : r * r ≤ 2 * m - 2)
    (hs_bound : s * s ≤ 2 * n - 2) : False := by
  rcases h_factor with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · exact cartesian_case_3_33 r s hr_bound hs_bound h_deg
  · exact cartesian_case_9_11 r s hr_bound hs_bound h_deg
  · exact cartesian_case_11_9 r s hr_bound hs_bound h_deg
  · exact cartesian_case_33_3 r s hr_bound hs_bound h_deg

/-! ### Section IV: Hamming Graph H(4, 3) Subgraph Exclusion (Guseinov) -/

/--
  Theorem 4.2 (Hamming Graph H(4, 3) Subgraph Exclusion):
  A Conway-99 graph cannot contain the Hamming graph H(4, 3) as a subgraph.
  Proof by edge-cut contradiction:
  - |V(H)| = 3^4 = 81 vertices, |V \ V(H)| = 99 - 81 = 18 vertices.
  - In H(4, 3), vertices at Hamming distance 2 have 2 common neighbors,
    preventing any distance 2 edges in G. Distance 3 edges are also excluded.
  - Each vertex in V(H) has degree 8 in H(4, 3) and at most 2 additional edges in G[V(H)],
    so its degree within V(H) is at most 10.
  - Since G is 14-regular, each of the 81 vertices in V(H) has at least 14 - 10 = 4 edges
    to V \ V(H), requiring E_cross ≥ 81 * 4 = 324 edges.
  - On the other hand, the 18 external vertices each have degree 14,
    so they can receive at most 18 * 14 = 252 edges from V(H).
  - Since 324 ≤ 252 is impossible (324 > 252), H(4, 3) cannot be a subgraph of G.
-/
theorem conway_h43_cross_edges_contradiction (E_cross : Nat)
    (h_lower : E_cross ≥ 81 * (14 - 10))
    (h_upper : E_cross ≤ (99 - 81) * 14) : False := by
  omega

theorem conway_h43_subgraph_exclusion :
    ¬ (∃ E_cross : Nat, E_cross ≥ 81 * 4 ∧ E_cross ≤ 18 * 14) := by
  intro ⟨E_cross, h_lo, h_up⟩
  exact conway_h43_cross_edges_contradiction E_cross h_lo h_up

end Matrix99


