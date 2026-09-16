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
   - **Case A (Triangle $K_3$):** Refuted in SAT with CaDiCaL and certified formally with `drat-trim` (`s VERIFIED`) in [`drat_trim_z2_f3_case_a.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z2_f3_case_a.log).
   - **Case B ($3K_1$):** Refuted in SAT with CaDiCaL and certified formally with `drat-trim` (`s VERIFIED`) in [`drat_trim_z2_f3_case_b.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z2_f3_case_b.log).
   - Structurally formalized in Lean 4 ([`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean)).
2. **$f = 5$ and $f = 7$ [PROVED ARITHMETICALLY IN LEAN 4]:**
   - Kernel-certified theorems in [`Conway/Z2Classification.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/Z2Classification.lean) (0 `sorry`, standard axioms):
     - `conway_no_z2_f5_automorphism`
     - `conway_no_z2_f7_automorphism`
   - The spectral trace requires $\varepsilon_1 \equiv 5(f - 1) \pmod 7$. For $f=5$ ($\varepsilon_1 \equiv 6 \pmod 7$) and $f=7$ ($\varepsilon_1 \equiv 2 \pmod 7$), admissible subgraph configurations produce arithmetically incompatible values of $\varepsilon_1$.
3. **$f \ge 9$ [PROVED]:**
   - Refuted by the negative base term $f(8-f) < 0$ and degree partition enumeration with SMT scripts.
4. **$f = 1$ (The Principal Open Involution Case) [EXPLORED / RUNNING IN HYBRID PORTFOLIO]:**
   - Represents an involution with a unique fixed point $x_0$ and 49 orbits of transposed pairs.
   - The neighborhood submatrix $C_{7 \times 42}$ satisfies $C C^T = 10 I_7 + 2 J_7$.
   - Analytically proved in [`scripts/classify_z2_f1_incidence_matrix.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/classify_z2_f1_incidence_matrix.py) that $C$ is unique up to isomorphism ($|W| = 645{,}120$), and the search space partitions exhaustively into **3 canonical symmetry-breaking branches**:
      - **Branch A (Twin):** Partner of $O_0$ is $O_{21}$ ($15{,}360\times$ symmetry reduction). Portfolio total: $> 463\mathrm{M}$ conflicts.
      - **Branch B (Secant):** Partner of $O_0$ is $O_1$ ($768\times$ symmetry reduction). Portfolio total: $> 242\mathrm{M}$ conflicts.
      - **Branch C (Disjoint):** Partner of $O_0$ is $O_{10}$ ($768\times$ symmetry reduction). Portfolio total: $> 237\mathrm{M}$ conflicts.
    - Total search effort across $f = 1$ has crossed $> 947\mathrm{M}$ conflicts.

### B. Parity Rigidity [PROVED]
- Formalized in [`Conway/ParityRigidity.lean`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/Conway/ParityRigidity.lean) (0 `sorry`, standard axioms):
  If $|\mathrm{Aut}(G)|$ is even, then $\mathrm{Aut}(G) \cong \mathbb{Z}_2$.
  This formally excludes $\mathbb{Z}_4$, Klein $V_4 \cong \mathbb{Z}_2 \times \mathbb{Z}_2$, and dihedral groups $D_{2k}$ ($k \ge 2$).

### C. Order 7 ($\mathbb{Z}_7$) [PROVED]
- Non-existence proved in historical literature (Behbahani-Lam 2011) via computational orbit matrices; $7 \mid \lvert \mathrm{Aut}(G) \rvert \implies \mathrm{Aut}(G) \cong \mathbb{Z}_7$ (Cesarz-Woldar 2025).
- Canonical CNF generation implemented in [`scripts/build_z7_canonical_cnf.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/build_z7_canonical_cnf.py) with Cesarz-Woldar coordinate constraints and full Crawford-style lex-leader symmetry breaking under multiplier group $\mathcal{G}_{\mathbb{Z}_7} \cong \mathbb{Z}_2 \times \mathbb{Z}_6$ (176,613 variables, 421,562 clauses; 13 unit tests passing in [`tests/test_canonical_sat_compilers.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/tests/test_canonical_sat_compilers.py)).
- **Certified Refutation:**
  - **Primary Solver:** CaDiCaL 3.0.1 derived `s UNSATISFIABLE` (exit code 20) in 771.59 seconds process time (771.76 s real time), logging 459,403 conflicts (595.60/s), $1{,}859{,}868{,}643$ propagations (2.41 M/s), and max RSS of 219.38 MB ([`cadical_z7.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/cadical_z7.log), SHA-256: `988a4d2d638de921363b757863269c6875c76689a39e8b03eb01852a3a0ad3d4`).
  - **DRAT Proof:** Emitted `proof_z7_canonical.drat` (192,218,491 bytes, SHA-256: `574cc2a77820e05a2c7c2b216b0e95d3f52f4da77ef37a5da75cc228d46e5ab0`).
  - **DRAT Verification:** `drat-trim` in backward checking mode verified the refutation in 844.008 seconds, extracting 213,600 core clauses and 495,181 core lemmas via 74,443,066 resolution steps (0 RAT lemmas in core; 285,673 redundant literals eliminated), returning `s VERIFIED` ([`drat_trim_z7.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/drat_trim_z7.log), SHA-256: `0d2dd54b686c2ea003c06d067048cf44dd403f50c1eca793f4730985c487c889`, supervisor summary [`z7_result.txt`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/z7_result.txt)).
  - **Secondary Independent Confirmation:** CaDiCaL 3.0.1 SAT hunter with alternative heuristics (`--seed=777 --stabilizeonly=true --elimeffort=10 --subsumeeffort=60`) independently confirmed `s UNSATISFIABLE` in 1827.91 seconds process time, traversing 1,605,095 conflicts (878.24/s) and $5{,}398{,}435{,}071$ propagations ([`cadical_z7_hunter.log`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/cadical_z7_hunter.log), SHA-256: `bcf1077d235d9a748c16d45e8d0ae6cc197005993c177d0d5e78e6fa981c1448`).

### D. Order 3 ($\mathbb{Z}_3$) [EXPLORED / RUNNING IN HYBRID CLUSTER]
- Non-existence proved in historical literature (Behbahani-Lam 2011; Crnković-Maksimović 2020).
- Canonical CNF generation implemented in [`scripts/build_z3_canonical_cnf.py`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/build_z3_canonical_cnf.py) with $S_3 \times \mathbb{Z}_2$ symmetry cuts for both the fixed-point-free (33 orbits) and fixed-3 (32 orbits) actions (unit tests passing).
- Currently being solved across portfolio (Fixed-3 action $>498\mathrm{M}$, FPF action $>314\mathrm{M}$ across DRAT and hunters on GCP + M2 Sessions 1--4): $> 812\mathrm{M}$ conflicts accumulated.

---

## 3. Infrastructure & Solver Operations: 1.74 Billion Conflict Milestone (> 1,740.38M Conflicts)

Cumulative search effort across the portfolio has passed **$> 1{,}740{,}380{,}304$ CDCL CONFLICTS** ($1{,}221{,}892{,}664$ cloud active + $459{,}403$ cloud $\mathbb{Z}_7$ proved + $518{,}028{,}237$ local M2 completed across Sessions 1, 2, 3).

### A. Google Cloud Platform (16-Solver Saturated Cluster — 1,222,352,067 Conflicts)
- **Virtual Machine:** `conway-sat-worker` (`e2-standard-16`, 16 vCPUs, 64 GB RAM, 450 GB SSD in `us-central1-b`, 87 GB SSD free).
- **Process Allocation & Status:** Fully saturated at 16 active CaDiCaL solvers executing across all 16 vCPUs (100% CPU utilization, load average 16.00):
  1. **$f = 1$ ($\mathbb{Z}_2$) Main DRAT Solvers (3 processes, >362.50M conflicts):**
     - Branch B: $> 133.21 \times 10^6$ conflicts (~151h continuous CPU).
     - Branch C: $> 132.97 \times 10^6$ conflicts (~151h continuous CPU).
     - Branch A: $> 96.32 \times 10^6$ conflicts (~151h continuous CPU).
  2. **Order 3 ($\mathbb{Z}_3$) Main DRAT Solvers (2 processes, >216.37M conflicts):**
     - Fixed-3 (32 orbits): $> 114.70 \times 10^6$ conflicts (~123h continuous CPU).
     - FPF (33 orbits): $> 101.67 \times 10^6$ conflicts (~123h continuous CPU).
  3. **Heuristic SAT Hunters (11 processes, non-DRAT mode `--sat`):**
     - *Baseline Hunters (6 processes, >643.01M conflicts):*
       - $\mathbb{Z}_3$ Fixed-3 Hunter (seed 42): $> 153.38 \times 10^6$ conflicts (~120h CPU).
       - $\mathbb{Z}_3$ FPF Hunter (seed 42): $> 123.78 \times 10^6$ conflicts (~120h CPU).
       - Branch B Hunter ($f=1$, seed 42): $> 108.88 \times 10^6$ conflicts.
       - Branch C Hunter ($f=1$, seed 42): $> 104.81 \times 10^6$ conflicts.
       - Branch A Hunter ($f=1$, seed 42): $> 79.00 \times 10^6$ conflicts.
       - Branch A Hunter 2026 ($f=1$, seed 2026): $> 73.15 \times 10^6$ conflicts.
     - *Newly Deployed Hunters (5 processes deployed September 17, 2026):*
       - Branch A Hunter (seed 1503, PID 892481).
       - $\mathbb{Z}_3$ Fixed-3 Hunter (seed 1010, PID 892482).
       - Branch A Hunter (seed 1892, PID 892483).
       - $\mathbb{Z}_3$ Fixed-3 Hunter (seed 2101, PID 892484).
       - $\mathbb{Z}_3$ FPF Hunter (seed 1306, PID 892485).
- **Autonomous Supervisor:** Upgraded daemon [`scripts/cloud_watcher.sh`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/cloud_watcher.sh) (PID 893164) polling every 20 seconds:
  - Detects `s SATISFIABLE`: extracts model assignments `^v ` immediately into `sat_solution_<tag>.txt` and syncs disk.
  - Detects `s UNSATISFIABLE`: automatically executes `/usr/local/bin/drat-trim` on corresponding CNF and DRAT files to certify refutation (Order 7 certified, `s UNSATISFIABLE / VERIFIED` in [`z7_result.txt`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/z7_result.txt)).
  - Automated Alerting: Upgraded with automated UNSAT alert detection across all 11 hunter logs.
  - Telemetry: Emits real-time priority alerts and posts hourly status heartbeats to `@Conway_Demon_Bot` via Telegram Bot API.

### B. Local Apple M2 Cluster (Dedicated External Storage `/Volumes/Untitled`)
- **Storage Architecture & Isolation:** All local DRAT proof streams are written directly to an external NVMe SSD mounted at `/Volumes/Untitled`, keeping internal SSD usage strictly at 0 bytes.
- **Completed Footprint across Sessions 1, 2, and 3 (518,028,237 Conflicts):**
  - **Session 1 Archive (`session1_108M_sep13_14/` — 254,851,580 Conflicts):**
    - $\mathbb{Z}_3$ Fixed-3 (seed 333): $108{,}884{,}838$ conflicts ($86.4\text{ GB}$ raw $\to 39.0\text{ GB}$ `.zst`).
    - Branch A ($f=1$, seed 9999): $73{,}270{,}233$ conflicts ($30.1\text{ GB}$ raw $\to 18.2\text{ GB}$ `.zst`).
    - Branch A ($f=1$, seed 777): $72{,}696{,}509$ conflicts ($30.5\text{ GB}$ raw $\to 18.8\text{ GB}$ `.zst`).
  - **Session 2 Archive (`session2_121M_sep14_15/` — 121,469,761 Conflicts):**
    - $\mathbb{Z}_3$ Fixed-3 (seed 555): $52{,}204{,}101$ conflicts ($48.4\text{ GB}$ raw $\to 18.8\text{ GB}$ `.zst`).
    - $\mathbb{Z}_3$ FPF (seed 777): $37{,}869{,}387$ conflicts ($37.9\text{ GB}$ raw $\to 13.1\text{ GB}$ `.zst`).
    - Branch A ($f=1$, seed 8888): $31{,}396{,}273$ conflicts ($11.4\text{ GB}$ raw $\to 7.12\text{ GB}$ `.zst`).
  - **Session 3 Archive (`session3_141M_sep15_16/` — 141,706,896 Conflicts):**
    - Stopped cleanly Wednesday noon (12:15 CEST) via [`scripts/auto_stop_wednesday.sh`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/auto_stop_wednesday.sh).
    - $\mathbb{Z}_3$ Fixed-3 (seed 1010): $61{,}071{,}983$ conflicts ($58.7\text{ GB}$ raw $\to 22.8\text{ GB}$ `.zst`).
    - $\mathbb{Z}_3$ FPF (seed 2026): $44{,}382{,}048$ conflicts ($47.5\text{ GB}$ raw $\to 16.6\text{ GB}$ `.zst`).
    - Branch A ($f=1$, seed 12345): $36{,}252{,}865$ conflicts ($13.3\text{ GB}$ raw $\to 8.1\text{ GB}$ `.zst`).
  - *Cumulative Local Completed Footprint (Sessions 1, 2, 3):* **$518{,}028{,}237$ conflicts** ($> 518\text{ Million conflicts}$ completed locally).
- **Completed Storage Optimization Pipeline (Zstandard):**
  - All historical DRAT proof archives across Sessions 1, 2, and 3 have been 100% compressed into `.zst` format (`zstd --rm -1 -T2`) via [`scripts/compress_historical_sessions.sh`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/compress_historical_sessions.sh).
  - Available free space on `/Volumes/Untitled` expanded from $21\text{ GiB}$ to **$217\text{ GiB}$** ($>10\times$ expansion), permanently securing storage headroom.
- **Session 4 Marathon Deployment (Wednesday Sep 16, 20:07 CEST to Friday Sep 18, 12:00 CEST, ~40h):**
  - 3 Performance cores running natively without nice:
    * Solver 1: $\mathbb{Z}_3$ Fixed-3 (`--seed=4444`, PID 4608) $\to$ `proof_z3_fixed3_s4.drat` ($> 7.9\times 10^6$ conflicts).
    * Solver 2: $\mathbb{Z}_3$ FPF (`--seed=9999`, PID 4613) $\to$ `proof_z3_fpf_s4.drat` ($> 7.1\times 10^6$ conflicts).
    * Solver 3: Branch A ($f=1$, `--seed=77777`, PID 4617) $\to$ `proof_branch_a_s4.drat` ($> 5.4\times 10^6$ conflicts).
    * Session 4 Total: $> 20.4\times 10^6$ conflicts in 3.4 hours.
  - Supervisor: [`scripts/local_solver_monitor.sh`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/local_solver_monitor.sh) (PID 10702), reporting to Telegram hourly.
  - Automated Shutdown: [`scripts/auto_stop_friday.sh`](file:///Users/antoniomachuca/Documents/Conway's%2099-Graph%20Problem/scripts/auto_stop_friday.sh) (PID 4220), scheduled for Friday noon (12:00 CEST) with clean unmount and notification.
