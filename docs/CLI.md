# CLI contract

The `ana_term` binary (installed as `ana_term` via `zig build`) exposes a text-first control plane. Arguments are parsed after the subcommand name.

## Global behavior

- **Stdout**: primary user-facing output (lists, summaries).
- **Stderr**: diagnostics and errors.
- **Exit codes** (shared):
  - `0`: success.
  - `1`: usage / unknown subcommand / invalid arguments.
  - `2`: invalid spec or validation failure.
  - `3`: I/O or runtime failure (read/write errors, unexpected OS errors).

## `list`

**Purpose**: Enumerate discovered `.toml` probe specs.

| Input | Description |
|-------|-------------|
| Positional paths | Optional directories or files to scan (default: `probes/`). |

| Output | Description |
|--------|-------------|
| Stdout | One path per line, sorted lexicographically. |

| Exit | Condition |
|------|-----------|
| 0 | Discovery completed (empty list is success). |
| 3 | Directory unreadable or I/O error. |

## `run`

**Purpose**: Run one or more specs through the phase-1 pipeline and write artifacts.

| Input | Description |
|-------|-------------|
| Path | Directory (e.g. `probes/smoke`) or single `.toml` file. |
| `--terminal <name>` | Optional; recorded in `run.json` (phase-1 may ignore execution). |
| `--platform <name>` | Optional; recorded in `run.json`. |
| `--capture <mode>` | Optional; one of `manual`, `text_observation`, `timed`. |

| Output | Description |
|--------|-------------|
| Artifact dir | `artifacts/YYYY-MM-DD/run-XXX/` with `run.json`, `summary.md`. |

| Exit | Condition |
|------|-----------|
| 0 | Run record written. |
| 2 | Spec missing required keys or validation failed. |
| 3 | Failed to create artifact directory or write files. |

## `run-suite`

**Purpose**: Run a named suite (future: maps to a list of specs or directories).

| Input | Description |
|-------|-------------|
| Suite name | Required identifier (phase-1 may stub with placeholder). |

| Exit | Condition |
|------|-----------|
| 0 | Stub success or suite executed. |
| 1 | Unknown suite name in phase-1 stub. |

## `report`

**Purpose**: Render or validate a `run.json` and optionally refresh `summary.md`.

| Input | Description |
|-------|-------------|
| Path | Path to `run.json` or to a run directory containing it. |

| Output | Description |
|--------|-------------|
| Stdout | Short confirmation or validation message. |

| Exit | Condition |
|------|-----------|
| 0 | JSON valid and report step completed. |
| 2 | JSON invalid or missing required fields. |
| 3 | Read/write failure. |

## `doctor`

**Purpose**: Print environment and build diagnostics (Zig version, cwd, basic paths).

| Output | Description |
|--------|-------------|
| Stdout | Key-value or line-oriented diagnostic lines. |

| Exit | Condition |
|------|-----------|
| 0 | Always in phase-1 (informational). |
