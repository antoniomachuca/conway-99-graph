#!/usr/bin/env python3
r"""
Experimental quotient CNF generation for Conway-99. The default z7-general model uses the 15-orbit necessary conditions in orbit_matrix_encoding.py. The frob21-restricted model preserves the historical additional block restrictions. A verified DRAT certifies only its exact CNF. Neither generator-to-mathematics nor graph-to-Lean transfer is formally verified. No runtime/proof-size comparison between these models is justified.
"""

import argparse
import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time
from typing import Any

import numpy as np
from pysat.card import CardEnc, EncType
from pysat.formula import CNF

if __package__:
    from .orbit_matrix_encoding import OrbitMatrixCNF, z7_specification
else:
    from orbit_matrix_encoding import OrbitMatrixCNF, z7_specification


def get_orbit_coordinates():
    """Return the historical Frob(21)-restricted Gamma_2 orbit coordinates."""
    orbits = {}
    for p in range(12):
        orb = []
        for t in range(7):
            if p in (0, 1, 2):
                d = p + 1
                c1 = f"{(0 + t) % 7 + 1}L"
                c2 = f"{(d + t) % 7 + 1}L"
            elif p in (3, 4, 5):
                d = (p - 3) + 1
                c1 = f"{(0 + t) % 7 + 1}R"
                c2 = f"{(d + t) % 7 + 1}R"
            else:
                d = (p - 6) + 1
                c1 = f"{(0 + t) % 7 + 1}L"
                c2 = f"{(d + t) % 7 + 1}R"
            orb.append((c1, c2))
        orbits[p] = orb
    return orbits


def compute_matrices():
    """Compute the historical Frob(21)-restricted C and T matrices."""
    orbits = get_orbit_coordinates()
    C = np.zeros((12, 12), dtype=int)
    for i in range(12):
        u_coords = set(orbits[i][0])
        for j in range(12):
            total = 0
            for t in range(7):
                if i == j and t == 0:
                    continue
                w_coords = set(orbits[j][t])
                total += len(u_coords.intersection(w_coords))
            C[i, j] = total

    T = np.zeros((12, 12), dtype=int)
    for i in range(12):
        for j in range(12):
            T[i, j] = (24 - C[i, j]) if i == j else (14 - C[i, j])

    return C, T


