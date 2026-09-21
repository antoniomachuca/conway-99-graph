# Technical Audit: Partial Formalization and Symmetry-Restricted Search for Conway-99

**Author:** Antonio Machuca — Universidad Rey Juan Carlos, Madrid, Spain

**Revision:** September 21, 2026

**Companion documents:** [README](../README.md), [technical-note source](../manuscript/conway_involutions.tex), [PDF](../manuscript/conway_involutions.pdf).

## 1. Scope and corrections

This report separates prior mathematical results, kernel-checked statements, recorded SAT refutations, and exploratory computations. It supersedes the earlier report's claims of a new involution classification and complete certification of the graph-level exclusions.

The claim that all advertised exclusions were proved end-to-end in Lean is incorrect: **The claim is false according to the current state of the repository.** Standard axiom dependencies do not establish that a theorem's added hypotheses follow from the graph definition.

The audit inspected source and retained logs, ran `lake build`, the 13 canonical compiler tests, targeted `#print axioms` checks, a small encoding counterexample, and the incidence/stabilizer calculation. It did not rerun the historical DRAT checks, launch graph searches, inspect remote processes, or repair the encoders.

**PENDING:** no original graph-theoretic restriction, complete rigidity theorem, or resolution of existence is established by this audit. A methodological contribution would require its own validation and literature comparison.

## 2. Prior results are not contributions of this repository

