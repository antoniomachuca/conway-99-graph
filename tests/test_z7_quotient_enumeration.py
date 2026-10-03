import hashlib
import itertools
import json
from pathlib import Path
import random
import signal
import subprocess
import sys
import tempfile
import unittest

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.enumerate_z7_quotient import (
    Budget, RowProblem, SearchStopped, check_z7_matrix, enumerate_rows,
    expand_z7, generate_rows, initial_stats, prepare_domains, z7_problem,
)


def satisfies(problem, matrix):
    n = problem.size
    return all(
        sum(matrix[i]) == problem.row_sums[i]
        and sum(matrix[i][j] * problem.weights[j] for j in range(n)) == problem.balances[i]
        and matrix[i][i] in problem.diagonals[i]
        and all(0 <= matrix[i][j] <= problem.bound
                and matrix[i][j] == matrix[j][i]
                and sum(matrix[i][k] * matrix[k][j] for k in range(n)) + matrix[i][j] == problem.targets[i][j]
                for j in range(n)) for i in range(n)
    )


def brute_force(problem):
    pairs = list(itertools.combinations_with_replacement(range(problem.size), 2))
    domains = [problem.diagonals[i] if i == j else range(problem.bound + 1) for i, j in pairs]
    found = set()
    for entries in itertools.product(*domains):
        matrix = [[0] * problem.size for _ in range(problem.size)]
        for (i, j), value in zip(pairs, entries):
            matrix[i][j] = matrix[j][i] = value
        if satisfies(problem, matrix):
            found.add(tuple(map(tuple, matrix)))
    return found


def cycle5_problem():
    return RowProblem(1, (2,) * 5,
                      tuple(tuple(2 if i == j else 1 for j in range(5)) for i in range(5)),
                      ((0,),) * 5, (0,) * 5, (0,) * 5)


def weighted_problem():
    matrix = ((2, 0, 1), (0, 0, 1), (1, 1, 2))
    targets = tuple(tuple(sum(matrix[i][k] * matrix[k][j] for k in range(3)) + matrix[i][j]
                          for j in range(3)) for i in range(3))
    return RowProblem(2, tuple(map(sum, matrix)), targets, ((0, 2),) * 3,
                      (1, -1, 0), tuple(row[0] - row[1] for row in matrix)), matrix


class TestRowEnumeration(unittest.TestCase):
    def test_all_row_domains_against_cartesian_products(self):
        problem, _ = weighted_problem()
        for problem in (problem, cycle5_problem()):
            for i in range(problem.size):
                expected = set()
                for row in itertools.product(range(problem.bound + 1), repeat=problem.size):
                    if (row[i] in problem.diagonals[i]
                            and sum(row) == problem.row_sums[i]
                            and sum(v * v for v in row) + row[i] == problem.targets[i][i]
                            and sum(a * b for a, b in zip(row, problem.weights)) == problem.balances[i]):
                        expected.add(row)
                rows = list(generate_rows(problem, i))
                self.assertEqual(len(rows), len(set(rows)))
                self.assertEqual(set(rows), expected)

    def test_labelled_cycle5_has_twelve_solutions(self):
        problem = cycle5_problem()
        stats = initial_stats(5)
        domains = prepare_domains(problem, stats)
        found = []
        enumerate_rows(problem, domains, found.append, stats)
        self.assertEqual(set(found), brute_force(problem))
        self.assertEqual(len(found), 12)
        self.assertEqual(stats["solutions_found"], 12)
        self.assertEqual(stats["nodes_by_depth"][5], 12)
        self.assertEqual(stats["root_rows_completed"], len(domains[0]))
        self.assertEqual(stats["nodes"], sum(stats["nodes_by_depth"]))

    def test_nonzero_diagonal_and_signed_balance(self):
        problem, planted = weighted_problem()
        stats = initial_stats(3)
        found = []
        enumerate_rows(problem, prepare_domains(problem, stats), found.append, stats)
        self.assertIn(planted, found)
        self.assertEqual(set(found), brute_force(problem))
        self.assertEqual(len(found), len(set(found)))

    def test_impossible_off_diagonal_targets(self):
        original = cycle5_problem()
        problem = RowProblem(1, original.row_sums,
                             tuple(tuple(2 if i == j else 0 for j in range(5)) for i in range(5)),
                             original.diagonals, original.weights, original.balances)
        stats = initial_stats(5)
        found = []
        enumerate_rows(problem, prepare_domains(problem, stats), found.append, stats)
        self.assertEqual(set(found), brute_force(problem))
        self.assertEqual(found, [])
        self.assertGreater(sum(stats["forward_prunes_by_depth"]), 0)

    def test_empty_row_domain_and_single_row(self):
        for total in (0, 1):
            problem = RowProblem(0, (total,), ((0,),), ((0,),), (0,), (0,))
            stats = initial_stats(1)
            found = []
            enumerate_rows(problem, prepare_domains(problem, stats), found.append, stats)
            self.assertEqual(set(found), brute_force(problem))
            self.assertEqual(len(found), 1 - total)

    def test_solution_limit_is_an_interruption(self):
        problem = cycle5_problem()
        stats = initial_stats(5)

        def stop(matrix):
            self.assertTrue(satisfies(problem, matrix))
            raise SearchStopped("solution_limit")

        with self.assertRaisesRegex(SearchStopped, "solution_limit"):
            enumerate_rows(problem, prepare_domains(problem, stats), stop, stats)
        self.assertEqual(stats["solutions_found"], 1)
        self.assertLess(stats["root_rows_completed"], stats["rows_generated"][0])

    def test_integer_overflow_and_invalid_domains_rejected(self):
        with self.assertRaisesRegex(ValueError, "overflow"):
            RowProblem(1000, (0,), ((0,),), ((0,),), (0,), (0,))
        with self.assertRaisesRegex(ValueError, "distinct"):
            RowProblem(1, (0,), ((0,),), ((0, 0),), (0,), (0,))