class Frob21RestrictedCNFBuilder:
    def __init__(self, max_val: int = 4):
        self.max_val = max_val
        self.cnf = CNF()
        self.top_id = 0
        self.true_lit = self.alloc_var()
        self.false_lit = self.alloc_var()
        self.cnf.append([self.true_lit])
        self.cnf.append([-self.false_lit])
        self.and_cache = {}

    def alloc_var(self) -> int:
        self.top_id += 1
        return self.top_id

    def make_unary_var(self):
        """Create an integer variable represented in unary."""
        var = {w: self.alloc_var() for w in range(1, self.max_val + 1)}
        for w in range(1, self.max_val):
            self.cnf.append([-var[w + 1], var[w]])
        return var

    def const_var(self, val: int):
        """Create a constant integer variable in unary."""
        return {
            w: self.true_lit if w <= val else self.false_lit
            for w in range(1, self.max_val + 1)
        }

    def get_and(self, a: int, b: int) -> int:
        """Encode a Tseitin conjunction with constant folding and caching."""
        if a == self.false_lit or b == self.false_lit:
            return self.false_lit
        if a == self.true_lit:
            return b
        if b == self.true_lit:
            return a
        if a == b:
            return a
        if a > b:
            a, b = b, a
        key = (a, b)
        if key not in self.and_cache:
            value = self.alloc_var()
            self.cnf.append([-value, a])
            self.cnf.append([-value, b])
            self.cnf.append([value, -a, -b])
            self.and_cache[key] = value
        return self.and_cache[key]

    def build_cnf(self, C, T) -> CNF:
        """Build the historical Frob(21)-restricted 12x12 exterior model."""
        # Circulant blocks for the restricted Frob(21) model.
        # LL_RR: x0, x1, x2 with x1 == x2 by the additional block restriction.
        LL_RR = [self.make_unary_var(), self.make_unary_var(), None]
        LL_RR[2] = LL_RR[1]

        LL_LR = [self.make_unary_var(), self.make_unary_var(), self.make_unary_var()]
        LL_RL = [self.make_unary_var(), self.make_unary_var(), self.make_unary_var()]
        RR_LR = [self.make_unary_var(), self.make_unary_var(), self.make_unary_var()]
        RR_RL = [self.make_unary_var(), self.make_unary_var(), self.make_unary_var()]

        M_vars = [[None] * 12 for _ in range(12)]

        def set_circ(bi, bj, circ_vars, transpose=False):
            for r in range(3):
                for c in range(3):
                    shift = (c - r) % 3 if not transpose else (r - c) % 3
                    M_vars[bi * 3 + r][bj * 3 + c] = circ_vars[shift]

        def set_fixed_block(bi, bj, block):
            for r in range(3):
                for c in range(3):
                    M_vars[bi * 3 + r][bj * 3 + c] = self.const_var(block[r][c])

        # Fixed diagonal blocks from the additional Frob(21) restrictions.
        LL_LL = [[0, 1, 1], [1, 0, 1], [1, 1, 0]]
        RR_RR = [[0, 1, 1], [1, 0, 1], [1, 1, 0]]
        ZERO_BLOCK = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]

        set_fixed_block(0, 0, LL_LL)
        set_fixed_block(1, 1, RR_RR)
        set_fixed_block(2, 2, ZERO_BLOCK)
        set_fixed_block(3, 3, ZERO_BLOCK)
        set_fixed_block(2, 3, ZERO_BLOCK)
        set_fixed_block(3, 2, ZERO_BLOCK)

        set_circ(0, 1, LL_RR, False)
        set_circ(1, 0, LL_RR, True)
        set_circ(0, 2, LL_LR, False)
        set_circ(2, 0, LL_LR, True)
        set_circ(0, 3, LL_RL, False)
        set_circ(3, 0, LL_RL, True)
        set_circ(1, 2, RR_LR, False)
        set_circ(2, 1, RR_LR, True)
        set_circ(1, 3, RR_RL, False)
        set_circ(3, 1, RR_RL, True)

        # Restricted row sums: sum_j M_ij = 12.
        for i in range(12):
            lits = []
            for j in range(12):
                for w in range(1, self.max_val + 1):
                    lit = M_vars[i][j][w]
                    if lit == self.true_lit:
                        lits.append(self.true_lit)
                    elif lit != self.false_lit:
                        lits.append(lit)
            enc = CardEnc.equals(lits=lits, bound=12, top_id=self.top_id, encoding=EncType.seqcounter)
            self.top_id = enc.nv
            self.cnf.extend(enc.clauses)

        # Restricted quadratic equations: sum_k M_ik M_kj + M_ij = T_ij.
        for i in range(12):
            for j in range(i, 12):
                target = int(T[i, j])
                lits = []
                for k in range(12):
                    for a in range(1, self.max_val + 1):
                        ua = M_vars[i][k][a]
                        if ua == self.false_lit:
                            continue
                        for b in range(1, self.max_val + 1):
                            ub = M_vars[j][k][b]
                            if ub == self.false_lit:
                                continue
                            product = self.get_and(ua, ub)
                            if product != self.false_lit:
                                lits.append(product)
                for w in range(1, self.max_val + 1):
                    lit = M_vars[i][j][w]
                    if lit != self.false_lit:
                        lits.append(lit)
                enc = CardEnc.equals(lits=lits, bound=target, top_id=self.top_id, encoding=EncType.seqcounter)
                self.top_id = enc.nv
                self.cnf.extend(enc.clauses)

        return self.cnf


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def json_value(value: Any):
    if isinstance(value, dict):
        return [
            {"index": list(key) if isinstance(key, tuple) else key, "value": json_value(item)}
            for key, item in value.items()
        ]
    if isinstance(value, (tuple, list)):
        return [json_value(item) for item in value]
    return value


def serializable_specification(spec):
    return {
        "sizes": list(spec["sizes"]),
        "degree": spec["degree"],
        "lam": spec["lam"],
        "mu": spec["mu"],
        "fixed": json_value(spec.get("fixed", {})),
        "domains": json_value(spec.get("domains", {})),
    }


