import argparse
from dataclasses import asdict, dataclass
from datetime import datetime, timezone
from functools import lru_cache
import hashlib
import json
import math
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import time

import numpy as np


@dataclass(frozen=True)
class RowProblem:
    bound: int
    row_sums: tuple
    targets: tuple
    diagonals: tuple
    weights: tuple
    balances: tuple

    def __post_init__(self):
        n = len(self.row_sums)
        if not n or type(self.bound) is not int or self.bound < 0:
            raise ValueError("Invalid dimension or entry bound")
        if n * self.bound**2 + self.bound > np.iinfo(np.int16).max:
            raise ValueError("Integer dot products could overflow int16")
        if any(len(values) != n for values in (self.targets, self.diagonals, self.weights, self.balances)):
            raise ValueError("Inconsistent dimensions")
        if any(len(row) != n for row in self.targets):
            raise ValueError("Targets must be square")
        for i in range(n):
            if not self.diagonals[i] or len(set(self.diagonals[i])) != len(self.diagonals[i]):
                raise ValueError("Diagonal domains must be nonempty and distinct")
            if any(type(v) is not int or not 0 <= v <= self.bound for v in self.diagonals[i]):
                raise ValueError("Invalid diagonal domain")
            if type(self.row_sums[i]) is not int or self.row_sums[i] < 0:
                raise ValueError("Invalid row sum")
            if type(self.weights[i]) is not int or type(self.balances[i]) is not int:
                raise ValueError("Balances require integer coefficients")
            for j in range(n):
                value = self.targets[i][j]
                if type(value) is not int or not 0 <= value <= np.iinfo(np.int16).max:
                    raise ValueError("Invalid quadratic target")
                if value != self.targets[j][i]:
                    raise ValueError("Targets must be symmetric")

    @property
    def size(self):
        return len(self.row_sums)


def z7_problem():
    left = (2, 2, 2, 0, 0, 0, 1, 1, 1, 1, 1, 1)
    targets = tuple(tuple(12 * int(i == j) + 14 - a * b - (2 - a) * (2 - b)
                          for j, b in enumerate(left)) for i, a in enumerate(left))
    return RowProblem(4, (12,) * 12, targets, ((0, 2),) * 12,
                      (1, 1, 1, -1, -1, -1, 0, 0, 0, 0, 0, 0), (0,) * 12)


def generate_rows(problem, index, tick=None):
    n = problem.size
    domains = tuple(problem.diagonals[index] if j == index else tuple(range(problem.bound + 1))
                    for j in range(n))
    remaining_weights = tuple(sum(abs(w) for w in problem.weights[j:]) for j in range(n + 1))

    @lru_cache(maxsize=None)
    def possible(j, total, squares, balance):
        if tick is not None:
            tick()
        remaining = n - j
        if remaining == 0:
            return total == squares == balance == 0
        if not 0 <= total <= remaining * problem.bound or squares < 0:
            return False
        if total * total > remaining * squares:
            return False
        if squares > remaining * problem.bound**2 + problem.bound:
            return False
        if abs(balance) > remaining_weights[j] * problem.bound:
            return False
        return any(possible(j + 1, total - value,
                            squares - value * value - (value if j == index else 0),
                            balance - problem.weights[j] * value) for value in domains[j])

    prefix = []

    def visit(j, total, squares, balance):
        if tick is not None:
            tick()
        if not possible(j, total, squares, balance):
            return
        if j == n:
            yield tuple(prefix)
            return
        for value in domains[j]:
            prefix.append(value)
            yield from visit(j + 1, total - value,
                             squares - value * value - (value if j == index else 0),
                             balance - problem.weights[j] * value)
            prefix.pop()

    yield from visit(0, problem.row_sums[index], problem.targets[index][index], problem.balances[index])


