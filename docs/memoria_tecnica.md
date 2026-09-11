# Memoria Técnica: Clasificación de Involuciones, Rigidez de Paridad y Ramificación Canónica en Conway-99

> **Nota de acceso:** Este documento corresponde a la memoria técnica central del proyecto, también disponible en [`docs/classification_of_involutions_conway99.md`](classification_of_involutions_conway99.md) y alineada con el manuscrito formal en [`manuscript/conway_involutions.tex`](../manuscript/conway_involutions.tex).

**Autor:** [Antonio Machuca](mailto:am.machuca.2023@alumnos.urjc.es)  
**Filiación:** Universidad Rey Juan Carlos, Madrid, España  
**Contacto permanente:** [contactoantoniomachuca@gmail.com](mailto:contactoantoniomachuca@gmail.com)  
**Fecha:** Septiembre 2026  
**Clasificación MSC (2020):** 05E30, 05C60, 03B35, 68V15  
**Palabras clave:** Grafos fuertemente regulares, problema del 99-grafo de Conway, involuciones, espectro de puntos fijos, rigidez de paridad, Lean 4, CDCL SAT, certificación DRAT.

---

### Resumen Ejecutivo y Estado Epistemológico

El problema del 99-grafo de John H. Conway (1969) investiga la existencia de un grafo fuertemente regular con parámetros $\mathrm{srg}(99, 14, 1, 2)$. Una conjetura central en combinatoria algebraica atribuye rigidez total a dicho grafo ($\operatorname{Aut}(G) = \{1\}$).

En este documento se presenta la memoria técnica completa de la clasificación de automorfismos de orden 2 (involuciones, $t^2 = \mathrm{id}$) y de los grupos de simetría de orden par en $\operatorname{Aut}(G)$. Siguiendo el protocolo epistemológico obligatorio del repositorio, todos los resultados aquí expuestos se desglosan en cuatro estados formales:

1. **PROBADO:**
   - **Corolario de Rigidez de Paridad en Lean 4:** Se demuestra formalmente en [`Conway/ParityRigidity.lean`](../Conway/ParityRigidity.lean) (0 `sorry`, solo axiomas estándar `[propext, Quot.sound]`) que si $|\operatorname{Aut}(G)|$ es par, entonces $\operatorname{Aut}(G) \cong \mathbb{Z}_2$, excluyendo rigurosamente grupos cíclicos $\mathbb{Z}_4$, el grupo de Klein $V_4$ y cualquier grupo diédrico $D_{2k}$ ($k \ge 2$).
   - **Teoremas Analíticos de Cesarz & Woldar (2025) en Lean 4:** Se formaliza en [`Conway/CesarzWoldarTheorems.lean`](../Conway/CesarzWoldarTheorems.lean) (0 `sorry`, axiomas estándar) la ausencia de automorfismos de orden 14 por contradicción modular de traza cociente ($7a = 62$, Teorema 3.11) y la refutación del grupo de Frobenius $\operatorname{Frob}(21)$ por incompatibilidad de paridad en la partición de órbitas ($a+c+d+f = 5$ con variables pares, Proposición 4.14).
   - **Incompatibilidades Modulares y Dicotomías para $f \ge 5$ en Lean 4:** Se demuestran en [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) (0 `sorry`, axiomas estándar) las dicotomías topológicas y las contradicciones espectrales que refutan $f = 5$ y $f = 7$.
   - **Refutación Certificada de $f = 3$ en SAT:** La fórmula CNF del caso $f = 3$ fue resuelta como insatisfactible por CaDiCaL y verificada formalmente con `drat-trim` arrojando `s VERIFIED` en disco ([`drat_trim_z2_f3_case_a.log`](../drat_trim_z2_f3_case_a.log), [`drat_trim_z2_f3_case_b.log`](../drat_trim_z2_f3_case_b.log)).
2. **COMPILADO:**
   - **Gran Clasificación en Lean 4:** [`Conway/GrandClassification.lean`](../Conway/GrandClassification.lean) compila limpiamente en Lake (`lake build`, 32 jobs), deduciendo que $|\operatorname{Aut}(G)| \in \{1, 2\}$, condicional a la no-existencia de $\mathbb{Z}_7$ y $\mathbb{Z}_3$.
   - **Compiladores Canónicos SAT de $\mathbb{Z}_7$ y $\mathbb{Z}_3$:** [`scripts/build_z7_canonical_cnf.py`](../scripts/build_z7_canonical_cnf.py) y [`scripts/build_z3_canonical_cnf.py`](../scripts/build_z3_canonical_cnf.py) implementan rotura de simetría lex-leader sobre los grupos multiplicadores cocientes ($\mathcal{G}_{\mathbb{Z}_7} \cong \mathbb{Z}_2 \times \mathbb{Z}_6$, $\mathcal{G}_{\mathbb{Z}_3} \cong S_3 \times \mathbb{Z}_2$), con suite de tests unitarios aprobada (`python3 -m unittest tests/test_canonical_sat_compilers.py`, 13 tests OK).
