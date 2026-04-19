# PH1-M21 Checkpoint

Sprint: `PH1-M21-S1`  
Super-gate: `ANA-GATE-230`

Status: **Accepted by Architect** at `ANA-GATE-230`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2101 | `890e7d5` | `[ANA-2101] Add run-envelope fingerprint plan doc` |
| ANA-2102 | `a3fd583` | `[ANA-2102] Document run-envelope fingerprint in report and CLI` |
| ANA-2103 | `dfac118` | `[ANA-2103] Add RunContext and populate seam for run-envelope fingerprint` |
| ANA-2104 | `6edf2a5` | `[ANA-2104] Emit run-envelope fingerprint in run.json root metadata` |
| ANA-2105 | `a41bda6` | `[ANA-2105] Require run-envelope fingerprint in run.json validation` |
| ANA-2106 | `0e9179a` | `[ANA-2106] Compare run metadata includes run-envelope fingerprint` |
| ANA-2107 | `a72160f` | `[ANA-2107] Unit tests for run-envelope fingerprint determinism and golden digest` |
| ANA-2108 | `6356f2b` | `[ANA-2108] Compare JSON writeFile covers run-envelope fingerprint delta` |
| ANA-2109 | `8be18a2` | `[ANA-2109] SMOKE.md PH1-M21 run-envelope fingerprint checks` |
| ANA-2110 | — | `[ANA-2110] Finalize PH1-M21 checkpoint and gate handoff` |

The git object for **ANA-2110** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2110]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2110` commit).
- Full run **`run.json`**: **`run_envelope_fingerprint_digest`** (64 lowercase hex) and **`run_envelope_fingerprint_version`** **`1`** immediately after **`compare_envelope_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M21_TICKETS.md`
- `docs/RUN_ENVELOPE_FINGERPRINT_PLAN.md`
