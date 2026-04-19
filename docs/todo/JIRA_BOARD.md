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

- Sprint ID: `PH1-M34-S1`
- Objective: executable launch templates per terminal profile (`ANA-3401`..`ANA-3410`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-360`

## Ticket Order (`PH1-M34-S1`)

1. `ANA-3401`
2. `ANA-3402`
3. `ANA-3403`
4. `ANA-3404`
5. `ANA-3405`
6. `ANA-3406`
7. `ANA-3407`
8. `ANA-3408`
9. `ANA-3409`
10. `ANA-3410`

## Current State

- `in_progress`: `ANA-3404`
- `todo`: `ANA-3405`..`ANA-3410`
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410`, `ANA-501`..`ANA-510`, `ANA-601`..`ANA-610`, `ANA-701`..`ANA-710`, `ANA-801`..`ANA-810`, `ANA-901`..`ANA-913`, `ANA-1001`..`ANA-1010`, `ANA-1101`..`ANA-1110`, `ANA-1201`..`ANA-1210`, `ANA-1301`..`ANA-1310`, `ANA-1401`..`ANA-1410`, `ANA-1501`..`ANA-1510`, `ANA-1601`..`ANA-1610`, `ANA-1701`..`ANA-1710`, `ANA-1801`..`ANA-1810`, `ANA-1901`..`ANA-1910`, `ANA-2001`..`ANA-2010`, `ANA-2101`..`ANA-2110`, `ANA-2201`..`ANA-2210`, `ANA-2301`..`ANA-2310`, `ANA-2401`..`ANA-2410`, `ANA-2501`..`ANA-2510`, `ANA-2601`..`ANA-2610`, `ANA-2701`..`ANA-2710`, `ANA-2801`..`ANA-2810`, `ANA-2901`..`ANA-2910`, `ANA-3001`..`ANA-3010`, `ANA-3101`..`ANA-3110`, `ANA-3201`..`ANA-3210`, `ANA-3301`..`ANA-3310` (accepted), `ANA-3401`..`ANA-3403`
