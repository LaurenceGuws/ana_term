# PH1-M18 Ticket Pack

Ticket authority for sprint `PH1-M18-S1`.

Objective: improve artifact integrity auditing by adding deterministic artifact-bundle fingerprint fields and surfacing them in report/compare outputs.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1801` — add `docs/ARTIFACT_BUNDLE_FINGERPRINT_PLAN.md` with PH1-M18 boundaries, canonical payload, risks, and acceptance checks.
2. `ANA-1802` — document PH1-M18 artifact-bundle fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1803` — extend `RunContext` with root artifact-bundle fingerprint fields and deterministic populate seam.
4. `ANA-1804` — emit artifact-bundle fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1805` — enforce artifact-bundle fingerprint invariants in `report` schema validation.
6. `ANA-1806` — extend compare metadata extraction/diff rows for artifact-bundle fingerprint fields.
7. `ANA-1807` — add/expand unit tests for artifact-bundle fingerprint generation and determinism.
8. `ANA-1808` — add regression tests for report/compare parsing and artifact-bundle fingerprint delta output.
9. `ANA-1809` — update `docs/SMOKE.md` with PH1-M18 artifact-bundle fingerprint regression checks.
10. `ANA-1810` — finalize `docs/todo/PH1_M18_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-200`
- Trigger: after commit for `ANA-1810`.
