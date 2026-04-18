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

- Sprint ID: `PH1-M7-S1`
- Objective: minimal real PTY experiment behind guarded transport (`ANA-701`..`ANA-710`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-90`

## Ticket Order (`PH1-M7-S1`)

1. `ANA-701`
2. `ANA-702`
3. `ANA-703`
4. `ANA-704`
5. `ANA-705`
6. `ANA-706`
7. `ANA-707`
8. `ANA-708`
9. `ANA-709`
10. `ANA-710`

## Current State

- `in_progress`: `ANA-710`
- `todo`: none
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410`, `ANA-501`..`ANA-510`, `ANA-601`..`ANA-610` (accepted)
