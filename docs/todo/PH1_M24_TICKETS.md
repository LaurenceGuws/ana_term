# PH1-M24 Ticket Pack

Ticket authority for sprint `PH1-M24-S1`.

Objective: improve artifact-level audit integrity by adding deterministic artifact-manifest fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-2401` — add `docs/ARTIFACT_MANIFEST_FINGERPRINT_PLAN.md` with PH1-M24 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-2402` — document PH1-M24 artifact-manifest fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-2403` — extend `RunContext` with root artifact-manifest fingerprint fields and deterministic populate seam.
4. `ANA-2404` — emit artifact-manifest fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-2405` — enforce artifact-manifest fingerprint invariants in `report` schema validation.
6. `ANA-2406` — extend compare metadata extraction/diff rows for artifact-manifest fingerprint fields.
7. `ANA-2407` — add/expand unit tests for artifact-manifest fingerprint generation and determinism.
8. `ANA-2408` — add regression tests for report/compare parsing and artifact-manifest fingerprint delta output.
9. `ANA-2409` — update `docs/SMOKE.md` with PH1-M24 artifact-manifest fingerprint regression checks.
10. `ANA-2410` — finalize `docs/todo/PH1_M24_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-260`
- Trigger: after commit for `ANA-2410`.
