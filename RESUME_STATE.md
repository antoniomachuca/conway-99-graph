# Resumen Global de Estado y Protocolo de Reanudación (`RESUME_STATE.md`)

- **Fecha y hora del Checkpoint:** 2026-09-10 21:38:00 CEST
- **Sesión de recuperación:** `e73d203f-d9d9-46be-a291-e1fb53f2b98e`
- **Ubicación del proyecto:** `/Users/antoniomachuca/Documents/Conway's 99-Graph Problem`
- **Espacio disponible en disco interno:** 69 GiB libres (`/System/Volumes/Data`)
- **Disco externo montado:** `/Volumes/Untitled/conway_drat_archives` (466 GiB libres, 56 GB archivados)

---

## 1. Estado del Solver Local en el Mac (PID 79296)

| Proceso | PID | Estado OS | CPU / RAM | Archivo Entrada | Archivo DRAT | Conflictos Guardados |
|---|---|---|---|---|---|---|
| **CaDiCaL 1.9.5** | **79296** | **EJECUTANDO (`RN`)** | **~98% CPU** / ~670 MB RAM | `conway_z2_f1.cnf` | `proof_z2_f1.resume-1.drat` (20.3 GB) | >45,750,000 (>45.7 M) |

*Notas sobre PID 79296:*
- Ha sido reanudado mediante señal `SIGCONT` a las 21:28 CEST tras completarse el traslado de 56 GB de pruebas inactivas al disco externo `/Volumes/Untitled/conway_drat_archives/`.
- El disco interno cuenta ahora con **69 GiB libres**, garantizando margen operativo seguro para el crecimiento de la prueba DRAT.

---

## 2. Infraestructura en Google Cloud (Computación Pesada)

| Recurso | Detalle |
|---|---|
| **Instancia VM** | `conway-sat-worker` |
| **Zona / Región** | `us-central1-b` |
| **Tipo de Máquina** | `e2-standard-16` (16 vCPUs, 64 GB RAM) |
| **Disco** | 300 GB SSD |
| **IP Externa** | `136.111.6.179` |
| **Estado** | `RUNNING` |

### Tareas en la Nube:
1. **Solvers Activos:** 3 ramas CaDiCaL (A, B, C) en paralelo en `~/conway` acumulando >42.7 M conflictos.
2. **Supervisor Autónomo en Nube (`cloud_watcher.sh`):** PID 9072 activo en la VM, monitoreando las ramas cada 15 segundos y ejecutando `drat-trim` inmediatamente tras `s UNSATISFIABLE` con alertas Telegram.
3. **Comando de Monitorización Local:**
   ```bash
   bash scripts/check_cloud_solvers.sh
   ```

---

## 3. Estado Formal en Lean 4

- `lake build` compila con éxito (28/28 jobs).
- Teoremas de incompatibilidad de traza espectral para $f=5$ y $f=7$ probados con axiomas estándar `[propext, Quot.sound]`:
  - `conway_no_z2_f5_automorphism`
  - `conway_no_z2_f7_automorphism`
- Casos $f=3$ (Caso A y Caso B) verificados formalmente con `drat-trim` (`s VERIFIED`).

---

## 4. Estado del Almacenamiento Externo y Respaldo

- Disco `/Volumes/Untitled` conectado y montado (466 GiB libres).
- Pruebas DRAT archivadas con éxito en `/Volumes/Untitled/conway_drat_archives/`:
  - `proof_z2_f1.drat` (1.0 GB)
  - `proof_z3_fixed3.drat` (23 GB)
  - `proof_z3_fpf.drat` (20 GB)
  - `proof_z7_tight.drat` (12 GB)
- Espacio interno en Mac asegurado en **69 GiB libres**.
- Solver local PID 79296 activo al 100% CPU en paralelo a la nube.

