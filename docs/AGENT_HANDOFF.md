# Handoff

Session entrypoint only. Keep this file short and current.

## Active Focus

- Product lane: text-first terminal harness
- Active macro batch (`in_progress`): `PH1-M1` (`PH1-M1-S1`) — 20-commit scaffold sprint under Jira ticket governance
- Active queue authority: `docs/todo/implementation.md`
- Ticket board authority: `docs/todo/JIRA_BOARD.md`
- Engineer entrypoint (dual mode): `docs/todo/ENGINEER_ENTRYPOINT.md`

## Dual Session Startup (Copy/Paste)

Architect session seed:

- Read `docs/todo/implementation.md`, `docs/todo/JIRA_BOARD.md`, and `docs/todo/PH1_M1_TICKETS.md`.
- Review only when `ANA-GATE-20` is reached or a hard blocker is raised.
- After acceptance, refocus queue + handoff + engineer entrypoint immediately.

Engineer session seed:

- Read `docs/todo/ENGINEER_ENTRYPOINT.md`, then `docs/todo/implementation.md`, then ticket docs.
- Execute only `ANA-101`..`ANA-120` in order.
- Stop and report only at `ANA-GATE-20` (or true blocker).

## First Read Order

1. `docs/todo/ENGINEER_ENTRYPOINT.md`
2. `docs/todo/implementation.md`
3. `docs/todo/JIRA_BOARD.md`
4. `docs/todo/PH1_M1_TICKETS.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Ticket order is strict.
- One ticket maps to one commit.
- Commit subject must include `[ANA-###]`.
- Engineer should not request review before checkpoint gate unless blocked.
