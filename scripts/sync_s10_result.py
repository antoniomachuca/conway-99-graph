#!/usr/bin/env python3
"""scripts/sync_s10_result.py

Automated synchronization and audit updater for the S10.cnf Z3 FPF resolution on omarchy.
Usage:
    python3 scripts/sync_s10_result.py [--watch] [--interval SECONDS]
"""

import sys
import time
import json
import subprocess
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
OMARCHY_HOST = "antoniomachuca@100.124.116.26"
REMOTE_DIR = "/home/antoniomachuca/conway_kit/z3_s10"
LOCAL_PROOF_DIR = REPO_ROOT / "proofs" / "z3_fpf_t27"


def run_ssh(cmd: str) -> subprocess.CompletedProcess:
    full_cmd = ["ssh", OMARCHY_HOST, cmd]
    return subprocess.run(full_cmd, capture_output=True, text=True)


def check_status():
    # 1. Check if CaDiCaL or ParaFROST already produced status.done
    res = run_ssh(f"test -f {REMOTE_DIR}/status.done && cat {REMOTE_DIR}/status.done || echo 'PENDING'")
    output = res.stdout.strip()
    if output != "PENDING":
        return output

    # 2. Check if ParaFROST on GPU finished with UNSATISFIABLE
    pf_check = run_ssh(f"grep -E 's UNSATISFIABLE|s SATISFIABLE' {REMOTE_DIR}/parafrost.log 2>/dev/null || echo 'NONE'")
    pf_res = pf_check.stdout.strip()
    if "s UNSATISFIABLE" in pf_res:
        print("[*] ParaFROST on GPU RTX 2080 finished with UNSATISFIABLE! Verifying DRAT...")
        verify_cmd = f"/home/antoniomachuca/conway_kit/tools/drat-trim/drat-trim {REMOTE_DIR}/S10.cnf {REMOTE_DIR}/parafrost.drat"
        v_res = run_ssh(f"{verify_cmd} > {REMOTE_DIR}/S10.check.log 2>&1; echo EXIT_CODE:$?")
        if "s VERIFIED" in run_ssh(f"cat {REMOTE_DIR}/S10.check.log").stdout:
            # Terminate CPU workers
            run_ssh("pkill -9 -f cadical || true")
            status_line = "SUCCESS: winner=parafrost_gpu (RTX 2080), drat_trim=VERIFIED\n"
            run_ssh(f"cp {REMOTE_DIR}/parafrost.log {REMOTE_DIR}/S10.solver.log; echo '{status_line}' > {REMOTE_DIR}/status.done")
            return status_line

    return "PENDING"


def get_worker_stats():
    script = """python3 -c "
import glob, os, subprocess
logs = sorted(glob.glob('/home/antoniomachuca/conway_kit/z3_s10/worker_*.log'))
res = []
for l in logs:
    with open(l, 'rb') as f:
        f.seek(max(0, os.path.getsize(l) - 2000))
        lines = f.read().decode('utf-8', errors='ignore').strip().split('\\n')
        time_s = '?'
        conflicts = '?'
        vars_rem = '?'
        for line in reversed(lines):
            if line.startswith('c - ') or line.startswith('c I ') or line.startswith('c d '):
                parts = line.split()
                if len(parts) >= 12:
                    time_s = parts[1]
                    conflicts = parts[6]
                    vars_rem = parts[-1]
                    break
        res.append((os.path.basename(l), time_s, conflicts, vars_rem))
for r in res[:3]:
    print(f'{r[0]}: time={r[1]}s conf={r[2]} rem={r[3]}')
print(f'... ({len(res)} CaDiCaL CPU workers total)')

# Check ParaFROST GPU
pf_log = '/home/antoniomachuca/conway_kit/z3_s10/parafrost.log'
if os.path.exists(pf_log):
    with open(pf_log, 'rb') as f:
        f.seek(max(0, os.path.getsize(pf_log) - 2000))
        lines = f.read().decode('utf-8', errors='ignore').strip().split('\\n')
        last = lines[-1] if lines else 'empty'
        print(f'ParaFROST (GPU RTX 2080): {last[:80]}')
" """
    res = run_ssh(script)
    return res.stdout.strip()



def sync_and_finalize():
    print("[*] S10.cnf solve & verification detected on omarchy! Downloading artifacts...")
    LOCAL_PROOF_DIR.mkdir(parents=True, exist_ok=True)

    # Download check.log, solver.log, hashes
    files_to_copy = ["S10.check.log", "S10.solver.log"]
    for f in files_to_copy:
        cmd = ["scp", f"{OMARCHY_HOST}:{REMOTE_DIR}/{f}", str(LOCAL_PROOF_DIR / f)]
        subprocess.run(cmd, check=True)
        print(f"[+] Downloaded {f}")

    # Read status.done details
    status_content = run_ssh(f"cat {REMOTE_DIR}/status.done").stdout.strip()
    print(f"[+] status.done: {status_content}")

    # Check that check.log contains s VERIFIED
    check_log = (LOCAL_PROOF_DIR / "S10.check.log").read_text(encoding="utf-8")
    if "s VERIFIED" not in check_log:
        print("[!] ERROR: S10.check.log does not contain 's VERIFIED'!")
        sys.exit(1)

    print("[SUCCESS] drat-trim independently confirmed 's VERIFIED' on S10.cnf!")
    print("[*] Updating proofs/z3_fpf_t27/audit_manifest.json...")
    manifest_path = LOCAL_PROOF_DIR / "audit_manifest.json"
    if manifest_path.exists():
        with open(manifest_path, "r") as mf:
            data = json.load(mf)
    else:
        data = {}

    data["S10"] = {
        "status": "UNSATISFIABLE",
        "drat_trim_result": "s VERIFIED",
        "drat_trim_exit_code": 0,
        "operational_state": "PROVED",
        "timestamp": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
    }
    with open(manifest_path, "w") as mf:
        json.dump(data, mf, indent=2)

    print("[*] Building Lean targets...")
    subprocess.run(["lake", "build", "Conway.Z3FpfCNFT27"], cwd=REPO_ROOT, check=True)
    subprocess.run(["lake", "build", "Conway.GrandClassification"], cwd=REPO_ROOT, check=True)
    print("[*] Running axiom tests...")
    subprocess.run(["pytest", "-v", "tests/test_grand_classification_axioms.py"], cwd=REPO_ROOT, check=True)
    print("\n[READY] All targets compiled and verified. S10 is completely PROVED.")


def main():
    status = check_status()
    if status != "PENDING":
        sync_and_finalize()
        return

    print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] S10 portfolio is still actively solving on omarchy.")
    print("Worker sample status:")
    print(get_worker_stats())

    if "--watch" in sys.argv:
        interval = 60
        if "--interval" in sys.argv:
            idx = sys.argv.index("--interval")
            interval = int(sys.argv[idx + 1])
        print(f"[*] Watching every {interval}s...")
        while True:
            time.sleep(interval)
            status = check_status()
            if status != "PENDING":
                sync_and_finalize()
                break
            print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] Still solving...")


if __name__ == "__main__":
    main()
