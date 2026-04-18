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

    const tr_o = obj.get("transport") orelse return "missing transport object";
    const tr = switch (tr_o) {
        .object => |t| t,
        else => return "transport must be a JSON object",
    };
    const tr_mode = getString(tr, "mode") orelse return "missing or invalid transport.mode (string required)";
    if (!std.mem.eql(u8, tr_mode, "none") and !std.mem.eql(u8, tr_mode, "pty_stub")) {
        return "transport.mode must be none or pty_stub";
    }
    const timeout_ms = getInteger(tr, "timeout_ms") orelse return "transport.timeout_ms must be an integer";
    if (timeout_ms <= 0) return "transport.timeout_ms must be positive";

    const hs = tr.get("handshake") orelse return "transport.handshake required";
    if (std.mem.eql(u8, tr_mode, "none")) {
        switch (hs) {
            .null => {},
            else => return "transport.handshake must be null when mode is none",
        }
    } else {
        if (getString(tr, "handshake") == null) return "transport.handshake must be a string when mode is pty_stub";
    }

    const hlat = getInteger(tr, "handshake_latency_ns") orelse return "transport.handshake_latency_ns must be an integer";
    if (hlat < 0) return "transport.handshake_latency_ns must be non-negative";
    if (std.mem.eql(u8, tr_mode, "none") and hlat != 0) {
        return "transport.handshake_latency_ns must be 0 when mode is none";
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

test "validateRunReport accepts minimal harness-shaped run.json" {
    const text =
        \\{"schema_version":"0.2","run_id":"run-001","started_at":"","ended_at":"","platform":"linux","term":"xterm","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"execution_mode":"placeholder","transport":{"handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[{"spec_id":"p","status":"manual","notes":"","capture_mode":"manual","observations":{}}]}
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
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"execution_mode":"placeholder","transport":{"handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[{"spec_id":"p","status":"manual","notes":"","capture_mode":"manual"}]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects non-object terminal" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":"oops","execution_mode":"placeholder","transport":{"handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects invalid execution_mode" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"execution_mode":"bogus","transport":{"handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects invalid transport.mode" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"execution_mode":"placeholder","transport":{"handshake":null,"handshake_latency_ns":0,"mode":"bogus","timeout_ms":30000},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}