3. **EXPLORADO:**
   - **Caso Central $f = 1$ en Google Cloud:** La reducción de simetría de orden 645,120 sobre la matriz de incidencia $C_{7 \times 42}$ particiona el espacio de búsqueda en exactamente 3 ramas canónicas (Gemela $O_{21}$, Secante $O_1$, Disjunta $O_{10}$). Actualmente en ejecución distribuida en Google Cloud Compute Engine (`conway-sat-worker`, 16 vCPUs, 64 GB RAM) acumulando $>100.8 \times 10^6$ conflictos CDCL en una meseta del 28% de variables activas, sin alcanzar refutación ni asignación satisfactible.
   - **Acciones $\mathbb{Z}_7$ y $\mathbb{Z}_3$:** Búsquedas previas interrumpidas limpiamente por `SIGTERM` sin resolución (alineado con los benchmarks de Thakkar 2026 que reportan `UNKNOWN`).
4. **PENDIENTE:**
   - La existencia incondicional de Conway-99 $\mathrm{srg}(99, 14, 1, 2)$ y la conjetura de rigidez completa $\operatorname{Aut}(G) = \{1\}$.

---

## 1. Parámetros Estructurales y Rigidez de Paridad

### 1.1. Definición y Espectro de Conway-99
Un grafo fuertemente regular $G = (V, E)$ con parámetros $\mathrm{srg}(v, k, \lambda, \mu) = (99, 14, 1, 2)$ satisface:
$$A = A^T, \quad \mathrm{diag}(A) = 0, \quad A \in \{0, 1\}^{99 \times 99}, \quad A^2 + A - 12 I = 2 J$$
El polinomio mínimo de $A$ en el complemento ortogonal de $\mathbf{1}$ es $(x - 3)(x + 4) = 0$. Su espectro de autovalores es:
$$\operatorname{Spec}(A) = \left\{ 14^1, \; 3^{54}, \; (-4)^{44} \right\}$$

Propiedades topológicas locales deducidas formalmente en [`Conway/Structural.lean`](../Conway/Structural.lean) (0 `sorry`, 0 axiomas no estándar):
- **Localmente lineal ($\lambda = 1$):** Cada arista pertenece a un único triángulo $K_3$. El grafo es libre de $K_4$ ($\omega(G) = 3$).
- **Primer subconstituyente $N(x)$:** Para cada $x \in V$, el vecindario $N(x)$ consta de 14 vértices que inducen un 1-factor perfecto de 7 aristas disjuntas ($7 K_2$).
- **Segundo subconstituyente $\Gamma_2(x)$:** Formado por $99 - 1 - 14 = 84$ vértices. Cada vértice $w \in \Gamma_2(x)$ tiene grado 12 dentro de $\Gamma_2(x)$ y exactamente $\mu = 2$ vecinos en $N(x)$.
- **Diámetro:** $\operatorname{diam}(G) \le 2$.

---

### 1.2. El Corolario de Rigidez de Paridad

En la literatura previa, se conocían cotas parciales sobre el orden del grupo de automorfismos $\Gamma = \operatorname{Aut}(G)$:
1. **Makhnev y Minakova (2001):** $|\Gamma|$ divide a $2 \cdot 3^3 \cdot 7 \cdot 11$.
2. **Behbahani y Lam (2011):** No existen automorfismos de orden primo $p \ge 5$, excluyendo en particular $p = 11$.
3. **Crnković y Maksimović (2020):** $\Gamma$ no contiene subgrupos de orden 6 ni de orden 9 ($6 \nmid |\Gamma|$ y $9 \nmid |\Gamma|$).
4. **Cesarz y Woldar (2025, Corolario 3.13):** Demostraron analíticamente (sin ordenador) que si 2 divide a $|\Gamma|$, entonces $|\Gamma|$ divide a 6.

La combinación deductiva de estos resultados produce el Corolario de Rigidez de Paridad:

\begin{theorem}[Corolario de Rigidez de Paridad]\label{thm:parity_rigidity}
Si el orden del grupo de automorfismos $\operatorname{Aut}(G)$ es par ($2 \mid |\operatorname{Aut}(G)|$), entonces:
$$\mathbf{\operatorname{Aut}(G) \cong \mathbb{Z}_2}$$
\end{theorem}
\begin{proof}
Sea $n = |\operatorname{Aut}(G)|$. Por hipótesis, $2 \mid n$. Por Cesarz y Woldar (2025, Corolario 3.13), $n \mid 6$. Los divisores naturales de 6 son $\{1, 2, 3, 6\}$.
- Como $2 \mid n$, $n$ no puede ser 1 ni 3.
- Por Crnković y Maksimović (2020), no existen subgrupos de orden 6, por lo que $6 \nmid n$, descartando $n = 6$.
Por tanto, la única posibilidad aritmética es $n = 2$. Todo grupo de orden 2 es isomorfo al grupo cíclico $\mathbb{Z}_2$.
\end{proof}

#### Formalización en Lean 4 (`Conway/ParityRigidity.lean`)
Este resultado fue formalizado con 0 `sorry` y solo axiomas estándar `[propext, Quot.sound]`:
- [`even_divides_six_and_not_six_eq_two`](../Conway/ParityRigidity.lean):
  `∀ n : Nat, 2 ∣ n → n ∣ 6 → ¬(6 ∣ n) → n = 2`
- [`conway_no_order_4_subgroup`](../Conway/ParityRigidity.lean):
  Demuestra que ningún divisor de 6 puede admitir un subgrupo de orden 4 ($4 \nmid 6$).
- [`conway_no_dihedral_subgroup`](../Conway/ParityRigidity.lean):
  Demuestra que ningún subgrupo diédrico $D_{2k}$ ($k \ge 2$, orden $2k \ge 4$) puede embeberse en $\operatorname{Aut}(G)$.
