import json
import os
from pathlib import Path
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.run_bounded_local_search import Limits, limit_reason, supervise


class TestBoundedLocalSearch(unittest.TestCase):
    def test_limit_boundaries(self):
        limits = Limits(12, 1024, 100)
        self.assertIsNone(limit_reason(limits, 11, 1023, 100))
        self.assertEqual(limit_reason(limits, 12, 0, 100), "wall_time_limit")
        self.assertEqual(limit_reason(limits, 0, 1024, 100), "proof_size_limit")
        self.assertEqual(limit_reason(limits, 0, 0, 99), "free_space_limit")

    def test_rejects_unbounded_limits(self):
        for limits in [(0, 1024, 100), (12, 0, 100), (12, 1024, -1)]:
            with self.assertRaises(ValueError):
                Limits(*limits)

    def test_wall_time_stops_only_owned_child_and_preserves_partial_proof(self):
        with tempfile.TemporaryDirectory() as directory:
            code = 'from pathlib import Path; import time; Path("proof.drat").write_bytes(b"partial"); time.sleep(60)'
            result = supervise([sys.executable, "-B", "-c", code], Path(directory), Limits(0.3, 1048576, 0), poll_seconds=0.01)
            self.assertEqual(result["stop_reason"], "wall_time_limit")
            self.assertEqual(result["classification"], "EXPLORED")
            self.assertEqual((Path(directory) / "proof.drat").read_bytes(), b"partial")
            with self.assertRaises(ProcessLookupError):
                os.kill(result["solver_pid"], 0)

    def test_low_space_stops_owned_child(self):
        readings = iter([1000, 0])
        with tempfile.TemporaryDirectory() as directory:
            result = supervise([sys.executable, "-B", "-c", "import time; time.sleep(60)"],
                               Path(directory), Limits(60, 1048576, 100), poll_seconds=0.01,
                               free_bytes=lambda: next(readings, 0))
            self.assertEqual(result["stop_reason"], "free_space_limit")

    def test_hard_proof_size_limit(self):
        with tempfile.TemporaryDirectory() as directory:
            code = 'from pathlib import Path; Path("proof.drat").write_bytes(b"x" * 8192)'
            result = supervise([sys.executable, "-B", "-c", code], Path(directory), Limits(10, 4096, 0), poll_seconds=0.01)
            self.assertLessEqual((Path(directory) / "proof.drat").stat().st_size, 4096)
            self.assertEqual(result["stop_reason"], "proof_size_limit")

    def test_unsat_without_checker_remains_pending(self):
        with tempfile.TemporaryDirectory() as directory:
            code = 'from pathlib import Path; import sys; Path("proof.drat").write_bytes(b"test"); print("s UNSATISFIABLE"); sys.exit(20)'
            result = supervise([sys.executable, "-B", "-c", code], Path(directory), Limits(10, 1048576, 0), poll_seconds=0.01)
            self.assertEqual(result["solver_result"], "UNSATISFIABLE")
            self.assertEqual(result["classification"], "PENDING")
            self.assertEqual(result["proof_verification"], "PENDING")

    def test_existing_artifacts_are_not_overwritten(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "solver.log"
            path.write_text("keep")
            with self.assertRaises(FileExistsError):
                supervise([sys.executable, "-c", "pass"], Path(directory), Limits(10, 1024, 0))
            self.assertEqual(path.read_text(), "keep")

    def test_monitor_error_stops_child_and_records_failure(self):
        calls = 0

        def broken_disk_probe():
            nonlocal calls
            calls += 1
            if calls > 1:
                raise OSError("test disk probe failure")
            return 1000

        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaises(OSError):
                supervise([sys.executable, "-B", "-c", "import time; time.sleep(60)"],
                          Path(directory), Limits(60, 1048576, 100), poll_seconds=0.01,
                          free_bytes=broken_disk_probe)
            state = json.loads((Path(directory) / "status.json").read_text())
            self.assertEqual(state["state"], "failed")
            with self.assertRaises(ProcessLookupError):
                os.kill(state["solver_pid"], 0)


if __name__ == "__main__":
    unittest.main()
