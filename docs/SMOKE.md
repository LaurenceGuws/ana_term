# Smoke workflow (PH1-M2 through PH1-M26)

Minimal operator path: run the **baseline-linux** suite twice with **different terminal identities**, then produce one **compare** report (markdown + JSON). **PH1-M3** adds strict `report` / `compare` checks and metadata-rich compare output. **PH1-M4** adds **execution modes** (`placeholder` vs `protocol_stub`), **`--dry-run`**, and deterministic stub **observations**—use **Section 6** when touching the runner seam. **PH1-M5** adds **transport** metadata (`none` vs **`pty_stub`**) and **`--timeout-ms`**—use **Section 7**. **PH1-M6** adds guarded transport scaffolding—use **Section 8**. **PH1-M7** adds a minimal Linux PTY open/close experiment—use **Section 9** (Linux host only). **PH1-M8** adds deterministic telemetry for that experiment—use **Section 10**. **PH1-M9** adds host **`uname`** snapshots on the guarded experiment path—use **Section 11**. **PH1-M10** adds root **`host_identity_*`** fields on every artifact run—use **Section 12**. **PH1-M11** adds deterministic **`run_fingerprint_*`** fields—use **Section 13**. **PH1-M12** adds deterministic **`specset_fingerprint_*`** fields—use **Section 14**. **PH1-M13** adds deterministic **`resultset_fingerprint_*`** fields—use **Section 15**. **PH1-M14** adds deterministic root **`transport_fingerprint_*`** fields—use **Section 16**. **PH1-M15** adds deterministic root **`exec_summary_fingerprint_*`** fields—use **Section 17**. **PH1-M16** adds deterministic root **`context_summary_fingerprint_*`** fields—use **Section 18**. **PH1-M17** adds deterministic root **`metadata_envelope_fingerprint_*`** fields—use **Section 19**. **PH1-M18** adds deterministic root **`artifact_bundle_fingerprint_*`** fields—use **Section 20**. **PH1-M19** adds deterministic root **`report_envelope_fingerprint_*`** fields—use **Section 21**. **PH1-M20** adds deterministic root **`compare_envelope_fingerprint_*`** fields—use **Section 22**. **PH1-M21** adds deterministic root **`run_envelope_fingerprint_*`** fields—use **Section 23**. **PH1-M22** adds deterministic root **`session_envelope_fingerprint_*`** fields—use **Section 24**. **PH1-M23** adds deterministic root **`environment_envelope_fingerprint_*`** fields—use **Section 25**. **PH1-M24** adds deterministic root **`artifact_manifest_fingerprint_*`** fields—use **Section 26**. **PH1-M25** adds deterministic root **`provenance_envelope_fingerprint_*`** fields—use **Section 27**. **PH1-M26** adds deterministic root **`integrity_envelope_fingerprint_*`** fields—use **Section 28**.

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

- **Dry-run**: add **`--dry-run`** to the opt-in command above. Exit **0**; no artifact directory is created.

- **Full run (Linux)**: omit **`--dry-run`**. After the run, **`report`** on the artifact directory exits **0**. In **`run.json`**, **`guarded_state`** is **`experiment_linux_pty`**, **`pty_experiment_open_ok`** is **`true`** (or **`false`** with **`pty_experiment_error`** set on failure), **`pty_capability_notes`** describes the POSIX path, and **PH1-M8** adds **`pty_experiment_attempt`** (**`1`**) and **`pty_experiment_elapsed_ns`** (non-negative wall time; see **Section 10**).

- **Compare**: run once with **`pty_stub`** and once with **`pty_guarded`** (with opt-in). Metadata should include **`guarded_opt_in`**, **`guarded_state`**, and **`pty_experiment_*`** (including attempt/elapsed) deltas alongside transport rows.

## 9. Guarded Linux PTY experiment (PH1-M7)

**Host must be Linux** (see **`docs/PTY_EXPERIMENT_PLAN.md`**). On non-Linux, a full **`pty_guarded`** run (without **`--dry-run`**) exits **2** before artifacts.

- **Negative (non-Linux or no opt-in)**: unchanged from **Section 8**; non-Linux full runs fail at preflight.

