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

### `PH1-M3` (`in_progress`)

Purpose:

- Harden report/compare correctness checks and comparison evidence quality.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M3_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- report schema validation hardening
- compare input validation hardening
- metadata-level comparison output improvements
- targeted regression tests and updated smoke guidance

Acceptance criteria:

- tickets `ANA-301` through `ANA-310` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-50` reached and reported.

Non-goals:

- deep PTY/ConPTY automation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-301` through `ANA-310` in order from `docs/todo/PH1_M3_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-50` (post `ANA-310`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M3_CHECKPOINT.md`.

### `PH1-M4` (`pending`)

Purpose:

- start protocol-aware execution lane after PH1-M3 acceptance.
