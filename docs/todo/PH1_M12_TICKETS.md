# PH1-M12 Ticket Pack

Ticket authority for sprint `PH1-M12-S1`.

Objective: improve suite integrity audits by adding deterministic spec-set fingerprint fields and compare/report surfacing.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1201` — add `docs/SPECSET_FINGERPRINT_PLAN.md` with PH1-M12 boundaries, risks, and acceptance checks.
2. `ANA-1202` — document PH1-M12 spec-set fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1203` — extend `RunContext` with root spec-set fingerprint fields and deterministic populate seam.
4. `ANA-1204` — emit spec-set fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1205` — enforce spec-set fingerprint invariants in `report` schema validation.
6. `ANA-1206` — extend compare metadata extraction/diff rows for spec-set fingerprint fields.
7. `ANA-1207` — add/expand unit tests for spec-set fingerprint generation and determinism.
8. `ANA-1208` — add regression tests for report/compare parsing and spec-set fingerprint delta output.
9. `ANA-1209` — update `docs/SMOKE.md` with PH1-M12 spec-set fingerprint regression checks.
10. `ANA-1210` — finalize `docs/todo/PH1_M12_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-140`
- Trigger: after commit for `ANA-1210`.
