# Run artifacts and report format

Every run emits machine-readable and human-readable outputs under the artifact root (see `src/report/artifact_paths.zig` for path policy).

## Artifact directory layout

```text
artifacts/
  YYYY-MM-DD/
    run-XXX/
      run.json
      summary.md
      transcript.log   (optional, phase-1 may omit)
      env.json         (optional)
```

`run-XXX` is a zero-padded sequence per day. The harness must not collide with existing run directories for the same date.

## `run.json` (required)

Top-level JSON object with at least:

| Field | Type | Description |
|-------|------|-------------|
| `schema_version` | string | Format version for tooling. |
| `run_id` | string | Unique id for this run directory. |
| `started_at` | string | RFC3339 / ISO8601 timestamp. |
| `ended_at` | string | RFC3339 / ISO8601 timestamp. |
| `platform` | string | OS identifier (e.g. `linux`). |
| `terminal` | object | Identity: `name`, optional `version`. |
| `term` | string | Value of `TERM` if known. |
| `results` | array | One entry per probe/spec executed. |

Each **result** object includes:

| Field | Type | Description |
|-------|------|-------------|
| `spec_id` | string | Probe `id` from spec. |
| `status` | string | One of: `pass`, `fail`, `manual`, `unsupported`, `error`. |
| `notes` | string | Freeform notes or error summary. |
| `observations` | object | Raw or structured observations (capture mode dependent). |

Phase-1 placeholder runs may use minimal values but must preserve these keys for tooling stability.

## `transport` object (`run.json`, PH1-M5+)

The harness emits a **`transport`** object alongside core run fields. Keys are stable for `report` / `compare`.

**Serialization order (PH1-M8+)**: when `mode` is `pty_guarded`, the harness writes transport keys in lexicographic order: `guarded_opt_in`, `guarded_state`, `handshake`, `handshake_latency_ns`, `mode`, `pty_capability_notes`, `pty_experiment_attempt`, `pty_experiment_elapsed_ns`, `pty_experiment_error`, `pty_experiment_open_ok`, `timeout_ms`.

| Field | Type | Description |
|-------|------|-------------|
| `mode` | string | `none`, `pty_stub`, or `pty_guarded`. |
| `timeout_ms` | integer | Positive deadline budget (milliseconds). |
| `handshake` | string or `null` | Stub handshake token when applicable. |
| `handshake_latency_ns` | integer | Synthetic latency; `0` when `mode` is `none`. |
| `guarded_opt_in` | boolean | `true` only for `pty_guarded` runs that passed the opt-in gate. |
| `guarded_state` | string | `na` \| `scaffold_only` \| `experiment_linux_pty` (see `docs/CLI.md`). |

**PH1-M7+ (guarded Linux PTY experiment)** — present when `mode` is `pty_guarded`:

| Field | Type | Description |
|-------|------|-------------|
| `pty_capability_notes` | string or `null` | Human-readable note on what was attempted (e.g. Linux `/dev/ptmx` path); `null` when `guarded_state` is `scaffold_only`. |
| `pty_experiment_attempt` | integer or `null` | **PH1-M8+**: `null` when `scaffold_only`; otherwise **`1`** (single experiment attempt). |
| `pty_experiment_elapsed_ns` | integer or `null` | **PH1-M8+**: `null` when `scaffold_only`; else wall-time nanoseconds for the experiment block, clamped to signed JSON range (`≤ 2^63−1`). |
| `pty_experiment_error` | string or `null` | Short static reason when open failed; `null` on success or when not applicable. |
| `pty_experiment_open_ok` | boolean or `null` | `null` when `guarded_state` is `scaffold_only`; otherwise whether the minimal PTY pair opened. |

See **`docs/PTY_EXPERIMENT_HARDENING_PLAN.md`** for PH1-M8 acceptance notes.

## `summary.md` (required)

Markdown document with:

1. Title line with run id and date.
2. Short **Environment** section: platform, terminal, `TERM`.
3. **Results** table or list: spec id, status, one-line note.
4. Optional **Next steps** for manual probes.

## Exit code policy (report command)

When reading `run.json`, `report` exits `0` on success, non-zero if the file is missing or invalid JSON (see `docs/CLI.md`).
