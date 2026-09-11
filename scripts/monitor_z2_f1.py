#!/usr/bin/env python3
"""
scripts/monitor_z2_f1.py
Autonomous Monitor and Verification Daemon for Conway's 99-Graph under Z_2 (f=1).
- Tracks CaDiCaL process (PID, memory, CPU, conflicts/s, remaining variables, DRAT size).
- Detects terminal status (s UNSATISFIABLE / s SATISFIABLE).
- If UNSAT: immediately launches drat-trim to produce proof_z2_f1.lrat and verifies proof.
- If SAT: extracts model, reconstructs 99x99 adjacency matrix, verifies with checkConway.
- Writes state to monitor_z2_f1_state.json.
"""

import os
import sys
import time
import json
import subprocess
import numpy as np
from typing import Dict, Any, Optional

WORKSPACE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CNF_FILE = os.path.join(WORKSPACE_DIR, "conway_z2_f1.cnf")
DRAT_FILE = os.path.join(WORKSPACE_DIR, "proof_z2_f1.drat")
LOG_FILE = os.path.join(WORKSPACE_DIR, "cadical_z2_f1.log")
LRAT_FILE = os.path.join(WORKSPACE_DIR, "proof_z2_f1.lrat")
DRAT_TRIM_LOG = os.path.join(WORKSPACE_DIR, "drat_trim_z2_f1.log")
DRAT_TRIM_BIN = os.path.join(WORKSPACE_DIR, "drat-trim", "drat-trim")
STATE_FILE = os.path.join(WORKSPACE_DIR, "monitor_z2_f1_state.json")

def find_cadical_pid() -> Optional[int]:
    try:
        out = subprocess.run(["pgrep", "-f", "cadical conway_z2_f1.cnf"], capture_output=True, text=True).stdout
        pids = [int(p) for p in out.strip().split() if p]
        return pids[0] if pids else None
    except Exception:
        return None

def parse_cadical_log():
    solver_status = "RUNNING"
    conflicts = 0
    proc_time = 0.0
    rem_vars = 0
    redundant = 0
    irredundant = 0
    model_lits = []
    
    if not os.path.exists(LOG_FILE):
        return "NOT_STARTED", proc_time, conflicts, rem_vars, redundant, irredundant, model_lits
        
    with open(LOG_FILE, "r", errors="ignore") as f:
        for line in f:
            sline = line.strip()
            if "s UNSATISFIABLE" in sline:
                solver_status = "UNSAT"
            elif "s SATISFIABLE" in sline:
                solver_status = "SAT"
            elif sline.startswith("v "):
                parts = sline[2:].split()
                for p in parts:
                    try:
                        lit = int(p)
                        if lit != 0:
                            model_lits.append(lit)
                    except ValueError:
                        pass
            elif sline.startswith("c ") and len(sline.split()) >= 11 and not sline.startswith("c ---"):
                sp = sline.split()
                try:
                    proc_time = float(sp[2])
                    conflicts = int(sp[7])
                    redundant = int(sp[8]) if len(sp) > 8 else 0
                    irredundant = int(sp[11]) if len(sp) > 11 else 0
                    rem_vars = int(sp[12]) if len(sp) > 12 else 0
                except (ValueError, IndexError):
                    pass
                    
    return solver_status, proc_time, conflicts, rem_vars, redundant, irredundant, model_lits

def run_drat_trim():
    print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Launching drat-trim verification...", flush=True)
    cmd = [DRAT_TRIM_BIN, CNF_FILE, DRAT_FILE, "-L", LRAT_FILE]
    t0 = time.time()
    with open(DRAT_TRIM_LOG, "w") as out_f:
        res = subprocess.run(cmd, stdout=out_f, stderr=subprocess.STDOUT)
    elapsed = time.time() - t0
    verified = False
    if os.path.exists(DRAT_TRIM_LOG):
        with open(DRAT_TRIM_LOG, "r") as f:
            content = f.read()
            if "s VERIFIED" in content:
                verified = True
    print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] drat-trim finished in {elapsed:.2f}s (Verified: {verified})", flush=True)
    return verified, elapsed

