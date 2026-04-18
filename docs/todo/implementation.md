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

### `PH1-M8` (`completed`)

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

Outcome:

- Accepted at `ANA-GATE-100`.

### `PH1-M9` (`completed`)

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

Outcome:

- Accepted at `ANA-GATE-110` after corrective closeout (`ANA-911`..`ANA-913`).

### `PH1-M10` (`completed`)

Purpose:

- Improve reproducibility evidence quality by adding deterministic run-host identity and compare/report surfacing for operator audits.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M10_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M10 host-identity evidence plan
- add host identity fields to run artifacts
- enforce schema invariants and compare metadata coverage for those fields
- add regression tests and smoke path updates
- PH1-M10 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1001` through `ANA-1010` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-120` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1001` through `ANA-1010` in order from `docs/todo/PH1_M10_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-120` (post `ANA-1010`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M10_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-120`.

### `PH1-M11` (`review_gate`)

Purpose:

- Harden cross-run auditability by adding deterministic run-fingerprint identity and surfacing it in report/compare outputs.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M11_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M11 run-fingerprint plan and boundaries
- emit deterministic root run fingerprint fields in `run.json`
- add schema invariants and compare metadata rows for fingerprint fields
- expand regression tests and smoke coverage
- PH1-M11 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1101` through `ANA-1110` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-130` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1101` through `ANA-1110` in order from `docs/todo/PH1_M11_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-130` (post `ANA-1110`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M11_CHECKPOINT.md`.

### `PH1-M12` (`completed`)

Purpose:

- Strengthen run provenance by adding deterministic spec-set fingerprint fields and compare visibility for suite integrity checks.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M12_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M12 spec-set fingerprint plan and boundaries
- emit root spec-set fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for spec-set fingerprint fields
- expand regression tests and smoke coverage
- PH1-M12 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1201` through `ANA-1210` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-140` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1201` through `ANA-1210` in order from `docs/todo/PH1_M12_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-140` (post `ANA-1210`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M12_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-140`.

### `PH1-M13` (`completed`)

Purpose:

- Improve artifact integrity auditing by adding deterministic results-set fingerprint fields and compare/report visibility.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M13_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M13 results-set fingerprint plan and boundaries
- emit root results-set fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for results-set fingerprint fields
- expand regression tests and smoke coverage
- PH1-M13 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1301` through `ANA-1310` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-150` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1301` through `ANA-1310` in order from `docs/todo/PH1_M13_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-150` (post `ANA-1310`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M13_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-150`.

### `PH1-M14` (`completed`)

Purpose:

- Improve run reproducibility auditing by adding deterministic transport-fingerprint fields and compare/report visibility.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M14_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M14 transport-fingerprint plan and boundaries
- emit root transport-fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for transport-fingerprint fields
- expand regression tests and smoke coverage
- PH1-M14 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1401` through `ANA-1410` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-160` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1401` through `ANA-1410` in order from `docs/todo/PH1_M14_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-160` (post `ANA-1410`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M14_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-160`.

### `PH1-M15` (`completed`)

Purpose:

- Improve replay traceability by adding deterministic execution-summary fingerprint fields and compare/report visibility.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M15_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M15 execution-summary fingerprint plan and boundaries
- emit root execution-summary fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for execution-summary fingerprint fields
- expand regression tests and smoke coverage
- PH1-M15 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1501` through `ANA-1510` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-170` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1501` through `ANA-1510` in order from `docs/todo/PH1_M15_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-170` (post `ANA-1510`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M15_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-170`.

### `PH1-M16` (`completed`)

Purpose:

- Improve execution reproducibility auditing by adding deterministic context-summary fingerprint fields and compare/report visibility.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M16_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M16 context-summary fingerprint plan and boundaries
- emit root context-summary fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for context-summary fingerprint fields
- expand regression tests and smoke coverage
- PH1-M16 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1601` through `ANA-1610` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-180` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1601` through `ANA-1610` in order from `docs/todo/PH1_M16_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-180` (post `ANA-1610`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M16_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-180`.

### `PH1-M17` (`completed`)

Purpose:

- Improve audit reproducibility with a deterministic metadata-envelope fingerprint that composes root execution metadata into one compare/report handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M17_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M17 metadata-envelope fingerprint plan and boundaries
- emit root metadata-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for metadata-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M17 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1701` through `ANA-1710` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-190` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1701` through `ANA-1710` in order from `docs/todo/PH1_M17_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-190` (post `ANA-1710`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M17_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-190`.

### `PH1-M18` (`completed`)

Purpose:

- Improve artifact integrity auditing with a deterministic artifact-bundle fingerprint that composes root metadata fingerprints into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M18_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M18 artifact-bundle fingerprint plan and boundaries
- emit root artifact-bundle fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for artifact-bundle fingerprint fields
- expand regression tests and smoke coverage
- PH1-M18 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1801` through `ANA-1810` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-200` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1801` through `ANA-1810` in order from `docs/todo/PH1_M18_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-200` (post `ANA-1810`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M18_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-200`.

### `PH1-M19` (`completed`)

Purpose:

- Improve run-report audit integrity with a deterministic report-envelope fingerprint that composes canonical report-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M19_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M19 report-envelope fingerprint plan and boundaries
- emit root report-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for report-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M19 checkpoint evidence

Acceptance criteria:

- tickets `ANA-1901` through `ANA-1910` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-210` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-1901` through `ANA-1910` in order from `docs/todo/PH1_M19_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-210` (post `ANA-1910`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M19_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-210`.

### `PH1-M20` (`review_gate`)

Purpose:

- Improve compare-output audit integrity with a deterministic compare-envelope fingerprint that composes canonical compare-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M20_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M20 compare-envelope fingerprint plan and boundaries
- emit root compare-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for compare-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M20 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2001` through `ANA-2010` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-220` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2001` through `ANA-2010` in order from `docs/todo/PH1_M20_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-220` (post `ANA-2010`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M20_CHECKPOINT.md`.

Outcome:

- Pending Architect review at `ANA-GATE-220`.
