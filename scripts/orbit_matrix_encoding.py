from itertools import product

from pysat.card import CardEnc, EncType
from pysat.formula import CNF


def verify_quotient(matrix, sizes, degree, lam, mu, fixed=None, domains=None):
    count = len(sizes)
    if len(matrix) != count or any(len(row) != count for row in matrix):
        raise ValueError("Incorrect quotient dimensions")
    for i, j in product(range(count), repeat=2):
        value = matrix[i][j]
        if type(value) is not int or not 0 <= value <= sizes[j] - int(i == j):
            raise ValueError("Invalid quotient entry")
        if sizes[i] * value != sizes[j] * matrix[j][i]:
            raise ValueError("Weighted symmetry violated")
        if (i, j) in (fixed or {}) and value != fixed[i, j]:
            raise ValueError("Fixed quotient entry violated")
        if (i, j) in (domains or {}) and value not in domains[i, j]:
            raise ValueError("Quotient entry outside the declared domain")
        lhs = sum(matrix[i][r] * matrix[r][j] for r in range(count)) + (mu - lam) * value
        rhs = (degree - mu) * int(i == j) + mu * sizes[j]
        if lhs != rhs:
            raise ValueError("SRG quotient equation violated")
    if any(sum(row) != degree for row in matrix):
        raise ValueError("Quotient row sum violated")
    return True


def quotient_from_graph(adjacency, orbits):
    vertices = [vertex for orbit in orbits for vertex in orbit]
    if sorted(vertices) != list(range(len(adjacency))) or any(not orbit for orbit in orbits):
        raise ValueError("Orbits must partition the vertices")
    matrix = []
    for source in orbits:
        row = []
        for target in orbits:
            counts = {sum(int(adjacency[u][v]) for v in target) for u in source}
            if len(counts) != 1:
                raise ValueError("Partition is not equitable")
            row.append(counts.pop())
        matrix.append(row)
    return matrix


def z7_specification():
    fixed = {(i, j): 0 for i in range(15) for j in range(15) if i == 0 or j == 0}
    fixed.update({(0, 1): 7, (0, 2): 7, (1, 0): 1, (2, 0): 1,
                  (1, 1): 0, (2, 2): 0, (1, 2): 1, (2, 1): 1})
    for i in range(3, 15):
        left = 2 if i < 6 else 0 if i < 9 else 1
        fixed[1, i] = fixed[i, 1] = left
        fixed[2, i] = fixed[i, 2] = 2 - left
    domains = {(i, j): ((0, 2) if i == j else tuple(range(5)))
               for i in range(3, 15) for j in range(3, 15)}
    return {"sizes": (1,) + (7,) * 14, "degree": 14, "lam": 1, "mu": 2,
            "fixed": fixed, "domains": domains}


