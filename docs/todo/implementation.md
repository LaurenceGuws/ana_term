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

### `PH1-M20` (`completed`)

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

- Accepted at `ANA-GATE-220`.

### `PH1-M21` (`completed`)

Purpose:

- Improve run-level audit integrity with a deterministic run-envelope fingerprint that composes canonical run-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M21_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M21 run-envelope fingerprint plan and boundaries
- emit root run-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for run-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M21 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2101` through `ANA-2110` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-230` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2101` through `ANA-2110` in order from `docs/todo/PH1_M21_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-230` (post `ANA-2110`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M21_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-230`.

### `PH1-M22` (`completed`)

Purpose:

- Improve session-level audit integrity with a deterministic session-envelope fingerprint that composes canonical session-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M22_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M22 session-envelope fingerprint plan and boundaries
- emit root session-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for session-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M22 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2201` through `ANA-2210` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-240` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2201` through `ANA-2210` in order from `docs/todo/PH1_M22_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-240` (post `ANA-2210`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M22_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-240`.

### `PH1-M23` (`completed`)

Purpose:

- Improve environment-level audit integrity with a deterministic environment-envelope fingerprint that composes canonical environment-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M23_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M23 environment-envelope fingerprint plan and boundaries
- emit root environment-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for environment-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M23 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2301` through `ANA-2310` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-250` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2301` through `ANA-2310` in order from `docs/todo/PH1_M23_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-250` (post `ANA-2310`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M23_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-250`.

### `PH1-M24` (`completed`)

Purpose:

- Improve artifact-level audit integrity with a deterministic artifact-manifest fingerprint that composes canonical artifact-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M24_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M24 artifact-manifest fingerprint plan and boundaries
- emit root artifact-manifest fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for artifact-manifest fingerprint fields
- expand regression tests and smoke coverage
- PH1-M24 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2401` through `ANA-2410` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-260` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2401` through `ANA-2410` in order from `docs/todo/PH1_M24_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-260` (post `ANA-2410`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M24_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-260`.

### `PH1-M25` (`completed`)

Purpose:

- Improve provenance-level audit integrity with a deterministic provenance-envelope fingerprint that composes canonical provenance-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M25_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M25 provenance-envelope fingerprint plan and boundaries
- emit root provenance-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for provenance-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M25 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2501` through `ANA-2510` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-270` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2501` through `ANA-2510` in order from `docs/todo/PH1_M25_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-270` (post `ANA-2510`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M25_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-270`.

### `PH1-M26` (`completed`)

Purpose:

- Improve integrity-level audit coverage with a deterministic integrity-envelope fingerprint that composes canonical root fingerprint chain metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M26_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M26 integrity-envelope fingerprint plan and boundaries
- emit root integrity-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for integrity-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M26 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2601` through `ANA-2610` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-280` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2601` through `ANA-2610` in order from `docs/todo/PH1_M26_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-280` (post `ANA-2610`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M26_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-280`.

### `PH1-M27` (`completed`)

Purpose:

- Improve consistency-level audit coverage with a deterministic consistency-envelope fingerprint that composes canonical cross-fingerprint chain metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M27_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M27 consistency-envelope fingerprint plan and boundaries
- emit root consistency-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for consistency-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M27 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2701` through `ANA-2710` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-290` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2701` through `ANA-2710` in order from `docs/todo/PH1_M27_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-290` (post `ANA-2710`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M27_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-290`.

### `PH1-M28` (`completed`)

Purpose:

- Improve trace-level audit coverage with a deterministic trace-envelope fingerprint that composes canonical trace-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M28_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M28 trace-envelope fingerprint plan and boundaries
- emit root trace-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for trace-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M28 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2801` through `ANA-2810` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-300` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2801` through `ANA-2810` in order from `docs/todo/PH1_M28_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-300` (post `ANA-2810`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M28_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-300`.

### `PH1-M29` (`completed`)

Purpose:

- Improve lineage-level audit coverage with a deterministic lineage-envelope fingerprint that composes canonical cross-run lineage metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M29_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M29 lineage-envelope fingerprint plan and boundaries
- emit root lineage-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for lineage-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M29 checkpoint evidence

Acceptance criteria:

- tickets `ANA-2901` through `ANA-2910` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-310` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-2901` through `ANA-2910` in order from `docs/todo/PH1_M29_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-310` (post `ANA-2910`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M29_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-310`.

### `PH1-M30` (`completed`)

Purpose:

- Improve state-level audit coverage with a deterministic state-envelope fingerprint that composes canonical state-facing metadata into one replay handle.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M30_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M30 state-envelope fingerprint plan and boundaries
- emit root state-envelope fingerprint fields in `run.json`
- add report schema invariants and compare metadata coverage for state-envelope fingerprint fields
- expand regression tests and smoke coverage
- PH1-M30 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3001` through `ANA-3010` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-320` reached and reported.

Non-goals:

- Windows ConPTY implementation
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-3001` through `ANA-3010` in order from `docs/todo/PH1_M30_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-320` (post `ANA-3010`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M30_CHECKPOINT.md`.

Outcome:

- Accepted at `ANA-GATE-320`.

### `PH1-M31` (`completed`)

Purpose:

- Establish a first real-terminal launch lane that records deterministic process-level evidence while preserving the text-first artifact contract.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M31_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M31 real-terminal launch plan and boundaries
- add real launch telemetry fields to run context and artifacts
- launch terminal command under guarded lane with bounded timeout and deterministic error mapping
- add report schema invariants and compare metadata coverage for launch telemetry
- expand regression tests and smoke coverage
- PH1-M31 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3101` through `ANA-3110` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-330` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-330`.

Queue lines (exact):

- [x] Execute `ANA-3101` through `ANA-3110` in order from `docs/todo/PH1_M31_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-330` (post `ANA-3110`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M31_CHECKPOINT.md`.

### `PH1-M32` (`completed`)

Purpose:

- Harden real terminal launch semantics so telemetry and compare outputs are stable across success, timeout, and non-zero exit paths.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M32_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M32 launch semantics hardening plan and boundaries
- tighten launch error taxonomy and invariants in artifacts
- add compare/report coverage for launch outcome semantics
- extend docs and smoke checks for kitty vs ghostty/konsole launch paths
- PH1-M32 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3201` through `ANA-3210` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-340` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-340`.

Queue lines (exact):

- [x] Execute `ANA-3201` through `ANA-3210` in order from `docs/todo/PH1_M32_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-340` (post `ANA-3210`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M32_CHECKPOINT.md`.

### `PH1-M33` (`completed`)

Purpose:

- Add terminal profile adapters so named local terminals (kitty, ghostty, konsole, zide-terminal) map to deterministic launch commands and comparable artifacts.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M33_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M33 terminal profile adapter plan and boundaries
- add profile resolver for supported terminals and explicit override precedence
- emit resolved launch profile metadata in run artifacts
- add report/compare coverage for profile metadata deltas
- extend smoke docs with local multi-terminal adapter path
- PH1-M33 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3301` through `ANA-3310` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-350` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-350`.

Queue lines (exact):

- [x] Execute `ANA-3301` through `ANA-3310` in order from `docs/todo/PH1_M33_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-350` (post `ANA-3310`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M33_CHECKPOINT.md`.

### `PH1-M34` (`completed`)

Purpose:

- Convert profile resolution into executable per-terminal launch templates so profile-driven runs can produce consistent non-interactive launch outcomes.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M34_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M34 executable template plan and boundaries
- add per-profile launch templates (kitty, ghostty, konsole, zide-terminal) with deterministic argument handling
- thread templated launch argv through guarded launch seam
- emit and validate templated launch metadata in artifacts/report/compare
- extend smoke docs with executable profile template checks
- PH1-M34 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3401` through `ANA-3410` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-360` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-360`.

Queue lines (exact):

- [x] Execute `ANA-3401` through `ANA-3410` in order from `docs/todo/PH1_M34_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-360` (post `ANA-3410`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M34_CHECKPOINT.md`.

### `PH1-M35` (`completed`)

Purpose:

- Harden launch preflight and availability evidence so missing binaries and launchability issues are surfaced deterministically before execution.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M35_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M35 preflight/availability plan and boundaries
- add preflight checks for resolved argv executable availability and launch prerequisites
- emit preflight evidence fields in run artifacts
- enforce report/compare invariants for preflight fields
- extend smoke docs with missing-binary and availability checks
- PH1-M35 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3501` through `ANA-3510` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-370` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-370`.

Queue lines (exact):

- [x] Execute `ANA-3501` through `ANA-3510` in order from `docs/todo/PH1_M35_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-370` (post `ANA-3510`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M35_CHECKPOINT.md`.

### `PH1-M36` (`completed`)

Purpose:

- Tighten launch preflight evidence fidelity so preflight reason tags, launch outcomes, and resolved executable path evidence stay strictly consistent.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M36_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M36 strictness plan and reason-fidelity boundaries
- align launch preflight reason taxonomy with terminal launch outcome contracts
- normalize resolved executable evidence for deterministic artifact/report/compare usage
- enforce strict schema and compare invariants for preflight + launch consistency
- extend smoke docs with reason-fidelity and path-consistency checks
- PH1-M36 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3601` through `ANA-3610` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-380` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-380`.

Queue lines (exact):

- [x] Execute `ANA-3601` through `ANA-3610` in order from `docs/todo/PH1_M36_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-380` (post `ANA-3610`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M36_CHECKPOINT.md`.

### `PH1-M37` (`completed`)

Purpose:

- Make guarded-launch failures more diagnosable by capturing deterministic launch failure envelope data across artifacts, report validation, and compare output.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M37_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M37 launch-failure diagnostics envelope and boundaries
- capture normalized failure evidence for spawn/preflight/launch termination paths
- emit launch diagnostics envelope in `run.json` and summary output
- enforce report/compare invariants for diagnostics envelope fields
- extend smoke docs for missing binary, non-executable, and launch error paths
- PH1-M37 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3701` through `ANA-3710` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-390` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-390` after corrective closeout (`ANA-3912`, `ANA-3913`).

Queue lines (exact):

- [x] Execute `ANA-3701` through `ANA-3710` in order from `docs/todo/PH1_M37_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-390` (post `ANA-3710`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M37_CHECKPOINT.md`.

### `PH1-M38` (`completed`)

Purpose:

- Add a dedicated launch diagnostics fingerprint chain so launch diagnostics envelope changes are detectable and attributable across artifacts and compare output.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M38_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M38 launch diagnostics fingerprint plan and boundaries
- add launch diagnostics fingerprint fields to `RunContext` and populate seam
- emit launch diagnostics fingerprint root fields in `run.json`
- enforce report and compare invariants for launch diagnostics fingerprint fields
- add regression coverage and smoke steps for diagnostics fingerprint deltas
- PH1-M38 checkpoint evidence

Acceptance criteria:

- tickets `ANA-3801` through `ANA-3810` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-400` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Outcome:

- Accepted at `ANA-GATE-400`.

Queue lines (exact):

- [x] Execute `ANA-3801` through `ANA-3810` in order from `docs/todo/PH1_M38_TICKETS.md`.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Stop only at `ANA-GATE-400` (post `ANA-3810`) unless truly blocked.
- [x] Submit checkpoint packet in `docs/todo/PH1_M38_CHECKPOINT.md`.

### `PH1-M39` (`completed`)

Purpose:

- Harden launch diagnostics fingerprint stability by canonicalizing normalization rules and adding strict cross-file invariants.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M39_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M39 canonicalization-hardening plan and boundaries
- enforce canonical null/zero/value handling for diagnostics fingerprint payload inputs
- align writer/validator/compare behavior for launch diagnostics fingerprint edge cases
- add regression coverage for normalization drift detection
- update smoke docs for PH1-M39 validation path
- PH1-M39 checkpoint evidence
- **corrective**: recover missing ANA-3905 (pipeline threading), ANA-3907 (compare metadata), ANA-3908 (determinism tests)
- **corrective**: normalize governance records for `ANA-GATE-410` review

Acceptance criteria:

- tickets `ANA-3901` through `ANA-3914` (11 total: 7 primary + 4 correctives) complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-410` reached and reported.
- all missing scopes recovered (ANA-3905, ANA-3907, ANA-3908 via ANA-3911, ANA-3912, ANA-3913).
- governance records normalized (checkpoint, JIRA board, implementation.md).

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [x] Execute `ANA-3901` through `ANA-3910` in order from `docs/todo/PH1_M39_TICKETS.md`.
- [x] Execute correctives `ANA-3911` through `ANA-3914` to recover missing scopes and normalize governance.
- [x] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [x] Reached `ANA-GATE-410` (post `ANA-3914`) with all tickets in review_gate.
- [x] Submit checkpoint packet in `docs/todo/PH1_M39_CHECKPOINT.md` with corrective evidence.

Outcome:

- Accepted at `ANA-GATE-410` after corrective scope recovery (`ANA-3911`..`ANA-3914`) and compiler fixes.

### `PH1-M40` (`in_progress`)

Purpose:

- Establish a launch diagnostics compatibility envelope that tracks canonicalization compatibility status across report validation, fingerprinting, and compare output.

Owner docs:

- `docs/Vision.md`
- `docs/todo/JIRA_BOARD.md`
- `docs/todo/PH1_M40_TICKETS.md`
- `docs/todo/ENGINEER_ENTRYPOINT.md`

Scope:

- define PH1-M40 compatibility-envelope plan and boundaries
- add compatibility envelope fields and populate seam for launch diagnostics metadata
- emit compatibility envelope fields in `run.json` root metadata
- enforce compatibility envelope invariants in report schema validation
- extend compare metadata rows for compatibility envelope deltas
- add tests and smoke updates for compatibility-envelope edge cases
- PH1-M40 checkpoint evidence

Acceptance criteria:

- tickets `ANA-4001` through `ANA-4010` complete in order.
- one commit per ticket with `[ANA-###]` subject prefix.
- `ANA-GATE-420` reached and reported.

Non-goals:

- full VT stream replay and assertion engine
- screenshot/OCR systems
- rich TUI frontend

Queue lines (exact):

- [ ] Execute `ANA-4001` through `ANA-4010` in order from `docs/todo/PH1_M40_TICKETS.md`.
- [ ] Keep Jira board status current in `docs/todo/JIRA_BOARD.md`.
- [ ] Stop only at `ANA-GATE-420` (post `ANA-4010`) unless truly blocked.
- [ ] Submit checkpoint packet in `docs/todo/PH1_M40_CHECKPOINT.md`.
