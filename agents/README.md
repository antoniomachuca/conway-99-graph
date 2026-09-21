# Agent Records and Current Handover

This directory contains historical operational reports and the corrected handover for work on Conway's 99-graph problem. It is not evidence that an agent, solver, or cloud process is currently running.

## Current documents

| File | Purpose |
|---|---|
| [handover_briefing.md](handover_briefing.md) | Current verification boundaries, known defects, prior-work attribution, and pending obligations. |
| [audit_log.md](audit_log.md) | Historical entries preserved under a superseding September 21, 2026 correction notice. Earlier verdicts must not be treated as current certification. |

The project has used separate roles for orbit reduction, CNF compilation, auditing, formalization, and solver operations. Role names and assertions of independent auditing are not substitutes for inspecting theorem statements, executable code, and retained evidence.

## Status interpretation

- **PROVED:** only the specific audited Lean propositions and recorded checked formula refutations, within their stated scope.
- **COMPILED:** the library with unfinished or externally conditional declarations, and the limited passing compiler suite despite its known semantic gap.
- **EXPLORED:** reproducible Python calculations and inconclusive or uncertified searches.
- **PENDING:** complete graph-to-encoding validation, missing formal interfaces, originality, rigidity, and existence.

See the [README](../README.md), [technical audit](../docs/technical_report.md), and [project rules](../AGENTS.md). Historical material in `archive/` and `correspondence/` may repeat superseded mathematical or operational claims. This revision neither rewrites raw solver logs nor certifies all earlier reports.
