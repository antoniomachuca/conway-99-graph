# Agent State: $\mathbb{Z}_2$ Solver Operator (`state_z2_solver_operator.md`)

## Operational Role
Supervises local and remote CDCL SAT solvers executing involution refutation branches.

## Infrastructure
- **Remote Cloud Worker:** `conway-sat-worker` in GCP (`us-central1-b`, e2-standard-16, 64 GB RAM, 300 GB SSD).
- **Local Machine:** Solvers stopped to keep CPU at 0% and protect local disk (~93 GiB free).
- **Automated Daemon:** `cloud_watcher.sh` running in cloud background, supervising solvers and triggering Telegram notifications upon completion.
