# PH1-M14 Ticket Pack

Ticket authority for sprint `PH1-M14-S1`.

Objective: improve run reproducibility auditing by adding deterministic transport-fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1401` — add `docs/TRANSPORT_FINGERPRINT_PLAN.md` with PH1-M14 boundaries, risks, and acceptance checks.
2. `ANA-1402` — document PH1-M14 transport-fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1403` — extend `RunContext` with root transport-fingerprint fields and deterministic populate seam.
4. `ANA-1404` — emit transport-fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1405` — enforce transport-fingerprint invariants in `report` schema validation.
6. `ANA-1406` — extend compare metadata extraction/diff rows for transport-fingerprint fields.
7. `ANA-1407` — add/expand unit tests for transport-fingerprint generation and determinism.
8. `ANA-1408` — add regression tests for report/compare parsing and transport-fingerprint delta output.
9. `ANA-1409` — update `docs/SMOKE.md` with PH1-M14 transport-fingerprint regression checks.
10. `ANA-1410` — finalize `docs/todo/PH1_M14_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-160`
- Trigger: after commit for `ANA-1410`.
