# PH1-M17 Ticket Pack

Ticket authority for sprint `PH1-M17-S1`.

Objective: improve audit reproducibility by adding deterministic metadata-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1701` — add `docs/METADATA_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M17 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-1702` — document PH1-M17 metadata-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1703` — extend `RunContext` with root metadata-envelope fingerprint fields and deterministic populate seam.
4. `ANA-1704` — emit metadata-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1705` — enforce metadata-envelope fingerprint invariants in `report` schema validation.
6. `ANA-1706` — extend compare metadata extraction/diff rows for metadata-envelope fingerprint fields.
7. `ANA-1707` — add/expand unit tests for metadata-envelope fingerprint generation and determinism.
8. `ANA-1708` — add regression tests for report/compare parsing and metadata-envelope fingerprint delta output.
9. `ANA-1709` — update `docs/SMOKE.md` with PH1-M17 metadata-envelope fingerprint regression checks.
10. `ANA-1710` — finalize `docs/todo/PH1_M17_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-190`
- Trigger: after commit for `ANA-1710`.
