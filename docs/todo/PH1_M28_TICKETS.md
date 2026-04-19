# PH1-M28 Ticket Pack

Ticket authority for sprint `PH1-M28-S1`.

Objective: improve trace-level audit coverage by adding deterministic trace-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2801` — add `docs/TRACE_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M28 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2802` — document PH1-M28 trace-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2803` — extend `RunContext` with root trace-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2804` — emit trace-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2805` — enforce trace-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2806` — extend compare metadata extraction/diff rows for trace-envelope fingerprint fields.
7. `ANA-2807` — add/expand unit tests for trace-envelope fingerprint generation and determinism.
8. `ANA-2808` — add regression tests for report/compare parsing and trace-envelope fingerprint delta output.
9. `ANA-2809` — update `docs/SMOKE.md` with PH1-M28 trace-envelope fingerprint regression checks.
10. `ANA-2810` — finalize `docs/todo/PH1_M28_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-300`
- Trigger: after commit for `ANA-2810`.
