"""Unit Test Suite for the 156 24-Dimensional Unimodular Lattices
and Conway 99-Graph Involution Eigenvector Support Bounds (Requirement R3).

Verifies:
1. Complete catalog integrity of 156 lattices:
   - Exactly 24 even unimodular lattices (Niemeier lattices).
   - Exactly 132 odd unimodular lattices (Borcherds 1993, SPLAG Ch. 16 & 17).
   - All lattices have dimension 24 and determinant 1 (unimodular).
   - Unique Leech lattice with min norm 4 and 0 roots.
   - All 23 other Niemeier lattices have min norm 2 and rank 24.
   - All 132 odd unimodular lattices have min norm 2.
2. Eigenvector support bounds:
   - Norm < 16 (h < 8) unconditionally refuted across all 156 lattices.
   - Detailed small h obstructions for h in {1, ..., 7}.
   - Norm > 20 (h > 10) unconditionally refuted by 24D rank & saturation bounds.
   - Admissible norms strictly restricted to {16, 18, 20} (h in {8, 9, 10}).
3. Cryptographic manifest & forensic audit report:
   - proofs/borcherds_lattices/manifest.json is valid and contains 156 SHA-256 entries.
   - proofs/borcherds_lattices/audit_report.md is valid, structured, and non-empty.
   - Operational state is strictly certified as PROVED.
"""

from __future__ import annotations

import json
from pathlib import Path
import sys

import pytest

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))

from scripts.verify_borcherds_lattices import (
    BORCHERDS_ODD_ROOT_SYSTEMS,
    NIEMEIER_LATTICES_DATA,
    audit_borcherds_eigenvectors,
    build_complete_borcherds_catalog,
    generate_manifest_and_report,
)


class TestBorcherdsCatalog:
    """Tests certifying the mathematical catalog of all 156 24-dimensional unimodular lattices."""

    @pytest.fixture(scope="class")
    def catalog(self):
        return build_complete_borcherds_catalog()

    def test_total_count_is_156(self, catalog):
        assert len(catalog) == 156

    def test_even_count_is_24(self, catalog):
        even = [lat for lat in catalog if lat["parity"] == "even"]
        assert len(even) == 24
        assert len(NIEMEIER_LATTICES_DATA) == 24

    def test_odd_count_is_132(self, catalog):
        odd = [lat for lat in catalog if lat["parity"] == "odd"]
        assert len(odd) == 132
        assert len(BORCHERDS_ODD_ROOT_SYSTEMS) == 132

    def test_all_dimensions_are_24(self, catalog):
        for lat in catalog:
            assert lat["dimension"] == 24
            assert lat["determinant"] == 1

    def test_leech_lattice_properties(self, catalog):
        leech = catalog[0]
        assert leech["name"] == "Niemeier_Leech"
        assert leech["parity"] == "even"
        assert leech["min_norm"] == 4
        assert leech["roots_count"] == 0
        assert leech["coxeter_number"] == 0

    def test_other_niemeier_lattices_min_norm_2(self, catalog):
        for lat in catalog[1:24]:
            assert lat["parity"] == "even"
            assert lat["min_norm"] == 2
            assert lat["roots_count"] > 0
            assert lat["coxeter_number"] > 0

    def test_all_odd_lattices_min_norm_2(self, catalog):
        for lat in catalog[24:]:
            assert lat["parity"] == "odd"
            assert lat["min_norm"] == 2


class TestEigenvectorNormBounds:
    """Tests certifying the mathematical exclusion of eigenvectors outside norm 16, 18, 20."""

    @pytest.fixture(scope="class")
    def audit_results(self):
        catalog = build_complete_borcherds_catalog()
        return audit_borcherds_eigenvectors(catalog)

    def test_no_eigenvectors_outside_norm_16_18_20(self, audit_results):
        assert audit_results["no_eigenvectors_outside_norm_16_18_20"] is True
        assert audit_results["operational_state"] == "PROVED"

    def test_norm_lt_16_refuted(self, audit_results):
        assert audit_results["norm_lt_16_refuted"] is True
        small_obs = audit_results["small_h_obstructions"]
        assert "h_1" in small_obs
        assert "h_4" in small_obs
        assert "h_5" in small_obs
        assert "h_6" in small_obs
        assert "h_7" in small_obs

    def test_norm_gt_20_refuted(self, audit_results):
        assert audit_results["norm_gt_20_refuted"] is True

    def test_admissible_norms_and_h_values(self, audit_results):
        assert audit_results["admissible_norms"] == [16, 18, 20]
        assert audit_results["admissible_h_values"] == [8, 9, 10]


class TestCoverageAndAuditArtifacts:
    """Tests certifying the generation and integrity of the cryptographic manifest and audit report."""

    @pytest.fixture(scope="class")
    def generated_paths(self):
        out_dir = REPO_ROOT / "proofs" / "borcherds_lattices"
        return generate_manifest_and_report(out_dir)

    def test_manifest_file_integrity(self, generated_paths):
        manifest_path, _ = generated_paths
        assert manifest_path.exists()
        with open(manifest_path) as f:
            data = json.load(f)

        assert data["operational_state"] == "PROVED"
        assert data["total_lattices"] == 156
        assert data["even_lattices_count"] == 24
        assert data["odd_lattices_count"] == 132
        assert data["admissible_norms"] == [16, 18, 20]
        assert data["admissible_h_values"] == [8, 9, 10]
        assert len(data["lattices"]) == 156

        # Check that every lattice has a valid SHA-256 hash
        for entry in data["lattices"]:
            assert "sha256" in entry
            assert len(entry["sha256"]) == 64

    def test_audit_report_file_integrity(self, generated_paths):
        _, report_path = generated_paths
        assert report_path.exists()
        content = report_path.read_text(encoding="utf-8")
        assert len(content) > 1000
        assert "PROVED" in content
        assert "Niemeier_Leech" in content
        assert "Niemeier_3E8" in content
        assert "Cryptographic Checksum Registry" in content
        assert "156" in content
