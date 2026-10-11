import Conway.Z7SearchSplit
import Conway.Z7Root29
import Conway.Z7Root29Domains
import Conway.Z7Root29Domain1
import Conway.Z7Root29Domain2
import Conway.Z7Root29Domain3
import Conway.Z7Root29Domain4
import Conway.Z7Root29Domain5
import Conway.Z7Root29Domain6
import Conway.Z7Root29Domain7
import Conway.Z7Root29Domain8
import Conway.Z7Root29Domain9
import Conway.Z7Root29Domain10
import Conway.Z7Root29Domain11

namespace Matrix99

theorem z7Root29Doms_literals :
    pinnedDoms z7Root29Row = [z7Root29Dom1, z7Root29Dom2, z7Root29Dom3, z7Root29Dom4, z7Root29Dom5, z7Root29Dom6, z7Root29Dom7, z7Root29Dom8, z7Root29Dom9, z7Root29Dom10, z7Root29Dom11] := by
  rw [pinnedDoms, pinnedTail]
  dsimp only [List.map]
  rw [z7Root29Domain_eq_1, z7Root29Domain_eq_2, z7Root29Domain_eq_3, z7Root29Domain_eq_4, z7Root29Domain_eq_5, z7Root29Domain_eq_6, z7Root29Domain_eq_7, z7Root29Domain_eq_8, z7Root29Domain_eq_9, z7Root29Domain_eq_10, z7Root29Domain_eq_11]

