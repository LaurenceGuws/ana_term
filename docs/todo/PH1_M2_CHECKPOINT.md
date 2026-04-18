# PH1-M2 Checkpoint

Sprint: `PH1-M2-S1`
Gate: `ANA-GATE-40`

Status: evidence template (fill completion at `ANA-220`).

## Objective (from sprint)

Deliver the first real terminal comparison lane on one OS: `run-suite baseline-linux`, terminal metadata in artifacts, and `compare` producing markdown + deterministic JSON.

## Evidence checklist

Fill each section before requesting Architect review.

### Build

- [ ] `zig build` succeeds (copy last run date / machine note if relevant).

### Unit tests

- [ ] `zig build test` succeeds (artifact path sequencing + compare diff classification).

### Smoke path (operator)

- [ ] Two `run-suite baseline-linux` invocations with **different** `--terminal` values (see `docs/SMOKE.md`).
- [ ] `compare` run against the two `run.json` paths; confirm `artifacts/compare/compare.md` and `artifacts/compare/compare.json`.

### Manifest validation

- [ ] Confirm invalid manifest cases fail as expected (duplicate path, non-`.toml` line, missing file, empty manifest). Optional: note exact stderr line used.

### Commits

- [ ] List `[ANA-201]`..`[ANA-220]` commits (subjects + SHAs) or reference `git log` range.

### Open risks / follow-ups

- [ ] None, or bullet list (e.g. PTY automation deferred per `COMPARE_PLAN.md`).

---

## Initial notes (optional)

_Add free-form notes while executing the sprint._
