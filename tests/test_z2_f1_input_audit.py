import contextlib
import io
from pathlib import Path
import sys
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from build_z2_f1_cnf import ConwayZ2F1Compiler
from scripts.validate_z2_f1_inputs import (
    audit_equations,
    audit_geometry,
    audit_stabilizer,
    compile_recorded,
    expected_cuts,
    read_cuts,
)


class TestZ2F1Geometry(unittest.TestCase):
    def setUp(self):
        self.compiler = ConwayZ2F1Compiler()

    def test_all_outer_coordinates_and_fixed_pair_equations(self):
        result = audit_geometry(self.compiler)
        self.assertEqual(result["outer_coordinates"], 84)
        self.assertEqual(result["fixed_vertex_degrees"], [14] * 15)

    def test_corrupted_coordinate_is_rejected(self):
        self.compiler.nbrs_N[(0, 0)] = {1}
        with self.assertRaises(ValueError):
            audit_geometry(self.compiler)

    def test_stabilizer_covers_actual_compiler_branch_labels(self):
        result = audit_stabilizer(self.compiler)
        self.assertEqual(result["suborbit_sizes"], [1, 1, 20, 20])
        self.assertEqual(result["representatives"], {"A": 21, "B": 1, "C": 11})

    def test_legacy_c_does_not_cover_the_disjoint_class(self):
        with self.assertRaises(ValueError):
            audit_stabilizer(self.compiler, {"A": 21, "B": 1, "C": 10})

    def test_declared_branch_supports_match_compiler_indices(self):
        from scripts.classify_z2_f1_incidence_matrix import derive_symmetry_breaking_branches

        for branch in derive_symmetry_breaking_branches().values():
            self.assertEqual(list(self.compiler.orbit_pairs[branch["partner_orbit_idx"]]), branch["partner_info"]["support"])

    def test_branch_cuts_and_wrong_partner(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "cuts.cnf"
            clauses = expected_cuts(1)
            path.write_text("".join(" ".join(map(str, clause)) + " 0\n" for clause in clauses))
            self.assertEqual(read_cuts(path, 1), clauses)
            with self.assertRaises(ValueError):
                read_cuts(path, 21)

    def test_generation_uses_disjoint_cut_and_preserves_existing_output(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            base = root / "base.cnf"
            base.write_text("p cnf 1764 1\n-1 0\n")
            output = root / "new"
            command = [sys.executable, str(ROOT / "scripts/generate_branches_cnf.py"),
                       "--base", str(base), "--output-dir", str(output)]
            result = subprocess.run(command, cwd=root, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            path = output / "conway_z2_f1_branch_c.cnf"
            original = path.read_bytes()
            lines = original.decode().splitlines()
            self.assertIn("12 0", lines)
            self.assertIn("463 0", lines)
            self.assertNotIn("11 0", lines)
            repeated = subprocess.run(command, cwd=root, capture_output=True, text=True)
            self.assertNotEqual(repeated.returncode, 0)
            self.assertEqual(path.read_bytes(), original)

    def test_missing_clause_terminator_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "cuts.cnf"
            path.write_text("2\n")
            with self.assertRaises(ValueError):
                read_cuts(path, 1)


class TestZ2F1SymbolicEquations(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with contextlib.redirect_stdout(io.StringIO()):
            cls.compiler, cls.equations = compile_recorded()

    def test_all_cardinality_constraints_match_adjacency_equations(self):
        self.assertEqual(audit_equations(self.compiler, self.equations), 2394)

    def test_changed_degree_bound_is_rejected(self):
        equations = list(self.equations)
        literals, bound = equations[0]
        equations[0] = (literals, bound + 1)
        with self.assertRaises(ValueError):
            audit_equations(self.compiler, equations)

    def test_missing_constraint_is_rejected(self):
        with self.assertRaises(ValueError):
            audit_equations(self.compiler, self.equations[:-1])


if __name__ == "__main__":
    unittest.main()