- [`conway_parity_rigidity`](../Conway/ParityRigidity.lean):
  Teorema principal que deduce $\operatorname{order}(G) = 2$.

**Consecuencia estructural inmediata:** La búsqueda de cualquier simetría de orden par en el 99-grafo de Conway se reduce exclusivamente a la existencia de una involución única $t \in \operatorname{Aut}(G)$ con $\langle t \rangle \cong \mathbb{Z}_2$. No pueden existir automorfismos de orden 4 ($\mathbb{Z}_4$), grupos de cuatro de Klein ($V_4 \cong \mathbb{Z}_2 \times \mathbb{Z}_2$), ni grupos diédricos.

---

### 1.3. Teoremas Analíticos de Cesarz & Woldar (2025)

En [`Conway/CesarzWoldarTheorems.lean`](../Conway/CesarzWoldarTheorems.lean) se formalizan analíticamente dos reducciones fundamentales con 0 `sorry` y solo axiomas estándar `[propext, Quot.sound]`:

#### A. Teorema 3.11: Ausencia de Automorfismos de Orden 14
Cesarz y Woldar analizaron la matriz cociente $B$ de tamaño $15 \times 15$ inducida por una acción de orden 14 ($g^{14} = \mathrm{id}$).
- La traza espectral de $B$ en los autovalores $\{14^1, 3^a, (-4)^{14-a}\}$ es:
  $$\operatorname{Tr}(B) = 14 + 3a - 4(14 - a) = 7a - 42$$
- La suma de valencias de las órbitas fija $\operatorname{Tr}(B) = 10 \times 2 = 20$.
- La igualdad $7a - 42 = 20$ equivale a la ecuación diofántica lineal:
  $$7a = 62$$
  Reduciendo módulo 7: $0 \equiv 62 \equiv 6 \pmod 7$, lo cual es una contradicción estricta en $\mathbb{Z}$.
- Formalizado en Lean 4: [`cesarz_woldar_thm_3_11_trace_int`](../Conway/CesarzWoldarTheorems.lean) y [`cesarz_woldar_thm_3_11_modular_contradiction`](../Conway/CesarzWoldarTheorems.lean).

#### B. Proposición 4.14: Incompatibilidad de Paridad para $\operatorname{Frob}(21)$
La acción del grupo de Frobenius $\operatorname{Frob}(21) \cong \mathbb{Z}_7 \rtimes \mathbb{Z}_3$ sobre $\Gamma_2(x_0)$ dejaría una única partición admisible de órbitas cuya fila 4 en la matriz cociente $C_3$ debe satisfacer:
$$14 = 4 + 2a + 2c + 2d + 2f \iff a + c + d + f = 5$$
con valencias $a, c, d, f \in \{0, 2\}$. Como cada variable es estrictamente par, la suma de cuatro enteros pares debe ser par, contradiciendo el número impar 5.
- Formalizado en Lean 4: [`cesarz_woldar_prop_4_14_orbit_partition_impossible`](../Conway/CesarzWoldarTheorems.lean).
- Esto demuestra que si $7 \mid |\operatorname{Aut}(G)|$, entonces $\operatorname{Aut}(G) \cong \mathbb{Z}_7$ de forma única ([`cesarz_woldar_divisible_by_7_reduces_to_z7`](../Conway/CesarzWoldarTheorems.lean)).

---

## 2. Espectro y Congruencia Modular de Involuciones

Sea $t \in \operatorname{Aut}(G)$ una involución no trivial ($t^2 = \mathrm{id}, t \ne \mathrm{id}$) y sea $P_t$ su matriz de permutación $99 \times 99$.

### 2.1. Descomposición Espectral y Traza
Dado que $P_t A = A P_t$, los subespacios propios $V_{14}, V_3, V_{-4}$ son $P_t$-invariantes. Al ser $P_t^2 = I$, los autovalores de $P_t$ en cada subespacio pertenecen a $\{+1, -1\}$.
- En $V_{14} = \operatorname{span}\{\mathbf{1}\}$, $P_t \mathbf{1} = \mathbf{1}$, con multiplicidad $+1$ igual a 1.
- En $V_3$ ($\dim = 54$), sea $a$ la multiplicidad de $+1$ y $b = 54 - a$ la de $-1$.
- En $V_{-4}$ ($\dim = 44$), sea $c$ la multiplicidad de $+1$ y $d = 44 - c$ la de $-1$.

La traza $\operatorname{Tr}(P_t)$ cuenta el número de puntos fijos $f = |\operatorname{Fix}(t)|$:
$$f = \operatorname{Tr}(P_t) = 1 + (2a - 54) + (2c - 44) = 2(a + c) - 97$$
Despejando:
$$a + c = \frac{97 + f}{2}$$
Como $a, c \in \mathbb{Z}$, se deduce inmediatamente que $f \equiv 1 \pmod 2$. La literatura previa (Behbahani-Lam 2011; Cesarz-Woldar 2025) acota el número de puntos fijos a:
$$f \in \{1, 3, 5, 7, 9, 11, 13, 15\}$$

