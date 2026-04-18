# PH1-M13 Ticket Pack

Ticket authority for sprint `PH1-M13-S1`.

Objective: improve artifact integrity auditing by adding deterministic results-set fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1301` — add `docs/RESULTSET_FINGERPRINT_PLAN.md` with PH1-M13 boundaries, risks, and acceptance checks.
2. `ANA-1302` — document PH1-M13 results-set fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1303` — extend `RunContext` with root results-set fingerprint fields and deterministic populate seam.
4. `ANA-1304` — emit results-set fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1305` — enforce results-set fingerprint invariants in `report` schema validation.
6. `ANA-1306` — extend compare metadata extraction/diff rows for results-set fingerprint fields.
7. `ANA-1307` — add/expand unit tests for results-set fingerprint generation and determinism.
8. `ANA-1308` — add regression tests for report/compare parsing and results-set fingerprint delta output.
9. `ANA-1309` — update `docs/SMOKE.md` with PH1-M13 results-set fingerprint regression checks.
10. `ANA-1310` — finalize `docs/todo/PH1_M13_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-150`
- Trigger: after commit for `ANA-1310`.
