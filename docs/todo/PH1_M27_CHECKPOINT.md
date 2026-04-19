# PH1-M27 Checkpoint

Sprint: `PH1-M27-S1`  
Super-gate: `ANA-GATE-290`

Status: **Engineering complete** — awaiting Architect review at `ANA-GATE-290`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2701 | `bc73690` | `[ANA-2701] Add consistency-envelope fingerprint plan document` |
| ANA-2702 | `6b4dcbb` | `[ANA-2702] Document consistency-envelope fingerprint in report format and CLI` |
| ANA-2703 | `67217fe` | `[ANA-2703] Add RunContext consistency-envelope fingerprint fields and populate seam` |
| ANA-2704 | `0485810` | `[ANA-2704] Emit consistency-envelope fingerprint in run.json root metadata` |
| ANA-2705 | `64487dd` | `[ANA-2705] Require consistency-envelope fingerprint in run.json validation` |
| ANA-2706 | `bb83418` | `[ANA-2706] Compare run metadata includes consistency-envelope fingerprint fields` |
| ANA-2707 | `4bead3e` | `[ANA-2707] Unit tests for consistency-envelope fingerprint` |
| ANA-2708 | `cf55f21` | `[ANA-2708] Compare JSON writeFile regression for consistency-envelope fingerprint` |
| ANA-2709 | `51699a2` | `[ANA-2709] Document PH1-M27 consistency-envelope fingerprint smoke checks` |
| ANA-2710 | — | `[ANA-2710] Finalize PH1-M27 checkpoint and ANA-GATE-290 handoff` |

The git object for **ANA-2710** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2710]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2710` commit).
- Full run **`run.json`**: **`consistency_envelope_fingerprint_digest`** (64 lowercase hex) and **`consistency_envelope_fingerprint_version`** **`1`** immediately after **`integrity_envelope_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M27_TICKETS.md`
- `docs/CONSISTENCY_ENVELOPE_FINGERPRINT_PLAN.md`
