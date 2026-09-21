# Makhnev–Minakova (2004): Prior Results and Attribution

## Bibliographic record

- **Authors:** A. A. Makhnev and I. M. Minakova.
- **English title:** *On automorphisms of strongly regular graphs with the parameters λ = 1 and μ = 2*.
- **English publication:** *Discrete Mathematics and Applications* **14**(2), 201–210 (2004).
- **DOI:** [10.1515/156939204872374](https://doi.org/10.1515/156939204872374).
- **Russian publication:** *Diskretnaya Matematika* **16**(1), 95–104 (2004).

The historical BibTeX key `makhnev2001automorphisms` is retained for compatibility; the publication year is 2004, not the year embedded in that key. The previous dossier's DOI and attribution of a new project parity-rigidity result are corrected by this revision.

## Explicit antecedent for the involution restriction

A. A. Makhnev's *Symmetric graphs and their automorphisms*, Berlin, September 2009, contains an explicit account of the relevant result:

[Lecture slides hosted by the University of Bielefeld](https://www.math.uni-bielefeld.de/~baumeist/sommerschule/makhnev.pdf).

Theorem 1, attributed there to Makhnev–Minakova, states that for an automorphism of prime order $p$ of a hypothetical $\mathrm{srg}(99,14,1,2)$, the fixed subgraph is one of:

1. A single vertex, with $p=2$ or $p=7$.
2. The empty graph, with $p=3$ or $p=11$.
3. A triangle, with $p=3$.

In particular, **an involution already has exactly one fixed vertex in this prior classification**. The preceding discussion lists candidate involution fixed subgraphs and excludes all but the single vertex using character integrality. Thus the repository's analyses of $f\ge3$ do not establish a previously unknown restriction.

The slides use

$$\chi_2(g)=\frac{4\alpha_0(g)+\alpha_1(g)-18}{7}.$$

For an involution, $\alpha_0(t)=f$ and $\alpha_1(t)=2\varepsilon_1$. This is the antecedent for the modular trace condition reconstructed in the repository.

## Relation to later results

- Behbahani–Lam (2011) further restrict prime-order automorphisms to orders 2 and 3, excluding order 7. Cesarz–Woldar (2025) explicitly recall this result.
- Crnković–Maksimović (2020) exclude groups of orders 6 and 9 and require order-3 actions to be fixed-point-free. This is not an exclusion of all order-3 actions.
- Cesarz–Woldar (2025) give computer-free reductions including the implication that an even automorphism-group order divides 6. Combining this with the exclusion of order 6 leaves order 2; this consequence is not a new mathematical discovery of this project.

## Repository verification boundary

These are bibliographic antecedents, not claims that the full cited proofs have been encoded in Lean here. The project's standalone arithmetic implications are **PROVED** within their audited statements; graph-level wrappers using external group or spectral premises are **COMPILED**. Completing those formal interfaces and establishing novelty of a distinct implementation remain **PENDING**.
