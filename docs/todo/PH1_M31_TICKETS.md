# PH1-M31 Ticket Pack

Ticket authority for sprint `PH1-M31-S1`.

Objective: establish a first real-terminal launch lane that records deterministic process-level evidence while preserving text-first report and compare contracts.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3101` — add `docs/REAL_TERMINAL_LAUNCH_PLAN.md` with PH1-M31 boundaries, launch model, risks, and acceptance checks.
2. `ANA-3102` — document PH1-M31 real-launch fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-3103` — extend `RunContext` with real-launch telemetry fields and deterministic defaults.
4. `ANA-3104` — add a terminal launcher seam that executes `--terminal-cmd` with bounded timeout and stable exit/error mapping.
5. `ANA-3105` — wire real-launch seam into guarded full-run pipeline with fail-closed behavior when launch prerequisites are missing.
6. `ANA-3106` — emit real-launch telemetry fields in `run.json` root/transport metadata with stable serialization order.
7. `ANA-3107` — enforce real-launch telemetry invariants in `report` schema validation.
8. `ANA-3108` — extend compare metadata extraction/diff rows for real-launch telemetry fields.
9. `ANA-3109` — add/expand unit and regression tests for launcher behavior plus report/compare parsing of launch telemetry.
10. `ANA-3110` — finalize `docs/todo/PH1_M31_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-330`
- Trigger: after commit for `ANA-3110`.
