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

### `PH1-M4` (`in_progress`)

Purpose:

- Introduce protocol-aware execution seams while preserving deterministic text-first artifacts.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M4_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- execution mode model + protocol-stub seam
- run/run-suite pipeline threading
- report/compare metadata + validation hardening for execution modes
- PH1-M4 smoke and checkpoint evidence

Acceptance criteria:

- tickets `ANA-401` through `ANA-410` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-60` reached and reported.

Non-goals:

- full PTY/ConPTY automation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-401` through `ANA-410` in order from `docs/todo/PH1_M4_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-60` (post `ANA-410`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M4_CHECKPOINT.md`.

### `PH1-M5` (`pending`)

Purpose:

- start real terminal transport ownership after PH1-M4 acceptance.
