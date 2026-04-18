# PH1-M1 Checkpoint

## Sprint

- Sprint ID: `PH1-M1-S1`
- Gate: `ANA-GATE-20`

## Completed Tickets

| Ticket | Commit SHA | Subject |
|--------|------------|---------|
| ANA-101 | `57d298b` | `[ANA-101] scaffold phase-1 directory layout` |
| ANA-102 | `7e26cd0` | `[ANA-102] add README phase-1 scope baseline` |
| ANA-103 | `1193206` | `[ANA-103] add harness architecture boundary doc` |
| ANA-104 | `2f22f75` | `[ANA-104] define TOML DSL schema and validation contract` |
| ANA-105 | `2ea2728` | `[ANA-105] define run artifact and report format` |
| ANA-106 | `431eee5` | `[ANA-106] define CLI command and exit-code contract` |
| ANA-107 | `c5d20ee` | `[ANA-107] bootstrap zig build entrypoint` |
| ANA-108 | `e886e5f` | `[ANA-108] add CLI parse and dispatch stubs` |
| ANA-109 | `7fef001` | `[ANA-109] add typed harness error model` |
| ANA-110 | `20d5843` | `[ANA-110] add probe category taxonomy` |
| ANA-111 | `261bdfc` | `[ANA-111] implement deterministic spec discovery` |
| ANA-112 | `c7b3d28` | `[ANA-112] add spec loader seam` |
| ANA-113 | `32093b6` | `[ANA-113] implement phase-1 spec validation` |
| ANA-114 | `a80d76a` | `[ANA-114] scaffold run planning and execution skeleton` |
| ANA-115 | `bb1d675` | `[ANA-115] add explicit capture mode contract` |
| ANA-116 | `51a7b45` | `[ANA-116] add report writer stubs` |
| ANA-117 | `cad64b9` | `[ANA-117] implement artifact path layout policy` |
| ANA-118 | `9b138af` | `[ANA-118] add five seed probe specs` |
| ANA-119 | `6a22d6d` | `[ANA-119] wire list and run to phase-1 scaffolding` |
| ANA-120 | *(see note below)* | `[ANA-120] publish PH1-M1 checkpoint evidence` |

Note: The `ANA-120` commit is the same revision that introduces `docs/todo/PH1_M1_CHECKPOINT.md`; use `git log -1 --oneline -- docs/todo/PH1_M1_CHECKPOINT.md` for its SHA.

## Validation Executed

- `zig build` (Zig `0.15.2`)
- `zig-out/bin/ana_term list` (discovers `probes/**/*.toml`, sorted)
- `zig-out/bin/ana_term run probes/smoke` (writes `artifacts/YYYY-MM-DD/run-XXX/{run.json,summary.md}`)
- `zig-out/bin/ana_term report <path-to-run.json>` (structural smoke: non-empty JSON object)
- `zig-out/bin/ana_term doctor` (informational stub)

### Command transcripts (representative)

```text
$ zig build
(succeeds)

$ zig-out/bin/ana_term list | head -6
# probe kinds: vt_sequence, render_workload, input_probe, perf_probe
probes/smoke/alt_screen.toml
probes/smoke/cursor.toml
probes/smoke/input_placeholder.toml
probes/smoke/reset.toml
probes/smoke/truecolor.toml

$ zig-out/bin/ana_term run probes/smoke
wrote run artifacts under artifacts/2026-04-18/run-001

$ zig-out/bin/ana_term report artifacts/2026-04-18/run-001/run.json
ok: validated artifacts/2026-04-18/run-001/run.json
```

## Artifact Evidence

- Example layout: `artifacts/<YYYY-MM-DD>/run-<NNN>/run.json` and `summary.md` (created by `run`; date and sequence depend on local clock and prior runs).
- `run.json` includes `schema_version`, `run_id`, and a `results` array with one row per discovered spec (phase-1 placeholder status/notes).

## Known Gaps / Follow-ups

- No PTY/ConPTY or terminal process integration; `run` emits placeholder results only.
- Spec validation is line-oriented and intended for simple seed TOML; richer TOML features need a real parser or stricter grammar.
- `run-suite` remains stubbed; `report` only checks that `run.json` looks like a JSON object.
- Platform/terminal identity fields in `run.json` are left empty in phase-1.
- Deferred to `PH1-M2`: first real cross-terminal comparison lane and deeper automation.

## Architect Review Request

- `Blocked by Architect review needed: true`
- Gate decision: accept `PH1-M1` scaffold as baseline for `PH1-M2`, or request corrective follow-up tickets.
