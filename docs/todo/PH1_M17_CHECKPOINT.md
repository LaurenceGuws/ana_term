# PH1-M17 Checkpoint

Sprint: `PH1-M17-S1`  
Super-gate: `ANA-GATE-190`

Status: **Accepted by Architect** at `ANA-GATE-190`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-1701 | `0fac695` | `[ANA-1701] Add metadata-envelope fingerprint plan doc` |
| ANA-1702 | `a4b0792` | `[ANA-1702] Document metadata-envelope fingerprint in report and CLI` |
| ANA-1703 | `5907710` | `[ANA-1703] Add RunContext and populate seam for metadata-envelope fingerprint` |
| ANA-1704 | `c88857a` | `[ANA-1704] Emit metadata-envelope fingerprint in run.json root metadata` |
| ANA-1705 | `3c2d0a3` | `[ANA-1705] Require metadata-envelope fingerprint in run.json validation` |
| ANA-1706 | `7751fa7` | `[ANA-1706] Compare run metadata includes metadata-envelope fingerprint` |
| ANA-1707 | `c7064c6` | `[ANA-1707] Unit tests for metadata-envelope fingerprint populate` |
| ANA-1708 | `cd244e0` | `[ANA-1708] Regression tests for metadata-envelope in report and compare` |
| ANA-1709 | `44e2b04` | `[ANA-1709] Document PH1-M17 metadata-envelope fingerprint smoke checks` |
| ANA-1710 | — | `[ANA-1710] Finalize PH1-M17 checkpoint and gate handoff` |

The git object for **ANA-1710** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-1710]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-1710` commit).
- Full run **`run.json`**: **`metadata_envelope_fingerprint_digest`** (64 lowercase hex) and **`metadata_envelope_fingerprint_version`** **`1`** immediately after **`context_summary_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M17_TICKETS.md`
- `docs/METADATA_ENVELOPE_FINGERPRINT_PLAN.md`
