# Documento de Traspaso y Contexto Integral del Proyecto Conway-99
**Archivo de Transferencia para Agentes / Subagentes Nuevos**
*Fecha y Hora:* 2026-09-10 13:30 CEST  
*Repositorio:* `/Users/antoniomachuca/Documents/Conway's 99-Graph Problem`

---

## 1. Directivas Permanentes y Rigor Epistemológico (De Obligado Cumplimiento)
Cualquier agente que retome este proyecto debe acatar estrictamente las reglas fijadas en `AGENTS.md` y `GEMINI.md`:
1. **Honestidad Radical y Anti-AI-Slop:** Prohibido el optimismo infundado, las afirmaciones prematuras de victoria ("Problema Resuelto", "Demostración Definitiva") o la complacencia. El tono debe ser austero, escéptico y preciso, propio de un auditor forense.
2. **Clasificación Estricta de Estados:** Todo resultado debe clasificarse únicamente en:
   - **PROBADO:**
     - En Lean 4: 0 `sorry`, 0 `sorryAx`, `#print axioms` mostrando solo `[propext, Quot.sound]`.
     - En SAT: Log finalizado explícitamente en `s UNSATISFIABLE` o `s SATISFIABLE`, y certificado con `drat-trim` mostrando `s VERIFIED`.
   - **COMPILADO:** Código que compila pero cuyos teoremas dependen transitivamente de `sorry` o premisas externas no internalizadas en el kernel.
   - **EXPLORADO:** Cálculos en curso, heurísticas o búsquedas sin conclusión terminal.
   - **PENDIENTE:** Hipótesis abiertas e instancias pendientes.
3. **Contexto Real de Conway-99:** Problema abierto desde hace 50 años (existencia de un grafo fuertemente regular con parámetros $\mathrm{srg}(99, 14, 1, 2)$). Si el grafo existe, la sospecha predominante en la literatura matemática (Brouwer, Cameron) es que es **rígido** ($\operatorname{Aut}(G) = \{1\}$). Las búsquedas bajo simetrías ($\mathbb{Z}_2, \mathbb{Z}_3, \mathbb{Z}_7$) solo cubren ramas con automorfismos; si el grafo carece de simetrías, estas búsquedas nunca lo hallarán.

---

## 2. Estado de la Cuestión: Qué se ha Conseguido Hasta Ahora

### A. Involuciones $\mathbb{Z}_2$ (Automorfismos de Orden 2)
Una involución $t$ es una permutación con $t^2 = \mathrm{id}$ que preserva la adyacencia. La paridad exige que el número de puntos fijos $f = |\mathrm{Fix}(t)|$ sea impar: $f \in \{1, 3, 5, 7, 9, \dots\}$.

1. **$f = 3$ [PROBADO]:**
   - **Caso A (Triángulo $K_3$):** Refutado en SAT con CaDiCaL y certificado formalmente con `drat-trim` (`s VERIFIED`) en `drat_trim_z2_f3_case_a.log`.
   - **Caso B ($3K_1$):** Refutado en SAT con CaDiCaL y certificado formalmente con `drat-trim` (`s VERIFIED`) en `drat_trim_z2_f3_case_b.log`.
   - Formalizado estructuralmente en Lean 4 (`Conway/Z2Classification.lean:526`).
2. **$f = 5$ y $f = 7$ [PROBADO ARITMÉTICAMENTE EN LEAN 4]:**
   - Teoremas en `Conway/Z2Classification.lean` (0 `sorry`, axiomas estándar):
     - `conway_no_z2_f5_automorphism`
     - `conway_no_z2_f7_automorphism`
   - La traza espectral exige $\varepsilon_1 \equiv 5(f - 1) \pmod 7$. Para $f=5$ ($\varepsilon_1 \equiv 6 \pmod 7$) y $f=7$ ($\varepsilon_1 \equiv 2 \pmod 7$), las configuraciones de subgrafos admisibles producen valores de $\varepsilon_1$ aritméticamente incompatibles.
3. **$f = 1$ (El Gran Caso Abierto de la Literatura) [EXPLORADO / EN RESOLUCIÓN ACTIVA]:**
   - Representa una involución con un único punto fijo $x_0$ y 49 órbitas de pares transpuestos.
   - La submatriz de incidencia de vecinos $C_{7 \times 42}$ satisface $C C^T = 10 I_7 + 2 J_7$.
   - **Hito Teórico Alcanzado:** Se demostró algebraicamente en `scripts/classify_z2_f1_incidence_matrix.py` que $C$ es única hasta isomorfismo ($|W| = 645.120$), y que el espacio de búsqueda se particiona de forma exacta y exhaustiva en **3 ramas canónicas de ruptura de simetría**:
     - **Rama A (Gemela):** La pareja de $O_0$ es $O_{21}$ (simetría rota $\times 15.360$).
     - **Rama B (Secante):** La pareja de $O_0$ es $O_1$ (simetría rota $\times 768$).
     - **Rama C (Disjunta):** La pareja de $O_0$ es $O_{10}$ (simetría rota $\times 768$).

