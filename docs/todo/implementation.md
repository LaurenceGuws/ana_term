# Implementation Queue

## Milestones

### `PH1-M0` (`completed`)

Purpose:

- Establish operational workflow infrastructure for single and dual agent execution.

### `PH1-M1` (`completed`)

Purpose:

- Build phase-1 harness scaffolding and command surface.

### `PH1-M2` (`completed`)

Purpose:

- Deliver first real terminal comparison lane on one OS across at least two terminals.

Outcome:

- Accepted at `ANA-GATE-40` after corrective governance closeout (`ANA-221`..`ANA-223`).

### `PH1-M3` (`completed`)

Purpose:

- Harden report/compare correctness checks and comparison evidence quality.

Outcome:

- Accepted at `ANA-GATE-50`.

### `PH1-M4` (`completed`)

Purpose:

- Introduce protocol-aware execution seams while preserving deterministic text-first artifacts.

Outcome:

- Accepted at `ANA-GATE-60`.

### `PH1-M5` (`in_progress`)

Purpose:

- Begin terminal transport ownership seams via deterministic stub transport contracts.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M5_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- transport mode model + stub transport seam
- run/run-suite transport metadata threading
- report/compare metadata + validation hardening for transport fields
- PH1-M5 smoke and checkpoint evidence

Acceptance criteria:

- tickets `ANA-501` through `ANA-510` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-70` reached and reported.

Non-goals:

- production PTY/ConPTY integration
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-501` through `ANA-510` in order from `docs/todo/PH1_M5_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-70` (post `ANA-510`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M5_CHECKPOINT.md`.

### `PH1-M6` (`pending`)

Purpose:

- evaluate transition from stub transport to guarded real transport prototype.
