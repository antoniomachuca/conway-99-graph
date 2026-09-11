#!/usr/bin/env bash
# ==============================================================================
# resume_all.sh: Idempotent, Safe & Non-Destructive Launcher for Conway Solvers
# ==============================================================================
# Rules enforced:
# 1. Never overwrites existing .cnf, .drat, .lrat or log files.
# 2. Never launches duplicate solver processes for the same CNF.
# 3. Allocates automatic .resume-N.drat suffix if proof already exists.
# 4. Uses binary DRAT format by default to protect disk space (~41 GiB remaining).
# 5. Employs absolute paths and records PIDs and timestamps.
# ==============================================================================

set -euo pipefail

PROJECT_DIR="/Users/antoniomachuca/Documents/Conway's 99-Graph Problem"
CADICAL_BIN="$PROJECT_DIR/cadical"
LOG_DIR="$HOME/conway_resume_logs"
STATE_FILE="$PROJECT_DIR/RESUME_STATE.md"

mkdir -p "$LOG_DIR"
cd "$PROJECT_DIR"

echo "======================================================================"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Conway 99 resume verification..."
echo "======================================================================"

launch_solver() {
    local cnf="$1"
    local proof_base="$2"
    local log_base="$3"
    local extra_opts="${4:-}"

    local cnf_path="$PROJECT_DIR/$cnf"
    if [[ ! -f "$cnf_path" ]]; then
        echo "[ERROR] CNF file not found: $cnf_path" >&2
        return 1
    fi

    # 1. Check if a solver is already running on this CNF
    if pgrep -f "$CADICAL_BIN.*$cnf" >/dev/null 2>&1; then
        local active_pid
        active_pid=$(pgrep -f "$CADICAL_BIN.*$cnf" | tr '\n' ' ')
        echo "[SKIP] Solver already active for $cnf (PID: $active_pid)"
        return 0
    fi

    # 2. Determine non-overlapping proof output filename
    local proof_target="$proof_base"
    local log_target="$log_base"
    if [[ -f "$PROJECT_DIR/$proof_base" ]]; then
        local n=1
        while [[ -f "$PROJECT_DIR/${proof_base%.drat}.resume-${n}.drat" ]]; do
            n=$((n + 1))
        done
        proof_target="${proof_base%.drat}.resume-${n}.drat"
        log_target="${log_base%.log}.resume-${n}.log"
    fi

    local proof_path="$PROJECT_DIR/$proof_target"
    local log_path="$PROJECT_DIR/$log_target"

    echo "[LAUNCH] Starting CaDiCaL for $cnf"
    echo "         Proof target: $proof_target"
    echo "         Log target:   $log_target"

    # 3. Launch process in background with nohup
    nohup "$CADICAL_BIN" "$cnf_path" "$proof_path" $extra_opts >> "$log_path" 2>&1 &
    local new_pid=$!
    echo "[STARTED] PID: $new_pid for $cnf"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] PID $new_pid: $CADICAL_BIN $cnf $proof_target" >> "$LOG_DIR/launchd.stdout.log"
}

# ------------------------------------------------------------------------------
# 1. Solvers
# ------------------------------------------------------------------------------
# Z2 (f=1 involution) - Highest theoretical priority
launch_solver "conway_z2_f1.cnf" "proof_z2_f1.drat" "cadical_z2_f1.log" ""

# Z3 (3 fixed points)
launch_solver "conway_z3_fixed3.cnf" "proof_z3_fixed3.drat" "cadical_z3.log" ""

# Z3 (fixed-point-free)
launch_solver "conway_z3_fpf.cnf" "proof_z3_fpf.drat" "cadical_z3_fpf.log" ""

# Z7 (tight)
launch_solver "conway_z7_tight.cnf" "proof_z7_tight.drat" "cadical_tight.log" ""

# ------------------------------------------------------------------------------
# 2. Lean 4 Background Servers
# ------------------------------------------------------------------------------
LEAN_BIN="$HOME/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
LAKE_BIN="$HOME/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake"

if [[ -x "$LEAN_BIN" ]] && ! pgrep -f "lean --server $PROJECT_DIR" >/dev/null 2>&1; then
    nohup "$LEAN_BIN" --server "$PROJECT_DIR" >> "$LOG_DIR/lean_server.log" 2>&1 &
    echo "[STARTED] lean --server PID: $!"
fi

if [[ -x "$LAKE_BIN" ]] && ! pgrep -f "lake serve -- $PROJECT_DIR" >/dev/null 2>&1; then
    nohup "$LAKE_BIN" serve -- "$PROJECT_DIR" >> "$LOG_DIR/lake_serve.log" 2>&1 &
    echo "[STARTED] lake serve PID: $!"
fi

echo "======================================================================"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] resume_all.sh finished execution."
echo "======================================================================"
