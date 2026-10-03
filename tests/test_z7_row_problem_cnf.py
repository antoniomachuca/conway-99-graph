from pathlib import Path
import sys
import unittest

from pysat.solvers import Cadical195

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.enumerate_z7_quotient import RowProblem, generate_rows, z7_problem
from scripts.z7_row_problem_cnf import RowProblemCNF, RowSelectionCNF
from tests.test_z7_quotient_enumeration import (
    brute_force, cycle5_problem, satisfies, weighted_problem,
)


def selection_models(problem):
    domains = [list(generate_rows(problem, i)) for i in range(problem.size)]
    encoded = RowSelectionCNF(problem, domains)
    if any(not clause for clause in encoded.cnf.clauses):
        return set()
    found = set()
    with Cadical195(bootstrap_with=encoded.cnf) as solver:
        for model in solver.enum_models():
            found.add(encoded.decode(model))
    return found


def models_of(problem):
    encoded = RowProblemCNF(problem)
    if any(not clause for clause in encoded.cnf.clauses):
        return set()
    found = set()
    with Cadical195(bootstrap_with=encoded.cnf) as solver:
        for model in solver.enum_models():
            found.add(encoded.decode(model))
    return found


class TestRowProblemCNF(unittest.TestCase):
    def test_small_models_match_brute_force(self):
        impossible = RowProblem(
            1, (2,) * 5,
            tuple(tuple(2 if i == j else 0 for j in range(5)) for i in range(5)),
            ((0,),) * 5, (0,) * 5, (0,) * 5,
        )
        single_sat = RowProblem(0, (0,), ((0,),), ((0,),), (0,), (0,))
        single_unsat = RowProblem(0, (1,), ((0,),), ((0,),), (0,), (0,))
        problems = (
            cycle5_problem(),
            weighted_problem()[0],
            impossible,
            single_sat,
            single_unsat,
        )
        for problem in problems:
            self.assertEqual(models_of(problem), brute_force(problem))

    def test_row_selection_matches_brute_force(self):
        impossible = RowProblem(
            1, (2,) * 5,
            tuple(tuple(2 if i == j else 0 for j in range(5)) for i in range(5)),
            ((0,),) * 5, (0,) * 5, (0,) * 5,
        )
        for problem in (cycle5_problem(), weighted_problem()[0], impossible):
            self.assertEqual(selection_models(problem), brute_force(problem))

    def test_cycle5_has_twelve_labelled_solutions(self):
        self.assertEqual(len(models_of(cycle5_problem())), 12)

    def test_assumptions_accept_only_solutions(self):
        problem, planted = weighted_problem()
        encoded = RowProblemCNF(problem)
        with Cadical195(bootstrap_with=encoded.cnf) as solver:
            self.assertTrue(solver.solve(assumptions=encoded.assumptions(planted)))
        broken = [list(row) for row in planted]
        broken[0][1] = 1 - broken[0][1]
        broken[1][0] = broken[0][1]
        self.assertFalse(satisfies(problem, broken))
        encoded = RowProblemCNF(problem)
        with Cadical195(bootstrap_with=encoded.cnf) as solver:
            self.assertFalse(solver.solve(assumptions=encoded.assumptions(broken)))

    def test_z7_encoding_uses_the_frozen_predicate_without_relabeling_cuts(self):
        problem = z7_problem()
        encoded = RowProblemCNF(problem)
        self.assertEqual(len(encoded.entries), problem.size * (problem.size + 1) // 2)
        self.assertEqual(set(encoded.entries[(0, 0)]), {0, 2})
        self.assertEqual(set(encoded.entries[(0, 1)]), set(range(5)))
        self.assertEqual(problem.weights, (1, 1, 1, -1, -1, -1, 0, 0, 0, 0, 0, 0))
        self.assertEqual(tuple(problem.targets[i][i] for i in range(12)), (22,) * 6 + (24,) * 6)
        def left(index):
            return 2 if index < 3 else 0 if index < 6 else 1
        for i in range(12):
            for j in range(12):
                a, b = left(i), left(j)
                expected = 12 * int(i == j) + 14 - a * b - (2 - a) * (2 - b)
                self.assertEqual(problem.targets[i][j], expected)
        self.assertTrue(all(clause for clause in encoded.cnf.clauses))
        self.assertGreater(encoded.top_id, 0)
        self.assertLess(encoded.top_id, 200_000)


if __name__ == "__main__":
    unittest.main()
