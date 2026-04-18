# PH1-M10 Ticket Pack

Ticket authority for sprint `PH1-M10-S1`.

Objective: improve run reproducibility evidence by adding deterministic host identity fields and surfacing them consistently in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1001` — add `docs/HOST_IDENTITY_PLAN.md` with PH1-M10 boundaries, risks, and acceptance checks.
2. `ANA-1002` — document PH1-M10 host identity fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1003` — extend `RunContext` with host identity fields for full runs.
4. `ANA-1004` — emit host identity fields in `run.json` root metadata with deterministic serialization.
5. `ANA-1005` — enforce host identity field invariants in `report` schema validation.
6. `ANA-1006` — extend compare metadata extraction/diff rows for host identity fields.
7. `ANA-1007` — add/expand unit tests for host identity capture and nullability rules.
8. `ANA-1008` — add regression tests for report/compare parsing and host identity diff output.
9. `ANA-1009` — update `docs/SMOKE.md` with PH1-M10 host identity regression steps.
10. `ANA-1010` — finalize `docs/todo/PH1_M10_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-120`
- Trigger: after commit for `ANA-1010`.
