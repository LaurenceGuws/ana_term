# PH1-M8 Checkpoint

Sprint: `PH1-M8-S1`  
Super-gate: `ANA-GATE-100`

Status: **Engineering complete** — awaiting Architect review at `ANA-GATE-100`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-801 | `f3a6890` | `[ANA-801] add PTY experiment hardening plan for PH1-M8` |
| ANA-802 | `e5234e5` | `[ANA-802] document PH1-M8 PTY telemetry in report and CLI` |
| ANA-803 | `04dbfdf` | `[ANA-803] add RunContext fields for PTY experiment telemetry` |
| ANA-804 | `49e23f1` | `[ANA-804] emit PTY attempt and elapsed telemetry in run.json` |
| ANA-805 | `1e911f7` | `[ANA-805] validate PTY attempt and elapsed transport fields` |
| ANA-806 | `ef753d0` | `[ANA-806] compare metadata for PTY attempt and elapsed fields` |
| ANA-807 | `578b90f` | `[ANA-807] expand unit tests for PTY errors and guarded preflight` |
| ANA-808 | `0844eea` | `[ANA-808] add regression tests for PTY telemetry validation and compare parse` |
| ANA-809 | `7e72ec9` | `[ANA-809] document PH1-M8 PTY telemetry smoke checks` |

`ANA-810` is the commit with subject `[ANA-810] finalize PH1-M8-S1 checkpoint and ticket pack` (search `git log --grep 'ANA-810'`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux.
- Guarded full run: **`report`** **0**; **`transport.pty_experiment_attempt`** **`1`**; **`pty_experiment_elapsed_ns`** non-negative.
- Preflight and dry-run behavior unchanged from PH1-M7.

## References

- `docs/todo/PH1_M8_TICKETS.md`
- `docs/PTY_EXPERIMENT_HARDENING_PLAN.md`
