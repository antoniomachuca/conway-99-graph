# Referee report: `discriminant_obstruction.tex` (campaign A working note)

Reviewer: Sidekick (independent implementation, `campaign_A/review/referee.py`, `run_review.py`,
output `review_out.jsonl`, rescan `scan_out_mine.jsonl`). Date: 2026-10-13.
**No reuse of the author's code**: integer kernel via sympy fraction-free `nullspace` + Smith
normal form saturation index (`det(V^T V)/prod(SNF diag)^2`); own cyclotomic regular
representation (`z^p = 1` wrap then `z^{p-1} = -(1+..+z^{p-2})`); own Brouwer parser;
own implementation of `cor:test` written from the note's statement.

## 1. Proof review — verdict per step

| Location | Claim | Verdict |
|---|---|---|
| Setup (l. 32–46) | `(A−rI)(A−sI)=μJ`, `(k−r)(k−s)=μv`, `A_b^T=A_{-b}`, `A_0` zero diagonal | verified |
| Lemma Φ | ring hom to `M_m(Z[C_p])`, `Φ(J)=(Σt^b)J`; `(Q−rI)(Q−sI)=pμJ`, `(M−rI)(M−sI)=0`; `Q1=k1`; `Q≡M mod π` | verified |
| Lemma lat | PID kernel is a direct summand; `BCY=Y` on columns in `L` | verified |
| Step 1 | `(Q−θI)N=0` (uses `(Q−θI)J=(k−θ)J`); `Jx=0` for `x∈ker(Q−θI)`; `N=(k−θ)(θ−θ')` on `L_θ`; `N'=M−θ'I` analogous | verified |
| Step 2 | `N=BKB^T`, `GK=(k−θ)(θ−θ')I_a`, `d | ((k−θ)(θ−θ'))^a`; `N'=B'K'B'*`, `G'K'=(θ−θ')I_{a'}` | verified (algebra checked symbolically on the identities; the key point `B^T N C^T = (k−θ)(θ−θ')(CB)^T` uses `NB` scalar) |
| Step 2, total positivity | `τ(G')=(τB')*(τB')` Gram of independent vectors ⇒ `d'` totally positive | verified — requires `Gal(K/Q)` abelian (true: cyclotomic) so `τ` commutes with conjugation; each conjugate is positive definite since `τB'` keeps independent columns |
| Step 3 | `ρ(N)=ρ(k−θ)ρ(N')` (uses `p≡0 mod π`); `K̄=ρ(k−θ)PK̄'P^T`, `K̄'=ρ(k−θ)^{-1}P'K̄P'^T`; `K̄`, `K̄'` invertible ⇒ `a=a'`; `ρ(d')=det P² ρ(d)` | verified — invertibility of `K̄` uses `p∤(k−θ)(θ−θ')` (primes of det K ⊆ S); of `K̄'` uses `p∤θ−θ'`, same hypothesis. `ρ(d)`, `ρ(d')` nonzero for the same reason |
| Step 3, Euler criterion | `χ(ρ(d')) = ρ(d')^{(p-1)/2} = ∏_{τ∈Gal(K+/Q)} ρ(τd') = ρ(N(d'))` | verified — `|Gal(K+/Q)|=(p−1)/2` and `ρ∘τ=ρ`; conclusion `χ(d) = N(d') mod p ∈ {±1}` needs `p∤d`, which holds since `d | ((k−θ)(θ−θ'))^a` |
| (a) isotypic | `f_θ = a + (p−1)a' = pa` | verified — trivial-isotypic dim = dim_Q ker(Q−θ) = a; each of the p−1 nontrivial characters gives `ker(M_j − θ)` = Galois conjugate of `ker(M−θ)`, same K-dim = O_K-rank `a'` |
| (a) trace part | `c_b = (k−θ')/p` for `b≠0` | verified — `tr N = a(k−θ)(θ−θ')` because `im N ⊆ ker(Q−θ)` and `N|_{ker}` is scalar; conjugating `N'` gives `Σ c_b ζ^{jb}` constant for `j≠0`, hence `c_b = c`; `pc = pμm/(k−θ) = k−θ'` since `(k−θ)(k−θ') = μpm` |
| Step 4 | `W = E_θ ⊕ Q·1`; `N_W = α(Q−θ'I) − βJ` scalar `α(θ−θ')` on `W`; `md = det T² det G_W` ⇒ parity | verified — `βm = α(k−θ)` holds since `g | gcd(m,k−θ)`; `(Q−θ)(Q−k)N_W = 0` via `(Q−θ)(Q−θ')=pμJ` and `(Q−k)J=0`; `N_W` scalar on `ker(Q−θ)` and on `1` separately; `B^T1 = 0` from `Jx = 0`; for `ℓ∤α(θ−θ')`, `ℓ∤det G_W` (since `det G_W | (α(θ−θ'))^{a+1}`) giving `v_ℓ(d) ≡ v_ℓ(m)` |
| cor:test | deduction logic | verified — `primes(d) ⊆ S`; (d)-primes in `S` contribute the forced factor `χ(ℓ)^{v_ℓ(m)}`; uncovered `S`-primes contribute `⊆ {1,χ(ℓ)}`; `N(d') mod p ∈ <primes of |θ−θ'|> ∩ {±1}`; disjoint ⇒ exclusion. `a = 0` handled correctly (`d = 1`: every covered `ℓ` must have `v_ℓ(m)` even). `θ−θ' < 0` handled via `|θ−θ'|` consistently |

### Issues found — none mathematical; three presentation-level remarks

