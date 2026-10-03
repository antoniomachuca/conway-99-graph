"""CNF for the symmetric row problem in ``enumerate_z7_quotient``.

Variables exist only for ``i <= j``. That is the symmetry the predicate
requires of the matrix. It does not identify matrices related by a
relabeling of the twelve exterior orbits.
"""

from pathlib import Path
import sys

import numpy as np
from pysat.card import CardEnc, EncType
from pysat.formula import CNF

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.enumerate_z7_quotient import RowProblem, z7_problem


class RowProblemCNF:
    def __init__(self, problem):
        if not isinstance(problem, RowProblem):
            raise TypeError("Expected a RowProblem")
        self.problem = problem
        self.cnf = CNF()
        self.top_id = 0
        self.true = self.new_var()
        self.cnf.append([self.true])
        self.entries = {}
        n = problem.size
        for i in range(n):
            for j in range(i, n):
                domain = problem.diagonals[i] if i == j else tuple(range(problem.bound + 1))
                literals = {value: self.new_var() for value in domain}
                self.entries[(i, j)] = literals
                self.exactly_one(list(literals.values()))
        for i in range(n):
            self.enforce_sum(
                [list(self.entry_lits(i, j).items()) for j in range(n)],
                problem.row_sums[i],
                nonnegative=True,
            )
            weighted = []
            for j in range(n):
                weight = problem.weights[j]
                if weight:
                    weighted.append([(weight * value, lit) for value, lit in self.entry_lits(i, j).items()])
            self.enforce_sum(weighted, problem.balances[i], nonnegative=False)
        for i in range(n):
            for j in range(i, n):
                steps = [self.product_step(self.entry_lits(i, k), self.entry_lits(j, k)) for k in range(n)]
                steps.append(list(self.entry_lits(i, j).items()))
                self.enforce_sum(steps, problem.targets[i][j], nonnegative=True)

    def new_var(self):
        self.top_id += 1
        return self.top_id

    def entry_lits(self, i, j):
        if i > j:
            i, j = j, i
        return self.entries[(i, j)]

    def at_most_one(self, literals):
        for left in range(len(literals)):
            for right in range(left + 1, len(literals)):
                self.cnf.append([-literals[left], -literals[right]])

    def exactly_one(self, literals):
        if not literals:
            self.cnf.append([])
            return
        self.cnf.append(list(literals))
        self.at_most_one(literals)

    def product_step(self, left, right):
        products = {}
        links = []
        for a, left_lit in left.items():
            for b, right_lit in right.items():
                value = a * b
                if value not in products:
                    products[value] = self.new_var()
                links.append((left_lit, right_lit, products[value]))
        self.exactly_one(list(products.values()))
        for left_lit, right_lit, product_lit in links:
            self.cnf.append([-left_lit, -right_lit, product_lit])
        return list(products.items())

    def enforce_sum(self, steps, target, nonnegative):
        if target < 0 or any(not step for step in steps):
            self.cnf.append([])
            return
        if not steps:
            if target != 0:
                self.cnf.append([])
            return
        if nonnegative and any(amount < 0 for step in steps for amount, _ in step):
            raise ValueError("Nonnegative sum received a negative amount")
        current = {0: self.true}
        for step in steps:
            reachable = {}
            for total, total_lit in current.items():
                for amount, choice in step:
                    nxt = total + amount
                    if nonnegative and nxt > target:
                        self.cnf.append([-total_lit, -choice])
                        continue
                    if nxt not in reachable:
                        reachable[nxt] = self.new_var()
                    self.cnf.append([-total_lit, -choice, reachable[nxt]])
            if not reachable:
                self.cnf.append([])
                return
            self.at_most_one(list(reachable.values()))
            current = reachable
        if target not in current:
            self.cnf.append([])
        else:
            self.cnf.append([current[target]])

    def assumptions(self, matrix):
        n = self.problem.size
        if len(matrix) != n or any(len(row) != n for row in matrix):
            raise ValueError("Incorrect matrix dimensions")
        literals = []
        for i in range(n):
            for j in range(i, n):
                value = matrix[i][j]
                if matrix[j][i] != value:
                    raise ValueError("Assumptions require a symmetric matrix")
                if value not in self.entries[(i, j)]:
                    raise ValueError("Entry outside its encoded domain")
                for candidate, lit in self.entries[(i, j)].items():
                    literals.append(lit if candidate == value else -lit)
        return literals

    def decode(self, model):
        chosen = {lit for lit in model if lit > 0}
        n = self.problem.size
        matrix = [[None] * n for _ in range(n)]
        for (i, j), literals in self.entries.items():
            values = [value for value, lit in literals.items() if lit in chosen]
            if len(values) != 1:
                raise ValueError("Model does not select one entry value")
            matrix[i][j] = matrix[j][i] = values[0]
        return tuple(tuple(row) for row in matrix)

    def compile(self):
        return self.cnf


def z7_row_cnf():
    return RowProblemCNF(z7_problem())


class RowSelectionCNF:
    """Choose one generated row per index and forbid pairwise-incompatible pairs.

    The generated lists are part of the formula. A refutation of this CNF does
    not by itself prove that ``generate_rows`` listed every locally legal row.
    """

    def __init__(self, problem, domains):
        if not isinstance(problem, RowProblem):
            raise TypeError("Expected a RowProblem")
        n = problem.size
        if len(domains) != n:
            raise ValueError("Expected one domain per row")
        self.problem = problem
        self.domains = []
        for rows in domains:
            tuples = tuple(tuple(int(v) for v in row) for row in rows)
            if any(len(row) != n for row in tuples):
                raise ValueError("Row length does not match the problem")
            if len(tuples) != len(set(tuples)):
                raise ValueError("Row domain contains duplicates")
            self.domains.append(tuples)
        self.cnf = CNF()
        self.top_id = 0
        self.selectors = []
        for rows in self.domains:
            literals = [self.new_var() for _ in rows]
            self.selectors.append(literals)
            if not literals:
                self.cnf.append([])
                continue
            encoded = CardEnc.equals(lits=literals, bound=1, top_id=self.top_id,
                                     encoding=EncType.seqcounter)
            self.top_id = max(self.top_id, encoded.nv)
            self.cnf.extend(encoded.clauses)
        arrays = [np.asarray(rows, dtype=np.int32) for rows in self.domains]
        for i in range(n):
            for j in range(i + 1, n):
                self.add_pair(i, j, arrays[i], arrays[j])

    def new_var(self):
        self.top_id += 1
        return self.top_id

    def add_pair(self, i, j, left, right):
        if left.size == 0 or right.size == 0:
            return
        dots = left @ right.T
        entry = left[:, j][:, None]
        compatible = (right[:, i][None, :] == entry) & (dots + entry == self.problem.targets[i][j])
        selectors = self.selectors
        for row_id, matches in enumerate(compatible):
            clause = [-selectors[i][row_id]]
            clause.extend(selectors[j][index] for index in np.flatnonzero(matches))
            self.cnf.append(clause)

    def decode(self, model):
        chosen = {lit for lit in model if lit > 0}
        rows = []
        for selectors, domain in zip(self.selectors, self.domains):
            hits = [index for index, lit in enumerate(selectors) if lit in chosen]
            if len(hits) != 1:
                raise ValueError("Model does not select one row")
            rows.append(domain[hits[0]])
        return tuple(rows)

    def compile(self):
        return self.cnf
