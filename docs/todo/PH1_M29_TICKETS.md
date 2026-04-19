# PH1-M29 Ticket Pack

Ticket authority for sprint `PH1-M29-S1`.

Objective: improve lineage-level audit coverage by adding deterministic lineage-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2901` — add `docs/LINEAGE_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M29 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2902` — document PH1-M29 lineage-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2903` — extend `RunContext` with root lineage-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2904` — emit lineage-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2905` — enforce lineage-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2906` — extend compare metadata extraction/diff rows for lineage-envelope fingerprint fields.
7. `ANA-2907` — add/expand unit tests for lineage-envelope fingerprint generation and determinism.
8. `ANA-2908` — add regression tests for report/compare parsing and lineage-envelope fingerprint delta output.
9. `ANA-2909` — update `docs/SMOKE.md` with PH1-M29 lineage-envelope fingerprint regression checks.
10. `ANA-2910` — finalize `docs/todo/PH1_M29_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-310`
- Trigger: after commit for `ANA-2910`.
