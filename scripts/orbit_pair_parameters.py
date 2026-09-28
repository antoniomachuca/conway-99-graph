#!/usr/bin/env python3
"""Local common-neighbor table for the 42 orbits of an involution with one fixed vertex.

EXPLORED. This is a finite enumeration in the coordinate model of
build_z2_f1_cnf.py. It does not call a SAT solver and it does not certify a
graph-level theorem.

For vertices u, v in Gamma_2(x_0), x_0 is not a common neighbor. If N(u) and
N(v) meet in c vertices, an edge demands 1 - c further common neighbors in
Gamma_2 and a non-edge demands 2 - c. A negative demand makes that relation
impossible.
"""

from collections import defaultdict
import itertools
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from build_z2_f1_cnf import ConwayZ2F1Compiler
from scripts.validate_z2_f1_inputs import PARTNERS

ORBITAL_NAME = {2: "same_support", 1: "intersecting", 0: "disjoint"}
RELATION_NAMES = ("K22", "M0", "M1", "empty")


def require(condition, message):
    if not condition:
        raise ValueError(message)


def support_pairs():
    pairs = list(itertools.combinations(range(7), 2))
    require(len(pairs) == 21, "K_7 must have 21 edges")
    return pairs


def orbit_index(pair_index, phase):
    return pair_index + 21 * phase


def decode_orbit(index, pairs):
    phase, pair_index = divmod(index, 21)
    return pairs[pair_index], phase


def apply_element(index, perm, signs, pairs, pair_index):
    support, phase = decode_orbit(index, pairs)
    r1, r2 = support
    new_phase = phase ^ signs[r1] ^ signs[r2]
    image = tuple(sorted((perm[r1], perm[r2])))
    return orbit_index(pair_index[image], new_phase)


def full_generators():
    generators = []
    for i in range(6):
        perm = list(range(7))
        perm[i], perm[i + 1] = perm[i + 1], perm[i]
        generators.append((tuple(perm), (0,) * 7))
    for root in range(7):
        signs = [0] * 7
        signs[root] = 1
        generators.append((tuple(range(7)), tuple(signs)))
    return generators


def stabilizer_generators():
    """Generators inside W that fix the positive orbit of support {0, 1}.

    These are the transformations recorded in classify_z2_f1_incidence_matrix:
    S_5 on the other five roots, the swap of the two support roots, the joint
    sign flip of those two roots, and the five individual sign flips outside.
    """
    generators = []
    for i in range(2, 6):
        perm = list(range(7))
        perm[i], perm[i + 1] = perm[i + 1], perm[i]
        generators.append((tuple(perm), (0,) * 7))
    perm = list(range(7))
    perm[0], perm[1] = 1, 0
    generators.append((tuple(perm), (0,) * 7))
    generators.append((tuple(range(7)), (1, 1, 0, 0, 0, 0, 0)))
    for root in range(2, 7):
        signs = [0] * 7
        signs[root] = 1
        generators.append((tuple(range(7)), tuple(signs)))
    return generators


def multiply(second, first):
    """Compose coordinate symmetries, applying first and then second."""
    perm1, signs1 = first
    perm2, signs2 = second
    perm = tuple(perm2[perm1[i]] for i in range(7))
    signs = tuple(signs1[i] ^ signs2[perm1[i]] for i in range(7))
    return perm, signs


def close_abstract_group(generators):
    identity = (tuple(range(7)), (0,) * 7)
    seen = {identity}
    frontier = [identity]
    while frontier:
        current = frontier.pop()
        for generator in generators:
            image = multiply(generator, current)
            if image not in seen:
                seen.add(image)
                frontier.append(image)
    return seen


def induced_permutation(element, pairs, pair_index):
    perm, signs = element
    return tuple(apply_element(i, perm, signs, pairs, pair_index) for i in range(42))


def neighborhood_image(compiler, index, perm, signs, lookup):
    images = []
    for bit in (0, 1):
        mapped = set()
        for vertex in compiler.nbrs_N[(index, bit)]:
            root = (vertex - 1) // 2
            old_bit = (vertex - 1) % 2
            mapped.add(1 + 2 * perm[root] + (old_bit ^ signs[root]))
        images.append(lookup[frozenset(mapped)])
    require(images[0][0] == images[1][0] and images[0][1] != images[1][1], "Symmetry splits an orbit")
    return images[0][0]


def check_label_action(compiler, generators, pairs, pair_index):
    lookup = {frozenset(neighbors): vertex for vertex, neighbors in compiler.nbrs_N.items()}
    for perm, signs in generators:
        for index in range(42):
            label = apply_element(index, perm, signs, pairs, pair_index)
            geometric = neighborhood_image(compiler, index, perm, signs, lookup)
            require(label == geometric, "Orbit-label action disagrees with N(x_0)")


def common_neighbor_count(compiler, left, right):
    return len(compiler.nbrs_N[left].intersection(compiler.nbrs_N[right]))


def cross_counts(compiler, left_orbit, right_orbit):
    return tuple(
        common_neighbor_count(compiler, (left_orbit, left_bit), (right_orbit, right_bit))
        for left_bit in (0, 1)
        for right_bit in (0, 1)
    )


