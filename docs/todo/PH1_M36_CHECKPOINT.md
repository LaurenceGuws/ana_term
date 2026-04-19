# PH1-M36 Checkpoint

Sprint: `PH1-M36-S1`  
Super-gate: `ANA-GATE-380`

Status: **Awaiting Architect review** at `ANA-GATE-380`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-3601 | `dadcc91` | `[ANA-3601] Add launch preflight strictness plan for PH1-M36` |
| ANA-3602 | `c30ed9b` | `[ANA-3602] Document PH1-M36 strictness in CLI and REPORT_FORMAT` |
| ANA-3603 | `c3d3cf0` | `[ANA-3603] Add PH1-M36 path normalization model to RunContext and probe` |
| ANA-3604 | `ad58c1b` | `[ANA-3604] Canonicalize Linux resolved argv0 path via realpath when possible` |
| ANA-3605 | `cae7e38` | `[ANA-3605] Fail closed on any unsuccessful preflight probe in guarded pipeline` |
| ANA-3606 | `1904edd` | `[ANA-3606] Emit PH1-M36 path normalization and transport fingerprint v3` |
| ANA-3607 | `13998d3` | `[ANA-3607] Enforce PH1-M36 preflight reason and path normalization invariants` |
| ANA-3608 | `70808cb` | `[ANA-3608] Extend compare RunMeta for PH1-M36 path normalization` |
| ANA-3609 | `97728c6` | `[ANA-3609] Add PH1-M36 compare metadata test and SMOKE strictness section` |
| ANA-3610 | — | `[ANA-3610] Finalize PH1-M36 checkpoint and ANA-GATE-380 handoff` |

The git object for **ANA-3610** is the commit that introduces this checkpoint file and handoff updates (search `git log` for subject `[ANA-3610]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-3610` commit).

## References

- `docs/todo/PH1_M36_TICKETS.md`
- `docs/LAUNCH_PREFLIGHT_STRICTNESS_PLAN.md`
