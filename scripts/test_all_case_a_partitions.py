#!/usr/bin/env python3
"""
scripts/test_all_case_a_partitions.py
Iterates through all non-isomorphic even partitions of epsilon_1 = 10 in Case A (K_3),
compiles CNFs, runs CaDiCaL to obtain DRAT proofs, and verifies with drat-trim.
"""

import os
import sys
import subprocess
import time

PARTITIONS = [
    (4, 4, 2),
    (6, 2, 2),
    (6, 4, 0),
]

def main():
    print("=" * 70)
    print("TESTING ALL NON-ISOMORPHIC CASE A PARTITIONS FOR Z_2 (f = 3)")
    print("=" * 70)
    
    os.makedirs("scratch", exist_ok=True)
    
    overall_start = time.time()
    results = {}
    
    for k0, k1, k2 in PARTITIONS:
        part_str = f"{k0}_{k1}_{k2}"
        cnf_path = f"scratch/case_a_{part_str}.cnf"
        drat_path = f"scratch/proof_case_a_{part_str}.drat"
        cadical_log = f"scratch/cadical_case_a_{part_str}.log"
        drat_log = f"scratch/drat_trim_case_a_{part_str}.log"
        
        print(f"\n[+] Testing partition ({k0}, {k1}, {k2})...")
        
        # 1. Compile CNF
        t0 = time.time()
        cmd_compile = [
            sys.executable, "build_z2_f3_cnf.py",
            "--case", "A",
            "--k-partition", str(k0), str(k1), str(k2),
            "--output", cnf_path
        ]
        res_comp = subprocess.run(cmd_compile, capture_output=True, text=True)
        if res_comp.returncode != 0:
            print(f"[-] Compilation failed: {res_comp.stderr}")
            results[part_str] = "COMPILATION_ERROR"
            continue
        t_comp = time.time() - t0
        print(f"    Compiled CNF in {t_comp:.2f}s ({os.path.getsize(cnf_path) / 1e6:.1f} MB)")
        
        # 2. Run CaDiCaL
        t0 = time.time()
        cmd_cadical = ["./cadical", cnf_path, drat_path]
        with open(cadical_log, "w") as log_f:
            res_cad = subprocess.run(cmd_cadical, stdout=log_f, stderr=subprocess.STDOUT)
        t_cad = time.time() - t0
        
        if res_cad.returncode != 20:
            print(f"[-] CaDiCaL returned {res_cad.returncode} (expected 20 = UNSAT)")
            results[part_str] = f"CADICAL_CODE_{res_cad.returncode}"
            continue
        print(f"    CaDiCaL UNSAT in {t_cad:.2f}s (DRAT trace: {os.path.getsize(drat_path) / 1024:.1f} KB)")
        
        # 3. Verify with drat-trim
        t0 = time.time()
        cmd_drat = ["./drat-trim/drat-trim", cnf_path, drat_path]
        with open(drat_log, "w") as log_f:
            res_drat = subprocess.run(cmd_drat, stdout=log_f, stderr=subprocess.STDOUT)
        t_drat = time.time() - t0
        
        with open(drat_log, "r") as f:
            drat_out = f.read()
            
        if "s VERIFIED" in drat_out:
            print(f"    drat-trim: s VERIFIED in {t_drat:.2f}s")
            results[part_str] = "VERIFIED_UNSAT"
        else:
            print(f"[-] drat-trim FAILED! Check {drat_log}")
            results[part_str] = "DRAT_TRIM_FAILED"
            
        # Clean up CNF to save disk space
        if os.path.exists(cnf_path):
            os.remove(cnf_path)

    print("\n" + "=" * 70)
    print(f"SUMMARY OF ALL CASE A PARTITIONS (Total time: {time.time() - overall_start:.2f}s)")
    print("=" * 70)
    for part, status in results.items():
        print(f"  Partition {part}: {status}")
    print("=" * 70)

if __name__ == "__main__":
    main()
