# Implementation Queue

## Milestones

### `PH1-M0` (`completed`)

Purpose:

- Establish operational workflow infrastructure for single and dual agent execution.

### `PH1-M1` (`completed`)

Purpose:

- Build phase-1 harness scaffolding and command surface.

Outcome:

- Accepted at architect gate after corrective closeout (`ANA-121`..`ANA-123`).

### `PH1-M2` (`in_progress`)

Purpose:

- Deliver first real terminal comparison lane on one OS across at least two terminals.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M2_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- `run-suite` implementation with baseline suite manifest
- terminal target model + metadata capture
- `compare` command + markdown/json comparison outputs
- PH1-M2 checkpoint evidence

Acceptance criteria:

- tickets `ANA-201` through `ANA-220` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-40` reached and reported.

Non-goals:

- full PTY/ConPTY protocol automation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-201` through `ANA-220` in order from `docs/todo/PH1_M2_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-40` (post `ANA-220`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M2_CHECKPOINT.md`.

### `PH1-M3` (`pending`)

Purpose:

- deepen probe correctness and platform coverage after comparison lane acceptance.
