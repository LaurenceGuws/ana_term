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

- Sprint ID: `PH1-M9-S1` (corrective batch)
- Objective: fix compile regression and close PH1-M9 acceptance (`ANA-911`..`ANA-913`)
- Commit budget before checkpoint: `3`
- Super-gate: `ANA-GATE-110`

## Ticket Order (`PH1-M9 corrective`)

1. `ANA-911`
2. `ANA-912`
3. `ANA-913`

## Current State

- `in_progress`: none
- `todo`: none
- `blocked`: none
- `review_gate`: `ANA-GATE-110`
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410`, `ANA-501`..`ANA-510`, `ANA-601`..`ANA-610`, `ANA-701`..`ANA-710`, `ANA-801`..`ANA-810` (accepted)
