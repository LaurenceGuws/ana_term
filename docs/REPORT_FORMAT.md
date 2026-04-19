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

**PH1-M10+ (root host identity)** — present on every harness `run.json` that writes artifacts (full run, not `--dry-run`):

| Field | Type | Description |
|-------|------|-------------|
| `host_identity_machine` | string | Non-empty `uname.machine` snapshot (truncated; JSON-escaped). |
| `host_identity_release` | string | Non-empty `uname.release` snapshot (truncated; JSON-escaped). |
| `host_identity_sysname` | string | Non-empty `uname.sysname` snapshot (truncated; JSON-escaped). |

**Serialization order**: after `execution_mode`, before `transport`: `host_identity_machine`, `host_identity_release`, `host_identity_sysname` (lexicographic). See **`docs/HOST_IDENTITY_PLAN.md`**.

**PH1-M11+ (run fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `run_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/RUN_FINGERPRINT_PLAN.md`). |
| `run_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `host_identity_sysname`, before `transport`: `run_fingerprint_digest`, `run_fingerprint_version` (lexicographic).

**PH1-M12+ (spec-set fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `specset_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/SPECSET_FINGERPRINT_PLAN.md`). |
| `specset_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `run_fingerprint_version`, before `transport`: `specset_fingerprint_digest`, `specset_fingerprint_version` (lexicographic).

**PH1-M13+ (results-set fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `resultset_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/RESULTSET_FINGERPRINT_PLAN.md`). |
| `resultset_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `specset_fingerprint_version`, before the nested `transport` object: `resultset_fingerprint_digest`, `resultset_fingerprint_version` (lexicographic).

**PH1-M14+ (transport fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `transport_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/TRANSPORT_FINGERPRINT_PLAN.md`). |
| `transport_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `resultset_fingerprint_version`, before root **`exec_summary_fingerprint_*`**, root **`context_summary_fingerprint_*`**, root **`metadata_envelope_fingerprint_*`**, root **`artifact_bundle_fingerprint_*`**, root **`report_envelope_fingerprint_*`**, root **`compare_envelope_fingerprint_*`**, root **`run_envelope_fingerprint_*`**, root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `transport_fingerprint_digest`, `transport_fingerprint_version` (lexicographic).

**PH1-M15+ (execution-summary fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `exec_summary_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/EXEC_SUMMARY_FINGERPRINT_PLAN.md`). |
| `exec_summary_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `transport_fingerprint_version`, before root **`context_summary_fingerprint_*`**, root **`metadata_envelope_fingerprint_*`**, root **`artifact_bundle_fingerprint_*`**, root **`report_envelope_fingerprint_*`**, root **`compare_envelope_fingerprint_*`**, root **`run_envelope_fingerprint_*`**, root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `exec_summary_fingerprint_digest`, `exec_summary_fingerprint_version` (lexicographic).

**PH1-M16+ (context-summary fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `context_summary_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/CONTEXT_SUMMARY_FINGERPRINT_PLAN.md`). |
| `context_summary_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `exec_summary_fingerprint_version`, before root **`metadata_envelope_fingerprint_*`**, root **`artifact_bundle_fingerprint_*`**, root **`report_envelope_fingerprint_*`**, root **`compare_envelope_fingerprint_*`**, root **`run_envelope_fingerprint_*`**, root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `context_summary_fingerprint_digest`, `context_summary_fingerprint_version` (lexicographic).