def executable_path(value: str) -> Path:
    path = Path(value).expanduser()
    if not path.is_file() or not os.access(path, os.X_OK):
        raise ValueError(f"Executable path is not executable: {path}")
    return path.resolve()


def reserve_bytes(output_dir: Path, reserve_gib: int) -> int:
    return reserve_gib * 1024 ** 3


def ensure_reserve(output_dir: Path, reserve_gib: int):
    if shutil.disk_usage(output_dir).free < reserve_bytes(output_dir, reserve_gib):
        raise RuntimeError(f"Free-space reserve of {reserve_gib} GiB is unavailable")


def git_metadata(root: Path):
    def git(*args):
        result = subprocess.run(["git", *args], cwd=root, capture_output=True, text=True, check=False)
        return result.stdout.strip()

    return {"head": git("rev-parse", "HEAD"), "dirty": bool(git("status", "--porcelain")),
            "status_porcelain": git("status", "--porcelain")}


def package_version(name: str):
    try:
        return importlib.metadata.version(name)
    except importlib.metadata.PackageNotFoundError:
        return "unknown"


def write_manifest(path: Path, manifest):
    path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n")


def artifact_hashes(output_dir: Path, names):
    return {name: sha256_file(output_dir / name) for name in names if (output_dir / name).is_file()}


def status_lines(path: Path, include_other=False):
    statuses = set()
    if path.is_file():
        with path.open("r", errors="replace") as stream:
            for line in stream:
                verdict = line.rstrip("\r\n")
                if verdict == "s UNSATISFIABLE":
                    statuses.add("UNSATISFIABLE")
                elif verdict == "s SATISFIABLE":
                    statuses.add("SATISFIABLE")
                elif verdict == "s UNKNOWN":
                    statuses.add("UNKNOWN")
                elif include_other and verdict.startswith("s "):
                    statuses.add(verdict[2:])
    return statuses


def log_verdict(path: Path):
    statuses = status_lines(path)
    if len(statuses) > 1:
        return "CONFLICT"
    return next(iter(statuses), "UNKNOWN")


def exact_verdict(path: Path, expected: str) -> bool:
    return status_lines(path, include_other=True) == {expected.removeprefix("s ")}


def parse_model(path: Path):
    model = set()
    with path.open("r", errors="replace") as stream:
        for line in stream:
            if line.startswith("v ") or line.startswith("v\t"):
                for token in line.split()[1:]:
                    literal = int(token)
                    if literal == 0:
                        continue
                    if -literal in model:
                        raise ValueError("Conflicting model literals")
                    model.add(literal)
    return model


def set_file_limit(limit_bytes):
    import resource
    soft, hard = resource.getrlimit(resource.RLIMIT_FSIZE)
    target = min(limit_bytes, hard) if hard != resource.RLIM_INFINITY else limit_bytes
    resource.setrlimit(resource.RLIMIT_FSIZE, (target, hard))


def terminate_process(process):
    if process.poll() is not None:
        return
    process.terminate()
    try:
        process.wait(timeout=5)
    except subprocess.TimeoutExpired:
        process.kill()
        process.wait()


def run_process(command, log_path, timeout, output_dir, reserve_gib, file_limit=None):
    preexec = (lambda: set_file_limit(file_limit)) if file_limit is not None else None
    process = None
    terminated = False
    try:
        with log_path.open("w") as log:
            process = subprocess.Popen(command, stdout=log, stderr=subprocess.STDOUT,
                                       preexec_fn=preexec)
            deadline = time.monotonic() + timeout
            stop_reason = None
            try:
                while process.poll() is None:
                    if time.monotonic() >= deadline:
                        stop_reason = "deadline"
                        break
                    if shutil.disk_usage(output_dir).free < reserve_bytes(output_dir, reserve_gib):
                        stop_reason = "reserve"
                        break
                    time.sleep(1)
            finally:
                if process.poll() is None:
                    terminate_process(process)
                    terminated = True
            returncode = process.wait()
        return returncode, stop_reason
    except BaseException:
        if process is not None and process.poll() is None and not terminated:
            terminate_process(process)
        raise


