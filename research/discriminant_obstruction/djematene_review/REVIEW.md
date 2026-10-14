# Review of Djematene, "Le graphe de Conway srg(99,14,1,2) n'a pas d'automorphisme d'ordre 3"

Source: Zenodo 10.5281/zenodo.23305123 (record dated 2026-10-11; manuscript dated 2026-09-23, marked
"preuve candidate, non encore relue par un tiers"), file `papers/conway99_order3/preuve_c3.tex`.
Reviewer: lead (Devin), 2026-10-13. Scope: the fixed-point-free case (Lemma 1 = `lem:QM`, Theorem
`thm:matrices`, Steps 1–6). The three-fixed-point case (Prop. 2) and Lemma `lem:fix` were read but not
checked in the same detail; that case is in any event excluded by Behbahani–Lam (thesis, Thm 4.14).
The authors' Lean 4 / Mathlib files are not in the archive ("available on request") and were not seen.

## Statement checked

Theorem (`thm:matrices`): there is no pair (Q, M) with Q ∈ M_33(Z) symmetric, Q·1 = 14·1,
Q² + Q = 12I + 6J; M ∈ M_33(Z[ω]) Hermitian, M² + M = 12I; and Q ≡ M (mod π = 1 − ω) entrywise.

## Step-by-step check (by hand)

| Step | Claim | Check |
|---|---|---|
| Lemma QM | With A_b[U,V] = A[(U,0),(V,b)], Φ(X) = Σ X_b x^b is a ring map to M_33(Z[x]/(x³−1)), Φ(J) = (1+x+x²)J; evaluating A² + A = 12I + 2J at x = 1 and x = ω gives Q² + Q = 12I + 6J and M² + M = 12I; M Hermitian since A_bᵀ = A_{−b}; Q − M = (1−ω)A₁ + (1−ω²)A₂ | correct |
| 1(a) | x ∈ ker(Q − 3I) ⇒ 1ᵀx = 0 | correct (Q symmetric, Q1 = 14·1) |
| 1(b) | N = 11(Q+4I) − 6J: (Q−3I)N = 0, Nx = 77x on V | correct ((Q−3I)(Q+4I) = 6J, (Q−3I)J = 11J) |
| 1(c) | N' = M + 4I: (M−3I)N' = 0, N'y = 7y | correct |
| 1(d) | W = V ⊕ Q1 = ker((Q−3I)(Q−14I)); N_W = 3(Q+4I) − J acts as 21 on W | correct (14 is a simple eigenvalue; N_W·1 = 54 − 33 = 21) |
| 2 | ker over a PID is a direct summand; bases B, B', B_W with left inverses C, C', C_W; d = det BᵀB > 0, d' = det B'*B' ∈ Z_{>0} | correct |
| 3 | N = BKBᵀ with K = CNCᵀ integral; GK = 77I; likewise G'K' = 7I, G_W K_W = 21I; hence d = 7^a 11^b, d' = 7^c ≡ 1 (mod 3), 11 ∤ det G_W | correct (uses BCv = v on L, N symmetric / N' Hermitian) |
| 4 | [B 1] = B_W T, Gram diag(G, 33) = Tᵀ G_W T ⇒ 33d = det(T)² det G_W ⇒ v₁₁(d) odd ⇒ d ≡ −1 (mod 3) | correct (Bᵀ1 = 0 by 1(a); 7 ≡ 1, 11 ≡ −1 mod 3) |
| 5 | ρ: Z[ω] → F₃; N̄ = 2N̄'; K̄ = 2(C̄B̄')K̄'(C̄B̄')ᵀ and symmetrically; K̄, K̄' invertible (det K = 77^r/d, det K' = 7^{r'}/d' prime to 3) ⇒ r = r', C̄B̄' invertible, det K̄ = 2^r det(C̄B̄')² det K̄' ⇒ ρ(d) = ρ(d') | correct (nonzero squares in F₃ equal 1; ρ(z̄) = ρ(z)) |
| 6 | d ≡ 2 and d' ≡ 1 (mod 3): contradiction | correct |
| Remark | r = r' with tr N = 77r, tr N' = 7r' gives τ = 6 (Ishida, arXiv:2606.29183, Prop. 8.7) | consistent; also excludes τ = 27 directly |

I found no error in the fixed-point-free argument.

## Numerical check of the general machinery (`check_lattice_steps.py`)

Steps 1–5 hold verbatim for any srg(3m, k, λ, μ) with a fixed-point-free order-3 automorphism, with
eigenvalues r > s, N = (k−r)(Q − sI) − 3μJ (eigenvalue (k−r)(r−s) on V) and N' = M − sI (eigenvalue
r − s); Step 5 needs 3 ∤ (k−r)(r−s). The script computes saturated Z- and Z[ω]-kernel bases on real graphs
(the Z[ω]-lattice via Z^{2m} and the trace form, det_Z = 3^{r'} d'²):

| Graph | (k−r)(r−s) | rank_Q, rank_M | d | d' | Step 5 applies | d ≡ d' (mod 3) |
|---|---|---|---|---|---|---|
| srg(15,6,1,3), τ = 3 | 5·4 | 3, 3 | 10 = 2·5 | 16 = 2⁴ | yes | yes (1 ≡ 1) |
| Paley(9), τ = 3 | 3·3 | 2, 1 | 3 | 3 | no | — |
| Paley(9), τ = 0 | 3·3 | 0, 2 | 1 | 3 | no | — |
| srg(27,10,1,5), τ = 9 | 9·6 | 8, 6 | 9 | 72 | no | — |

All divisibility predictions (d | ((k−r)(r−s))^rank, d' | (r−s)^rank') hold, and in the one control where
Step 5 applies, rank_Q = rank_M and d ≡ d' (mod 3) as predicted; v₅(d) = 1 is odd, matching the analogue of
Step 4 (m = 5). No contradiction arises for the existing graphs, as it must: for srg(15,6,1,3) the factor 2
leaves the residues free, and for the others 3 divides (k−r)(r−s).

## Conclusion

- The fixed-point-free order-3 argument is, as far as I can check by hand and numerically, **correct**.
  This is a reviewer's check, not a formal verification; I have not seen the authors' Lean files.
- Combined with Behbahani–Lam (an order-3 automorphism has no fixed points), it excludes every
  automorphism of order 3; with the published results, |Aut(Γ)| ∈ {1, 2}.
- Consequences for this project: the t = 6 campaign and the t = 27 formalization re-check a case that this
  argument settles; t = 27 also follows from Ishida's Prop. 8.7.
