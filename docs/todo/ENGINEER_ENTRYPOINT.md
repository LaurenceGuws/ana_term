# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- Sprint `PH1-M40-S1` engineer execution is **active** (tickets `ANA-4001`..`ANA-4010`).
- Super-gate: **`ANA-GATE-420`** — stop and report after checkpoint publication.
- Ticket source (reference): `docs/todo/PH1_M40_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M40_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-4001` through `ANA-4010` in strict order.
- Keep one ticket per commit when executing a batch.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-420` reached (post `ANA-4010`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