def normalized_counts(counts):
    matrix = [[counts[0], counts[1]], [counts[2], counts[3]]]
    candidates = []
    for swap_rows in (False, True):
        for swap_columns in (False, True):
            for transpose in (False, True):
                rows = [list(row) for row in matrix]
                if swap_rows:
                    rows[0], rows[1] = rows[1], rows[0]
                if swap_columns:
                    for row in rows:
                        row[0], row[1] = row[1], row[0]
                if transpose:
                    rows = [[rows[0][0], rows[1][0]], [rows[0][1], rows[1][1]]]
                candidates.append((rows[0][0], rows[0][1], rows[1][0], rows[1][1]))
    return min(candidates)


def demands(counts, adjacent):
    """Return the four Gamma_2 demands, or None when one of them is negative."""
    required = []
    for seen, is_edge in zip(counts, adjacent):
        demand = (1 if is_edge else 2) - seen
        if demand < 0:
            return None
        required.append(demand)
    return tuple(required)


RELATION_EDGES = {
    "K22": (True, True, True, True),
    "M0": (True, False, False, True),
    "M1": (False, True, True, False),
    "empty": (False, False, False, False),
}


def classify_pair(counts):
    relations = {}
    for name, adjacent in RELATION_EDGES.items():
        required = demands(counts, adjacent)
        relations[name] = {"possible": required is not None, "demands": required}
    simple_possible = relations["M0"]["possible"] or relations["M1"]["possible"]
    relations["simple_matching"] = {
        "possible": simple_possible,
        "M0": relations["M0"]["possible"],
        "M1": relations["M1"]["possible"],
    }
    return relations


def support_intersection(left, right, pairs):
    left_support, _ = decode_orbit(left, pairs)
    right_support, _ = decode_orbit(right, pairs)
    return len(set(left_support).intersection(right_support))


def pair_orbitals(compiler, pairs, pair_index):
    generators = [induced_permutation(element, pairs, pair_index) for element in full_generators()]
    unordered = list(itertools.combinations(range(42), 2))
    position = {pair: i for i, pair in enumerate(unordered)}
    parent = list(range(len(unordered)))

    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    def union(i, j):
        ri, rj = find(i), find(j)
        if ri != rj:
            parent[ri] = rj

    for permutation in generators:
        for left, right in unordered:
            image = tuple(sorted((permutation[left], permutation[right])))
            union(position[(left, right)], position[image])

    grouped = defaultdict(list)
    for pair in unordered:
        grouped[find(position[pair])].append(pair)

    orbitals = []
    for members in grouped.values():
        intersections = {support_intersection(left, right, pairs) for left, right in members}
        require(len(intersections) == 1, "A W-orbit mixes support-intersection types")
        intersection = intersections.pop()
        fingerprints = {}
        possibilities = {}
        for left, right in members:
            counts = cross_counts(compiler, left, right)
            fingerprint = normalized_counts(counts)
            relations = classify_pair(counts)
            possibility = tuple(relations[name]["possible"] for name in ("K22", "simple_matching", "empty"))
            fingerprints[fingerprint] = fingerprints.get(fingerprint, 0) + 1
            possibilities[possibility] = possibilities.get(possibility, 0) + 1
        require(len(fingerprints) == 1, "Common-neighbor pattern is not constant on a W-orbit")
        require(len(possibilities) == 1, "Relation feasibility is not constant on a W-orbit")
        fingerprint = next(iter(fingerprints))
        sample = min(members)
        sample_counts = cross_counts(compiler, *sample)
        orbitals.append({
            "name": ORBITAL_NAME[intersection],
            "size": len(members),
            "support_intersection": intersection,
            "cn_normalized": fingerprint,
            "representative": {"orbits": sample, "counts": sample_counts, "relations": classify_pair(sample_counts)},
            "relations": {
                "K22": {"possible": possibility[0]},
                "simple_matching": {"possible": possibility[1]},
                "empty": {"possible": possibility[2]},
            },
        })
    orbitals.sort(key=lambda item: -item["support_intersection"])
    require([item["size"] for item in orbitals] == [21, 420, 420], "Unexpected W-orbit sizes on pairs")
    require(sum(item["size"] for item in orbitals) == 861, "Pair orbits do not cover every unordered pair")
    return orbitals


def stabilizer_orders(pairs, pair_index):
    elements = close_abstract_group(stabilizer_generators())
    permutations = defaultdict(int)
    for element in elements:
        permutations[induced_permutation(element, pairs, pair_index)] += 1
    kernel = permutations[tuple(range(42))]
    faithful = set(permutations)
    require(all(perm[0] == 0 for perm in faithful), "Recorded stabilizer moves orbit 0")
    require(all(perm[21] == 21 for perm in faithful), "Recorded stabilizer moves the twin orbit")

    def orbit_size(point):
        return len({perm[point] for perm in faithful})

    orbits = {}
    for point in range(42):
        orbits.setdefault(frozenset(perm[point] for perm in faithful), point)
    sizes = sorted(len(orbit) for orbit in orbits)
    require(sizes == [1, 1, 20, 20], "Faithful stabilizer suborbits are not 1,1,20,20")
    return {
        "abstract_order": len(elements),
        "faithful_order": len(faithful),
        "kernel_order": kernel,
        "suborbit_sizes": sizes,
        "partner_orbit_sizes": {name: orbit_size(partner) for name, partner in PARTNERS.items()},
    }


