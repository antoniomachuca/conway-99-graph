# Documento de traspaso — estado corregido de Conway-99

**Revisión documental:** 21 de septiembre de 2026

**Estado vigente detallado:** [README](README.md), [informe técnico](docs/technical_report.md) y [traspaso para agentes](agents/handover_briefing.md).

## 1. Correcciones científicas

- La restricción a una involución con un único vértice fijo ya aparece en la exposición de Makhnev de septiembre de 2009, atribuida a Makhnev–Minakova. No es un descubrimiento de este repositorio.
- La exclusión de orden 7 ya era conocida por Behbahani–Lam (2011). Los logs locales de UNSAT/VERIFIED son evidencia sobre la fórmula registrada, no una prueba de la corrección de su traducción desde grafos.
- El caso de orden 3 sin puntos fijos no debe darse por excluido por confusión con el caso que tiene puntos fijos.
- Las declaraciones finales de Lean para $f=5$ y $f=7$ incorporan hipótesis aritméticas incompatibles. La afirmación de que son exclusiones incondicionales formalizadas de extremo a extremo es incorrecta: **The claim is false according to the current state of the repository.**
- El compilador canónico actual de orden 7 confunde la variable SAT `1` con la constante verdadera. Se ha reproducido el error sin lanzar una búsqueda del grafo. La revisión documental no lo corrige.

## 2. Taxonomía vigente

| Estado | Alcance |
|---|---|
| **PROVED** | Equivalencia del comprobador, lemas estructurales seleccionados y contradicciones aritméticas auditadas con axiomas estándar. Registros históricos de refutaciones SAT: únicamente al nivel de sus fórmulas. |
| **COMPILED** | Compilación Lean de 32 jobs con tres advertencias `sorry`; wrappers condicionales; 13 tests del compilador que pasan pese al defecto semántico. La clasificación agregada depende de `sorryAx`. |
| **EXPLORED** | Cálculo reproducible de órbitas y búsquedas sin resolución certificada. No se infiere una probabilidad ni porcentaje de avance de los conflictos. |
| **PENDING** | Reparar y validar codificaciones, recuperar la procedencia exacta de entradas, verificar cobertura, completar interfaces formales, acreditar novedad y resolver las cuestiones abiertas. |

La entrada `conway_z7_canonical.cnf` nombrada en el log no está en la raíz local auditada; el DRAT y los logs sí están. No se ha vuelto a ejecutar `drat-trim` en esta auditoría. La presencia de esos archivos no completa las obligaciones de traducción grafo–CNF.

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

**PENDING:** verificar cualquier estado operativo actual consultando evidencia nueva. Esta revisión no accedió a la VM, no verificó los procesos de las unidades externas y no inició, detuvo ni reconfiguró solvers.

## 4. Interpretación y siguientes pasos

Los registros retenidos de orden 7 contienen `s UNSATISFIABLE` y `s VERIFIED`, pero el enunciado anterior de una demostración local incondicional del caso completo excedía esa evidencia. Deben verificarse la codificación y la procedencia de la CNF antes de trasladar el veredicto al problema del grafo.

Las estimaciones de probabilidad y de tiempo hasta UNSAT han sido retiradas del [informe de estrategia](docs/solver_strategy_and_probability_report.md). La prioridad pendiente es validar los modelos y sus interfaces matemáticas. El código formal comprobado conserva utilidad aunque no concluya otra rama; no acredita por sí solo novedad matemática ni resuelve la existencia de un posible grafo rígido.
