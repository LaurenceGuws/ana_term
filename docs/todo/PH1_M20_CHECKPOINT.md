# PH1-M20 Checkpoint

Sprint: `PH1-M20-S1`  
Super-gate: `ANA-GATE-220`

Status: **Accepted by Architect** at `ANA-GATE-220`.

## Ticket commits (strict order, one commit per ticket)

| Ticket | Commit | Subject |
|--------|--------|---------|
| ANA-2001 | `1f24a97` | `[ANA-2001] Add compare-envelope fingerprint plan doc` |
| ANA-2002 | `1a754dd` | `[ANA-2002] Document compare-envelope fingerprint in report and CLI` |
| ANA-2003 | `7161be8` | `[ANA-2003] Add RunContext and populate seam for compare-envelope fingerprint` |
| ANA-2004 | `edc179a` | `[ANA-2004] Emit compare-envelope fingerprint in run.json root metadata` |
| ANA-2005 | `aa096a4` | `[ANA-2005] Require compare-envelope fingerprint in run.json validation` |
| ANA-2006 | `fb581a8` | `[ANA-2006] Compare run metadata includes compare-envelope fingerprint` |
| ANA-2007 | `fea292e` | `[ANA-2007] Unit tests for compare-envelope fingerprint populate` |
| ANA-2008 | `bbee138` | `[ANA-2008] Regression tests for compare-envelope in compare JSON output` |
| ANA-2009 | `637f427` | `[ANA-2009] Document PH1-M20 compare-envelope fingerprint smoke checks` |
| ANA-2010 | — | `[ANA-2010] Finalize PH1-M20 checkpoint and gate handoff` |

The git object for **ANA-2010** is the commit that introduces this checkpoint file (search `git log` for subject `[ANA-2010]`).

## Engineer validation log

- `zig build` / `zig build test` — pass on Linux (last run before `ANA-2010` commit).
- Full run **`run.json`**: **`compare_envelope_fingerprint_digest`** (64 lowercase hex) and **`compare_envelope_fingerprint_version`** **`1`** immediately after **`report_envelope_fingerprint_version`**; **`report`** exit **0** when schema matches harness output.

## References

- `docs/todo/PH1_M20_TICKETS.md`
- `docs/COMPARE_ENVELOPE_FINGERPRINT_PLAN.md`
