# PH1-M3 Checkpoint

Sprint: `PH1-M3-S1`
Gate: `ANA-GATE-50`

Status: **ready for Architect review** (Engineer closure at `ANA-310`).

## Objective (from sprint)

Harden `report` / `compare` correctness checks and improve comparison evidence (metadata diffs, strict result parsing) without PTY automation.

## Evidence checklist

### Build

- [x] `zig build` succeeds (verified 2026-04-18, Linux).

### Unit tests

- [x] `zig build test` succeeds (report schema + compare parsing tests).

### Smoke / regression (operator)

- [x] `report` on `artifacts/2026-04-18/run-008` exits **0**.
- [x] `compare` on `run-007` vs `run-008` writes `compare.md` (metadata + results) and `compare.json` with `schema_version` **0.2** and `metadata_deltas`.

### Commits (`ANA-301`..`ANA-310`)

| Ticket | SHA | Subject |
|--------|-----|---------|
| ANA-301 | `93758f8` | clarify dynamic ticket authority in WORKFLOW |
| ANA-302 | `9c5dc14` | add strict run.json schema validation to report |
| ANA-303 | `57daef0` | strict compare validation for results spec_id rows |
| ANA-304 | `88b0366` | add metadata diff table to compare markdown |
| ANA-305 | `fd5318a` | add metadata deltas to compare.json |
| ANA-306 | `4577bbb` | add tests for report run.json schema validation |
| ANA-307 | `c1be13a` | add tests for compare strict results parsing |
| ANA-308 | `cd7dd09` | document PH1-M3 smoke and regression in SMOKE |
| ANA-309 | `2117ff8` | add PH1-M3 checkpoint evidence template |

`ANA-310`: resolve SHA with `git log -1 --oneline --grep=ANA-310` (finalizes checkpoint, board, implementation queue; adds `docs/todo/PH1_M3_TICKETS.md` to version control for sprint authority).

### Open risks / follow-ups

- None for this sprint scope; PTY depth remains deferred.

---

## Architect handoff

- Engineer requests review at **`ANA-GATE-50`** for sprint **`PH1-M3-S1`**.
- Operator guide: `docs/SMOKE.md`.
