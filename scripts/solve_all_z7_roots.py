#!/usr/bin/env python3
"""Solve and certify all 33 canonical Z7 row-0 roots with CaDiCaL and drat-trim.

Produces solver logs, DRAT proofs, checker logs, and a master manifest.
"""

import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
CADICAL = ROOT / "cadical"
DRAT_TRIM = ROOT / "drat-trim/drat-trim"
SCRATCH = Path("/Users/antoniomachuca/.gemini/antigravity-cli/brain/fad001df-379a-4509-862b-6c21f1d09039/scratch/roots_cnf")


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while chunk := f.read(65536):
            h.update(chunk)
    return h.hexdigest()


def main():
    if not CADICAL.is_file() or not DRAT_TRIM.is_file():
        sys.exit("Error: cadical or drat-trim binary missing")

    manifest_path = SCRATCH / "roots_manifest.json"
    if not manifest_path.is_file():
        sys.exit(f"Error: manifest missing at {manifest_path}")

    with open(manifest_path) as f:
        data = json.load(f)

    results = []
    t_start_all = time.time()

    print(f"Starting certified solve of all {len(data['roots'])} roots...")

    for item in data["roots"]:
        idx = item["index"]
        cnf_path = SCRATCH / item["cnf"]
        drat_path = SCRATCH / f"root_{idx:02d}.drat"
        solver_log = SCRATCH / f"root_{idx:02d}_cadical.log"
        checker_log = SCRATCH / f"root_{idx:02d}_drat.log"

        print(f"[{idx:02d}/33] Solving {cnf_path.name} (row={item['row']})...", end="", flush=True)

        # 1. Run CaDiCaL
        t0 = time.time()
        with open(solver_log, "w") as out:
            res_cad = subprocess.run([str(CADICAL), str(cnf_path), str(drat_path)],
                                     stdout=out, stderr=subprocess.STDOUT)
        t_solve = time.time() - t0

        if res_cad.returncode != 20:
            print(f" FAILED (returncode {res_cad.returncode})")
            sys.exit(f"Solver failed on root {idx}")

        # Check solver log
        solver_txt = solver_log.read_text()
        if "s UNSATISFIABLE" not in solver_txt:
            sys.exit(f"Missing UNSAT in {solver_log}")

        # 2. Run drat-trim
        t1 = time.time()
        with open(checker_log, "w") as out:
            res_chk = subprocess.run([str(DRAT_TRIM), str(cnf_path), str(drat_path)],
                                     stdout=out, stderr=subprocess.STDOUT)
        t_check = time.time() - t1

        if res_chk.returncode != 0:
            print(f" CHECK FAILED (returncode {res_chk.returncode})")
            sys.exit(f"Checker failed on root {idx}")

        checker_txt = checker_log.read_text()
        if "s VERIFIED" not in checker_txt:
            sys.exit(f"Missing s VERIFIED in {checker_log}")

        drat_bytes = drat_path.stat().st_size
        print(f" UNSAT ({t_solve:.2f}s) | VERIFIED ({t_check:.2f}s) | drat: {drat_bytes/1024/1024:.1f}MB")

        results.append({
            "index": idx,
            "row": item["row"],
            "cnf": item["cnf"],
            "cnf_sha256": item["sha256"],
            "drat": drat_path.name,
            "drat_sha256": sha256_file(drat_path),
            "drat_bytes": drat_bytes,
            "solve_time_s": t_solve,
            "check_time_s": t_check,
            "solver_verdict": "s UNSATISFIABLE",
            "checker_verdict": "s VERIFIED",
            "status": "PROVED",
        })

    total_time = time.time() - t_start_all
    summary = {
        "campaign": "z7_row0_roots_refutation",
        "roots_count": len(results),
        "total_wall_time_s": total_time,
        "all_unsat": all(r["solver_verdict"] == "s UNSATISFIABLE" for r in results),
        "all_verified": all(r["checker_verdict"] == "s VERIFIED" for r in results),
        "results": results
    }

    summary_path = SCRATCH / "all_roots_certified_summary.json"
    with open(summary_path, "w") as f:
        json.dump(summary, f, indent=2)

    print(f"\n=======================================================")
    print(f"SUCCESS: All 33 roots UNSAT and VERIFIED in {total_time:.1f}s!")
    print(f"Summary written to {summary_path}")
    print(f"=======================================================")


if __name__ == "__main__":
    main()