def verify_satisfying_assignment(model_lits):
    print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Reconstructing adjacency matrix from SAT model...", flush=True)
    sys.path.insert(0, WORKSPACE_DIR)
    from build_z2_f1_cnf import ConwayZ2F1Compiler
    compiler = ConwayZ2F1Compiler()
    model_set = set(model_lits)
    A = compiler.reconstruct_adjacency(model_set)
    np.save(os.path.join(WORKSPACE_DIR, "candidate_z2_f1_adj.npy"), A)
    
    # Check SRG properties
    diag_zero = bool(np.all(np.diag(A) == 0))
    symmetric = bool(np.array_equal(A, A.T))
    degrees = A.sum(axis=1)
    k_14 = bool(np.all(degrees == 14))
    A2 = A @ A
    srg_eq = bool(np.all(A2 + A == 12 * np.eye(99, dtype=int) + 2 * np.ones((99, 99), dtype=int)))
    valid = diag_zero and symmetric and k_14 and srg_eq
    print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Candidate verification: Diag0={diag_zero}, Symm={symmetric}, Deg14={k_14}, SRG={srg_eq} => Valid={valid}", flush=True)
    return valid, A.tolist()

def main():
    print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Starting autonomous Z2 (f=1) monitor daemon...", flush=True)
    
    while True:
        pid = find_cadical_pid()
        solver_status, proc_time, conflicts, rem_vars, redundant, irredundant, model_lits = parse_cadical_log()
        
        drat_size_bytes = os.path.getsize(DRAT_FILE) if os.path.exists(DRAT_FILE) else 0
        drat_size_mb = drat_size_bytes / (1024 * 1024)
        
        rss_mb = 0.0
        cpu_pct = 0.0
        alive = False
        if pid is not None:
            alive = True
            try:
                ps_res = subprocess.run(["ps", "-p", str(pid), "-o", "%cpu,rss"], capture_output=True, text=True)
                ps_lines = ps_res.stdout.strip().splitlines()
                if len(ps_lines) > 1:
                    parts = ps_lines[1].split()
                    cpu_pct = float(parts[0].replace(",", "."))
                    rss_mb = float(parts[1]) / 1024.0
            except Exception:
                pass
                
        cps = conflicts / proc_time if proc_time > 0 else 0.0
        
        state: Dict[str, Any] = {
            "timestamp": time.time(),
            "time_str": time.strftime("%Y-%m-%d %H:%M:%S"),
            "pid": pid,
            "alive": alive,
            "solver_status": solver_status,
            "process_time_sec": proc_time,
            "conflicts": conflicts,
            "conflicts_per_sec": cps,
            "remaining_vars": rem_vars,
            "redundant_clauses": redundant,
            "irredundant_clauses": irredundant,
            "drat_size_mb": drat_size_mb,
            "rss_mb": rss_mb,
            "cpu_pct": cpu_pct
        }
        
        with open(STATE_FILE, "w") as f:
            json.dump(state, f, indent=2)
            
        print(f"[{state['time_str']}] Status: {solver_status} | PID: {pid} (Alive: {alive}) | "
              f"Time: {proc_time:.1f}s | Conflicts: {conflicts:,} ({cps:.1f}/s) | "
              f"Vars: {rem_vars:,} | DRAT: {drat_size_mb:.1f} MB | RSS: {rss_mb:.1f} MB | CPU: {cpu_pct}%", flush=True)
              
        if solver_status == "UNSAT":
            print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Instance exhausted: UNSAT! Verifying proof...", flush=True)
            verified, elapsed = run_drat_trim()
            state["verification"] = {
                "result": "VERIFIED" if verified else "FAILED",
                "drat_trim_time_sec": elapsed,
                "lrat_path": LRAT_FILE
            }
            with open(STATE_FILE, "w") as f:
                json.dump(state, f, indent=2)
            break
            
        elif solver_status == "SAT":
            print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Satisfying model found! Verifying witness...", flush=True)
            valid, _ = verify_satisfying_assignment(model_lits)
            state["verification"] = {
                "result": "VALID_GRAPH" if valid else "INVALID",
                "candidate_matrix": os.path.join(WORKSPACE_DIR, "candidate_z2_f1_adj.npy")
            }
            with open(STATE_FILE, "w") as f:
                json.dump(state, f, indent=2)
            break
            
        elif not alive:
            print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Solver process terminated. Checking final log...", flush=True)
            solver_status, proc_time, conflicts, rem_vars, redundant, irredundant, model_lits = parse_cadical_log()
            if solver_status == "UNSAT":
                verified, elapsed = run_drat_trim()
                state["verification"] = {"result": "VERIFIED" if verified else "FAILED", "drat_trim_time_sec": elapsed}
            elif solver_status == "SAT":
                valid, _ = verify_satisfying_assignment(model_lits)
                state["verification"] = {"result": "VALID_GRAPH" if valid else "INVALID"}
            else:
                state["solver_status"] = "TERMINATED_UNEXPECTEDLY"
            with open(STATE_FILE, "w") as f:
                json.dump(state, f, indent=2)
            break
            
        time.sleep(10)

if __name__ == "__main__":
    main()
