# PH1-M26 Checkpoint

Sprint: `PH1-M26-S1`  
Super-gate: `ANA-GATE-280`

Status: **Pending Architect review** at `ANA-GATE-280`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2601 | `efb1c45` | `[ANA-2601] Add integrity-envelope fingerprint plan document` |
| ANA-2602 | `8f5b938` | `[ANA-2602] Document integrity-envelope fingerprint in report format and CLI` |
| ANA-2603 | `f10f3d3` | `[ANA-2603] Add RunContext integrity-envelope fingerprint fields and populate seam` |
| ANA-2604 | `434d0c8` | `[ANA-2604] Emit integrity-envelope fingerprint in run.json root metadata` |
| ANA-2605 | `4ef7a7c` | `[ANA-2605] Require integrity-envelope fingerprint in run.json validation` |
| ANA-2606 | `8e7cd3f` | `[ANA-2606] Compare run metadata includes integrity-envelope fingerprint fields` |
| ANA-2607 | `e3ff23e` | `[ANA-2607] Unit tests for integrity-envelope fingerprint determinism and golden digest` |
| ANA-2608 | `04d7bde` | `[ANA-2608] Regression test for compare JSON integrity-envelope fingerprint deltas` |
| ANA-2609 | `022f1b1` | `[ANA-2609] Document PH1-M26 integrity-envelope fingerprint smoke checks` |
| ANA-2610 | — | `[ANA-2610] Finalize PH1-M26 checkpoint and ANA-GATE-280 handoff` |

The git object for **ANA-2610** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2610]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2610` commit).
- Full run **`run.json`**: **`integrity_envelope_fingerprint_digest`** (64 lowercase hex) and **`integrity_envelope_fingerprint_version`** **`1`** immediately after **`provenance_envelope_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M26_TICKETS.md`
- `docs/INTEGRITY_ENVELOPE_FINGERPRINT_PLAN.md`
