# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- Sprint `PH1-M20-S1` checkpoint submitted; **pause** for Architect review at **`ANA-GATE-220`**.
- Evidence: `docs/todo/PH1_M20_CHECKPOINT.md`.
- Do not start the next execution batch until the Architect accepts the gate and updates `docs/todo/implementation.md` / `docs/todo/JIRA_BOARD.md`.
- Ticket source (completed sprint): `docs/todo/PH1_M20_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M20_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- **Paused** at `ANA-GATE-220` pending Architect acceptance of `PH1-M20`.
- When resumed by Architect: follow the then-current `docs/todo/implementation.md` queue and `docs/todo/JIRA_BOARD.md`.
- Keep one ticket per commit when executing a batch.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` as ticket status changes.
- Validate locally at ticket boundaries.

## Reporting Contract

Report only when:

- `ANA-GATE-220` reached (post `ANA-2010`), or
- hard blocker needs architecture/product decision.

Include:

- `#DONE`
- `#OUTSTANDING`
- `COMMITS`
- `Blocked by Architect review needed: true|false`
