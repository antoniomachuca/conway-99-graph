import time
from pysat.solvers import Cadical153, Cadical195, Glucose42
from pysat.card import CardEnc, EncType
from pysat.formula import CNF

print("Testing pysat cardinality encoding...")
cnf = CardEnc.equals(lits=[1, 2, 3, 4], bound=2, top_id=4, encoding=EncType.totalizer)
print("Clauses:", len(cnf.clauses), "New top id:", cnf.nv)
