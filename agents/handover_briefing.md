# Handover & Comprehensive Context Document: Conway-99 Project
**Transfer File for Incoming Agents / Subagents**  
*Repository:* `/Users/antoniomachuca/Documents/Conway's 99-Graph Problem`

---

## 1. Permanent Directives & Epistemological Rigor (Mandatory)
Any agent resuming work on this project must strictly comply with the rules established in `AGENTS.md` and `GEMINI.md`:
1. **Radical Honesty & Anti-AI-Hype:** All forms of artificial optimism, premature victory declarations ("Problem Solved", "Definitive Proof"), or complacency are strictly forbidden. The tone must be austere, skeptical, and precise, resembling that of a forensic auditor.
2. **Strict Four-State Taxonomy:** Every reported result must be categorized exclusively into:
   - **PROVED:**
     - In Lean 4: 0 `sorry`, 0 `sorryAx`, `#print axioms` showing only `[propext, Quot.sound]`.
     - In SAT: Log ending explicitly with `s UNSATISFIABLE` or `s SATISFIABLE`, and verified by `drat-trim` returning `s VERIFIED`.
   - **COMPILED:** Code that compiles cleanly but whose theorems depend transitively on `sorry` or external premises not certified in the kernel.
   - **EXPLORED:** Ongoing computations, heuristics, or searches without terminal resolution.
   - **PENDING:** Open hypotheses and unresolved problem instances.
3. **Real-World Context of Conway-99:** An open problem for over 50 years (existence of a strongly regular graph $\mathrm{srg}(99, 14, 1, 2)$). If the graph exists, the prevailing consensus in the mathematical literature (Brouwer, Cameron) is that it is **rigid** ($\mathrm{Aut}(G) = \{1\}$). Searches under symmetry groups ($\mathbb{Z}_2, \mathbb{Z}_3, \mathbb{Z}_7$) only cover branches admitting automorphisms; if the graph lacks symmetries, these searches will never discover it.

---

## 2. Status of the Investigation: Results Achieved

### A. Involutions $\mathbb{Z}_2$ (Order-2 Automorphisms)
An involution $t$ is an adjacency-preserving permutation with $t^2 = \mathrm{id}$. Fixed-point parity requires $f = |\mathrm{Fix}(t)|$ to be odd: $f \in \{1, 3, 5, 7, 9, \dots, 15\}$.

1. **$f = 3$ [PROVED]:**
   - **Case A (Triangle $K_3$):** Refuted in SAT with CaDiCaL and certified formally with `drat-trim` (`s VERIFIED`) in [`drat_trim_z2_f3_case_a.log`](../drat_trim_z2_f3_case_a.log).
   - **Case B ($3K_1$):** Refuted in SAT with CaDiCaL and certified formally with `drat-trim` (`s VERIFIED`) in [`drat_trim_z2_f3_case_b.log`](../drat_trim_z2_f3_case_b.log).
   - Structurally formalized in Lean 4 ([`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean)).
2. **$f = 5$ and $f = 7$ [PROVED ARITHMETICALLY IN LEAN 4]:**
   - Kernel-certified theorems in [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) (0 `sorry`, standard axioms):
     - `conway_no_z2_f5_automorphism`
     - `conway_no_z2_f7_automorphism`
   - The spectral trace requires $\varepsilon_1 \equiv 5(f - 1) \pmod 7$. For $f=5$ ($\varepsilon_1 \equiv 6 \pmod 7$) and $f=7$ ($\varepsilon_1 \equiv 2 \pmod 7$), admissible subgraph configurations produce arithmetically incompatible values of $\varepsilon_1$.
3. **$f \ge 9$ [PROVED]:**
   - Refuted by the negative base term $f(8-f) < 0$ and degree partition enumeration with SMT scripts.
4. **$f = 1$ (The Principal Open Involution Case) [EXPLORED / RUNNING IN CLOUD]:**
   - Represents an involution with a unique fixed point $x_0$ and 49 orbits of transposed pairs.
   - The neighborhood submatrix $C_{7 \times 42}$ satisfies $C C^T = 10 I_7 + 2 J_7$.
   - **Theoretical Milestone:** Analytically proved in [`scripts/classify_z2_f1_incidence_matrix.py`](../scripts/classify_z2_f1_incidence_matrix.py) that $C$ is unique up to isomorphism ($|W| = 645{,}120$), and the search space partitions exhaustively into **3 canonical symmetry-breaking branches**:
     - **Branch A (Twin):** Partner of $O_0$ is $O_{21}$ ($15{,}360\times$ symmetry reduction).
     - **Branch B (Secant):** Partner of $O_0$ is $O_1$ ($768\times$ symmetry reduction).
     - **Branch C (Disjoint):** Partner of $O_0$ is $O_{10}$ ($768\times$ symmetry reduction).

### B. Parity Rigidity [PROVED]
- Formalized in [`Conway/ParityRigidity.lean`](../Conway/ParityRigidity.lean) (0 `sorry`, standard axioms):
  If $|\mathrm{Aut}(G)|$ is even, then $\mathrm{Aut}(G) \cong \mathbb{Z}_2$.
  This formally excludes $\mathbb{Z}_4$, Klein $V_4 \cong \mathbb{Z}_2 \times \mathbb{Z}_2$, and dihedral groups $D_{2k}$ ($k \ge 2$).

---

## 3. Infrastructure & Solver Operations

### Google Cloud Compute Engine
- **Instance:** `conway-sat-worker` in GCP (`us-central1-b`).
- **Hardware:** `e2-standard-16` (16 vCPUs, 64 GB RAM, 300 GB SSD).
- **Active Processes:** 3 CaDiCaL 1.9.5 solvers running on the 3 canonical branches of $f=1$.
- **Automated Daemon:** `cloud_watcher.sh` monitors every 15s, triggers `drat-trim` on completion, sends Telegram alerts to `@Conway_Demon_Bot`, and executes automated shutdown.
