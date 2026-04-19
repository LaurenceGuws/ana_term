# PH1-M27 Ticket Pack

Ticket authority for sprint `PH1-M27-S1`.

Objective: improve consistency-level audit coverage by adding deterministic consistency-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2701` — add `docs/CONSISTENCY_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M27 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2702` — document PH1-M27 consistency-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2703` — extend `RunContext` with root consistency-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2704` — emit consistency-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2705` — enforce consistency-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2706` — extend compare metadata extraction/diff rows for consistency-envelope fingerprint fields.
7. `ANA-2707` — add/expand unit tests for consistency-envelope fingerprint generation and determinism.
8. `ANA-2708` — add regression tests for report/compare parsing and consistency-envelope fingerprint delta output.
9. `ANA-2709` — update `docs/SMOKE.md` with PH1-M27 consistency-envelope fingerprint regression checks.
10. `ANA-2710` — finalize `docs/todo/PH1_M27_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-290`
- Trigger: after commit for `ANA-2710`.
