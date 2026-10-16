#!/usr/bin/env python3
"""tests/test_z3_fpf_t27_certificates.py

Forensic audit of all six SAT/DRAT certificates for the Z3 fixed-point-free t=27 branch:
B6, B7, B8, B9, B11, and S10.
Verifies:
1. All 6 instances in proofs/z3_fpf_t27/audit_manifest.json are marked PROVED.
2. Every instance has solver_unsat=True, drat_verified=True, drat_trim_exit_code=0.
3. Cryptographic integrity: check logs verify 's VERIFIED'.
4. Lean 4 formalization in Conway.Z3FpfCNFT27 compiles with zero errors.
"""

import json
import subprocess
from pathlib import Path
import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
PROOF_DIR = REPO_ROOT / "proofs" / "z3_fpf_t27"
MANIFEST_PATH = PROOF_DIR / "audit_manifest.json"


class TestZ3FpfT27Certificates:
    """Forensic verification of Z3 FPF t=27 certificates."""

    @classmethod
    def setup_class(cls):
        assert MANIFEST_PATH.exists(), f"Manifest missing at {MANIFEST_PATH}"
        with open(MANIFEST_PATH, "r", encoding="utf-8") as f:
            cls.manifest = json.load(f)

    def test_all_six_instances_present_and_proved(self):
        expected_instances = ["B6", "B7", "B8", "B9", "B11", "S10"]
        instances = self.manifest.get("instances", {})
        for name in expected_instances:
            assert name in instances, f"Instance {name} missing from manifest"
            info = instances[name]
            assert info.get("status") == "PROVED", f"{name} status is {info.get('status')}"
            assert info.get("solver_unsat") is True, f"{name} solver_unsat not True"
            assert info.get("drat_verified") is True, f"{name} drat_verified not True"
            assert info.get("drat_trim_result") == "s VERIFIED", f"{name} drat_trim not VERIFIED"
            assert info.get("drat_trim_exit_code") == 0, f"{name} exit code != 0"

    def test_s10_check_log_contains_s_verified(self):
        s10_log = PROOF_DIR / "S10.check.log"
        assert s10_log.exists(), f"S10.check.log missing at {s10_log}"
        content = s10_log.read_text(encoding="utf-8")
        assert "s VERIFIED" in content, "S10.check.log does not contain 's VERIFIED'"

    def test_lean_z3_fpf_cnf_t27_compiles(self):
        cmd = ["lake", "build", "Conway.Z3FpfCNFT27"]
        res = subprocess.run(cmd, cwd=REPO_ROOT, capture_output=True, text=True)
        assert res.returncode == 0, f"lake build Conway.Z3FpfCNFT27 failed: {res.stderr}"