class TestZ7Algebra(unittest.TestCase):
    def test_exact_unrestricted_parameters(self):
        problem = z7_problem()
        self.assertEqual(problem.diagonals, ((0, 2),) * 12)
        self.assertEqual(problem.row_sums, (12,) * 12)
        self.assertEqual(tuple(problem.targets[i][i] for i in range(12)), (22,) * 6 + (24,) * 6)
        self.assertEqual((problem.targets[0][1], problem.targets[0][3], problem.targets[0][6],
                          problem.targets[6][7]), (10, 14, 12, 12))
        self.assertEqual(problem.weights, (1, 1, 1, -1, -1, -1, 0, 0, 0, 0, 0, 0))

    def test_reduced_equations_equal_full_matrix_residuals(self):
        rng = random.Random(7)
        problem = z7_problem()
        for _ in range(30):
            outer = [[0] * 12 for _ in range(12)]
            for i in range(12):
                outer[i][i] = rng.choice((0, 2))
                for j in range(i + 1, 12):
                    outer[i][j] = outer[j][i] = rng.randrange(5)
            matrix = expand_z7(outer)
            weights = [1] + [7] * 14
            for i in range(15):
                for j in range(15):
                    residual = sum(matrix[i][k] * matrix[k][j] for k in range(15)) + matrix[i][j]
                    residual -= 12 * int(i == j) + 2 * weights[j]
                    if i >= 3 and j >= 3:
                        a, b = i - 3, j - 3
                        expected = sum(outer[a][k] * outer[k][b] for k in range(12)) + outer[a][b]
                        expected -= problem.targets[a][b]
                    elif i in (1, 2) and j >= 3 or j in (1, 2) and i >= 3:
                        a = max(i, j) - 3
                        sign = 1 if min(i, j) == 1 else -1
                        expected = sum(outer[a]) + sign * sum(w * v for w, v in zip(problem.weights, outer[a])) - 12
                    else:
                        expected = 0
                    self.assertEqual(residual, expected)
                    self.assertEqual(weights[i] * matrix[i][j], weights[j] * matrix[j][i])
                if i >= 3:
                    self.assertEqual(sum(matrix[i]) - 14, sum(outer[i - 3]) - 12)
                else:
                    self.assertEqual(sum(matrix[i]), 14)

    def test_direct_validator_rejects_incomplete_quotient(self):
        with self.assertRaisesRegex(ValueError, "srg_equation|row_sum"):
            check_z7_matrix(expand_z7([[0] * 12 for _ in range(12)]))
        with self.assertRaisesRegex(ValueError, "natural"):
            check_z7_matrix([[False] * 15 for _ in range(15)])
        with self.assertRaisesRegex(ValueError, "15 by 15"):
            check_z7_matrix([[0]])


class TestEnumerationRuntime(unittest.TestCase):
    def test_timeout_and_signal(self):
        with tempfile.TemporaryDirectory() as directory:
            budget = Budget(Path(directory), initial_stats(1), 1, 30, 1024**2, 1)
            budget.deadline = budget.started - 1
            with self.assertRaisesRegex(SearchStopped, "timeout"):
                budget.tick(force=True)
            budget.interrupt(signal.SIGTERM, None)
            with self.assertRaisesRegex(SearchStopped, "SIGTERM"):
                budget.tick(force=True)

    def test_output_and_disk_reserves(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            budget = Budget(output, initial_stats(1), 10, 30, 1, 1)
            (output / "test.txt").write_text("test")
            with self.assertRaisesRegex(SearchStopped, "output_limit"):
                budget.check_resources()
            budget.max_bytes = 1024**2
            budget.reserve_bytes = 10**30
            with self.assertRaisesRegex(SearchStopped, "disk_reserve"):
                budget.check_resources()

    def test_short_cli_run_records_incomplete_result_and_source_hashes(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / "run"
            command = [sys.executable, "-B", str(ROOT / "scripts/enumerate_z7_quotient.py"),
                       "--output-dir", str(output), "--seconds", "0.005", "--reserve-gib", "0.001"]
            process = subprocess.run(command, cwd=ROOT, capture_output=True, text=True, timeout=30)
            self.assertEqual(process.returncode, 0, process.stderr)
            manifest = json.loads((output / "manifest.json").read_text())
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertFalse(manifest["complete"])
            self.assertEqual(manifest["stop_reason"], "timeout")
            self.assertFalse(manifest["symmetry_breaking"])
            for name, digest in manifest["source_sha256"].items():
                self.assertEqual(hashlib.sha256((output / name).read_bytes()).hexdigest(), digest)
            progress = json.loads((output / "progress.json").read_text())
            self.assertEqual(progress["phase"], "stopped")
            self.assertTrue(progress["diagnostic_only_not_a_restart_checkpoint"])
            before = (output / "manifest.json").read_bytes()
            repeated = subprocess.run(command, cwd=ROOT, capture_output=True, text=True, timeout=30)
            self.assertNotEqual(repeated.returncode, 0)
            self.assertEqual((output / "manifest.json").read_bytes(), before)


if __name__ == "__main__":
    unittest.main()
