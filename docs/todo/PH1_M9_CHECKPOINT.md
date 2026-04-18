# PH1-M9 Checkpoint

Sprint: `PH1-M9-S1`  
Super-gate: `ANA-GATE-110`

Status: **Corrective engineering complete** — awaiting Architect re-review at `ANA-GATE-110` (post `ANA-911`..`ANA-913`).

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-901 | `43adfb1` | `[ANA-901] add PTY reproducibility plan for PH1-M9` |
| ANA-902 | `255523f` | `[ANA-902] document PTY host machine/release transport fields` |
| ANA-903 | `513f33e` | `[ANA-903] add RunContext PTY host uname snapshot fields` |
| ANA-904 | `a9f6991` | `[ANA-904] emit PTY host machine/release in run.json transport` |
| ANA-905 | `f26091e` | `[ANA-905] validate PTY host machine/release in run.json schema` |
| ANA-906 | `757de4c` | `[ANA-906] compare run metadata for PTY host machine/release` |
| ANA-907 | `d791f26` | `[ANA-907] test PTY host snapshot capture on Linux` |
| ANA-908 | `3f3d4ee` | `[ANA-908] regression tests for PTY host fields in report and compare` |
| ANA-909 | `6413c0d` | `[ANA-909] document PH1-M9 PTY host snapshot smoke checks` |

`ANA-910` is the commit with subject `[ANA-910] finalize PH1-M9-S1 checkpoint and ticket pack` (search `git log --grep 'ANA-910'`).

## Corrective batch (compile regression)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-911 | `b0a5d3d` | `[ANA-911] fix json_writer host field encoding for Io.Writer API` |
| ANA-912 | `0e8cc79` | `[ANA-912] test json_writer PTY host field JSON encoding path` |

`ANA-913` is the commit with subject `[ANA-913] finalize PH1-M9 corrective checkpoint for ANA-GATE-110` (search `git log --grep 'ANA-913'`).

## Engineer validation log

- `zig build` — pass (default harness executable build).
- `zig build test` — pass on Linux.
- Guarded full run: **`report`** **0**; **`transport.pty_experiment_host_machine`** and **`pty_experiment_host_release`** non-empty strings on **`experiment_linux_pty`**; **`null`** on **`scaffold_only`** (**`--dry-run`**).
- Preflight and opt-in behavior unchanged from PH1-M8.

## References

- `docs/todo/PH1_M9_TICKETS.md`
- `docs/todo/PH1_M9_CORRECTIVE_TICKETS.md`
- `docs/PTY_REPRODUCIBILITY_PLAN.md`
