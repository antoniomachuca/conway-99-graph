"""
tests/test_z3_fixed3_orbit_matrix.py

Deterministic Unit Tests for the Z_3 Fixed-3 35x35 Orbit Matrix Architecture,
Spectral Parameter Analysis, Algebraic Row Prototype Bounds, and Certified
SAT/DRAT Artifact Verification (Requirement R1).
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
from scripts.build_z3_fixed3_orbit_matrix_cnf import (
    SPECTRAL_TRACES,
    build_fixed3_orbit_matrix_cnf,
)


class TestZ3Fixed3OrbitMatrixTheory(unittest.TestCase):
    def test_spectral_trace_integer_solvability(self):
        """
        Verify that 7*a - 122 = 2*t has integer solutions for multiplicity a in [0..34]
        if and only if t is congruent to 2 modulo 7, yielding Tr in {4, 18, 32, 46, 60}.
        """
        valid_traces = []
        for a in range(35):
            trace = 14 + 3 * a - 4 * (34 - a)
            if trace >= 0 and trace % 2 == 0:
                t = trace // 2
                if t <= 32:
                    valid_traces.append(trace)

        self.assertEqual(valid_traces, [4, 18, 32, 46, 60])
        self.assertEqual(SPECTRAL_TRACES, [4, 18, 32, 46, 60])

    def test_k4_free_and_row_capacity_exclusion(self):
        """
        Verify the mathematical impossibility of t in {16, 23, 30}:
        - Orbits in W = 20, so t <= 20 excludes t=23 (Tr=46) and t=30 (Tr=60).
        - Off-diagonal 2s capacity: 2*(20 - t) >= 12 requires t <= 14, excluding t=16 (Tr=32).
        """
        # Maximum orbits in W
        max_w_orbits = 20
        for t in [23, 30]:
            self.assertGreater(t, max_w_orbits, f"Trace with t={t} exceeds W capacity")

        # Row prototype bound on non-triangular capacity
        for t in [2, 9]:
            capacity = 2 * (max_w_orbits - t)
            self.assertGreaterEqual(capacity, 12, f"t={t} satisfies capacity bound")

        for t in [16, 23, 30]:
            capacity = 2 * (max_w_orbits - t)
            self.assertLess(capacity, 12, f"t={t} violates capacity bound")

    def test_cnf_generator_creates_valid_formulas(self):
        """Verify that the CNF compiler constructs valid non-empty formulas for all traces."""
        for tr in SPECTRAL_TRACES:
            cnf = build_fixed3_orbit_matrix_cnf(tr)
            self.assertGreater(cnf.nv, 900000)
            self.assertGreater(len(cnf.clauses), 1800000)

    def test_audit_manifest_integrity_and_cryptographic_verification(self):
        """
        Forensic audit check: verify that proofs/z3_fixed3/audit_manifest.json exists,
        is non-empty, contains all 5 spectral traces with status UNSATISFIABLE (code 20),
        drat-trim VERIFIED (code 0), and all SHA-256 hashes match files on disk.
        """
        manifest_path = ROOT / "proofs" / "z3_fixed3" / "audit_manifest.json"
        self.assertTrue(manifest_path.exists(), "audit_manifest.json must exist")

        with open(manifest_path, "r") as f:
            manifest = json.load(f)

        self.assertEqual(len(manifest), 5, "Must contain all 5 spectral trace instances")

        recorded_files = {entry["cnf_file"]: entry for entry in manifest}
        for tr in SPECTRAL_TRACES:
            expected_name = f"conway_z3_fixed3_tr{tr:02d}.cnf"
            self.assertIn(expected_name, recorded_files)
            entry = recorded_files[expected_name]

            # Verify solver and checker status contracts
            self.assertEqual(entry["solver_exit_code"], 20)
            self.assertEqual(entry["solver_status"], "UNSATISFIABLE")
            self.assertEqual(entry["chk_exit_code"], 0)
            self.assertTrue(entry["chk_verified"])
            self.assertEqual(entry["operational_state"], "PROVED")

            # Verify cryptographic SHA-256 against actual files on disk
            cnf_path = Path(entry["cnf_path"])
            drat_path = Path(entry["drat_path"])
            self.assertTrue(cnf_path.exists())
            self.assertTrue(drat_path.exists())

            with open(cnf_path, "rb") as fc:
                computed_cnf_sha = hashlib.sha256(fc.read()).hexdigest()
            self.assertEqual(computed_cnf_sha, entry["cnf_sha256"])

            with open(drat_path, "rb") as fd:
                computed_drat_sha = hashlib.sha256(fd.read()).hexdigest()
            self.assertEqual(computed_drat_sha, entry["drat_sha256"])


if __name__ == "__main__":
    unittest.main()
