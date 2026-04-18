const std = @import("std");

/// Returns `null` if `root` satisfies the phase-1 `run.json` contract (`docs/REPORT_FORMAT.md` + harness output); otherwise a static error description.
pub fn validateRunReport(root: std.json.Value) ?[]const u8 {
    const obj = switch (root) {
        .object => |o| o,
        else => return "expected top-level JSON object",
    };

    if (getString(obj, "schema_version") == null) return "missing or invalid schema_version (string required)";
    if (getString(obj, "run_id") == null) return "missing or invalid run_id (string required)";
    if (getString(obj, "started_at") == null) return "missing or invalid started_at (string required)";
    if (getString(obj, "ended_at") == null) return "missing or invalid ended_at (string required)";
    if (getString(obj, "platform") == null) return "missing or invalid platform (string required)";
    if (getString(obj, "term") == null) return "missing or invalid term (string required)";

    const exec_m = getString(obj, "execution_mode") orelse return "missing or invalid execution_mode (string required)";
    if (!std.mem.eql(u8, exec_m, "placeholder") and !std.mem.eql(u8, exec_m, "protocol_stub")) {
        return "execution_mode must be placeholder or protocol_stub";
    }

    const term_o = obj.get("terminal") orelse return "missing terminal object";
    const term_obj = switch (term_o) {
        .object => |t| t,
        else => return "terminal must be a JSON object",
    };
    if (getString(term_obj, "name") == null) return "terminal.name must be a string";

    const him = getString(obj, "host_identity_machine") orelse return "host_identity_machine must be a string";
    if (him.len == 0) return "host_identity_machine must be non-empty";
    const hir = getString(obj, "host_identity_release") orelse return "host_identity_release must be a string";
    if (hir.len == 0) return "host_identity_release must be non-empty";
    const his = getString(obj, "host_identity_sysname") orelse return "host_identity_sysname must be a string";
    if (his.len == 0) return "host_identity_sysname must be non-empty";

    const rfd = getString(obj, "run_fingerprint_digest") orelse return "run_fingerprint_digest must be a string";
    if (rfd.len != 64) return "run_fingerprint_digest must be 64 lowercase hex characters";
    for (rfd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "run_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const rfv = getString(obj, "run_fingerprint_version") orelse return "run_fingerprint_version must be a string";
    if (!std.mem.eql(u8, rfv, "1")) return "run_fingerprint_version must be 1";

    const sfd = getString(obj, "specset_fingerprint_digest") orelse return "specset_fingerprint_digest must be a string";
    if (sfd.len != 64) return "specset_fingerprint_digest must be 64 lowercase hex characters";
    for (sfd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "specset_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const sfv = getString(obj, "specset_fingerprint_version") orelse return "specset_fingerprint_version must be a string";
    if (!std.mem.eql(u8, sfv, "1")) return "specset_fingerprint_version must be 1";

    const rsd = getString(obj, "resultset_fingerprint_digest") orelse return "resultset_fingerprint_digest must be a string";
    if (rsd.len != 64) return "resultset_fingerprint_digest must be 64 lowercase hex characters";
    for (rsd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "resultset_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const rsv = getString(obj, "resultset_fingerprint_version") orelse return "resultset_fingerprint_version must be a string";
    if (!std.mem.eql(u8, rsv, "1")) return "resultset_fingerprint_version must be 1";

    const tfd = getString(obj, "transport_fingerprint_digest") orelse return "transport_fingerprint_digest must be a string";
    if (tfd.len != 64) return "transport_fingerprint_digest must be 64 lowercase hex characters";
    for (tfd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "transport_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const tfv = getString(obj, "transport_fingerprint_version") orelse return "transport_fingerprint_version must be a string";
    if (!std.mem.eql(u8, tfv, "1")) return "transport_fingerprint_version must be 1";

    const esfd = getString(obj, "exec_summary_fingerprint_digest") orelse return "exec_summary_fingerprint_digest must be a string";
    if (esfd.len != 64) return "exec_summary_fingerprint_digest must be 64 lowercase hex characters";
    for (esfd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "exec_summary_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const esfv = getString(obj, "exec_summary_fingerprint_version") orelse return "exec_summary_fingerprint_version must be a string";
    if (!std.mem.eql(u8, esfv, "1")) return "exec_summary_fingerprint_version must be 1";

    const csfd = getString(obj, "context_summary_fingerprint_digest") orelse return "context_summary_fingerprint_digest must be a string";
    if (csfd.len != 64) return "context_summary_fingerprint_digest must be 64 lowercase hex characters";
    for (csfd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "context_summary_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const csfv = getString(obj, "context_summary_fingerprint_version") orelse return "context_summary_fingerprint_version must be a string";
    if (!std.mem.eql(u8, csfv, "1")) return "context_summary_fingerprint_version must be 1";

    const mefd = getString(obj, "metadata_envelope_fingerprint_digest") orelse return "metadata_envelope_fingerprint_digest must be a string";
    if (mefd.len != 64) return "metadata_envelope_fingerprint_digest must be 64 lowercase hex characters";
    for (mefd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "metadata_envelope_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const mefv = getString(obj, "metadata_envelope_fingerprint_version") orelse return "metadata_envelope_fingerprint_version must be a string";
    if (!std.mem.eql(u8, mefv, "1")) return "metadata_envelope_fingerprint_version must be 1";

    const abfd = getString(obj, "artifact_bundle_fingerprint_digest") orelse return "artifact_bundle_fingerprint_digest must be a string";
    if (abfd.len != 64) return "artifact_bundle_fingerprint_digest must be 64 lowercase hex characters";
    for (abfd) |c| {
        switch (c) {
            '0'...'9', 'a'...'f' => {},
            else => return "artifact_bundle_fingerprint_digest must be 64 lowercase hex characters",
        }
    }
    const abfv = getString(obj, "artifact_bundle_fingerprint_version") orelse return "artifact_bundle_fingerprint_version must be a string";
    if (!std.mem.eql(u8, abfv, "1")) return "artifact_bundle_fingerprint_version must be 1";

    const tr_o = obj.get("transport") orelse return "missing transport object";
    const tr = switch (tr_o) {
        .object => |t| t,
        else => return "transport must be a JSON object",
    };
    const tr_mode = getString(tr, "mode") orelse return "missing or invalid transport.mode (string required)";
    const mode_ok = std.mem.eql(u8, tr_mode, "none") or std.mem.eql(u8, tr_mode, "pty_stub") or std.mem.eql(u8, tr_mode, "pty_guarded");
    if (!mode_ok) {
        return "transport.mode must be none, pty_stub, or pty_guarded";
    }
    const timeout_ms = getInteger(tr, "timeout_ms") orelse return "transport.timeout_ms must be an integer";
    if (timeout_ms <= 0) return "transport.timeout_ms must be positive";

    const guarded_opt_in = getBool(tr, "guarded_opt_in") orelse return "transport.guarded_opt_in must be a boolean";
    const guarded_state = getString(tr, "guarded_state") orelse return "missing or invalid transport.guarded_state (string required)";

    if (std.mem.eql(u8, tr_mode, "none")) {
        if (guarded_opt_in) return "transport.guarded_opt_in must be false when mode is none";
        if (!std.mem.eql(u8, guarded_state, "na")) return "transport.guarded_state must be na when mode is none";
    } else if (std.mem.eql(u8, tr_mode, "pty_stub")) {
        if (guarded_opt_in) return "transport.guarded_opt_in must be false when mode is pty_stub";
        if (!std.mem.eql(u8, guarded_state, "na")) return "transport.guarded_state must be na when mode is pty_stub";
    } else {
        if (!guarded_opt_in) return "transport.guarded_opt_in must be true when mode is pty_guarded";
        const gs_ok = std.mem.eql(u8, guarded_state, "scaffold_only") or std.mem.eql(u8, guarded_state, "experiment_linux_pty");
        if (!gs_ok) return "transport.guarded_state must be scaffold_only or experiment_linux_pty when mode is pty_guarded";

        const po = tr.get("pty_experiment_open_ok") orelse return "missing transport.pty_experiment_open_ok";
        const pe = tr.get("pty_experiment_error") orelse return "missing transport.pty_experiment_error";
        const pn = tr.get("pty_capability_notes") orelse return "missing transport.pty_capability_notes";
        const p_att = tr.get("pty_experiment_attempt") orelse return "missing transport.pty_experiment_attempt";
        const p_el = tr.get("pty_experiment_elapsed_ns") orelse return "missing transport.pty_experiment_elapsed_ns";
        const p_hm = tr.get("pty_experiment_host_machine") orelse return "missing transport.pty_experiment_host_machine";
        const p_hr = tr.get("pty_experiment_host_release") orelse return "missing transport.pty_experiment_host_release";

        if (std.mem.eql(u8, guarded_state, "scaffold_only")) {
            switch (po) {
                .null => {},
                else => return "transport.pty_experiment_open_ok must be null when guarded_state is scaffold_only",
            }
            switch (pe) {
                .null => {},
                else => return "transport.pty_experiment_error must be null when guarded_state is scaffold_only",
            }
            switch (pn) {
                .null => {},
                else => return "transport.pty_capability_notes must be null when guarded_state is scaffold_only",
            }
            switch (p_att) {
                .null => {},
                else => return "transport.pty_experiment_attempt must be null when guarded_state is scaffold_only",
            }
            switch (p_el) {
                .null => {},
                else => return "transport.pty_experiment_elapsed_ns must be null when guarded_state is scaffold_only",
            }
            switch (p_hm) {
                .null => {},
                else => return "transport.pty_experiment_host_machine must be null when guarded_state is scaffold_only",
            }
            switch (p_hr) {
                .null => {},
                else => return "transport.pty_experiment_host_release must be null when guarded_state is scaffold_only",
            }
        } else {
            const open_ok = switch (po) {
                .bool => |b| b,
                else => return "transport.pty_experiment_open_ok must be a boolean when guarded_state is experiment_linux_pty",
            };
            const notes = getString(tr, "pty_capability_notes") orelse return "transport.pty_capability_notes must be a string for experiment_linux_pty";
            if (notes.len == 0) return "transport.pty_capability_notes must be non-empty for experiment_linux_pty";
            const att = getInteger(tr, "pty_experiment_attempt") orelse return "transport.pty_experiment_attempt must be an integer";
            if (att != 1) return "transport.pty_experiment_attempt must be 1";
            const elap = getInteger(tr, "pty_experiment_elapsed_ns") orelse return "transport.pty_experiment_elapsed_ns must be an integer";
            if (elap < 0) return "transport.pty_experiment_elapsed_ns must be non-negative";
            if (elap > std.math.maxInt(i64)) return "transport.pty_experiment_elapsed_ns out of range";
            if (open_ok) {
                switch (pe) {
                    .null => {},
                    else => return "transport.pty_experiment_error must be null when pty_experiment_open_ok is true",
                }
            } else {
                if (getString(tr, "pty_experiment_error") == null) return "transport.pty_experiment_error must be a string when pty_experiment_open_ok is false";
            }
            const host_m = getString(tr, "pty_experiment_host_machine") orelse return "transport.pty_experiment_host_machine must be a string when guarded_state is experiment_linux_pty";
            if (host_m.len == 0) return "transport.pty_experiment_host_machine must be non-empty for experiment_linux_pty";
            const host_r = getString(tr, "pty_experiment_host_release") orelse return "transport.pty_experiment_host_release must be a string when guarded_state is experiment_linux_pty";
            if (host_r.len == 0) return "transport.pty_experiment_host_release must be non-empty for experiment_linux_pty";
        }
    }

    const hs = tr.get("handshake") orelse return "transport.handshake required";
    if (std.mem.eql(u8, tr_mode, "none")) {
        switch (hs) {
            .null => {},
            else => return "transport.handshake must be null when mode is none",
        }
    } else {
        if (getString(tr, "handshake") == null) return "transport.handshake must be a string for stub transport modes";
    }

    const hlat = getInteger(tr, "handshake_latency_ns") orelse return "transport.handshake_latency_ns must be an integer";
    if (hlat < 0) return "transport.handshake_latency_ns must be non-negative";
    if (std.mem.eql(u8, tr_mode, "none") and hlat != 0) {
        return "transport.handshake_latency_ns must be 0 when mode is none";
    }
    if ((std.mem.eql(u8, tr_mode, "pty_stub") or std.mem.eql(u8, tr_mode, "pty_guarded")) and hlat <= 0) {
        return "transport.handshake_latency_ns must be positive for pty_stub and pty_guarded";
    }

    const res_o = obj.get("results") orelse return "missing results array";
    const arr = switch (res_o) {
        .array => |a| a,
        else => return "results must be a JSON array",
    };

    for (arr.items, 0..) |item, i| {
        const row = switch (item) {
            .object => |r| r,
            else => return "results entries must be objects",
        };
        if (getString(row, "spec_id") == null) return "results[].spec_id must be a string";
        if (getString(row, "status") == null) return "results[].status must be a string";
        if (getString(row, "notes") == null) return "results[].notes must be a string";
        if (row.get("observations")) |obs| {
            switch (obs) {
                .object => {},
                else => return "results[].observations must be an object",
            }
        } else return "results[].observations required";
        if (getString(row, "capture_mode") == null) return "results[].capture_mode must be a string";
        _ = i;
    }

    return null;
}

fn getString(obj: std.json.ObjectMap, key: []const u8) ?[]const u8 {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .string => |s| s,
        else => null,
    };
}

fn getInteger(obj: std.json.ObjectMap, key: []const u8) ?i64 {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .integer => |i| i,
        else => null,
    };
}

fn getBool(obj: std.json.ObjectMap, key: []const u8) ?bool {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .bool => |b| b,
        else => null,
    };
}

test "validateRunReport accepts minimal harness-shaped run.json" {
    const text =
        \\{"schema_version":"0.2","run_id":"run-001","started_at":"","ended_at":"","platform":"linux","term":"xterm","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[{"spec_id":"p","status":"manual","notes":"","capture_mode":"manual","observations":{}}]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) == null);
}

test "validateRunReport rejects missing schema_version" {
    const text =
        \\{"run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects result row missing observations" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[{"spec_id":"p","status":"manual","notes":"","capture_mode":"manual"}]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects non-object terminal" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":"oops","execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects invalid execution_mode" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"execution_mode":"bogus","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects invalid transport.mode" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"bogus","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects non-integer transport.timeout_ms" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":3.5},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport accepts pty_guarded transport" {
    const text =
        \\{"schema_version":"0.2","run_id":"rid","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":true,"guarded_state":"scaffold_only","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":null,"pty_experiment_attempt":null,"pty_experiment_elapsed_ns":null,"pty_experiment_error":null,"pty_experiment_host_machine":null,"pty_experiment_host_release":null,"pty_experiment_open_ok":null,"timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) == null);
}

test "validateRunReport accepts pty_guarded experiment_linux_pty success" {
    const text =
        \\{"schema_version":"0.2","run_id":"rid","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":true,"guarded_state":"experiment_linux_pty","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":"linux /dev/ptmx","pty_experiment_attempt":1,"pty_experiment_elapsed_ns":42,"pty_experiment_error":null,"pty_experiment_host_machine":"x86_64","pty_experiment_host_release":"6.1.0-test","pty_experiment_open_ok":true,"timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) == null);
}

test "validateRunReport rejects pty_guarded without opt-in flag in json" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"scaffold_only","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":null,"pty_experiment_attempt":null,"pty_experiment_elapsed_ns":null,"pty_experiment_error":null,"pty_experiment_host_machine":null,"pty_experiment_host_release":null,"pty_experiment_open_ok":null,"timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport accepts pty_guarded experiment failure telemetry" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":true,"guarded_state":"experiment_linux_pty","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":"linux /dev/ptmx","pty_experiment_attempt":1,"pty_experiment_elapsed_ns":0,"pty_experiment_error":"grantpt","pty_experiment_host_machine":"aarch64","pty_experiment_host_release":"6.6.0","pty_experiment_open_ok":false,"timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) == null);
}

test "validateRunReport rejects pty_guarded experiment with wrong attempt count" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":true,"guarded_state":"experiment_linux_pty","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":"linux /dev/ptmx","pty_experiment_attempt":2,"pty_experiment_elapsed_ns":1,"pty_experiment_error":null,"pty_experiment_host_machine":"x86_64","pty_experiment_host_release":"1.0","pty_experiment_open_ok":true,"timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects pty_stub with guarded_state scaffold_only" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"scaffold_only","handshake":"stub-handshake-v1","handshake_latency_ns":1,"mode":"pty_stub","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects pty_guarded experiment missing host_machine" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":true,"guarded_state":"experiment_linux_pty","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":"linux /dev/ptmx","pty_experiment_attempt":1,"pty_experiment_elapsed_ns":0,"pty_experiment_error":null,"pty_experiment_host_release":"6.6.0","pty_experiment_open_ok":true,"timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects pty_guarded scaffold with non-null host_release" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":true,"guarded_state":"scaffold_only","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":null,"pty_experiment_attempt":null,"pty_experiment_elapsed_ns":null,"pty_experiment_error":null,"pty_experiment_host_machine":null,"pty_experiment_host_release":"6.6.0","pty_experiment_open_ok":null,"timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects empty host_identity_machine" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing host_identity_sysname" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects run_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong run_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"2","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects specset_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong specset_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"2","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing specset_fingerprint_digest" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects resultset_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong resultset_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"2","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing resultset_fingerprint_digest" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects transport_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong transport_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"2","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing transport_fingerprint_digest" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects exec_summary_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong exec_summary_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"2","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing exec_summary_fingerprint_digest" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects context_summary_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong context_summary_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"2","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing context_summary_fingerprint_digest" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects metadata_envelope_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"222222222222222222222222222222222222222222222222222222222222222B","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong metadata_envelope_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"2","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing metadata_envelope_fingerprint_digest" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects artifact_bundle_fingerprint_digest with uppercase hex" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"333333333333333333333333333333333333333333333333333333333333333B","artifact_bundle_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects wrong artifact_bundle_fingerprint_version" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","artifact_bundle_fingerprint_digest":"3333333333333333333333333333333333333333333333333333333333333333","artifact_bundle_fingerprint_version":"2","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects missing artifact_bundle_fingerprint_digest" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","host_identity_machine":"x86_64","host_identity_release":"6.0.0","host_identity_sysname":"Linux","run_fingerprint_digest":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","metadata_envelope_fingerprint_digest":"2222222222222222222222222222222222222222222222222222222222222222","metadata_envelope_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}
