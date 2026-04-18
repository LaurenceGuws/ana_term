# PH1-M9 Ticket Pack

Ticket authority for sprint `PH1-M9-S1`.

Objective: harden guarded PTY experiment reproducibility and failure evidence so repeated runs are easier to audit and compare.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-901` — add `docs/PTY_REPRODUCIBILITY_PLAN.md` with PH1-M9 boundaries, risks, and acceptance checks.
2. `ANA-902` — document PH1-M9 reproducibility fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-903` — extend `RunContext` with reproducibility snapshot fields for guarded PTY experiments.
4. `ANA-904` — emit reproducibility snapshot fields in `run.json` transport metadata (stable key order, nullable rules).
5. `ANA-905` — enforce reproducibility transport invariants in `report` schema validation.
6. `ANA-906` — extend compare metadata extraction/diff rows for PH1-M9 reproducibility fields.
7. `ANA-907` — add/expand unit tests for reproducibility snapshot generation and guarded preflight invariants.
8. `ANA-908` — add regression tests for report/compare parsing and failure evidence formatting of PH1-M9 fields.
9. `ANA-909` — update `docs/SMOKE.md` with PH1-M9 reproducibility regression steps.
10. `ANA-910` — finalize `docs/todo/PH1_M9_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-110`
- Trigger: after commit for `ANA-910`.
