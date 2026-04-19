# PH1-M37 Ticket Pack

Ticket authority for sprint `PH1-M37-S1`.

Objective: add deterministic launch failure diagnostics envelope data so guarded runs provide actionable, comparable failure evidence across artifacts and compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3701` — add `docs/LAUNCH_FAILURE_ENVELOPE_PLAN.md` defining PH1-M37 boundaries, failure taxonomy, and acceptance checks.
2. `ANA-3702` — document PH1-M37 diagnostics envelope fields in `docs/CLI.md` and `docs/REPORT_FORMAT.md`.
3. `ANA-3703` — add launch diagnostics envelope model/types in `RunContext` and runner seams.
4. `ANA-3704` — capture deterministic spawn/exec failure evidence on Linux guarded path.
5. `ANA-3705` — map launch termination paths to normalized diagnostics envelope reason tags.
6. `ANA-3706` — emit diagnostics envelope fields in `run.json` and summary; include canonical lines in transport fingerprint payload.
7. `ANA-3707` — enforce diagnostics envelope invariants in `report` schema validation and fixtures.
8. `ANA-3708` — extend compare `RunMeta` / `diffRunMeta` metadata rows for diagnostics envelope fields.
9. `ANA-3709` — add unit + regression tests for diagnostics envelope parsing and diff emission; update `docs/SMOKE.md`.
10. `ANA-3710` — finalize `docs/todo/PH1_M37_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-390`
- Trigger: after commit for `ANA-3710`.
