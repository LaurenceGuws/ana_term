# PH1-M25 Ticket Pack

Ticket authority for sprint `PH1-M25-S1`.

Objective: improve provenance-level audit integrity by adding deterministic provenance-envelope fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2501` — add `docs/PROVENANCE_ENVELOPE_FINGERPRINT_PLAN.md` with PH1-M25 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2502` — document PH1-M25 provenance-envelope fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2503` — extend `RunContext` with root provenance-envelope fingerprint fields and deterministic populate seam.
4. `ANA-2504` — emit provenance-envelope fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2505` — enforce provenance-envelope fingerprint invariants in `report` schema validation.
6. `ANA-2506` — extend compare metadata extraction/diff rows for provenance-envelope fingerprint fields.
7. `ANA-2507` — add/expand unit tests for provenance-envelope fingerprint generation and determinism.
8. `ANA-2508` — add regression tests for report/compare parsing and provenance-envelope fingerprint delta output.
9. `ANA-2509` — update `docs/SMOKE.md` with PH1-M25 provenance-envelope fingerprint regression checks.
10. `ANA-2510` — finalize `docs/todo/PH1_M25_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-270`
- Trigger: after commit for `ANA-2510`.
