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

- Sprint ID: `PH1-M5-S1`
- Objective: transport seam ownership (`ANA-501`..`ANA-510`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-70`

## Ticket Order (`PH1-M5-S1`)

1. `ANA-501`
2. `ANA-502`
3. `ANA-503`
4. `ANA-504`
5. `ANA-505`
6. `ANA-506`
7. `ANA-507`
8. `ANA-508`
9. `ANA-509`
10. `ANA-510`

## Current State

- `in_progress`: `ANA-502`
- `todo`: `ANA-503`..`ANA-510`
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410` (accepted)
