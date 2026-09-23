import z3
import time

t0 = time.time()
solver = z3.Solver()

# 666 boolean variables
# Check performance of z3 on boolean formulation with PbEq
print("Testing Z3 with PB constraints...")
