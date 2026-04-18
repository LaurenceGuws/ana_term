# Smoke workflow (PH1-M2)

Minimal operator path: run the **baseline-linux** suite twice with **different terminal identities**, then produce one **compare** report (markdown + JSON).

## Prerequisites

- From the repo root, build the harness: `zig build`.
- Use `zig-out/bin/ana_term` (or install the binary and use `ana_term` on `PATH`).

## 1. First run

Pick a logical terminal id (for example `wezterm`). Artifacts land under `artifacts/YYYY-MM-DD/run-NNN/`.

```sh
zig-out/bin/ana_term run-suite baseline-linux --terminal wezterm
```

Note the printed run directory (or locate the newest `artifacts/*/run-*`).

## 2. Second run

Use a **different** `--terminal` value so metadata differs (for example `alacritty`). Optionally set `--terminal-cmd` to record how you would launch that terminal later.

```sh
zig-out/bin/ana_term run-suite baseline-linux --terminal alacritty --terminal-cmd "alacritty -e"
```

Again note the second run directory.

## 3. Compare

Point `compare` at each run’s `run.json` (or at the run directory; the command resolves `run.json` inside it).

```sh
zig-out/bin/ana_term compare path/to/first/run.json path/to/second/run.json
```

Outputs:

- `artifacts/compare/compare.md` — table of per-spec deltas.
- `artifacts/compare/compare.json` — same information with deterministic key ordering.

## References

- Terminal flags and behavior: `docs/CLI.md`
- Suite contents: `docs/SUITES.md` and `examples/smoke/baseline-linux.txt`
- Comparison scope: `docs/COMPARE_PLAN.md`