- **Positive (Linux, opt-in, full run)**:

```sh
zig-out/bin/ana_term run-suite baseline-linux --transport pty_guarded --allow-guarded-transport --terminal wezterm
```

Confirm with **`report`** on the run directory. Inspect **`transport.guarded_state`** and **`pty_experiment_open_ok`** in **`run.json`**.

## 10. PH1-M8 hardened PTY telemetry (Linux)

Same commands as **Section 9**. After a successful full run, open **`run.json`** and verify:

- **`pty_experiment_attempt`** is **`1`**.
- **`pty_experiment_elapsed_ns`** is present, non-negative, and fits a signed JSON integer (harness clamps if needed).
- Transport keys follow the lexicographic order documented in **`docs/REPORT_FORMAT.md`**.

**Compare**: two guarded full runs on the same host may show **`changed`** on **`pty_experiment_elapsed_ns`** (wall time); **`pty_experiment_attempt`** should remain **`1`** for both.

See **`docs/PTY_EXPERIMENT_HARDENING_PLAN.md`**.

## 11. PH1-M9 PTY host reproducibility snapshot (Linux)

Use the same full **`pty_guarded`** command as **Sections 9–10** (Linux host, opt-in, **no** **`--dry-run`**). After **`report`** exits **0**, open **`run.json`** → **`transport`** and verify:

- **`pty_experiment_host_machine`** and **`pty_experiment_host_release`** are **non-empty strings** (truncated snapshots from **`uname`** on the experiment path).
- **`--dry-run`** with opt-in still yields **`guarded_state`**: **`scaffold_only`** and both host fields **`null`**.
- Transport keys follow the lexicographic order in **`docs/REPORT_FORMAT.md`** (host fields immediately after **`pty_experiment_error`**, before **`pty_experiment_open_ok`**).

**Compare**: two full guarded runs on the same host should normally show **`unchanged`** for **`pty_experiment_host_machine`** and **`pty_experiment_host_release`** in **`compare.md`** / **`metadata_deltas`** in **`compare.json`** (unless the kernel identity changed between runs).

See **`docs/PTY_REPRODUCIBILITY_PLAN.md`**.

## 12. PH1-M10 root host identity (artifact runs)

After any full **`run-suite`** (or **`run`**) that writes **`run.json`** (**not** **`--dry-run`**), run **`report`** on the artifact directory and confirm exit **0**. Open **`run.json`** and verify root-level:

- **`host_identity_machine`**, **`host_identity_release`**, **`host_identity_sysname`** — non-empty strings (runtime **`uname`** snapshots; JSON-escaped).
- Serialization order: immediately after **`execution_mode`**, before **`transport`** (see **`docs/REPORT_FORMAT.md`**).

**Compare**: two runs on the same machine should normally show **`unchanged`** for these three metadata rows unless the kernel identity changed.

See **`docs/HOST_IDENTITY_PLAN.md`**.

## 13. PH1-M11 run fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`run_fingerprint_digest`**: **64** lowercase hex characters.
- **`run_fingerprint_version`**: **`1`**.
- Serialization order: after **`host_identity_sysname`**, before **`transport`** (see **`docs/REPORT_FORMAT.md`**).

**Compare**: identical runs (same **`run_id`**, suite, and ordered **`spec_id`** list, same host identity context) should yield the same digest; changing any canonical input should change **`run_fingerprint_digest`**.

See **`docs/RUN_FINGERPRINT_PLAN.md`**.

## 14. PH1-M12 spec-set fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`specset_fingerprint_digest`**: **64** lowercase hex characters.
- **`specset_fingerprint_version`**: **`1`**.
- Serialization order: after **`run_fingerprint_version`**, before **`transport`** (see **`docs/REPORT_FORMAT.md`**).

**Compare**: two runs with the same **suite label** (or both absent) and the same **ordered `spec_id` list** should yield the same **`specset_fingerprint_digest`**; reordering probes or changing the suite string should change the digest. **`metadata_deltas`** should include **`specset_fingerprint_digest`** when left and right digests differ.

