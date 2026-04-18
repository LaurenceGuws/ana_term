# PH1-M2 Checkpoint

Sprint: `PH1-M2-S1`
Gate: `ANA-GATE-40`

Status: **gate re-opened for Architect review** (corrective batch `ANA-221`..`ANA-223` after rejection at `101b3d1`).

## Gate history

- **Rejected** at `101b3d1`: ticket authority file `docs/todo/PH1_M2_TICKETS.md` was not in git; `docs/AGENT_HANDOFF.md` and `docs/todo/ENGINEER_ENTRYPOINT.md` still described PH1-M1 / `ANA-GATE-20` on that commit.
- **Corrective**: `ANA-221` adds the ticket pack; `ANA-222` refocuses handoff + engineer entrypoint to PH1-M2 / `ANA-GATE-40`; `ANA-223` records evidence and board state.

### Governance verification (post-corrective)

- [x] `git cat-file -e HEAD:docs/todo/PH1_M2_TICKETS.md` succeeds on a clean checkout.
- [x] `docs/AGENT_HANDOFF.md` and `docs/todo/ENGINEER_ENTRYPOINT.md` reference PH1-M2 and `ANA-GATE-40`.

### Corrective commits (`ANA-221`..`ANA-223`)

| Ticket | SHA | Subject |
|--------|-----|---------|
| ANA-221 | `629715b` | add PH1-M2 ticket pack to repo |
| ANA-222 | `5786189` | refocus handoff and engineer entrypoint to PH1-M2 |

`ANA-223`: resolve SHA with `git log -1 --oneline --grep=ANA-223` (updates board + this checkpoint; re-opens `ANA-GATE-40`).

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
