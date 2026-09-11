#!/bin/bash
set -e
cd ~/conway

echo "=== System Status ==="
echo "CPUs: $(nproc)"
free -h
df -h .

CADICAL=$(command -v cadical || echo "/root/cadical/build/cadical" || echo "/usr/local/bin/cadical")
if [ ! -x "$CADICAL" ]; then
    echo "ERROR: cadical binary not found yet. Current path: $CADICAL"
    exit 1
fi

echo "Using CaDiCaL: $CADICAL"
$CADICAL --version || true

echo "=== Launching 3 Symmetry-Broken Branches ==="
nohup $CADICAL conway_z2_f1_branch_a.cnf proof_z2_f1_branch_a.drat > cadical_branch_a.log 2>&1 &
PID_A=$!
echo "Branch A launched: PID $PID_A (Partner O21, 15,360x symmetry broken)"

nohup $CADICAL conway_z2_f1_branch_b.cnf proof_z2_f1_branch_b.drat > cadical_branch_b.log 2>&1 &
PID_B=$!
echo "Branch B launched: PID $PID_B (Partner O1, 768x symmetry broken)"

nohup $CADICAL conway_z2_f1_branch_c.cnf proof_z2_f1_branch_c.drat > cadical_branch_c.log 2>&1 &
PID_C=$!
echo "Branch C launched: PID $PID_C (Partner O10, 768x symmetry broken)"

echo "$PID_A $PID_B $PID_C" > solver_pids.txt
echo "All 3 branches running in background."
ps aux | grep cadical | grep -v grep
