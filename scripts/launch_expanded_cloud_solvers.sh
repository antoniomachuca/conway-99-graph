#!/bin/bash
# scripts/launch_expanded_cloud_solvers.sh
# Deploys 7 additional solvers onto the Google Cloud VM
# (total: 10 active solvers, using 10 out of 16 cores)

set -e
cd ~/conway

echo "=== Current active cadical processes ==="
pgrep -fl cadical || true

echo "=== Launching 3 SAT Hunters for f=1 (Seed 42, no DRAT) ==="
nohup /usr/local/bin/cadical --sat --seed=42 conway_z2_f1_branch_a.cnf > cadical_hunter_a.log 2>&1 &
echo $! >> solver_pids.txt

nohup /usr/local/bin/cadical --sat --seed=42 conway_z2_f1_branch_b.cnf > cadical_hunter_b.log 2>&1 &
echo $! >> solver_pids.txt

nohup /usr/local/bin/cadical --sat --seed=42 conway_z2_f1_branch_c.cnf > cadical_hunter_c.log 2>&1 &
echo $! >> solver_pids.txt

echo "=== Launching Z_7 Canonical Solvers (1 DRAT, 1 SAT Hunter) ==="
nohup /usr/local/bin/cadical conway_z7_canonical.cnf proof_z7_canonical.drat > cadical_z7.log 2>&1 &
echo $! >> solver_pids.txt

nohup /usr/local/bin/cadical --sat --seed=777 conway_z7_canonical.cnf > cadical_z7_hunter.log 2>&1 &
echo $! >> solver_pids.txt

echo "=== Launching Z_3 Canonical Solvers (fpf and fixed-3, DRAT enabled) ==="
nohup /usr/local/bin/cadical conway_z3_fpf.cnf proof_z3_fpf.drat > cadical_z3_fpf.log 2>&1 &
echo $! >> solver_pids.txt

nohup /usr/local/bin/cadical conway_z3_fixed3.cnf proof_z3_fixed3.drat > cadical_z3_fixed3.log 2>&1 &
echo $! >> solver_pids.txt

echo "=== All 7 new solvers launched successfully ==="
ps aux | grep cadical | grep -v grep
