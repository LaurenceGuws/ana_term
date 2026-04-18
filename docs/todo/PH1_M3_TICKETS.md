# PH1-M3 Ticket Pack

Ticket authority for sprint `PH1-M3-S1`.

Objective: strengthen correctness semantics and evidence quality on the comparison lane (without introducing PTY automation yet).

Commit contract: one ticket per commit. Subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-301` — update `docs/WORKFLOW.md` Jira section to remove stale PH1-M1 ticket-pack pointer and define dynamic ticket-authority rule.
2. `ANA-302` — add strict schema checks for required `run.json` fields in `report`.
3. `ANA-303` — add `compare` validation for missing/duplicate `spec_id` rows.
4. `ANA-304` — include terminal/suite metadata diffs in `compare.md` header section.
5. `ANA-305` — include metadata diffs in `compare.json`.
6. `ANA-306` — add tests for report schema checks.
7. `ANA-307` — add tests for compare duplicate/missing spec behavior.
8. `ANA-308` — document PH1-M3 smoke + regression steps in `docs/SMOKE.md`.
9. `ANA-309` — add PH1-M3 checkpoint doc with evidence template.
10. `ANA-310` — finalize PH1-M3-S1 checkpoint evidence and request Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-50`
- Trigger: after commit for `ANA-310`.