See **`docs/SPECSET_FINGERPRINT_PLAN.md`**.

## 15. PH1-M13 results-set fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`resultset_fingerprint_digest`**: **64** lowercase hex characters.
- **`resultset_fingerprint_version`**: **`1`**.
- Serialization order: after **`specset_fingerprint_version`**, before root **`transport_fingerprint_*`**, root **`exec_summary_fingerprint_*`**, root **`context_summary_fingerprint_*`**, and the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: two runs with the same **ordered `results` rows** (same **`spec_id`**, **`status`**, **`capture_mode`**, and **`notes`** per row) should yield the same **`resultset_fingerprint_digest`**; changing status, notes, capture mode, or row order should change the digest. **`metadata_deltas`** should include **`resultset_fingerprint_digest`** when left and right digests differ.

See **`docs/RESULTSET_FINGERPRINT_PLAN.md`**.

## 16. PH1-M14 transport fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`transport_fingerprint_digest`**: **64** lowercase hex characters.
- **`transport_fingerprint_version`**: **`1`**.
- Serialization order: after **`resultset_fingerprint_version`**, before root **`exec_summary_fingerprint_*`**, root **`context_summary_fingerprint_*`**, and the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: identical **effective transport configuration** (mode, timeout, guarded flags, handshake/latency inputs, and guarded PTY snapshot fields when applicable) and the same **`run_id`** should yield the same **`transport_fingerprint_digest`**; changing mode, timeout, stub latency inputs, or guarded experiment fields should change the digest. **`metadata_deltas`** should include **`transport_fingerprint_digest`** when left and right digests differ.

See **`docs/TRANSPORT_FINGERPRINT_PLAN.md`**.

## 17. PH1-M15 execution-summary fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`exec_summary_fingerprint_digest`**: **64** lowercase hex characters.
- **`exec_summary_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`transport_fingerprint_version`**, before root **`context_summary_fingerprint_*`** and the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: two runs whose **execution-shaping inputs** match the canonical payload (for example same **`execution_mode`**, **`strict`**, **`platform`**, **`capture_mode`**, **`terminal`**, optional labels, **`transport.mode`**, and **`transport.timeout_ms`**) should yield the same **`exec_summary_fingerprint_digest`**; toggling **`--strict`**, changing **`--exec-mode`**, changing **`--terminal`**, or changing transport mode/timeout should change the digest when those fields diverge. **`metadata_deltas`** should include **`exec_summary_fingerprint_digest`** when left and right digests differ.

See **`docs/EXEC_SUMMARY_FINGERPRINT_PLAN.md`**.

## 18. PH1-M16 context-summary fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`context_summary_fingerprint_digest`**: **64** lowercase hex characters.
- **`context_summary_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`exec_summary_fingerprint_version`**, before the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: two runs whose **context canonical inputs** match (same root **`term`** as recorded, same **`terminal_cmd`**, same **`allow_guarded_transport`** / env gate, and same **`host_identity_*`** snapshot strings) should yield the same **`context_summary_fingerprint_digest`**; changing **`TERM`**, changing **`--terminal-cmd`**, toggling guarded opt-in, or changing host identity fields should change the digest when those inputs diverge. **`metadata_deltas`** should include **`context_summary_fingerprint_digest`** when left and right digests differ.

See **`docs/CONTEXT_SUMMARY_FINGERPRINT_PLAN.md`**.

## 19. PH1-M17 metadata-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`metadata_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical ordered stack of the six upstream root digests plus literal **`1`** version lines; see **`docs/METADATA_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`metadata_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`context_summary_fingerprint_version`**, before root **`artifact_bundle_fingerprint_*`** and the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when any upstream root digest (**`run`**, **`specset`**, **`resultset`**, **`transport`**, **`exec_summary`**, or **`context_summary`**) differs between runs, **`metadata_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`metadata_envelope_fingerprint_digest`** when left and right digests differ.

See **`docs/METADATA_ENVELOPE_FINGERPRINT_PLAN.md`**.

