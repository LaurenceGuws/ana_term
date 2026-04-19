# PH1-M23 Checkpoint

Sprint: `PH1-M23-S1`  
Super-gate: `ANA-GATE-250`

Status: **Awaiting Architect review** at `ANA-GATE-250`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2301 | `6f7d12e` | `[ANA-2301] Add environment-envelope fingerprint plan document` |
| ANA-2302 | `11a8aab` | `[ANA-2302] Document environment-envelope fingerprint in report format and CLI` |
| ANA-2303 | `2e74678` | `[ANA-2303] Add RunContext environment-envelope fingerprint fields and populate seam` |
| ANA-2304 | `38087a6` | `[ANA-2304] Emit environment-envelope fingerprint in run.json root metadata` |
| ANA-2305 | `f340920` | `[ANA-2305] Require environment-envelope fingerprint in run.json validation` |
| ANA-2306 | `744ec2d` | `[ANA-2306] Compare run metadata includes environment-envelope fingerprint fields` |
| ANA-2307 | `9157c37` | `[ANA-2307] Unit tests for environment-envelope fingerprint determinism and golden digest` |
| ANA-2308 | `a93048c` | `[ANA-2308] Regression test for compare JSON environment-envelope fingerprint deltas` |
| ANA-2309 | `f61d5b1` | `[ANA-2309] Document PH1-M23 environment-envelope fingerprint smoke checks` |
| ANA-2310 | — | `[ANA-2310] Finalize PH1-M23 checkpoint and ANA-GATE-250 handoff` |

The git object for **ANA-2310** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2310]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2310` commit).
- Full run **`run.json`**: **`environment_envelope_fingerprint_digest`** (64 lowercase hex) and **`environment_envelope_fingerprint_version`** **`1`** immediately after **`session_envelope_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M23_TICKETS.md`
- `docs/ENVIRONMENT_ENVELOPE_FINGERPRINT_PLAN.md`
