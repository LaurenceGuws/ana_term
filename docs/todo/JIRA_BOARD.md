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

- Sprint ID: `PH1-M15-S1`
- Objective: execution-summary fingerprint integrity hardening (`ANA-1501`..`ANA-1510`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-170`

## Ticket Order (`PH1-M15-S1`)

1. `ANA-1501`
2. `ANA-1502`
3. `ANA-1503`
4. `ANA-1504`
5. `ANA-1505`
6. `ANA-1506`
7. `ANA-1507`
8. `ANA-1508`
9. `ANA-1509`
10. `ANA-1510`

## Current State

- `in_progress`: `ANA-1506`
- `todo`: `ANA-1507`..`ANA-1510`
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410`, `ANA-501`..`ANA-510`, `ANA-601`..`ANA-610`, `ANA-701`..`ANA-710`, `ANA-801`..`ANA-810`, `ANA-901`..`ANA-913`, `ANA-1001`..`ANA-1010`, `ANA-1101`..`ANA-1110`, `ANA-1201`..`ANA-1210`, `ANA-1301`..`ANA-1310`, `ANA-1401`..`ANA-1410` (accepted)
