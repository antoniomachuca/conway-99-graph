# Campaign A: a discriminant obstruction for automorphisms of prime order of regular graphs

Lead, 2026-10-13 (Actualizado: 2026-10-14). Estado taxonómico: **`EXPLORED`** (derivación matemática y validación numérica reproducible; manuscrito formal en `discriminant_obstruction.tex` / `discriminant_obstruction.pdf`; no formalizado en kernel de Lean 4, no arbitrado externamente). Generaliza el argumento de orden 3 de D. Djematene para $\operatorname{srg}(99,14,1,2)$ (Zenodo 10.5281/zenodo.23305123, revisado en `../djematene_review/REVIEW.md`) a órdenes primos arbitrarios $p \le 19$, a automorfismos con puntos fijos, y a grafos regulares conexos con cualquier número de autovalores mediante el polinomio de Hoffman.

---

## 1. Enunciado Formal (Caso Libre de Puntos Fijos)

Sea $\Gamma$ un $\operatorname{srg}(v,k,\lambda,\mu)$ no completo con autovalores enteros $k > r > s$, $\sigma$ un automorfismo de orden primo $p$ que actúa sin puntos fijos ($v = pm$), $\theta \in \{r, s\}$, $\theta'$ el autovalor complementario, y asumamos la condición de coprimalidad $p \nmid (k-\theta)(\theta-\theta')$.

Sean:
- $Q = \sum_b A_b \in M_m(\mathbb{Z})$ (matriz órbita cociente entera).
- $M = \sum_b \zeta^b A_b \in M_m(\mathcal{O}_K)$ (matriz hermítica sobre el anillo de enteros del cuerpo ciclotómico $K = \mathbb{Q}(\zeta_p)$).
- $L = \mathbb{Z}^m \cap \ker(Q - \theta I)$ de rango $a$, con discriminante $d = \det(B^{\mathsf T} B)$.
- $L' = \mathcal{O}_K^m \cap \ker(M - \theta I)$ de rango $a'$, con discriminante $d' = \det(B'^* B')$ (totalmente positivo en $\mathcal{O}_{K^+}$) para $p \le 19$ ($\mathcal{O}_K$ dominio de ideales principales).

Entonces:
1. **(R) Restricción de Rango y Trazas:**
   $a = a'$, $p \mid f_\theta$, y $\sum_U A_b[U,U] = (k - \theta')/p$ para todo $b \not\equiv 0 \pmod p$ (cada $\sigma^b$ mueve exactamente $k - \theta'$ vértices a vecinos). Por la identidad $(k-\theta)(k-\theta') = \mu v$, esto es automático a partir de los parámetros y concuerda con las identidades de Ishida (arXiv:2606.29183).
