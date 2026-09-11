import time
from pysat.solvers import Kissat404
from pysat.formula import CNF

print("Loading conway_z7.cnf into Kissat404...", flush=True)
t0 = time.time()
cnf = CNF(from_file="conway_z7.cnf")
print(f"Loaded {len(cnf.clauses)} clauses in {time.time() - t0:.2f}s. Initializing Kissat404...", flush=True)

solver = Kissat404(bootstrap_with=cnf.clauses)
print("Solving with Kissat404...", flush=True)
t_solve = time.time()
res = solver.solve()
print(f"Kissat404 result: {res} in {time.time() - t_solve:.2f}s", flush=True)
if res:
    print("SAT! Found solution.")
    model = solver.get_model()
    with open("witness_z7.json", "w") as f:
        import json
        json.dump(model, f)
else:
    print("UNSAT! No srg(99, 14, 1, 2) graph exists with Z_7 symmetry.")