**PH1-M17+ (metadata-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `metadata_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/METADATA_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `metadata_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `context_summary_fingerprint_version`, before root **`artifact_bundle_fingerprint_*`**, root **`report_envelope_fingerprint_*`**, root **`compare_envelope_fingerprint_*`**, root **`run_envelope_fingerprint_*`**, root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `metadata_envelope_fingerprint_digest`, `metadata_envelope_fingerprint_version` (lexicographic).

**PH1-M18+ (artifact-bundle fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `artifact_bundle_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/ARTIFACT_BUNDLE_FINGERPRINT_PLAN.md`). |
| `artifact_bundle_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `metadata_envelope_fingerprint_version`, before root **`report_envelope_fingerprint_*`**, root **`compare_envelope_fingerprint_*`**, root **`run_envelope_fingerprint_*`**, root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `artifact_bundle_fingerprint_digest`, `artifact_bundle_fingerprint_version` (lexicographic).

**PH1-M19+ (report-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `report_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/REPORT_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `report_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `artifact_bundle_fingerprint_version`, before root **`compare_envelope_fingerprint_*`**, root **`run_envelope_fingerprint_*`**, root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `report_envelope_fingerprint_digest`, `report_envelope_fingerprint_version` (lexicographic).

**PH1-M20+ (compare-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `compare_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/COMPARE_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `compare_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `report_envelope_fingerprint_version`, before root **`run_envelope_fingerprint_*`**, root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `compare_envelope_fingerprint_digest`, `compare_envelope_fingerprint_version` (lexicographic).

**PH1-M21+ (run-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `run_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/RUN_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `run_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `compare_envelope_fingerprint_version`, before root **`session_envelope_fingerprint_*`**, root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `run_envelope_fingerprint_digest`, `run_envelope_fingerprint_version` (lexicographic).

**PH1-M22+ (session-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `session_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/SESSION_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `session_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `run_envelope_fingerprint_version`, before root **`environment_envelope_fingerprint_*`**, root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `session_envelope_fingerprint_digest`, `session_envelope_fingerprint_version` (lexicographic).

**PH1-M23+ (environment-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `environment_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/ENVIRONMENT_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `environment_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `session_envelope_fingerprint_version`, before root **`artifact_manifest_fingerprint_*`**, root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `environment_envelope_fingerprint_digest`, `environment_envelope_fingerprint_version` (lexicographic).

**PH1-M24+ (artifact-manifest fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `artifact_manifest_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/ARTIFACT_MANIFEST_FINGERPRINT_PLAN.md`). |
| `artifact_manifest_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `environment_envelope_fingerprint_version`, before root **`provenance_envelope_fingerprint_*`**, root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `artifact_manifest_fingerprint_digest`, `artifact_manifest_fingerprint_version` (lexicographic).

**PH1-M25+ (provenance-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `provenance_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/PROVENANCE_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `provenance_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `artifact_manifest_fingerprint_version`, before root **`integrity_envelope_fingerprint_*`**, root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `provenance_envelope_fingerprint_digest`, `provenance_envelope_fingerprint_version` (lexicographic).

**PH1-M26+ (integrity-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `integrity_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/INTEGRITY_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `integrity_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `provenance_envelope_fingerprint_version`, before root **`consistency_envelope_fingerprint_*`**, root **`trace_envelope_fingerprint_*`**, and the nested `transport` object: `integrity_envelope_fingerprint_digest`, `integrity_envelope_fingerprint_version` (lexicographic).

**PH1-M27+ (consistency-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `consistency_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/CONSISTENCY_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `consistency_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `integrity_envelope_fingerprint_version`, before the nested `transport` object: `consistency_envelope_fingerprint_digest`, `consistency_envelope_fingerprint_version` (lexicographic).

**PH1-M28+ (trace-envelope fingerprint)** — present on every harness `run.json` that writes artifacts:

| Field | Type | Description |
|-------|------|-------------|
| `trace_envelope_fingerprint_digest` | string | **64**-character lowercase hex SHA-256 of the canonical payload (`docs/TRACE_ENVELOPE_FINGERPRINT_PLAN.md`). |
| `trace_envelope_fingerprint_version` | string | Fingerprint schema revision; phase-1 value **`1`**. |

**Serialization order**: after `consistency_envelope_fingerprint_version`, before the nested `transport` object: `trace_envelope_fingerprint_digest`, `trace_envelope_fingerprint_version` (lexicographic).

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

**Serialization order (PH1-M9+)**: when `mode` is `pty_guarded`, the harness writes transport keys in lexicographic order: `guarded_opt_in`, `guarded_state`, `handshake`, `handshake_latency_ns`, `mode`, `pty_capability_notes`, `pty_experiment_attempt`, `pty_experiment_elapsed_ns`, `pty_experiment_error`, `pty_experiment_host_machine`, `pty_experiment_host_release`, `pty_experiment_open_ok`, `timeout_ms`.

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
| `pty_experiment_host_machine` | string or `null` | **PH1-M9+**: `null` when `scaffold_only`; else non-empty `uname.machine` snapshot (truncated if needed). |
| `pty_experiment_host_release` | string or `null` | **PH1-M9+**: `null` when `scaffold_only`; else non-empty `uname.release` snapshot (truncated to harness buffer). |
| `pty_experiment_open_ok` | boolean or `null` | `null` when `guarded_state` is `scaffold_only`; otherwise whether the minimal PTY pair opened. |

See **`docs/PTY_EXPERIMENT_HARDENING_PLAN.md`** (PH1-M8) and **`docs/PTY_REPRODUCIBILITY_PLAN.md`** (PH1-M9).

## `summary.md` (required)

Markdown document with:

1. Title line with run id and date.
2. Short **Environment** section: platform, terminal, `TERM`.
3. **Results** table or list: spec id, status, one-line note.
4. Optional **Next steps** for manual probes.

## Exit code policy (report command)

When reading `run.json`, `report` exits `0` on success, non-zero if the file is missing or invalid JSON (see `docs/CLI.md`).
