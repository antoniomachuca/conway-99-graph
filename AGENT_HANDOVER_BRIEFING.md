# Documento de traspaso — estado corregido de Conway-99

**Revisión documental:** 21 de septiembre de 2026

**Estado vigente detallado:** [README](README.md), [informe técnico](docs/technical_report.md) y [traspaso para agentes](agents/handover_briefing.md).

## 1. Correcciones científicas

- La restricción a una involución con un único vértice fijo ya aparece en la exposición de Makhnev de septiembre de 2009, atribuida a Makhnev–Minakova. No es un descubrimiento de este repositorio.
- La exclusión de orden 7 ya era conocida por Behbahani–Lam (2011). Los logs locales de UNSAT/VERIFIED son evidencia sobre la fórmula registrada, no una prueba de la corrección de su traducción desde grafos.
- El caso de orden 3 sin puntos fijos no debe darse por excluido por confusión con el caso que tiene puntos fijos.
- Las declaraciones finales de Lean para $f=5$ y $f=7$ incorporan hipótesis aritméticas incompatibles. La afirmación de que son exclusiones incondicionales formalizadas de extremo a extremo es incorrecta: **The claim is false according to the current state of the repository.**
- **COMPILED:** se ha reparado el defecto del literal `1` en los compiladores canónicos y en la ruta antigua `build_z3_fpf_cnf.py`. Pasan 20 tests de compiladores, 11 de auditoría de entradas y 8 del supervisor.
- **COMPILED:** la C local antigua usaba O10, soporte `{1,6}`, y repetía la clase secante. La C disjunta corregida usa O11, soporte `{2,3}`. Se conservan los archivos anteriores y se generan entradas nuevas; esto no es una nueva exclusión matemática.

## 2. Taxonomía vigente

| Estado | Alcance |
|---|---|
| **PROVED** | Equivalencia del comprobador, lemas estructurales seleccionados y contradicciones aritméticas auditadas con axiomas estándar. Registros históricos de refutaciones SAT: únicamente al nivel de sus fórmulas. |
| **COMPILED** | Compilación Lean anterior de 32 jobs con tres advertencias `sorry`; wrappers condicionales; 39 tests Python seleccionados pasan (20 compiladores, 11 auditoría, 8 supervisor). La clasificación agregada sigue dependiendo de `sorryAx`. |
| **EXPLORED** | Cálculo reproducible de órbitas y búsquedas sin resolución certificada. No se infiere una probabilidad ni porcentaje de avance de los conflictos. |
| **PENDING** | Reparar y validar codificaciones, recuperar la procedencia exacta de entradas, verificar cobertura, completar interfaces formales, acreditar novedad y resolver las cuestiones abiertas. |

La entrada `conway_z7_canonical.cnf` nombrada en el log no está en la raíz local auditada; el DRAT y los logs sí están. No se ha vuelto a ejecutar `drat-trim` en esta auditoría. La presencia de esos archivos no completa las obligaciones de traducción grafo–CNF.

## Sesión posterior autorizada — EXPLORED

El 21 de septiembre a las 15:32:09 CEST se inició una sola búsqueda de **C disjunta corregida (O11)**: PID 12384, supervisor 12329, `nice 10`, semilla 20260921 y DRAT binario. La parada máxima configurada es el **22 de septiembre a las 03:32:09 CEST**, o antes por 50 GiB de DRAT o menos de 50 GiB libres. El supervisor conserva los artefactos parciales y solo detiene su propio proceso.

La carpeta es `/Volumes/Untitled/conway_local_run/f1_c_drat_20260921T132559366256Z`. Incluye entrada, hashes, copia de fuentes, manifiesto, logs y `status.json`. Esta anotación registra el arranque; hay que consultar procesos y estado para confirmar actividad posterior. La comprobación DRAT sigue **PENDING**. No se modificó GCP ni se enviaron notificaciones.

## 3. Registro histórico del 20 de septiembre — no es telemetría actual

El documento anterior, fechado el **20 de septiembre de 2026 a las 21:49 CEST**, informó de los siguientes datos. Se conservan como **información histórica comunicada**, no como mediciones confirmadas el día 21:

| Concepto informado entonces | Valor comunicado |
|---|---|
| Rama A | Aproximadamente 135.590.239 conflictos; DRAT de 51 GB. |
| Rama B | Aproximadamente 179.187.847 conflictos; DRAT de 56 GB. |
| Rama C | Aproximadamente 178.504.217 conflictos; DRAT de 54 GB. |
| Total de las tres ramas | Más de 493 millones de conflictos; ninguna declarada resuelta. |
| Orden 3 en GCP | Más de 177 millones de conflictos en fixed-3 y 163 millones en FPF. |
| Cartera acumulada | Más de 1.200 millones en GCP y 1.740 millones globales, según el informe anterior. |
| VM | `conway-sat-worker`, `us-central1-b`, `e2-standard-16`; 16 solvers informados. |
| Uptime | 10 días, 9 horas y 48 minutos comunicados. |
| Disco remoto | Ampliación comunicada de 550 GB a 850 GB; 824 GiB de sistema de archivos; 291 GB libres y 65% usado. |
| Interrupciones y pérdida de datos | El informe anterior declaró ninguna interrupción y 0 bytes perdidos; no se ha reconstruido aquí esa comprobación. |
| Mac | Reinicio comunicado a las 10:03 y 79 GiB libres. |
| DRAT de orden 7 | Descarga local comunicada de aproximadamente 183 MB; los archivos locales se inspeccionaron en la auditoría posterior. |

**PENDING:** verificar el estado remoto con evidencia nueva. La revisión documental inicial no accedió a la VM ni lanzó búsquedas. El seguimiento local autorizado y su registro de arranque se describen arriba; los datos históricos del día 20 no son telemetría actual.

## 4. Interpretación y siguientes pasos

Los registros retenidos de orden 7 contienen `s UNSATISFIABLE` y `s VERIFIED`, pero el enunciado anterior de una demostración local incondicional del caso completo excedía esa evidencia. Deben verificarse la codificación y la procedencia de la CNF antes de trasladar el veredicto al problema del grafo.

Las estimaciones de probabilidad y de tiempo hasta UNSAT han sido retiradas del [informe de estrategia](docs/solver_strategy_and_probability_report.md). La prioridad pendiente es validar los modelos y sus interfaces matemáticas. El código formal comprobado conserva utilidad aunque no concluya otra rama; no acredita por sí solo novedad matemática ni resuelve la existencia de un posible grafo rígido.
