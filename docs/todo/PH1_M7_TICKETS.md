# PH1-M7 Ticket Pack

Ticket authority for sprint `PH1-M7-S1`.

Objective: promote guarded transport from scaffold-only metadata to a first minimal Linux PTY experiment while preserving fail-closed defaults and deterministic reporting.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-701` — add `docs/PTY_EXPERIMENT_PLAN.md` with Linux-first constraints, safety boundaries, and explicit non-goals.
2. `ANA-702` — document guarded-state promotion contract in `docs/CLI.md` and `docs/REPORT_FORMAT.md` (`scaffold_only` and `experiment_linux_pty`).
3. `ANA-703` — add POSIX PTY seam module and typed error model (open/close only; no interactive workload loop).
4. `ANA-704` — implement guarded real-PTY preflight path gated by existing opt-in controls.
5. `ANA-705` — thread minimal PTY experiment execution through `run`/`run-suite` guarded mode.
6. `ANA-706` — emit experiment evidence fields in `run.json` transport metadata (PTY open result + capability notes).
7. `ANA-707` — extend `report` schema validation for promoted guarded-state invariants and experiment fields.
8. `ANA-708` — extend `compare` metadata extraction/diff rows and tests for PTY experiment fields.
9. `ANA-709` — update `docs/SMOKE.md` with PH1-M7 guarded real-PTY regression path (negative and positive checks).
10. `ANA-710` — finalize `docs/todo/PH1_M7_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-90`
- Trigger: after commit for `ANA-710`.
