# Jira Board (Architect Authority)

This file is the canonical ticket board for active execution.

## Board Rules

- Ticket IDs are immutable (`ANA-###`).
- One ticket maps to one commit unless explicitly marked `atomic-pair`.
- Engineer executes tickets in listed order unless a dependency says otherwise.
- Engineer does not reorder, merge, or split tickets without Architect approval.
- Architect is the only role allowed to move tickets into `review_gate` and `done`.

## Status Columns

- `todo`: scoped, ready, not started.
- `in_progress`: active execution ticket (max 1).
- `blocked`: waiting on architecture/product decision.
- `review_gate`: checkpoint reached; awaiting Architect review.
- `done`: Architect accepted ticket outcome.

## Current Sprint

- Sprint ID: `PH1-M4-S1`
- Objective: protocol-aware execution seams (`ANA-401`..`ANA-410`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-60`

## Ticket Order (`PH1-M4-S1`)

1. `ANA-401`
2. `ANA-402`
3. `ANA-403`
4. `ANA-404`
5. `ANA-405`
6. `ANA-406`
7. `ANA-407`
8. `ANA-408`
9. `ANA-409`
10. `ANA-410`

## Current State

- `in_progress`: `ANA-402`
- `todo`: `ANA-403`..`ANA-410`
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310` (accepted)