---

## 3. Estado Actual de los Procesos y de la Infraestructura

### A. Google Cloud Compute Engine (Computación Pesada Activa)
- **Instancia:** `conway-sat-worker` en GCP (`us-central1-b`).
- **Hardware:** `e2-standard-16` (16 vCPUs, 64 GB RAM, 300 GB SSD).
- **Procesos en Ejecución:** 3 solvers CaDiCaL 1.9.5 en paralelo al 99.9% de CPU cada uno:
  - `conway_z2_f1_branch_a.cnf` -> `proof_z2_f1_branch_a.drat`
  - `conway_z2_f1_branch_b.cnf` -> `proof_z2_f1_branch_b.drat`
  - `conway_z2_f1_branch_c.cnf` -> `proof_z2_f1_branch_c.drat`
- **Estado (a las 13:28 CEST):**
  - Rama A: 1.77 M conflictos (38% vars activas).
  - Rama B: 2.41 M conflictos (29% vars activas).
  - Rama C: 2.27 M conflictos (39% vars activas).
  - Total combinado: >6.4 M conflictos. Espacio en disco en la VM: 286 GB libres.
- **Comando de Comprobación Rápida:**
  ```bash
  bash scripts/check_cloud_solvers.sh
  ```

### B. Proceso Local en el Mac (PID 79296) [CONGELADO EN MEMORIA]
- **Comando:** `./cadical conway_z2_f1.cnf proof_z2_f1.resume-1.drat`
- **Tiempo de CPU Acumulado:** 602 minutos (más de 10 horas).
- **Conflictos:** 43.959.195 (~44 M de conflictos).
- **Estado OS:** **PAUSADO con `SIGSTOP`** (estado `TN` en `ps`). Consume **0% CPU** y **0 bytes de disco**.
- **Motivo de la Pausa:** Proteger el disco interno del Mac (quedaban 22 GiB libres y la prueba crecía a 2 GB/h).
- **Plan:** El usuario ha comprado un disco duro externo. Cuando se conecte, se moverán 56 GB de pruebas inactivas antiguas (`proof_z3_*.drat` y `proof_z7_tight.drat`) al disco externo, liberando 56 GB en el Mac (~78 GiB libres). En ese momento, se puede reanudar con `kill -CONT 79296` si fuera necesario.

### C. Demonio Local de Monitorización (PID 93183)
- **Script:** `scripts/daemon_hourly_monitor.sh`
- **Función:** Cada 60 minutos consulta la VM en Google Cloud, guarda las estadísticas en `cloud_monitoring.log`, y muestra un cartel de notificación nativo en la pantalla del Mac del usuario con sonido `Pop`.
- **Alertas de Terminación:** Si una rama termina en `s UNSATISFIABLE` o `s SATISFIABLE`, lanza alerta sonoro de alta prioridad.
- **Coste:** 0 tokens de IA.

---

## 4. Hoja de Ruta y Próximos Pasos Técnicos

1. **Monitoreo de las 3 Ramas en GCP:**
   - Esperar a que la Rama A, B o C terminen.
   - Si una rama termina en `s UNSATISFIABLE`:
     Ejecutar en la VM:
     ```bash
     drat-trim conway_z2_f1_branch_<X>.cnf proof_z2_f1_branch_<X>.drat -L proof_<X>.lrat
     ```
     Verificar que devuelva `s VERIFIED`.
   - Si las 3 ramas son `UNSATISFIABLE`, el caso $f = 1$ queda **REFUTADO AL 100%**.
   - Con ello, el orden par $\mathbb{Z}_2$ queda **completamente cerrado en Conway-99**.
2. **Recepción del Disco Duro Externo:**
   - Montar el disco en `/Volumes/<DISCO>`.
   - Mover pruebas DRAT inactivas:
     ```bash
     mv proof_z3_*.drat /Volumes/<DISCO>/
     mv proof_z7_tight.drat /Volumes/<DISCO>/
     ```
   - Evaluar si reanudar PID 79296 (`kill -CONT 79296`) o dar prioridad absoluta a los resultados de la nube.
3. **Siguiente Frontera Matemática (Si $\mathbb{Z}_2$ queda cerrado):**
   - Abordar $\mathbb{Z}_3$ (orden 3: fixed-point-free y 3 puntos fijos).
   - Integrar los certificados SAT en el kernel de Lean 4 eliminando los `sorry` en `Conway/Z7NonExistence.lean` y `Conway/Z3*.lean`.
