# PH1-M7 Checkpoint

Sprint: `PH1-M7-S1`  
Super-gate: `ANA-GATE-90`

Status: **Engineering complete** — awaiting Architect review at `ANA-GATE-90`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-701 | `ff9f589` | `[ANA-701] add Linux PTY experiment plan doc` |
| ANA-702 | `46112d7` | `[ANA-702] document guarded_state and PTY experiment report fields` |
| ANA-703 | `6d82a9b` | `[ANA-703] add Linux minimal POSIX PTY open/close seam` |
| ANA-704 | `583aea7` | `[ANA-704] gate pty_guarded experiment on Linux host preflight` |
| ANA-705 | `7d9708b` | `[ANA-705] run minimal PTY experiment for guarded non-dry-run on Linux` |
| ANA-706 | `3de70b4` | `[ANA-706] emit PTY experiment fields in run.json transport` |
| ANA-707 | `c46e0cf` | `[ANA-707] validate PTY experiment transport invariants in report schema` |
| ANA-708 | `5544de1` | `[ANA-708] add PTY experiment fields to compare metadata` |
| ANA-709 | `5d5b8f1` | `[ANA-709] document PH1-M7 guarded PTY smoke regression` |

`ANA-710` is the commit with subject `[ANA-710] finalize PH1-M7-S1 checkpoint and ticket pack` (search `git log --grep 'ANA-710'`).

## Engineer validation log

- `zig build`, `zig build test` — pass on Linux.
- **Preflight**: `pty_guarded` without opt-in exits **2**; non-Linux full run exits **2**; `pty_guarded` with opt-in and **`--dry-run`** exits **0** (no artifacts).
- **Full run (Linux)**: guarded opt-in run produces **`guarded_state`: `experiment_linux_pty`**, **`pty_experiment_open_ok`**: **`true`** (typical), **`report`** exits **0**.

## Notes

- `build.zig` links **libc** for POSIX `grantpt` / `unlockpt` / `ptsname_r`.
- Ticket definitions: `docs/todo/PH1_M7_TICKETS.md`.
