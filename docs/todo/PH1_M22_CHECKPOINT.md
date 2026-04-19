# PH1-M22 Checkpoint

Sprint: `PH1-M22-S1`  
Super-gate: `ANA-GATE-240`

Status: **Accepted by Architect** at `ANA-GATE-240`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2201 | `aa82ff0` | `[ANA-2201] Add session-envelope fingerprint plan document` |
| ANA-2202 | `ab1736a` | `[ANA-2202] Document session-envelope fingerprint in report format and CLI` |
| ANA-2203 | `ac4b33c` | `[ANA-2203] Add RunContext session-envelope fingerprint fields and populate seam` |
| ANA-2204 | `7197027` | `[ANA-2204] Emit session-envelope fingerprint in run.json root metadata` |
| ANA-2205 | `585c321` | `[ANA-2205] Require session-envelope fingerprint in run.json validation` |
| ANA-2206 | `e97d59f` | `[ANA-2206] Compare run metadata includes session-envelope fingerprint fields` |
| ANA-2207 | `3c07b6c` | `[ANA-2207] Unit tests for session-envelope fingerprint determinism and golden digest` |
| ANA-2208 | `cce2f7f` | `[ANA-2208] Regression test for compare JSON session-envelope fingerprint deltas` |
| ANA-2209 | `be75905` | `[ANA-2209] Document PH1-M22 session-envelope fingerprint smoke checks` |
| ANA-2210 | — | `[ANA-2210] Finalize PH1-M22 checkpoint and ANA-GATE-240 handoff` |

The git object for **ANA-2210** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2210]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2210` commit).
- Full run **`run.json`**: **`session_envelope_fingerprint_digest`** (64 lowercase hex) and **`session_envelope_fingerprint_version`** **`1`** immediately after **`run_envelope_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M22_TICKETS.md`
- `docs/SESSION_ENVELOPE_FINGERPRINT_PLAN.md`
