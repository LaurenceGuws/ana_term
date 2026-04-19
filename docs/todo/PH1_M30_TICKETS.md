# PH1-M30 Ticket Pack

Ticket authority for sprint `PH1-M30-S1`.

Objective: improve state-level audit coverage by adding deterministic state-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3001` — add `docs/STATE_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M30 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-3002` — document PH1-M30 state-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-3003` — extend `RunContext` with root state-envelope fingerprint fields and deterministic populate seam.
4. `ANA-3004` — emit state-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-3005` — enforce state-envelope fingerprint invariants in `report` schema validation.
6. `ANA-3006` — extend compare metadata extraction/diff rows for state-envelope fingerprint fields.
7. `ANA-3007` — add/expand unit tests for state-envelope fingerprint generation and determinism.
8. `ANA-3008` — add regression tests for report/compare parsing and state-envelope fingerprint delta output.
9. `ANA-3009` — update `docs/SMOKE.md` with PH1-M30 state-envelope fingerprint regression checks.
10. `ANA-3010` — finalize `docs/todo/PH1_M30_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-320`
- Trigger: after commit for `ANA-3010`.
