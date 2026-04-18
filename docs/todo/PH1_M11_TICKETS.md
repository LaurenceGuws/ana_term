# PH1-M11 Ticket Pack

Ticket authority for sprint `PH1-M11-S1`.

Objective: improve auditability by introducing deterministic run-fingerprint fields in root artifacts and compare evidence.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-1101` — add `docs/RUN_FINGERPRINT_PLAN.md` with PH1-M11 boundaries, risks, and acceptance checks.
2. `ANA-1102` — document PH1-M11 run-fingerprint fields and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-1103` — extend `RunContext` with root run-fingerprint fields and deterministic population seam.
4. `ANA-1104` — emit run-fingerprint fields in `run.json` root metadata with stable serialization.
5. `ANA-1105` — enforce run-fingerprint field invariants in `report` schema validation.
6. `ANA-1106` — extend compare metadata extraction/diff rows for run-fingerprint fields.
7. `ANA-1107` — add/expand unit tests for run-fingerprint generation and nullability rules.
8. `ANA-1108` — add regression tests for report/compare parsing and run-fingerprint delta output.
9. `ANA-1109` — update `docs/SMOKE.md` with PH1-M11 run-fingerprint regression checks.
10. `ANA-1110` — finalize `docs/todo/PH1_M11_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-130`
- Trigger: after commit for `ANA-1110`.