def initial_stats(size):
    return {
        "rows_generated": [None] * size,
        "nodes": 0,
        "nodes_by_depth": [0] * (size + 1),
        "candidate_tests_by_depth": [0] * size,
        "forward_prunes_by_depth": [0] * size,
        "solutions_found": 0,
        "root_rows_completed": 0,
        "last_attempted_path": [],
    }


def prepare_domains(problem, stats, tick=None):
    domains = []
    for i in range(problem.size):
        rows = list(generate_rows(problem, i, tick))
        domains.append(np.asarray(rows, dtype=np.int16).reshape((-1, problem.size)))
        stats["rows_generated"][i] = len(rows)
        if tick is not None:
            tick()
    return domains


def enumerate_rows(problem, domains, on_solution, stats, tick=None):
    n = problem.size
    chosen = []
    path = []

    def visit(i, active):
        if tick is not None:
            tick()
        stats["nodes"] += 1
        stats["nodes_by_depth"][i] += 1
        if i == n:
            stats["solutions_found"] += 1
            on_solution(tuple(tuple(int(v) for v in row) for row in chosen))
            return
        for row_id in active[i]:
            if tick is not None:
                tick()
            stats["candidate_tests_by_depth"][i] += 1
            row = domains[i][row_id]
            stats["last_attempted_path"] = path + [int(row_id)]
            reduced = list(active)
            for j in range(i + 1, n):
                ids = active[j]
                ids = ids[domains[j][ids, i] == row[j]]
                if ids.size:
                    dots = domains[j][ids] @ row
                    ids = ids[dots + row[j] == problem.targets[i][j]]
                reduced[j] = ids
                if not ids.size:
                    break
            else:
                chosen.append(row)
                path.append(int(row_id))
                visit(i + 1, reduced)
                path.pop()
                chosen.pop()
                if i == 0:
                    stats["root_rows_completed"] += 1
                continue
            stats["forward_prunes_by_depth"][i] += 1
            if i == 0:
                stats["root_rows_completed"] += 1

    visit(0, [np.arange(len(rows), dtype=np.int32) for rows in domains])


def expand_z7(outer):
    if len(outer) != 12 or any(len(row) != 12 for row in outer):
        raise ValueError("Expected a 12 by 12 exterior block")
    matrix = [[0] * 15 for _ in range(15)]
    matrix[0][1] = matrix[0][2] = 7
    matrix[1][0] = matrix[2][0] = 1
    matrix[1][2] = matrix[2][1] = 1
    for i in range(3, 15):
        left = 2 if i < 6 else 0 if i < 9 else 1
        matrix[i][1] = matrix[1][i] = left
        matrix[i][2] = matrix[2][i] = 2 - left
        for j in range(3, 15):
            matrix[i][j] = int(outer[i - 3][j - 3])
    return matrix


def check_z7_matrix(matrix):
    if len(matrix) != 15 or any(len(row) != 15 for row in matrix):
        raise ValueError("Lean predicate: expected a 15 by 15 matrix")
    if any(type(v) is not int or v < 0 for row in matrix for v in row):
        raise ValueError("Lean predicate: entries must be natural numbers")
    sizes = [1] + [7] * 14
    for i in range(15):
        if sum(matrix[i]) != 14:
            raise ValueError("row_sum")
        if matrix[i][i] not in (0, 2):
            raise ValueError("diag_parity")
        if i < 3 and matrix[i][i] != 0:
            raise ValueError("diag_zero/diag_one/diag_two")
        if matrix[0][i] != (7 if i in (1, 2) else 0):
            raise ValueError("root_row")
        if matrix[i][0] != (1 if i in (1, 2) else 0):
            raise ValueError("root_column")
        if i >= 3:
            left = 2 if i < 6 else 0 if i < 9 else 1
            if matrix[i][1] != left or matrix[i][2] != 2 - left:
                raise ValueError("outer_left/outer_right")
        for j in range(15):
            if sizes[i] * matrix[i][j] != sizes[j] * matrix[j][i]:
                raise ValueError("degree_symmetry")
            if matrix[i][j] > sizes[j]:
                raise ValueError("entry_bound")
            if i >= 3 and j >= 3 and matrix[i][j] > 4:
                raise ValueError("outer_bound")
            lhs = sum(matrix[i][k] * matrix[k][j] for k in range(15)) + matrix[i][j]
            if lhs != 12 * int(i == j) + 2 * sizes[j]:
                raise ValueError("srg_equation")
    if matrix[1][2] != 1 or matrix[2][1] != 1:
        raise ValueError("matching_forward/matching_backward")
    return True