def z7Root29Branch (k : Nat) : Bool :=
  noExtension [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    (List.zipWith (fun j dom => prune 1 (z7Root29Dom1.getD k []) j dom)
      [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
      [z7Root29Dom2, z7Root29Dom3, z7Root29Dom4, z7Root29Dom5, z7Root29Dom6, z7Root29Dom7, z7Root29Dom8, z7Root29Dom9, z7Root29Dom10, z7Root29Dom11])

set_option maxHeartbeats 800000000
set_option maxRecDepth 10000
set_option Elab.async false

theorem z7Root29Dom1_length : z7Root29Dom1.length = 341 := by
  decide +kernel

theorem z7Root29_chunk_0 :
    ∀ k, k < 8 → 0 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_1 :
    ∀ k, k < 16 → 8 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_2 :
    ∀ k, k < 24 → 16 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_3 :
    ∀ k, k < 32 → 24 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_4 :
    ∀ k, k < 40 → 32 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_5 :
    ∀ k, k < 48 → 40 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_6 :
    ∀ k, k < 56 → 48 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_7 :
    ∀ k, k < 64 → 56 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_8 :
    ∀ k, k < 72 → 64 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_9 :
    ∀ k, k < 80 → 72 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_10 :
    ∀ k, k < 88 → 80 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_11 :
    ∀ k, k < 96 → 88 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_12 :
    ∀ k, k < 104 → 96 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_13 :
    ∀ k, k < 112 → 104 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_14 :
    ∀ k, k < 120 → 112 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_15 :
    ∀ k, k < 128 → 120 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_16 :
    ∀ k, k < 136 → 128 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_17 :
    ∀ k, k < 144 → 136 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_18 :
    ∀ k, k < 152 → 144 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_19 :
    ∀ k, k < 160 → 152 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_20 :
    ∀ k, k < 168 → 160 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_21 :
    ∀ k, k < 176 → 168 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_22 :
    ∀ k, k < 184 → 176 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_23 :
    ∀ k, k < 192 → 184 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_24 :
    ∀ k, k < 200 → 192 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_25 :
    ∀ k, k < 208 → 200 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_26 :
    ∀ k, k < 216 → 208 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_27 :
    ∀ k, k < 224 → 216 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_28 :
    ∀ k, k < 232 → 224 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_29 :
    ∀ k, k < 240 → 232 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_30 :
    ∀ k, k < 248 → 240 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_31 :
    ∀ k, k < 256 → 248 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_32 :
    ∀ k, k < 264 → 256 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_33 :
    ∀ k, k < 272 → 264 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_34 :
    ∀ k, k < 280 → 272 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_35 :
    ∀ k, k < 288 → 280 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_36 :
    ∀ k, k < 296 → 288 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_37 :
    ∀ k, k < 304 → 296 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_38 :
    ∀ k, k < 312 → 304 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_39 :
    ∀ k, k < 320 → 312 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_40 :
    ∀ k, k < 328 → 320 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_41 :
    ∀ k, k < 336 → 328 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_chunk_42 :
    ∀ k, k < 341 → 336 ≤ k → z7Root29Branch k = true := by
  decide +kernel

theorem z7Root29_noExtension :
    noExtension pinnedTail (pinnedDoms z7Root29Row) = true := by
  rw [z7Root29Doms_literals]
  unfold pinnedTail
  rw [noExtension_cons_cons]
  apply all_of_getD _ _ []
  intro k hk
  rw [z7Root29Dom1_length] at hk
  show z7Root29Branch k = true
  exact if h0 : k < 8 then z7Root29_chunk_0 k h0 (by omega) else if h1 : k < 16 then z7Root29_chunk_1 k h1 (by omega) else if h2 : k < 24 then z7Root29_chunk_2 k h2 (by omega) else if h3 : k < 32 then z7Root29_chunk_3 k h3 (by omega) else if h4 : k < 40 then z7Root29_chunk_4 k h4 (by omega) else if h5 : k < 48 then z7Root29_chunk_5 k h5 (by omega) else if h6 : k < 56 then z7Root29_chunk_6 k h6 (by omega) else if h7 : k < 64 then z7Root29_chunk_7 k h7 (by omega) else if h8 : k < 72 then z7Root29_chunk_8 k h8 (by omega) else if h9 : k < 80 then z7Root29_chunk_9 k h9 (by omega) else if h10 : k < 88 then z7Root29_chunk_10 k h10 (by omega) else if h11 : k < 96 then z7Root29_chunk_11 k h11 (by omega) else if h12 : k < 104 then z7Root29_chunk_12 k h12 (by omega) else if h13 : k < 112 then z7Root29_chunk_13 k h13 (by omega) else if h14 : k < 120 then z7Root29_chunk_14 k h14 (by omega) else if h15 : k < 128 then z7Root29_chunk_15 k h15 (by omega) else if h16 : k < 136 then z7Root29_chunk_16 k h16 (by omega) else if h17 : k < 144 then z7Root29_chunk_17 k h17 (by omega) else if h18 : k < 152 then z7Root29_chunk_18 k h18 (by omega) else if h19 : k < 160 then z7Root29_chunk_19 k h19 (by omega) else if h20 : k < 168 then z7Root29_chunk_20 k h20 (by omega) else if h21 : k < 176 then z7Root29_chunk_21 k h21 (by omega) else if h22 : k < 184 then z7Root29_chunk_22 k h22 (by omega) else if h23 : k < 192 then z7Root29_chunk_23 k h23 (by omega) else if h24 : k < 200 then z7Root29_chunk_24 k h24 (by omega) else if h25 : k < 208 then z7Root29_chunk_25 k h25 (by omega) else if h26 : k < 216 then z7Root29_chunk_26 k h26 (by omega) else if h27 : k < 224 then z7Root29_chunk_27 k h27 (by omega) else if h28 : k < 232 then z7Root29_chunk_28 k h28 (by omega) else if h29 : k < 240 then z7Root29_chunk_29 k h29 (by omega) else if h30 : k < 248 then z7Root29_chunk_30 k h30 (by omega) else if h31 : k < 256 then z7Root29_chunk_31 k h31 (by omega) else if h32 : k < 264 then z7Root29_chunk_32 k h32 (by omega) else if h33 : k < 272 then z7Root29_chunk_33 k h33 (by omega) else if h34 : k < 280 then z7Root29_chunk_34 k h34 (by omega) else if h35 : k < 288 then z7Root29_chunk_35 k h35 (by omega) else if h36 : k < 296 then z7Root29_chunk_36 k h36 (by omega) else if h37 : k < 304 then z7Root29_chunk_37 k h37 (by omega) else if h38 : k < 312 then z7Root29_chunk_38 k h38 (by omega) else if h39 : k < 320 then z7Root29_chunk_39 k h39 (by omega) else if h40 : k < 328 then z7Root29_chunk_40 k h40 (by omega) else if h41 : k < 336 then z7Root29_chunk_41 k h41 (by omega) else if h42 : k < 341 then z7Root29_chunk_42 k h42 (by omega) else absurd hk (by omega)

#print axioms z7Root29Doms_literals
#print axioms z7Root29_noExtension

end Matrix99
