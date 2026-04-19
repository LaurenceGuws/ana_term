# PH1-M24 Checkpoint

Sprint: `PH1-M24-S1`  
Super-gate: `ANA-GATE-260`

Status: **Awaiting Architect review** at `ANA-GATE-260`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2401 | `d770e70` | `[ANA-2401] Add artifact-manifest fingerprint plan document` |
| ANA-2402 | `14f3dc4` | `[ANA-2402] Document artifact-manifest fingerprint in report format and CLI` |
| ANA-2403 | `2b1791a` | `[ANA-2403] Add RunContext artifact-manifest fingerprint fields and populate seam` |
| ANA-2404 | `c77aaa6` | `[ANA-2404] Emit artifact-manifest fingerprint in run.json root metadata` |
| ANA-2405 | `1ce1993` | `[ANA-2405] Require artifact-manifest fingerprint in run.json validation` |
| ANA-2406 | `70a796c` | `[ANA-2406] Compare run metadata includes artifact-manifest fingerprint fields` |
| ANA-2407 | `f049dcc` | `[ANA-2407] Unit tests for artifact-manifest fingerprint determinism and golden digest` |
| ANA-2408 | `93a970f` | `[ANA-2408] Regression test for compare JSON artifact-manifest fingerprint deltas` |
| ANA-2409 | `cc07e80` | `[ANA-2409] Document PH1-M24 artifact-manifest fingerprint smoke checks` |
| ANA-2410 | — | `[ANA-2410] Finalize PH1-M24 checkpoint and ANA-GATE-260 handoff` |

The git object for **ANA-2410** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2410]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2410` commit).
- Full run **`run.json`**: **`artifact_manifest_fingerprint_digest`** (64 lowercase hex) and **`artifact_manifest_fingerprint_version`** **`1`** immediately after **`environment_envelope_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M24_TICKETS.md`
- `docs/ARTIFACT_MANIFEST_FINGERPRINT_PLAN.md`