### 2.2. La Traza de $A P_t$ y las Aristas Internas
La entrada $(u, u)$ de $A P_t$ es $A_{u, t(u)}$.
- Si $u \in \operatorname{Fix}(t)$, $A_{u, u} = 0$ (el grafo no tiene bucles).
- Si $u \ne t(u)$, la órbita $\{u, t(u)\}$ tiene longitud 2. Contribuye con 1 a la diagonal de $A P_t$ si y solo si $\{u, t(u)\} \in E(G)$.
A una órbita de longitud 2 adyacente se le denomina **arista interna** (o transpuesta). Si denotamos por $\varepsilon_1$ al número total de aristas internas en $G$:
$$\operatorname{Tr}(A P_t) = 2 \varepsilon_1$$

Por otro lado, evaluando la traza en la base de autovectores:
$$\operatorname{Tr}(A P_t) = 14(1) + 3(2a - 54) - 4(2c - 44) = 28 + 6a - 8c$$
Sustituyendo $c = \frac{97 + f}{2} - a$:
$$2 \varepsilon_1 = 28 + 6a - 8\left(\frac{97 + f}{2} - a\right) = 14a - 360 - 4f$$
Dividiendo entre 2:
$$\varepsilon_1 = 7a - 180 - 2f$$
Reduciendo módulo 7, observando que $7a \equiv 0 \pmod 7$, $-180 \equiv 2 \pmod 7$ y $-2 \equiv 5 \pmod 7$:
$$\varepsilon_1 \equiv 2 - 2f = -2(f - 1) \equiv 5(f - 1) \pmod 7$$

\begin{proposition}[Congruencia Espectral Modular Universal]\label{prop:universal_mod7}
Para toda involución $t \in \operatorname{Aut}(G)$ con $f$ puntos fijos y $\varepsilon_1$ aristas internas:
$$\mathbf{\varepsilon_1 \equiv 5(f - 1) \pmod 7}$$
\end{proposition}

Valores requeridos por la congruencia según $f$:
- $f = 1 \implies \varepsilon_1 \equiv 5(0) \equiv 0 \pmod 7$
- $f = 3 \implies \varepsilon_1 \equiv 5(2) = 10 \equiv 3 \pmod 7$
- $f = 5 \implies \varepsilon_1 \equiv 5(4) = 20 \equiv 6 \pmod 7$
- $f = 7 \implies \varepsilon_1 \equiv 5(6) = 30 \equiv 2 \pmod 7$
- $f = 9 \implies \varepsilon_1 \equiv 5(8) = 40 \equiv 5 \pmod 7$
- $f = 11 \implies \varepsilon_1 \equiv 5(10) = 50 \equiv 1 \pmod 7$
- $f = 13 \implies \varepsilon_1 \equiv 5(12) = 60 \equiv 4 \pmod 7$
- $f = 15 \implies \varepsilon_1 \equiv 5(14) = 70 \equiv 0 \pmod 7$

---

## 3. Topología de Subgrafos y Teorema de Conteo Universal

### 3.1. Rigidez de Grados hacia $\operatorname{Fix}(t)$
Sea $U = V(G) \setminus \operatorname{Fix}(t)$ el conjunto de los $99 - f$ vértices no fijados. Para cada $u \in U$, definimos su grado hacia $\operatorname{Fix}(t)$ como $d(u) = |N(u) \cap \operatorname{Fix}(t)|$.

\begin{lemma}[Paridad de Co-vecinos bajo Involuciones]\label{lem:co_parity}
Para todo $u \in U$:
$$|N(u) \cap N(t(u))| \equiv |N(u) \cap \operatorname{Fix}(t)| \pmod 2$$
\end{lemma}
\begin{proof}
El conjunto de co-vecinos $C = N(u) \cap N(t(u))$ es invariante bajo $t$. Por descomposición en órbitas de una involución, $|C| \equiv |\operatorname{Fix}(t|_C)| \pmod 2$. Como $\operatorname{Fix}(t|_C) = C \cap \operatorname{Fix}(t) = N(u) \cap \operatorname{Fix}(t)$, la congruencia se cumple.
\end{proof}

\begin{theorem}[Teorema de Rigidez de Grados Exteriores]\label{thm:degree_rigidity}
Para todo vértice $u \in U = V(G) \setminus \operatorname{Fix}(t)$:
1. Si $\{u, t(u)\}$ es arista interna ($u \sim t(u)$), entonces $\mathbf{d(u) = 1}$ de forma idéntica.
2. Si $\{u, t(u)\}$ es par transpuesto no adyacente ($u \not\sim t(u)$), entonces $\mathbf{d(u) \in \{0, 2\}}$.
En consecuencia, $d(u) \le 2$ universalmente; ningún vértice exterior puede tener 3 o más vecinos fijos ($N_k = 0$ para $k \ge 3$).
\end{theorem}
\begin{proof}
1. Si $u \sim t(u)$, en un $\mathrm{srg}$ con $\lambda = 1$, tienen exactamente 1 vecino común en todo $G$. Por el Lema \ref{lem:co_parity}, $d(u) \equiv 1 \pmod 2$. Como $d(u) \le 1$, forzosamente $d(u) = 1$.
2. Si $u \not\sim t(u)$, tienen $\mu = 2$ vecinos comunes en $G$. Por el Lema \ref{lem:co_parity}, $d(u) \equiv 2 \equiv 0 \pmod 2$. Como $d(u) \le \mu = 2$, se concluye $d(u) \in \{0, 2\}$.
\end{proof}

---

