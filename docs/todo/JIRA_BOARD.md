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
- `review_gate`: engineer hit checkpoint boundary; waiting on Architect review.
- `done`: Architect accepted the ticket outcome.

## Active Sprint

- Sprint ID: `PH1-M1-S1`
- Objective: phase-1 harness scaffolding with strict text-first boundaries.
- Commit budget before checkpoint: `20` commits.
- Super-gate: `ANA-GATE-20`.

## Ticket Order (`PH1-M1-S1`)

1. `ANA-101`
2. `ANA-102`
3. `ANA-103`
4. `ANA-104`
5. `ANA-105`
6. `ANA-106`
7. `ANA-107`
8. `ANA-108`
9. `ANA-109`
10. `ANA-110`
11. `ANA-111`
12. `ANA-112`
13. `ANA-113`
14. `ANA-114`
15. `ANA-115`
16. `ANA-116`
17. `ANA-117`
18. `ANA-118`
19. `ANA-119`
20. `ANA-120`

## Current State

- `in_progress`: `ANA-102`
- `todo`: `ANA-103`..`ANA-120`
- `blocked`: none
- `review_gate`: none
- `done`: none
- `implementation_complete` (Engineer; Architect promotes to `done` at gate): `ANA-101`
