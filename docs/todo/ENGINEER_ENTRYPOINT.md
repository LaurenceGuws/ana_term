# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- `PH1-M31` / `PH1-M31-S1` engineer execution is **complete**; checkpoint: `docs/todo/PH1_M31_CHECKPOINT.md`.
- Super-gate: `ANA-GATE-330` — **Architect review** (no further engineer tickets in this sprint unless Architect reopens scope).
- Ticket source (reference): `docs/todo/PH1_M31_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M31_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-3101` through `ANA-3110` in strict order.
- Keep one ticket per commit when executing a batch.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-330` reached (post `ANA-3110`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
