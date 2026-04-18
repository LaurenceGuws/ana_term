# PH1-M1 Ticket Pack

Ticket authority for sprint `PH1-M1-S1`.

## Ticket Contract

Every ticket includes:

- purpose
- scope
- acceptance
- non-goals
- commit subject prefix

Engineer must keep commit subjects in the form: `[ANA-###] <summary>`.

## Tickets

### ANA-101

- Purpose: scaffold baseline repository layout for phase-1 harness modules.
- Scope: create top-level directories `src/`, `examples/`, `artifacts/`, `tests/fixtures/`, `tests/golden/`, `probes/`.
- Acceptance: directories exist and include minimal placeholder keep files where needed.
- Non-goals: no feature implementation logic.
- Commit: `[ANA-101] scaffold phase-1 directory layout`

### ANA-102

- Purpose: establish product-facing README baseline.
- Scope: add `README.md` with one-sentence definition, scope boundaries, and current milestone.
- Acceptance: README states phase-1 goal + non-goals matching `docs/Vision.md`.
- Non-goals: detailed API docs.
- Commit: `[ANA-102] add README phase-1 scope baseline`

### ANA-103

- Purpose: define architecture boundaries.
- Scope: add `docs/DESIGN.md` with ownership split (`core/dsl/runner/capture/report/probes/platform`).
- Acceptance: module boundary table exists and includes explicit ownership rules.
- Non-goals: deep implementation details.
- Commit: `[ANA-103] add harness architecture boundary doc`

### ANA-104

- Purpose: define DSL contract.
- Scope: add `docs/DSL.md` for TOML schema with required/optional keys and validation errors.
- Acceptance: includes at least one canonical example spec and field-level rules.
- Non-goals: parser implementation.
- Commit: `[ANA-104] define TOML DSL schema and validation contract`

### ANA-105

- Purpose: define report artifacts contract.
- Scope: add `docs/REPORT_FORMAT.md` with JSON schema sections and markdown summary layout.
- Acceptance: documents required result fields and artifact directory layout.
- Non-goals: renderer implementation.
- Commit: `[ANA-105] define run artifact and report format`

### ANA-106

- Purpose: define CLI command contract.
- Scope: add `docs/CLI.md` with `list`, `run`, `run-suite`, `report`, `doctor`.
- Acceptance: each command has inputs, outputs, and exit-code policy.
- Non-goals: command execution internals.
- Commit: `[ANA-106] define CLI command and exit-code contract`

### ANA-107

- Purpose: bootstrap language/toolchain project entry.
- Scope: create Zig scaffolding (`build.zig`, `build.zig.zon`, `src/main.zig`) minimal compile path.
- Acceptance: `zig build` succeeds with a placeholder binary.
- Non-goals: full command handling.
- Commit: `[ANA-107] bootstrap zig build entrypoint`

### ANA-108

- Purpose: create CLI command routing skeleton.
- Scope: add `src/cli/` modules for command parsing + dispatch stubs.
- Acceptance: binary accepts known command names and returns informative placeholder output.
- Non-goals: real execution pipeline.
- Commit: `[ANA-108] add CLI parse and dispatch stubs`

### ANA-109

- Purpose: define error model.
- Scope: add `src/core/errors.zig` or equivalent for typed error categories and exit mapping.
- Acceptance: unknown command, invalid spec, and runtime failure categories are represented.
- Non-goals: comprehensive runtime handling.
- Commit: `[ANA-109] add typed harness error model`

### ANA-110

- Purpose: add probe category taxonomy.
- Scope: add `src/probes/categories.zig` (or equivalent constants) for `vt_sequence`, `render_workload`, `input_probe`, `perf_probe`.
- Acceptance: CLI/list path can reference categories.
- Non-goals: real probe execution.
- Commit: `[ANA-110] add probe category taxonomy`

### ANA-111

- Purpose: implement spec file discovery baseline.
- Scope: add `src/dsl/discovery.zig` for collecting `.toml` probe specs from paths.
- Acceptance: `list` path can enumerate spec files deterministically.
- Non-goals: schema validation.
- Commit: `[ANA-111] implement deterministic spec discovery`

### ANA-112

- Purpose: implement minimal TOML loading seam.
- Scope: add `src/dsl/loader.zig` placeholder loader returning structured raw document.
- Acceptance: invalid file read errors propagate through typed error model.
- Non-goals: full semantic validation.
- Commit: `[ANA-112] add spec loader seam`

### ANA-113

- Purpose: implement phase-1 schema validator.
- Scope: add `src/dsl/validator.zig` for required top-level keys and step structure checks.
- Acceptance: validator returns actionable errors with file path + field name.
- Non-goals: exhaustive deep semantic checks.
- Commit: `[ANA-113] implement phase-1 spec validation`

### ANA-114

- Purpose: scaffold run orchestration contract.
- Scope: add `src/runner/run_plan.zig` and `src/runner/run_execute.zig` stubs.
- Acceptance: `run` command can produce an in-memory run record skeleton.
- Non-goals: terminal integration.
- Commit: `[ANA-114] scaffold run planning and execution skeleton`

### ANA-115

- Purpose: scaffold capture modes.
- Scope: add `src/capture/modes.zig` with `manual`, `text_observation`, `timed` and mode metadata.
- Acceptance: run skeleton stores selected capture mode.
- Non-goals: capture I/O implementation.
- Commit: `[ANA-115] add explicit capture mode contract`

### ANA-116

- Purpose: scaffold report writer contract.
- Scope: add `src/report/json_writer.zig` and `src/report/markdown_writer.zig` stubs.
- Acceptance: command writes placeholder `run.json` and `summary.md` artifacts.
- Non-goals: full result richness.
- Commit: `[ANA-116] add report writer stubs`

### ANA-117

- Purpose: scaffold artifact directory layout policy.
- Scope: add `src/report/artifact_paths.zig` date/run id generation and path resolver.
- Acceptance: artifact outputs follow `artifacts/YYYY-MM-DD/run-XXX/` layout.
- Non-goals: cleanup/retention policy.
- Commit: `[ANA-117] implement artifact path layout policy`

### ANA-118

- Purpose: seed phase-1 probe specs.
- Scope: add five TOML specs under `probes/smoke/` per vision (reset, cursor, alt-screen, truecolor, input placeholder).
- Acceptance: all specs parse and pass phase-1 validator.
- Non-goals: correctness claim on terminal behavior.
- Commit: `[ANA-118] add five seed probe specs`

### ANA-119

- Purpose: hook `list` and `run` to produce end-to-end placeholder artifacts.
- Scope: wire command dispatch to discovery/validator/runner/report seams.
- Acceptance: `list` prints specs; `run probes/smoke` emits artifact directory with expected files.
- Non-goals: terminal PTY integration.
- Commit: `[ANA-119] wire list and run to phase-1 scaffolding`

### ANA-120

- Purpose: finalize sprint checkpoint evidence.
- Scope: update docs with command transcript examples and add `docs/todo/PH1_M1_CHECKPOINT.md` summary.
- Acceptance: checkpoint doc includes completed ticket table, validations run, and known gaps.
- Non-goals: opening next milestone.
- Commit: `[ANA-120] publish PH1-M1 checkpoint evidence`

## Super-Gate

- Gate ID: `ANA-GATE-20`
- Trigger: after commit for `ANA-120`.
- Engineer must stop and report for Architect review.
