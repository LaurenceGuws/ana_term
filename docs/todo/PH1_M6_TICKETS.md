# PH1-M6 Ticket Pack

Ticket authority for sprint `PH1-M6-S1`.

Objective: prototype guarded real-transport scaffolding behind explicit opt-in while preserving deterministic artifacts and safety defaults.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-601` — add `docs/REAL_TRANSPORT_GUARD_PLAN.md` with guardrails, threat model, and PH1-M6 boundaries.
2. `ANA-602` — add CLI contract for `--transport pty_guarded` and required opt-in flag/env gate.
3. `ANA-603` — extend `transport_mode` enum with `pty_guarded` and keep default `none`.
4. `ANA-604` — add guarded transport preflight module (fail-closed unless explicit opt-in).
5. `ANA-605` — thread guarded transport checks through run/run-suite without opening PTY yet.
6. `ANA-606` — emit guarded-transport state fields in `run.json` transport object.
7. `ANA-607` — extend report schema validation for guarded transport fields and invariants.
8. `ANA-608` — extend compare metadata rows/tests for guarded transport state.
9. `ANA-609` — update `docs/SMOKE.md` with guarded-transport negative/positive checks.
10. `ANA-610` — finalize PH1-M6-S1 checkpoint evidence and request Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-80`
- Trigger: after commit for `ANA-610`.
