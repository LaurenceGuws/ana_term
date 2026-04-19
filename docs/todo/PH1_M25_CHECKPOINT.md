# PH1-M25 Checkpoint

Sprint: `PH1-M25-S1`  
Super-gate: `ANA-GATE-270`

Status: **Accepted by Architect** at `ANA-GATE-270`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2501 | `0ad66fb` | `[ANA-2501] Add provenance-envelope fingerprint plan document` |
| ANA-2502 | `d100515` | `[ANA-2502] Document provenance-envelope fingerprint in report format and CLI` |
| ANA-2503 | `002808d` | `[ANA-2503] Add RunContext provenance-envelope fingerprint fields and populate seam` |
| ANA-2504 | `8cf063b` | `[ANA-2504] Emit provenance-envelope fingerprint in run.json root metadata` |
| ANA-2505 | `dfb7e66` | `[ANA-2505] Require provenance-envelope fingerprint in run.json validation` |
| ANA-2506 | `96879bc` | `[ANA-2506] Compare run metadata includes provenance-envelope fingerprint fields` |
| ANA-2507 | `94ef158` | `[ANA-2507] Unit tests for provenance-envelope fingerprint determinism and golden digest` |
| ANA-2508 | `d5c838b` | `[ANA-2508] Regression test for compare JSON provenance-envelope fingerprint deltas` |
| ANA-2509 | `36715ad` | `[ANA-2509] Document PH1-M25 provenance-envelope fingerprint smoke checks` |
| ANA-2510 | — | `[ANA-2510] Finalize PH1-M25 checkpoint and ANA-GATE-270 handoff` |

The git object for **ANA-2510** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2510]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2510` commit).
- Full run **`run.json`**: **`provenance_envelope_fingerprint_digest`** (64 lowercase hex) and **`provenance_envelope_fingerprint_version`** **`1`** immediately after **`artifact_manifest_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M25_TICKETS.md`
- `docs/PROVENANCE_ENVELOPE_FINGERPRINT_PLAN.md`
