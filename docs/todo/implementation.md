# Implementation Queue

## Milestones

### `PH1-M0` (`completed`)

Purpose:

- Establish operational workflow infrastructure for single and dual agent execution so implementation work can proceed without process ambiguity.

Outcome:

- Completed and accepted as baseline.
- Refocused into `PH1-M1` execution sprint.

### `PH1-M1` (`in_progress`)

Purpose:

- Build phase-1 harness scaffolding and command surface using strict ticketed execution.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M1_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- harness repo scaffolding
- docs contracts (`DESIGN`, `DSL`, `REPORT_FORMAT`, `CLI`)
- zig project bootstrap and CLI stubs
- DSL discovery/loading/validation seams
- run/capture/report scaffolding seams
- five seed probes
- end-to-end placeholder artifact emission

Acceptance criteria:

- tickets `ANA-101` through `ANA-120` are implemented with one commit each.
- commit subject for each ticket uses `[ANA-###]` prefix.
- sprint checkpoint doc exists (`docs/todo/PH1_M1_CHECKPOINT.md`).
- `ANA-GATE-20` reached and reported for Architect review.

Non-goals:

- deep terminal PTY/ConPTY automation
- screenshot/OCR workflows
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-101` through `ANA-120` in order from `docs/todo/PH1_M1_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-20` (post `ANA-120`) unless truly blocked.
- [x] Submit checkpoint review packet in `docs/todo/PH1_M1_CHECKPOINT.md`.

### `PH1-M2` (`pending`)

Purpose:

- Begin first real terminal comparison lane after scaffold acceptance.

Acceptance criteria:

- defined after `PH1-M1` Architect review.
