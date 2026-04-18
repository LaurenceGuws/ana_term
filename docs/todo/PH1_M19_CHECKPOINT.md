# PH1-M19 Checkpoint

Sprint: `PH1-M19-S1`  
Super-gate: `ANA-GATE-210`

Status: **Accepted by Architect** at `ANA-GATE-210`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-1901 | `c06cb87` | `[ANA-1901] Add report-envelope fingerprint plan doc` |
| ANA-1902 | `c34b9da` | `[ANA-1902] Document report-envelope fingerprint in report and CLI` |
| ANA-1903 | `927fdd3` | `[ANA-1903] Add RunContext and populate seam for report-envelope fingerprint` |
| ANA-1904 | `9575bf0` | `[ANA-1904] Emit report-envelope fingerprint in run.json root metadata` |
| ANA-1905 | `ac62d0e` | `[ANA-1905] Require report-envelope fingerprint in run.json validation` |
| ANA-1906 | `50fe698` | `[ANA-1906] Compare run metadata includes report-envelope fingerprint` |
| ANA-1907 | `40e387b` | `[ANA-1907] Unit tests for report-envelope fingerprint populate` |
| ANA-1908 | `e98baaf` | `[ANA-1908] Regression tests for report-envelope in report and compare` |
| ANA-1909 | `d39177f` | `[ANA-1909] Document PH1-M19 report-envelope fingerprint smoke checks` |
| ANA-1910 | — | `[ANA-1910] Finalize PH1-M19 checkpoint and gate handoff` |

The git object for **ANA-1910** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-1910]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-1910` commit).
- Full run **`run.json`**: **`report_envelope_fingerprint_digest`** (64 lowercase hex) and **`report_envelope_fingerprint_version`** **`1`** immediately after **`artifact_bundle_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M19_TICKETS.md`
- `docs/REPORT_ENVELOPE_FINGERPRINT_PLAN.md`