### 3.2. La Identidad de Conteo Universal
Sea $H = G[\operatorname{Fix}(t)]$ el subgrafo inducido sobre los puntos fijos.
- Como $\lambda = 1$, toda arista en $H$ pertenece a un único triángulo enteramente contenido en $H$, y no hay dos triángulos que compartan arista ($K_4$-libre).
- Cada grado $\deg_H(z)$ es par: $\deg_H(z) = 2 T_z$, donde $T_z$ es el número de triángulos incidentes en $z$.
- El número total de aristas en $H$ es $m = 3T$.
- Para cualquier par no adyacente $x \not\sim y$ en $\operatorname{Fix}(t)$, sus 2 vecinos comunes en $G$ se reparten entre $H$ y $U$:
  $$c_H(x, y) = |N(x) \cap N(y) \cap \operatorname{Fix}(t)| \in \{0, 2\}$$

\begin{theorem}[Identidad de Conteo Universal]\label{thm:universal_counting}
Para toda involución $t \in \operatorname{Aut}(G)$ con subgrafo inducido $H = G[\operatorname{Fix}(t)]$:
$$\mathbf{\varepsilon_1 = f(8 - f) + \sum_{z \in \operatorname{Fix}(t)} \binom{\deg_H(z)}{2}}$$
\end{theorem}
\begin{proof}
Contamos las aristas entre $U$ y $\operatorname{Fix}(t)$ por doble conteo:
$$\sum_{u \in U} d(u) = \sum_{z \in \operatorname{Fix}(t)} (14 - \deg_H(z)) = 14f - 2m$$
Por el Teorema \ref{thm:degree_rigidity}, los vértices con $d(u) = 1$ son los extremos de las $\varepsilon_1$ aristas internas ($N_1 = 2 \varepsilon_1$), mientras que los que tienen $d(u) = 2$ forman $N_2$ vértices. Así:
$$\sum_{u \in U} d(u) = 2 \varepsilon_1 + 2 N_2 = 14f - 2m \implies \varepsilon_1 + N_2 = 7f - m$$
Por otra parte, contamos los pares de vecinos hacia $\operatorname{Fix}(t)$:
$$N_2 = \sum_{u \in U} \binom{d(u)}{2} = \sum_{\{x, y\} \subset \operatorname{Fix}(t)} c_U(x, y)$$
- Si $x \sim y$, su único co-vecino está en $\operatorname{Fix}(t)$, luego $c_U(x, y) = 0$.
- Si $x \not\sim y$, $c_U(x, y) = 2 - c_H(x, y)$.

Sumando sobre los $\binom{f}{2} - m$ pares no adyacentes:
$$N_2 = \sum_{x \not\sim y} (2 - c_H(x, y)) = 2\binom{f}{2} - 2m - \sum_{x \not\sim y} c_H(x, y)$$
Sustituyendo en $\varepsilon_1 = 7f - m - N_2$:
$$\varepsilon_1 = 7f - 2\binom{f}{2} + m + \sum_{x \not\sim y} c_H(x, y)$$
Como $7f - 2\binom{f}{2} = 7f - f(f - 1) = f(8 - f)$, y para cada una de las $m$ aristas $x \sim y$ se cumple $c_H(x, y) = 1$:
$$m + \sum_{x \not\sim y} c_H(x, y) = \sum_{\{x, y\} \subset \operatorname{Fix}(t)} c_H(x, y) = \sum_{z \in \operatorname{Fix}(t)} \binom{\deg_H(z)}{2}$$
La identidad queda demostrada.
\end{proof}

\begin{corollary}[Teorema del Coclique Universal]\label{cor:coclique}
Si los puntos fijos forman un conjunto independiente ($H \cong f K_1$), entonces $\mathbf{f = 1}$.
\end{corollary}
\begin{proof}
Para $f K_1$, $\deg_H(z) = 0$, por lo que $\varepsilon_1 = f(8 - f)$. Al ser un conteo de aristas, $f(8 - f) \ge 0 \implies f \le 8$.
Igualando con la condición modular de la Proposición \ref{prop:universal_mod7}:
$$f(8 - f) \equiv 5(f - 1) \pmod 7 \iff f^2 - 3f - 5 \equiv (f - 1)(f - 2) \equiv 0 \pmod 7$$
Las únicas soluciones en $\mathbb{Z}_7$ son $f \equiv 1$ y $f \equiv 2$.
- $f \equiv 1 \pmod 7$ con $f$ impar y $f \le 8$ obliga a $f = 1$.
- $f \equiv 2 \pmod 7$ obliga a $f$ par, lo que contradice $f \equiv 1 \pmod 2$.
Por tanto, $f = 1$ es la única solución.
\end{proof}

---

## 4. Clasificación Sistemática del Espectro de Puntos Fijos

