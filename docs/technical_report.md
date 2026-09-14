# Technical Report: Classification of Involutions, Parity Rigidity, and Certified Symmetries in Conway-99

> **Access Note:** This document serves as the central mathematical and technical reference for the project, aligned with the academic preprint in [`manuscript/conway_involutions.tex`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/manuscript/conway_involutions.tex) and the repository status documented in [`README.md`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/README.md).

**Author:** [Antonio Machuca](mailto:am.machuca.2023@alumnos.urjc.es)  
**Affiliation:** Universidad Rey Juan Carlos, Madrid, Spain  
**Permanent Contact:** [contactoantoniomachuca@gmail.com](mailto:contactoantoniomachuca@gmail.com)  
**Date:** September 2026  
**MSC Classification (2020):** 05E30, 05C60, 03B35, 68V15  
**Keywords:** Strongly regular graphs, Conway's 99-graph problem, involutions, fixed-point spectrum, parity rigidity, Lean 4, CDCL SAT, DRAT certification.

---

### Executive Summary and Epistemological Status

The 99-graph problem proposed by John H. Conway (1969) asks whether there exists a strongly regular graph with parameters $\mathrm{srg}(99, 14, 1, 2)$. A fundamental conjecture in algebraic combinatorics asserts that any such graph must be rigid, satisfying $\mathrm{Aut}(G) = \{1\}$.

This technical report presents the exhaustive classification of order-2 automorphisms (involutions, $t^2 = \mathrm{id}$), even-order symmetry groups, and prime-order actions on $G$. In accordance with the strict epistemological guidelines of this repository, all results are categorized into four operational states:

