"""Deterministic lock for the f=1 orbit-pair common-neighbor table.

The expected booleans and demands are part of the calculation. A change here
means the coordinate model or the elimination rule changed.
"""

from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.orbit_pair_parameters import build_report, format_report


EXPECTED_BRANCHES = {
    "A": {
        "partner": 21,
        "support": (0, 1),
        "phase": "-",
        "orbital": "same_support",
        "counts": (1, 1, 1, 1),
        "faithful_residual_order": 7680,
        "abstract_residual_order": 15360,
        "demands": {
            "K22": (0, 0, 0, 0),
            "M0": (0, 1, 1, 0),
            "M1": (1, 0, 0, 1),
            "empty": (1, 1, 1, 1),
        },
    },
    "B": {
        "partner": 1,
        "support": (0, 2),
        "phase": "+",
        "orbital": "intersecting",
        "counts": (1, 0, 0, 1),
        "faithful_residual_order": 384,
        "abstract_residual_order": 768,
        "demands": {
            "K22": (0, 1, 1, 0),
            "M0": (0, 2, 2, 0),
            "M1": (1, 1, 1, 1),
            "empty": (1, 2, 2, 1),
        },
    },
    "C": {
        "partner": 11,
        "support": (2, 3),
        "phase": "+",
        "orbital": "disjoint",
        "counts": (0, 0, 0, 0),
        "faithful_residual_order": 384,
        "abstract_residual_order": 768,
        "demands": {
            "K22": (1, 1, 1, 1),
            "M0": (1, 2, 2, 1),
            "M1": (2, 1, 1, 2),
            "empty": (2, 2, 2, 2),
        },
    },
}


class TestOrbitPairParameters(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.report = build_report()

    def test_status_is_explored_and_no_branch_dies(self):
        self.assertEqual(self.report["classification"], "EXPLORED")
        self.assertFalse(self.report["arithmetic_obstruction"])
        self.assertEqual(self.report["dead_branches"], [])
        self.assertEqual(self.report["max_common_neighbors_in_N"], 1)
        self.assertTrue(self.report["label_action_matches_neighborhoods"])

    def test_w_splits_the_861_pairs_into_the_three_geometric_orbitals(self):
        orbitals = self.report["orbitals"]
        self.assertEqual([item["name"] for item in orbitals], ["same_support", "intersecting", "disjoint"])
        self.assertEqual([item["size"] for item in orbitals], [21, 420, 420])
        self.assertEqual([item["cn_normalized"] for item in orbitals], [(1, 1, 1, 1), (0, 1, 1, 0), (0, 0, 0, 0)])
        for orbital in orbitals:
            self.assertTrue(orbital["relations"]["K22"]["possible"])
            self.assertTrue(orbital["relations"]["simple_matching"]["possible"])
            self.assertTrue(orbital["relations"]["empty"]["possible"])

    def test_recorded_stabilizer_orders(self):
        stabilizer = self.report["stabilizer"]
        self.assertEqual(stabilizer["abstract_order"], 15360)
        self.assertEqual(stabilizer["faithful_order"], 7680)
        self.assertEqual(stabilizer["kernel_order"], 2)
        self.assertEqual(stabilizer["suborbit_sizes"], [1, 1, 20, 20])
        self.assertEqual(stabilizer["partner_orbit_sizes"], {"A": 1, "B": 20, "C": 20})

    def test_each_required_k22_partner_remains_possible(self):
        self.assertEqual([branch["name"] for branch in self.report["branches"]], ["A", "B", "C"])
        for branch in self.report["branches"]:
            expected = EXPECTED_BRANCHES[branch["name"]]
            self.assertEqual(branch["partner"], expected["partner"])
            self.assertEqual(branch["support"], expected["support"])
            self.assertEqual(branch["phase"], expected["phase"])
            self.assertEqual(branch["orbital"], expected["orbital"])
            self.assertEqual(branch["counts"], expected["counts"])
            self.assertEqual(branch["faithful_residual_order"], expected["faithful_residual_order"])
            self.assertEqual(branch["abstract_residual_order"], expected["abstract_residual_order"])
            self.assertTrue(branch["alive"])
            self.assertTrue(branch["k22_possible"])
            for relation, demands in expected["demands"].items():
                self.assertTrue(branch["relations"][relation]["possible"])
                self.assertEqual(branch["relations"][relation]["demands"], demands)
            self.assertTrue(branch["relations"]["simple_matching"]["possible"])
            self.assertTrue(branch["relations"]["simple_matching"]["M0"])
            self.assertTrue(branch["relations"]["simple_matching"]["M1"])

    def test_printed_table_states_the_explored_verdict(self):
        text = format_report(self.report)
        self.assertIn("Status: EXPLORED", text)
        self.assertIn("Arithmetic obstruction: no", text)
        self.assertIn("7680", text)
        self.assertIn("15360", text)


if __name__ == "__main__":
    unittest.main()