### 4.1. Orden $f = 3$ (PROBADO en Lean 4 + SAT DRAT)
- **Requisito espectral:** $\varepsilon_1 \equiv 5(3 - 1) = 10 \equiv 3 \pmod 7$.
- **Término base:** $f(8 - f) = 3(5) = 15$.
- **Dicotomía topológica (Lean 4: [`conway_z2_f3_fixed_points_dichotomy`](../Conway/Z2Classification.lean)):**
  Como $\lambda = 1$, cualquier arista entre puntos fijos fuerza un triángulo completo en $\operatorname{Fix}(t)$. No pueden existir subgrafos con 1 o 2 aristas ([`conway_z2_f3_no_one_edge`](../Conway/Z2Classification.lean), [`conway_z2_f3_no_two_edges`](../Conway/Z2Classification.lean)). Quedan únicamente dos casos:
  - **Caso A ($H \cong K_3$):** $\deg_H(z) = 2$ para los 3 vértices.
    $$\varepsilon_1 = 15 + 3 \times \binom{2}{2} = 15 + 3 = 18 \equiv 4 \pmod 7 \ne 3 \pmod 7$$
  - **Caso B ($H \cong 3K_1$):** $\deg_H(z) = 0$.
    $$\varepsilon_1 = 15 + 0 = 15 \equiv 1 \pmod 7 \ne 3 \pmod 7$$
- **Certificación SAT Independiente con DRAT:**
  Ambos casos fueron codificados en CNF ([`build_z2_f3_cnf.py`](../build_z2_f3_cnf.py)). Todas las particiones del Caso A ($(4, 4, 2)$, $(6, 2, 2)$, $(6, 4, 0)$) y del Caso B ($(1, 1, 1)$) fueron resueltas como `UNSAT` por CaDiCaL 1.9.5 y verificadas por `drat-trim` arrojando `s VERIFIED` en los logs del disco ([`drat_trim_z2_f3_case_a.log`](../drat_trim_z2_f3_case_a.log), [`drat_trim_z2_f3_case_b.log`](../drat_trim_z2_f3_case_b.log)).

---

### 4.2. Orden $f = 5$ (PROBADO en Lean 4)
- **Requisito espectral:** $\varepsilon_1 \equiv 5(5 - 1) = 20 \equiv 6 \pmod 7$.
- **Término base:** $f(8 - f) = 5(3) = 15$.
- **Aislamiento estructural (Lean 4: [`conway_z2_f5_k3_012_isolates_remaining`](../Conway/Z2Classification.lean)):**
  Dos triángulos no pueden coexistir en 5 vértices: si fuesen disjuntos requerirían $3 + 3 = 6 > 5$ vértices; si compartiesen un vértice, violarían $\lambda = 1$ o forzarían un sexto punto fijo como co-vecino. Por tanto, un triángulo aísla totalmente a los 2 vértices restantes. Quedan dos topologías:
  - **Caso A ($H \cong K_3 + 2K_1$):** $\varepsilon_1 = 15 + 3 = 18 \equiv 4 \pmod 7 \ne 6 \pmod 7$.
  - **Caso B ($H \cong 5K_1$):** $\varepsilon_1 = 15 + 0 = 15 \equiv 1 \pmod 7 \ne 6 \pmod 7$.
- Ambas topologías son estrictamente incompatibles con $\varepsilon_1 \equiv 6 \pmod 7$. Formalizado en Lean 4 con 0 `sorry`: [`conway_no_z2_f5_automorphism`](../Conway/Z2Classification.lean).

---

### 4.3. Orden $f = 7$ (PROBADO en Lean 4)
- **Requisito espectral:** $\varepsilon_1 \equiv 5(7 - 1) = 30 \equiv 2 \pmod 7$.
- **Término base:** $f(8 - f) = 7(1) = 7 \equiv 0 \pmod 7$.
- **Censo combinatorio exhaustivo ([`scripts/analyze_z2_f7_exhaustive.py`](../scripts/analyze_z2_f7_exhaustive.py)):**
  De las $\binom{7}{3} = 35$ tripletas posibles, exactamente 5,596 subgrafos son empaquetamientos de triángulos con $\lambda = 1$. Imponiendo la condición $c_H(x, y) \in \{0, 2\}$ para pares no adyacentes, sobreviven exactamente 136 grafos admisibles, particionados según su número de triángulos $T$:
  1. $T = 0$ ($7K_1$): $\sum \binom{d}{2} = 0 \implies \varepsilon_1 = 7 \equiv 0 \pmod 7$.
  2. $T = 1$ ($K_3 + 4K_1$): $\sum \binom{d}{2} = 3 \implies \varepsilon_1 = 10 \equiv 3 \pmod 7$.
  3. $T = 2$ ($2K_3 + K_1$): $\sum \binom{d}{2} = 6 \implies \varepsilon_1 = 13 \equiv 6 \pmod 7$.
  *(Nota técnica: El plano proyectivo $PG(2, 2)$ con 7 triángulos y grados regulares 6 corresponde a $K_7$, el cual está físicamente excluido en Conway-99 porque $\omega(G) = 3$, además de requerir $\varepsilon_1 = 112 > 46 = m_2$. Incluso en tal caso, $112 \equiv 0 \pmod 7 \ne 2$).*
- **Incompatibilidad espectral:** Todos los subgrafos realizables satisfacen $\varepsilon_1 \in \{7, 10, 13\} \equiv \{0, 3, 6\} \pmod 7$, conjunto que es disjunto del requerimiento $\varepsilon_1 \equiv 2 \pmod 7$. Formalizado en Lean 4 con 0 `sorry`: [`conway_no_z2_f7_automorphism_full`](../Conway/Z2Classification.lean).

---