1. **(b) is stated with exponent `a` but proved first with `a'`** (`G'K' = (θ−θ')^{a'}`); `a = a'` is only established in Step 3. Harmless, but the statement order masks it.
2. **cor:test second clause** reads "if some prime `ℓ | m` of (d) does not divide `d`" — meaning "**cannot** divide `d` (`ℓ ∉ S`)", since whether `ℓ | d` is not decidable from parameters otherwise. Worth tightening.
3. **In (c), `N(d') ≡ ±1`** additionally requires `p ∤ d` (Legendre symbol nonzero); it holds under the hypothesis but the "in particular" clause silently uses it.

No step is wrong. The argument is the straight generalization of the reviewed order-3
proof (REVIEW.md), and I found no new gap in the generalization.

## 2. Independent numerical check (own implementation)

Controls (overlapping the author's validation list) — `a, a', d, N_{K+/Q}(d')`:

| graph | p | m | θ | a | a' | d | N(d') | checks |
|---|---|---|---|---|---|---|---|---|
| T(11) | 5 | 11 | 7 | 2 | 2 | 891 = 3⁴·11 | 6561 = 3⁸ | (a)–(d) all true; χ(d)=+1, N≡1 |
| T(11)^c | 5 | 11 | −8 | 2 | 2 | 891 | 6561 | same |
| T(13) | 13 | 6 | −2 | 5 | 5 | 6 | 1771561 = 11⁶ | (a)–(d); χ(d)=−1, N≡12≡−1 |
| T(13)^c | 13 | 6 | 1 | 5 | 5 | 6 | 1771561 | same |
| T(14) | 13 | 7 | 10 | 1 | 1 | 42 | 2985984 = 12⁶ | (a)–(d); χ(d)=+1, N≡1 |
| T(14)^c | 13 | 7 | −11 | 1 | 1 | 42 | 2985984 | same |

Numbers agree with the author's `validate_p13_19.out` (`T(13): a=5,d=6,N=1771561`;
`T(14): a=1,d=42,N=2985984`) where comparable.

New families (not in the author's validation set; graph parameters AND the automorphism
verified in code before use):

| graph | construction | p | θ | a | a' | d | N(d') | checks |
|---|---|---|---|---|---|---|---|---|
| Petersen srg(10,3,0,1) | Kneser K(5,2), σ = 5-cycle, fpf | 5 | 1 | 1 | 1 | 2 | 9 | (a)–(d); χ(d)=−1, N≡4≡−1 |
| GQ(3,3) srg(40,12,2,4) | isotropic pts of PG(3,3) under alternating form `B(x,y)=Tr_{F81/F3}((t−t⁹)xy⁹)`, σ = mult by t (root of Φ₅ over F₃), verified fpf, B verified alternating/invariant numerically | 5 | −4 | 3 | 3 | 288 = 2⁵·3² | 5184 = 72² | (a)–(d); χ(d)=−1, N≡4≡−1 |

Hypothesis-failure cases confirm the necessity of `p ∤ (k−θ)(θ−θ')`: `a ≠ a'` occurs
(T(11) θ=−2: a=8,a'=9; T(13) θ=9: 0 vs 1; T(14) θ=−2: 5 vs 6; Petersen θ=−2: 0 vs 1;
GQ(3,3) θ=2: 4 vs 5) — consistent with the note's remark.

Circulant search (exhaustive in k for v ∈ {26,34,38,39}; v ∈ {46,51,57,58} left running
for >10 min without finishing — truncated, not exhaustive there) found only
degenerate/complete cases (μ = 0, eigenvalues (k,−1)) — no additional nontrivial test
instances within the completed range.

**No prediction of the theorem failed.** Every applicable case satisfies
`a = a'`, `c_b` constant `= (k−θ')/p`, `d | ((k−θ)(θ−θ'))^a`, `N(d') | |θ−θ'|^{a(p−1)/2}`,
`Legendre(d) = N(d') mod p`, and the (d) parity law.

## 3. Independent rescan of cor:test on Brouwer's open table

Own parser over the same snapshot: **2889 open parameter sets, 2819 with integral
eigenvalues** — identical counts to the author's. Excluded `(params, p)` pairs:
**34, set-identical** to `scan_out.jsonl` (diff empty both ways), same verdict `D`
for all 34 (no `R`-only or `R`-and-`D` rows).

## 4. cor:88 check

Arithmetic by hand (θ = 3, θ' = −6 for srg(88,27,6,9), p = 11): `m = 8`, `k−θ = 24`,
`g = 8`, `α(θ−θ') = 9`; covered primes of `m = 8` are `{2}`, `2 ∤ 9`, so
`v_2(d) ≡ v_2(8) = 3` is odd; `S = {2,3}`, `χ(2) = −1`, `χ(3) = +1` mod 11
⇒ `χ(d) = −1`. `N(d') | 9^{5·5}` ⇒ `N(d') mod 11 ∈ ⟨3⟩ = {1,3,9,5,4}`;
intersection with `{±1} = {1,10}` is `{1}` ⇒ `χ(d) = +1`. Contradiction — the
corollary's computation is correct. Also `f_3 = 55 = 5·11` and `c = 3 ≤ 8`, so (a)
excludes nothing here (as stated in the note).

Thesis Table 16 (thesis.txt ~line 4118): under `p = 11` the listed rows are
`f = 0` (5 orbit matrices, '?'), `f = 11` (0), `f = 22` (0, nnfp) — the note's
claim is accurate as written.

## Verdict

The theorem and both corollaries are correct as far as a referee-level check goes:
every proof step verified or repaired where noted (three cosmetic remarks above);
independent numerics on controls AND on two new families reproduce every predicted
relation; the open-table scan is reproduced exactly; cor:88's arithmetic and the
Table 16 citation check out. Classification of this review itself: **EXPLORED**
(manual + independent-computation referee check, not a formal verification).
