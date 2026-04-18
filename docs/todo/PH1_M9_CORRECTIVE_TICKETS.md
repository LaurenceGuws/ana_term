# PH1-M9 Corrective Ticket Pack

Ticket authority for corrective batch after `ANA-GATE-110` rejection.

Objective: restore `zig build` green and close PH1-M9 with reproducibility fields intact.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-911` — fix `src/report/json_writer.zig` compile break in guarded host-field JSON escaping/writer usage.
2. `ANA-912` — add regression coverage for guarded host snapshot JSON serialization path and verify `zig build` + `zig build test`.
3. `ANA-913` — update board/checkpoint with corrective evidence and request Architect re-review at `ANA-GATE-110`.

## Super-Gate

- Gate ID: `ANA-GATE-110`
- Trigger: after commit for `ANA-913`.
