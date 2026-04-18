# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- **Paused at `ANA-GATE-150`**: sprint `PH1-M13-S1` engineering queue is complete; Architect owns board `done` promotion after review.
- Checkpoint packet: `docs/todo/PH1_M13_CHECKPOINT.md`.
- Ticket source: `docs/todo/PH1_M13_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M13_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-1301` through `ANA-1310` in strict order.
- Keep one ticket per commit.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-150` reached (post `ANA-1310`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
