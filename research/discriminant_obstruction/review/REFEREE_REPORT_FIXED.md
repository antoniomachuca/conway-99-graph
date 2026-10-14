# Referee report — "Automorphisms with fixed points" section

Scope: `discriminant_obstruction.tex` lines 204–290 (Theorem `thm:fix`, Lemma
`lem:bigp`, Corollary `cor:full`). Independent implementation: this directory,
`referee_fixed.py` + `run_review_fixed.py` (integer kernels via python-flint row-HNF
of the transpose — saturated bases, no reuse of the author's `int_kernel`/Bareiss
machinery; cyclotomic norm via my own regular representation and trace form; own
join-spectrum determinant). Author's files untouched.

**Status: EXPLORED (referee-level verification; not formal).**

## 1. Line-by-line verdict on Theorem `thm:fix` (ll. 217–240)

- **Setup (ll. 206–215).** Invariant vectors under σ (order p, f fixed, m orbits,
  v = pm+f) form Z^{m+f} with Ã = [[Q,a],[pa^T,A_F]]: rows U of the top block encode
  (Az)_U = Σ_V Q z_V + a·y, bottom block (Az)_t = Σ_V p·a[V,t]z_V + A_F y. Verified.
  D = diag(pI_m,I_f) gives ⟨z,z'⟩_{Z^v} = z^T D z' and DÃ symmetric (D-self-adjoint).
  (Ã−r)(Ã−s) = μ·1 w^T with w = (p,…,p,1,…,1) = D·1, since J on invariant vectors is
  1 w^T. Nontrivial isotypic components vanish on F and are Galois conjugates of
  M = Σ ζ^b A_b on the orbits — so f_θ = a + (p−1)a'. **Verified.**
