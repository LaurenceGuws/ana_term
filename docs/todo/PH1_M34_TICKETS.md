# PH1-M34 Ticket Pack

Ticket authority for sprint `PH1-M34-S1`.

Objective: convert terminal profiles into executable launch templates so profile-driven guarded runs produce deterministic, non-interactive launch behavior and metadata.

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-3401` — add `docs/TERMINAL_PROFILE_EXEC_TEMPLATE_PLAN.md` with PH1-M34 boundaries, template model, risks, and acceptance checks.
2. `ANA-3402` — document executable profile template behavior in `docs/CLI.md` and `docs/REPORT_FORMAT.md`.
3. `ANA-3403` — extend profile model from plain command strings to templated argv contracts per known terminal.
4. `ANA-3404` — implement resolver output for template argv and explicit fallback behavior when a template cannot be formed.
5. `ANA-3405` — thread template argv through guarded launcher seam while preserving timeout and outcome taxonomy.
6. `ANA-3406` — emit template metadata in `run.json` (`resolved_terminal_argv`, template id/version) and markdown summary.
7. `ANA-3407` — enforce template metadata invariants in `report` schema validation.
8. `ANA-3408` — extend compare `RunMeta` / metadata diff rows for template metadata fields.
9. `ANA-3409` — add unit + regression tests for template resolution/execution paths and compare/report parsing; update `docs/SMOKE.md` with template checks.
10. `ANA-3410` — finalize `docs/todo/PH1_M34_CHECKPOINT.md` and publish sprint evidence for Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-360`
- Trigger: after commit for `ANA-3410`.