class SearchStopped(Exception):
    pass


def dump_json(path, value):
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n")
    temporary.replace(path)


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


class Budget:
    def __init__(self, output, stats, seconds, interval, max_bytes, reserve_bytes):
        self.output = output
        self.stats = stats
        self.started = time.monotonic()
        self.deadline = self.started + seconds
        self.interval = interval
        self.next_report = self.started
        self.max_bytes = max_bytes
        self.reserve_bytes = reserve_bytes
        self.calls = 0
        self.interrupted = None
        self.phase = "preparing_domains"

    def interrupt(self, number, frame):
        self.interrupted = signal.Signals(number).name

    def check_resources(self):
        if shutil.disk_usage(self.output).free < self.reserve_bytes:
            raise SearchStopped("disk_reserve")
        if sum(path.stat().st_size for path in self.output.iterdir() if path.is_file()) >= self.max_bytes:
            raise SearchStopped("output_limit")

    def tick(self, force=False):
        self.calls += 1
        if not force and self.calls % 256:
            return
        if self.interrupted:
            raise SearchStopped(self.interrupted)
        now = time.monotonic()
        if now >= self.deadline:
            raise SearchStopped("timeout")
        if now >= self.next_report:
            self.check_resources()
            self.report()
            self.next_report = now + self.interval

    def report(self):
        value = {"status": "EXPLORED", "phase": self.phase, "pid": os.getpid(),
                 "elapsed_seconds": time.monotonic() - self.started,
                 "utc": datetime.now(timezone.utc).isoformat(),
                 "diagnostic_only_not_a_restart_checkpoint": True, **self.stats}
        dump_json(self.output / "progress.json", value)
        with (self.output / "progress.jsonl").open("a") as stream:
            stream.write(json.dumps(value, sort_keys=True) + "\n")
        print(json.dumps({"phase": self.phase, "elapsed_seconds": round(value["elapsed_seconds"], 2),
                          "nodes": self.stats["nodes"], "solutions_found": self.stats["solutions_found"],
                          "root_rows_completed": self.stats["root_rows_completed"],
                          "rows_generated": self.stats["rows_generated"]}), flush=True)
        return value


