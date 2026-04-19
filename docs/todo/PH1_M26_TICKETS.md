# PH1-M26 Ticket Pack

Ticket authority for sprint `PH1-M26-S1`.

Objective: improve integrity-level audit coverage by adding deterministic integrity-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2601` — add `docs/INTEGRITY_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M26 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2602` — document PH1-M26 integrity-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2603` — extend `RunContext` with root integrity-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2604` — emit integrity-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2605` — enforce integrity-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2606` — extend compare metadata extraction/diff rows for integrity-envelope fingerprint fields.
7. `ANA-2607` — add/expand unit tests for integrity-envelope fingerprint generation and determinism.
8. `ANA-2608` — add regression tests for report/compare parsing and integrity-envelope fingerprint delta output.
9. `ANA-2609` — update `docs/SMOKE.md` with PH1-M26 integrity-envelope fingerprint regression checks.
10. `ANA-2610` — finalize `docs/todo/PH1_M26_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-280`
- Trigger: after commit for `ANA-2610`.
