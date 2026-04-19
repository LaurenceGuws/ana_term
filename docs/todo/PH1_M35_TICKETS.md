# PH1-M35 Ticket Pack

Ticket authority for sprint `PH1-M35-S1`.

Objective: add deterministic launch preflight and availability evidence so missing binaries and launchability failures are visible in artifacts/report/compare.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3501` — add `docs/LAUNCH_PREFLIGHT_PLAN.md` with PH1-M35 boundaries, preflight checks, risks, and acceptance checks.
2. `ANA-3502` — document PH1-M35 preflight fields/invariants in `docs/CLI.md` and `docs/REPORT_FORMAT.md`.
3. `ANA-3503` — add preflight model/types for availability status and failure reason taxonomy.
4. `ANA-3504` — implement executable availability check for resolved argv[0] on Linux (`PATH`/absolute checks) with deterministic reason tags.
5. `ANA-3505` — wire preflight into guarded run pipeline before launch attempt; keep fail-closed behavior explicit.
6. `ANA-3506` — emit preflight evidence fields in `run.json`/summary and include canonical lines in transport fingerprint payload.
7. `ANA-3507` — enforce preflight evidence invariants in `report` schema validation.
8. `ANA-3508` — extend compare `RunMeta` / metadata diff rows for preflight evidence fields.
9. `ANA-3509` — add unit + regression tests for available/missing-binary paths and compare/report parsing; update `docs/SMOKE.md` preflight checks.
10. `ANA-3510` — finalize `docs/todo/PH1_M35_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-370`
- Trigger: after commit for `ANA-3510`.
