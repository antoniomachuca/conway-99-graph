import json
import os
from pathlib import Path
import shutil
import stat
import subprocess
import sys
import tempfile
import textwrap
import unittest
from unittest.mock import Mock
from unittest.mock import patch

from pysat.formula import CNF

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

import scripts.solve_z7_orbit_matrix as solver


class FakeBuilder:
    def __init__(self, clause=(1,)):
        self.cnf = CNF()
        self.cnf.append(list(clause))

    def compile(self):
        return self.cnf

    def decode(self, model):
        return [[0]]


def fake_build_model(model=None):
    builder = FakeBuilder()
    return builder, builder.cnf, {"sizes": [1], "degree": 0, "lam": 0, "mu": 0}


def fake_negative_model(model=None):
    builder = FakeBuilder((-1,))
    return builder, builder.cnf, {"sizes": [1], "degree": 0, "lam": 0, "mu": 0}


def executable(directory, name, body):
    path = Path(directory) / name
    path.write_text("#!/usr/bin/env python3\n" + textwrap.dedent(body))
    path.chmod(path.stat().st_mode | stat.S_IXUSR)
    return path


class TestZ7OrbitMatrixCLI(unittest.TestCase):
    def args(self, output_dir, cadical, drat_trim, *extra):
        return [
            "--model", "z7-general",
            "--output-dir", str(output_dir),
            "--cadical", str(cadical),
            "--drat-trim", str(drat_trim),
            "--timeout", "1",
            "--checker-timeout", "1",
            "--proof-limit-mib", "1",
            "--reserve-gib", "1",
            *extra,
        ]

    def make_tools(self, directory, solver_body, checker_body):
        return (
            executable(directory, "cadical-mock", solver_body),
            executable(directory, "drat-trim-mock", checker_body),
        )

    def manifest(self, output_dir):
        return json.loads((Path(output_dir) / "manifest.json").read_text())

    def test_generate_only_is_compiled_and_does_not_run_solver(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "raise SystemExit('solver must not run')",
                "raise SystemExit('checker must not run')",
            )
            output = root / "generated"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim, "--generate-only")), 0)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "COMPILED")
            self.assertEqual(manifest["solver_verdict"], "NOT_RUN")
            self.assertFalse((output / "solver.log").exists())

    def test_existing_output_directory_is_refused(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            output = root / "existing"
            output.mkdir()
            with self.assertRaises(FileExistsError):
                solver.run_cli(self.args(output, root / "missing-cadical", root / "missing-trim"))

    def test_exit20_without_unsat_line_is_not_proved(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "import sys; print('solver stopped without a verdict'); sys.exit(20)",
                "print('s VERIFIED')",
            )
            output = root / "no-verdict"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertNotEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 0)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertEqual(manifest["solver_verdict"], "UNKNOWN")

    def test_unsat_and_verified_checker_is_formula_only_proved(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "from pathlib import Path; Path(__import__('sys').argv[-1]).write_bytes(b'MOCK DRAT\\n'); print('s UNSATISFIABLE'); __import__('sys').exit(20)",
                "print('s VERIFIED')",
            )
            output = root / "proved-formula"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 0)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "PROVED")
            self.assertEqual(manifest["scope"], "exact_cnf_only")
            self.assertEqual(manifest["graph_transfer"], "PENDING")

    def test_negative_model_literal_is_validated_and_explored(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "import sys; print('s SATISFIABLE'); print('v -1 0'); sys.exit(10)",
                "print('s VERIFIED')",
            )
            output = root / "negative-model"
            with patch.object(solver, "build_model", side_effect=fake_negative_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 0)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertTrue(manifest["model_validated"])

    def test_invalid_model_clause_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "import sys; print('s SATISFIABLE'); print('v -1 0'); sys.exit(10)",
                "print('s VERIFIED')",
            )
            output = root / "invalid-model-clause"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 2)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertFalse(manifest["model_validated"])
            self.assertTrue(manifest["stop_reason"].startswith("invalid_model:"))

    def test_conflicting_solver_verdict_is_not_terminal(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "import sys; print('s SATISFIABLE'); print('s UNSATISFIABLE'); sys.exit(0)",
                "print('s VERIFIED')",
            )
            output = root / "conflicting-verdict"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 2)
            manifest = self.manifest(output)
            self.assertEqual(manifest["solver_verdict"], "CONFLICT")
            self.assertEqual(manifest["stop_reason"], "solver_unknown")

    def test_contradictory_model_literals_are_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "import sys; print('s SATISFIABLE'); print('v 1 -1 0'); sys.exit(10)",
                "print('s VERIFIED')",
            )
            output = root / "contradictory-model"
            with patch.object(solver, "build_model", side_effect=fake_negative_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 2)
            manifest = self.manifest(output)
            self.assertFalse(manifest["model_validated"])
            self.assertIn("Conflicting model literals", manifest["stop_reason"])

    def test_interrupted_checker_is_not_proved(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "from pathlib import Path; Path(__import__('sys').argv[-1]).write_bytes(b'MOCK DRAT\\n'); print('s UNSATISFIABLE'); __import__('sys').exit(20)",
                "import time; print('s VERIFIED', flush=True); time.sleep(30)",
            )
            output = root / "interrupted-checker"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 2)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertEqual(manifest["checker_stop_reason"], "deadline")
            self.assertFalse(manifest["proof_complete"])

    def test_checker_failure_with_verified_text_is_not_proved(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "from pathlib import Path; Path(__import__('sys').argv[-1]).write_bytes(b'MOCK DRAT\\n'); print('s UNSATISFIABLE'); __import__('sys').exit(20)",
                "print('s VERIFIED'); __import__('sys').exit(1)",
            )
            output = root / "checker-failure"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertNotEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 0)
            self.assertEqual(self.manifest(output)["status"], "EXPLORED")

    def test_solver_cnf_overwrite_blocks_checker(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "from pathlib import Path; Path(__import__('sys').argv[-2]).write_text('p cnf 1 0\\n'); Path(__import__('sys').argv[-1]).write_bytes(b'MOCK DRAT\\n'); print('s UNSATISFIABLE'); __import__('sys').exit(20)",
                "print('s VERIFIED')",
            )
            output = root / "overwritten-cnf"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 2)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertEqual(manifest["stop_reason"], "input_hash_changed_after_solver")
            self.assertFalse((output / "checker.log").exists())

    def test_snapshot_help_works_from_unrelated_cwd(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            snapshot = root / "snapshot"
            unrelated = root / "unrelated"
            snapshot.mkdir()
            unrelated.mkdir()
            shutil.copyfile(ROOT / "scripts/solve_z7_orbit_matrix.py", snapshot / "solve_z7_orbit_matrix.py")
            shutil.copyfile(ROOT / "scripts/orbit_matrix_encoding.py", snapshot / "orbit_matrix_encoding.py")
            result = subprocess.run(
                [sys.executable, str(snapshot / "solve_z7_orbit_matrix.py"), "--help"],
                cwd=unrelated, capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("--model", result.stdout)

    def test_polling_exception_terminates_child(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            process = Mock()
            process.poll.return_value = None
            process.wait.return_value = -15
            with patch.object(solver.subprocess, "Popen", return_value=process), \
                    patch.object(solver.shutil, "disk_usage", side_effect=OSError("probe failure")):
                with self.assertRaises(OSError):
                    solver.run_process(["mock"], root / "solver.log", 60, root, 1)
            process.terminate.assert_called_once()

    def test_interrupt_preserves_unknown_manifest(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(root, "pass", "pass")
            output = root / "interrupted"
            with patch.object(solver, "build_model", side_effect=fake_build_model), \
                    patch.object(solver, "run_process", side_effect=KeyboardInterrupt):
                self.assertEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 2)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertEqual(manifest["solver_verdict"], "UNKNOWN")
            self.assertFalse(manifest["proof_complete"])
            self.assertIn("KeyboardInterrupt", manifest["stop_reason"])

    def test_solver_timeout_is_not_proved(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            cadical, drat_trim = self.make_tools(
                root,
                "import time; time.sleep(30)",
                "print('s VERIFIED')",
            )
            output = root / "timeout"
            with patch.object(solver, "build_model", side_effect=fake_build_model):
                self.assertNotEqual(solver.run_cli(self.args(output, cadical, drat_trim)), 0)
            manifest = self.manifest(output)
            self.assertEqual(manifest["status"], "EXPLORED")
            self.assertEqual(manifest["stop_reason"], "deadline")


if __name__ == "__main__":
    unittest.main()
