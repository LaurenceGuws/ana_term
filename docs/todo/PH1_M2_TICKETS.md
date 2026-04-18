# PH1-M2 Ticket Pack

Ticket authority for sprint `PH1-M2-S1`.

Objective: deliver first real terminal comparison path on one OS for at least two terminals, with machine-readable + markdown comparative output.

Commit contract: one ticket per commit. Commit subject format: `[ANA-###] <summary>`.

## Tickets

1. `ANA-201` — add `docs/COMPARE_PLAN.md` defining PH1-M2 comparison scope and non-goals.
2. `ANA-202` — define terminal target model in `docs/CLI.md` (`--terminal`, `--terminal-cmd`, `--platform`).
3. `ANA-203` — add env contract doc `docs/ENV.md` for portable terminal launch configuration.
4. `ANA-204` — add `baseline-linux` suite definition doc in `docs/SUITES.md`.
5. `ANA-205` — add suite manifest file `examples/smoke/baseline-linux.txt` listing probes.
6. `ANA-206` — implement `run-suite baseline-linux` by resolving manifest to spec paths.
7. `ANA-207` — add terminal target parsing in CLI (`--terminal`, `--terminal-cmd`, defaults).
8. `ANA-208` — add terminal invocation metadata struct in runner (command, args, version placeholder).
9. `ANA-209` — add per-run `env.json` artifact writer with platform/TERM/terminal metadata.
10. `ANA-210` — update `run.json` schema fields for terminal identity and suite name.
11. `ANA-211` — add `comparison_id` + grouping fields to run artifacts.
12. `ANA-212` — add `compare` command stub: consumes two `run.json` files.
13. `ANA-213` — implement markdown compare summary (`added/changed/status deltas`).
14. `ANA-214` — implement JSON compare output (`compare.json`) with deterministic ordering.
15. `ANA-215` — add smoke docs for generating two runs and one compare report.
16. `ANA-216` — add validation for suite manifests (missing/duplicate/non-toml entries).
17. `ANA-217` — add deterministic run-id sequencing test helper (unit or integration-style).
18. `ANA-218` — add focused tests for compare diff classification logic.
19. `ANA-219` — update `docs/todo/PH1_M2_CHECKPOINT.md` with evidence template and initial fill.
20. `ANA-220` — finalize PH1-M2-S1 checkpoint evidence and request Architect review.

## Super-Gate

- Gate ID: `ANA-GATE-40`
- Trigger: after commit for `ANA-220`.
