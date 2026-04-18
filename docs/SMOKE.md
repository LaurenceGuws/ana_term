# Smoke workflow (PH1-M2 + PH1-M3 hardening)

Minimal operator path: run the **baseline-linux** suite twice with **different terminal identities**, then produce one **compare** report (markdown + JSON). **PH1-M3** adds strict `report` / `compare` checks and metadata-rich compare output—use the regression steps below when touching reporting code.

## Prerequisites

- From the repo root, build the harness: `zig build`.
- Use `zig-out/bin/ana_term` (or install the binary and use `ana_term` on `PATH`).
- After code changes, run unit tests: `zig build test`.

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

- `artifacts/compare/compare.md` — metadata table (terminal, suite, etc.), paths, then per-spec deltas.
- `artifacts/compare/compare.json` — `schema_version` **0.2** with `metadata_deltas` plus per-spec `deltas`.

## 4. Report validation (PH1-M3)

Schema-check a `run.json` (path to file or run directory):

```sh
zig-out/bin/ana_term report path/to/run-NNN
```

Expect `ok: validated …` and exit **0**. Malformed or incomplete JSON should exit **2** with a short schema reason on stderr (see `docs/REPORT_FORMAT.md`).

## 5. Compare expectations (PH1-M3)

- Each side must have a **unique** `spec_id` in `results`. Duplicate rows in one file should fail with `duplicate spec_id in results` and exit **2**.
- Rows must include string `spec_id` and `status`. Missing fields fail compare with exit **2**.

## References

- Terminal flags and behavior: `docs/CLI.md`
- Suite contents: `docs/SUITES.md` and `examples/smoke/baseline-linux.txt`
- Comparison scope: `docs/COMPARE_PLAN.md`
- Run artifact fields: `docs/REPORT_FORMAT.md`