2. **(D) Obstrucción de Discriminante (para $p \le 19$):**
   - $d \mid ((k-\theta)(\theta-\theta'))^a$.
   - $\operatorname{N}_{K^+/\mathbb{Q}}(d') \mid |\theta-\theta'|^{a(p-1)/2}$.
   - **Compatibilidad de Legendre:** $\chi(d) \equiv \operatorname{N}_{K^+/\mathbb{Q}}(d') \pmod p$, donde $\chi$ es el símbolo de Legendre módulo $p$.
   - **Condición de Paridad:** Para todo primo $\ell \mid m$ tal que $\ell \nmid (m/g)(\theta-\theta')$, donde $g = \gcd(m, k-\theta)$:
     $$v_\ell(d) \equiv v_\ell(m) \pmod 2.$$

### Bosquejo de la Demostración
- Matrices anuladoras: $N = (k-\theta)(Q - \theta'I) - p\mu J$ y $N' = M - \theta'I$ satisfacen $(Q-\theta I)N = 0$, $(M-\theta I)N' = 0$, $G K = (k-\theta)(\theta-\theta')I_a$ y $G' K' = (\theta-\theta')I_{a'}$.
- Reducción módulo $\pi = 1 - \zeta$: $N \equiv (k-\theta)N' \pmod \pi$, lo que fuerza $a = a'$ y $\rho(d') = \det(\bar C \bar B')^2 \rho(d)$.
- Por el criterio de Euler y Galois: $\chi(\rho(d')) = \rho(\operatorname{N}_{K^+/\mathbb{Q}}(d'))$.
- Gluing con el vector de unos $\mathbf{1}$ en $\ker((Q-\theta I)(Q-kI))$ con $N_W = (m/g)(Q - \theta'I) - ((k-\theta)/g)J$: produce $m \cdot d = \det(T)^2 \det G_W$ con $\det G_W \mid ((m/g)(\theta-\theta'))^{a+1}$, determinando la paridad de $v_\ell(d)$.

---

## 2. Validación Numérica en Grafos Conocidos (`obstruction.py`, `validate_p11.py`, `validate_p13_19.out`)

Validado en grafos triangulares $T(n)$ y sus complementos, con $\sigma$ generado como producto de $p$-ciclos que fijan a lo sumo un punto (acción libre de puntos fijos en pares de vértices):
- $p = 3$: $n \in \{7, 9, 10, 15\}$
- $p = 5$: $n \in \{10, 11, 15\}$
- $p = 7$: $n \in \{14, 15\}$
- $p = 11$: $n \in \{22, 23\}$
- $p = 13$: $n \in \{13, 14, 27\}$ (incluyendo $T(27)$ sobre $v = 351$ vértices)
- $p = 17$: $n \in \{17, 18\}$
- $p = 19$: $n \in \{19, 20\}$

**Resultados de la validación:**
- **$p = 13, 17, 19$ confirmados:** Las 14 instancias correspondientes a $p = 13, 17, 19$ fueron ejecutadas y verificadas exhaustivamente sin discrepancias (registradas en `validate_p13_19.out`).
- En la totalidad de los **36 casos aplicables** evaluados ($18$ para $p \le 7$, $4$ para $p = 11$, y $14$ para $p \in \{13, 17, 19\}$), los invariantes calculados ($a, a', d, \operatorname{N}(d')$) satisfacen con precisión todas las relaciones teóricas predichas:
  - Igualdad de rango estricta: $a = a'$.
  - Recuento de ciclos constante: $c_b = (k - \theta')/p$.
  - Congruencia de caracteres: $\chi(d) \equiv \operatorname{N}_{K^+/\mathbb{Q}}(d') \pmod p$.
  - Divisibilidad de discriminantes y normas algebraicas.
  - Paridades $v_\ell(d) \equiv v_\ell(m) \pmod 2$.
- El evaluador de parámetros `test_params` no genera falsos positivos (no excluye ningún grafo existente).
- En los casos no aplicables (donde $p \mid (k-\theta)(\theta-\theta')$), ocurre $a \neq a'$, confirmando que la condición de coprimalidad es indispensable.

**Controles adicionales independientes:**
- Grafo de Petersen con un $5$-ciclo: $a = a' = 1$, $d = 2$, $\operatorname{N}(d') = 9$.
- Grafo de colinealidad de $GQ(3,3)$, $\operatorname{srg}(40,12,2,4)$, con automorfismo de orden 5 libre de puntos fijos: $a = a' = 3$, $d = 288$, $\operatorname{N}(d') = 5184$.
- Test de falsación sobre 1.076 familias de parámetros conocidas: únicamente se marca $\operatorname{srg}(209,100,45,50)$ con $p=11$. Las realizaciones conocidas (descendientes del two-graph regular sobre 210 puntos) poseen grupo de automorfismos de orden 24, careciendo de elementos de orden 11, lo que concuerda con la obstrucción teórica.

---

## 3. Barrido de Parámetros Abiertos de Brouwer (`scan_brouwer.py`, `scan_out.jsonl`)

Sobre 2.889 conjuntos de parámetros abiertos marcados con '?' en las tablas de Brouwer ($v \le 1300$), 2.819 con autovalores enteros:
- 10.322 tripletas $(\text{set}, p, \theta)$ no aplicables por divisibilidad.
- 3.588 pasaron el test.
- **34 pares $(\text{set}, p)$ fueron excluidos definitivamente por (D)** en el caso libre de puntos fijos (ninguno por condición de rango R sola).
- La lista incluye $\operatorname{srg}(99,14,1,2)$ con $p=3$ (el caso Djematene) y $\operatorname{srg}(88,27,6,9)$ con $p=11$.

---

## 4. Extensión a Automorfismos con Puntos Fijos (`fixed_points.py`, `scan_fixed3.py`)

Sea $\sigma$ de orden primo $p$ con conjunto fijo $F$ ($f = |F|$, subgrafo inducido $\Gamma_F$ con matriz de adyacencia $A_F$) y $m$ órbitas regulares ($v = pm + f$).

1. **Acción en el subespacio invariante:**
   $$\tilde A = \begin{pmatrix} Q & a \\ p\,a^{\mathsf T} & A_F \end{pmatrix}, \qquad \tilde A\mathbf{1} = k\mathbf{1}, \qquad (\tilde A - rI)(\tilde A - sI) = \mu \mathbf{1} w^{\mathsf T},$$
   autoadjunta respecto a la forma $D = \operatorname{diag}(p I_m, I_f)$. En las componentes isotípicas no triviales, los vértices fijos tienen peso nulo y $M = \sum_b \zeta^b A_b$ preserva sus propiedades espectrales.
2. **Condición Espectral (F):**
   Si $\det\bigl((k - \theta)(\theta I_f - A_F) + \mu J_f\bigr) \not\equiv 0 \pmod p$, entonces todas las coordenadas fijas de cualquier vector de $L$ son divisibles por $p$. La matriz de Gram inducida satisface $B^{\mathsf T} D B = p \tilde G$ con $\tilde G$ entera, y su discriminante $\tilde d = \det \tilde G$ satisface las mismas condiciones de divisibilidad, carácter y paridad que en el caso libre de puntos fijos (sustituyendo $m$ por $v$).
3. **Cota de Puntos Fijos y Subgrafos Admisibles:**
   Si $p > \max(\lambda, \mu)$ y $\mu \ge 2$, dos vértices fijos sólo pueden compartir vecinos fijos, forzando la cota $f \le v / (p + 1)$ (Lema 5 / `lem:bigp`). Los subgrafos inducidos admisibles $\Gamma_F$ quedan restringidos a cliques $K_{\lambda+2}$, grafos fuertemente regulares inducidos, o uniones/joins regulares.

### Tabla Resumen de Resultados por Grafo (Extensión a Puntos Fijos)

| Caso | Grafo SRG | $p$ | Puntos Fijos Admisibles | Subgrafos Fijos $\Gamma_F$ | $\theta$ Test | $\det_F \pmod p$ | Contradicción Aritmética | Estado Taxonómico | Novedad en Literatura |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **1** | $\operatorname{srg}(99, 14, 1, 2)$ | 3 | $\{0, 3, \dots, 24\}$ | $\emptyset, K_3, \text{Paley}(9)$ | 3 | $2, 1 \neq 0$ | $\{-1\} \cap \{+1\} = \emptyset$ | **`EXPLORED`** | Conocido (Djematene 2024) |
| **2** | $\operatorname{srg}(88, 27, 6, 9)$ | 11 | $\{0\}$ | $\emptyset$ | 3 | $1 \neq 0$ | $\{-1\} \cap \{+1\} = \emptyset$ | **`EXPLORED`** | **NUEVO** (cierra Behbahani–Lam 2011) |
| **3** | $\operatorname{srg}(342, 33, 4, 3)$ | 7 | $\{6, \dots, 41\}$ | $K_6$ | -5 | $1 \neq 0$ | $\{-1\} \cap \{+1\} = \emptyset$ | **`EXPLORED`** | **NUEVO** (inédito) |
| **4** | $\operatorname{srg}(364, 33, 2, 3)$ | 5 | $\{4, \dots, 59\}$ | $K_4$ | 5 | $1 \neq 0$ | $\{-1\} \cap \{+1\} = \emptyset$ | **`EXPLORED`** | **NUEVO** (cierra Kazarina–Makhnev 2005) |
| **5** | $\operatorname{srg}(561, 60, 9, 6)$ | 11 | $\{0, \dots, 44\}$ | $\emptyset, K_{11}$ | 9 | $4 \neq 0$ | $\{-1\} \cap \{+1\} = \emptyset$ | **`EXPLORED`** | **NUEVO** (inédito) |
| **6** | $\operatorname{srg}(650, 55, 0, 5)$ | 11 | $\{1, \dots, 45\}$ | $K_1$ | 5, -10 | $2, 4 \neq 0$ | $\{-1\} \cap \{+1\} = \emptyset$ | **`EXPLORED`** | **NUEVO** (inédito) |

---

## 5. Extensión a Grafos Regulares con Más Autovalores vía Polinomio de Hoffman (`general.py`, `scan_drg.py`)

La obstrucción no depende intrínsecamente de que el grafo sea fuertemente regular (3 autovalores). Para cualquier grafo conexo $k$-regular $\Gamma$ con $d+1$ autovalores distintos $k = \theta_0 > \theta_1 > \dots > \theta_d$, el **polinomio de Hoffman**
$$H(x) = \prod_{i=1}^d (x - \theta_i) \in \mathbb{Z}[x]$$
satisface $H(A) = c J$, con constante entera $c = H(k)/v \in \mathbb{Z}$.

Para cada autovalor entero $\theta = \theta_j \neq k$:
- Se define $P_\theta(x) = H(x) / (x - \theta) \in \mathbb{Z}[x]$ y la constante $c_\theta = (k - \theta) P_\theta(\theta)$.
- Se sustituyen las matrices anuladoras por $N = (k - \theta) P_\theta(\tilde A) - c \mathbf{1} w^{\mathsf T}$, $N' = P_\theta(M)$, y $N_W = \alpha P_\theta(\tilde A) - \beta \mathbf{1} w^{\mathsf T}$ con $\beta v = \alpha(P_\theta(k) - P_\theta(\theta))$.
- Bajo la condición espectral en el subgrafo fijo:
  $$\det\bigl((k - \theta)(P_\theta(\theta) I_f - P_\theta(A_F)) + c J_f\bigr) \not\equiv 0 \pmod p,$$
  (con $p \le 19, p \nmid c_\theta$), se preservan íntegramente las tesis (a)--(d) del Teorema de Puntos Fijos reemplazando $(\theta - \theta')$ por $P_\theta(\theta)$ y definiendo $\alpha = v / \gcd(v, P_\theta(k) - P_\theta(\theta))$.

### Validaciones y barrido DRG:
1. **Validación en grafos concretos (`general.py`, `general.out`):**
   Comprobado en familias con 4 autovalores distintos:
   - Grafos de Johnson $J(n, 3)$ y Kneser $K(n, 3)$ para $n \in \{9, 10, 11, 12\}$ bajo permutaciones de orden $p \in \{5, 7, 11\}$, con $f = 0$ y $f = 1$ puntos fijos.
   - En todos los casos aplicables donde la hipótesis se cumple, las identidades de rango ($a = a'$), divisibilidad de normas, símbolo de Legendre y paridades se verifican exactamente.
2. **Barrido de arrays de distancia-regularidad (`scan_drg.py`, `scan_drg.jsonl`):**
   Evaluado sobre 1.514 intersection arrays factibles de la base BCN (Brouwer–Cohen–Neumaier). Identifica dos exclusiones candidatas:
   - Array $\{65, 44, 11; 1, 4, 55\}$ ($v = 924$): excluye automorfismo libre de puntos fijos de orden $p = 7$.
   - Array $\{11, 10, 4; 1, 1, 5\}$ ($v = 210$): excluye automorfismo de orden $p = 11$ con $f = 1$ punto fijo.

---

## 6. Estado de la Hoja de Ruta (Roadmap Completado)

Las cuatro tareas planteadas en el borrador preliminar del 13 de octubre han sido formalizadas y auditadas en su totalidad:

1. **Validación para $p = 13, 17, 19$:**
   - **Estado:** **COMPLETADO**.
   - **Evidencia:** 14 instancias de grafos triangulares y complementos ($T(13)$, $T(14)$, $T(17)$, $T(18)$, $T(19)$, $T(20)$, $T(27)$) auditadas sin excepciones en `validate_p13_19.out`.
2. **Redacción limpia del teorema general y demostración rigurosa:**
   - **Estado:** **COMPLETADO**.
   - **Evidencia:** Formalizado en `discriminant_obstruction.tex` y compilado en `discriminant_obstruction.pdf`, cubriendo el Teorema 1 (libre de puntos fijos), Teorema 2 (extensión a puntos fijos con forma métrica $D$), Lema 5 (cota $f \le v/(p+1)$ y regularidad inducida), y Teorema 4 (generalización a grafos regulares vía polinomio de Hoffman).
3. **Chequeo exhaustivo de literatura por caso excluido:**
   - **Estado:** **COMPLETADO**.
   - **Evidencia:** Documentado en la Sección 6 de `discriminant_obstruction.tex`:
     - $\operatorname{srg}(88, 27, 6, 9)$, $p=11$: Cierra el problema abierto en Behbahani–Lam (2011), descartando los 5 orbit matrices pendientes para $f=0$.
     - $\operatorname{srg}(364, 33, 2, 3)$, $p=5$: Cierra la clasificación de Kazarina–Makhnev (2005) al descartar la única configuración admisible $\Gamma_F = K_4$.
     - $\operatorname{srg}(342, 33, 4, 3)$, $\operatorname{srg}(561, 60, 9, 6)$, $\operatorname{srg}(650, 55, 0, 5)$: Novedades inéditas en la literatura.
4. **Extensión a automorfismos con puntos fijos:**
   - **Estado:** **COMPLETADO**.
   - **Evidencia:** Implementado en `fixed_points.py` y `scan_fixed3.py`, validado en Paley graphs ($P(25), P(49), P(81)$) y familias de ciclos en $T(n)$, con la clasificación completa de los 6 casos de interés.

### Nota Taxonómica Epistemológica (Mandatory Project Rules)
- Los compiladores, scripts de búsqueda y validadores deterministas (`obstruction.py`, `fixed_points.py`, `general.py`, etc.) están en estado **`COMPILED`** / testeados.
- Las demostraciones matemáticas teóricas y las exclusiones de automorfismos de órdenes primos se categorizan estrictamente como **`EXPLORED`**, dado que, aunque cuentan con certificados aritméticos y scripts independientes verificados, aún no han sido formalizadas en el kernel de Lean 4 libre de axiomas no estándar ni sometidas a arbitraje externo por pares matemáticos.
