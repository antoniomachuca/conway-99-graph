import argparse
from dataclasses import asdict, dataclass
from datetime import datetime, timezone
import fcntl
from functools import partial
import json
import math
import os
from pathlib import Path
import resource
import shutil
import signal
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.validate_z2_f1_inputs import PARTNERS, require, sha256_file

GIB = 1024 ** 3


@dataclass(frozen=True)
class Limits:
    max_seconds: float
    max_proof_bytes: int
    min_free_bytes: int

    def __post_init__(self):
        if not math.isfinite(self.max_seconds) or self.max_seconds <= 0 or self.max_proof_bytes <= 0 or self.min_free_bytes < 0:
            raise ValueError("Limits must be finite and bounded")


def limit_reason(limits, elapsed, proof_bytes, free_bytes):
    if elapsed >= limits.max_seconds:
        return "wall_time_limit"
    if proof_bytes >= limits.max_proof_bytes:
        return "proof_size_limit"
    if free_bytes < limits.min_free_bytes:
        return "free_space_limit"
    return None


def write_status(directory, state):
    temporary = directory / "status.next.json"
    with temporary.open("x") as stream:
        json.dump(state, stream, indent=2)
    temporary.replace(directory / "status.json")


def stop_process(process):
    if process is None or process.poll() is not None:
        return
    process.terminate()
    try:
        process.wait(timeout=10)
    except subprocess.TimeoutExpired:
        process.kill()
        process.wait(timeout=10)


def constrain_child(proof_limit):
    os.nice(10)
    resource.setrlimit(resource.RLIMIT_FSIZE, (proof_limit, proof_limit))


def terminal_result(log, returncode):
    result = "UNKNOWN"
    with log.open(errors="replace") as stream:
        for line in stream:
            if line.strip() in ("s SATISFIABLE", "s UNSATISFIABLE"):
                result = line.strip()[2:]
    if result == "SATISFIABLE" and returncode == 10:
        return result
    if result == "UNSATISFIABLE" and returncode == 20:
        return result
    return "UNKNOWN"


