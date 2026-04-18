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

- Sprint ID: `PH1-M3-S1`
- Objective: correctness hardening + evidence quality (`ANA-301`..`ANA-310`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-50`

## Ticket Order (`PH1-M3-S1`)

1. `ANA-301`
2. `ANA-302`
3. `ANA-303`
4. `ANA-304`
5. `ANA-305`
6. `ANA-306`
7. `ANA-307`
8. `ANA-308`
9. `ANA-309`
10. `ANA-310`

## Current State

- `in_progress`: `ANA-306`
- `todo`: `ANA-307`..`ANA-310`
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223` (accepted)
