# PH1-M36 Ticket Pack

Ticket authority for sprint `PH1-M36-S1`.

Objective: enforce launch preflight strictness and reason fidelity so preflight evidence, launch outcomes, and resolved path metadata remain deterministic and internally consistent.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3601` — add `docs/LAUNCH_PREFLIGHT_STRICTNESS_PLAN.md` defining PH1-M36 boundaries, reason-fidelity contract, and acceptance checks.
2. `ANA-3602` — document PH1-M36 strictness fields/invariants in `docs/CLI.md` and `docs/REPORT_FORMAT.md`.
3. `ANA-3603` — add strict reason-fidelity model updates in `RunContext` and launch/preflight seam types.
4. `ANA-3604` — normalize resolved executable path evidence for deterministic Linux emission (absolute/realpath policy + fallback tags).
5. `ANA-3605` — enforce preflight-to-launch reason consistency in guarded pipeline branches.
6. `ANA-3606` — emit strictness metadata updates in `run.json`/summary and include canonical lines in transport fingerprint payload.
7. `ANA-3607` — tighten `report` schema validation for reason-fidelity and path-normalization invariants.
8. `ANA-3608` — extend compare `RunMeta` / metadata diff rows for PH1-M36 strictness evidence.
9. `ANA-3609` — add unit + regression tests for preflight/launch reason consistency and path normalization; update `docs/SMOKE.md`.
10. `ANA-3610` — finalize `docs/todo/PH1_M36_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-380`
- Trigger: after commit for `ANA-3610`.