def supervise(command, directory, limits, poll_seconds=5, free_bytes=None, keep_awake=False, required_mount=None):
    directory = Path(directory)
    for name in ("solver.log", "proof.drat", "result.txt", "status.json", "status.next.json"):
        if (directory / name).exists():
            raise FileExistsError(directory / name)
    free_bytes = free_bytes or (lambda: shutil.disk_usage(directory).free)
    require(free_bytes() >= limits.min_free_bytes, "Insufficient free space before launch")
    require(poll_seconds > 0, "Polling interval must be positive")
    requested = [None]
    previous_handlers = {}

    def request_stop(signum, frame):
        requested[0] = f"signal_{signum}"

    for signum in (signal.SIGTERM, signal.SIGINT):
        previous_handlers[signum] = signal.signal(signum, request_stop)
    started = time.time()
    monotonic_start = time.monotonic()
    process = None
    awake = None
    state = {"state": "starting", "classification": "EXPLORED", "proof_verification": "PENDING",
             "supervisor_pid": os.getpid(), "started_utc": datetime.fromtimestamp(started, timezone.utc).isoformat(),
             "deadline_utc": datetime.fromtimestamp(started + limits.max_seconds, timezone.utc).isoformat(),
             "limits": asdict(limits), "stop_reason": None}
    proof = directory / "proof.drat"
    try:
        with (directory / "solver.log").open("xb") as output:
            environment = {key: value for key, value in os.environ.items() if not key.startswith("CADICAL_")}
            process = subprocess.Popen(command, cwd=directory, stdin=subprocess.DEVNULL, stdout=output,
                                       stderr=subprocess.STDOUT, start_new_session=True, env=environment,
                                       preexec_fn=partial(constrain_child, limits.max_proof_bytes))
            state.update(state="running", solver_pid=process.pid)
            if keep_awake:
                awake = subprocess.Popen(["/usr/bin/caffeinate", "-s", "-w", str(process.pid)],
                                         stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                state["caffeinate_pid"] = awake.pid
            write_status(directory, state)
            print(json.dumps(state), flush=True)
            while process.poll() is None:
                elapsed = max(time.time() - started, time.monotonic() - monotonic_start)
                proof_bytes = proof.stat().st_size if proof.exists() else 0
                available = free_bytes()
                reason = requested[0] or limit_reason(limits, elapsed, proof_bytes, available)
                if required_mount is not None and not Path(required_mount).is_mount():
                    reason = "external_volume_unmounted"
                state.update(elapsed_seconds=elapsed, proof_bytes=proof_bytes, free_bytes=available,
                             updated_utc=datetime.now(timezone.utc).isoformat())
                if reason:
                    state.update(state="stopping", stop_reason=reason)
                    write_status(directory, state)
                    stop_process(process)
                    break
                write_status(directory, state)
                time.sleep(poll_seconds)
            process.wait()
        proof_bytes = proof.stat().st_size if proof.exists() else 0
        elapsed = max(time.time() - started, time.monotonic() - monotonic_start)
        reason = state["stop_reason"] or limit_reason(limits, elapsed, proof_bytes, free_bytes())
        result = terminal_result(directory / "solver.log", process.returncode)
        state.update(state="finished", stop_reason=reason, elapsed_seconds=elapsed, proof_bytes=proof_bytes,
                     returncode=process.returncode, solver_result=result,
                     classification="PENDING" if result != "UNKNOWN" else "EXPLORED",
                     finished_utc=datetime.now(timezone.utc).isoformat())
        write_status(directory, state)
        print(json.dumps(state), flush=True)
        return state
    except BaseException as error:
        stop_process(process)
        state.update(state="failed", stop_reason="supervisor_error", error=str(error),
                     finished_utc=datetime.now(timezone.utc).isoformat())
        write_status(directory, state)
        raise
    finally:
        stop_process(process)
        stop_process(awake)
        for signum, handler in previous_handlers.items():
            signal.signal(signum, handler)


def launch(args):
    directory = args.directory.resolve(strict=True)
    volume = args.volume.resolve(strict=True)
    require(volume.is_mount() and directory.is_relative_to(volume), "Session must be on the mounted external volume")
    require(shutil.disk_usage(directory).free >= args.limits.min_free_bytes + args.limits.max_proof_bytes,
            "Not enough space for the proof budget and reserve")
    validation = json.loads((directory / "validation.json").read_text())
    branch = validation["selected_branch"]
    require(validation["stabilizer"]["representatives"] == PARTNERS, "Branch validation uses obsolete representatives")
    require(validation["symbolic_constraints_checked"] == 2394, "Missing symbolic checks")
    require(sha256_file(directory / "input.cnf") == validation["generated_branches"][branch]["sha256"], "Input hash mismatch")
    for name, digest in validation["source_sha256"].items():
        source = (ROOT / name).resolve(strict=True)
        require(source.is_relative_to(ROOT) and sha256_file(source) == digest, f"Source changed after validation: {name}")
    solver = args.solver.resolve(strict=True)
    require(os.access(solver, os.X_OK), "Solver is not executable")
    with (directory.parent / ".bounded_local_search.lock").open("a") as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        existing = subprocess.run(["pgrep", "-x", "cadical"], capture_output=True, text=True)
        require(existing.returncode == 1, "Another CaDiCaL process exists, or process inspection failed")
        command = [str(solver), "-t", str(args.max_seconds), f"--seed={args.seed}", "--binary",
                   "-w", str(directory / "result.txt"), str(directory / "input.cnf"), str(directory / "proof.drat")]
        manifest = {"classification": "EXPLORED", "branch": branch, "partner": PARTNERS[branch],
                    "input_sha256": sha256_file(directory / "input.cnf"), "solver_sha256": sha256_file(solver),
                    "solver_version": subprocess.check_output([str(solver), "--version"], text=True).strip(),
                    "runner_sha256": sha256_file(Path(__file__)), "command": command, "limits": asdict(args.limits),
                    "nice_increment": 10, "proof_format": "binary DRAT", "proof_verification": "PENDING",
                    "poll_seconds": 5, "external_volume": str(volume),
                    "created_utc": datetime.now(timezone.utc).isoformat()}
        with (directory / "manifest.json").open("x") as stream:
            json.dump(manifest, stream, indent=2)
        with solver.open("rb") as source, (directory / "solver.binary.snapshot").open("xb") as target:
            shutil.copyfileobj(source, target)
        require(sha256_file(directory / "solver.binary.snapshot") == manifest["solver_sha256"], "Solver snapshot mismatch")
        supervise(command, directory, args.limits, keep_awake=True, required_mount=volume)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", type=Path, required=True)
    parser.add_argument("--volume", type=Path, required=True)
    parser.add_argument("--solver", type=Path, default=ROOT / "cadical")
    parser.add_argument("--max-seconds", type=int, required=True)
    parser.add_argument("--max-proof-gib", type=int, required=True)
    parser.add_argument("--min-free-gib", type=int, default=50)
    parser.add_argument("--seed", type=int, default=20260921)
    parser.add_argument("--detach", action="store_true")
    args = parser.parse_args()
    args.limits = Limits(args.max_seconds, args.max_proof_gib * GIB, args.min_free_gib * GIB)
    require(0 <= args.seed <= 2000000000, "Seed outside CaDiCaL range")
    if args.detach:
        directory = args.directory.resolve(strict=True)
        arguments = [value for value in sys.argv[1:] if value != "--detach"]
        with (directory / "supervisor.log").open("xb") as output:
            process = subprocess.Popen([sys.executable, "-B", str(Path(__file__).resolve()), *arguments],
                                       stdin=subprocess.DEVNULL, stdout=output, stderr=subprocess.STDOUT,
                                       start_new_session=True, close_fds=True)
        print(json.dumps({"supervisor_pid": process.pid, "session_directory": str(directory), "startup": "PENDING"}))
        return
    launch(args)


if __name__ == "__main__":
    main()