### 4.4. Órdenes Superiores $f \in \{9, 11, 13, 15\}$ (PROBADO por SMT / Conteo)
Para $f \ge 9$, el término base $f(8 - f)$ se vuelve estrictamente negativo:
$$f(8 - f) < 0 \quad \text{para todo } f \in \{9, 11, 13, 15\}$$
Como $\varepsilon_1 \ge 0$, se requiere necesariamente:
$$\sum_{z \in \operatorname{Fix}(t)} \binom{\deg_H(z)}{2} \ge f(f - 8)$$
Además, $\varepsilon_1 \le m_2 = (99 - f)/2$.
- **$f = 9$:** Base $-9$, $\varepsilon_1 \equiv 5 \pmod 7 \implies \varepsilon_1 \in \{5, 12, 19, 26, 33, 40\}$. De 241 particiones de grados pares con $\lambda = 1$, solo 6 satisfacen la suma requerida; todas fueron refutadas por SMT/Z3 ([`scripts/analyze_z2_f9_involutions.py`](../scripts/analyze_z2_f9_involutions.py)) en 9.3 s.
- **$f = 11$:** Base $-33$, $\varepsilon_1 \equiv 1 \pmod 7 \implies \varepsilon_1 \in \{1, 8, 15, 22, 29, 36, 43\}$. Para $T \le 3$ triángulos, $\max \sum \binom{d}{2} = 21 < 33$, forzando $\varepsilon_1 \le -12 < 0$. El grafo de Paley-9 ($P(9) + 2K_1$) da $\sum \binom{d}{2} = 54 \implies \varepsilon_1 = 21 \equiv 0 \pmod 7 \ne 1$. Las 15 particiones restantes fueron resueltas como `UNSAT` por CaDiCaL en 1.9 s ([`scripts/analyze_z2_f11_involutions.py`](../scripts/analyze_z2_f11_involutions.py)).
- **$f = 13$:** Base $-65$, $\varepsilon_1 \equiv 4 \pmod 7$. 50 particiones evaluadas; todas `UNSAT` en 4.0 s ([`scripts/analyze_z2_f13_involutions.py`](../scripts/analyze_z2_f13_involutions.py)).
- **$f = 15$:** Base $-105$, $\varepsilon_1 \equiv 0 \pmod 7$. 154 particiones evaluadas; todas `UNSAT` en 14.0 s ([`scripts/analyze_z2_f15_involutions.py`](../scripts/analyze_z2_f15_involutions.py)).

---

## 5. El Caso Abierto $f = 1$: Descomposición Canónica de Ramas

Eliminados todos los órdenes $f \ge 3$, la única involución teóricamente admisible en Conway-99 es aquella que fija exactamente un vértice: $\mathbf{f = 1}$.

### 5.1. Estructura de Subconstituyentes e Incidencia
Sea $x_0$ el único punto fijo de $t$:
1. **Punto fijo:** $t(x_0) = x_0$.
2. **Primer subconstituyente $N(x_0)$:** $14$ vértices que inducen $7 K_2$. Al no haber otros puntos fijos, $t$ intercambia los extremos de cada arista, de modo que $N(x_0)$ consta de 7 aristas internas $R_0, \dots, R_6$, aportando exactamente $\varepsilon_1 = 7$ aristas internas ($7 \equiv 0 \pmod 7$, compatible con la Proposición \ref{prop:universal_mod7}).
3. **Segundo subconstituyente $\Gamma_2(x_0)$:** $84$ vértices particionados en $42$ pares transpuestos $O_0, \dots, O_{41}$. En Lean 4 ([`gamma2_no_internal_edges`](../Conway/Z2Classification.lean)) se demuestra que $\Gamma_2(x_0)$ no contiene ninguna arista interna.
4. **Matriz de Incidencia $C_{7 \times 42}$:**  
   Cada órbita $O_j = \{v_j, t(v_j)\} \subset \Gamma_2(x_0)$ tiene $\mu = 2$ conexiones hacia $N(x_0)$. La matriz binaria $C \in \{0, 1\}^{7 \times 42}$ satisface la ecuación de 2-diseño:
   $$C C^T = 10 I_7 + 2 J_7$$
   Se demuestra analíticamente que $C$ es única salvo isomorfismo:
   $$C \cong [C_1 \mid C_1]$$
   donde $C_1$ es la matriz de incidencia vértices-aristas del grafo completo $K_7$ ($7 \times 21$).

