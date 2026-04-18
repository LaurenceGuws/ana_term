# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- Execute only `PH1-M16` / sprint `PH1-M16-S1`.
- Super-gate: `ANA-GATE-180` (report after `ANA-1610` or hard blocker).
- Ticket source: `docs/todo/PH1_M16_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M16_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-1601` through `ANA-1610` in strict order.
- Keep one ticket per commit.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-180` reached (post `ANA-1610`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
