# STALE ARTIFACT WARNING — order-7 canonical pair at repository root

Recorded: 2026-10-05. Do not delete these files; cite them only as stale.

The following files at the repository root belong to a **superseded order-7
encoding with 176,613 variables and 421,562 clauses**:

- `proof_z7_canonical.drat` (192,218,491 bytes)
- `cadical_z7.log` (solves that formula; log line: `parsed 421562 clauses`)
- `drat_trim_z7.log` (`s VERIFIED` in 844.008 s **on that formula**)
- `z7_result.txt` (ambiguous; contains only the two verdict lines)

They do **not** certify the current `conway_z7_canonical.cnf` at the
repository root, whose header is `p cnf 177097 422508`.

The certificate pair for the current 177,097-variable formula is:

- CNF: `/Volumes/Untitled/conway_repro_z7/conway_z7_canonical.cnf`
  (SHA-256 in `SHA256SUMS.txt`).
- Proof: `/Volumes/Untitled/conway_repro_z7/proof_z7_canonical.drat`
  (26,746,488,053 bytes).
- Checker log: `/Volumes/Untitled/conway_repro_z7/drat_trim_z7.log`,
  `s VERIFIED` in 103,482.837 s on the 177,097-variable formula
  (a first attempt timed out: `drat_trim_z7_timeout.log`).
- Published copy: Zenodo record 10.5281/zenodo.22995101 (see `README.md:17`).

Rule (`AGENTS.md` §2): a claim is PROVED only for the exact file named in the
solver log and the checker log. Citing the root logs above for the
177,097-variable formula would be a false claim.
