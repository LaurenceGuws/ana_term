# PH1-M40 Ticket Pack

Ticket authority for sprint `PH1-M40-S1`.

Objective: add a launch diagnostics compatibility envelope so compatibility status is deterministic and diffable across run emission, schema validation, and compare metadata.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-4001` — add `docs/LAUNCH_DIAGNOSTICS_COMPATIBILITY_PLAN.md` with PH1-M40 boundaries, envelope model, and acceptance checks.
2. `ANA-4002` — document compatibility envelope fields/invariants in `docs/CLI.md` and `docs/REPORT_FORMAT.md`.
3. `ANA-4003` — add compatibility envelope fields to `RunContext` and helper types.
4. `ANA-4004` — implement compatibility envelope populate logic from canonicalized diagnostics inputs.
5. `ANA-4005` — emit compatibility envelope root fields in `run.json` and summary output.
6. `ANA-4006` — enforce compatibility envelope invariants in `run_json_validate` schema checks.
7. `ANA-4007` — extend compare `RunMeta` / `diffRunMeta` for compatibility envelope metadata deltas.
8. `ANA-4008` — add unit tests for compatibility envelope determinism and invariant enforcement.
9. `ANA-4009` — add regression tests + `docs/SMOKE.md` updates for compatibility envelope edge cases.
10. `ANA-4010` — finalize `docs/todo/PH1_M40_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-420`
- Trigger: after commit for `ANA-4010`.
