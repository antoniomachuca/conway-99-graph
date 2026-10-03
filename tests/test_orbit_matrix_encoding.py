from contextlib import contextmanager
import itertools
from pathlib import Path
import sys
import unittest

from pysat.solvers import Cadical195

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.orbit_matrix_encoding import (
    OrbitMatrixCNF, quotient_from_graph, verify_quotient, z7_specification,
)


@contextmanager
def cnf_solver(clauses):
    with Cadical195() as solver:
        for clause in clauses:
            solver.add_clause(clause)
        yield solver


class TestOrbitMatrixArithmetic(unittest.TestCase):
    def test_mixed_orbit_sizes_exhaustive(self):
        sizes = (2, 1)
        matrices = [[[a, b], [c, 0]] for a, b, c in itertools.product(range(2), range(2), range(3))]
        for degree, lam, mu in itertools.product(range(3), repeat=3):
            encoder = OrbitMatrixCNF(sizes, degree, lam, mu)
            encoder.compile()
            with cnf_solver(encoder.cnf.clauses) as solver:
                for matrix in matrices:
                    try:
                        verify_quotient(matrix, sizes, degree, lam, mu)
                        expected = True
                    except ValueError:
                        expected = False
                    self.assertEqual(solver.solve(assumptions=encoder.assumptions(matrix)), expected,
                                     (degree, lam, mu, matrix))

    def test_literal_one_conjunction_truth_table(self):
        encoder = OrbitMatrixCNF((1,), 0, 0, 0)
        a, b = encoder.new_variable(), encoder.new_variable()
        self.assertEqual(a, 1)
        output = encoder.conjunction(a, b)
        with cnf_solver(encoder.cnf.clauses) as solver:
            for x, y, z in itertools.product((False, True), repeat=3):
                assumptions = [a if x else -a, b if y else -b, output if z else -output]
                self.assertEqual(solver.solve(assumptions=assumptions), z == (x and y))

    def test_signed_repeated_linear_terms(self):
        for bound in range(-3, 5):
            encoder = OrbitMatrixCNF((1,), 0, 0, 0)
            a, b = encoder.new_variable(), encoder.new_variable()
            encoder.linear_equals([(a, 2), (b, -3), (True, 1), (False, 5)], bound)
            with cnf_solver(encoder.cnf.clauses) as solver:
                for x, y in itertools.product((False, True), repeat=2):
                    self.assertEqual(solver.solve(assumptions=[a if x else -a, b if y else -b]),
                                     2 * x - 3 * y + 1 == bound)

    def test_domain_holes_and_constants(self):
        encoder = OrbitMatrixCNF((3,), 2, 1, 0, domains={(0, 0): (0, 2)})
        with cnf_solver(encoder.cnf.clauses) as solver:
            for value in range(3):
                self.assertEqual(solver.solve(assumptions=encoder.assumptions([[value]])), value in (0, 2))
        encoder.compile()
        with cnf_solver(encoder.cnf.clauses) as solver:
            self.assertTrue(solver.solve())
            self.assertEqual(encoder.decode(solver.get_model()), [[2]])

    def test_empty_and_impossible_cardinalities(self):
        for terms, bound, expected in (([], 0, True), ([], 1, False), ([(True, 2)], 1, False)):
            encoder = OrbitMatrixCNF((1,), 0, 0, 0)
            encoder.linear_equals(terms, bound)
            with cnf_solver(encoder.cnf.clauses) as solver:
                self.assertEqual(solver.solve(), expected)


class TestKnownOrbitQuotients(unittest.TestCase):
    def test_paley9_translation_and_inversion(self):
        adjacency = [[int(u != v and (u // 3 == v // 3 or u % 3 == v % 3)) for v in range(9)] for u in range(9)]
        for orbits in (
            ((0, 1, 2), (3, 4, 5), (6, 7, 8)),
            ((0,), (1, 2), (3, 6), (4, 8), (5, 7)),
        ):
            matrix = quotient_from_graph(adjacency, orbits)
            sizes = tuple(map(len, orbits))
            self.assertTrue(verify_quotient(matrix, sizes, 4, 1, 2))
            encoder = OrbitMatrixCNF(sizes, 4, 1, 2)
            encoder.compile()
            with cnf_solver(encoder.cnf.clauses) as solver:
                self.assertTrue(solver.solve(assumptions=encoder.assumptions(matrix)))
                model = solver.get_model()
                self.assertEqual(encoder.decode(model), matrix)
                self.assertTrue(all(any(literal in set(model) for literal in clause) for clause in encoder.cnf.clauses))
                changed = [row[:] for row in matrix]
                changed[0][1] = 0 if changed[0][1] else 1
                self.assertFalse(solver.solve(assumptions=encoder.assumptions(changed)))

    def test_c5_one_orbit(self):
        adjacency = [[int((u - v) % 5 in (1, 4)) for v in range(5)] for u in range(5)]
        matrix = quotient_from_graph(adjacency, (tuple(range(5)),))
        encoder = OrbitMatrixCNF((5,), 2, 0, 1)
        encoder.compile()
        with cnf_solver(encoder.cnf.clauses) as solver:
            self.assertTrue(solver.solve(assumptions=encoder.assumptions(matrix)))
            self.assertEqual(encoder.decode(solver.get_model()), [[2]])

    def test_nonequitable_partition_rejected(self):
        adjacency = [[int(abs(u - v) == 1) for v in range(3)] for u in range(3)]
        with self.assertRaises(ValueError):
            quotient_from_graph(adjacency, ((0, 1), (2,)))


class TestZ7GeneralSpecification(unittest.TestCase):
    def test_general_model_does_not_impose_frob21_blocks(self):
        specification = z7_specification()
        self.assertEqual(specification["sizes"], (1,) + (7,) * 14)
        self.assertFalse(any(i >= 3 and j >= 3 for i, j in specification["fixed"]))
        encoder = OrbitMatrixCNF(**specification)
        self.assertIsNot(encoder.entries[3, 4], encoder.entries[4, 5])
        self.assertIs(encoder.entries[3, 4], encoder.entries[4, 3])
        with cnf_solver(encoder.cnf.clauses) as solver:
            for i in range(3, 15):
                self.assertEqual(specification["domains"][i, i], (0, 2))
                self.assertTrue(solver.solve(assumptions=list(encoder.entries[i, i])))
        left = [specification["fixed"][i, 1] for i in range(3, 15)]
        self.assertEqual(left, [2] * 3 + [0] * 3 + [1] * 6)

    def test_invalid_domain_and_repeated_compile_rejected(self):
        with self.assertRaises(ValueError):
            OrbitMatrixCNF((1,), 0, 0, 0, domains={(0, 0): (1,)})
        encoder = OrbitMatrixCNF((1,), 0, 0, 0)
        encoder.compile()
        with self.assertRaises(ValueError):
            encoder.compile()


if __name__ == "__main__":
    unittest.main()
