#!/usr/bin/env python3
"""
analyze_z2_f7_involutions.py
Analizador algebraico, topologico y combinatorio para involuciones (Z_2)
con f = 7 puntos fijos en el 99-Grafo de Conway srg(99, 14, 1, 2).
"""

import sys
from itertools import combinations
import z3

def spectral_analysis():
    print("=" * 70)
    print("1. ANALISIS ESPECTRAL Y MODULAR PARA f = 7")
    print("=" * 70)
    admissible = []
    for a in range(8, 53):
        c = 52 - a
        if 0 <= c <= 44:
            eps_1 = 7 * a - 194
            if 0 <= eps_1 <= 46:
                admissible.append((a, c, eps_1))
                
    print(f"Traza: Tr(P_t) = 7 => a + c = 52")
    print(f"Formula de aristas internas: eps_1 = 7a - 194 = 2 (mod 7)")
    print(f"Candidatos espectrales admisibles en [0, 46]:")
    for a, c, eps_1 in admissible:
        print(f"  a = {a:2d}, c = {c:2d} => eps_1 = {eps_1:2d} (= {eps_1 % 7} mod 7)")
    return [eps for _, _, eps in admissible]

def z3_model_f7(case_name, adj_fix, valid_spectral_eps):
    print(f"\n--- Modelado Z3 / ILP para {case_name} ---")
    c_fix = {}
    c_U = {}
    for x in range(7):
        for y in range(x + 1, 7):
            cn = sum(1 for z in range(7) if z != x and z != y and adj_fix[x][z] == 1 and adj_fix[y][z] == 1)
            c_fix[(x, y)] = cn
            if adj_fix[x][y] == 1:
                c_U[(x, y)] = 0
            else:
                c_U[(x, y)] = 2 - cn
    
    sum_binom_d = sum(c_U.values())
    deg_U = []
    for x in range(7):
        deg_Fix = sum(adj_fix[x])
        deg_U.append(14 - deg_Fix)
    sum_d = sum(deg_U)
    print(f"Grados de Fix hacia U: {deg_U}, suma = {sum_d}")
    print(f"Total de pares de vecinos en U: sum binom(d_j, 2) = {sum_binom_d}")
    
    solver = z3.Solver()
    N = {k: z3.Int(f"N_{k}") for k in range(8)}
    eps_1 = z3.Int("eps_1")
    
    for k in range(8):
        solver.add(N[k] >= 0)
        
    solver.add(sum(N[k] for k in range(8)) == 92)
    solver.add(sum(k * N[k] for k in range(8)) == sum_d)
    solver.add(sum((k * (k - 1) // 2) * N[k] for k in range(2, 8)) == sum_binom_d)
    
    solver.add(2 * eps_1 == N[1] + N[3] + N[5] + N[7])
    solver.add(92 - 2 * eps_1 == N[0] + N[2] + N[4] + N[6])
    
    for k in [0, 2, 4, 6]:
        solver.add(N[k] % 2 == 0)
    for k in [1, 3, 5, 7]:
        solver.add(N[k] % 2 == 0)
        
    # Also: can any vertex have d_j >= 3?
    # If d_j >= 3, u_j has >= 3 neighbors in Fix(t).
    # Since lambda = 1, no two neighbors can be adjacent.
    # So the neighbors of u_j in Fix(t) must form an independent set!
    # In Case 1 (K_3 + 4K_1), the max independent set in Fix(t) has size 1 + 4 = 5.
    # In Case 2 (2K_3 + K_1), the max independent set has size 1 + 1 + 1 = 3.
    # Moreover, if u_j has 3 independent neighbors x_1, x_2, x_3:
    # If u_j ~ t(u_j), then u_j and t(u_j) are common neighbors to all pairs {x_1, x_2}, {x_2, x_3}, {x_1, x_3}.
    # Since mu = 2, these are ALL common neighbors.
    
    solver_spec = z3.Solver()
    for c in solver.assertions():
        solver_spec.add(c)
    solver_spec.add(z3.Or([eps_1 == val for val in valid_spectral_eps]))
    
    res = solver_spec.check()
    print(f"Resultado Z3 con restriccion espectral eps_1 in {valid_spectral_eps}: {res}")
    if res == z3.sat:
        m = solver_spec.model()
        print(f"  MODELO ENCONTRADO:")
        print(f"  eps_1 = {m[eps_1]}")
        for k in range(8):
            print(f"  N_{k} = {m[N[k]]}")
    else:
        # Check what eps_1 values are possible without spectral restriction
        possible_eps = []
        while solver.check() == z3.sat:
            m = solver.model()
            v = m[eps_1].as_long()
            possible_eps.append((v, [m[N[k]].as_long() for k in range(8)]))
            solver.add(eps_1 != v)
        possible_eps.sort(key=lambda x: x[0])
        print(f"  Valores de eps_1 algebraicamente posibles (sin mod 7): {[x[0] for x in possible_eps]}")
        for val, n_dist in possible_eps:
            print(f"    eps_1 = {val:2d} => mod 7 = {val % 7} (requerido: 2) | N = {n_dist}")

def main():
    spectral_eps = spectral_analysis()
    
    # Case 0: 7K_1
    adj_0 = [[0]*7 for _ in range(7)]
    z3_model_f7("Caso 0: 7K_1 (7-coclique)", adj_0, spectral_eps)
    
    # Case 1: K_3 + 4K_1
    adj_1 = [[0]*7 for _ in range(7)]
    adj_1[0][1] = adj_1[1][0] = 1
    adj_1[1][2] = adj_1[2][1] = 1
    adj_1[2][0] = adj_1[0][2] = 1
    z3_model_f7("Caso 1: K_3 + 4K_1 (1 triangulo, 4 aislados)", adj_1, spectral_eps)
    
    # Case 2: 2K_3 + K_1
    adj_2 = [[0]*7 for _ in range(7)]
    adj_2[0][1] = adj_2[1][0] = 1
    adj_2[1][2] = adj_2[2][1] = 1
    adj_2[2][0] = adj_2[0][2] = 1
    adj_2[3][4] = adj_2[4][3] = 1
    adj_2[4][5] = adj_2[5][4] = 1
    adj_2[5][3] = adj_2[3][5] = 1
    z3_model_f7("Caso 2: 2K_3 + K_1 (2 triangulos disjuntos, 1 aislado)", adj_2, spectral_eps)

if __name__ == "__main__":
    main()
