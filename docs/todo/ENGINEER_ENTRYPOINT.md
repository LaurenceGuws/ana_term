# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- **Paused at `ANA-GATE-190`.** Sprint `PH1-M17-S1` engineer queue (`ANA-1701`..`ANA-1710`) is complete; resume only after Architect gate acceptance or new Architect direction.
- Super-gate: `ANA-GATE-190` (checkpoint: `docs/todo/PH1_M17_CHECKPOINT.md`).
- Ticket source: `docs/todo/PH1_M17_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M17_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-1701` through `ANA-1710` in strict order.
- Keep one ticket per commit.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-190` reached (post `ANA-1710`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
