# PH1-M2 Checkpoint

Sprint: `PH1-M2-S1`
Gate: `ANA-GATE-40`

Status: **ready for Architect review** (Engineer closure at `ANA-220`).

## Objective (from sprint)

Deliver the first real terminal comparison lane on one OS: `run-suite baseline-linux`, terminal metadata in artifacts, and `compare` producing markdown + deterministic JSON.

## Evidence checklist

### Build

- [x] `zig build` succeeds (verified 2026-04-18, Linux).

### Unit tests

- [x] `zig build test` succeeds (artifact path sequencing + compare diff classification).

### Smoke path (operator)

- [x] Two `run-suite baseline-linux` invocations with different `--terminal` values (`wezterm-smoke-a`, `alacritty-smoke-b`) produced `artifacts/2026-04-18/run-005` and `run-006`.
- [x] `compare` on those runs wrote `artifacts/compare/compare.md` and `artifacts/compare/compare.json`.

### Manifest validation

- [x] Implementation rejects duplicate paths, non-`.toml` lines, missing files, and empty manifests (`src/cli/suite_manifest.zig`, surfaced from `run-suite`).

### Commits (`ANA-201`..`ANA-220`)

| Ticket | SHA | Subject |
|--------|-----|---------|
| ANA-201 | `330fdc9` | add PH1-M2 comparison plan doc |
| ANA-202 | `e685cbf` | document terminal target model in CLI |
| ANA-203 | `da625c1` | add env.json environment contract doc |
| ANA-204 | `557abaf` | add baseline-linux suite definition doc |
| ANA-205 | `986726c` | add baseline-linux suite manifest file |
| ANA-206 | `ad92078` | implement run-suite baseline-linux manifest resolution |
| ANA-207 | `189eb9e` | add terminal target CLI flags and defaults |
| ANA-208 | `519e17a` | add terminal invocation metadata struct |
| ANA-209 | `bdb279b` | add per-run env.json artifact writer |
| ANA-210 | `4d3608c` | extend run.json schema for terminal and suite |
| ANA-211 | `0875f90` | add comparison_id and run_group to artifacts |
| ANA-212 | `de43a99` | add compare command stub for two run.json files |
| ANA-213 | `6d322c4` | implement markdown compare summary output |
| ANA-214 | `9c10efe` | add deterministic compare.json output |
| ANA-215 | `b69c266` | add smoke workflow doc for runs and compare |
| ANA-216 | `9223715` | validate suite manifest paths |
| ANA-217 | `be47ebc` | add run directory sequencing helper and tests |
| ANA-218 | `e35126e` | add compare diff tests and zig build test step |
| ANA-219 | `7f8b5af` | expand PH1-M2 checkpoint evidence template |

`ANA-220` is the git commit with subject `[ANA-220] finalize PH1-M2-S1 checkpoint evidence` (use `git log --grep=ANA-220` to resolve its SHA).

### Open risks / follow-ups

- Full PTY/ConPTY automation and cross-OS matrix remain out of scope per `docs/COMPARE_PLAN.md`.

---

## Architect handoff

- Engineer requests review at **`ANA-GATE-40`** for sprint **`PH1-M2-S1`**.
- Operator guide for two runs + compare: `docs/SMOKE.md`.
