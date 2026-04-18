# PH1-M6 Checkpoint

Sprint: `PH1-M6-S1`  
Super-gate: `ANA-GATE-80`

Status: **Engineering complete** — awaiting Architect review at `ANA-GATE-80`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-601 | `6bb5e91` | `[ANA-601] add real transport guard plan and M6 board` |
| ANA-602 | `04b1520` | `[ANA-602] document pty_guarded and guarded transport opt-in CLI` |
| ANA-603 | `62ea5fe` | `[ANA-603] add pty_guarded to transport mode enum` |
| ANA-604 | `6c423a2` | `[ANA-604] add guarded transport preflight helpers` |
| ANA-605 | `c5a29fc` | `[ANA-605] wire guarded transport preflight into run paths` |
| ANA-606 | `2548cdf` | `[ANA-606] emit guarded transport fields in run artifacts` |
| ANA-607 | `92abf2d` | `[ANA-607] validate guarded transport fields in run.json schema` |
| ANA-608 | `f3b139f` | `[ANA-608] add guarded transport rows to compare metadata` |
| ANA-609 | `f8e9cf8` | `[ANA-609] document guarded transport smoke checks` |

`ANA-610` is the commit with subject `[ANA-610] finalize PH1-M6-S1 checkpoint and ticket pack` (search `git log --grep 'ANA-610'`).

## Engineer validation log

- `zig build` — pass
- `zig build test` — pass
- Guarded transport: `run-suite baseline-linux --transport pty_guarded` exits **2** without opt-in; with `--allow-guarded-transport`, `report` on the run directory exits **0** and `transport.guarded_state` is `scaffold_only`.

## Scope notes

- **No real PTY** is opened; `pty_guarded` uses deterministic stub handshake/latency compatible with JSON signed integer parsing (`handshake_latency_ns` clamped via modulo of `maxInt(i64)`).
- Ticket definitions: `docs/todo/PH1_M6_TICKETS.md`.
