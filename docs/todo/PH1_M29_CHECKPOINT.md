# PH1-M29 Checkpoint

Sprint: `PH1-M29-S1`  
Super-gate: `ANA-GATE-310`

Status: **Accepted by Architect** at `ANA-GATE-310`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2901 | `befe704` | `[ANA-2901] Add lineage-envelope fingerprint plan document` |
| ANA-2902 | `3b0e718` | `[ANA-2902] Document lineage-envelope fingerprint in report format and CLI` |
| ANA-2903 | `311c565` | `[ANA-2903] Add RunContext lineage-envelope fingerprint fields and populate seam` |
| ANA-2904 | `97d703f` | `[ANA-2904] Emit lineage-envelope fingerprint in run.json root metadata` |
| ANA-2905 | `1c6b170` | `[ANA-2905] Require lineage-envelope fingerprint in run.json validation` |
| ANA-2906 | `690345e` | `[ANA-2906] Compare run metadata includes lineage-envelope fingerprint fields` |
| ANA-2907 | `614a28d` | `[ANA-2907] Unit tests for lineage-envelope fingerprint` |
| ANA-2908 | `829424d` | `[ANA-2908] Compare JSON writeFile regression for lineage-envelope fingerprint` |
| ANA-2909 | `da6f745` | `[ANA-2909] Smoke doc for lineage-envelope fingerprint` |
| ANA-2910 | — | `[ANA-2910] Finalize PH1-M29 checkpoint and ANA-GATE-310 handoff` |

The git object for **ANA-2910** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2910]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2910` commit).
- Full run **`run.json`**: **`lineage_envelope_fingerprint_digest`** (64 lowercase hex) and **`lineage_envelope_fingerprint_version`** **`1`** immediately after **`trace_envelope_fingerprint_version`**, before the nested **`transport`** object; **`report`** exit **0** when schema matches harness output.
- Golden lineage digest (when **`trace_envelope_fingerprint_digest`** is the PH1-M28 golden value): **`ab0d29132d75a50c33523822984a11df745fa6cd934d2ee9d638b240a84c8659`**.

## References

- `docs/todo/PH1_M29_TICKETS.md`
- `docs/LINEAGE_ENVELOPE_FINGERPRINT_PLAN.md`
