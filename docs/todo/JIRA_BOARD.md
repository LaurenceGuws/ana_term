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

- Sprint ID: `PH1-M39-S1`
- Objective: launch diagnostics canonicalization hardening (`ANA-3901`..`ANA-3910`)
- Commit budget before checkpoint: `10`
- Super-gate: `ANA-GATE-410`

## Ticket Order (`PH1-M39-S1` with correctives)

Primary (10):
1. `ANA-3901` — canonicalization plan
2. `ANA-3902` — documentation
3. `ANA-3903` — helper module
4. `ANA-3904` — schema validation
5. `ANA-3906` — invariants verification (recovered 3905 scope implicitly)
6. `ANA-3909` — regression tests + SMOKE.md
7. `ANA-3910` — initial checkpoint

Correctives (4 - recover missing scope and normalize governance):
8. `ANA-3911` — recover ANA-3905 scope (pipeline threading) with tests
9. `ANA-3912` — recover ANA-3907 scope (compare metadata) with tests
10. `ANA-3913` — recover ANA-3908 scope (determinism tests) with tests
11. `ANA-3914` — governance normalization and closure

## Current State

- `in_progress`: none (all tickets complete)
- `todo`: none
- `blocked`: none
- `review_gate`: `ANA-3901`, `ANA-3902`, `ANA-3903`, `ANA-3904`, `ANA-3906`, `ANA-3909`, `ANA-3910`, `ANA-3911`, `ANA-3912`, `ANA-3913`, `ANA-3914`
- `done`: `ANA-101`..`ANA-123`, `ANA-201`..`ANA-223`, `ANA-301`..`ANA-310`, `ANA-401`..`ANA-410`, `ANA-501`..`ANA-510`, `ANA-601`..`ANA-610`, `ANA-701`..`ANA-710`, `ANA-801`..`ANA-810`, `ANA-901`..`ANA-913`, `ANA-1001`..`ANA-1010`, `ANA-1101`..`ANA-1110`, `ANA-1201`..`ANA-1210`, `ANA-1301`..`ANA-1310`, `ANA-1401`..`ANA-1410`, `ANA-1501`..`ANA-1510`, `ANA-1601`..`ANA-1610`, `ANA-1701`..`ANA-1710`, `ANA-1801`..`ANA-1810`, `ANA-1901`..`ANA-1910`, `ANA-2001`..`ANA-2010`, `ANA-2101`..`ANA-2110`, `ANA-2201`..`ANA-2210`, `ANA-2301`..`ANA-2310`, `ANA-2401`..`ANA-2410`, `ANA-2501`..`ANA-2510`, `ANA-2601`..`ANA-2610`, `ANA-2701`..`ANA-2710`, `ANA-2801`..`ANA-2810`, `ANA-2901`..`ANA-2910`, `ANA-3001`..`ANA-3010`, `ANA-3101`..`ANA-3110`, `ANA-3201`..`ANA-3210`, `ANA-3301`..`ANA-3310`, `ANA-3401`..`ANA-3410` (accepted), `ANA-3501`..`ANA-3510`, `ANA-3601`..`ANA-3610`, `ANA-3701`..`ANA-3710`, `ANA-3801`..`ANA-3810`, `ANA-3912`, `ANA-3913` (corrective from prior sprint)
