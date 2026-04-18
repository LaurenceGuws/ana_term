# Smoke workflow (PH1-M2 through PH1-M6)

Minimal operator path: run the **baseline-linux** suite twice with **different terminal identities**, then produce one **compare** report (markdown + JSON). **PH1-M3** adds strict `report` / `compare` checks and metadata-rich compare output. **PH1-M4** adds **execution modes** (`placeholder` vs `protocol_stub`), **`--dry-run`**, and deterministic stub **observations**—use **Section 6** when touching the runner seam. **PH1-M5** adds **transport** metadata (`none` vs **`pty_stub`**) and **`--timeout-ms`**—use **Section 7**. **PH1-M6** adds guarded transport scaffolding—use **Section 8**.

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

## 6. Protocol-stub regression (PH1-M4)

- **Dry-run** (validate + plan only; **no** artifact directory):

```sh
zig-out/bin/ana_term run-suite baseline-linux --dry-run
```

Expect `dry-run: ok, planned N spec(s)` and exit **0**.

- **Protocol stub** run (writes `run.json` with `execution_mode: protocol_stub` and non-empty deterministic `observations` per spec):

```sh
zig-out/bin/ana_term run-suite baseline-linux --exec-mode protocol_stub --terminal wezterm
```

Then `report` on that run directory must exit **0**.

- **Metadata compare**: run the suite once with default **`placeholder`** (omit `--exec-mode`) and once with **`--exec-mode protocol_stub`** (same or different `--terminal` as you like). Run **`compare`** on the two `run.json` paths. In **`compare.md`**, the **`execution_mode`** metadata row should show **`changed`** (and the same appears under **`metadata_deltas`** in **`compare.json`**).

## 7. Transport-stub regression (PH1-M5)

- **Default (`none`)**: omit **`--transport`** (or pass **`--transport none`**). `run.json` includes a **`transport`** object with `mode: none`, `handshake: null`, `handshake_latency_ns: 0`, and `timeout_ms` from defaults (see **`docs/CLI.md`**).

- **Stub transport** (still **no** real PTY; see **`docs/TRANSPORT_PLAN.md`**):

```sh
zig-out/bin/ana_term run-suite baseline-linux --transport pty_stub --timeout-ms 8000 --terminal wezterm
```

Expect `report` **0**; `transport.handshake` is a fixed stub string, `handshake_latency_ns` is deterministic from the run id.

- **Compare**: run once with **`none`** and once with **`pty_stub`** (same suite). **`compare`** metadata should show **`transport_mode`** (and related **`transport_*`** rows) as **changed**.

## 8. Guarded transport scaffolding (PH1-M6)

Still **no** real PTY; see **`docs/REAL_TRANSPORT_GUARD_PLAN.md`**.

- **Fail closed (negative)**: guarded mode without opt-in must exit **2** before writing artifacts:

```sh
zig-out/bin/ana_term run-suite baseline-linux --transport pty_guarded --terminal wezterm
```

- **Explicit opt-in (positive)**: pass **`--allow-guarded-transport`** or set **`ANA_TERM_ALLOW_GUARDED_TRANSPORT=1`**:

```sh
zig-out/bin/ana_term run-suite baseline-linux --transport pty_guarded --allow-guarded-transport --terminal wezterm
```

Expect **`report` 0** on the run directory. In **`run.json`**, **`transport.mode`** is **`pty_guarded`**, **`guarded_opt_in`** is **`true`**, **`guarded_state`** is **`scaffold_only`**, and handshake fields match the deterministic guarded stub.

- **Compare**: run once with **`pty_stub`** and once with **`pty_guarded`** (both with opt-in for the latter). Metadata should include **`guarded_opt_in`** / **`guarded_state`** deltas alongside transport rows.

## References

- Terminal flags and behavior: `docs/CLI.md`
- Suite contents: `docs/SUITES.md` and `examples/smoke/baseline-linux.txt`
- Comparison scope: `docs/COMPARE_PLAN.md`
- Run artifact fields: `docs/REPORT_FORMAT.md`
- Protocol execution seam: `docs/PROTO_EXEC_PLAN.md`
- Transport seam: `docs/TRANSPORT_PLAN.md`
- Guarded transport: `docs/REAL_TRANSPORT_GUARD_PLAN.md`
