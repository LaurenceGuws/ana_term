# PH1-M3 Checkpoint

Sprint: `PH1-M3-S1`
Gate: `ANA-GATE-50`

Status: evidence template (fill completion at `ANA-310`).

## Objective (from sprint)

Harden `report` / `compare` correctness checks and improve comparison evidence (metadata diffs, strict result parsing) without PTY automation.

## Evidence checklist

### Build

- [ ] `zig build` succeeds.

### Unit tests

- [ ] `zig build test` succeeds (report schema + compare parsing tests).

### Smoke / regression (operator)

- [ ] `report` on a real run directory exits **0** (`docs/SMOKE.md` §4).
- [ ] `compare` on two valid runs writes `compare.md` (metadata + results) and `compare.json` with `schema_version` **0.2** (`docs/SMOKE.md` §3–5).

### Commits

- [ ] List `[ANA-301]`..`[ANA-310]` commits (subjects + SHAs) or `git log` range.

### Open risks / follow-ups

- [ ] None, or bullet list.

---

## Initial notes (optional)

_Add free-form notes while executing the sprint._
