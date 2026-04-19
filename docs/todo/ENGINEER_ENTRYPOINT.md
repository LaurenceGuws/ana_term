# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- Execute only `PH1-M30` / sprint `PH1-M30-S1`.
- Super-gate: `ANA-GATE-320` (report after `ANA-3010` or hard blocker).
- Ticket source: `docs/todo/PH1_M30_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M30_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-3001` through `ANA-3010` in strict order.
- Keep one ticket per commit when executing a batch.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-320` reached (post `ANA-3010`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
