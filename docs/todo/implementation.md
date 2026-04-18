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

### `PH1-M7` (`completed`)

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

Outcome:

- Accepted at `ANA-GATE-90`.

### `PH1-M8` (`review_gate`)

Purpose:

- Stabilize the guarded Linux PTY experiment by adding deterministic experiment metadata, stricter invariants, and repeatable smoke evidence.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M8_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- document PH1-M8 experiment hardening boundaries
- add deterministic PTY experiment telemetry fields in `run.json`
- validate/report/compare coverage for new PTY experiment telemetry
- expand regression tests for Linux-only guarded path
- PH1-M8 smoke and checkpoint evidence

Acceptance criteria:

- tickets `ANA-801` through `ANA-810` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-100` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-801` through `ANA-810` in order from `docs/todo/PH1_M8_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-100` (post `ANA-810`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M8_CHECKPOINT.md`.

### `PH1-M9` (`review_gate`)

Purpose:

- Harden guarded PTY experiment reproducibility with deterministic environment capture and clearer failure evidence.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M9_TICKETS.md`
- `docs/todo/PH1_M9_CORRECTIVE_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- document PH1-M9 reproducibility plan and boundaries
- add deterministic PTY experiment environment snapshot fields in artifacts
- add report/compare invariants for reproducibility fields
- expand regression coverage for failure-path evidence formatting
- PH1-M9 smoke and checkpoint evidence

Acceptance criteria:

- tickets `ANA-901` through `ANA-910` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-110` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-901` through `ANA-910` in order from `docs/todo/PH1_M9_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-110` (post `ANA-910`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M9_CHECKPOINT.md`.

Corrective queue lines (post review rejection):

- [x] Execute `ANA-911` through `ANA-913` in order from `docs/todo/PH1_M9_CORRECTIVE_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-110` (post `ANA-913`) unless truly blocked.
- [x] Update `docs/todo/PH1_M9_CHECKPOINT.md` with corrective evidence and re-request Architect review.
