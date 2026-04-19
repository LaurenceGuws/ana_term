# PH1-M32 Checkpoint

Sprint: `PH1-M32-S1`  
Super-gate: `ANA-GATE-340`

Status: **Accepted by Architect** at `ANA-GATE-340`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-3201 | `ae956f6` | `[ANA-3201] Add terminal launch semantics plan document` |
| ANA-3202 | `2cab044` | `[ANA-3202] Document PH1-M32 launch outcome in REPORT_FORMAT and CLI` |
| ANA-3203 | `b08d11a` | `[ANA-3203] Add terminal_launch_outcome to RunContext and LaunchTelemetry` |
| ANA-3204 | `e604ec1` | `[ANA-3204] Map Linux launch termination paths to PH1-M32 outcome classes` |
| ANA-3205 | `e0d5afa` | `[ANA-3205] Wire terminal_launch_outcome through guarded full-run pipeline` |
| ANA-3206 | `fdc4578` | `[ANA-3206] Emit terminal_launch_outcome in run.json and transport fingerprint` |
| ANA-3207 | `239f639` | `[ANA-3207] Validate terminal_launch_outcome in run.json schema` |
| ANA-3208 | `5ced912` | `[ANA-3208] Compare RunMeta includes terminal_launch_outcome diff row` |
| ANA-3209 | `3cdb8e9` | `[ANA-3209] Add tests for launch outcome validation and compare metadata` |
| ANA-3210 | — | `[ANA-3210] Finalize PH1-M32 checkpoint and ANA-GATE-340 handoff` |

The git object for **ANA-3210** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-3210]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-3210` commit).
- **Outcomes**: `ok`, `nonzero_exit`, `signaled`, `timeout`, `spawn_failed` — wired through `LaunchTelemetry`, `run.json` (`terminal_launch_outcome` after `terminal_launch_ok`), transport fingerprint, `report` validation (including consistency with `terminal_launch_ok` / exit code / error tag), and `compare` `RunMeta` / metadata deltas.

## References

- `docs/todo/PH1_M32_TICKETS.md`
- `docs/TERMINAL_LAUNCH_SEMANTICS_PLAN.md`
