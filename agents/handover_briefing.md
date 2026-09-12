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

### C. Order 7 ($\mathbb{Z}_7$) [PROVED]
- Non-existence proved in historical literature (Behbahani-Lam 2011) via computational orbit matrices; $7 \mid \lvert \mathrm{Aut}(G) \rvert \implies \mathrm{Aut}(G) \cong \mathbb{Z}_7$ (Cesarz-Woldar 2025).
- Canonical CNF generation implemented in [`scripts/build_z7_canonical_cnf.py`](../scripts/build_z7_canonical_cnf.py) with Cesarz-Woldar coordinate constraints and full Crawford-style lex-leader symmetry breaking under multiplier group $\mathcal{G}_{\mathbb{Z}_7} \cong \mathbb{Z}_2 \times \mathbb{Z}_6$ (176,613 variables, 421,562 clauses; 13 unit tests passing in [`tests/test_canonical_sat_compilers.py`](../tests/test_canonical_sat_compilers.py)).
- **Certified Refutation:**
  - **Primary Solver:** CaDiCaL 3.0.1 derived `s UNSATISFIABLE` (exit code 20) in 771.59 seconds process time (771.76 s real time), logging 459,403 conflicts (595.60/s), $1{,}859{,}868{,}643$ propagations (2.41 M/s), and max RSS of 219.38 MB ([`cadical_z7.log`](../cadical_z7.log), SHA-256: `988a4d2d638de921363b757863269c6875c76689a39e8b03eb01852a3a0ad3d4`).
  - **DRAT Proof:** Emitted `proof_z7_canonical.drat` (192,218,491 bytes, SHA-256: `574cc2a77820e05a2c7c2b216b0e95d3f52f4da77ef37a5da75cc228d46e5ab0`).
  - **DRAT Verification:** `drat-trim` in backward checking mode verified the refutation in 844.008 seconds, extracting 213,600 core clauses and 495,181 core lemmas via 74,443,066 resolution steps (0 RAT lemmas in core; 285,673 redundant literals eliminated), returning `s VERIFIED` ([`drat_trim_z7.log`](../drat_trim_z7.log), SHA-256: `0d2dd54b686c2ea003c06d067048cf44dd403f50c1eca793f4730985c487c889`, supervisor summary [`z7_result.txt`](../z7_result.txt)).
  - **Secondary Independent Confirmation:** CaDiCaL 3.0.1 SAT hunter with alternative heuristics (`--seed=777 --stabilizeonly=true --elimeffort=10 --subsumeeffort=60`) independently confirmed `s UNSATISFIABLE` in 1827.91 seconds process time, traversing 1,605,095 conflicts (878.24/s) and $5{,}398{,}435{,}071$ propagations ([`cadical_z7_hunter.log`](../cadical_z7_hunter.log), SHA-256: `bcf1077d235d9a748c16d45e8d0ae6cc197005993c177d0d5e78e6fa981c1448`).

### D. Order 3 ($\mathbb{Z}_3$) [EXPLORED / RUNNING IN HYBRID CLUSTER]
- Non-existence proved in historical literature (Behbahani-Lam 2011; Crnković-Maksimović 2020).
- Canonical CNF generation implemented in [`scripts/build_z3_canonical_cnf.py`](../scripts/build_z3_canonical_cnf.py) with $S_3 \times \mathbb{Z}_2$ symmetry cuts for both the fixed-point-free (33 orbits) and fixed-3 (32 orbits) actions (unit tests passing).
- Currently being solved across 5 solvers (4 GCP cloud + 1 local Apple M2 core): $> 176.08\mathrm{M}$ conflicts accumulated.

---

## 3. Infrastructure & Solver Operations: Hybrid 14-Solver Portfolio (>500M Conflicts)

Cumulative search effort across the project has crossed **> 500.38 MILLION CONFLICTS** (433.38M cloud conflicts + 66.99M local M2 conflicts).

### A. Google Cloud Platform (11-Solver Cluster — 433.38M Conflicts)
- **Virtual Machine:** `conway-sat-worker` (`e2-standard-16`, 16 vCPUs, 64 GB RAM, 300 GB SSD in `us-central1-b`, 243 GB SSD free).
- **Process Allocation & Status:** 11 active CaDiCaL solvers executing across dedicated vCPUs with 5 vCPUs held idle for OS responsiveness, filesystem throughput, and proof checking headroom:
  1. **$f = 1$ ($\mathbb{Z}_2$) Main DRAT Solvers (3 processes, 187.49M conflicts):**
     - Branch C: $> 72.52 \times 10^6$ conflicts (~59.5h continuous CPU).
     - Branch B: $> 69.38 \times 10^6$ conflicts (~59.7h continuous CPU).
     - Branch A: $> 45.59 \times 10^6$ conflicts (~59.6h continuous CPU).
  2. **Order 3 ($\mathbb{Z}_3$) Main DRAT Solvers (2 processes, 67.21M conflicts):**
     - Fixed-3 (32 orbits): $> 37.18 \times 10^6$ conflicts (~31.7h continuous CPU).
     - FPF (33 orbits): $> 30.03 \times 10^6$ conflicts (~31.7h continuous CPU).
  3. **Heuristic SAT Hunters (6 processes, 178.68M conflicts, no DRAT):**
     - $\mathbb{Z}_3$ Fixed-3 Hunter: $> 45.75 \times 10^6$ conflicts.
     - $\mathbb{Z}_3$ FPF Hunter: $> 32.69 \times 10^6$ conflicts.
     - Branch B Hunter ($f=1$): $> 29.71 \times 10^6$ conflicts.
     - Branch C Hunter ($f=1$): $> 29.03 \times 10^6$ conflicts.
     - Branch A Hunter ($f=1$): $> 22.37 \times 10^6$ conflicts.
     - Branch A Hunter 2026 ($f=1$): $> 19.13 \times 10^6$ conflicts.
- **Autonomous Supervisor:** Upgraded daemon [`scripts/cloud_watcher.sh`](../scripts/cloud_watcher.sh) (PID 68900) polling every 20 seconds:
  - Detects `s SATISFIABLE`: extracts model assignments `^v ` immediately into `sat_solution_<tag>.txt` and syncs disk.
  - Detects `s UNSATISFIABLE`: automatically executes `/usr/local/bin/drat-trim` on corresponding CNF and DRAT files to certify refutation (successfully verified Order 7, recording `s UNSATISFIABLE / VERIFIED` in [`z7_result.txt`](../z7_result.txt)).
  - Telemetry: Emits real-time priority alerts to `@Conway_Demon_Bot` via Telegram Bot API and posts periodic 4-hour status heartbeats.

### B. Local Host Workstation (Apple M2 Cluster — 66.99M Conflicts)
- **Process Allocation:** 3 dedicated Performance cores executing CaDiCaL with DRAT proof logging.
- **Dedicated External Storage:** All local DRAT proof streams are redirected to an external NVMe SSD mounted at `/Volumes/Untitled`, precluding internal SSD wear and storage exhaustion while running with 0% thermal throttling.
- **Active Solvers:**
  - $\mathbb{Z}_3$ Fixed-3 (seed 333, DRAT): $> 30.43 \times 10^6$ conflicts (~11.2h CPU).
  - Branch A ($f=1$, seed 9999, DRAT): $> 18.71 \times 10^6$ conflicts (~11.3h CPU).
  - Branch A ($f=1$, seed 777, DRAT): $> 17.85 \times 10^6$ conflicts (~11.3h CPU).
