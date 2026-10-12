# Reference Index and Prior-Work Attribution

**Revised:** September 21, 2026.

This directory stores reference dossiers written for this project. It does not distribute copies of third-party papers; copies that were here earlier were removed on 12 October 2026 for copyright reasons. Obtain the papers from the publishers or the authors. A dossier is not evidence that every interpretation previously attached to it is correct. The [current technical note](../manuscript/conway_involutions.tex) and [technical audit](../docs/technical_report.md) distinguish literature results from local formalization status.

## Sources central to the corrected account

| BibTeX key | Publication | Relevance and boundary |
|---|---|---|
| `makhnev2001automorphisms` | Makhnev–Minakova, *On automorphisms of strongly regular graphs with the parameters λ = 1 and μ = 2*, 2004 | Prior automorphism classification; the legacy key is not the publication year. [Corrected dossier](paper_makhnev_minakova_2004.md), [DOI](https://doi.org/10.1515/156939204872374). |
| `makhnev2009symmetric` | Makhnev, *Symmetric graphs and their automorphisms*, Berlin, September 2009 | Theorem 1 explicitly attributes to Makhnev–Minakova the restriction that an involution fixes exactly one vertex. [Primary slides](https://www.math.uni-bielefeld.de/~baumeist/sommerschule/makhnev.pdf); not a newly downloaded local artifact. |
| `behbahani2011strongly` | Behbahani–Lam, *Strongly regular graphs with non-trivial automorphisms*, 2011 | Prime-order automorphisms restricted to 2 and 3; order 7 already excluded. [DOI](https://doi.org/10.1016/j.disc.2010.10.005). The 2009 thesis of Behbahani (Concordia University, ISBN 978-0-494-63369-4) is background material, not the journal article itself. |
| `crnkovic2014strongly` | Crnković–Maksimović, *Construction of strongly regular graphs having an automorphism group of composite order*, 2020 | Exclusion of groups of orders 6 and 9. The fixed-point-free property of order-3 automorphisms is cited from Behbahani–Lam, not proved here; the fixed-point-free order-3 action is not excluded. [Article](https://cdm.ucalgary.ca/article/view/62323). |
| `cesarz2025automorphisms` | Cesarz–Woldar, *On the automorphism group of a putative Conway 99-graph*, 2025 | Computer-free reductions and explicit summary of earlier computational exclusions. [Publisher](https://alco.centre-mersenne.org/articles/10.5802/alco.418/). |
| `brouwer2011spectra` | Brouwer–Haemers, *Spectra of Graphs*, 2012 | Spectral background. The authors report release in December 2011 and copyright year 2012. [Author's page](https://homepages.cwi.nl/~aeb/math/ipm/). |
| `heule2013verifying` | Wetzler–Heule–Hunt, *DRAT-trim: Efficient Checking and Trimming Using Expressive Clausal Proofs*, SAT 2014 | Formula-refutation checking; does not certify a graph-to-CNF translator. The legacy key is retained with corrected metadata. [DOI](https://doi.org/10.1007/978-3-319-09284-3_31), [author-hosted paper](https://www.cs.utexas.edu/~marijn/publications/drat-trim.pdf). |
| `moura2021lean4` | de Moura–Ullrich, *The Lean 4 Theorem Prover and Programming Language*, 2021 | Theorem-prover background. [Local dossier](paper_moura_ullrich_lean4.md). |

The BibTeX file retains historical keys for compatibility. Dates and authors should be taken from the corrected entry, not inferred from a key name.

## Other sources (not distributed here)

- Conway's problem list, *Five $1,000 Problems (Update 2017)*: background on the problem and prize; do not identify its modern circulation date with the first investigation of the parameter set.
- Thakkar–Severini, [arXiv:2608.11211](https://arxiv.org/abs/2608.11211) (2026): computational experiments. A reported timeout or a characterization of order 7 as open does not override the earlier exclusion recalled by Cesarz–Woldar. No controlled speedup comparison with this repository is established.
- The CaDiCaL system description (Biere et al., 2019), the DRAT-trim paper (linked above), the [Cameron dossier](paper_cameron_1972.md), and the [Higman dossier](paper_higman_1964.md): supporting or historical material; their presence is not certification of the project-specific inferences.
- The Ouimet–Greaves preprint: historical background for the earlier disclosure discussion, not mathematical evidence for the Conway investigation.

## Operational status

The literature supplies antecedents, not local kernel certificates. **PROVED** is reserved in the current project account for precisely audited Lean statements and recorded checked formula refutations. Conditional wrappers remain **COMPILED**, uncertified calculations **EXPLORED**, and complete formalization or a distinct originality claim **PENDING**.
