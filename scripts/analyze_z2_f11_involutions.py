#!/usr/bin/env python3
"""
analyze_z2_f11_involutions.py
Analizador formal y refutador exhaustivo para involuciones (Z_2) con f = 11 puntos fijos
en el 99-Grafo de Conway srg(99, 14, 1, 2).

Teoremas aplicados:
1. Traza Espectral: Tr(P_t) = 11 => a + c = 54 => eps_1 = 7a - 202 ≡ 1 (mod 7).
   Candidatos admisibles en [0, 44]: {1, 8, 15, 22, 29, 36, 43}.
2. Rigidez de Grados: Todo vertice en un subgrafo localmente lineal (lambda = 1)
   tiene grado par: deg_H(z) in {0, 2, 4, 6, 8, 10}.
3. Identidad Universal de Conteo:
   eps_1 = f*(8 - f) + sum_{z in Fix(t)} binom(deg_H(z), 2) = -33 + sum binom.
   Dado eps_1 >= 0, exige estrictamente sum binom(deg_H(z), 2) >= 33.
4. Rigidez de Co-vecinos: para todo par no adyacente x, y in Fix(t), c_Fix(x, y) in {0, 2}.
5. Refutacion Exhaustiva via CaDiCaL:
   De las 19 particiones aritmeticas posibles con eps_1 ≡ 1 (mod 7) y sum binom >= 33,
   exactamente 0 admiten realizacion como grafo con lambda = 1 y c_Fix in {0, 2}.
"""

import sys
import itertools
from pysat.formula import CNF
from pysat.solvers import Cadical195
from pysat.card import CardEnc, EncType

def main():
    print("=" * 80)
    print("DEMOSTRACION Y REFUTACION EXHAUSTIVA PARA f = 11 PUNTOS FIJOS")
    print("=" * 80)

    f = 11
    spectral_mod = (5 * (f - 1)) % 7
    m2 = (99 - f) // 2
    allowed_eps = [e for e in range(0, m2 + 1) if e % 7 == spectral_mod]
    print(f"1. Traza espectral exige: eps_1 ≡ {spectral_mod} (mod 7)")
    print(f"   Candidatos admisibles en [0, {m2}]: {allowed_eps}")
    print(f"2. Formula universal: eps_1 = -33 + sum_{{z in Fix(t)}} binom(deg_H(z), 2)")
    print(f"   Para eps_1 >= 0, se exige sum binom >= 33.")

    # Generacion de particiones de grados posibles
    deg_options = [0, 2, 4, 6, 8, 10]
    b_map = {0: 0, 2: 1, 4: 6, 6: 15, 8: 28, 10: 45}
    max_edges = f * (f - 1) // 2 # 55
    max_T = max_edges // 3 # 18

    valid_seqs = []
    for seq in itertools.combinations_with_replacement(deg_options, f):
        tot_deg = sum(seq)
        if tot_deg % 6 == 0:
            T = tot_deg // 6
            if T <= max_T:
                sum_b = sum(b_map[d] for d in seq)
                if sum_b >= 33:
                    eps_1 = -33 + sum_b
                    if 0 <= eps_1 <= m2 and eps_1 % 7 == spectral_mod:
                        valid_seqs.append((eps_1, T, tuple(sorted(seq, reverse=True))))

    valid_seqs.sort()
    print(f"\n3. Particiones de grados aritmeticamente posibles: {len(valid_seqs)}")
    for eps, T, degs in valid_seqs:
        print(f"   eps_1 = {eps:2d} (T = {T:2d}): {degs}")

    # Construccion de la base CNF para grafos localmente lineales con c_Fix in {0, 2}
    print(f"\n4. Construyendo modelo SAT (lambda_H = 1, c_Fix in {{0, 2}})...")
    edge_vars = {}
    idx = 1
    for i in range(f):
        for j in range(i + 1, f):
            edge_vars[(i, j)] = idx
            edge_vars[(j, i)] = idx
            idx += 1

    base_cnf = CNF()
    next_var = idx

    c_ijk = {}
    for i in range(f):
        for j in range(i + 1, f):
            for k in range(f):
                if k != i and k != j:
                    v = next_var
                    next_var += 1
                    c_ijk[(i, j, k)] = v
                    e_ik = edge_vars[(min(i, k), max(i, k))]
                    e_jk = edge_vars[(min(j, k), max(j, k))]
                    base_cnf.append([-v, e_ik])
                    base_cnf.append([-v, e_jk])
                    base_cnf.append([v, -e_ik, -e_jk])

    for i in range(f):
        for j in range(i + 1, f):
            e_ij = edge_vars[(i, j)]
            lits = [c_ijk[(i, j, k)] for k in range(f) if k != i and k != j]
            base_cnf.append([-e_ij] + lits)
            for a in range(len(lits)):
                for b in range(a + 1, len(lits)):
                    base_cnf.append([-e_ij, -lits[a], -lits[b]])
                    
            for a in range(len(lits)):
                for b in range(a + 1, len(lits)):
                    for c in range(b + 1, len(lits)):
                        base_cnf.append([e_ij, -lits[a], -lits[b], -lits[c]])
            for a in range(len(lits)):
                other_lits = [lits[b] for b in range(len(lits)) if b != a]
                base_cnf.append([e_ij, -lits[a]] + other_lits)

    print(f"   Base CNF construida: {next_var - 1} variables, {len(base_cnf.clauses)} clausulas.")

    print(f"\n5. Verificando realizabilidad topologica con CaDiCaL...")
    all_unsat = True
    for idx_seq, (eps, T, target_deg) in enumerate(valid_seqs):
        if max(target_deg) > 2 * T:
            print(f"   [{idx_seq+1:2d}/{len(valid_seqs)}] eps_1={eps:2d}, T={T:2d}, degs={target_deg} => UNSAT (max_deg > 2T)")
            continue

        cnf = CNF()
        cnf.extend(base_cnf)
        top = next_var
        for i in range(f):
            v_edges = [edge_vars[(min(i, j), max(i, j))] for j in range(f) if j != i]
            card = CardEnc.equals(lits=v_edges, bound=target_deg[i], top_id=top, encoding=EncType.totalizer)
            cnf.extend(card)
            if len(card.clauses) > 0:
                top = max(abs(l) for cl in card.clauses for l in cl) + 1
                
        solver = Cadical195(bootstrap_with=cnf)
        res = solver.solve()
        if res:
            all_unsat = False
            print(f"   [{idx_seq+1:2d}/{len(valid_seqs)}] eps_1={eps:2d}, T={T:2d}, degs={target_deg} => SAT (MODELO ENCONTRADO)")
        else:
            print(f"   [{idx_seq+1:2d}/{len(valid_seqs)}] eps_1={eps:2d}, T={T:2d}, degs={target_deg} => UNSAT (100% verificado)")

    print("\n" + "=" * 80)
    if all_unsat:
        print("CONCLUSION MATEMATICA DEFINITIVA:")
        print("NO EXISTE NINGUN SUBGRAFO LOCALMENTE LINEAL EN 11 VERTICES CON c_Fix in {0, 2}")
        print("QUE SATISFAGA LA CONGRUENCIA ESPECTRAL eps_1 ≡ 1 (mod 7) Y eps_1 >= 0.")
        print("EL CASO f = 11 QUEDA 100% REFUTADO E INCONDICIONALMENTE CERRADO.")
    else:
        print("ALERTA: Se encontro al menos un modelo compatible.")
    print("=" * 80)

if __name__ == "__main__":
    main()
