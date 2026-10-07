"""Enumerate canonical row-0 roots of the Z7 exterior row problem.

The row problem (``enumerate_z7_quotient.z7_problem``) is invariant under
S3 x S3 x S6 acting on the index blocks {0,1,2}, {3,4,5}, {6..11}: the
weights, row sums, diagonal domains, and the target matrix are all preserved
by within-block simultaneous row/column permutations. Every solution can
therefore be transformed into one whose row 0 is sorted ascending inside
{1,2}, {3,4,5}, and {6..11}. The sorted rows that satisfy the unary row
constraints are the ROOTS. Refuting the CNF with row 0 fixed to each root
refutes the whole row problem.

Validation: the set of roots must equal the canonicalization of the full
row-0 domain produced by ``generate_rows`` (7,576 rows on record).

Outputs per root a CNF = base RowProblemCNF + 12 unit clauses fixing row 0.
"""

from itertools import combinations_with_replacement as cwr
from pathlib import Path
import hashlib
import json
import sys

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.enumerate_z7_quotient import z7_problem, generate_rows
from scripts.z7_row_problem_cnf import RowProblemCNF

WEIGHTS = (1, 1, 1, -1, -1, -1, 0, 0, 0, 0, 0, 0)
BLOCKS = ((0, 1, 2), (3, 4, 5), (6, 7, 8, 9, 10, 11))


def canonical(row):
    r = list(row)
    r[1:3] = sorted(r[1:3])
    r[3:6] = sorted(r[3:6])
    r[6:12] = sorted(r[6:12])
    return tuple(r)


def unary_ok(row):
    if sum(row) != 12:
        return False
    if sum(w * a for w, a in zip(WEIGHTS, row)) != 0:
        return False
    return sum(a * a for a in row) + row[0] == 22  # targets[0][0] = 22


def enumerate_roots():
    roots = []
    for a00 in (0, 1, 2):
        for p1 in cwr(range(5), 2):
            for p2 in cwr(range(5), 3):
                s01 = a00 + sum(p1)
                for p3 in cwr(range(5), 6):
                    row = (a00,) + p1 + p2 + p3
                    if s01 + sum(p2) + sum(p3) != 12:
                        continue
                    if unary_ok(row):
                        roots.append(row)
    return roots


def check_block_symmetry(problem):
    """Brute-force check: every within-block permutation preserves the data."""
    import itertools

    def apply_perm(perm, matrix):
        return tuple(tuple(matrix[perm[i]][perm[j]] for j in range(12)) for i in range(12))

    for block in BLOCKS:
        rest = [j for j in range(12) if j not in block]
        for p in itertools.permutations(block):
            perm = list(range(12))
            for a, b in zip(block, p):
                perm[a] = b
            if any(perm[j] != j for j in rest):
                pass
            if apply_perm(perm, problem.targets) != problem.targets:
                raise AssertionError(f"target matrix not invariant under {perm}")
            if tuple(problem.weights[perm[j]] for j in range(12)) != problem.weights:
                raise AssertionError(f"weights not invariant under {perm}")
    return True


def main():
    out = Path(sys.argv[1])
    out.mkdir(parents=True, exist_ok=False)
    problem = z7_problem()
    check_block_symmetry(problem)

    roots = enumerate_roots()

    full_domain = list(generate_rows(problem, 0))
    canonical_domain = {canonical(tuple(map(int, r))) for r in full_domain}
    if canonical_domain != set(roots):
        missing = canonical_domain - set(roots)
        extra = set(roots) - canonical_domain
        raise AssertionError(f"root mismatch: missing={len(missing)} extra={len(extra)}")

    base = RowProblemCNF(problem)
    cnf = base.compile()
    manifest = {"root_count": len(roots), "full_domain_size": len(full_domain),
                "roots": []}
    for idx, row in enumerate(roots):
        units = [base.entry_lits(0, j)[row[j]] for j in range(12)]
        clauses = [list(c) for c in cnf.clauses] + [[u] for u in units]
        path = out / f"root_{idx:02d}.cnf"
        with open(path, "w") as fh:
            fh.write(f"p cnf {base.top_id} {len(clauses)}\n")
            for clause in clauses:
                fh.write(" ".join(map(str, clause)) + " 0\n")
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        manifest["roots"].append({"index": idx, "row": list(row),
                                  "cnf": path.name, "sha256": digest,
                                  "clauses": len(clauses)})
    with open(out / "roots_manifest.json", "w") as fh:
        json.dump(manifest, fh, indent=1)
    print(f"roots={len(roots)} domain={len(full_domain)} -> {out}")


if __name__ == "__main__":
    main()
