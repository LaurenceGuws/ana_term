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

### `PH1-M5` (`completed`)

Purpose:

- Begin terminal transport ownership seams via deterministic stub transport contracts.

Outcome:

- Accepted at `ANA-GATE-70`.

### `PH1-M6` (`completed`)

Purpose:

- Prototype guarded real-transport scaffolding behind explicit opt-in and fail-closed defaults.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M6_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- guarded transport mode + preflight gating
- transport metadata and schema invariants for guarded state
- compare visibility + tests for guarded state
- PH1-M6 smoke and checkpoint evidence

Acceptance criteria:

- tickets `ANA-601` through `ANA-610` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-80` reached and reported.

Non-goals:

- production PTY/ConPTY data plane
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-601` through `ANA-610` in order from `docs/todo/PH1_M6_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-80` (post `ANA-610`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M6_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-80`.

### `PH1-M7` (`review_gate`)

Purpose:

- Promote guarded scaffolding to a first minimal real PTY experiment behind existing fail-closed controls.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M7_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- real PTY experiment plan with Linux-first constraints
- explicit `guarded_state` promotion contract (`scaffold_only` -> `experiment_linux_pty`)
- minimal POSIX PTY open/close lane behind guarded opt-in
- run/report/compare evidence updates for experiment markers
- PH1-M7 smoke and checkpoint evidence

Acceptance criteria:

- tickets `ANA-701` through `ANA-710` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-90` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-701` through `ANA-710` in order from `docs/todo/PH1_M7_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-90` (post `ANA-710`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M7_CHECKPOINT.md`.

### `PH1-M8` (`pending`)

Purpose:

- (Architect to define next promotion after `ANA-GATE-90`.)