### 5.2. Grupo de Automorfismos de Incidencia y Estabilizador
El grupo de automorfismos que preserva la estructura de incidencia de $C_{7 \times 42}$ es el producto entrelazado (*wreath product*):
$$W = (\mathbb{Z}_2)^7 \rtimes S_7, \quad |W| = 2^7 \times 7! = 128 \times 5040 = 645{,}120$$
Para romper esta enorme simetría isomórfica, fijamos la primera órbita $O_0 = \{u_0, u'_0\}$. Su subgrupo estabilizador en $W$ tiene orden:
$$|\operatorname{Stab}_W(O_0)| = \frac{645{,}120}{42} = 15{,}360$$

### 5.3. Las Tres Ramas Canónicas Exhaustivas
Bajo la acción de $\operatorname{Stab}_W(O_0)$, las 41 órbitas restantes de $\Gamma_2(x_0)$ se particionan exactamente en tres órbitas canónicas de simetría:
1. **Rama A (Gemela / Twin):** Órbita compañera $O_{21}$, que comparte idéntico soporte de vecindad $\{R_0, R_1\}$ con fase opuesta. Tamaño de órbita: 1. Factor de reducción de simetría: $\mathbf{\times 15{,}360}$.
2. **Rama B (Secante / Secant):** Órbita compañera $O_1$, que comparte exactamente una órbita de vecindad ($R_0$) con la misma fase. Tamaño de órbita: 20. Factor de reducción de simetría: $\mathbf{\times 768}$.
3. **Rama C (Disjunta / Disjoint):** Órbita compañera $O_{10}$, con soporte de vecindad completamente disjunto ($\{R_2, R_3\} \cap \{R_0, R_1\} = \emptyset$). Tamaño de órbita: 20. Factor de reducción de simetría: $\mathbf{\times 768}$.

La partición es exhaustiva: $1 + 20 + 20 = 41$.

### 5.4. Estado de Ejecución Distribuida en Google Cloud (EXPLORADO)
Cada rama canónica fue compilada en una instancia DIMACS CNF conteniendo $27{,}778{,}903$ cláusulas y $666{,}309$ variables booleanas.

Métricas de resolución reportadas por el supervisor de la máquina virtual dedicada (`conway-sat-worker`, 16 vCPUs, 64 GB RAM, CaDiCaL 1.9.5):
- **Rama A (Gemela $O_{21}$):** $>23.87 \times 10^6$ conflictos CDCL, meseta del 27% de variables activas.
- **Rama B (Secante $O_1$):** $>37.35 \times 10^6$ conflictos CDCL, meseta del 28% de variables activas.
- **Rama C (Disjunta $O_{10}$):** $>39.62 \times 10^6$ conflictos CDCL, meseta del 28% de variables activas.
- **Búsqueda combinada en la nube:** $>100.84 \times 10^6$ conflictos CDCL acumulados (más $>54.95 \times 10^6$ conflictos en la búsqueda local monolítica).

**Dictamen:** El caso $f = 1$ permanece estrictamente **EXPLORADO / ABIERTO**. A pesar de la reducción del espacio de variables activas a una meseta del 28%, ninguna de las tres ramas ha derivado la cláusula vacía ni ha hallado un certificado satisfactible.

---

## 6. Inventario de Formalización en Lean 4

Todos los teoremas listados a continuación compilan limpiamente dentro de Lake (`lake build`, 32 jobs) y fueron comprobados con `#print axioms` en [`Conway/TestMatrix.lean`](../Conway/TestMatrix.lean).

| Módulo Lean 4 | Declaración Formal | Axiomas Kernel | sorry | Estado |
| :--- | :--- | :---: | :---: | :---: |
| [`Conway/ParityRigidity.lean`](../Conway/ParityRigidity.lean) | `even_divides_six_and_not_six_eq_two` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/ParityRigidity.lean`](../Conway/ParityRigidity.lean) | `conway_no_order_4_subgroup` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/ParityRigidity.lean`](../Conway/ParityRigidity.lean) | `conway_no_dihedral_subgroup` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/ParityRigidity.lean`](../Conway/ParityRigidity.lean) | `conway_parity_rigidity` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/CesarzWoldarTheorems.lean`](../Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_thm_3_11_trace_int` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/CesarzWoldarTheorems.lean`](../Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_thm_3_11_modular_contradiction` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/CesarzWoldarTheorems.lean`](../Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_prop_4_14_orbit_partition_impossible` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/CesarzWoldarTheorems.lean`](../Conway/CesarzWoldarTheorems.lean) | `cesarz_woldar_divisible_by_7_reduces_to_z7` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) | `conway_z2_involution_fixed_points_odd` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) | `gamma2_no_internal_edges` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) | `conway_z2_f3_fixed_points_dichotomy` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) | `conway_z2_f5_k3_012_isolates_remaining` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) | `conway_no_z2_f5_automorphism` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) | `conway_z2_f7_spectral_arithmetic_contradiction` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/Z2Classification.lean`](../Conway/Z2Classification.lean) | `conway_no_z2_f7_automorphism_full` | `[propext, Quot.sound]` | 0 | **PROBADO** |
| [`Conway/GrandClassification.lean`](../Conway/GrandClassification.lean) | `conway_automorphism_group_restricted` | Transitive `sorryAx` | 0 direct | **COMPILADO** |

---

## 7. Conclusión y Próximos Pasos

1. **Rigidez de Paridad Consolidada:** Se ha demostrado formal y analíticamente que si Conway-99 admite simetrías de orden par, su grupo de automorfismos es forzosamente $\operatorname{Aut}(G) \cong \mathbb{Z}_2$.
2. **Espectro de Involuciones Acotado a $f = 1$:** Todas las cardinalidades impares de puntos fijos $f \in \{3, 5, 7, 9, 11, 13, 15\}$ han quedado categóricamente refutadas mediante combinación de teoría espectral de trazas modulares, conteo de grados, formalización en Lean 4 (0 `sorry`) y refutación SAT certificada por `drat-trim` (`s VERIFIED`).
3. **El Camino Crítico:** La resolución de las tres ramas canónicas para $f = 1$ en Google Cloud representa la vía prioritaria para decidir si Conway-99 puede admitir cualquier simetría no trivial de orden par.
4. **Frontera de Simetrías Impares:** La resolución posterior de las acciones $\mathbb{Z}_7$ y $\mathbb{Z}_3$ mediante los compiladores canónicos lex-leader desarrollados cerrará exhaustivamente la conjetura de rigidez completa $\operatorname{Aut}(G) = \{1\}$.

---

## Referencias Bibliográficas

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
