# PH1-M8 Ticket Pack

Ticket authority for sprint `PH1-M8-S1`.

Objective: harden the Linux-only guarded PTY experiment with deterministic telemetry and stricter evidence invariants while preserving fail-closed defaults.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-801` — add `docs/PTY_EXPERIMENT_HARDENING_PLAN.md` with PH1-M8 boundaries, risks, and acceptance checks.
2. `ANA-802` — document PH1-M8 telemetry fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-803` — add deterministic PTY experiment timing/attempt metadata model to `RunContext`.
4. `ANA-804` — emit PH1-M8 telemetry fields in `run.json` transport object (stable key order, nullable rules).
5. `ANA-805` — enforce PH1-M8 transport telemetry invariants in `report` schema validation.
6. `ANA-806` — extend compare metadata extraction/diff rows for PH1-M8 telemetry fields.
7. `ANA-807` — add/expand unit tests for Linux guarded preflight and PTY experiment result shaping.
8. `ANA-808` — add/expand report+compare regression tests for PH1-M8 telemetry fields.
9. `ANA-809` — update `docs/SMOKE.md` with PH1-M8 hardened guarded PTY regression steps.
10. `ANA-810` — finalize `docs/todo/PH1_M8_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-100`
- Trigger: after commit for `ANA-810`.
