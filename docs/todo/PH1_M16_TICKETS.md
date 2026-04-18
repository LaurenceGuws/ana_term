# PH1-M16 Ticket Pack

Ticket authority for sprint `PH1-M16-S1`.

Objective: improve execution reproducibility auditing by adding deterministic context-summary fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1601` — add `docs/CONTEXT_SUMMARY_FINGERPRINT_PLAN.md` with PH1-M16 boundaries, risks, and acceptance checks.
2. `ANA-1602` — document PH1-M16 context-summary fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1603` — extend `RunContext` with root context-summary fingerprint fields and deterministic populate seam.
4. `ANA-1604` — emit context-summary fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1605` — enforce context-summary fingerprint invariants in `report` schema validation.
6. `ANA-1606` — extend compare metadata extraction/diff rows for context-summary fingerprint fields.
7. `ANA-1607` — add/expand unit tests for context-summary fingerprint generation and determinism.
8. `ANA-1608` — add regression tests for report/compare parsing and context-summary fingerprint delta output.
9. `ANA-1609` — update `docs/SMOKE.md` with PH1-M16 context-summary fingerprint regression checks.
10. `ANA-1610` — finalize `docs/todo/PH1_M16_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-180`
- Trigger: after commit for `ANA-1610`.
