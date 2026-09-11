# Bibliographic Dossier: Makhnev & Minakova (2001 / 2004)

## Citation Details
- **Authors:** Alexander A. Makhnev and I. M. Minakova
- **Title (Russian):** Об автоморфизмах сильно регулярных графов с параметрами $\lambda=1, \mu=2$
- **Journal (Russian):** *Дискретная математика* (Discrete Mathematics, Moscow), Vol. 16, No. 1, pp. 95–104 (2004). [MathNet: dm144](https://www.mathnet.ru/rus/dm144)
- **Title (English Translation):** On automorphisms of strongly regular graphs with $\lambda = 1, \mu = 2$
- **Journal (English):** *Discrete Mathematics and Applications*, Vol. 14, No. 2, pp. 201–210 (2004). DOI: [10.1515/15693920412331295982](https://doi.org/10.1515/15693920412331295982)

---

## Abstract & Mathematical Scope

Let $\Gamma$ be a strongly regular graph with parameters $(v, k, 1, 2)$. Using the standard algebraic feasibility conditions of strongly regular graphs, the vertex degree $k$ must be of the form:
$$k = u^2 + u + 2, \quad u \in \{1, 3, 4, 10, 31\}$$
The corresponding parameter tuples $(v, k, 1, 2)$ are:
1. $u = 1$: $(9, 4, 1, 2)$, the unique $3 \times 3$ grid graph ($K_3 \square K_3$).
2. $u = 3$: $(99, 14, 1, 2)$, Conway's 99-graph (existence open).
3. $u = 4$: $(243, 22, 1, 2)$, the coset graph of the ternary Golay code (Berlekamp-van Lint-Seidel graph).
4. $u = 10$: $(6273, 112, 1, 2)$ (existence open).
5. $u = 31$: $(494209, 994, 1, 2)$ (existence open).

---

## Key Theorems for Conway's 99-Graph ($u = 3$)

Makhnev and Minakova investigate the automorphism group $\operatorname{Aut}(\Gamma)$ of a putative $\operatorname{srg}(99, 14, 1, 2)$ using character theory and subconstituent decomposition:

1. **Order Bound on Even Automorphisms:**
   If $\operatorname{Aut}(\Gamma)$ contains an involution ($t^2 = \mathrm{id}, t \ne \mathrm{id}$), then:
   $$|\operatorname{Aut}(\Gamma)| \text{ divides } 42 = 2 \cdot 3 \cdot 7$$
   This excludes any 2-groups of order $\ge 4$ containing non-trivial centralizers, and restricts even automorphism groups to $\{ \mathbb{Z}_2, \mathbb{Z}_6, D_6, \mathbb{Z}_{14}, D_{14}, \mathbb{Z}_{42} \}$.

2. **Exclusion of Prime Divisors $p \ge 11$:**
   No automorphism of prime order $p \ge 11$ (specifically $p = 11$) can act on $\operatorname{srg}(99, 14, 1, 2)$.

3. **Relation to Modern Literature:**
   - **Crnković & Maksimović (2020):** Ruled out orders 6 and 9, eliminating $\mathbb{Z}_6, D_6, \mathbb{Z}_{42}$.
   - **Cesarz & Woldar (2025):** Ruled out order 14 analytically via trace contradiction $7a = 62$.
   - **Parity Rigidity Corollary (This Project, 2026):** Proves that if $|\operatorname{Aut}(\Gamma)|$ is even, $\operatorname{Aut}(\Gamma) \cong \mathbb{Z}_2$, formally completing the exclusion of all composite even orders.