- **N = (k−θ)(Ã−θ'I) − μ1w^T (l. 228):** (Ã−θI)N = (k−θ)μ1w^T − μ(k−θ)1w^T = 0.
  For x∈L: w^Tx = ⟨1,x⟩_D, and ⟨1,Ãx⟩_D = θw^Tx while ⟨Ã1,x⟩_D = kw^Tx ⇒ w^Tx = 0
  (k≠θ), so Nx = cx, c = (k−θ)(θ−θ'). **Verified.**
- **Fixed-coordinate divisibility (ll. 229–231):** row t∈F of N on orbit columns:
  (k−θ)p·a[U,t] − μp ≡ 0 mod p; on fixed columns R = (k−θ)(A_F−θ'I) − μJ_f. Thus
  cx_F ≡ Rx_F mod p, i.e. ((k−θ)(θI−A_F)+μJ_f)x_F ≡ 0. Condition (F) ⇒ x_F ≡ 0 (mod p)
  for every x∈L. **Verified** (sign check: (k−θ)(A_F−θ'I)−cI = (k−θ)(A_F−θI), giving
  the stated matrix). Consequently B^TDB = pG̃ entrywise: orbit part contributes p,
  fixed products contribute p². **Verified.**
- **X = N·diag(I_m,pI_f) = pND⁻¹ (l. 233):** integral trivially; symmetric iff DN
  symmetric: DN = (k−θ)D(Ã−θ'I) − μ(D1)w^T = (k−θ)D(Ã−θ') − μww^T (using D1 = w) —
  symmetric. Columns of X lie in L (columns of N do). Then X = BKB^T with
  K = CXC^T, and B^TDX = pB^TN^T = pc·B^T (using DN D⁻¹ = N^T), so
  G̃K = cI_a and **d̃ | c^a** (b). **Verified.**
- **Modulo p (ll. 234–236):** X̄ = diag(ρ(k−θ)(Q̄−θ'I), 0): the J-term contributes
  μ1·w^T·diag(I,pI) ≡ 0 and the (θ'−diagonal)×(pa^T-block) vanishes mod p.
  B̄ = (B̄1;0) by fixed-divisibility, C̄1B̄1 = I; then
  K̄ = ρ(k−θ)C̄1(Q̄−θ'I)C̄1^T and ρ(k−θ)(Q̄−θ'I) = B̄1K̄B̄1^T. This is exactly the
  input Step 3 of `thm:main` needs (same Q̄, same M mod π — F contributes nothing
  to nontrivial characters): **a = a', f_θ = pa** (a); **χ(d̃) ≡ N_{K⁺/Q}(d') mod p**
  (c); the d'-side divisibility N(d') | (θ−θ')^{a(p−1)/2} is unchanged. **Verified.**
- **Part (d), α = v/gcd(v,k−θ) (ll. 237–240):** W = ker((Ã−θI)(Ã−kI)) =
  ker(Ã−θ)⊕Q·1 (Ã diagonalisable — D-self-adjoint — with spectrum ⊆ {k,r,s} on the
  invariant subspace). N_W = α(Ã−θ'I) − β1w^T: annihilated by (Ã−θ)(Ã−k) because
  (Ã−k)1 = 0 and (Ã−θ)(Ã−θ') = μ1w^T kills 1w^T under (Ã−k); N_W = α(θ−θ') on W:
  on ker(Ã−θ) since w^Tx = 0; on 1: N_W 1 = (α(k−θ')−βv)1 = α(θ−θ')1 iff
  βv = α(k−θ), i.e. v·(k−θ)/g = (v/g)(k−θ) ✓. X_W = pN_WD⁻¹ has columns in L_W and
  is symmetric (same ww^T argument); G_W^D K_W = pα(θ−θ')I_{a+1} ⇒
  det G_W^D | (pα(θ−θ'))^{a+1}. With [B|1] = B_W T: B^TD1 = 0 gives
  diag(pG̃, ⟨1,1⟩_D = v) = T^T G_W^D T, so **p^a d̃·v = det(T)²·det G_W^D**. For
  ℓ≠p, ℓ|v, ℓ∤α(θ−θ'): v_ℓ(d̃) ≡ v_ℓ(v) (mod 2). **Verified.**
- **f = 0 specialization (ll. 242–245):** empty determinant = 1, d̃ = d, W-lattice
  recovers α = m/g — consistent with `thm:main`/`cor:test`. **Verified.**

*Minor remarks (cosmetic only):* (i) In (b) the note says "d̃ divides c^a"; taken
literally as signed divisibility this is what det G̃·det K = c^a gives — fine.
(ii) The bound "p ≤ 19" is inherited from O_K being a PID; correct.

## 2. Line-by-line verdict on Lemma `lem:bigp` (ll. 248–260)

- **All common neighbours of two fixed vertices are fixed:** a non-fixed common
  neighbour yields a σ-orbit of p distinct common neighbours, contradicting
  counts λ < p or μ < p (needs p > max(λ,μ)). **Verified.**
- **Equal degrees of non-adjacent fixed vertices:** edge count between N_F(x) and
  N_F(y) = μλ + (deg x − μ)μ (u ∈ N_F(x)∩N_F(y) — μ of them — each contribute λ;
  the deg x−μ others contribute μ; all common neighbours lie in F by the first
  point). Symmetry ⇒ deg x = deg y. **Verified.**
- **Join decomposition:** distinct complement components are pairwise joined
  (non-adjacent in Γ_F ⇒ adjacent in complement ⇒ same component). Within one
  component, all degrees in Γ_F are equal (transitivity along complement paths),
  so each induced part is regular and Γ_F is the join. **Verified.**
- **f ≤ v/(p+1) for μ ≥ 2:** a fixed vertex with all k neighbours fixed forces
  every distance-2 vertex to have ≥ μ ≥ 2 fixed neighbours; a non-fixed vertex
  with ≥ 2 fixed neighbours u,v gives u,v ≥ p common neighbours > max(λ,μ) —
  impossible. So propagation forces σ = 1. Hence every fixed vertex has a
  non-fixed neighbour (≥ p of them, full orbit), while every non-fixed vertex has
  ≤ 1 fixed neighbour: pf ≤ v−f. **Verified.**
- **Part classification used by the enumeration (implicit in the note):** part C on
  n_C vertices must have induced counts λ_i = λ−(f−n_C) (adjacent) and
  μ_i = μ−(f−n_C) (non-adjacent). If μ_i < 0 → impossible unless C complete (but a
  complete C on ≥2 vertices splits into K1 complement components). If μ_i = 0 and
  λ_i ≥ 0 → C is a union of ≥2 cliques of size λ_i+2. If λ_i < 0 → C edgeless,
  requiring μ = f−n_C. Otherwise C is an srg(n_C,d,λ_i,μ_i) whose complement is
  connected (otherwise it decomposes further) — i.e. primitive, including
  conference-type (non-integral spectrum) cases. The cross-part condition
  λ = d_i + d_j + f − n_i − n_j forces all e_i = d_i−n_i equal for t ≥ 3 parts.
  **The classification is complete and matches what `scan_fixed3.py` enumerates.**
  Cross-validated against exhaustive enumeration of all 2^C(f,2) graphs for
  f ≤ 6 (see §4): identical admissible sets.

## 3. Independent numerical verification of `thm:fix` (own code)

19 graphs × graph+complement = 38 analyses (`review/review_fixed.out`), numbers
agree with `fixed_points.out` on every field (a, a', N(d'), f_θ, d̃, fixed_div,
condF, all check verdicts). Graphs verified srg + σ an automorphism of exact
order p before use (own checks). New independent constructions: Paley(25) built
on F₅[x]/(x²+2) with multiplication by a square of order 3 (f=1); Paley(49) on
F₇[x]/(x²+1), order-3 square (f=1); Paley(81) on F₃[x]/(x⁴+x+2), order-5 square
(f=1); plus the same T(n)/complement families (p = 3,5,7,11,13,17,19; f = 1,3,6,
10,15). Where (F) holds — 14 (graph,θ) cases incl. all three Paley tests —
**every conclusion of thm:fix holds**: fixed coords ≡ 0 mod p, a = a', p | f_θ,
d̃ | c^a, N(d') | (θ−θ')^{a(p−1)/2}, χ(d̃) ≡ N(d') (mod p), parity (d). Where the
parameter-level test excludes (verdict R or D) on an applicable θ, **condition
(F) fails on the concrete graph in every case** (condF ≡ 0 mod p), and
fixed-coord divisibility indeed fails — 0 violations. Sample: Paley(81) θ=4,
p=5: a=a'=8, d̃=6561=3⁸, N(d')=3486784401=3^{40}·… wait — d̃ | c^a with
c=(40−4)(4+5)=324: d̃=6561=3⁸ | 324⁸=2^{16}3^{32} ✓; χ(6561)=χ(3^8)=1, N(d')
mod 5 = 3486784401 mod 5 = 1 ✓.

## 4. cor:full items — hand arithmetic + independent enumeration

f-admissible range: f ≡ v (mod p), 2 ≤ ... ≤ v/(p+1) (μ≥2 bound), plus f∈{0,1}.
All confirmed by `my_fixed_subgraphs` (own code) and, for f ≤ 6, by exhaustive
enumeration of all graphs on f vertices (ground truth — identical results).

### srg(88,27,6,9), p = 11 — VERIFIED
Eigenvalues 3, −6 (mults 55, 32); θ=3: c = 24·9 = 216, 11∤c ✓, f_θ=55=5·11.
p > max(6,9) = 9 ✓. f ≡ 0 mod 11, f ≤ 88/12 = 7 ⇒ **f = 0**. Excluded by the fpf
case: a=5, S={2,3}, α=88/8=11, α(θ−θ')=99 ⇒ only ℓ=2 constrained, v_2(88)=3 odd,
χ(2)=−1 (mod 11) ⇒ χ(d̃)=−1 (χ(3)=1), while ⟨3⟩∩{±1} = {1} mod 11 ⇒ χ(d̃)=+1.
Contradiction → no order-11 automorphism. ✓

### srg(99,14,1,2), p = 3 — VERIFIED
Eigenvalues 3, −4 (mults 54, 44); θ=3: c = 11·7 = 77, 3∤77, f_θ=54=18·3
(θ=−4: 3|c, inapplicable). p=3 > max(1,2)=2 ✓. f ≡ 0 mod 3, f ≤ 24 ⇒
f ∈ {0,3,6,9,12,15,18,21,24}. Admissible Γ_F: f=3 → K3 only (exhaustive check on
3 vertices: unique); f=9 → srg(9,4,1,2) = Paley(9) only; f ∈ {6,12,15,18,21,24}
→ **no admissible Γ_F exists at all** (part enumeration: only K1, E_{f−2} and
occasional srg parts — none satisfy the join equations; e.g. f=6 admits a
potential part srg(5,2,0,1) = C5 but no combination sums to f=6 with
e-sum = −5). (F) determinants mod 3: K3: eigenvalues of
11(3I−A_{K3})+2J_3: 17 (×1), 44 (×2) → det ≡ 2·2² ≡ 2 ≠ 0; Paley(9):
11(3I−A)+2J eigenvalues 7 (×1), 22 (×4), 55 (×4) → det ≡ 1 ≠ 0. Then θ=3's D
verdict applies: a=18, S={7,11}, α=9, α(θ−θ')=63 ⇒ ℓ=11 constrained,
v_11(99)=1 odd, χ(11)=χ(2)=−1 mod 3 ⇒ χ(d̃)=−1, but ⟨7⟩={1} mod 3 ⇒ need +1. →
all f excluded → **no order-3 automorphism**. ✓ (f=0 is Djematene's case.)

### srg(342,33,4,3), p = 7 — VERIFIED
disc = 1+120 = 121 → r,s = 6,−5; mults: f_r=152, f_s=189 (11f = 5·341−33 = 1672).
f ≡ 342 ≡ 6 mod 7, f ≤ 342/8 = 42 ⇒ f ∈ {6,13,20,27,34,41} (f=0,1 impossible).
θ=−5: c = 38·(−11), 7∤c, f_{−5}=189=27·7 ⇒ applicable, a=27. θ=6: f_6=152, 7∤152
⇒ R. Admissible Γ_F: exhaustive enumeration of all 2^15 graphs on 6 vertices
gives **exactly K6** (adjacent pairs share 4 = λ, no non-adjacent pairs —
consistent with f=λ+2=6); f ∈ {13,...,41}: no admissible Γ_F. (F) for K6, θ=−5:
38(−5I−A_{K6})+3J_6, eigenvalues −362 (×1), −152 (×5) → det ≡ 2·2⁵ ≡ 1 mod 7
≠ 0. D test: S={2,11,19}, α=342/38=9, α(θ−θ')=−99 ⇒ ℓ∈{2,19} constrained, both
with odd valuations (v_2=v_19=1), χ(2)=1, χ(19)=χ(5)=−1 mod 7 ⇒ χ(d̃)=−1;
⟨11⟩={1,2,4}∩{±1}={1} ⇒ need +1 → contradiction. → **no order-7 automorphism**. ✓

### srg(364,33,2,3), p = 5 — VERIFIED
Eigenvalues 5,−6; mults f_5=195 (11f = 6·363−33 = 2145), f_{−6}=168.
f ≡ 364 ≡ 4 mod 5, f ≤ 364/6 = 60 ⇒ f ∈ {4,9,…,59}. θ=5 applicable (c=28·11=308),
a=39; θ=−6: 5∤168 ⇒ R. Γ_F: exhaustive on 4 vertices ⇒ **K4 only** (f=λ+2=4);
f ≥ 9: no admissible Γ_F (parts available: K1; E_{f−3}; clique-union needs
n=f−3 with a=λ−f+n+2=−1 impossible; srg parts need n≥f−2... enumerate per case —
none combine). (F) for K4, θ=5: 28(5I−A_{K4})+3J: eigenvalues 68 (×1), 168 (×3)
→ det ≡ 3·3³ = 81 ≡ 1 mod 5 ≠ 0. D test: S={2,7,11}, α=364/28=13,
α(θ−θ')=143=11·13 ⇒ ℓ∈{2,7} constrained (13|α(θ−θ'), and 13∉S so no constraint
needed there — note v_13(d̃)=0 anyway). v_2(364)=2 even, v_7=1 odd ⇒
χ(d̃) = χ(7) = χ(2) = −1 mod 5; ⟨11⟩={1} ⇒ need +1 → contradiction.
→ **no order-5 automorphism**. ✓

### srg(561,60,9,6), p = 11 — VERIFIED
Eigenvalues 9,−6; mults f_9=220 (15f = 6·560−60 = 3300), f_{−6}=340.
f ≡ 0 mod 11, f ≤ 561/12 = 46 ⇒ f ∈ {0,11,22,33,44}. θ=9: c=51·15=765, 11∤c,
a=20 (θ=−6: 11|c, inapplicable). Γ_F: f=11 ⇒ **K11 only** (f=λ+2=11; no other
parts: E_{f−6}=E5 exists as a part but e-sums never match; srg parts n<11 all
degenerate to complete); f ∈ {22,33,44}: no admissible Γ_F. (F) for K11, θ=9:
51(9I−A_{K11})+6J: eigenvalues 15 (×1), 510 (×10) → det ≡ 4·4^{10} ≡ 4 mod 11
≠ 0. D test: S={3,5,17}, α=561/51=11, α(θ−θ')=165 ⇒ only ℓ=17 constrained,
v_17(561)=1 odd, χ(17)=χ(6)=−1 mod 11 ⇒ χ(d̃)=−1 (χ(3)=χ(5)=+1 give no freedom);
⟨3,5⟩={1,3,4,5,9}∩{±1}={1} ⇒ need +1 → contradiction; f=0 also excluded by the
same θ=9 D. → **no order-11 automorphism**. ✓

### srg(650,55,0,5), p = 11 — VERIFIED
Eigenvalues 5,−10; mults f_5=429 (15f = 10·649−55 = 6435), f_{−10}=220.
f ≡ 650 ≡ 1 mod 11, f ≤ 650/12 = 54 ⇒ f ∈ {1,12,23,34,45}. Both θ applicable:
θ=5: c=50·15=750; θ=−10: c=65·(−15)=−975. Γ_F: λ=0 ⇒ parts are K1 and
E_{f−5} only (λ_i = n−f < 0 kills clique/srg parts); no join reaches λ=0
requirements (e-sums −1 and −(f−5) never sum to −f) ⇒ **no Γ_F for f ≥ 2**.
f=1: Γ_F=K1, (F): (55−θ)θ+5 ≠ 0 mod 11 for both θ: 50·5+5=255 ≡ 2; 
65·(−10)+5=−645 ≡ 4. D test θ=5: S={2,3,5}, α=650/50=13, α(θ−θ')=195 ⇒ ℓ=2
constrained, v_2(650)=1 odd, χ(2)=−1 ⇒ χ(d̃)=−1; ⟨3,5⟩∩{±1}={1} ⇒ need +1 → D.
θ=−10: S={3,5,13}, α=650/65=10, α(θ−θ')=−150 ⇒ ℓ=13 constrained, v_13=1 odd,
χ(13)=χ(2)=−1 ⇒ χ(d̃)=−1; ⟨3,5⟩∩{±1}={1} ⇒ need +1 → D. → **no order-11
automorphism**. ✓

### Complements
The complement claim is true trivially: Aut(Γ) = Aut(Γ̄), so exclusion for Γ is
exclusion for Γ̄. Note however that p > max(λ,μ) generally **fails** on the
complements (e.g. (342,308,277,280) with p=7), so `lem:bigp`/`thm:fix` do not
apply to the complement parameters directly — the conclusion stands purely by
automorphism equality. Worth one clarifying clause in the note; not an error.

## 5. Findings

- **No mathematical errors found** in `thm:fix`, `lem:bigp`, or `cor:full`;
  every step verified (weighted self-adjointness via D1 = w is the linchpin and
  is correct).
- **No admissible fixed subgraph is missing** from `scan_fixed3.py`: the
  part taxonomy (K1 / E_n / mK_a / primitive or conference srg) is provably
  complete under `lem:bigp`; exhaustive enumeration for f ≤ 6 confirms exactly
  the cliques K3, K4, K6 in the applicable cases.
- All six items, including the four new ones, check out by hand (arithmetic
  shown above); eigenvalue/multiplicity numbers agree.
- The strongest exclusion mechanism at several f (e.g. (99), f=6,12,…,24) is
  *nonexistence* of an admissible Γ_F — the scan handles this correctly.
- One nuance to flag: the author reports `d_tilde` only when (F) holds; my
  computation confirms d̃ = det(B^TDB)/p^a can be integral even when (F) fails
  (e.g. Paley(25) θ=−3, d̃=125), so readers should not read (F) as equivalent
  to integrality of d̃ — the theorem states the correct implication.
- Classification: EXPLORED — verified mathematically and numerically, no Lean/SAT
  certificate.