- Makhnev's September 2009 presentation attributes to Makhnev–Minakova a classification of prime-order actions whose order-2 case has exactly one fixed vertex. Theorem 1 and the preceding character-integrality argument already exclude the other involution fixed-subgraph candidates. [Primary lecture slides](https://www.math.uni-bielefeld.de/~baumeist/sommerschule/makhnev.pdf).
- Behbahani–Lam (2011) restrict prime-order automorphisms to 2 and 3. Thus the exclusion of order 7 predates this project. The introduction of [Cesarz–Woldar (2025)](https://alco.centre-mersenne.org/articles/10.5802/alco.418/) explicitly recalls this result.
- Crnković–Maksimović (2020) exclude groups of orders 6 and 9 and require an order-3 automorphism to act without fixed points. This does not exclude the fixed-point-free order-3 action. [Article](https://cdm.ucalgary.ca/article/view/62323).
- Cesarz–Woldar give computer-free proofs of $2\mid|\operatorname{Aut}(G)|\Rightarrow|\operatorname{Aut}(G)|\mid6$ and $7\mid|\operatorname{Aut}(G)|\Rightarrow\operatorname{Aut}(G)\cong\mathbb Z_7$. Their contribution is not a claim that the order-7 action was previously computationally open.

Combining the even-order bound with exclusion of order 6 leaves order 2. This is a consequence of prior work, not a new parity-rigidity discovery here. Published mathematics and local formalization status must be recorded separately.

## 3. Definitions and audited Lean components

For a binary symmetric matrix with zero diagonal, the equation

$$A^2+A=12I+2J$$

encodes the parameters $(99,14,1,2)$. The spectrum is $\{14^1,3^{54},(-4)^{44}\}$. The induced neighborhood is $7K_2$, not a union of seven triangles.

### 3.1 PROVED: the checker and selected structural lemmas

Targeted axiom checks returned only `[propext, Quot.sound]` for:

- `conway_soundness` and `conway_complete`: equivalence of `checkConway A = true` and `ConwayAdj A` in [Decidable.lean](../Conway/Decidable.lean).
- `conway_k4_free`, `conway_neighborhood_one_factor`, and `conway_diameter_at_most_two` in [Structural.lean](../Conway/Structural.lean).
- `conway_z2_f3_fixed_points_dichotomy` in [Z2Classification.lean](../Conway/Z2Classification.lean).

These statements are checked consequences of their stated hypotheses. They neither produce a candidate graph nor establish a novel restriction beyond the literature. This inventory is not an assertion that every declaration in the imported modules has been audited.

### 3.2 PROVED arithmetic; COMPILED graph-level wrappers

For $f=5$, the final nonexistence declaration includes

$$\exists\varepsilon_1\in\mathbb N:\quad
(\varepsilon_1=18\ \lor\ \varepsilon_1=15)\ \land\ \varepsilon_1\bmod7=6.$$

For $f=7$, the corresponding added condition is

$$\exists\varepsilon_1\in\mathbb N:\quad
\varepsilon_1\in\{7,10,13\}\ \land\ \varepsilon_1\bmod7=2.$$

The kernel refutes these arithmetic conjunctions. The declarations do not derive the relevant number, counting formula, spectral congruence, and exhaustive candidate census from `(A, t)`. The standalone arithmetic incompatibilities are **PROVED**; the advertised complete graph exclusions remain **COMPILED**, with their missing interfaces **PENDING**.

[ParityRigidity.lean](../Conway/ParityRigidity.lean) defines `ConwayAutGroupBounds` with the external restrictions as fields. Its principal result proves an implication from these fields. It does not construct the bounds for the automorphism group of every `ConwayAdj` matrix.

[CesarzWoldarTheorems.lean](../Conway/CesarzWoldarTheorems.lean) verifies terminal contradictions such as $7a=62$ and a sum of even numbers equaling 5. The complete graph-action reductions in the published paper are not reconstructed in the kernel by those arithmetic lemmas.

### 3.3 COMPILED: unfinished nonexistence and aggregate declarations

`lake build` completed with 32 jobs and warnings for `sorry` in:

- [Z7NonExistence.lean](../Conway/Z7NonExistence.lean);
- [Z3Fixed3NonExistence.lean](../Conway/Z3Fixed3NonExistence.lean);
- [Z3FpfNonExistence.lean](../Conway/Z3FpfNonExistence.lean).

`#print axioms Matrix99.conway_automorphism_group_restricted` returned `[sorryAx, Quot.sound]`. Moreover, its actual statement combines exclusions for specified actions; it is not itself a theorem about the cardinality of the full automorphism group. Comments and theorem names must not be substituted for checking the statement.

## 4. Analytical reconstructions, not new kernel-certified exclusions

**EXPLORED:** the following are mathematical derivations explaining the encodings and arithmetic checks. They are not presented as new results or as a completed Lean formalization. Their use in an end-to-end certified reduction remains **PENDING**.

### 4.1 Spectral trace

Let an involution $t$ have $f$ fixed vertices, and let $\varepsilon_1$ count unordered adjacent transposed pairs. If $a,c$ are the $+1$ multiplicities on the eigenspaces for 3 and $-4$, respectively, then

$$a+c=\frac{97+f}{2},\qquad
2\varepsilon_1=\operatorname{Tr}(AP_t)=28+6a-8c.$$

Thus

$$\varepsilon_1=7a-180-2f,\qquad
\varepsilon_1\equiv5(f-1)\pmod7.$$

This is compatible with the character expression in Makhnev's presentation,

$$\chi_2(t)=\frac{4f+2\varepsilon_1-18}{7}=2a-54.$$

The character-integrality method is prior work, not a new obstruction introduced by this repository.

### 4.2 Counting identity

Write $F=\operatorname{Fix}(t)$, $U=V(G)\setminus F$, $H=G[F]$, $m=|E(H)|$, and $d(u)=|N(u)\cap F|$ for $u\in U$.

The common-neighbor set of $u,t(u)$ is invariant under $t$. Its fixed points are exactly the fixed neighbors of $u$. Consequently, adjacent transposed vertices have $d(u)=1$, while nonadjacent transposed vertices have $d(u)\in\{0,2\}$.

Let $N_2$ be the number of vertices in $U$ with $d(u)=2$, and put $S=\sum_{z\in F}\binom{\deg_H(z)}2$. Counting edges from $F$ to $U$ gives

$$2\varepsilon_1+2N_2=14f-2m.$$

Counting common neighbors of unordered pairs of fixed vertices gives

$$N_2=f(f-1)-m-S.$$

Subtracting yields, in the integers,

$$\varepsilon_1=f(8-f)+S.$$

A negative value of the base term $f(8-f)$ alone is not a contradiction: the nonnegative term $S$ must also be bounded. Nor does $\lambda=1$ alone imply that $H$ has maximum degree 2; the $3\times3$ lattice graph is already a degree-4 example with $\lambda=1$. The earlier manuscript's blanket degree bound and its resulting classification into paths and long cycles are withdrawn.

For a coclique, $S=0$, so $\varepsilon_1\ge0$ gives $f\le8$. Combining the trace congruence with odd $f$ leaves $f=1$. This reconstructs part of a known exclusion; it does not establish priority or certify all higher-$f$ Python/SMT searches. Those scripts remain **EXPLORED** under the project rules.

## 5. SAT evidence and the encoding defect

### 5.1 PROVED only at the recorded formula level

The retained files include the following terminal records:

| Recorded input | Solver record | Checker record | Scope |
|---|---|---|---|
| `conway_z2_f3_case_a.cnf` | [Case A log](../cadical_z2_f3_case_a.log): `s UNSATISFIABLE`, 1,040 conflicts | [Case A checker log](../drat_trim_z2_f3_case_a.log): `s VERIFIED` | One retained input/proof record; not evidence for every historical partition. |
| `conway_z2_f3_case_b.cnf` | [Case B log](../cadical_z2_f3_case_b.log): `s UNSATISFIABLE`, 1,150 conflicts | [Case B checker log](../drat_trim_z2_f3_case_b.log): `s VERIFIED` | The specified formula, not a verified graph-to-CNF equivalence. |
| `conway_z7_canonical.cnf` | [Order-7 log](../cadical_z7.log): `s UNSATISFIABLE`, 771.59 s process time | [Order-7 checker log](../drat_trim_z7.log): `s VERIFIED`, 844.008 s | Historical verification record; exact input absent from the audited repository root. |

The order-7 checker reports binary-mode checking and 192,218,491 proof bytes. Earlier descriptions of that trace as non-binary should not be relied upon. The secondary hunter's terminal UNSAT is corroborating solver output, not a second independently checked DRAT proof.

These logs were read during the audit; the DRAT checks were not rerun. To reproduce a check, preserve or recover the exact formula, proof, generator revision, options, and file hashes. The presence of a proof file is not evidence of completion. Generating a new formula with the current compiler does not establish that it matches a historical input.

### 5.2 Semantic repair of the compiler helper methods

The earlier audit correctly discovered that historical versions of [order-7 compiler](../scripts/build_z7_canonical_cnf.py) and [order-3 compiler](../scripts/build_z3_canonical_cnf.py) allocated primary variable ID 1 and simultaneously treated integer `1` as the constant True in their helper methods `get_and_lit` and `add_card_equals`.

A small counterexample, requiring no graph search, demonstrated the defect:

```python
from scripts.build_z7_canonical_cnf import ConwayZ7CanonicalCompiler

compiler = ConwayZ7CanonicalCompiler(enable_lex=False)
assert compiler.var_map[(0, 0, 1)] == 1
compiler.add_card_equals([1, 2], 1)
print(compiler.cnf.clauses)
```

In the unpatched code, the output was `[[-2]]`, collapsing $x_1+x_2=1$ into a false assignment whenever $x_1=0$.

**REPAIRED (September 21, 2026):**
1. In [build_z7_canonical_cnf.py](../scripts/build_z7_canonical_cnf.py) and [build_z3_canonical_cnf.py](../scripts/build_z3_canonical_cnf.py), the conflation of literal `1` with boolean True was removed. Literal `0` remains the reserved non-literal sentinel for known non-edges / False; primary variable 1 is treated as an ordinary Boolean variable, and Tseitin conjunctions $y \iff x_1 \land x_2$ allocate fresh auxiliary variables properly.
2. In [test_canonical_sat_compilers.py](../tests/test_canonical_sat_compilers.py), the `TestCompilerHelperSemantics` suite was added (4 new regression tests), verifying full truth tables for conjunction and cardinality via CaDiCaL.
3. **Audit of Active $f=1$ Search Provenance:** The instances running on Google Cloud Platform (`instances/conway_z2_f1_branch_a.cnf`, etc.) were generated by [agent_b_cnf_compiler.py](../scripts/agent_b_cnf_compiler.py), which uses an independent Tseitin allocation method without constant-1 shortcuts (`if a == 1:`). The active $>1.06\times 10^9$ conflict $f=1$ search space is structurally immune to this compiler defect.

The general epistemological requirement remains:

$$\text{graph satisfying the branch hypotheses}\Longrightarrow\text{satisfying assignment of the encoded CNF}.$$

A DRAT certificate checks the CNF refutation, not this implication. A SAT assignment likewise needs decoding and direct validation of all graph parameters before it is a graph witness.


## 6. EXPLORED: incidence structure and canonical branching

For the known one-fixed-vertex involution case, the rooted neighborhood has seven matched pairs and the second subconstituent has 42 transposed pairs. The coordinate description of the 84 outer vertices by nonmatched neighborhood pairs is already present in prior work, including Section 2 of Cesarz–Woldar.

Let $C$ be the **binary support-incidence matrix** on the seven neighborhood pairs and the 42 outer orbits; an entry records whether a neighborhood pair is in an orbit's support. It is not the cardinality of the intersection of that neighborhood pair with the union of both outer vertices' neighborhoods.

The script [classify_z2_f1_incidence_matrix.py](../scripts/classify_z2_f1_incidence_matrix.py) constructs $C=[C_1\mid C_1]$, where $C_1$ is the vertex-edge incidence matrix of $K_7$, and checks

$$CC^T=10I_7+2J_7.$$

For a binary $7\times42$ matrix satisfying this equation, let $k_j$ be its column sums. Then

$$\sum_j k_j=84,\qquad
\sum_j k_j^2=\mathbf1^TCC^T\mathbf1=168,\qquad
\sum_j(k_j-2)^2=0.$$

Every column therefore has weight 2, and each unordered row pair occurs twice. The earlier manuscript incorrectly substituted $\operatorname{Tr}(C^TC)$ for $\sum_j k_j^2$; that trace is 84, not 168. The variance calculation above uses the correct quadratic form, as does the script's explanatory derivation.

Two different relabeling groups must be distinguished:

- The binary incidence matrix alone permits independent swaps of its 21 duplicate-column pairs, giving $(S_2)^{21}\rtimes S_7$ of order 10,569,646,080 under row/column relabeling.
- The signed rooted coordinate system uses $W=(\mathbb Z_2)^7\rtimes S_7$, of order 645,120. Its action on the 42 orbit labels has the global sign flip in its kernel. This is not the full automorphism group of the undecorated binary matrix.

The audited Python calculation returns:

```text
transitive_on_orbits: True
pair_orbit_sizes: [21, 420, 420]
stab_O0_order: 15360
stab_O0_partition_sizes: [1, 1, 20, 20]
```

After excluding the distinguished label itself, the remaining classes have sizes $1,20,20$: identical support with opposite phase, intersecting support, and disjoint support. The branch generator chooses representatives from these classes for the proposed $K_{2,2}$ partner of the distinguished orbit.

The numbers 15,360 and 768 are stabilizer orders in this description, not measured runtime speedups. **PENDING:** a complete audit of the graph-to-model mapping, the partner reduction, all symmetry cuts, and the resulting CNF coverage. Originality of this particular implementation is not established by reproducing the group calculation.

## 7. Verification and research priorities

The [README verification section](../README.md#4-verification-commands) gives commands for the build, existing tests, targeted axiom audit, and manuscript compilation. The verification boundary is deliberate:

1. **PROVED:** the specifically audited Lean statements and the historical formula-level certificate records, within their exact scopes.
2. **COMPILED:** the library with unfinished declarations and the tested but semantically incomplete encoders.
3. **EXPLORED:** incidence calculations, uncertified SMT analyses, and inconclusive SAT executions.
4. **PENDING:** repairs, full encoding validation, missing formal interfaces, methodological novelty, and unresolved mathematical cases.

No current process table, cloud balance, disk capacity, probability of satisfiability, or time-to-UNSAT is asserted here. Historical operational claims are retained in [the audit log](../agents/audit_log.md) with a superseding notice. See [the strategy report](solver_strategy_and_probability_report.md) for why conflict totals and restart diversity do not provide mathematical probabilities.

The checker, structural formalization, and explicit orbit calculations can be useful without any further UNSAT result. They do not establish that the graph exists or does not exist, and symmetry-restricted searches cannot find a rigid graph. The next defensible step is validation of the mathematical and encoding interfaces, rather than treating accumulated computation as a new theorem.
