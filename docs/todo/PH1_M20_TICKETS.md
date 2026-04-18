# PH1-M20 Ticket Pack

Ticket authority for sprint `PH1-M20-S1`.

Objective: improve compare-output audit integrity by adding deterministic compare-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2001` — add `docs/COMPARE_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M20 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2002` — document PH1-M20 compare-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2003` — extend `RunContext` with root compare-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2004` — emit compare-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2005` — enforce compare-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2006` — extend compare metadata extraction/diff rows for compare-envelope fingerprint fields.
7. `ANA-2007` — add/expand unit tests for compare-envelope fingerprint generation and determinism.
8. `ANA-2008` — add regression tests for report/compare parsing and compare-envelope fingerprint delta output.
9. `ANA-2009` — update `docs/SMOKE.md` with PH1-M20 compare-envelope fingerprint regression checks.
10. `ANA-2010` — finalize `docs/todo/PH1_M20_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-220`
- Trigger: after commit for `ANA-2010`.
