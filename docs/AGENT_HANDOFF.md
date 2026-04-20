# Handoff

Session entrypoint only. Keep this file short and current.

## Active Focus

- Product lane: text-first terminal harness
- Last accepted batch: `PH1-M37` (`PH1-M37-S1`) — launch failure diagnostics envelope (`ANA-3701`..`ANA-3710`) with corrective closeout (`ANA-3912`, `ANA-3913`); checkpoint `docs/todo/PH1_M37_CHECKPOINT.md`
- Active engineer batch: `PH1-M38` (`PH1-M38-S1`) — launch diagnostics fingerprint chain (`ANA-3801`..`ANA-3810`)
- Super-gate (Architect review): `ANA-GATE-400`
- Active queue authority: `docs/todo/implementation.md`
- Ticket board authority: `docs/todo/JIRA_BOARD.md`
- Engineer entrypoint: `docs/todo/ENGINEER_ENTRYPOINT.md`

## First Read Order

1. `docs/todo/ENGINEER_ENTRYPOINT.md`
2. `docs/todo/implementation.md`
3. `docs/todo/JIRA_BOARD.md`
4. `docs/todo/PH1_M38_TICKETS.md`
5. `docs/Vision.md`
6. `docs/WORKFLOW.md`

## Execution Contract

- Execute only `ANA-3801`..`ANA-3810` in strict order.
- One ticket per commit with `[ANA-###]` prefix.
- Stop at `ANA-GATE-400` or hard blocker.
