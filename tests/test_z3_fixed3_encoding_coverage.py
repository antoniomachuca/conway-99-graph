"""Coverage of the Z3-fixed3 canonical constraint assembly.

The checks call ConwayZ3Fixed3CanonicalCompiler and compare the recorded
degree and common-neighbor cardinalities with the orbit profile in that
compiler. They do not solve the Conway instance and do not discharge
conway_no_z3_fixed3_automorphism.
"""

from collections import Counter
from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.build_z3_canonical_cnf import ConwayZ3Fixed3CanonicalCompiler


N0 = range(0, 4)
N1 = range(4, 8)
N2 = range(8, 12)
W = range(12, 32)
MATCHED = {(0, 1), (2, 3), (4, 5), (6, 7), (8, 9), (10, 11)}


def neighborhood(orbit):
    if orbit < 4:
        return 0
    if orbit < 8:
        return 1
    if orbit < 12:
        return 2
    return None


class TracingFixed3Compiler(ConwayZ3Fixed3CanonicalCompiler):
    def __init__(self):
        self.cardinalities = []
        super().__init__(enable_lex=False)

    def add_card_equals(self, lits, bound):
        self.cardinalities.append((tuple(lit for lit in lits if lit), bound))


def subdegree_bound(source, block_index):
    if source < 12:
        return 10 if block_index == 3 else 1
    return 8 if block_index == 3 else 2


def expected_degree_cards(compiler):
    cards = []
    blocks = (list(N0), list(N1), list(N2), list(W))
    for source in range(32):
        own = neighborhood(source)
        for block_index, block in enumerate(blocks):
            if own is not None and block_index == own:
                continue
            literals = tuple(
                lit for orbit in block if orbit != source for time in range(3)
                if (lit := compiler.get_adj_lit(source, 0, orbit, time))
            )
            cards.append((literals, subdegree_bound(source, block_index)))
        cards.append((tuple(
            lit for orbit in range(32) if orbit != source for time in range(3)
            if (lit := compiler.get_adj_lit(source, 0, orbit, time))
        ), 13 if source < 12 else 14))
    return cards


def pair_orbits():
    pairs = []
    for left in range(32):
        pairs.append(((left, 0), (left, 1)))
        for right in range(left + 1, 32):
            for difference in range(3):
                pairs.append(((left, 0), (right, difference)))
    return pairs


def expected_common_card(compiler, left, right):
    left_orbit, left_time = left
    right_orbit, right_time = right
    same = neighborhood(left_orbit)
    bound = 1 if same is not None and same == neighborhood(right_orbit) else 2
    literals = []
    edge = compiler.get_adj_lit(left_orbit, left_time, right_orbit, right_time)
    if edge:
        literals.append(edge)
    for orbit in range(32):
        for time in range(3):
            witness = (orbit, time)
            if witness in (left, right):
                continue
            to_left = compiler.get_adj_lit(left_orbit, left_time, orbit, time)
            to_right = compiler.get_adj_lit(right_orbit, right_time, orbit, time)
            if to_left and to_right:
                literals.append(compiler.get_and_lit(to_left, to_right))
    return tuple(literals), bound


def independent_adjacency(compiler, left_orbit, left_time, right_orbit, right_time):
    if left_orbit == right_orbit:
        return 0
    if left_orbit > right_orbit:
        return independent_adjacency(compiler, right_orbit, right_time, left_orbit, left_time)
    difference = (right_time - left_time) % 3
    key = (left_orbit, right_orbit, difference)
    if compiler.fixed_edges.get(key) == 0:
        return 0
    return compiler.edge_vars[key]


class TestZ3Fixed3EncodingCoverage(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.compiler = TracingFixed3Compiler()
        cls.degree_start = len(cls.compiler.cardinalities)
        cls.compiler.build_degree_constraints()
        cls.degree_cards = cls.compiler.cardinalities[cls.degree_start:]
        cls.common_start = len(cls.compiler.cardinalities)
        cls.compiler.build_common_neighbor_constraints(verbose=False)
        cls.common_cards = cls.compiler.cardinalities[cls.common_start:]

    def test_fixed_one_factor_is_the_only_preset_block(self):
        compiler = self.compiler
        self.assertEqual(len(compiler.edge_vars), 1488)
        self.assertTrue(all(left < right for left, right, _ in compiler.edge_vars))
        preset = {}
        for left in range(12):
            for right in range(left + 1, 12):
                if left // 4 != right // 4:
                    continue
                for difference in range(3):
                    preset[(left, right, difference)] = int((left, right) in MATCHED and difference == 0)
        self.assertEqual(compiler.fixed_edges, preset)
        self.assertEqual(len(preset), 54)

    def test_adjacency_literal_follows_the_circulant_rule(self):
        compiler = self.compiler
        for left in range(32):
            for left_time in range(3):
                for right in range(32):
                    for right_time in range(3):
                        self.assertEqual(
                            compiler.get_adj_lit(left, left_time, right, right_time),
                            independent_adjacency(compiler, left, left_time, right, right_time),
                        )

    def test_degree_profile_matches_neighborhood_blocks(self):
        expected = expected_degree_cards(self.compiler)
        self.assertEqual(len(self.degree_cards), 148)
        self.assertEqual(Counter(self.degree_cards), Counter(expected))
        matched = self.compiler.get_adj_lit(0, 0, 1, 0)
        self.assertNotEqual(matched, 0)
        self.assertTrue(any(matched in literals and bound == 13 for literals, bound in self.degree_cards))

    def test_common_neighbor_targets_cover_every_pair_orbit(self):
        pairs = pair_orbits()
        self.assertEqual(len(pairs), 1520)
        expected = [expected_common_card(self.compiler, left, right) for left, right in pairs]
        self.assertEqual(self.common_cards, expected)

        matched_edge = self.compiler.get_adj_lit(0, 0, 1, 0)
        matched = self.common_cards[pairs.index(((0, 0), (1, 0)))]
        self.assertEqual(matched[1], 1)
        self.assertEqual(matched[0][0], matched_edge)

        absent = self.common_cards[pairs.index(((0, 0), (1, 1)))]
        self.assertEqual(absent[1], 1)
        self.assertNotIn(self.compiler.edge_vars[(0, 1, 1)], absent[0])

        outside = self.common_cards[pairs.index(((0, 0), (12, 0)))]
        self.assertEqual(outside[1], 2)
        self.assertEqual(outside[0][0], self.compiler.get_adj_lit(0, 0, 12, 0))


if __name__ == "__main__":
    unittest.main()