def run(args):
    output = args.output_dir.resolve()
    if not output.parent.is_dir():
        raise ValueError("Output parent must already exist")
    if shutil.disk_usage(output.parent).free < args.reserve_gib * 1024**3:
        raise ValueError("Insufficient disk reserve before starting")
    output.mkdir(exist_ok=False)
    root = Path(__file__).resolve().parents[1]
    sources = (Path(__file__).resolve(), root / "Conway/Z7OrbitMatrix.lean",
               root / "tests/test_z7_quotient_enumeration.py")
    hashes = {}
    for source in sources:
        expected = sha256(source)
        destination = output / source.name
        shutil.copy2(source, destination)
        if sha256(destination) != expected:
            raise RuntimeError("Source snapshot changed while being copied")
        hashes[source.name] = expected
    problem = z7_problem()
    stats = initial_stats(problem.size)
    budget = Budget(output, stats, args.seconds, args.progress_seconds,
                    args.output_limit_mib * 1024**2, args.reserve_gib * 1024**3)
    manifest = {
        "status": "EXPLORED", "scope": "Exact necessary conditions of Lean Z7OrbitMatrix; no graph lift",
        "algorithm": "Independent row-domain backtracking with pairwise forward checking",
        "symmetry_breaking": False, "row_order": list(range(12)),
        "row_problem": asdict(problem), "source_sha256": hashes,
        "git_head": subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=root, text=True).strip(),
        "argv": sys.argv, "python": sys.version, "numpy": np.__version__, "pid": os.getpid(),
        "started_utc": datetime.now(timezone.utc).isoformat(),
        "limits": {"seconds": args.seconds, "progress_seconds": args.progress_seconds,
                   "solution_limit": args.solution_limit, "output_limit_mib": args.output_limit_mib,
                   "reserve_gib": args.reserve_gib},
        "metrics": {
            "nodes": "Entered consistent prefixes, including the empty prefix and solution leaves",
            "candidate_tests_by_depth": "Attempted row assignments, including forward-check rejections",
            "root_rows_completed": "Fully processed first-row candidates; not a fraction of all work",
        },
        "limitations": ["Software enumeration is not a kernel proof or a certified exclusion.",
                        "A matrix witness is not a Conway graph.",
                        "Interrupted counts are lower bounds, not search-space coverage estimates.",
                        "The progress files are diagnostics, not restart checkpoints.",
                        "A toy exhaustive comparison tests software, not universal completeness."],
        "complete": False, "stop_reason": None,
    }
    dump_json(output / "manifest.json", manifest)
    previous_handlers = {number: signal.signal(number, budget.interrupt)
                         for number in (signal.SIGINT, signal.SIGTERM)}
    exit_code = 0

    def on_solution(outer):
        matrix = expand_z7(outer)
        check_z7_matrix(matrix)
        filename = output / f"matrix_{stats['solutions_found']:06d}.json"
        dump_json(filename, {"status": "EXPLORED", "outer": outer, "matrix": matrix,
                             "independent_integer_check": True, "lean_kernel_checked": False,
                             "graph_witness": False})
        budget.check_resources()
        if args.solution_limit and stats["solutions_found"] >= args.solution_limit:
            raise SearchStopped("solution_limit")

    try:
        budget.tick(force=True)
        domains = prepare_domains(problem, stats, budget.tick)
        budget.phase = "searching"
        budget.tick(force=True)
        enumerate_rows(problem, domains, on_solution, stats, budget.tick)
        manifest["complete"] = True
        manifest["stop_reason"] = "exhausted"
    except SearchStopped as error:
        manifest["stop_reason"] = str(error)
    except Exception as error:
        manifest["stop_reason"] = "error"
        manifest["error"] = {"type": type(error).__name__, "message": str(error)}
        exit_code = 1
    finally:
        budget.phase = "finished" if manifest["complete"] else "stopped"
        manifest["final_progress"] = budget.report()
        manifest["finished_utc"] = datetime.now(timezone.utc).isoformat()
        manifest["artifact_sha256"] = {path.name: sha256(path) for path in output.iterdir()
                                       if path.name.startswith("matrix_") and path.suffix == ".json"}
        dump_json(output / "manifest.json", manifest)
        for number, handler in previous_handlers.items():
            signal.signal(number, handler)
    print(json.dumps({"status": "EXPLORED", "complete": manifest["complete"],
                      "stop_reason": manifest["stop_reason"], "solutions_found": stats["solutions_found"]}), flush=True)
    return exit_code


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument("--seconds", type=float, default=43200)
    parser.add_argument("--progress-seconds", type=float, default=30)
    parser.add_argument("--solution-limit", type=int, default=1)
    parser.add_argument("--output-limit-mib", type=float, default=256)
    parser.add_argument("--reserve-gib", type=float, default=10)
    args = parser.parse_args()
    for name in ("seconds", "progress_seconds", "output_limit_mib", "reserve_gib"):
        value = getattr(args, name)
        if not math.isfinite(value) or value <= 0:
            parser.error(f"{name} must be finite and positive")
    if args.solution_limit < 0:
        parser.error("solution-limit must be nonnegative (0 means unlimited)")
    return run(args)


if __name__ == "__main__":
    raise SystemExit(main())
