# PH1-M21 Ticket Pack

Ticket authority for sprint `PH1-M21-S1`.

Objective: improve run-level audit integrity by adding deterministic run-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2101` — add `docs/RUN_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M21 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2102` — document PH1-M21 run-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2103` — extend `RunContext` with root run-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2104` — emit run-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2105` — enforce run-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2106` — extend compare metadata extraction/diff rows for run-envelope fingerprint fields.
7. `ANA-2107` — add/expand unit tests for run-envelope fingerprint generation and determinism.
8. `ANA-2108` — add regression tests for report/compare parsing and run-envelope fingerprint delta output.
9. `ANA-2109` — update `docs/SMOKE.md` with PH1-M21 run-envelope fingerprint regression checks.
10. `ANA-2110` — finalize `docs/todo/PH1_M21_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-230`
- Trigger: after commit for `ANA-2110`.