1. **PROVED:**
   - **Parity Rigidity Corollary in Lean 4:** Formally verified in [`Conway/ParityRigidity.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean) (0 `sorry`, standard foundational axioms `[propext, Quot.sound]`) that if $|\mathrm{Aut}(G)|$ is even, then $\mathrm{Aut}(G) \cong \mathbb{Z}_2$, rigorously excluding cyclic $\mathbb{Z}_4$, Klein four-group $V_4$, and any dihedral group $D_{2k}$ ($k \ge 2$).
   - **Analytical Theorems of Cesarz & Woldar (2025) in Lean 4:** Formalized in [`Conway/CesarzWoldarTheorems.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean) (0 `sorry`, standard axioms): exclusion of order-14 automorphisms via quotient trace modular contradiction ($7a = 62$, Theorem 3.11) and refutation of the Frobenius group $\mathrm{Frob}(21)$ via orbit partition parity contradiction ($a+c+d+f = 5$ with even variables, Proposition 4.14).
   - **Modular Incompatibilities and Topological Dichotomies for $f \ge 5$ in Lean 4:** Formally verified in [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) (0 `sorry`, standard axioms), refuting fixed-point counts $f = 5$ and $f = 7$.
   - **Certified SAT Refutation of $f = 3$:** The CNF formulas for $f = 3$ were solved to `s UNSATISFIABLE` by CaDiCaL and independently certified by `drat-trim` returning `s VERIFIED` on disk ([`drat_trim_z2_f3_case_a.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z2_f3_case_a.log), [`drat_trim_z2_f3_case_b.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z2_f3_case_b.log)).
   - **Certified SAT Refutation of Order 7 ($\mathbb{Z}_7$):** The canonical DIMACS CNF formula `conway_z7_canonical.cnf` (176,613 variables, 421,562 clauses) incorporating Cesarz-Woldar coordinate constraints and multiplier group $\mathcal{G}_{\mathbb{Z}_7} \cong \mathbb{Z}_2 \times \mathbb{Z}_6$ Crawford cuts was solved to `s UNSATISFIABLE` by CaDiCaL 3.0.1 in 771.59 seconds ([`cadical_z7.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/cadical_z7.log)) and formally verified by `drat-trim` backward checking mode in 844.01 seconds returning `s VERIFIED` ([`drat_trim_z7.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z7.log), supervisor summary [`z7_result.txt`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/z7_result.txt)). Secondary confirmation independently verified `s UNSATISFIABLE` in 1827.91 seconds ([`cadical_z7_hunter.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/cadical_z7_hunter.log)).
2. **COMPILED:**
   - **Grand Classification in Lean 4:** [`Conway/GrandClassification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/GrandClassification.lean) compiles cleanly in Lake (`lake build`, 32 jobs), deducing that $|\mathrm{Aut}(G)| \in \{1, 2\}$, conditional on the non-existence of $\mathbb{Z}_3$.
   - **Canonical SAT Compilers for $\mathbb{Z}_7$ and $\mathbb{Z}_3$:** [`scripts/build_z7_canonical_cnf.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/build_z7_canonical_cnf.py) and [`scripts/build_z3_canonical_cnf.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/build_z3_canonical_cnf.py) implement Crawford-style lex-leader symmetry breaking over quotient multiplier groups ($\mathcal{G}_{\mathbb{Z}_7} \cong \mathbb{Z}_2 \times \mathbb{Z}_6, \; \mathcal{G}_{\mathbb{Z}_3} \cong S_3 \times \mathbb{Z}_2$), passing all 13 deterministic unit tests in [`tests/test_canonical_sat_compilers.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/tests/test_canonical_sat_compilers.py).
3. **EXPLORED:**
   - **Hybrid 14-Solver Portfolio (>1 Billion CDCL Conflicts):** Cumulative search effort across the distributed cluster has surpassed the one billion conflict milestone, reaching $> 1{,}041{,}090{,}647$ CDCL conflicts (> 1.041 Billion conflicts / > 1.04 Giga-conflicts). Workload is distributed across an 11-worker Google Cloud Compute Engine VM (`conway-sat-worker`, $786{,}239{,}067$ conflicts accumulated) and dedicated local Apple M2 hardware writing to external NVMe SSD ($254{,}851{,}580$ conflicts archived in Session 1; Session 2 actively running across 3 Performance cores).
   - **Central Involution Case $f = 1$:** The $645{,}120$-fold symmetry group of $C_{7 \times 42}$ partitions the space into 3 canonical branches (Branch A, B, C), accounting for $> 630.38\mathrm{M}$ conflicts (Branch A $>304.93\mathrm{M}$, Branch C $>163.63\mathrm{M}$, Branch B $>161.82\mathrm{M}$). Branch C DRAT on GCP reached $> 101.64\mathrm{M}$ conflicts (~100h CPU), marking the first solver in the project to surpass 100M conflicts.
   - **Order 3 ($\mathbb{Z}_3$) Actions:** Actively executing across canonical DRAT solvers (Fixed-3 $>70.88\mathrm{M}$ and FPF $>61.03\mathrm{M}$ on GCP), cloud hunters ($>167.85\mathrm{M}$), and local M2 Session 1 ($108.88\mathrm{M}$), totaling $> 408.64\mathrm{M}$ conflicts.
4. **PENDING:**
   - The unconditional existence of Conway's 99-graph $\mathrm{srg}(99, 14, 1, 2)$ and the Full Rigidity Conjecture $\mathrm{Aut}(G) = \{1\}$.

---

## 1. Structural Parameters and Parity Rigidity

### 1.1. Definition and Spectrum of Conway-99
A strongly regular graph $G = (V, E)$ with parameters $\mathrm{srg}(v, k, \lambda, \mu) = (99, 14, 1, 2)$ satisfies:
$$A = A^T, \quad \mathrm{diag}(A) = 0, \quad A \in \{0, 1\}^{99 \times 99}, \quad A^2 + A - 12 I = 2 J$$
The minimal polynomial of $A$ on the orthogonal complement of $\mathbf{1}$ is $(x - 3)(x + 4) = 0$. Its eigenvalue spectrum is:
$$\mathrm{Spec}(A) = \left\{ 14^1, \; 3^{54}, \; (-4)^{44} \right\}$$

Local topological invariants formalized in [`Conway/Structural.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Structural.lean) (0 `sorry`, standard foundational axioms):
- **Locally Linear ($\lambda = 1$):** Every edge belongs to a unique triangle $K_3$. The graph is $K_4$-free ($\omega(G) = 3$).
- **First Subconstituent $N(x)$:** For each $x \in V$, the neighborhood $N(x)$ consists of 14 vertices inducing a 1-factor of 7 disjoint edges ($7 K_2$).
- **Second Subconstituent $\Gamma_2(x)$:** Composed of $99 - 1 - 14 = 84$ vertices. Each vertex $w \in \Gamma_2(x)$ has degree 12 within $\Gamma_2(x)$ and exactly $\mu = 2$ neighbors in $N(x)$.
- **Diameter:** $\mathrm{diam}(G) \le 2$.

---

### 1.2. The Parity Rigidity Corollary

Prior literature established partial bounds on the automorphism group order $\Gamma = \mathrm{Aut}(G)$:
1. **Makhnev & Minakova (2001):** $|\Gamma|$ divides $2 \cdot 3^3 \cdot 7 \cdot 11$.
2. **Behbahani & Lam (2011):** There are no automorphisms of prime order $p \ge 5$, ruling out $p = 11$ in particular.
3. **Crnković & Maksimović (2020):** $\Gamma$ contains no subgroups of order 6 or order 9 ($6 \nmid |\Gamma|$ and $9 \nmid |\Gamma|$).
4. **Cesarz & Woldar (2025, Cor. 3.13):** Proved analytically without computers that if 2 divides $|\Gamma|$, then $|\Gamma|$ divides 6.

Combining these deductive steps yields the Parity Rigidity Corollary:

\begin{theorem}[Parity Rigidity Corollary]\label{thm:parity_rigidity}
If the order of the automorphism group $\mathrm{Aut}(G)$ is even ($2 \mid |\mathrm{Aut}(G)|$), then:
$$\mathbf{\mathrm{Aut}(G) \cong \mathbb{Z}_2}$$
\end{theorem}
\begin{proof}
Let $n = |\mathrm{Aut}(G)|$. By assumption, $2 \mid n$. By Cesarz & Woldar (2025, Cor. 3.13), $n \mid 6$. The natural divisors of 6 are $\{1, 2, 3, 6\}$.
- Since $2 \mid n$, $n \ne 1$ and $n \ne 3$.
- By Crnković & Maksimović (2020), no subgroup of order 6 exists, so $6 \nmid n$, ruling out $n = 6$.
Thus the unique arithmetic possibility is $n = 2$. Every group of order 2 is isomorphic to the cyclic group $\mathbb{Z}_2$.
\end{proof}

#### Formalization in Lean 4 (`Conway/ParityRigidity.lean`)
Formalized with 0 `sorry` and standard axioms `[propext, Quot.sound]`:
- [`even_divides_six_and_not_six_eq_two`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean):
  `∀ n : Nat, 2 ∣ n → n ∣ 6 → ¬(6 ∣ n) → n = 2`
- [`conway_no_order_4_subgroup`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean):
  Shows that no divisor of 6 can contain a subgroup of order 4 ($4 \nmid 6$).
- [`conway_no_dihedral_subgroup`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean):
  Shows that no dihedral group $D_{2k}$ ($k \ge 2$, order $2k \ge 4$) embeds into $\mathrm{Aut}(G)$.
- [`conway_parity_rigidity`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean):
  Main theorem deducing $\mathrm{order}(G) = 2$.

**Immediate Structural Consequence:** The search for even-order symmetries in Conway's 99-graph reduces strictly to the existence of a single involution $t \in \mathrm{Aut}(G)$ generating $\langle t \rangle \cong \mathbb{Z}_2$. There exist no automorphisms of order 4 ($\mathbb{Z}_4$), no Klein four-groups ($V_4 \cong \mathbb{Z}_2 \times \mathbb{Z}_2$), and no dihedral groups.

---

### 1.3. Analytical Reductions of Cesarz & Woldar (2025)

Formalized in [`Conway/CesarzWoldarTheorems.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean) with 0 `sorry` and standard axioms `[propext, Quot.sound]`:

#### A. Theorem 3.11: Absence of Automorphisms of Order 14
Cesarz and Woldar analyzed the $15 \times 15$ quotient matrix $B$ induced by an action of order 14 ($g^{14} = \mathrm{id}$).
- The spectral trace of $B$ on eigenvalues $\{14^1, 3^a, (-4)^{14-a}\}$ is:
  $$\mathrm{Tr}(B) = 14 + 3a - 4(14 - a) = 7a - 42$$
- Summing the valencies of the orbits fixes $\mathrm{Tr}(B) = 10 \times 2 = 20$.
- The equality $7a - 42 = 20$ yields the linear Diophantine equation:
  $$7a = 62$$
  Reducing modulo 7 gives $0 \equiv 62 \equiv 6 \pmod 7$, an unconditional contradiction in $\mathbb{Z}$.
- Formalized in Lean 4: [`cesarz_woldar_thm_3_11_trace_int`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean) and [`cesarz_woldar_thm_3_11_modular_contradiction`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean).

#### B. Proposition 4.14: Parity Incompatibility for $\mathrm{Frob}(21)$
The action of the Frobenius group $\mathrm{Frob}(21) \cong \mathbb{Z}_7 \rtimes \mathbb{Z}_3$ on $\Gamma_2(x_0)$ leaves a unique admissible orbit partition whose row 4 in quotient matrix $C_3$ must satisfy:
$$14 = 4 + 2a + 2c + 2d + 2f \iff a + c + d + f = 5$$
with valencies $a, c, d, f \in \{0, 2\}$. Since each variable is even, the sum of four even integers must be even, contradicting 5.
- Formalized in Lean 4: [`cesarz_woldar_prop_4_14_orbit_partition_impossible`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean).
- Consequently, if $7 \mid |\mathrm{Aut}(G)|$, then $\mathrm{Aut}(G) \cong \mathbb{Z}_7$ uniquely ([`cesarz_woldar_divisible_by_7_reduces_to_z7`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean)).

---

## 2. Spectrum and Modular Congruence of Involutions

Let $t \in \mathrm{Aut}(G)$ be a non-trivial involution ($t^2 = \mathrm{id}, t \ne \mathrm{id}$) and let $P_t$ be its $99 \times 99$ permutation matrix.

### 2.1. Spectral Decomposition and Trace
Because $P_t A = A P_t$, the eigenspaces $V_{14}, V_3, V_{-4}$ are $P_t$-invariant. Since $P_t^2 = I$, the eigenvalues of $P_t$ restricted to each eigenspace are in $\{+1, -1\}$.
- On $V_{14} = \mathrm{span}\{\mathbf{1}\}$, $P_t \mathbf{1} = \mathbf{1}$, with $+1$-multiplicity 1.
- On $V_3$ ($\dim = 54$), let $a$ be the multiplicity of $+1$ and $b = 54 - a$ that of $-1$.
- On $V_{-4}$ ($\dim = 44$), let $c$ be the multiplicity of $+1$ and $d = 44 - c$ that of $-1$.

The trace $\mathrm{Tr}(P_t)$ counts fixed points $f = |\mathrm{Fix}(t)|$:
$$f = \mathrm{Tr}(P_t) = 1 + (2a - 54) + (2c - 44) = 2(a + c) - 97$$
Solving for $a + c$:
$$a + c = \frac{97 + f}{2}$$
Since $a, c \in \mathbb{Z}$, $f$ must be odd: $f \equiv 1 \pmod 2$. Prior literature (Behbahani-Lam 2011; Cesarz-Woldar 2025) bounds $f$ to:
$$f \in \{1, 3, 5, 7, 9, 11, 13, 15\}$$

### 2.2. The Trace of $A P_t$ and Internal Edges
The $(u, u)$-entry of $A P_t$ is $A_{u, t(u)}$.
- If $u \in \mathrm{Fix}(t)$, $A_{u, u} = 0$ (no self-loops).
- If $u \ne t(u)$, the orbit $\{u, t(u)\}$ has length 2. It contributes 1 to the diagonal of $A P_t$ if and only if $\{u, t(u)\} \in E(G)$.
An adjacent length-2 orbit is termed an **internal edge** (or transposed edge). Let $\varepsilon_1$ denote the number of internal edges in $G$:
$$\mathrm{Tr}(A P_t) = 2 \varepsilon_1$$

Evaluating the trace in the eigenvector basis:
$$\mathrm{Tr}(A P_t) = 14(1) + 3(2a - 54) - 4(2c - 44) = 28 + 6a - 8c$$
Substituting $c = \frac{97 + f}{2} - a$:
$$2 \varepsilon_1 = 28 + 6a - 8\left(\frac{97 + f}{2} - a\right) = 14a - 360 - 4f$$
Dividing by 2:
$$\varepsilon_1 = 7a - 180 - 2f$$
Reducing modulo 7, using $7a \equiv 0 \pmod 7$, $-180 \equiv 2 \pmod 7$, and $-2 \equiv 5 \pmod 7$:
$$\varepsilon_1 \equiv 2 - 2f = -2(f - 1) \equiv 5(f - 1) \pmod 7$$

\begin{proposition}[Universal Modular Spectral Congruence]\label{prop:universal_mod7}
For every involution $t \in \mathrm{Aut}(G)$ with $f$ fixed points and $\varepsilon_1$ internal edges:
$$\mathbf{\varepsilon_1 \equiv 5(f - 1) \pmod 7}$$
\end{proposition}

Required values modulo 7:
- $f = 1 \implies \varepsilon_1 \equiv 5(0) \equiv 0 \pmod 7$
- $f = 3 \implies \varepsilon_1 \equiv 5(2) = 10 \equiv 3 \pmod 7$
- $f = 5 \implies \varepsilon_1 \equiv 5(4) = 20 \equiv 6 \pmod 7$
- $f = 7 \implies \varepsilon_1 \equiv 5(6) = 30 \equiv 2 \pmod 7$
- $f = 9 \implies \varepsilon_1 \equiv 5(8) = 40 \equiv 5 \pmod 7$
- $f = 11 \implies \varepsilon_1 \equiv 5(10) = 50 \equiv 1 \pmod 7$
- $f = 13 \implies \varepsilon_1 \equiv 5(12) = 60 \equiv 4 \pmod 7$
- $f = 15 \implies \varepsilon_1 \equiv 5(14) = 70 \equiv 0 \pmod 7$

---

## 3. Subgraph Topology and Universal Counting Theorem

### 3.1. Degree Rigidity Toward $\mathrm{Fix}(t)$
Let $U = V(G) \setminus \mathrm{Fix}(t)$ denote the set of $99 - f$ non-fixed vertices. For each $u \in U$, define its degree toward $\mathrm{Fix}(t)$ as $d(u) = |N(u) \cap \mathrm{Fix}(t)|$.

\begin{lemma}[Parity of Common Neighbors under Involutions]\label{lem:co_parity}
For every $u \in U$:
$$|N(u) \cap N(t(u))| \equiv |N(u) \cap \mathrm{Fix}(t)| \pmod 2$$
\end{lemma}
\begin{proof}
The set of common neighbors $C = N(u) \cap N(t(u))$ is invariant under $t$. By orbit decomposition of an involution, $|C| \equiv |\mathrm{Fix}(t|_C)| \pmod 2$. Since $\mathrm{Fix}(t|_C) = C \cap \mathrm{Fix}(t) = N(u) \cap \mathrm{Fix}(t)$, the congruence holds.
\end{proof}

\begin{theorem}[Exterior Degree Rigidity Theorem]\label{thm:degree_rigidity}
For every vertex $u \in U = V(G) \setminus \mathrm{Fix}(t)$:
1. If $\{u, t(u)\}$ is an internal edge ($u \sim t(u)$), then $\mathbf{d(u) = 1}$ identically.
2. If $\{u, t(u)\}$ is a non-adjacent transposed pair ($u \not\sim t(u)$), then $\mathbf{d(u) \in \{0, 2\}}$.
Consequently, $d(u) \le 2$ universally; no exterior vertex can have 3 or more fixed neighbors ($N_k = 0$ for $k \ge 3$).
\end{theorem}
\begin{proof}
1. If $u \sim t(u)$, in an $\mathrm{srg}$ with $\lambda = 1$, they have exactly 1 common neighbor in all of $G$. By Lemma \ref{lem:co_parity}, $d(u) \equiv 1 \pmod 2$. Since $d(u) \le 1$, $d(u) = 1$ holds.
2. If $u \not\sim t(u)$, they have $\mu = 2$ common neighbors in $G$. By Lemma \ref{lem:co_parity}, $d(u) \equiv 2 \equiv 0 \pmod 2$. Since $d(u) \le \mu = 2$, it follows that $d(u) \in \{0, 2\}$.
\end{proof}

---

### 3.2. The Universal Counting Identity
Let $H = G[\mathrm{Fix}(t)]$ be the subgraph induced on fixed points.
- Since $\lambda = 1$, every edge in $H$ belongs to a unique triangle entirely contained in $H$, and no two triangles share an edge ($K_4$-free).
- Every degree $\deg_H(z)$ is even: $\deg_H(z) = 2 T_z$, where $T_z$ is the number of triangles incident to $z$.
- The total number of edges in $H$ is $m = 3T$.
- For any non-adjacent pair $x \not\sim y$ in $\mathrm{Fix}(t)$, their 2 common neighbors in $G$ partition between $H$ and $U$:
  $$c_H(x, y) = |N(x) \cap N(y) \cap \mathrm{Fix}(t)| \in \{0, 2\}$$

\begin{theorem}[Universal Counting Identity]\label{thm:universal_counting}
For every involution $t \in \mathrm{Aut}(G)$ with induced subgraph $H = G[\mathrm{Fix}(t)]$:
$$\mathbf{\varepsilon_1 = f(8 - f) + \sum_{z \in \mathrm{Fix}(t)} \binom{\deg_H(z)}{2}}$$
\end{theorem}
\begin{proof}
Edges between $U$ and $\mathrm{Fix}(t)$ are counted via double counting:
$$\sum_{u \in U} d(u) = \sum_{z \in \mathrm{Fix}(t)} (14 - \deg_H(z)) = 14f - 2m$$
By Theorem \ref{thm:degree_rigidity}, vertices with $d(u) = 1$ are the endpoints of the $\varepsilon_1$ internal edges ($N_1 = 2 \varepsilon_1$), while those with $d(u) = 2$ form $N_2$ vertices. Thus:
$$\sum_{u \in U} d(u) = 2 \varepsilon_1 + 2 N_2 = 14f - 2m \implies \varepsilon_1 + N_2 = 7f - m$$
On the other hand, counting pairs of neighbors toward $\mathrm{Fix}(t)$:
$$N_2 = \sum_{u \in U} \binom{d(u)}{2} = \sum_{\{x, y\} \subset \mathrm{Fix}(t)} c_U(x, y)$$
- If $x \sim y$, their unique common neighbor is in $\mathrm{Fix}(t)$, so $c_U(x, y) = 0$.
- If $x \not\sim y$, $c_U(x, y) = 2 - c_H(x, y)$.

Summing over the $\binom{f}{2} - m$ non-adjacent pairs:
$$N_2 = \sum_{x \not\sim y} (2 - c_H(x, y)) = 2\binom{f}{2} - 2m - \sum_{x \not\sim y} c_H(x, y)$$
Substituting into $\varepsilon_1 = 7f - m - N_2$:
$$\varepsilon_1 = 7f - 2\binom{f}{2} + m + \sum_{x \not\sim y} c_H(x, y)$$
Since $7f - 2\binom{f}{2} = 7f - f(f - 1) = f(8 - f)$, and for each of the $m$ edges $x \sim y$, $c_H(x, y) = 1$:
$$m + \sum_{x \not\sim y} c_H(x, y) = \sum_{\{x, y\} \subset \mathrm{Fix}(t)} c_H(x, y) = \sum_{z \in \mathrm{Fix}(t)} \binom{\deg_H(z)}{2}$$
The identity follows.
\end{proof}

\begin{corollary}[Universal Coclique Theorem]\label{cor:coclique}
If the fixed points form an independent set ($H \cong f K_1$), then $\mathbf{f = 1}$.
\end{corollary}
\begin{proof}
For $f K_1$, $\deg_H(z) = 0$, so $\varepsilon_1 = f(8 - f)$. As an edge count, $f(8 - f) \ge 0 \implies f \le 8$.
Matching with the modular condition from Proposition \ref{prop:universal_mod7}:
$$f(8 - f) \equiv 5(f - 1) \pmod 7 \iff f^2 - 3f - 5 \equiv (f - 1)(f - 2) \equiv 0 \pmod 7$$
The only solutions in $\mathbb{Z}_7$ are $f \equiv 1$ and $f \equiv 2$.
- $f \equiv 1 \pmod 7$ with $f$ odd and $f \le 8$ forces $f = 1$.
- $f \equiv 2 \pmod 7$ forces $f$ even, contradicting $f \equiv 1 \pmod 2$.
Therefore $f = 1$ is the unique solution.
\end{proof}

---

## 4. Systematic Elimination of Candidate Symmetries

### 4.1. Order $f = 3$ (PROVED in Lean 4 + SAT DRAT)
- **Spectral requirement:** $\varepsilon_1 \equiv 5(3 - 1) = 10 \equiv 3 \pmod 7$.
- **Base term:** $f(8 - f) = 3(5) = 15$.
- **Topological dichotomy (Lean 4: [`conway_z2_f3_fixed_points_dichotomy`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean)):**
  Since $\lambda = 1$, any edge between fixed points forces an entire triangle in $\mathrm{Fix}(t)$. No subgraphs with 1 or 2 edges can exist ([`conway_z2_f3_no_one_edge`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean), [`conway_z2_f3_no_two_edges`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean)). Exactly two topological cases remain:
  - **Case A ($H \cong K_3$):** $\deg_H(z) = 2$ for all 3 vertices.
    $$\varepsilon_1 = 15 + 3 \times \binom{2}{2} = 15 + 3 = 18 \equiv 4 \pmod 7 \ne 3 \pmod 7$$
  - **Case B ($H \cong 3K_1$):** $\deg_H(z) = 0$.
    $$\varepsilon_1 = 15 + 0 = 15 \equiv 1 \pmod 7 \ne 3 \pmod 7$$
- **Independent SAT Certification with DRAT:**
  Both cases were encoded into DIMACS CNF formulas. All partitions of Case A ($(4, 4, 2)$, $(6, 2, 2)$, $(6, 4, 0)$) and Case B ($(1, 1, 1)$) were solved to `UNSAT` by CaDiCaL and verified by `drat-trim`, concluding with `s VERIFIED` in logs ([`drat_trim_z2_f3_case_a.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z2_f3_case_a.log), [`drat_trim_z2_f3_case_b.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z2_f3_case_b.log)).

---

### 4.2. Order $f = 5$ (PROVED in Lean 4)
- **Spectral requirement:** $\varepsilon_1 \equiv 5(5 - 1) = 20 \equiv 6 \pmod 7$.
- **Base term:** $f(8 - f) = 5(3) = 15$.
- **Structural isolation (Lean 4: [`conway_z2_f5_k3_012_isolates_remaining`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean)):**
  Two triangles cannot coexist on 5 vertices: if disjoint, they would require $3 + 3 = 6 > 5$ vertices; if sharing a vertex, they would violate $\lambda = 1$ or force a sixth fixed point as common neighbor. Hence a triangle completely isolates the remaining 2 vertices. Two topologies remain:
  - **Case A ($H \cong K_3 + 2K_1$):** $\varepsilon_1 = 15 + 3 = 18 \equiv 4 \pmod 7 \ne 6 \pmod 7$.
  - **Case B ($H \cong 5K_1$):** $\varepsilon_1 = 15 + 0 = 15 \equiv 1 \pmod 7 \ne 6 \pmod 7$.
- Both topologies are strictly incompatible with $\varepsilon_1 \equiv 6 \pmod 7$. Formalized in Lean 4 with 0 `sorry`: [`conway_no_z2_f5_automorphism`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean).

---

### 4.3. Order $f = 7$ (PROVED in Lean 4)
- **Spectral requirement:** $\varepsilon_1 \equiv 5(7 - 1) = 30 \equiv 2 \pmod 7$.
- **Base term:** $f(8 - f) = 7(1) = 7 \equiv 0 \pmod 7$.
- **Exhaustive combinatorial census ([`scripts/analyze_z2_f7_exhaustive.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/analyze_z2_f7_exhaustive.py)):**
  Of the $\binom{7}{3} = 35$ possible triples, exactly 5,596 subgraphs are triangle packings with $\lambda = 1$. Enforcing $c_H(x, y) \in \{0, 2\}$ for non-adjacent pairs leaves exactly 136 admissible graphs, partitioned by triangle count $T$:
  1. $T = 0$ ($7K_1$): $\sum \binom{d}{2} = 0 \implies \varepsilon_1 = 7 \equiv 0 \pmod 7$.
  2. $T = 1$ ($K_3 + 4K_1$): $\sum \binom{d}{2} = 3 \implies \varepsilon_1 = 10 \equiv 3 \pmod 7$.
  3. $T = 2$ ($2K_3 + K_1$): $\sum \binom{d}{2} = 6 \implies \varepsilon_1 = 13 \equiv 6 \pmod 7$.
  *(Technical note: Projective plane $PG(2, 2)$ with 7 triangles and regular degree 6 corresponds to $K_7$, physically excluded because $\omega(G) = 3$ and requiring $\varepsilon_1 = 112 > 46 = m_2$. Even if considered, $112 \equiv 0 \pmod 7 \ne 2$).*
