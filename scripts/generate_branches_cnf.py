import argparse
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.validate_z2_f1_inputs import PARTNERS, expected_cuts, require, sha256_file


def generate_branches(base, output):
    base = base.resolve(strict=True)
    with base.open("rb") as stream:
        fields = stream.readline().split()
        require(len(fields) == 4 and fields[:2] == [b"p", b"cnf"], "Invalid base CNF header")
        variables, clauses = map(int, fields[2:])
        require(variables >= 1764, "Base CNF has too few variables for this model")
        body = stream.read()
    require(body.endswith(b"\n"), "Base CNF must end in a newline")
    output.mkdir()
    records = {}
    for branch, partner in PARTNERS.items():
        cuts = expected_cuts(partner)
        path = output / f"conway_z2_f1_branch_{branch.lower()}.cnf"
        with path.open("xb") as stream:
            stream.write(f"p cnf {variables} {clauses + len(cuts)}\n".encode("ascii"))
            stream.write(body)
            for clause in cuts:
                stream.write((" ".join(map(str, clause)) + " 0\n").encode("ascii"))
        records[branch] = {"partner": partner, "path": str(path.resolve()), "sha256": sha256_file(path)}
    report = {"classification": "COMPILED", "base_sha256": sha256_file(base), "branches": records,
              "boundary": "Serialization and branch representatives only; no graph nonexistence claim."}
    with (output / "manifest.json").open("x") as stream:
        json.dump(report, stream, indent=2)
    return report


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--base", type=Path, default=ROOT / "conway_z2_f1.cnf")
    parser.add_argument("--output-dir", type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(generate_branches(args.base, args.output_dir), indent=2))


if __name__ == "__main__":
    main()