## 20. PH1-M18 artifact-bundle fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`artifact_bundle_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over **`metadata_envelope_fingerprint_digest`** plus the phase-1 companion artifact manifest; see **`docs/ARTIFACT_BUNDLE_FINGERPRINT_PLAN.md`**).
- **`artifact_bundle_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`metadata_envelope_fingerprint_version`**, before the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`metadata_envelope_fingerprint_digest`** differs, **`artifact_bundle_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`artifact_bundle_fingerprint_digest`** when left and right digests differ.

See **`docs/ARTIFACT_BUNDLE_FINGERPRINT_PLAN.md`**.

## 21. PH1-M19 report-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`report_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`artifact_bundle_fingerprint_digest`** to the phase-1 report contract tag; see **`docs/REPORT_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`report_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`artifact_bundle_fingerprint_version`**, before the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`artifact_bundle_fingerprint_digest`** differs, **`report_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`report_envelope_fingerprint_digest`** (and **`report_envelope_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/REPORT_ENVELOPE_FINGERPRINT_PLAN.md`**.

## 22. PH1-M20 compare-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`compare_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`report_envelope_fingerprint_digest`** to the phase-1 compare contract tag; see **`docs/COMPARE_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`compare_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`report_envelope_fingerprint_version`**, before the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`report_envelope_fingerprint_digest`** differs, **`compare_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`compare_envelope_fingerprint_digest`** (and **`compare_envelope_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/COMPARE_ENVELOPE_FINGERPRINT_PLAN.md`**.

## 23. PH1-M21 run-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`run_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`compare_envelope_fingerprint_digest`** to the phase-1 run contract tag; see **`docs/RUN_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`run_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`compare_envelope_fingerprint_version`**, before root **`session_envelope_fingerprint_*`** and the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`compare_envelope_fingerprint_digest`** differs, **`run_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`run_envelope_fingerprint_digest`** (and **`run_envelope_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/RUN_ENVELOPE_FINGERPRINT_PLAN.md`**.

## 24. PH1-M22 session-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`session_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`run_envelope_fingerprint_digest`** to the phase-1 session contract tag; see **`docs/SESSION_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`session_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`run_envelope_fingerprint_version`**, before root **`environment_envelope_fingerprint_*`** and the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`run_envelope_fingerprint_digest`** differs, **`session_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`session_envelope_fingerprint_digest`** (and **`session_envelope_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/SESSION_ENVELOPE_FINGERPRINT_PLAN.md`**.

## 25. PH1-M23 environment-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`environment_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`session_envelope_fingerprint_digest`** to the phase-1 environment contract tag; see **`docs/ENVIRONMENT_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`environment_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`session_envelope_fingerprint_version`**, before root **`artifact_manifest_fingerprint_*`** and the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`session_envelope_fingerprint_digest`** differs, **`environment_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`environment_envelope_fingerprint_digest`** (and **`environment_envelope_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/ENVIRONMENT_ENVELOPE_FINGERPRINT_PLAN.md`**.

