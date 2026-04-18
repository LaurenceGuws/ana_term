# PH1-M15 Ticket Pack

Ticket authority for sprint `PH1-M15-S1`.

Objective: improve replay traceability by adding deterministic execution-summary fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1501` — add `docs/EXEC_SUMMARY_FINGERPRINT_PLAN.md` with PH1-M15 boundaries, risks, and acceptance checks.
2. `ANA-1502` — document PH1-M15 execution-summary fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1503` — extend `RunContext` with root execution-summary fingerprint fields and deterministic populate seam.
4. `ANA-1504` — emit execution-summary fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1505` — enforce execution-summary fingerprint invariants in `report` schema validation.
6. `ANA-1506` — extend compare metadata extraction/diff rows for execution-summary fingerprint fields.
7. `ANA-1507` — add/expand unit tests for execution-summary fingerprint generation and determinism.
8. `ANA-1508` — add regression tests for report/compare parsing and execution-summary fingerprint delta output.
9. `ANA-1509` — update `docs/SMOKE.md` with PH1-M15 execution-summary fingerprint regression checks.
10. `ANA-1510` — finalize `docs/todo/PH1_M15_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-170`
- Trigger: after commit for `ANA-1510`.
