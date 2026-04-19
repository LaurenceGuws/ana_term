# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- Execute only `PH1-M29` / sprint `PH1-M29-S1` (engineering execution complete; Architect review at `ANA-GATE-310`).
- Super-gate: `ANA-GATE-310` (report after `ANA-2910` or hard blocker).
- Ticket source: `docs/todo/PH1_M29_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M29_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-2901` through `ANA-2910` in strict order.
- Keep one ticket per commit when executing a batch.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-310` reached (post `ANA-2910`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