def build_model(model):
    if model == "z7-general":
        builder = OrbitMatrixCNF(**z7_specification())
        return builder, builder.compile(), serializable_specification(z7_specification())
    C, T = compute_matrices()
    builder = Frob21RestrictedCNFBuilder()
    return builder, builder.build_cnf(C, T), {"max_val": builder.max_val, "restriction": "historical Frob(21) blocks"}


def parse_args(argv=None):
    parser = argparse.ArgumentParser(description="Generate and safely audit Z7 orbit quotient CNFs")
    parser.add_argument("--model", choices=("z7-general", "frob21-restricted"), default="z7-general")
    parser.add_argument("--output-dir", required=True, type=Path)
    parser.add_argument("--cadical", required=True)
    parser.add_argument("--drat-trim", required=True)
    parser.add_argument("--timeout", type=int, default=120)
    parser.add_argument("--checker-timeout", type=int, default=120)
    parser.add_argument("--proof-limit-mib", type=int, default=256)
    parser.add_argument("--reserve-gib", type=int, default=10)
    parser.add_argument("--generate-only", action="store_true")
    args = parser.parse_args(argv)
    for name in ("timeout", "checker_timeout", "proof_limit_mib", "reserve_gib"):
        if getattr(args, name) <= 0:
            parser.error(f"--{name.replace('_', '-')} must be positive")
    return args


