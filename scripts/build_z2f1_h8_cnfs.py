#!/usr/bin/env python3
"""Build Partitioned DIMACS CNF Formulas for Z2 Involution Symmetry Breaking (h=8)
in Conway's 99-Graph Problem (Requirement R2).

Generates 5 DIMACS CNFs corresponding to the 5 canonical classes of signed support
matrices W in {0, -1}^(8x8) (OEIS A005638 filtered by mu <= 2).
Each formula combines the base srg(99, 14, 1, 2) group ring model with phi(8)
and the 64 unit clauses fixing all active orbit primary variables.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO_ROOT))
sys.path.insert(0, str(REPO_ROOT / "scratch" / "avenue2_20261011"))

from scripts.enumerate_z2_w_matrices import (
    get_canonical_w8_classes,
    semantic_to_model_clauses,
)
from z2f1_groupring_sat import Model


def compute_sha256(filepath: str) -> str:
    """Compute the SHA-256 hash of a file."""
    h = hashlib.sha256()
    with open(filepath, "rb") as f:
        while chunk := f.read(1024 * 1024):
            h.update(chunk)
    return h.hexdigest()


def build_cnfs(
    classes: Optional[List[Dict[str, Any]]] = None,
    out_dir: str = "instances/z2_h8",
    selected_ids: Optional[List[int]] = None,
    force: bool = False,
) -> List[Dict[str, Any]]:
    """PROJECT.md Interface Contract:
    Generates 5 DIMACS CNF files incorporating the 64 unit clauses for each canonical class.
    Returns list of metadata dicts for the generated CNF files.
    """
    out_path = Path(out_dir)
    out_path.mkdir(parents=True, exist_ok=True)

    if classes is None:
        classes = get_canonical_w8_classes()

    if selected_ids is not None:
        classes = [c for c in classes if c["class_id"] in selected_ids]

    print(f"[*] Instantiating base Model(m=49, k=14, lam=1, mu=2, phi=8)...")
    t0 = time.time()
    base_model = Model(m=49, k=14, lam=1, mu=2, phi=8)
    base_build_time = round(time.time() - t0, 2)
    print(f"[*] Base model built in {base_build_time}s: {base_model.pool.top} vars, {len(base_model.clauses)} clauses")

    manifest_entries: List[Dict[str, Any]] = []

    for c in classes:
        class_id = c["class_id"]
        class_name = c["name"]
        filename = f"conway_z2_h8_class{class_id}_{class_name}.cnf"
        target_file = out_path / filename

        if target_file.exists() and not force:
            print(f"[+] File already exists: {target_file} (use --force to overwrite)")
            sha256 = compute_sha256(str(target_file))
            size = target_file.stat().st_size
            manifest_entries.append({
                "class_id": class_id,
                "name": class_name,
                "filename": filename,
                "path": str(target_file.resolve()),
                "size_bytes": size,
                "sha256": sha256,
                "vars": base_model.pool.top,
                "clauses": len(base_model.clauses) + 64,
            })
            continue

        print(f"[*] Generating CNF for Class {class_id} ({class_name})...")
        t_gen = time.time()

        # Generate 64 unit clauses for this class
        unit_clauses = semantic_to_model_clauses(base_model, c["unit_clauses_semantic"])
        assert len(unit_clauses) == 64, f"Expected 64 unit clauses, got {len(unit_clauses)}"

        total_clauses_count = len(base_model.clauses) + len(unit_clauses)
        top_var = base_model.pool.top

        # Write DIMACS CNF directly
        with open(target_file, "w") as fo:
            fo.write(f"c Conway's 99-Graph Z2 Involution Symmetry Breaking (h=8)\n")
            fo.write(f"c Canonical Class {class_id}: {class_name}\n")
            fo.write(f"c Triangles: {c['triangles']}, Connected: {c['connected']}\n")
            fo.write(f"c Unit clauses: 64 (8 e(i), 28 x(i,j,0), 28 x(i,j,1))\n")
            fo.write(f"p cnf {top_var} {total_clauses_count}\n")
            for cl in base_model.clauses:
                fo.write(" ".join(map(str, cl)) + " 0\n")
            for cl in unit_clauses:
                fo.write(" ".join(map(str, cl)) + " 0\n")

        gen_time = round(time.time() - t_gen, 2)
        sha256 = compute_sha256(str(target_file))
        size = target_file.stat().st_size

        print(f"[✓] Class {class_id} written to {target_file} ({size / (1024*1024):.2f} MB, {gen_time}s)")

        manifest_entries.append({
            "class_id": class_id,
            "name": class_name,
            "filename": filename,
            "path": str(target_file.resolve()),
            "size_bytes": size,
            "sha256": sha256,
            "vars": top_var,
            "clauses": total_clauses_count,
            "triangles": c["triangles"],
            "max_cn_nonadj": c["max_cn_nonadj"],
            "max_cn_adj": c["max_cn_adj"],
            "connected": c["connected"],
        })

    # Write manifest file
    manifest_path = out_path / "manifest.json"
    with open(manifest_path, "w") as fo:
        json.dump(manifest_entries, fo, indent=2)
    print(f"[*] Manifest saved to {manifest_path}")

    return manifest_entries


def main() -> None:
    parser = argparse.ArgumentParser(description="Build DIMACS CNF files for Z2 h=8 canonical classes.")
    parser.add_argument("--out-dir", default="instances/z2_h8", help="Output directory for CNF files.")
    parser.add_argument("--classes", type=str, help="Comma-separated class IDs to build (e.g., '1,2').")
    parser.add_argument("--force", action="store_true", help="Force overwrite existing CNF files.")
    parser.add_argument("--json", action="store_true", help="Print manifest JSON to stdout.")
    args = parser.parse_args()

    selected_ids = None
    if args.classes:
        selected_ids = [int(x.strip()) for x in args.classes.split(",") if x.strip()]

    entries = build_cnfs(out_dir=args.out_dir, selected_ids=selected_ids, force=args.force)

    if args.json:
        print(json.dumps(entries, indent=2))
    else:
        print("\nSummary of Generated CNF Files:")
        print(f"{'Class':<6} {'Name':<16} {'Variables':<12} {'Clauses':<12} {'Size (MB)':<10} {'SHA-256':<16}")
        print("-" * 75)
        for e in entries:
            mb = e["size_bytes"] / (1024 * 1024)
            print(f"{e['class_id']:<6} {e['name']:<16} {e['vars']:<12} {e['clauses']:<12} {mb:<10.2f} {e['sha256'][:14]}...")


if __name__ == "__main__":
    main()
