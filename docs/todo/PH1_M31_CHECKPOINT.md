# PH1-M31 Checkpoint

Sprint: `PH1-M31-S1`  
Super-gate: `ANA-GATE-330`

Status: **Engineer sprint complete** — submitted for Architect review at `ANA-GATE-330`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-3101 | `79b6f99` | `[ANA-3101] Add real terminal launch plan document` |
| ANA-3102 | `2f63408` | `[ANA-3102] Document PH1-M31 real-launch fields in REPORT_FORMAT and CLI` |
| ANA-3103 | `e2b04f8` | `[ANA-3103] Extend RunContext with real-launch telemetry fields` |
| ANA-3104 | `43badb4` | `[ANA-3104] Add bounded real terminal launcher seam (Linux)` |
| ANA-3105 | `21fa483` | `[ANA-3105] Wire real terminal launch into guarded Linux full-run path` |
| ANA-3106 | `7636569` | `[ANA-3106] Emit terminal_launch fields in run.json and transport fingerprint` |
| ANA-3107 | `92c3797` | `[ANA-3107] Validate terminal_launch transport fields in report schema` |
| ANA-3108 | `7ed2a68` | `[ANA-3108] Extend compare RunMeta with terminal_launch telemetry rows` |
| ANA-3109 | `730199a` | `[ANA-3109] Add compare test for terminal_launch_ok metadata diff` |
| ANA-3110 | — | `[ANA-3110] Finalize PH1-M31 checkpoint and ANA-GATE-330 handoff` |

The git object for **ANA-3110** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-3110]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-3110` commit).
- Guarded Linux full run: **`--terminal-cmd`** is **required** (fail-closed with stderr message if missing).
- **`transport`**: **`terminal_launch_*`** keys emitted in lexicographic order after **`pty_experiment_open_ok`**, before **`timeout_ms`**, when **`mode`** is **`pty_guarded`**; **`report`** validation enforces invariants; **`compare`** exposes five new metadata rows.

## References

- `docs/todo/PH1_M31_TICKETS.md`
- `docs/REAL_TERMINAL_LAUNCH_PLAN.md`
