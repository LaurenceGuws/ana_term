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

- Sprint ID: `PH1-M8-S1`
- Objective: guarded Linux PTY experiment hardening and evidence quality (`ANA-801`..`ANA-810`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-100`

## Ticket Order (`PH1-M8-S1`)

1. `ANA-801`
2. `ANA-802`
3. `ANA-803`
4. `ANA-804`
5. `ANA-805`
6. `ANA-806`
7. `ANA-807`
8. `ANA-808`
9. `ANA-809`
10. `ANA-810`

## Current State

- `in_progress`: `ANA-804`
- `todo`: `ANA-805`..`ANA-810`
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410`, `ANA-501`..`ANA-510`, `ANA-601`..`ANA-610`, `ANA-701`..`ANA-710` (accepted)
