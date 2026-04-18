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

- Sprint ID: `PH1-M2-S1`
- Objective: first real comparison lane (`ANA-201`..`ANA-220`)
- Commit budget before checkpoint: `20`
- Super-gate: `ANA-GATE-40`

## Ticket Order (`PH1-M2-S1`)

1. `ANA-201`
2. `ANA-202`
3. `ANA-203`
4. `ANA-204`
5. `ANA-205`
6. `ANA-206`
7. `ANA-207`
8. `ANA-208`
9. `ANA-209`
10. `ANA-210`
11. `ANA-211`
12. `ANA-212`
13. `ANA-213`
14. `ANA-214`
15. `ANA-215`
16. `ANA-216`
17. `ANA-217`
18. `ANA-218`
19. `ANA-219`
20. `ANA-220`

## Current State

- `in_progress`: none
- `todo`: none
- `blocked`: none
- `review_gate`: none
- `done`: `ANA-101`..`ANA-123` (accepted)

Engineer note: sprint `PH1-M2-S1` tickets `ANA-201`..`ANA-220` are committed; checkpoint packet in `docs/todo/PH1_M2_CHECKPOINT.md`. Super-gate: `ANA-GATE-40` (Architect review).
