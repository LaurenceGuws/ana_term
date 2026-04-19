# PH1-M33 Ticket Pack

Ticket authority for sprint `PH1-M33-S1`.

Objective: add deterministic terminal profile adapters so named local terminals (kitty, ghostty, konsole, zide-terminal) resolve to stable launch commands and comparable metadata.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3301` — add `docs/TERMINAL_PROFILE_ADAPTER_PLAN.md` with PH1-M33 boundaries, adapter model, risks, and acceptance checks.
2. `ANA-3302` — document profile adapter behavior and precedence in `docs/CLI.md` and `docs/REPORT_FORMAT.md`.
3. `ANA-3303` — add profile adapter model + resolver seam (`terminal id` -> `resolved command template`) for kitty/ghostty/konsole/zide-terminal.
4. `ANA-3304` — wire resolver into run context setup with explicit precedence (`--terminal-cmd` override > profile > fallback terminal id).
5. `ANA-3305` — emit resolved profile metadata in `run.json` / summary output (profile id, resolved command source, resolved command).
6. `ANA-3306` — enforce profile metadata invariants in `report` schema validation.
7. `ANA-3307` — extend compare `RunMeta` / diff rows for profile metadata fields.
8. `ANA-3308` — add unit tests for profile resolution and precedence rules.
9. `ANA-3309` — add regression tests for report/compare profile metadata parsing and deltas; update `docs/SMOKE.md` local multi-terminal path.
10. `ANA-3310` — finalize `docs/todo/PH1_M33_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-350`
- Trigger: after commit for `ANA-3310`.
