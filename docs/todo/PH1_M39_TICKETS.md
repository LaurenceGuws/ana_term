# PH1-M39 Ticket Pack

Ticket authority for sprint `PH1-M39-S1`.

Objective: harden launch diagnostics fingerprint canonicalization so normalization drift is prevented across run emission, schema validation, and compare metadata.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3901` — add `docs/LAUNCH_DIAGNOSTICS_CANONICALIZATION_PLAN.md` with PH1-M39 boundaries, normalization rules, and acceptance checks.
2. `ANA-3902` — document PH1-M39 canonicalization invariants in `docs/CLI.md` and `docs/REPORT_FORMAT.md`.
3. `ANA-3903` — add canonicalization helper types for diagnostics fingerprint input normalization.
4. `ANA-3904` — implement canonical normalization logic for reason/elapsed/signal fingerprint inputs.
5. `ANA-3905` — thread canonicalized inputs through fingerprint populate and run pipeline seams.
6. `ANA-3906` — enforce PH1-M39 canonicalization invariants in `run_json_validate` schema checks.
7. `ANA-3907` — extend compare parsing/diff metadata for canonicalization edge-case evidence.
8. `ANA-3908` — add unit tests for canonicalization determinism and drift prevention.
9. `ANA-3909` — add regression tests + `docs/SMOKE.md` updates for canonicalization mismatches.
10. `ANA-3910` — finalize `docs/todo/PH1_M39_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-410`
- Trigger: after commit for `ANA-3910`.
