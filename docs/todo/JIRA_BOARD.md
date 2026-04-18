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

- Sprint ID: `PH1-M14-S1`
- Objective: transport-fingerprint integrity hardening (`ANA-1401`..`ANA-1410`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-160`

## Ticket Order (`PH1-M14-S1`)

1. `ANA-1401`
2. `ANA-1402`
3. `ANA-1403`
4. `ANA-1404`
5. `ANA-1405`
6. `ANA-1406`
7. `ANA-1407`
8. `ANA-1408`
9. `ANA-1409`
10. `ANA-1410`

## Current State

- `in_progress`: `ANA-1410`
- `todo`: none
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410`, `ANA-501`..`ANA-510`, `ANA-601`..`ANA-610`, `ANA-701`..`ANA-710`, `ANA-801`..`ANA-810`, `ANA-901`..`ANA-913`, `ANA-1001`..`ANA-1010`, `ANA-1101`..`ANA-1110`, `ANA-1201`..`ANA-1210`, `ANA-1301`..`ANA-1310` (accepted)
