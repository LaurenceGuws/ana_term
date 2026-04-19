# PH1-M32 Ticket Pack

Ticket authority for sprint `PH1-M32-S1`.

Objective: harden real terminal launch semantics so `run.json`, `report`, and `compare` remain deterministic and operator-useful across success, timeout, and non-zero exit paths.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3201` — add `docs/TERMINAL_LAUNCH_SEMANTICS_PLAN.md` with PH1-M32 boundaries, outcome taxonomy, risks, and acceptance checks.
2. `ANA-3202` — document PH1-M32 launch outcome semantics and invariants in `docs/REPORT_FORMAT.md` and `docs/CLI.md`.
3. `ANA-3203` — refine launch telemetry model for explicit outcome classes (`ok`, `timeout`, `spawn_failed`, `nonzero_exit`, `signaled`).
4. `ANA-3204` — update Linux launch seam to map child termination and timeout paths into the PH1-M32 outcome classes deterministically.
5. `ANA-3205` — wire launch outcome classes through guarded full-run pipeline and preserve fail-closed rules.
6. `ANA-3206` — emit stabilized launch outcome fields in `run.json` and include canonical lines in transport fingerprint payload.
7. `ANA-3207` — enforce PH1-M32 launch outcome invariants in `report` schema validation.
8. `ANA-3208` — extend compare metadata extraction/diff rows for launch outcome semantics.
9. `ANA-3209` — add/expand unit + regression tests for timeout/non-zero/signal launch outcomes and compare/report parsing.
10. `ANA-3210` — finalize `docs/todo/PH1_M32_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-340`
- Trigger: after commit for `ANA-3210`.