class OrbitMatrixCNF:
    def __init__(self, sizes, degree, lam, mu, fixed=None, domains=None):
        if not sizes or any(type(size) is not int or size < 1 for size in sizes):
            raise ValueError("Orbit sizes must be positive integers")
        if any(type(value) is not int or value < 0 for value in (degree, lam, mu)):
            raise ValueError("SRG parameters must be nonnegative integers")
        self.sizes = tuple(sizes)
        self.degree, self.lam, self.mu = degree, lam, mu
        self.fixed, self.domains = dict(fixed or {}), dict(domains or {})
        self.cnf = CNF()
        self.top_id = 0
        self.entries = {}
        self.and_cache = {}
        self.compiled = False
        count = len(sizes)
        if any(not 0 <= i < count or not 0 <= j < count for i, j in self.fixed.keys() | self.domains.keys()):
            raise ValueError("Entry index outside the matrix")
        for i, j in product(range(count), repeat=2):
            domain = tuple(self.domains.get((i, j), range(sizes[j] + 1 - int(i == j))))
            if not domain or any(type(value) is not int or value < 0 or value > sizes[j] - int(i == j) for value in domain):
                raise ValueError("Invalid entry domain")
            if (i, j) in self.fixed:
                value = self.fixed[i, j]
                if type(value) is not int or value not in domain:
                    raise ValueError("Fixed entry outside its domain")
                self.entries[i, j] = (True,) * value
            elif i > j and sizes[i] == sizes[j] and (j, i) not in self.fixed and domain == tuple(self.domains.get((j, i), range(sizes[i] + 1))):
                self.entries[i, j] = self.entries[j, i]
            else:
                thresholds = tuple(self.new_variable() for _ in range(max(domain)))
                self.entries[i, j] = thresholds
                for lower, upper in zip(thresholds, thresholds[1:]):
                    self.cnf.append([-upper, lower])
                for value in set(range(max(domain) + 1)).difference(domain):
                    clause = ([] if value == 0 else [-thresholds[value - 1]])
                    if value < len(thresholds):
                        clause.append(thresholds[value])
                    self.cnf.append(clause)
        self.primary_variables = self.top_id

    def new_variable(self):
        self.top_id += 1
        return self.top_id

    @staticmethod
    def negate(literal):
        return not literal if type(literal) is bool else -literal

    def conjunction(self, a, b):
        if a is False or b is False:
            return False
        if a is True:
            return b
        if b is True or a == b:
            return a
        if a == -b:
            return False
        key = tuple(sorted((a, b)))
        if key not in self.and_cache:
            value = self.new_variable()
            self.cnf.extend([[-value, a], [-value, b], [value, -a, -b]])
            self.and_cache[key] = value
        return self.and_cache[key]

    def linear_equals(self, terms, bound):
        literals = []
        for literal, coefficient in terms:
            if literal is True:
                bound -= coefficient
            elif literal is False:
                continue
            elif coefficient < 0:
                literals.extend([-literal] * -coefficient)
                bound -= coefficient
            else:
                literals.extend([literal] * coefficient)
        if bound < 0 or bound > len(literals):
            self.cnf.append([])
        elif not literals:
            return
        else:
            encoded = CardEnc.equals(lits=literals, bound=bound, top_id=self.top_id, encoding=EncType.seqcounter)
            self.top_id = max(self.top_id, encoded.nv)
            self.cnf.extend(encoded.clauses)

    def compile(self):
        if self.compiled:
            raise ValueError("This quotient has already been compiled")
        self.compiled = True
        count = len(self.sizes)
        for i in range(count):
            self.linear_equals(((literal, 1) for j in range(count) for literal in self.entries[i, j]), self.degree)
        for i in range(count):
            for j in range(i + 1, count):
                if self.entries[i, j] is self.entries[j, i] and self.sizes[i] == self.sizes[j]:
                    continue
                self.linear_equals(
                    [(literal, self.sizes[i]) for literal in self.entries[i, j]] +
                    [(literal, -self.sizes[j]) for literal in self.entries[j, i]], 0)
        for i in range(count):
            for j in range(i, count):
                terms = [(self.conjunction(a, b), 1) for r in range(count)
                         for a in self.entries[i, r] for b in self.entries[r, j]]
                terms.extend((literal, self.mu - self.lam) for literal in self.entries[i, j])
                bound = (self.degree - self.mu) * int(i == j) + self.mu * self.sizes[j]
                self.linear_equals(terms, bound)
        return self.cnf

    def assumptions(self, matrix):
        if len(matrix) != len(self.sizes) or any(len(row) != len(self.sizes) for row in matrix):
            raise ValueError("Incorrect matrix dimensions")
        result = []
        for (i, j), thresholds in self.entries.items():
            value = matrix[i][j]
            if type(value) is not int or value < 0 or value > len(thresholds):
                raise ValueError("Entry outside its encoded bounds")
            for index, literal in enumerate(thresholds):
                if type(literal) is bool:
                    if literal != (index < value):
                        raise ValueError("Fixed entry mismatch")
                else:
                    result.append(literal if index < value else -literal)
        return result

    def decode(self, model):
        values = set(model)
        count = len(self.sizes)
        matrix = [[sum(literal is True or (type(literal) is int and literal in values)
                       for literal in self.entries[i, j]) for j in range(count)] for i in range(count)]
        verify_quotient(matrix, self.sizes, self.degree, self.lam, self.mu, self.fixed, self.domains)
        return matrix
