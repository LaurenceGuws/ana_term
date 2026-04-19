# PH1-M22 Ticket Pack

Ticket authority for sprint `PH1-M22-S1`.

Objective: improve session-level audit integrity by adding deterministic session-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2201` — add `docs/SESSION_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M22 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2202` — document PH1-M22 session-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2203` — extend `RunContext` with root session-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2204` — emit session-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2205` — enforce session-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2206` — extend compare metadata extraction/diff rows for session-envelope fingerprint fields.
7. `ANA-2207` — add/expand unit tests for session-envelope fingerprint generation and determinism.
8. `ANA-2208` — add regression tests for report/compare parsing and session-envelope fingerprint delta output.
9. `ANA-2209` — update `docs/SMOKE.md` with PH1-M22 session-envelope fingerprint regression checks.
10. `ANA-2210` — finalize `docs/todo/PH1_M22_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-240`
- Trigger: after commit for `ANA-2210`.
