# Estado del Agente: `z2_solver_operator`

- **Última actualización:** 2026-09-10 01:59:00 CEST
- **Rol:** Operador y monitor del solver CaDiCaL para involuciones $\mathbb{Z}_2$ ($f = 1$).
- **Estado del proceso:** ACTIVO (PID: 79296, ejecutándose en segundo plano con CPU ~95%).

---

## 1. Parámetros de la Ejecución en Curso
- **Comando:** `./cadical conway_z2_f1.cnf proof_z2_f1.resume-1.drat > cadical_z2_f1.resume-1.log 2>&1 &`
- **PID:** 79296
- **Instancia CNF:** `conway_z2_f1.cnf` (27,778,444 bytes, 666,309 vars, 1,508,157 cls)
- **Prueba DRAT activa:** `proof_z2_f1.resume-1.drat` (formato binario compacto, ~211 MB y creciendo a ritmo seguro)
- **Prueba DRAT previa protegida:** `proof_z2_f1.drat` (1,053,368,320 bytes = 1.05 GB, 1.97M conflictos previos, inmutable)
- **Log activo:** `cadical_z2_f1.resume-1.log`
- **Conflictos alcanzados en esta sesión:** >100,000 en ~145 s de CPU (~690 conflictos/s)
- **Variables activas tras in-processing:** 286,792 (43% remanentes)
- **Memoria RSS:** ~73 MB

---

## 2. Protocolo de Inspección Rápida
Para consultar el progreso sin interrumpir el proceso:
```bash
# Ver últimos conflictos
grep "conflicts" cadical_z2_f1.resume-1.log | tail -n 5
# Ver tamaño de la prueba binaria
ls -lh proof_z2_f1.resume-1.drat
# Comprobar que sigue vivo
ps aux | grep 79296 | grep -v grep
```

---

## 3. Protocolo de Terminación
- Si CaDiCaL termina con `s UNSATISFIABLE`:
  ```bash
  ./drat-trim/drat-trim conway_z2_f1.cnf proof_z2_f1.resume-1.drat -L proof_z2_f1.lrat
  ```
- Si CaDiCaL termina con `s SATISFIABLE`:
  - Extraer asignación y verificar formalmente con `Matrix99.verifyCandidate` en `Conway/Decidable.lean`.
