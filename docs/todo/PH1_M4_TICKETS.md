# PH1-M4 Ticket Pack

Ticket authority for sprint `PH1-M4-S1`.

Objective: begin protocol-aware execution seams while keeping text-first artifacts and deterministic compare flows.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-401` — add `docs/PROTO_EXEC_PLAN.md` with PH1-M4 scope/non-goals and seam boundaries.
2. `ANA-402` — add `--dry-run` and `--strict` command flags contract to `docs/CLI.md` and implement parser hooks.
3. `ANA-403` — add execution mode model (`placeholder`, `protocol_stub`) and emit in `run.json`.
4. `ANA-404` — add protocol-stub runner seam module under `src/runner/` with deterministic fake observations.
5. `ANA-405` — thread execution mode through `run` and `run-suite` pipelines.
6. `ANA-406` — include execution mode in markdown summary and compare metadata deltas.
7. `ANA-407` — add schema validation rules for new execution mode field in report validator/tests.
8. `ANA-408` — add compare regression tests for mismatched execution mode metadata.
9. `ANA-409` — update `docs/SMOKE.md` with PH1-M4 protocol-stub regression path.
10. `ANA-410` — finalize PH1-M4-S1 checkpoint evidence and request Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-60`
- Trigger: after commit for `ANA-410`.
