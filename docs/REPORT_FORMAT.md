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

## `summary.md` (required)

Markdown document with:

1. Title line with run id and date.
2. Short **Environment** section: platform, terminal, `TERM`.
3. **Results** table or list: spec id, status, one-line note.
4. Optional **Next steps** for manual probes.

## Exit code policy (report command)

When reading `run.json`, `report` exits `0` on success, non-zero if the file is missing or invalid JSON (see `docs/CLI.md`).
