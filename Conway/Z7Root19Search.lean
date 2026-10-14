import Conway.Z7SearchSplit
import Conway.Z7Root19
import Conway.Z7Root19Domains
import Conway.Z7Root19Domain1
import Conway.Z7Root19Domain2
import Conway.Z7Root19Domain3
import Conway.Z7Root19Domain4
import Conway.Z7Root19Domain5
import Conway.Z7Root19Domain6
import Conway.Z7Root19Domain7
import Conway.Z7Root19Domain8
import Conway.Z7Root19Domain9
import Conway.Z7Root19Domain10
import Conway.Z7Root19Domain11

namespace Matrix99

theorem z7Root19Doms_literals :
    pinnedDoms z7Root19Row = [z7Root19Dom1, z7Root19Dom2, z7Root19Dom3, z7Root19Dom4, z7Root19Dom5, z7Root19Dom6, z7Root19Dom7, z7Root19Dom8, z7Root19Dom9, z7Root19Dom10, z7Root19Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root19Domain_eq_1, z7Root19Domain_eq_2, z7Root19Domain_eq_3, z7Root19Domain_eq_4, z7Root19Domain_eq_5, z7Root19Domain_eq_6, z7Root19Domain_eq_7, z7Root19Domain_eq_8, z7Root19Domain_eq_9, z7Root19Domain_eq_10, z7Root19Domain_eq_11]

def z7Root19Branch (k : Nat) : Bool :=
  noExtension [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    (List.zipWith (fun j dom => prune 1 (z7Root19Dom1.getD k []) j dom)
      [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
      [z7Root19Dom2, z7Root19Dom3, z7Root19Dom4, z7Root19Dom5, z7Root19Dom6, z7Root19Dom7, z7Root19Dom8, z7Root19Dom9, z7Root19Dom10, z7Root19Dom11])

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root19Dom1_length : z7Root19Dom1.length = 187 := by
  decide +kernel

theorem z7Root19_chunk_0 :
    ∀ k, k < 8 → 0 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_1 :
    ∀ k, k < 16 → 8 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_2 :
    ∀ k, k < 24 → 16 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_3 :
    ∀ k, k < 32 → 24 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_4 :
    ∀ k, k < 40 → 32 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_5 :
    ∀ k, k < 48 → 40 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_6 :
    ∀ k, k < 56 → 48 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_7 :
    ∀ k, k < 64 → 56 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_8 :
    ∀ k, k < 72 → 64 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_9 :
    ∀ k, k < 80 → 72 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_10 :
    ∀ k, k < 88 → 80 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_11 :
    ∀ k, k < 96 → 88 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_12 :
    ∀ k, k < 104 → 96 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_13 :
    ∀ k, k < 112 → 104 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_14 :
    ∀ k, k < 120 → 112 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_15 :
    ∀ k, k < 128 → 120 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_16 :
    ∀ k, k < 136 → 128 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_17 :
    ∀ k, k < 144 → 136 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_18 :
    ∀ k, k < 152 → 144 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_19 :
    ∀ k, k < 160 → 152 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_20 :
    ∀ k, k < 168 → 160 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_21 :
    ∀ k, k < 176 → 168 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_22 :
    ∀ k, k < 184 → 176 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_chunk_23 :
    ∀ k, k < 187 → 184 ≤ k → z7Root19Branch k = true := by
  decide +kernel

theorem z7Root19_noExtension :
    noExtension pinnedTail (pinnedDoms z7Root19Row) = true := by
  rw [z7Root19Doms_literals]
  unfold pinnedTail
  rw [noExtension_cons_cons]
  apply all_of_getD _ _ []
  intro k hk
  rw [z7Root19Dom1_length] at hk
  show z7Root19Branch k = true
  exact if h0 : k < 8 then z7Root19_chunk_0 k h0 (by omega) else if h1 : k < 16 then z7Root19_chunk_1 k h1 (by omega) else if h2 : k < 24 then z7Root19_chunk_2 k h2 (by omega) else if h3 : k < 32 then z7Root19_chunk_3 k h3 (by omega) else if h4 : k < 40 then z7Root19_chunk_4 k h4 (by omega) else if h5 : k < 48 then z7Root19_chunk_5 k h5 (by omega) else if h6 : k < 56 then z7Root19_chunk_6 k h6 (by omega) else if h7 : k < 64 then z7Root19_chunk_7 k h7 (by omega) else if h8 : k < 72 then z7Root19_chunk_8 k h8 (by omega) else if h9 : k < 80 then z7Root19_chunk_9 k h9 (by omega) else if h10 : k < 88 then z7Root19_chunk_10 k h10 (by omega) else if h11 : k < 96 then z7Root19_chunk_11 k h11 (by omega) else if h12 : k < 104 then z7Root19_chunk_12 k h12 (by omega) else if h13 : k < 112 then z7Root19_chunk_13 k h13 (by omega) else if h14 : k < 120 then z7Root19_chunk_14 k h14 (by omega) else if h15 : k < 128 then z7Root19_chunk_15 k h15 (by omega) else if h16 : k < 136 then z7Root19_chunk_16 k h16 (by omega) else if h17 : k < 144 then z7Root19_chunk_17 k h17 (by omega) else if h18 : k < 152 then z7Root19_chunk_18 k h18 (by omega) else if h19 : k < 160 then z7Root19_chunk_19 k h19 (by omega) else if h20 : k < 168 then z7Root19_chunk_20 k h20 (by omega) else if h21 : k < 176 then z7Root19_chunk_21 k h21 (by omega) else if h22 : k < 184 then z7Root19_chunk_22 k h22 (by omega) else if h23 : k < 187 then z7Root19_chunk_23 k h23 (by omega) else absurd hk (by omega)

#print axioms z7Root19Doms_literals
#print axioms z7Root19_noExtension

end Matrix99
