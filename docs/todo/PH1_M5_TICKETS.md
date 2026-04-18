# PH1-M5 Ticket Pack

Ticket authority for sprint `PH1-M5-S1`.

Objective: begin real terminal transport ownership seams (still text-first), focusing on controlled launch/handshake scaffolding and evidence contracts.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-501` — add `docs/TRANSPORT_PLAN.md` with PH1-M5 scope/non-goals and safety boundaries.
2. `ANA-502` — define transport config contract in `docs/CLI.md` (`--transport`, `--timeout-ms`).
3. `ANA-503` — add transport mode enum (`none`, `pty_stub`) and run context threading.
4. `ANA-504` — add `src/runner/transport_stub.zig` with deterministic handshake and timing fields.
5. `ANA-505` — thread transport mode into run/run-suite and include transport metadata in `run.json`.
6. `ANA-506` — extend report validator for transport metadata schema.
7. `ANA-507` — extend compare metadata deltas with transport fields and tests.
8. `ANA-508` — add focused tests for transport schema/compare behavior.
9. `ANA-509` — update `docs/SMOKE.md` with PH1-M5 transport-stub regression steps.
10. `ANA-510` — finalize PH1-M5-S1 checkpoint evidence and request Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-70`
- Trigger: after commit for `ANA-510`.