## 26. PH1-M24 artifact-manifest fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`artifact_manifest_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`environment_envelope_fingerprint_digest`** to the phase-1 artifact-manifest contract tag; see **`docs/ARTIFACT_MANIFEST_FINGERPRINT_PLAN.md`**).
- **`artifact_manifest_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`environment_envelope_fingerprint_version`**, before the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`environment_envelope_fingerprint_digest`** differs, **`artifact_manifest_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`artifact_manifest_fingerprint_digest`** (and **`artifact_manifest_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/ARTIFACT_MANIFEST_FINGERPRINT_PLAN.md`**.

## 27. PH1-M25 provenance-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`provenance_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`artifact_manifest_fingerprint_digest`** to the phase-1 provenance contract tag; see **`docs/PROVENANCE_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`provenance_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`artifact_manifest_fingerprint_version`**, before the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`artifact_manifest_fingerprint_digest`** differs, **`provenance_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`provenance_envelope_fingerprint_digest`** (and **`provenance_envelope_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/PROVENANCE_ENVELOPE_FINGERPRINT_PLAN.md`**.

## 28. PH1-M26 integrity-envelope fingerprint (artifact runs)

After a full run that writes **`run.json`**, **`report`** must exit **0**. In **`run.json`** root metadata verify:

- **`integrity_envelope_fingerprint_digest`**: **64** lowercase hex characters (SHA-256 over the canonical payload binding **`provenance_envelope_fingerprint_digest`** to the phase-1 integrity contract tag; see **`docs/INTEGRITY_ENVELOPE_FINGERPRINT_PLAN.md`**).
- **`integrity_envelope_fingerprint_version`**: **`1`**.
- Serialization order: immediately after **`provenance_envelope_fingerprint_version`**, before the nested **`transport`** object (see **`docs/REPORT_FORMAT.md`**).

**Compare**: when **`provenance_envelope_fingerprint_digest`** differs, **`integrity_envelope_fingerprint_digest`** should differ. **`metadata_deltas`** should include **`integrity_envelope_fingerprint_digest`** (and **`integrity_envelope_fingerprint_version`** when applicable) when left and right values differ.

See **`docs/INTEGRITY_ENVELOPE_FINGERPRINT_PLAN.md`**.

## References

- Terminal flags and behavior: `docs/CLI.md`
- Suite contents: `docs/SUITES.md` and `examples/smoke/baseline-linux.txt`
- Comparison scope: `docs/COMPARE_PLAN.md`
- Run artifact fields: `docs/REPORT_FORMAT.md`
- Protocol execution seam: `docs/PROTO_EXEC_PLAN.md`
- Transport seam: `docs/TRANSPORT_PLAN.md`
- Guarded transport: `docs/REAL_TRANSPORT_GUARD_PLAN.md`
- Linux PTY experiment: `docs/PTY_EXPERIMENT_PLAN.md`
- PTY experiment hardening: `docs/PTY_EXPERIMENT_HARDENING_PLAN.md`
- PTY reproducibility (PH1-M9): `docs/PTY_REPRODUCIBILITY_PLAN.md`
- Host identity (PH1-M10): `docs/HOST_IDENTITY_PLAN.md`
- Run fingerprint (PH1-M11): `docs/RUN_FINGERPRINT_PLAN.md`
- Spec-set fingerprint (PH1-M12): `docs/SPECSET_FINGERPRINT_PLAN.md`
- Results-set fingerprint (PH1-M13): `docs/RESULTSET_FINGERPRINT_PLAN.md`
- Transport fingerprint (PH1-M14): `docs/TRANSPORT_FINGERPRINT_PLAN.md`
- Execution-summary fingerprint (PH1-M15): `docs/EXEC_SUMMARY_FINGERPRINT_PLAN.md`
- Context-summary fingerprint (PH1-M16): `docs/CONTEXT_SUMMARY_FINGERPRINT_PLAN.md`
- Metadata-envelope fingerprint (PH1-M17): `docs/METADATA_ENVELOPE_FINGERPRINT_PLAN.md`
- Artifact-bundle fingerprint (PH1-M18): `docs/ARTIFACT_BUNDLE_FINGERPRINT_PLAN.md`
- Report-envelope fingerprint (PH1-M19): `docs/REPORT_ENVELOPE_FINGERPRINT_PLAN.md`
- Compare-envelope fingerprint (PH1-M20): `docs/COMPARE_ENVELOPE_FINGERPRINT_PLAN.md`
- Run-envelope fingerprint (PH1-M21): `docs/RUN_ENVELOPE_FINGERPRINT_PLAN.md`
- Session-envelope fingerprint (PH1-M22): `docs/SESSION_ENVELOPE_FINGERPRINT_PLAN.md`
- Environment-envelope fingerprint (PH1-M23): `docs/ENVIRONMENT_ENVELOPE_FINGERPRINT_PLAN.md`
- Artifact-manifest fingerprint (PH1-M24): `docs/ARTIFACT_MANIFEST_FINGERPRINT_PLAN.md`
- Provenance-envelope fingerprint (PH1-M25): `docs/PROVENANCE_ENVELOPE_FINGERPRINT_PLAN.md`
- Integrity-envelope fingerprint (PH1-M26): `docs/INTEGRITY_ENVELOPE_FINGERPRINT_PLAN.md`
