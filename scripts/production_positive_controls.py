import contextlib
import io
import itertools
from pathlib import Path
import sys
from unittest.mock import patch

import numpy as np
from pysat.solvers import Cadical195

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from build_z2_f1_cnf import ConwayZ2F1Compiler
from scripts.build_z3_canonical_cnf import ConwayZ3FPFCanonicalCompiler

BVLS_SOURCE = "https://arxiv.org/html/1907.02800v2#S3.SS1"
BVLS_DIRECTIONS = (
    (1, 0, 0, 0, 0), (0, 0, 1, 0, 1), (0, 1, 0, 1, 0),
    (0, 1, 2, 0, 0), (0, 0, 1, 2, 1), (0, 1, 0, 1, 2),
    (1, 1, 2, 0, 2), (1, 0, 0, 1, 2), (1, 0, 2, 1, 0),
    (1, 1, 0, 0, 2), (1, 1, 2, 1, 0),
)


def verify_graph(adjacency, degree):
    adjacency = np.asarray(adjacency)
    n = len(adjacency)
    if adjacency.shape != (n, n) or not np.isin(adjacency, (0, 1)).all():
        raise ValueError("Expected a square binary adjacency matrix")
    adjacency = adjacency.astype(np.int64)
    if not np.array_equal(adjacency, adjacency.T) or np.diag(adjacency).any():
        raise ValueError("Expected a simple undirected graph")
    if not np.all(adjacency.sum(axis=1) == degree):
        raise ValueError("Incorrect degree")
    expected = (degree - 2) * np.eye(n, dtype=np.int64) + 2 * np.ones((n, n), dtype=np.int64)
    if not np.array_equal(adjacency @ adjacency + adjacency, expected):
        raise ValueError("The graph does not have lambda=1, mu=2")
    return True


def known_graph(name):
    if name == "paley9":
        directions = ((1, 0), (0, 1))
    elif name == "bvls243":
        directions = BVLS_DIRECTIONS
    else:
        raise ValueError(f"Unknown control: {name}")
    dimension = len(directions[0])
    vertices = list(itertools.product(range(3), repeat=dimension))
    connection = {tuple(sign * x % 3 for x in vector) for vector in directions for sign in (1, -1)}
    adjacency = np.array([
        [int(tuple((y - x) % 3 for x, y in zip(u, v)) in connection) for v in vertices]
        for u in vertices
    ], dtype=np.int64)
    degree = 2 * len(directions)
    verify_graph(adjacency, degree)
    return vertices, adjacency, degree


def inversion_order(vertices, adjacency):
    position = {vertex: i for i, vertex in enumerate(vertices)}
    negative = lambda vertex: tuple(-x % 3 for x in vertex)
    zero = (0,) * len(vertices[0])
    root = position[zero]
    neighbors = {vertices[i] for i in np.flatnonzero(adjacency[root])}
    representatives = sorted(vertex for vertex in neighbors if vertex < negative(vertex))
    ordered_neighbors = [vertex for rep in representatives for vertex in (rep, negative(rep))]
    coordinate_vertex = {}
    for i, vertex in enumerate(vertices):
        if vertex == zero or vertex in neighbors:
            continue
        support = frozenset(j + 1 for j, neighbor in enumerate(ordered_neighbors) if adjacency[i, position[neighbor]])
        if len(support) != 2 or support in coordinate_vertex:
            raise ValueError("Outer coordinates are not a bijection")
        coordinate_vertex[support] = vertex
    pairs = list(itertools.combinations(range(len(representatives)), 2))
    ordered_outer = []
    for crossed in (False, True):
        for r, s in pairs:
            support = frozenset((1 + 2 * r, 1 + 2 * s + int(crossed)))
            vertex = coordinate_vertex[support]
            ordered_outer.extend((vertex, negative(vertex)))
    order = [position[vertex] for vertex in [zero] + ordered_neighbors + ordered_outer]
    if len(order) != len(vertices) or len(set(order)) != len(vertices):
        raise ValueError("Inversion relabeling is not a permutation")
    permutation = [position[negative(vertex)] for vertex in vertices]
    if not np.array_equal(adjacency[np.ix_(permutation, permutation)], adjacency):
        raise ValueError("Inversion does not preserve adjacency")
    if sum(i == j for i, j in enumerate(permutation)) != 1:
        raise ValueError("Inversion must have exactly one fixed vertex")
    return order


def translation_order(vertices, adjacency, triangle=True):
    position = {vertex: i for i, vertex in enumerate(vertices)}
    zero = (0,) * len(vertices[0])
    root = position[zero]
    shift_index = next(i for i in range(len(vertices)) if i != root and bool(adjacency[root, i]) == triangle)
    shift = vertices[shift_index]
    translate = lambda vertex: tuple((x + y) % 3 for x, y in zip(vertex, shift))
    permutation = [position[translate(vertex)] for vertex in vertices]
    if any(i == j or permutation[permutation[j]] != i for i, j in enumerate(permutation)):
        raise ValueError("Translation must be fixed-point-free of order three")
    if not np.array_equal(adjacency[np.ix_(permutation, permutation)], adjacency):
        raise ValueError("Translation does not preserve adjacency")
    seen = set()
    orbits = []
    for vertex in vertices:
        if vertex in seen:
            continue
        orbit = (vertex, translate(vertex), translate(translate(vertex)))
        seen.update(orbit)
        orbits.append(tuple(position[v] for v in orbit))
    orbits.sort(key=lambda orbit: (-int(adjacency[orbit[0], orbit[1]]), orbit))
    return [v for orbit in orbits for v in orbit]


