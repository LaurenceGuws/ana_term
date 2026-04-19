# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- Sprint `PH1-M35-S1` engineer execution is **complete** (tickets `ANA-3501`..`ANA-3510`).
- Super-gate: **`ANA-GATE-370`** — **Architect review** of PH1-M35 checkpoint (`docs/todo/PH1_M35_CHECKPOINT.md`).
- Ticket source (reference): `docs/todo/PH1_M35_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M35_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-3501` through `ANA-3510` in strict order.
- Keep one ticket per commit when executing a batch.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-370` reached (post `ANA-3510`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
