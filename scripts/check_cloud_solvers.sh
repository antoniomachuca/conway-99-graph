#!/bin/bash
echo "=== Cloud Solvers Status (conway-sat-worker in GCP us-central1-b) ==="
gcloud compute ssh conway-sat-worker --zone=us-central1-b --command="
echo '--- Active Solver Processes ---'
ps aux | grep -E 'cadical|drat-trim' | grep -v grep || echo 'Solvers starting up or idle...'
echo '--- Memory and Disk ---'
free -h
df -h ~/conway
echo '--- Branch A Log (last 5 lines) ---'
tail -n 5 ~/conway/cadical_branch_a.log 2>/dev/null || echo 'Not started yet'
echo '--- Branch B Log (last 5 lines) ---'
tail -n 5 ~/conway/cadical_branch_b.log 2>/dev/null || echo 'Not started yet'
echo '--- Branch C Log (last 5 lines) ---'
tail -n 5 ~/conway/cadical_branch_c.log 2>/dev/null || echo 'Not started yet'
"
