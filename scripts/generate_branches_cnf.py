import os

base_cnf = "conway_z2_f1.cnf"
branches = [
    ("A", "cuts_branch_a.cnf", "instances/conway_z2_f1_branch_a.cnf"),
    ("B", "cuts_branch_b.cnf", "instances/conway_z2_f1_branch_b.cnf"),
    ("C", "cuts_branch_c.cnf", "instances/conway_z2_f1_branch_c.cnf"),
]

os.makedirs("instances", exist_ok=True)

with open(base_cnf, "r") as f:
    header = f.readline()
    assert header.startswith("p cnf"), f"Unexpected header: {header}"
    parts = header.strip().split()
    n_vars = int(parts[2])
    n_clauses = int(parts[3])
    base_body = f.read()

for branch_name, cut_file, out_file in branches:
    with open(cut_file, "r") as cf:
        cut_lines = [l for l in cf if not l.startswith("c") and l.strip()]
    n_cuts = len(cut_lines)
    new_clauses = n_clauses + n_cuts
    new_header = f"p cnf {n_vars} {new_clauses}\n"
    with open(out_file, "w") as out:
        out.write(new_header)
        out.write(base_body)
        out.write("".join(cut_lines))
    print(f"[+] Created {out_file}: {n_vars} vars, {new_clauses} clauses (+{n_cuts} cuts)")

print("[+] All branch CNFs generated successfully.")
