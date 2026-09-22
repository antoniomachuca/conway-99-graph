import argparse
from collections import Counter
from datetime import datetime, timezone
import hashlib
from importlib.metadata import version
import itertools
import json
from pathlib import Path
import subprocess
import sys
from unittest.mock import patch

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

import build_z2_f1_cnf as model

PARTNERS = {"A": 21, "B": 1, "C": 11}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def sha256_file(path):
    digest = hashlib.sha256()
    with Path(path).open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def audit_geometry(compiler):
    coordinates = compiler.nbrs_N
    expected = {frozenset((a, b)) for a, b in itertools.combinations(range(1, 15), 2)
                if (a - 1) // 2 != (b - 1) // 2}
    require(set(coordinates) == set(itertools.product(range(42), range(2))), "Invalid outer labels")
    require(len({frozenset(v) for v in coordinates.values()}) == 84, "Repeated coordinates")
    require({frozenset(v) for v in coordinates.values()} == expected, "Invalid coordinate coverage")
    for p in range(42):
        opposite = {a + 1 if a % 2 else a - 1 for a in coordinates[(p, 0)]}
        require(coordinates[(p, 1)] == opposite, "Coordinates do not respect the involution")
    for a in range(1, 15):
        inverse = {u for u, neighbors in coordinates.items() if a in neighbors}
        require(len(inverse) == 12 and set(compiler.nbrs_G2_of_N[a]) == inverse, "Invalid inverse incidence")
    fixed = compiler.reconstruct_adjacency(set())
    target = 12 * np.eye(99, dtype=int) + 2 * np.ones((99, 99), dtype=int)
    equation = fixed @ fixed + fixed
    require(np.array_equal(fixed, fixed.T) and not np.diag(fixed).any(), "Invalid fixed adjacency")
    require(np.array_equal(equation[:15, :15], target[:15, :15]), "Fixed pair equations fail")
    require(np.array_equal(equation[0], target[0]), "Root equations fail")
    require(np.all(fixed.sum(axis=1)[15:] == 2), "Outer fixed degree is not two")
    return {"outer_coordinates": 84, "fixed_vertex_degrees": fixed.sum(axis=1)[:15].tolist()}


def audit_stabilizer(compiler, representatives=None):
    representatives = PARTNERS if representatives is None else representatives
    lookup = {frozenset(neighbors): vertex for vertex, neighbors in compiler.nbrs_N.items()}
    generators = []
    for a, b in [(0, 1)] + [(i, i + 1) for i in range(2, 6)]:
        permutation = list(range(7))
        permutation[a], permutation[b] = permutation[b], permutation[a]
        generators.append((permutation, set()))
    generators.extend((list(range(7)), flips) for flips in [{0, 1}] + [{r} for r in range(2, 7)])
    images = []
    for permutation, flips in generators:
        image = []
        for p in range(42):
            mapped = []
            for bit in range(2):
                neighbors = {1 + 2 * permutation[(a - 1) // 2] + (((a - 1) % 2) ^ ((a - 1) // 2 in flips))
                             for a in compiler.nbrs_N[(p, bit)]}
                mapped.append(lookup[frozenset(neighbors)])
            require(mapped[0][0] == mapped[1][0] and mapped[0][1] != mapped[1][1], "Invalid orbit action")
            image.append(mapped[0][0])
        require(image[0] == 0 and set(image) == set(range(42)), "Not a stabilizer permutation")
        images.append(image)
    remaining = set(range(42))
    suborbits = []
    while remaining:
        orbit = {min(remaining)}
        frontier = list(orbit)
        while frontier:
            point = frontier.pop()
            for image in images:
                if image[point] not in orbit:
                    orbit.add(image[point])
                    frontier.append(image[point])
        suborbits.append(orbit)
        remaining -= orbit
    require(sorted(map(len, suborbits)) == [1, 1, 20, 20], "Unexpected stabilizer suborbits")
    for orbit in suborbits:
        if orbit != {0}:
            require(len(orbit.intersection(representatives.values())) == 1, "Branch representatives do not cover suborbits")
    return {"suborbit_sizes": sorted(map(len, suborbits)), "representatives": representatives}


def expected_cuts(partner):
    require(partner in range(1, 42), "Invalid partner")
    return [[1 + partner], [1 + 42 * partner]] + [
        [-(1 + q), -(1 + 42 * q)] for q in range(1, 42) if q != partner
    ]


def read_cuts(path, partner):
    clauses = []
    for line in Path(path).read_text().splitlines():
        if not line.strip() or line.lstrip().startswith("c"):
            continue
        values = [int(value) for value in line.split()]
        require(values[-1] == 0 and 0 not in values[:-1], "Invalid clause terminator")
        clauses.append(values[:-1])
    require(clauses == expected_cuts(partner), "Unexpected branch cut clauses")
    return clauses


def compile_recorded():
    compiler = model.ConwayZ2F1Compiler()
    equations = []
    original = model.CardEnc.equals

    def record(*args, **kwargs):
        equations.append((tuple(kwargs["lits"]), kwargs["bound"]))
        return original(*args, **kwargs)

    with patch.object(model.CardEnc, "equals", side_effect=record):
        compiler.build_constraints()
    return compiler, equations


def audit_equations(compiler, equations):
    require(len(equations) == 2394, "Missing or additional cardinality constraint")
    diagonal = {1 + 43 * p for p in range(42)}
    require(compiler.cnf.clauses[:42] == [[-value] for value in sorted(diagonal)], "Internal-edge units differ")
    fixed = compiler.reconstruct_adjacency(set())
    adjacency = [[() if fixed[u, v] else None for v in range(99)] for u in range(99)]
    for u in range(15, 99):
        p, bit_u = divmod(u - 15, 2)
        for v in range(15, 99):
            q, bit_v = divmod(v - 15, 2)
            if p != q:
                row, column = (min(p, q), max(p, q)) if bit_u == bit_v else (max(p, q), min(p, q))
                adjacency[u][v] = (1 + 42 * row + column,)
    gates = {value: pair for pair, value in compiler.aux_and.items()}

    def normalize(poly):
        return {term: count for term, count in poly.items() if count}

    def common_equation(u, v):
        terms = [adjacency[u][v]]
        for w in range(99):
            a, b = adjacency[u][w], adjacency[w][v]
            if a is not None and b is not None:
                terms.append(tuple(sorted(set(a + b))))
        result = Counter(term for term in terms if term is not None)
        result[()] -= 2
        return result

    expected = []
    for p in range(42):
        degree = Counter(term for term in adjacency[15 + 2 * p] if term is not None)
        degree[()] -= 14
        expected.append((degree, 1))
    expected.extend((common_equation(15 + 2 * p, 16 + 2 * p), 2) for p in range(42))
    expected.extend((common_equation(a, 15 + 2 * p), 1) for a in range(1, 15) for p in range(42))
    expected.extend((common_equation(15 + 2 * p, 15 + 2 * q + bit), 1)
                    for p in range(42) for q in range(p + 1, 42) for bit in range(2))
    for index, ((literals, bound), (reference, factor)) in enumerate(zip(equations, expected)):
        actual = Counter()
        for literal in literals:
            require(literal > 0, "Unexpected signed cardinality input")
            term = (literal,) if literal <= 1764 else gates[literal]
            if not diagonal.intersection(term):
                actual[tuple(sorted(set(term)))] += factor
        actual[()] -= factor * bound
        require(normalize(actual) == normalize(reference), f"Symbolic constraint {index} differs from adjacency equations")
    return len(equations)


def dimacs_lines(compiler, cuts=()):
    yield f"p cnf {compiler.cnf.nv} {len(compiler.cnf.clauses) + len(cuts)}\n"
    for clause in itertools.chain(compiler.cnf.clauses, cuts):
        yield " ".join(map(str, clause)) + " 0\n"


def generated_hash(compiler, cuts=()):
    digest = hashlib.sha256()
    for line in dimacs_lines(compiler, cuts):
        digest.update(line.encode("ascii"))
    return digest.hexdigest()


def audit_local_files(compiler, cuts):
    files = {"base": (ROOT / "conway_z2_f1.cnf", [])}
    files.update({name: (ROOT / "instances" / f"conway_z2_f1_branch_{name.lower()}.cnf", clauses)
                  for name, clauses in cuts.items()})
    result = {}
    for name, (path, clauses) in files.items():
        actual = sha256_file(path)
        regenerated = generated_hash(compiler, clauses)
        require(actual == regenerated, f"Regenerated {name} differs: stored={actual}, generated={regenerated}")
        result[name] = {"path": str(path), "sha256": actual, "bytes": path.stat().st_size,
                        "variables": compiler.cnf.nv, "clauses": len(compiler.cnf.clauses) + len(clauses)}
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--prepare-under", type=Path)
    parser.add_argument("--branch", choices=PARTNERS, default="C")
    args = parser.parse_args()
    compiler, equations = compile_recorded()
    report = {"classification": "COMPILED", "geometry": audit_geometry(compiler),
              "stabilizer": audit_stabilizer(compiler), "symbolic_constraints_checked": audit_equations(compiler, equations)}
    cuts = {name: expected_cuts(partner) for name, partner in PARTNERS.items()}
    stored_cuts = {name: read_cuts(ROOT / f"cuts_branch_{name.lower()}.cnf", PARTNERS[name]) for name in ("A", "B")}
    stored_c_partner = PARTNERS["C"]
    try:
        stored_cuts["C"] = read_cuts(ROOT / "cuts_branch_c.cnf", stored_c_partner)
    except ValueError:
        stored_c_partner = 10
        stored_cuts["C"] = read_cuts(ROOT / "cuts_branch_c.cnf", stored_c_partner)
    report["artifacts"] = audit_local_files(compiler, stored_cuts)
    report["stored_branch_C"] = {"partner": stored_c_partner, "support": compiler.orbit_pairs[stored_c_partner],
                                 "disjoint": not bool(set(compiler.orbit_pairs[0]) & set(compiler.orbit_pairs[stored_c_partner]))}
    report["generated_branches"] = {name: {"partner": PARTNERS[name], "sha256": generated_hash(compiler, clauses)}
                                    for name, clauses in cuts.items()}
    report["selected_branch"] = args.branch
    report["python_sat_version"] = version("python-sat")
    report["python_version"] = sys.version
    report["git_revision"] = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip()
    sources = ["build_z2_f1_cnf.py", "build_z3_fpf_cnf.py", "scripts/generate_branches_cnf.py",
               "scripts/validate_z2_f1_inputs.py", "scripts/classify_z2_f1_incidence_matrix.py",
               "scripts/run_bounded_local_search.py", "tests/test_canonical_sat_compilers.py",
               "tests/test_z2_f1_input_audit.py", "tests/test_bounded_local_search.py"]
    sources.extend(f"cuts_branch_{name.lower()}.cnf" for name in PARTNERS)
    report["source_sha256"] = {name: sha256_file(ROOT / name) for name in sources}
    report["boundary"] = "Checks are relative to the f=1 coordinate model; not a Lean proof or a DRAT refutation. No remote provenance checked."
    if args.prepare_under:
        parent = args.prepare_under.resolve(strict=True)
        directory = parent / (f"f1_{args.branch.lower()}_drat_" + datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ"))
        directory.mkdir()
        with (directory / "input.cnf").open("x", encoding="ascii") as stream:
            stream.writelines(dimacs_lines(compiler, cuts[args.branch]))
        require(sha256_file(directory / "input.cnf") == report["generated_branches"][args.branch]["sha256"], "Snapshot hash differs")
        for name, clauses in cuts.items():
            with (directory / f"cuts_branch_{name.lower()}.cnf").open("x", encoding="ascii") as stream:
                stream.writelines(" ".join(map(str, clause)) + " 0\n" for clause in clauses)
        for name, digest in report["source_sha256"].items():
            snapshot = directory / "sources" / name
            snapshot.parent.mkdir(parents=True, exist_ok=True)
            with snapshot.open("xb") as stream:
                stream.write((ROOT / name).read_bytes())
            require(sha256_file(snapshot) == digest, f"Source snapshot differs: {name}")
        report["session_directory"] = str(directory)
        report["source_snapshot_directory"] = str(directory / "sources")
        report["git_worktree_status"] = subprocess.check_output(["git", "status", "--short"], cwd=ROOT, text=True)
        with (directory / "validation.json").open("x") as stream:
            json.dump(report, stream, indent=2)
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