class PlantedClauseSink:
    def __init__(self, values):
        self.values = dict(values)
        self.clauses = self
        self.count = 0
        self.pending = []
        self.retired_top = max(values, default=0)
        self.checked = 0

    def __len__(self):
        return self.count

    def append(self, clause):
        clause = list(clause)
        if any(not isinstance(lit, int) or lit == 0 for lit in clause):
            raise ValueError("Invalid DIMACS literal")
        self.pending.append(clause)
        self.count += 1

    def extend(self, clauses):
        for clause in clauses:
            self.append(clause)
        self.flush()

    def flush(self):
        if not self.pending:
            return
        if any(not clause for clause in self.pending):
            raise ValueError("Production clauses contain an empty clause")
        variables = sorted({abs(lit) for clause in self.pending for lit in clause})
        unknown = set(variables).difference(self.values)
        if any(var <= self.retired_top for var in unknown):
            raise ValueError("A discarded auxiliary variable was reused")
        local = {var: i + 1 for i, var in enumerate(variables)}
        clauses = [[local[abs(lit)] if lit > 0 else -local[abs(lit)] for lit in clause] for clause in self.pending]
        assumptions = [local[var] if self.values[var] else -local[var] for var in variables if var in self.values]
        with Cadical195(bootstrap_with=clauses) as solver:
            if not solver.solve(assumptions=assumptions):
                raise ValueError("Production clauses reject the planted graph")
            model = set(solver.get_model() or [])
            if any(lit not in model for lit in assumptions):
                raise ValueError("Solver model violates the planted assignment")
            if any(not any(lit in model for lit in clause) for clause in clauses):
                raise ValueError("Solver model violates an emitted clause")
        self.checked += len(self.pending)
        self.retired_top = max([self.retired_top] + variables)
        self.pending.clear()


def check_planted(name, action, triangle=True):
    vertices, adjacency, degree = known_graph(name)
    if action == "z2-f1":
        order = inversion_order(vertices, adjacency)
        compiler = ConwayZ2F1Compiler(degree=degree)
        expected = adjacency[np.ix_(order, order)]
        values = {}
        offset = degree + 1
        for p in range(compiler.num_outer_orbits):
            for q in range(compiler.num_outer_orbits):
                u = offset + 2 * p
                v = offset + 2 * q + int(p >= q)
                values[compiler.var_id(p, q)] = bool(expected[u, v])
        reconstructed = compiler.reconstruct_adjacency({var for var, value in values.items() if value})
        if not np.array_equal(reconstructed, expected):
            raise ValueError("Production decoding disagrees with the independent graph")
        conjunction = "get_and_var"
        compile_call = compiler.build_constraints
    elif action == "z3-fpf":
        order = translation_order(vertices, adjacency, triangle=triangle)
        expected = adjacency[np.ix_(order, order)]
        compiler = ConwayZ3FPFCanonicalCompiler(num_orbits=len(vertices) // 3, degree=degree)
        values = {var: bool(expected[3 * p, 3 * p + 1]) for p, var in compiler.t_vars.items()}
        values.update({var: bool(expected[3 * p, 3 * q + d]) for (p, q, d), var in compiler.edge_vars.items()})
        for u in range(len(vertices)):
            for v in range(len(vertices)):
                literal = compiler.get_adj_lit(u // 3, u % 3, v // 3, v % 3)
                if bool(values.get(literal, False)) != bool(expected[u, v]):
                    raise ValueError("Production adjacency map disagrees with the independent graph")
        conjunction = "get_and_lit"
        compile_call = lambda: compiler.compile(verbose=False)
    else:
        raise ValueError(f"Unknown action: {action}")
    primary_count = len(values)
    if set(values) != set(range(1, compiler.top_id + 1)):
        raise ValueError("The planted assignment does not cover all primary variables")
    sink = PlantedClauseSink(values)
    compiler.cnf = sink
    original = getattr(compiler, conjunction)

    def evaluate_and(a, b):
        value_a = False if a == 0 else sink.values[abs(a)] == (a > 0)
        value_b = False if b == 0 else sink.values[abs(b)] == (b > 0)
        value = value_a and value_b
        result = original(a, b)
        if result == 0:
            if value:
                raise ValueError("Incorrect false conjunction")
        else:
            if abs(result) <= sink.retired_top and abs(result) not in sink.values:
                raise ValueError("Conjunction reuses a discarded auxiliary variable")
            result_value = value if result > 0 else not value
            if abs(result) in sink.values and sink.values[abs(result)] != result_value:
                raise ValueError("Conjunction aliases an incompatible variable")
            sink.values[abs(result)] = result_value
        return result

    with patch.object(compiler, conjunction, evaluate_and), contextlib.redirect_stdout(io.StringIO()):
        compile_call()
    sink.flush()
    if sink.checked != sink.count:
        raise ValueError("Not all emitted clauses were checked")
    return {"status": "COMPILED", "graph": name, "action": action,
            "vertices": len(vertices), "degree": degree, "primary_variables": primary_count,
            "clauses_checked": sink.checked, "variables": compiler.top_id,
            "scope": "All emitted production clauses admit the fixed independent graph; auxiliary extensions checked in disjoint batches."}