def build_report():
    compiler = ConwayZ2F1Compiler()
    pairs = support_pairs()
    pair_index = {pair: i for i, pair in enumerate(pairs)}
    require(compiler.orbit_pairs == pairs + pairs, "Compiler orbit order is not the duplicated K_7 edge list")
    neighbor_sets = {frozenset(neighbors) for neighbors in compiler.nbrs_N.values()}
    require(len(neighbor_sets) == 84, "The 84 outer vertices do not have distinct neighborhoods in N(x_0)")

    check_label_action(compiler, full_generators(), pairs, pair_index)
    check_label_action(compiler, stabilizer_generators(), pairs, pair_index)
    orbitals = pair_orbitals(compiler, pairs, pair_index)
    by_name = {item["name"]: item for item in orbitals}
    symmetry = stabilizer_orders(pairs, pair_index)
    maximum = 0
    for left, right in itertools.combinations(range(42), 2):
        maximum = max(maximum, max(cross_counts(compiler, left, right)))

    branches = []
    for name, partner in PARTNERS.items():
        support, phase = decode_orbit(partner, pairs)
        intersection = support_intersection(0, partner, pairs)
        orbital = by_name[ORBITAL_NAME[intersection]]
        counts = cross_counts(compiler, 0, partner)
        relations = classify_pair(counts)
        partner_orbit = symmetry["partner_orbit_sizes"][name]
        require(symmetry["faithful_order"] % partner_orbit == 0, "Partner orbit does not divide the stabilizer")
        alive = relations["K22"]["possible"]
        branches.append({
            "name": name,
            "partner": partner,
            "support": support,
            "phase": "-" if phase else "+",
            "orbital": orbital["name"],
            "counts": counts,
            "relations": {key: relations[key] for key in ("K22", "M0", "M1", "empty", "simple_matching")},
            "k22_possible": alive,
            "alive": alive,
            "abstract_residual_order": symmetry["abstract_order"] // partner_orbit,
            "faithful_residual_order": symmetry["faithful_order"] // partner_orbit,
        })

    dead = [branch["name"] for branch in branches if not branch["alive"]]
    return {
        "classification": "EXPLORED",
        "arithmetic_obstruction": bool(dead),
        "dead_branches": dead,
        "max_common_neighbors_in_N": maximum,
        "pair_count": 861,
        "label_action_matches_neighborhoods": True,
        "orbitals": orbitals,
        "stabilizer": symmetry,
        "branches": branches,
        "boundary": "Negative Gamma_2 demand is the only elimination used. No solver was run.",
    }


def _yes(flag):
    return "possible" if flag else "impossible"


def format_report(report):
    lines = [
        "Status: EXPLORED",
        "Arithmetic obstruction: " + ("yes, branches " + ",".join(report["dead_branches"]) if report["arithmetic_obstruction"] else "no"),
        f"Maximum common neighbors in N(x_0): {report['max_common_neighbors_in_N']}",
        "Orbit pairs: 861 = 21 + 420 + 420",
        "",
        "Orbital              size    K22        matching        empty       normalized cn",
    ]
    for orbital in report["orbitals"]:
        lines.append(
            f"{orbital['name']:<20} {orbital['size']:>6}  "
            f"{_yes(orbital['relations']['K22']['possible']):<10} "
            f"{_yes(orbital['relations']['simple_matching']['possible']):<15} "
            f"{_yes(orbital['relations']['empty']['possible']):<11} "
            f"{orbital['cn_normalized']}"
        )
    lines.extend([
        "",
        "Branch partner support phase orbital           K22 required alive |action| |Stab|",
    ])
    for branch in report["branches"]:
        support = "{" + ",".join(map(str, branch["support"])) + "}"
        lines.append(
            f"{branch['name']:<5} O_{branch['partner']:<5} {support:<8} {branch['phase']:<5} "
            f"{branch['orbital']:<17} {_yes(branch['k22_possible']):<12} "
            f"{'yes' if branch['alive'] else 'no':<5} "
            f"{branch['faithful_residual_order']:<8} {branch['abstract_residual_order']}"
        )
    stabilizer = report["stabilizer"]
    lines.extend([
        "",
        "The order |W| counts elements of (Z_2)^7 rtimes S_7 that fix orbit 0.",
        f"That group has order {stabilizer['abstract_order']}. "
        f"Its action on the 42 labels has a kernel of order {stabilizer['kernel_order']} "
        f"and faithful order {stabilizer['faithful_order']}.",
        "The |action| column is the residual faithful order. The |W| column is the residual abstract order.",
        report["boundary"],
    ])
    return "\n".join(lines)


def main():
    report = build_report()
    print(format_report(report))
    return 0 if not report["arithmetic_obstruction"] else 2


if __name__ == "__main__":
    sys.exit(main())
