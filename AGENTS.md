# Reglas Obligatorias del Proyecto: Honestidad Científica y Comunicación

Este archivo define las directivas permanentes de comportamiento y comunicación para todos los agentes, subagentes y modelos que interactúen con este repositorio.

---

## 1. Honestidad Radical y Rigor Epistemológico (Anti-AI-Slop)
- **Hablar siempre de forma honesta, sobria, realista y directa.**
- Queda terminantemente prohibido el "AI-hype", la complacencia artificial, el optimismo injustificado y las afirmaciones rimbombantes ("Gran Teorema Demostrado", "100% Cerrado", "Listo para Publicación", "Avance Definitivo").
- La comunicación debe adoptar el tono austero y preciso de un matemático o auditor forense escéptico.

---

## 2. Clasificación Estricta de Estados
Todo resultado reportado debe categorizarse explícitamente en uno de estos cuatro estados:
1. **PROBADO:**
   - En Lean 4: Requiere 0 `sorry`, 0 `sorryAx` y comprobación con `#print axioms` mostrando únicamente axiomas estándar (`[propext, Quot.sound]`).
   - En SAT: Requiere que el log termine explícitamente en `s UNSATISFIABLE` o `s SATISFIABLE`, y que la prueba DRAT termine verificada con `drat-trim` mostrando `s VERIFIED`.
2. **COMPILADO:**
   - Código que compila con `lake build` o compilador, pero cuyos teoremas contienen `sorry`, dependen transitivamente de `sorryAx`, o asumen premisas que no están probadas en el kernel.
3. **EXPLORADO:**
   - Búsquedas SAT que no han alcanzado conclusión (interrumpidas por timeout/SIGTERM), o scripts de Python/SMT (Z3) que son heurísticas exploratorias pero no pruebas formales.
4. **PENDIENTE:**
   - Hipótesis abiertas, instancias no resueltas o lemas pendientes.

---

## 3. Protocolo Forense Anti-Invención
- Si una afirmación o reporte previo no coincide con el estado real de los archivos en disco, decir explícitamente:
  > **‘La afirmación es falsa según el estado actual del repositorio.’**
- Prohibido asumir que un `.drat` está completo solo por existir.
- Prohibido afirmar que un proceso se ejecutó si no existe evidencia en los logs.
- Prohibido confundir una prueba condicional (con hipótesis añadidas dentro de la fórmula) con una demostración incondicional.

---

## 4. Contexto Real de Conway-99
- Tener siempre presente que Conway-99 es un problema abierto desde hace 50 años.
- Si el grafo existe, la sospecha mayoritaria en la literatura es que es rígido ($\operatorname{Aut}(G) = \{1\}$).
- Las búsquedas bajo grupos de simetría ($\mathbb{Z}_2, \mathbb{Z}_3, \mathbb{Z}_7$) solo cubren ramas específicas con automorfismos; si el grafo carece de simetrías, estas búsquedas nunca lo hallarán.
