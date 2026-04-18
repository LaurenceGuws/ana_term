# PH1-M19 Ticket Pack

Ticket authority for sprint `PH1-M19-S1`.

Objective: improve run-report audit integrity by adding deterministic report-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1901` — add `docs/REPORT_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M19 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-1902` — document PH1-M19 report-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1903` — extend `RunContext` with root report-envelope fingerprint fields and deterministic populate seam.
4. `ANA-1904` — emit report-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1905` — enforce report-envelope fingerprint invariants in `report` schema validation.
6. `ANA-1906` — extend compare metadata extraction/diff rows for report-envelope fingerprint fields.
7. `ANA-1907` — add/expand unit tests for report-envelope fingerprint generation and determinism.
8. `ANA-1908` — add regression tests for report/compare parsing and report-envelope fingerprint delta output.
9. `ANA-1909` — update `docs/SMOKE.md` with PH1-M19 report-envelope fingerprint regression checks.
10. `ANA-1910` — finalize `docs/todo/PH1_M19_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-210`
- Trigger: after commit for `ANA-1910`.
