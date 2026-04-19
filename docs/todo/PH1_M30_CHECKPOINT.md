# PH1-M30 Checkpoint

Sprint: `PH1-M30-S1`  
Super-gate: `ANA-GATE-320`

Status: **Engineering complete** — awaiting Architect review at `ANA-GATE-320`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-3001 | `6211c88` | `[ANA-3001] Add state-envelope fingerprint plan document` |
| ANA-3002 | `305e829` | `[ANA-3002] Document state-envelope fingerprint in report format and CLI` |
| ANA-3003 | `8e18a10` | `[ANA-3003] Add RunContext state-envelope fingerprint fields and populate seam` |
| ANA-3004 | `333fafd` | `[ANA-3004] Emit state-envelope fingerprint in run.json root metadata` |
| ANA-3005 | `0aa30db` | `[ANA-3005] Require state-envelope fingerprint in run.json validation` |
| ANA-3006 | `5c3524e` | `[ANA-3006] Compare run metadata includes state-envelope fingerprint fields` |
| ANA-3007 | `83128b8` | `[ANA-3007] Unit tests for state-envelope fingerprint` |
| ANA-3008 | `e3121d5` | `[ANA-3008] Report/compare regression tests for state-envelope fingerprint` |
| ANA-3009 | `21186a0` | `[ANA-3009] Smoke doc for state-envelope fingerprint` |
| ANA-3010 | — | `[ANA-3010] Finalize PH1-M30 checkpoint and ANA-GATE-320 handoff` |

The git object for **ANA-3010** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-3010]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-3010` commit).
- Full run **`run.json`**: **`state_envelope_fingerprint_digest`** (64 lowercase hex) and **`state_envelope_fingerprint_version`** **`1`** immediately after **`lineage_envelope_fingerprint_version`**, before the nested **`transport`** object; **`report`** exit **0** when schema matches harness output.
- Golden state digest (when **`lineage_envelope_fingerprint_digest`** is the PH1-M29 golden value): **`fc9e33e37e4d5cc403f7738cb104509dee956b6cfee8c3170f119ecfa078a6ee`**.

## References

- `docs/todo/PH1_M30_TICKETS.md`
- `docs/STATE_ENVELOPE_FINGERPRINT_PLAN.md`