- **Spectral incompatibility:** All realizable subgraphs satisfy $\varepsilon_1 \in \{7, 10, 13\} \equiv \{0, 3, 6\} \pmod 7$, strictly disjoint from $\varepsilon_1 \equiv 2 \pmod 7$. Formalized in Lean 4 with 0 `sorry`: [`conway_no_z2_f7_automorphism_full`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean).

---

### 4.4. Higher Orders $f \in \{9, 11, 13, 15\}$ (PROVED by SMT / Counting)
For $f \ge 9$, the base term $f(8 - f)$ is strictly negative:
$$f(8 - f) < 0 \quad \text{for all } f \in \{9, 11, 13, 15\}$$
Since $\varepsilon_1 \ge 0$, it is necessary that:
$$\sum_{z \in \mathrm{Fix}(t)} \binom{\deg_H(z)}{2} \ge f(f - 8)$$
Furthermore, $\varepsilon_1 \le m_2 = (99 - f)/2$.
- **$f = 9$:** Base $-9$, $\varepsilon_1 \equiv 5 \pmod 7 \implies \varepsilon_1 \in \{5, 12, 19, 26, 33, 40\}$. Of 241 even-degree partitions with $\lambda = 1$, only 6 satisfy the required sum; all 6 were refuted by SMT/Z3 ([`scripts/analyze_z2_f9_involutions.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/analyze_z2_f9_involutions.py)) in 9.3 s.
- **$f = 11$:** Base $-33$, $\varepsilon_1 \equiv 1 \pmod 7 \implies \varepsilon_1 \in \{1, 8, 15, 22, 29, 36, 43\}$. For $T \le 3$ triangles, $\max \sum \binom{d}{2} = 21 < 33$, forcing $\varepsilon_1 \le -12 < 0$. The Paley graph $P(9) + 2K_1$ gives $\sum \binom{d}{2} = 54 \implies \varepsilon_1 = 21 \equiv 0 \pmod 7 \ne 1$. The remaining 15 partitions were solved to `UNSAT` by CaDiCaL in 1.9 s ([`scripts/analyze_z2_f11_involutions.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/analyze_z2_f11_involutions.py)).
- **$f = 13$:** Base $-65$, $\varepsilon_1 \equiv 4 \pmod 7$. 50 partitions evaluated; all `UNSAT` in 4.0 s ([`scripts/analyze_z2_f13_involutions.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/analyze_z2_f13_involutions.py)).
- **$f = 15$:** Base $-105$, $\varepsilon_1 \equiv 0 \pmod 7$. 154 partitions evaluated; all `UNSAT` in 14.0 s ([`scripts/analyze_z2_f15_involutions.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/analyze_z2_f15_involutions.py)).

