#!/usr/bin/env python3
"""
analyze_z2_f13_involutions.py
Formal exhaustive analyzer and refuter for involutions (Z_2) with f = 13 fixed points
on Conway's 99-graph srg(99, 14, 1, 2).
"""

import sys
import itertools
from pysat.formula import CNF
from pysat.solvers import Cadical195
from pysat.card import CardEnc, EncType

def main():
    print("=" * 80)
    print("EXHAUSTIVE PROOF AND REFUTATION FOR f = 13 FIXED POINTS")
    print("=" * 80)

    f = 13
    spectral_mod = (5 * (f - 1)) % 7 # 4
    m2 = (99 - f) // 2 # 43
    allowed_eps = [e for e in range(0, m2 + 1) if e % 7 == spectral_mod]
    print(f"1. Spectral trace requires: eps_1 ≡ {spectral_mod} (mod 7)")
    print(f"   Admissible candidates in [0, {m2}]: {allowed_eps}")
    print(f"2. Universal formula: eps_1 = -65 + sum_{{z in Fix(t)}} binom(deg_H(z), 2)")
    print(f"   For eps_1 >= 0, the binomial sum must be >= 65.")

    deg_options = [0, 2, 4, 6, 8, 10, 12]
    b_map = {0: 0, 2: 1, 4: 6, 6: 15, 8: 28, 10: 45, 12: 66}
    max_edges = f * (f - 1) // 2
    max_T = max_edges // 3

    valid_seqs = []
    for seq in itertools.combinations_with_replacement(deg_options, f):
        tot_deg = sum(seq)
        if tot_deg % 6 == 0:
            T = tot_deg // 6
            if T <= max_T:
                sum_b = sum(b_map[d] for d in seq)
                if sum_b >= 65:
                    eps_1 = -65 + sum_b
                    if 0 <= eps_1 <= m2 and eps_1 % 7 == spectral_mod:
                        valid_seqs.append((eps_1, T, tuple(sorted(seq, reverse=True))))

    valid_seqs.sort()
    print(f"\n3. Arithmetically possible degree partitions: {len(valid_seqs)}")
    for eps, T, degs in valid_seqs:
        print(f"   eps_1 = {eps:2d} (T = {T:2d}): {degs}")

    # Base CNF
    print(f"\n4. Building the SAT model (lambda_H = 1, c_Fix in {{0, 2}})...")
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
                others = [lits[b] for b in range(len(lits)) if b != a]
                base_cnf.append([e_ij, -lits[a]] + others)

    print(f"   Base CNF built: {next_var - 1} variables, {len(base_cnf.clauses)} clauses.")

    print(f"\n5. Checking exact topological realizability with CaDiCaL...")
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
            print(f"   [{idx_seq+1:2d}/{len(valid_seqs)}] eps_1={eps:2d}, T={T:2d}, degs={target_deg} => SAT (MODEL FOUND)")
            break
        else:
            print(f"   [{idx_seq+1:2d}/{len(valid_seqs)}] eps_1={eps:2d}, T={T:2d}, degs={target_deg} => UNSAT (100% checked)")
        solver.delete()

    print("\n" + "=" * 80)
    if all_unsat:
        print("MATHEMATICAL CONCLUSION:")
        print("EVERY PARTITION FOR f = 13 IS UNSAT.")
        print("NO INVOLUTION WITH f = 13 FIXED POINTS SATISFIES THESE CONSTRAINTS IN CONWAY-99.")
    else:
        print("ALERT: at least one compatible model was found.")
    print("=" * 80)

if __name__ == "__main__":
    main()
