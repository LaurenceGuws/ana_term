# PH1-M10 Checkpoint

Sprint: `PH1-M10-S1`  
Super-gate: `ANA-GATE-120`

Status: **Engineering complete** — awaiting Architect review at `ANA-GATE-120`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-1001 | `159a171` | `[ANA-1001] add PH1-M10 host identity plan` |
| ANA-1002 | `5faa114` | `[ANA-1002] document PH1-M10 host identity fields in report and CLI` |
| ANA-1003 | `b9d9834` | `[ANA-1003] add RunContext host identity snapshot fields` |
| ANA-1004 | `06a81ac` | `[ANA-1004] emit root host identity fields in run.json` |
| ANA-1005 | `9e2cc4c` | `[ANA-1005] validate run.json host identity root fields` |
| ANA-1006 | `1eb641b` | `[ANA-1006] compare metadata for root host identity fields` |
| ANA-1007 | `d54b161` | `[ANA-1007] test host identity capture on Linux` |
| ANA-1008 | `3429853` | `[ANA-1008] regression tests for host identity validation and compare` |
| ANA-1009 | `761fcb1` | `[ANA-1009] document PH1-M10 host identity smoke checks` |

`ANA-1010` is the commit with subject `[ANA-1010] finalize PH1-M10-S1 checkpoint and ticket pack` (search `git log --grep 'ANA-1010'`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux.
- Full run **`run.json`**: root **`host_identity_machine`**, **`host_identity_release`**, **`host_identity_sysname`** present and non-empty; **`report`** **0**.

## References

- `docs/todo/PH1_M10_TICKETS.md`
- `docs/HOST_IDENTITY_PLAN.md`
