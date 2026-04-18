# Engineer Entrypoint

Read this file first in Dual Agent Mode.

## Active Batch

- Execute only `PH1-M1` / sprint `PH1-M1-S1`.
- Ticket source: `docs/todo/PH1_M1_TICKETS.md`.
- Board source: `docs/todo/JIRA_BOARD.md`.

## Required Read Order

1. `docs/todo/implementation.md`
2. `docs/todo/JIRA_BOARD.md`
3. `docs/todo/PH1_M1_TICKETS.md`
4. `docs/AGENT_HANDOFF.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute tickets `ANA-101` through `ANA-120` in order.
- Keep one ticket per commit.
- Use commit subjects: `[ANA-###] <summary>`.
- Update `docs/todo/JIRA_BOARD.md` ticket state as you progress.
- Validate locally for each ticket boundary.

## Reporting Contract

Do not ask for Architect review until one of these is true:

- `ANA-GATE-20` reached (after `ANA-120` commit), or
- hard blocker requiring architecture/product decision.

When reporting, include:

- `#DONE`: ticket IDs completed since last report
- `#OUTSTANDING`: ticket IDs remaining in sprint
- `COMMITS`: commit SHAs and subjects since last report
- `Blocked by Architect review needed: true|false`

## Gate Rule

- Normal cadence: execute continuously up to 20 commits.
- Super-gate: stop at `ANA-GATE-20` and hand back checkpoint evidence.
