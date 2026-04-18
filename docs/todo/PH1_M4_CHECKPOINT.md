# PH1-M4 Checkpoint

Sprint: `PH1-M4-S1`
Gate: `ANA-GATE-60`

Status: **ready for Architect review** (Engineer closure at `ANA-410`).

## Objective (from sprint)

Introduce protocol-aware execution seams (`placeholder` vs `protocol_stub`), `run` / `run-suite` control flags, and execution-mode-aware reporting/compare metadata while keeping deterministic text artifacts.

## Evidence checklist

### Build

- [x] `zig build` succeeds (2026-04-18, Linux).

### Unit tests

- [x] `zig build test` succeeds (including execution_mode schema + compare metadata regression).

### Smoke / regression

- [x] `run-suite baseline-linux --dry-run` prints planned count and exits **0**.
- [x] `run-suite baseline-linux --exec-mode protocol_stub --terminal ph4-stub` writes artifacts; `report` on that run exits **0**.
- [x] Operator steps documented in `docs/SMOKE.md` §6.

### Commits (`ANA-401`..`ANA-410`)

| Ticket | SHA | Subject |
|--------|-----|---------|
| ANA-401 | `e611370` | add PH1-M4 protocol execution plan doc |
| ANA-402 | `4c91ed3` | document and parse --dry-run and --strict flags |
| ANA-403 | `91ee4ec` | add execution mode model and run.json field |
| ANA-404 | `c342053` | add protocol-stub runner seam with deterministic observations |
| ANA-405 | `4efa1b1` | thread execution mode and dry-run through run pipeline |
| ANA-406 | `4c9bd7e` | surface execution mode in summary and compare metadata |
| ANA-407 | `ea1ecb2` | validate execution_mode in report schema |
| ANA-408 | `67ea030` | add compare regression test for execution_mode metadata |
| ANA-409 | `a08216f` | document PH1-M4 protocol-stub smoke path |

`ANA-410`: resolve SHA with `git log -1 --oneline --grep=ANA-410` (finalizes checkpoint, implementation queue, board; ensures `docs/todo/PH1_M4_TICKETS.md` is versioned).

### Open risks / follow-ups

- Real PTY/transport remains **PH1-M5+** per milestone non-goals.

---

## Architect handoff

- Engineer requests review at **`ANA-GATE-60`** for sprint **`PH1-M4-S1`**.
- Plan: `docs/PROTO_EXEC_PLAN.md`; smoke: `docs/SMOKE.md` §6.