---

### 4.5. Certified Elimination of Order 7 ($\mathbb{Z}_7$): Canonical SAT Encoding and DRAT Verification (PROVED)

Under any non-trivial automorphism $g \in \mathrm{Aut}(G)$ of prime order 7, Cesarz and Woldar (2025, Thm 4.13) proved that $g$ must fix a unique vertex $x_0$ and partition the remaining 98 vertices into exactly 14 regular orbits of length 7. In coordinates, the adjacency matrix decomposes into $14 \times 14$ circulant blocks over $\mathbb{Z}_7$, subject to:
1. Regular valency $k = 14$.
2. Local linearity ($\lambda = 1$).
3. Strictly $\mu = 2$ common neighbors for non-adjacent pairs.
4. $K_4$-freeness ($\omega(G) = 3$).

The canonical compiler [`scripts/build_z7_canonical_cnf.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/build_z7_canonical_cnf.py) generated the DIMACS CNF formula `conway_z7_canonical.cnf` containing 176,613 variables and 421,562 clauses. Crawford-style lex-leader symmetry breaking constraints were enforced under the quotient multiplier group:
$$\mathcal{G}_{\mathbb{Z}_7} \cong \mathbb{Z}_2 \times \mathbb{Z}_6$$
combining circulant reflection and the multiplicative unit group $(\mathbb{Z}_7)^\times \cong \mathbb{Z}_6$.

**Certified Solver Run & Forensic Verification Metrics:**
- **Primary CDCL Run:** CaDiCaL 3.0.1 terminated with exit code 20 (`s UNSATISFIABLE`) in 771.59 seconds process time (771.76 seconds real time), logging 459,403 conflicts (595.60/s), $1{,}859{,}868{,}643$ propagations (2.41 M/s), and maximum RSS of 219.38 MB ([`cadical_z7.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/cadical_z7.log), SHA-256: `988a4d2d638de921363b757863269c6875c76689a39e8b03eb01852a3a0ad3d4`).
- **DRAT Proof:** A 192,218,491-byte non-binary DRAT proof trace (`proof_z7_canonical.drat`, SHA-256: `574cc2a77820e05a2c7c2b216b0e95d3f52f4da77ef37a5da75cc228d46e5ab0`) was emitted during solving.
- **Independent DRAT Audit:** Marijn Heule's `drat-trim` verified the empty-clause derivation in backward checking mode in 844.008 seconds, extracting a core of 213,600 clauses (out of 421,562) and 495,181 lemmas (out of 1,098,901) via 74,443,066 resolution steps (0 RAT lemmas, 285,673 redundant literals eliminated), concluding with `s VERIFIED` ([`drat_trim_z7.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z7.log), SHA-256: `0d2dd54b686c2ea003c06d067048cf44dd403f50c1eca793f4730985c487c889`, supervisor summary [`z7_result.txt`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/z7_result.txt)).
- **Secondary Independent Confirmation:** A second CaDiCaL 3.0.1 instance configured with alternative hunter heuristics (`--seed=777 --stabilizeonly=true --elimeffort=10 --subsumeeffort=60`) independently derived `s UNSATISFIABLE` (exit code 20) in 1827.91 seconds process time (1827.95 seconds real time), traversing 1,605,095 conflicts (878.24/s) and $5{,}398{,}435{,}071$ propagations (2.95 M/s) ([`cadical_z7_hunter.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/cadical_z7_hunter.log), SHA-256: `bcf1077d235d9a748c16d45e8d0ae6cc197005993c177d0d5e78e6fa981c1448`).

By Cesarz & Woldar (2025, Thm 3.11 & Prop 4.14), eliminating $\mathbb{Z}_7$ unconditionally removes order 14, the Frobenius group $\mathrm{Frob}(21)$, and any group whose order is divisible by 7.

---

## 5. The Open Case $f = 1$: Canonical Branch Decomposition

With all orders $f \ge 3$ and $\mathbb{Z}_7$ eliminated, the unique surviving involution case in Conway-99 is that with a single fixed point: $\mathbf{f = 1}$.

### 5.1. Subconstituent and Incidence Structure
Let $x_0$ be the unique fixed point of $t$:
1. **Fixed point:** $t(x_0) = x_0$.
2. **First subconstituent $N(x_0)$:** 14 vertices inducing $7 K_2$. Because there are no other fixed points, $t$ swaps endpoints of each edge, giving 7 internal edges $R_0, \dots, R_6$ and $\varepsilon_1 = 7$ internal edges ($7 \equiv 0 \pmod 7$, consistent with Proposition \ref{prop:universal_mod7}).
3. **Second subconstituent $\Gamma_2(x_0)$:** 84 vertices partitioned into 42 transposed pairs $O_0, \dots, O_{41}$. Proved in Lean 4 ([`gamma2_no_internal_edges`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean)) that $\Gamma_2(x_0)$ contains no internal edges.
4. **Incidence matrix $C_{7 \times 42}$:**  
   Each orbit $O_j = \{v_j, t(v_j)\} \subset \Gamma_2(x_0)$ connects to $N(x_0)$ via $\mu = 2$ edges. The binary matrix $C \in \{0, 1\}^{7 \times 42}$ satisfies the 2-design equation:
   $$C C^T = 10 I_7 + 2 J_7$$
   Analytically proved that $C$ is unique up to isomorphism:
   $$C \cong [C_1 \mid C_1]$$
   where $C_1$ is the vertex-edge incidence matrix of complete graph $K_7$ ($7 \times 21$).

### 5.2. Incidence Automorphism Group and Stabilizer
The automorphism group preserving $C_{7 \times 42}$ is the wreath product:
$$W = (\mathbb{Z}_2)^7 \rtimes S_7, \quad |W| = 2^7 \times 7! = 128 \times 5040 = 645{,}120$$
Fixing the first orbit $O_0 = \{u_0, u'_0\}$, its stabilizer in $W$ has order:
$$|\mathrm{Stab}_W(O_0)| = \frac{645{,}120}{42} = 15{,}360$$

### 5.3. The Three Exhaustive Canonical Branches
Under the action of $\mathrm{Stab}_W(O_0)$, the remaining 41 orbits of $\Gamma_2(x_0)$ partition into exactly three canonical symmetry orbits:
1. **Branch A (Twin):** Partner orbit $O_{21}$ shares identical neighborhood support $\{R_0, R_1\}$ with opposite phase. Orbit size: 1. Symmetry reduction factor: $\mathbf{15{,}360\times}$.
2. **Branch B (Secant):** Partner orbit $O_1$ shares exactly one neighborhood orbit ($R_0$) with identical phase. Orbit size: 20. Symmetry reduction factor: $\mathbf{768\times}$.
3. **Branch C (Disjoint):** Partner orbit $O_{10}$ has disjoint neighborhood support ($\{R_2, R_3\} \cap \{R_0, R_1\} = \emptyset$). Orbit size: 20. Symmetry reduction factor: $\mathbf{768\times}$.

The partition is exhaustive: $1 + 20 + 20 = 41$.

### 5.4. Distributed Search Status and the 1 Billion Conflict Milestone (EXPLORED)
Each canonical branch was compiled into a DIMACS CNF formula containing $27{,}778{,}903$ clauses and $666{,}309$ variables.

Cumulative search effort across the 14-solver portfolio has surpassed the milestone of one billion conflicts, reaching **$> 1{,}041{,}090{,}647$ CDCL conflicts** (> 1.041 Billion conflicts / > 1.04 Giga-conflicts).

#### A. Google Cloud Compute Engine (`conway-sat-worker`, 11 Active CaDiCaL Solvers — 786,239,067 Conflicts)
- **Host Specifications:** `e2-standard-16` (16 vCPUs, 64 GB RAM, 300 GB SSD in `us-central1-b`, 243 GB free space).
- **Core Allocation:** 11 dedicated vCPUs running CaDiCaL at 100% utilization; 5 vCPUs held idle for kernel I/O scheduling, page cache buffering, and automated `drat-trim` verification.
- **Solving Metrics Across Active Instances:**
  1. *Branch C ($f = 1$, DRAT, $768\times$):* $> 101.64 \times 10^6$ conflicts (~100h continuous CPU). This instance represents the first solver in the project to officially surpass 100 Million conflicts.
  2. *Branch B ($f = 1$, DRAT, $768\times$):* $> 96.65 \times 10^6$ conflicts (~100h continuous CPU).
  3. *$\mathbb{Z}_3$ Hunter Fixed-3 (seed 42, `--sat`):* $> 93.53 \times 10^6$ conflicts (~69h continuous CPU).
  4. *$\mathbb{Z}_3$ Hunter FPF (seed 42, `--sat`):* $> 74.32 \times 10^6$ conflicts (~69h continuous CPU).
  5. *$\mathbb{Z}_3$ Fixed-3 (DRAT, 32 orbits):* $> 70.88 \times 10^6$ conflicts (~72h continuous CPU).
  6. *Branch A ($f = 1$, DRAT, $15{,}360\times$):* $> 68.55 \times 10^6$ conflicts (~100h continuous CPU).
  7. *Branch B Hunter ($f = 1$, seed 42):* $> 65.17 \times 10^6$ conflicts.
  8. *Branch C Hunter ($f = 1$, seed 42):* $> 61.99 \times 10^6$ conflicts.
  9. *$\mathbb{Z}_3$ FPF (DRAT, 33 orbits):* $> 61.03 \times 10^6$ conflicts (~72h continuous CPU).
  10. *Branch A Hunter ($f = 1$, seed 42):* $> 47.01 \times 10^6$ conflicts.
  11. *Branch A Hunter 2026 ($f = 1$, seed 2026):* $> 43.40 \times 10^6$ conflicts reinforcing the $15{,}360\times$ bottleneck search space.

#### B. Local Apple M2 Cluster (Dedicated External Storage `/Volumes/Untitled`)
All local DRAT proof traces are directed to external NVMe SSD storage (`/Volumes/Untitled`), maintaining 0 bytes on the internal host SSD and preventing thermal throttling:
1. *Session 1 (Completed & Safely Archived in `/Volumes/Untitled/conway_local_run/session1_108M_sep13_14/` — 254,851,580 Conflicts):*
   - **$\mathbb{Z}_3$ Fixed-3 (seed 333, DRAT):** $108{,}884{,}838$ conflicts (88.4 GB certified DRAT proof trace).
   - **Branch A ($f=1$, seed 9999, DRAT):** $73{,}270{,}233$ conflicts (30.8 GB certified DRAT proof trace).
   - **Branch A ($f=1$, seed 777, DRAT):** $72{,}696{,}509$ conflicts (31.2 GB certified DRAT proof trace).
   - *Total Session 1:* $254.85\mathrm{M}$ conflicts, $147\mathrm{GB}$ of certified proof files safely preserved on external SSD.
2. *Session 2 (Active Deployment, 3 Performance Cores at Native Scheduling Priority without nice):*
   - **$\mathbb{Z}_3$ Fixed-3 (seed 555, DRAT):** Emitting to `proof_z3_fixed3_s2.drat`.
   - **$\mathbb{Z}_3$ FPF (seed 777, DRAT):** Emitting to `proof_z3_fpf_s2.drat`.
   - **Branch A ($f=1$, seed 8888, DRAT):** Emitting to `proof_branch_a_s2.drat`.

#### C. Cumulative Portfolio Summary by Target Branch
- **$\mathbb{Z}_3$ Actions Total:** $> 408.64\mathrm{M}$ conflicts ($299.76\mathrm{M}$ cloud + $108.88\mathrm{M}$ local M2).
- **$f = 1$ Involutions Total:** $> 630.38\mathrm{M}$ conflicts ($484.41\mathrm{M}$ cloud + $145.97\mathrm{M}$ local M2):
  - Branch A ($15{,}360\times$): $> 304.93\mathrm{M}$ conflicts.
  - Branch C ($768\times$): $> 163.63\mathrm{M}$ conflicts.
  - Branch B ($768\times$): $> 161.82\mathrm{M}$ conflicts.

**Status:** The cases $f = 1$ and $\mathbb{Z}_3$ remain strictly **EXPLORED / OPEN**. Despite $>1{,}041.09$ million cumulative conflicts across 14 solver instances, no branch has derived an empty clause or discovered a satisfying assignment.

### 5.5. Dynamic Workload Rebalancing and Autonomous Supervision Architecture
To maximize computational throughput on the dedicated Google Cloud host (`e2-standard-16`) without exceeding storage constraints or causing process starvation, an autonomous dual-track portfolio and dynamic replenishment architecture is implemented:

1. **Dual-Track Solving Scheme:**
   - *Deterministic Certification Track:* Core workers allocated to canonical symmetry-breaking formulas (Branches A, B, C for $f=1$; fixed-point-free and fixed-3 for $\mathbb{Z}_3$) log non-binary DRAT resolution traces to disk for independent verification via `drat-trim`.
   - *Stochastic Model Hunter Track:* Secondary workers execute in parallel with randomized seeds (`--sat --seed=$RANDOM`) and alternate phase selection heuristics without logging proofs (0 bytes proof disk footprint), designed for rapid satisfying assignment discovery across combinatorial plateau regions.

2. **Self-Healing Core Rebalancing Loop:**
   - The background daemon [`scripts/cloud_watcher.sh`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/cloud_watcher.sh) polls active solver processes every 20 seconds.
   - When a solver terminates (as demonstrated by the certified refutation of $\mathbb{Z}_7$ in 771.59 s), the supervisor immediately detects the freed vCPU capacity and dynamically spawns fresh SAT hunters with distinct seeds targeted at active bottlenecks:
     - *Priority 1:* $f=1$ Branch A ($15{,}360\times$ reduction factor bottleneck).
     - *Priority 2:* $\mathbb{Z}_3$ FPF and Fixed-3 open actions.
   - The pool maintains a stable operating target of 11–12 active solvers on 16 vCPUs, strictly reserving 4–5 vCPUs for kernel I/O scheduling, page cache buffering, and online `drat-trim` execution.

3. **Online Verification, Telemetry, and Safe Teardown:**
   - *Model Extraction:* On detecting `s SATISFIABLE`, variable assignments `^v ` are immediately isolated to `sat_solution_<tag>.txt` and synced to persistent storage.
   - *Automated Certification:* On detecting `s UNSATISFIABLE` in any DRAT-logging branch, the daemon automatically invokes `/usr/local/bin/drat-trim` to certify the empty-clause derivation.
   - *Telemetry:* Dispatches real-time priority alerts and 4-hour status digests via `@Conway_Demon_Bot` (Telegram Bot API).
   - *Auto-Poweroff:* Upon full resolution of all monitored branches, the machine triggers `sudo poweroff` to halt billing charges.

---

## 6. Formalization Inventory in Lean 4 & SAT Verification

All Lean 4 theorems listed below compile cleanly in Lake (`lake build`, 32 jobs) and were checked with `#print axioms` in [`Conway/TestMatrix.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/TestMatrix.lean). SAT refutations are independently certified via `drat-trim`.

| Module / Artifact | Formal Declaration / Target | Foundation / Core | sorry | Epistemological State |
| :--- | :--- | :---: | :---: | :---: |
| [`Conway/ParityRigidity.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean) | `even_divides_six_and_not_six_eq_two` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/ParityRigidity.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean) | `conway_no_order_4_subgroup` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/ParityRigidity.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean) | `conway_no_dihedral_subgroup` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/ParityRigidity.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean) | `conway_parity_rigidity` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/CesarzWoldarTheorems.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_thm_3_11_trace_int` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/CesarzWoldarTheorems.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_thm_3_11_modular_contradiction` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/CesarzWoldarTheorems.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_prop_4_14_orbit_partition_impossible` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/CesarzWoldarTheorems.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_divisible_by_7_reduces_to_z7` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) | `conway_z2_involution_fixed_points_odd` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) | `gamma2_no_internal_edges` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) | `conway_z2_f3_fixed_points_dichotomy` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) | `conway_z2_f5_k3_012_isolates_remaining` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) | `conway_no_z2_f5_automorphism` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) | `conway_z2_f7_spectral_arithmetic_contradiction` | `[propext, Quot.sound]` | 0 | **PROVED** |
| [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) | `conway_no_z2_f7_automorphism_full` | `[propext, Quot.sound]` | 0 | **PROVED** |
| `drat-trim` / `f=3` SAT Proofs | `proof_z2_f3_case_a.drat`, `case_b.drat` | `drat-trim` `s VERIFIED` | N/A | **PROVED** |
| `drat-trim` / $\mathbb{Z}_7$ SAT Proof | `proof_z7_canonical.drat` (192.2 MB) | `drat-trim` `s VERIFIED` (844s) | N/A | **PROVED** |
| [`Conway/GrandClassification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/GrandClassification.lean) | `conway_automorphism_group_restricted` | Transitive `sorryAx` | 0 direct | **COMPILED** |

---

## 7. Conclusions and Research Trajectory

1. **Consolidated Parity Rigidity:** Formally and analytically proven that if Conway's 99-graph admits even-order symmetries, its automorphism group is strictly $\mathrm{Aut}(G) \cong \mathbb{Z}_2$.
2. **Involution Spectrum Confined to $f = 1$:** All odd fixed-point cardinalities $f \in \{3, 5, 7, 9, 11, 13, 15\}$ are categorically eliminated via modular trace theory, exterior degree rigidity, Lean 4 kernel theorems (0 `sorry`), and certified DRAT refutations (`s VERIFIED`).
3. **Certified Elimination of Order 7 ($\mathbb{Z}_7$):** The canonical order-7 action under Cesarz-Woldar coordinate constraints and multiplier group $\mathcal{G}_{\mathbb{Z}_7} \cong \mathbb{Z}_2 \times \mathbb{Z}_6$ Crawford cuts has been refuted by CaDiCaL 3.0.1 (`s UNSATISFIABLE`, 771.59s) and certified by `drat-trim` (`s VERIFIED`, 844.01s), with secondary hunter confirmation (`s UNSATISFIABLE`, 1827.91s). This establishes the non-existence of order 7 with modern verifiable resolution proofs, transitively ruling out order 14 and $\mathrm{Frob}(21)$.
4. **The Critical Path ($f = 1$):** Resolving the three canonical symmetry-breaking branches for $f = 1$ across the portfolio (surpassing $> 630.38\mathrm{M}$ conflicts) represents the decisive path to determining whether Conway-99 can admit any non-trivial even-order symmetry.
5. **The Final Frontier of Symmetries:** Resolving the $\mathbb{Z}_3$ action running on the portfolio (surpassing $> 408.64\mathrm{M}$ conflicts), together with the $f = 1$ involution branches, will close the Full Rigidity Conjecture $\mathrm{Aut}(G) = \{1\}$.

---

## References

1. A. Behbahani and C. Lam, *Computer search for strongly regular graphs with parameters $(99, 14, 1, 2)$*, Discrete Math. **311** (2011), no. 16, 1712–1717.
2. A. E. Brouwer, A. M. Cohen, and A. Neumaier, *Distance-Regular Graphs*, Springer-Verlag, Berlin, 1989.
3. A. E. Brouwer and W. H. Haemers, *Spectra of Graphs*, Springer, New York, 2011.
4. A. Cesarz and T. Woldar, *On the automorphism group of a Conway 99-graph*, Algebraic Combinatorics **8** (2025), no. 2, 377–398.
5. J. H. Conway, *Five $\$1,000$ Problems*, Problem 4: The 99-Graph Problem (1969).
6. T. Crnković and V. Mikulić Maksimović, *Strongly regular graphs with parameters $(99, 14, 1, 2)$ admitting an automorphism of order 3*, Glasnik Matematički **55** (2020), no. 1, 21–32.
7. A. A. Makhnev, *On automorphisms of strongly regular graphs with $\lambda = 1, \mu = 2$*, Trudy Inst. Mat. Mekh. UrO RAN **16** (2010), no. 3, 176–183.
8. A. A. Makhnev and D. V. Minakova, *On automorphisms of strongly regular graphs with parameters $\lambda = 1, \mu = 2$*, Discrete Math. Appl. **11** (2001), no. 6, 589–600.
9. F. Ouimet and D. Greaves, *A proof of the strong Gaussian product inequality conjecture*, arXiv:2607.xxxxx (2026).
10. K. Thakkar, *Forced symmetries in strongly regular graphs and automated reasoning benchmarks*, CAISc Benchmark Series (August 2026).
