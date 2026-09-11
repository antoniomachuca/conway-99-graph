"""
DRAT Proof Verifier & LRAT Certificate Generator
Autonomous Verifier using Marijn Heule's drat-trim
"""

import os
import sys
import time
import subprocess
from typing import Dict, Optional, Tuple

WORKSPACE_DIR = os.path.dirname(os.path.abspath(__file__))
DRAT_TRIM_BIN = os.path.join(WORKSPACE_DIR, "drat-trim", "drat-trim")

PROFILES = [
    {
        "name": "Z_7 (tight)",
        "cnf": os.path.join(WORKSPACE_DIR, "conway_z7_tight.cnf"),
        "drat": os.path.join(WORKSPACE_DIR, "proof_z7_tight.drat"),
        "log": os.path.join(WORKSPACE_DIR, "cadical_tight.log"),
        "lrat": os.path.join(WORKSPACE_DIR, "proof_z7_tight.lrat"),
    },
    {
        "name": "Z_3 (3 fixed points)",
        "cnf": os.path.join(WORKSPACE_DIR, "conway_z3_fixed3.cnf"),
        "drat": os.path.join(WORKSPACE_DIR, "proof_z3_fixed3.drat"),
        "log": os.path.join(WORKSPACE_DIR, "cadical_z3.log"),
        "lrat": os.path.join(WORKSPACE_DIR, "proof_z3_fixed3.lrat"),
    },
    {
        "name": "Z_3 (fixed-point-free)",
        "cnf": os.path.join(WORKSPACE_DIR, "conway_z3_fpf.cnf"),
        "drat": os.path.join(WORKSPACE_DIR, "proof_z3_fpf.drat"),
        "log": os.path.join(WORKSPACE_DIR, "cadical_z3_fpf.log"),
        "lrat": os.path.join(WORKSPACE_DIR, "proof_z3_fpf.lrat"),
    },
    {
        "name": "Z_2 (f = 1 involution)",
        "cnf": os.path.join(WORKSPACE_DIR, "conway_z2_f1.cnf"),
        "drat": os.path.join(WORKSPACE_DIR, "proof_z2_f1.drat"),
        "log": os.path.join(WORKSPACE_DIR, "cadical_z2_f1.log"),
        "lrat": os.path.join(WORKSPACE_DIR, "proof_z2_f1.lrat"),
    },
]

def check_solver_status(log_path: str) -> Tuple[str, Optional[int]]:
    if not os.path.exists(log_path):
        return "NOT_STARTED", None
    
    status = "SOLVING_IN_PROGRESS"
    conflicts = None
    with open(log_path, "r", errors="ignore") as f:
        for line in f:
            if "s UNSATISFIABLE" in line:
                status = "UNSAT"
            elif "s SATISFIABLE" in line:
                status = "SAT"
            if line.startswith("c ") and not line.startswith("c ---") and "seconds" not in line:
                parts = line.split()
                if len(parts) >= 8:
                    try:
                        conflicts = int(parts[7])
                    except ValueError:
                        pass
    return status, conflicts

def verify_drat_proof(cnf_path: str, drat_path: str, lrat_path: Optional[str] = None) -> bool:
    if not os.path.exists(DRAT_TRIM_BIN):
        print(f"[Error] drat-trim binary not found at {DRAT_TRIM_BIN}", flush=True)
        return False
        
    cmd = [DRAT_TRIM_BIN, cnf_path, drat_path]
    if lrat_path:
        cmd.extend(["-L", lrat_path])
        
    print(f"[DRAT-Trim] Verifying: {' '.join(cmd)}", flush=True)
    t0 = time.time()
    res = subprocess.run(cmd, capture_output=True, text=True)
    elapsed = time.time() - t0
    
    print(res.stdout, flush=True)
    if res.stderr:
        print(res.stderr, flush=True)
        
    if "s VERIFIED" in res.stdout:
        print(f"[DRAT-Trim] Proof VERIFIED in {elapsed:.2f}s! LRAT certificate written to {lrat_path}", flush=True)
        return True
    else:
        print(f"[DRAT-Trim] Verification did not confirm UNSAT (status code {res.returncode}).", flush=True)
        return False

def audit_all():
    print("=" * 70)
    print("CONWAY'S 99-GRAPH DRAT PROOF AUDITOR")
    print("=" * 70)
    for p in PROFILES:
        name = p["name"]
        drat_size = os.path.getsize(p["drat"]) / (1024 * 1024) if os.path.exists(p["drat"]) else 0
        status, conflicts = check_solver_status(p["log"])
        conf_str = f"{conflicts:,}" if conflicts is not None else "N/A"
        print(f"Profile: {name}")
        print(f"  Solver Status: {status}")
        print(f"  Conflicts:     {conf_str}")
        print(f"  DRAT Trace:    {drat_size:.1f} MB ({p['drat']})")
        
        if status == "UNSAT":
            print(f"  [ACTION] Solver completed with UNSAT! Running drat-trim...")
            verify_drat_proof(p["cnf"], p["drat"], p["lrat"])
        elif status == "SAT":
            print(f"  [CRITICAL] Solver found a SATISFYING ASSIGNMENT! Conway's 99-graph witness exists!")
        else:
            print(f"  Solving actively running in background.")
        print("-" * 70)

if __name__ == "__main__":
    audit_all()
