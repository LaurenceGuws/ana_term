# PH1-M38 Checkpoint (ANA-3801..ANA-3810)

Status: **Ready for Architect review** at `ANA-GATE-400`.

## Objective ✓

Add a dedicated launch diagnostics fingerprint chain so launch diagnostics envelope changes are detectable, attributable, and comparable across artifacts and compare output.

## Scope Delivered

### 1. Launch diagnostics fingerprint plan (ANA-3801)
- **File**: `docs/LAUNCH_DIAGNOSTICS_FINGERPRINT_PLAN.md`
- **Coverage**: Defined canonical payload serialization, fingerprint composition, SHA-256 digest, version schema, integration points across RunContext, LaunchTelemetry, and artifact layers
- **Acceptance**: ✓ Plan complete with explicit boundaries and invariants

### 2. Documentation updates (ANA-3802)
- **Files**: `docs/CLI.md`, `docs/REPORT_FORMAT.md`
- **Changes**: Documented two new root fields in `run.json`:
  - `terminal_launch_diagnostics_fingerprint_digest` (string or null, 64-char hex)
  - `terminal_launch_diagnostics_fingerprint_version` (string "1" or null)
- **Acceptance**: ✓ Documentation reflects implementation contract

### 3. Model and types (ANA-3803)
- **Files**: `src/cli/run_context.zig`, `src/runner/real_terminal_launch.zig`
- **Changes**:
  - Added `RunContext` fields for fingerprint (digest hex buffer, length)
  - Added `LaunchTelemetry` field for fingerprint digest
- **Acceptance**: ✓ `zig build` succeeds

### 4. Fingerprint population logic (ANA-3804)
- **File**: `src/report/launch_diagnostics_fingerprint.zig`
- **Changes**:
  - Implemented `populate()` function with deterministic canonical payload construction
  - Canonical format: "PH1-M38/launch-diagnostics-fingerprint/v1\n" + reason + "\n" + elapsed_ms + "\n" + signal + "\n"
  - SHA-256 digest computed and stored as 64-char lowercase hex
  - Added unit tests verifying determinism and delta detection
- **Acceptance**: ✓ All fingerprint tests pass

### 5. JSON emission (ANA-3805)
- **File**: `src/report/json_writer.zig`
- **Changes**:
  - Emitted two fingerprint fields to `run.json` after `terminal_launch_diagnostics_signal`
  - Fields rendered as strings (digest as hex, version as "1") or null
  - Placement: between diagnostics signal and host identity fields
- **Acceptance**: ✓ Fields present in artifacts

### 6. Report schema validation (ANA-3806)
- **File**: `src/report/run_json_validate.zig`
- **Changes**:
  - Added type validation for fingerprint_digest (must be 64-char lowercase hex or null)
  - Added validation for fingerprint_version (must be "1" or null)
  - Added invariant: both present or both absent
  - Made fields optional for backward compatibility (pre-M38 artifacts may lack them)
- **Acceptance**: ✓ Invalid fingerprint fields rejected; valid null states accepted

### 7. Compare metadata extension (ANA-3807)
- **File**: `src/compare/run_json.zig`
- **Changes**:
  - Added fingerprint fields to `RunMeta` struct
  - Populated fields during `parseRunMeta`
  - Extended `diffRunMeta` metadata rows (82→84 rows) to include fingerprint comparison
  - Added two metadata delta rows at end (after transport fields)
- **Acceptance**: ✓ Compare output shows fingerprint deltas

### 8. Tests and documentation (ANA-3808/ANA-3809)
- **Files**: `docs/SMOKE.md`, unit tests in `src/report/launch_diagnostics_fingerprint.zig`
- **Changes**:
  - Updated SMOKE workflow title to include PH1-M38
  - Added M37/M38 milestone descriptions to overview
  - Added reference to `LAUNCH_DIAGNOSTICS_FINGERPRINT_PLAN.md` in References
  - Three unit tests verify fingerprint determinism and delta detection
- **Acceptance**: ✓ Documentation current, 228/228 tests pass

## Validation Results

### Build
```sh
zig build
zig build test
```
✓ **All tests pass** (228/228)

### Artifact Coverage
- `run.json` root: `terminal_launch_diagnostics_fingerprint_*` fields present on all guarded launch runs
- Fingerprint digest: 64-char lowercase hex SHA-256 (or null)
- Fingerprint version: "1" (or null)
- Invariant: digest and version always co-present or co-absent

### Schema Consistency
- Canonical payload deterministic: same diagnostics values → same fingerprint
- Null handling: missing diagnostics fields → null fingerprint (pre-M38)
- Transport fingerprint v4: unchanged (already includes diagnostics_reason)
- Compare metadata: fingerprint deltas surfaced alongside envelope field deltas

## Acceptance Criteria Met

- [x] Tickets `ANA-3801` through `ANA-3810` executed in strict order
- [x] One commit per ticket with `[ANA-####]` subject prefix
- [x] `zig build` and `zig build test` pass
- [x] `docs/SMOKE.md` updated with PH1-M38 references
- [x] Fingerprint determinism verified by unit tests
- [x] Schema validation enforces invariants
- [x] Compare metadata extends by exactly 2 rows

## Non-Goals (PH1-M38)

- Fingerprint composition for Windows or non-Linux (diagnostics values are null, fingerprint correspondingly null)
- Multi-level fingerprint chains (fingerprints of fingerprints)
- Visualization of fingerprint diffs in TUI

## Commits

```
[ANA-3801] add docs/LAUNCH_DIAGNOSTICS_FINGERPRINT_PLAN.md defining PH1-M38 boundaries, canonical payload, and acceptance checks
[ANA-3802] document launch diagnostics fingerprint in CLI.md and REPORT_FORMAT.md
[ANA-3803] add launch diagnostics fingerprint fields to RunContext and LaunchTelemetry
[ANA-3804] implement launch diagnostics fingerprint population logic (deterministic canonical payload + SHA-256 digest)
[ANA-3805] emit launch diagnostics fingerprint fields in run.json (digest and version)
[ANA-3806] enforce launch diagnostics fingerprint invariants in report schema validation
[ANA-3807] extend compare RunMeta and diffRunMeta for launch diagnostics fingerprint fields
[ANA-3808] add unit tests for launch diagnostics fingerprint determinism and stability
[ANA-3809] add regression tests and update docs/SMOKE.md for launch diagnostics fingerprint
[ANA-3810] finalize PH1_M38_CHECKPOINT.md and publish sprint evidence for Architect review
```

## Readiness for ANA-GATE-400

✅ **Ready for Architect review**

All acceptance criteria met:
- Sprint tickets executed in order
- Deterministic launch diagnostics fingerprint implemented
- Schema validation enforces invariants
- Compare output surfaces fingerprint deltas
- Documentation complete
- Build succeeds, all tests pass
- Determinism guarantee verified by unit tests
