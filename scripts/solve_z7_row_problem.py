#!/usr/bin/env python3
"""Solve the exact Z7 exterior row-problem CNF and optionally check DRAT.

A verified run certifies that CNF only. It does not discharge the Lean
nonexistence placeholder.
"""

import argparse
from dataclasses import asdict
import json
from pathlib import Path
import shutil
import sys

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.enumerate_z7_quotient import generate_rows, z7_problem
from scripts.solve_z7_orbit_matrix import (
    artifact_hashes, ensure_reserve, exact_verdict, git_metadata, log_verdict,
    package_version, run_process, sha256_file, write_manifest,
)
from scripts.z7_row_problem_cnf import RowProblemCNF, RowSelectionCNF


def parse_args(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-dir", required=True, type=Path)
    parser.add_argument("--cadical", required=True, type=Path)
    parser.add_argument("--drat-trim", required=True, type=Path)
    parser.add_argument("--timeout", type=int, default=1800)
    parser.add_argument("--checker-timeout", type=int, default=1800)
    parser.add_argument("--proof-limit-mib", type=int, default=2048)
    parser.add_argument("--reserve-gib", type=int, default=10)
    parser.add_argument("--encoding", choices=("direct", "selection"), default="selection")
    parser.add_argument("--generate-only", action="store_true")
    args = parser.parse_args(argv)
    for name in ("timeout", "checker_timeout", "proof_limit_mib", "reserve_gib"):
        if getattr(args, name) <= 0:
            parser.error(f"{name} must be positive")
    return args


def main(argv=None):
    args = parse_args(argv)
    output = args.output_dir.expanduser().resolve()
    if output.exists():
        raise FileExistsError(f"Output directory already exists: {output}")
    if not output.parent.is_dir():
        raise FileNotFoundError(f"Output parent does not exist: {output.parent}")
    cadical = args.cadical.expanduser().resolve()
    drat_trim = args.drat_trim.expanduser().resolve()
    if not cadical.is_file() or not drat_trim.is_file():
        raise FileNotFoundError("Solver and checker binaries must exist")
    ensure_reserve(output.parent, args.reserve_gib)
    output.mkdir()
    sources = (
        ROOT / "scripts/z7_row_problem_cnf.py",
        ROOT / "scripts/enumerate_z7_quotient.py",
        ROOT / "scripts/solve_z7_row_problem.py",
        ROOT / "Conway/Z7OrbitMatrix.lean",
    )
    for source in sources:
        shutil.copyfile(source, output / source.name)
    problem = z7_problem()
    domains = None
    if args.encoding == "selection":
        domains = [list(generate_rows(problem, i)) for i in range(problem.size)]
        encoded = RowSelectionCNF(problem, domains)
    else:
        encoded = RowProblemCNF(problem)
    cnf_path = output / "z7_row_problem.cnf"
    encoded.compile().to_file(str(cnf_path))
    (output / "row_problem.json").write_text(json.dumps(asdict(problem), indent=2, sort_keys=True) + "\n")
    manifest = {
        "status": "EXPLORED",
        "scope": "exact_z7_exterior_row_problem_cnf" if args.encoding == "direct"
                  else "z7_exterior_rows_selected_from_generated_domains",
        "encoding": args.encoding,
        "symmetry_breaking": False,
        "triangle_identification": "Predicate symmetry C_ij = C_ji; not an orbit relabeling cut",
        "solver_verdict": "NOT_RUN",
        "proof_complete": False,
        "graph_transfer": "PENDING",
        "lean_nonexistence": "PENDING",
        "row_problem": asdict(problem),
        "cnf_variables": encoded.top_id,
        "cnf_clauses": len(encoded.cnf.clauses),
        "argv": sys.argv if argv is None else [str(Path(__file__).resolve()), *argv],
        "python": sys.version,
        "pysat_version": package_version("python-sat"),
        "git": git_metadata(ROOT),
        "binaries": {
            "cadical": str(cadical),
            "drat_trim": str(drat_trim),
            "cadical_sha256": sha256_file(cadical),
            "drat_trim_sha256": sha256_file(drat_trim),
        },
        "configuration": {
            "timeout": args.timeout,
            "checker_timeout": args.checker_timeout,
            "proof_limit_mib": args.proof_limit_mib,
            "reserve_gib": args.reserve_gib,
            "generate_only": args.generate_only,
        },
        "rows_generated": None if domains is None else [len(rows) for rows in domains],
        "limitations": [
            "A verified DRAT certifies only this CNF.",
            "The generator is tested on small exhaustive instances, not inside the Lean kernel.",
            "This run does not discharge z7_orbit_matrix_nonexistence.",
        ] + ([
            "The selection encoding refutes combinations of generated rows; it does not contain a separate proof that those lists are exhaustive.",
        ] if args.encoding == "selection" else [
            "The direct encoding is the equation system itself, without generated row lists.",
        ]),
    }
    manifest_path = output / "manifest.json"
    names = ["z7_row_problem.cnf", "row_problem.json", *[path.name for path in sources]]
    manifest["artifacts"] = artifact_hashes(output, names)
    write_manifest(manifest_path, manifest)
    if args.generate_only:
        manifest["status"] = "COMPILED"
        write_manifest(manifest_path, manifest)
        print(json.dumps({"status": "COMPILED", "variables": encoded.top_id,
                          "clauses": len(encoded.cnf.clauses)}))
        return 0

    proof_path = output / "z7_row_problem.drat"
    solver_log = output / "solver.log"
    command = [str(cadical), "-t", str(args.timeout), str(cnf_path), str(proof_path)]
    manifest["solver_argv"] = command
    manifest["solver_verdict"] = "UNKNOWN"
    write_manifest(manifest_path, manifest)
    returncode, stop_reason = run_process(
        command, solver_log, args.timeout + 30, output, args.reserve_gib,
        args.proof_limit_mib * 1024 * 1024,
    )
    manifest["solver_returncode"] = returncode
    manifest["stop_reason"] = stop_reason
    manifest["solver_verdict"] = log_verdict(solver_log)
    manifest["artifacts"].update(artifact_hashes(output, ["solver.log", "z7_row_problem.drat"]))
    if (returncode == 20 and stop_reason is None and manifest["solver_verdict"] == "UNSATISFIABLE"
            and proof_path.is_file()):
        before = artifact_hashes(output, ["z7_row_problem.cnf", "z7_row_problem.drat"])
        manifest["integrity_before_checker"] = before
        checker_log = output / "checker.log"
        checker = [str(drat_trim), str(cnf_path), str(proof_path)]
        manifest["checker_argv"] = checker
        checker_rc, checker_stop = run_process(
            checker, checker_log, args.checker_timeout, output, args.reserve_gib,
        )
        after = artifact_hashes(output, ["z7_row_problem.cnf", "z7_row_problem.drat"])
        manifest["checker_returncode"] = checker_rc
        manifest["checker_stop_reason"] = checker_stop
        manifest["integrity_after_checker"] = after
        manifest["artifacts"].update(artifact_hashes(output, ["checker.log"]))
        if before != after:
            manifest["stop_reason"] = "input_hash_changed_during_checker"
        elif checker_stop is None and checker_rc == 0 and exact_verdict(checker_log, "s VERIFIED"):
            manifest["status"] = "PROVED"
            manifest["proof_complete"] = True
        else:
            manifest["stop_reason"] = "checker_failure_or_missing_verdict"
    elif stop_reason is None and manifest["solver_verdict"] in ("UNKNOWN", "CONFLICT"):
        manifest["stop_reason"] = "solver_unknown"
    write_manifest(manifest_path, manifest)
    print(json.dumps({
        "status": manifest["status"],
        "solver_verdict": manifest["solver_verdict"],
        "proof_complete": manifest["proof_complete"],
        "stop_reason": manifest["stop_reason"],
        "variables": encoded.top_id,
        "clauses": len(encoded.cnf.clauses),
    }))
    return 0 if manifest["status"] == "PROVED" else 2


if __name__ == "__main__":
    raise SystemExit(main())
