# Campaign A: a discriminant obstruction for fixed-point-free automorphisms of prime order

Lead, 2026-10-13. Status: **EXPLORED** (hand derivation + numerical validation; not formalized, not
independently reviewed). Generalizes the fixed-point-free part of Djematene's order-3 argument for
srg(99,14,1,2) (Zenodo 10.5281/zenodo.23305123, reviewed in `../djematene_review/REVIEW.md`).

## Statement (to be written up carefully)

Let Γ be an srg(v,k,λ,μ) with integral eigenvalues k > r > s, σ an automorphism of prime order p acting
without fixed points (v = pm), θ ∈ {r, s}, θ' the other eigenvalue, and assume p ∤ (k−θ)(θ−θ'). Let
Q = Σ_b A_b (m×m, integer), M = Σ_b ζ^b A_b (Hermitian over O_K, K = Q(ζ_p)), L = ker_Z(Q − θ),
L' = ker_{O_K}(M − θ), a = rank L, a' = rank L'. Then:

- (R) a = a', p | f_θ, and Σ_U A_b[U,U] = (k − θ')/p for every b ≠ 0 (so every σ^b moves exactly k − θ'
  vertices to neighbours). Using (k−θ)(k−θ') = μv this is automatic from the parameters — it gives no
  exclusions; it agrees with Ishida's exact values (arXiv:2606.29183).
- (D) for p ≤ 19 (O_K a PID): with d = disc L and d' = disc L' (totally positive in O_{K+}),
  Legendre(d/p) ≡ N_{K+/Q}(d') (mod p); d | ((k−θ)(θ−θ'))^a; N(d') | (θ−θ')^{a(p−1)/2}; and for every prime
  ℓ | m with ℓ ∤ (m/g)(θ−θ'), g = gcd(m, k−θ): v_ℓ(d) ≡ v_ℓ(m) (mod 2).

Proof sketch (as in Djematene §3): N = (k−θ)(Q − θ'I) − pμJ and N' = M − θ'I give GK = (k−θ)(θ−θ')I and
G'K' = (θ−θ')I; reduction modulo π = 1 − ζ gives N̄ = (k−θ)N̄', hence a = a' and ρ(d') = det(C̄B̄')²ρ(d);
Euler's criterion and ρ∘τ = ρ for τ ∈ Gal give χ(ρ(d')) = ρ(N_{K+/Q}(d')); the gluing of L with 1 inside
ker((Q−θ)(Q−k)) with N_W = (m/g)(Q − θ'I) − ((k−θ)/g)J gives m·d = det(T)² det G_W with
det G_W | ((m/g)(θ−θ'))^{a+1}.

## Validation on known graphs (`obstruction.py`, `validate_p11.py`)

Triangular graphs T(n) and complements with σ = product of p-cycles fixing at most one point (fixed-point-free
on pairs): p = 3 (n = 7, 9, 10, 15), p = 5 (n = 10, 11, 15), p = 7 (n = 14, 15), p = 11 (n = 22, 23). In every applicable case (22 in all: 18 for p = 3, 5, 7 and 4 for p = 11) the computed a, a', d, N(d') satisfy all
predicted relations, and `test_params` does not exclude the graph. In the non-applicable cases a ≠ a'
occurs, as expected (the hypothesis p ∤ (k−θ)(θ−θ') matters). p = 13, 17, 19 are not validated yet.

## Scan of Brouwer's table (`scan_brouwer.py`, `scan_out.jsonl`)

2,889 open ('?') parameter sets with v ≤ 1300 (snapshot in Djematene's archive), 2,819 with integral
eigenvalues: 10,322 (set, p, θ) tests not applicable, 3,588 passed, **34 (set, p) excluded by (D)**, none by
(R). The list includes (99,14,1,2) with p = 3 (Djematene's case) and, e.g., (88,27,6,9) with p = 11.

Candidate consequence (needs literature check): Behbahani–Lam (thesis, Table 16) leave for srg(88,27,6,9)
and p = 11 only the fixed-point-free case (5 orbit matrices, unresolved); fixed points 11 and 22 give no
orbit matrix. With (D) this would give: an srg(88,27,6,9) has no automorphism of order 11, so the possible
primes are 2, 3, 5.

## To do

1. Validate p = 13, 17, 19 (larger controls; faster exact linear algebra needed).
2. Write the general theorem and proof cleanly; check every step again.
3. Literature check per excluded (set, p): Behbahani–Lam tables, Makhnev et al., Crnković et al., Ishida §8.
4. Extend to automorphisms with fixed points (Djematene §4 does three fixed points for (99,14,1,2)).