def run_cli(argv=None):
    args = parse_args(argv)
    output_dir = args.output_dir.expanduser().resolve()
    if output_dir.exists():
        raise FileExistsError(f"Output directory already exists: {output_dir}")
    if not output_dir.parent.is_dir():
        raise FileNotFoundError(f"Output parent does not exist: {output_dir.parent}")
    cadical = executable_path(args.cadical)
    drat_trim = executable_path(args.drat_trim)
    ensure_reserve(output_dir.parent, args.reserve_gib)
    output_dir.mkdir()
    ensure_reserve(output_dir, args.reserve_gib)

    cnf_name = f"{args.model}.cnf"
    proof_name = f"{args.model}.drat"
    solver_log_name = "solver.log"
    checker_log_name = "checker.log"
    manifest_path = output_dir / "manifest.json"
    source_names = ("solve_z7_orbit_matrix.py", "orbit_matrix_encoding.py")
    for name in source_names:
        shutil.copyfile(Path(__file__).resolve().with_name(name), output_dir / name)

    manifest = {
        "model": args.model,
        "status": "EXPLORED",
        "solver_verdict": "NOT_RUN",
        "graph_transfer": "PENDING",
        "scope": "exact_cnf_only" if args.model == "frob21-restricted" else "z7_general_quotient",
        "stop_reason": None,
        "solver_returncode": None,
        "checker_returncode": None,
        "proof_complete": False,
        "model_validated": False,
        "argv": list(sys.argv if argv is None else [str(Path(__file__).resolve()), *argv]),
        "configuration": {"timeout": args.timeout, "checker_timeout": args.checker_timeout,
                          "proof_limit_mib": args.proof_limit_mib, "reserve_gib": args.reserve_gib,
                          "generate_only": args.generate_only},
        "python": sys.version,
        "pysat_version": package_version("python-sat"),
        "git": git_metadata(Path(__file__).resolve().parents[1]),
        "binaries": {"cadical": str(cadical), "drat_trim": str(drat_trim),
                     "cadical_sha256": sha256_file(cadical), "drat_trim_sha256": sha256_file(drat_trim)},
        "encoded_specification": None,
        "artifacts": {},
        "limitations": ["A certificate certifies only the exact generated CNF.",
                        "Generator-to-mathematics and graph-to-Lean transfer are not formally verified.",
                        "A satisfying quotient is not a Conway-99 graph certificate."],
    }
    write_manifest(manifest_path, manifest)

    try:
        builder, cnf, encoded_spec = build_model(args.model)
        manifest["encoded_specification"] = encoded_spec
        cnf_path = output_dir / cnf_name
        cnf.to_file(cnf_path)
        manifest["artifacts"].update(artifact_hashes(output_dir, [cnf_name, *source_names]))
        write_manifest(manifest_path, manifest)

        if args.generate_only:
            manifest["status"] = "COMPILED"
            manifest["solver_verdict"] = "NOT_RUN"
            manifest["artifacts"].update(artifact_hashes(output_dir, [cnf_name, *source_names]))
            write_manifest(manifest_path, manifest)
            return 0

        proof_path = output_dir / proof_name
        solver_log = output_dir / solver_log_name
        command = [str(cadical), "-t", str(args.timeout), str(cnf_path), str(proof_path)]
        manifest["solver_argv"] = command
        manifest["solver_verdict"] = "UNKNOWN"
        write_manifest(manifest_path, manifest)
        returncode, stop_reason = run_process(command, solver_log, args.timeout + 10,
                                               output_dir, args.reserve_gib,
                                               args.proof_limit_mib * 1024 * 1024)
        manifest["solver_returncode"] = returncode
        manifest["stop_reason"] = stop_reason
        manifest["solver_verdict"] = log_verdict(solver_log)
        if manifest["stop_reason"] is None and manifest["solver_verdict"] in ("UNKNOWN", "CONFLICT"):
            manifest["stop_reason"] = "solver_unknown"
        manifest["artifacts"].update(artifact_hashes(output_dir, [solver_log_name, proof_name]))

        if (returncode == 10 and manifest["stop_reason"] is None
                and manifest["solver_verdict"] == "SATISFIABLE"):
            try:
                model = parse_model(solver_log)
                if not all(any(lit in model for lit in clause) for clause in cnf.clauses):
                    raise ValueError("Model does not satisfy every CNF clause")
                if args.model == "z7-general":
                    decoded = builder.decode(model)
                    (output_dir / "decoded_matrix.json").write_text(json.dumps(decoded) + "\n")
                    manifest["artifacts"].update(artifact_hashes(output_dir, ["decoded_matrix.json"]))
                manifest["model_validated"] = True
            except ValueError as error:
                manifest["stop_reason"] = "invalid_model: " + str(error)
            manifest["status"] = "EXPLORED"
            write_manifest(manifest_path, manifest)
            return 0 if manifest["model_validated"] else 2

        if (returncode == 20 and manifest["stop_reason"] is None
                and manifest["solver_verdict"] == "UNSATISFIABLE" and proof_path.is_file()):
            before = artifact_hashes(output_dir, [cnf_name, proof_name])
            manifest["integrity_before_checker"] = before
            if before.get(cnf_name) != manifest["artifacts"].get(cnf_name):
                manifest["stop_reason"] = "input_hash_changed_after_solver"
            else:
                checker_log = output_dir / checker_log_name
                checker_command = [str(drat_trim), str(cnf_path), str(proof_path)]
                manifest["checker_argv"] = checker_command
                checker_rc, checker_stop = run_process(checker_command, checker_log, args.checker_timeout,
                                                       output_dir, args.reserve_gib)
                after = artifact_hashes(output_dir, [cnf_name, proof_name])
                manifest["checker_returncode"] = checker_rc
                manifest["checker_stop_reason"] = checker_stop
                manifest["integrity_after_checker"] = after
                manifest["artifacts"].update(artifact_hashes(output_dir, [checker_log_name]))
                if before != after:
                    manifest["stop_reason"] = "input_hash_changed_during_checker"
                elif (checker_stop is None and checker_rc == 0
                      and exact_verdict(checker_log, "s VERIFIED")):
                    manifest["status"] = "PROVED"
                    manifest["scope"] = "exact_cnf_only"
                    manifest["proof_complete"] = True
                else:
                    manifest["stop_reason"] = "checker_failure_or_missing_verdict"

        write_manifest(manifest_path, manifest)
        return 0 if manifest["status"] == "PROVED" else 2
    except (Exception, KeyboardInterrupt) as error:
        manifest["stop_reason"] = f"{type(error).__name__}: {error}"
        manifest["status"] = "EXPLORED"
        write_manifest(manifest_path, manifest)
        print(f"ERROR: {error}", file=sys.stderr)
        return 2


def main():
    try:
        return run_cli()
    except (FileExistsError, FileNotFoundError, RuntimeError, ValueError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
