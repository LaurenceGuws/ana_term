const std = @import("std");

pub const RunMeta = struct {
    platform: ?[]const u8 = null,
    term: ?[]const u8 = null,
    terminal_name: ?[]const u8 = null,
    suite: ?[]const u8 = null,
    comparison_id: ?[]const u8 = null,
    run_group: ?[]const u8 = null,
    execution_mode: ?[]const u8 = null,
    host_identity_machine: ?[]const u8 = null,
    host_identity_release: ?[]const u8 = null,
    host_identity_sysname: ?[]const u8 = null,
    run_fingerprint_digest: ?[]const u8 = null,
    run_fingerprint_version: ?[]const u8 = null,
    specset_fingerprint_digest: ?[]const u8 = null,
    specset_fingerprint_version: ?[]const u8 = null,
    resultset_fingerprint_digest: ?[]const u8 = null,
    resultset_fingerprint_version: ?[]const u8 = null,
    transport_fingerprint_digest: ?[]const u8 = null,
    transport_fingerprint_version: ?[]const u8 = null,
    exec_summary_fingerprint_digest: ?[]const u8 = null,
    exec_summary_fingerprint_version: ?[]const u8 = null,
    context_summary_fingerprint_digest: ?[]const u8 = null,
    context_summary_fingerprint_version: ?[]const u8 = null,
    guarded_opt_in: ?[]const u8 = null,
    guarded_state: ?[]const u8 = null,
    pty_capability_notes: ?[]const u8 = null,
    pty_experiment_attempt: ?[]const u8 = null,
    pty_experiment_elapsed_ns: ?[]const u8 = null,
    pty_experiment_error: ?[]const u8 = null,
    pty_experiment_host_machine: ?[]const u8 = null,
    pty_experiment_host_release: ?[]const u8 = null,
    pty_experiment_open_ok: ?[]const u8 = null,
    transport_handshake: ?[]const u8 = null,
    transport_handshake_latency_ns: ?[]const u8 = null,
    transport_mode: ?[]const u8 = null,
    transport_timeout_ms: ?[]const u8 = null,
};

pub const MetaDiffRow = struct {
    field: []const u8,
    left: ?[]const u8,
    right: ?[]const u8,
    delta: []const u8,
};

/// Reads metadata fields. String slices may point into `root`; numeric transport fields are formatted into `allocator`.
pub fn parseRunMeta(allocator: std.mem.Allocator, root: std.json.Value) !RunMeta {
    const obj = switch (root) {
        .object => |o| o,
        else => return .{},
    };
    var m = RunMeta{};
    m.platform = readOptString(obj, "platform");
    m.term = readOptString(obj, "term");
    m.suite = readOptStringOrNull(obj, "suite");
    m.comparison_id = readOptStringOrNull(obj, "comparison_id");
    m.run_group = readOptStringOrNull(obj, "run_group");
    m.execution_mode = readOptString(obj, "execution_mode");
    m.host_identity_machine = readOptString(obj, "host_identity_machine");
    m.host_identity_release = readOptString(obj, "host_identity_release");
    m.host_identity_sysname = readOptString(obj, "host_identity_sysname");
    m.run_fingerprint_digest = readOptString(obj, "run_fingerprint_digest");
    m.run_fingerprint_version = readOptString(obj, "run_fingerprint_version");
    m.specset_fingerprint_digest = readOptString(obj, "specset_fingerprint_digest");
    m.specset_fingerprint_version = readOptString(obj, "specset_fingerprint_version");
    m.resultset_fingerprint_digest = readOptString(obj, "resultset_fingerprint_digest");
    m.resultset_fingerprint_version = readOptString(obj, "resultset_fingerprint_version");
    m.transport_fingerprint_digest = readOptString(obj, "transport_fingerprint_digest");
    m.transport_fingerprint_version = readOptString(obj, "transport_fingerprint_version");
    m.exec_summary_fingerprint_digest = readOptString(obj, "exec_summary_fingerprint_digest");
    m.exec_summary_fingerprint_version = readOptString(obj, "exec_summary_fingerprint_version");
    m.context_summary_fingerprint_digest = readOptString(obj, "context_summary_fingerprint_digest");
    m.context_summary_fingerprint_version = readOptString(obj, "context_summary_fingerprint_version");
    if (obj.get("terminal")) |t| switch (t) {
        .object => |term_o| {
            m.terminal_name = readOptString(term_o, "name");
        },
        else => {},
    } else {}

    if (obj.get("transport")) |tv| switch (tv) {
        .object => |tr| {
            m.transport_mode = readOptString(tr, "mode");
            m.guarded_opt_in = try readOptBoolString(allocator, tr, "guarded_opt_in");
            m.guarded_state = readOptStringOrNull(tr, "guarded_state");
            m.pty_capability_notes = readOptStringOrNull(tr, "pty_capability_notes");
            m.pty_experiment_attempt = try readOptNumberStringOrNull(allocator, tr, "pty_experiment_attempt");
            m.pty_experiment_elapsed_ns = try readOptNumberStringOrNull(allocator, tr, "pty_experiment_elapsed_ns");
            m.pty_experiment_error = readOptStringOrNull(tr, "pty_experiment_error");
            m.pty_experiment_host_machine = readOptStringOrNull(tr, "pty_experiment_host_machine");
            m.pty_experiment_host_release = readOptStringOrNull(tr, "pty_experiment_host_release");
            m.pty_experiment_open_ok = try readOptBoolString(allocator, tr, "pty_experiment_open_ok");
            m.transport_handshake = readHandshakeField(tr);
            m.transport_timeout_ms = try readOptNumberString(allocator, tr, "timeout_ms");
            m.transport_handshake_latency_ns = try readOptNumberString(allocator, tr, "handshake_latency_ns");
        },
        else => {},
    } else {}

    return m;
}

fn readHandshakeField(tr: std.json.ObjectMap) ?[]const u8 {
    const v = tr.get("handshake") orelse return null;
    return switch (v) {
        .string => |s| s,
        .null => null,
        else => null,
    };
}

fn readOptBoolString(allocator: std.mem.Allocator, obj: std.json.ObjectMap, key: []const u8) !?[]const u8 {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .bool => |b| if (b) try allocator.dupe(u8, "true") else try allocator.dupe(u8, "false"),
        .null => null,
        else => return error.InvalidCompareMeta,
    };
}

fn readOptNumberString(allocator: std.mem.Allocator, obj: std.json.ObjectMap, key: []const u8) !?[]const u8 {
    const v = obj.get(key) orelse return null;
    const n = switch (v) {
        .integer => |i| i,
        else => return error.InvalidCompareMeta,
    };
    const s = try std.fmt.allocPrint(allocator, "{d}", .{n});
    return s;
}

fn readOptNumberStringOrNull(allocator: std.mem.Allocator, obj: std.json.ObjectMap, key: []const u8) !?[]const u8 {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .integer => |i| try std.fmt.allocPrint(allocator, "{d}", .{i}),
        .null => null,
        else => return error.InvalidCompareMeta,
    };
}

fn readOptString(obj: std.json.ObjectMap, key: []const u8) ?[]const u8 {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .string => |s| s,
        else => null,
    };
}

fn readOptStringOrNull(obj: std.json.ObjectMap, key: []const u8) ?[]const u8 {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .string => |s| s,
        .null => null,
        else => null,
    };
}

fn metaDelta(l: ?[]const u8, r: ?[]const u8) []const u8 {
    if (l == null and r == null) return "unchanged";
    if (l == null) return "only_right";
    if (r == null) return "only_left";
    if (std.mem.eql(u8, l.?, r.?)) return "unchanged";
    return "changed";
}

/// Fixed field order for deterministic compare output.
pub fn diffRunMeta(left: RunMeta, right: RunMeta) [35]MetaDiffRow {
    return .{
        .{ .field = "comparison_id", .left = left.comparison_id, .right = right.comparison_id, .delta = metaDelta(left.comparison_id, right.comparison_id) },
        .{ .field = "execution_mode", .left = left.execution_mode, .right = right.execution_mode, .delta = metaDelta(left.execution_mode, right.execution_mode) },
        .{ .field = "host_identity_machine", .left = left.host_identity_machine, .right = right.host_identity_machine, .delta = metaDelta(left.host_identity_machine, right.host_identity_machine) },
        .{ .field = "host_identity_release", .left = left.host_identity_release, .right = right.host_identity_release, .delta = metaDelta(left.host_identity_release, right.host_identity_release) },
        .{ .field = "host_identity_sysname", .left = left.host_identity_sysname, .right = right.host_identity_sysname, .delta = metaDelta(left.host_identity_sysname, right.host_identity_sysname) },
        .{ .field = "guarded_opt_in", .left = left.guarded_opt_in, .right = right.guarded_opt_in, .delta = metaDelta(left.guarded_opt_in, right.guarded_opt_in) },
        .{ .field = "guarded_state", .left = left.guarded_state, .right = right.guarded_state, .delta = metaDelta(left.guarded_state, right.guarded_state) },
        .{ .field = "platform", .left = left.platform, .right = right.platform, .delta = metaDelta(left.platform, right.platform) },
        .{ .field = "pty_capability_notes", .left = left.pty_capability_notes, .right = right.pty_capability_notes, .delta = metaDelta(left.pty_capability_notes, right.pty_capability_notes) },
        .{ .field = "pty_experiment_attempt", .left = left.pty_experiment_attempt, .right = right.pty_experiment_attempt, .delta = metaDelta(left.pty_experiment_attempt, right.pty_experiment_attempt) },
        .{ .field = "pty_experiment_elapsed_ns", .left = left.pty_experiment_elapsed_ns, .right = right.pty_experiment_elapsed_ns, .delta = metaDelta(left.pty_experiment_elapsed_ns, right.pty_experiment_elapsed_ns) },
        .{ .field = "pty_experiment_error", .left = left.pty_experiment_error, .right = right.pty_experiment_error, .delta = metaDelta(left.pty_experiment_error, right.pty_experiment_error) },
        .{ .field = "pty_experiment_host_machine", .left = left.pty_experiment_host_machine, .right = right.pty_experiment_host_machine, .delta = metaDelta(left.pty_experiment_host_machine, right.pty_experiment_host_machine) },
        .{ .field = "pty_experiment_host_release", .left = left.pty_experiment_host_release, .right = right.pty_experiment_host_release, .delta = metaDelta(left.pty_experiment_host_release, right.pty_experiment_host_release) },
        .{ .field = "pty_experiment_open_ok", .left = left.pty_experiment_open_ok, .right = right.pty_experiment_open_ok, .delta = metaDelta(left.pty_experiment_open_ok, right.pty_experiment_open_ok) },
        .{ .field = "run_fingerprint_digest", .left = left.run_fingerprint_digest, .right = right.run_fingerprint_digest, .delta = metaDelta(left.run_fingerprint_digest, right.run_fingerprint_digest) },
        .{ .field = "run_fingerprint_version", .left = left.run_fingerprint_version, .right = right.run_fingerprint_version, .delta = metaDelta(left.run_fingerprint_version, right.run_fingerprint_version) },
        .{ .field = "specset_fingerprint_digest", .left = left.specset_fingerprint_digest, .right = right.specset_fingerprint_digest, .delta = metaDelta(left.specset_fingerprint_digest, right.specset_fingerprint_digest) },
        .{ .field = "specset_fingerprint_version", .left = left.specset_fingerprint_version, .right = right.specset_fingerprint_version, .delta = metaDelta(left.specset_fingerprint_version, right.specset_fingerprint_version) },
        .{ .field = "resultset_fingerprint_digest", .left = left.resultset_fingerprint_digest, .right = right.resultset_fingerprint_digest, .delta = metaDelta(left.resultset_fingerprint_digest, right.resultset_fingerprint_digest) },
        .{ .field = "resultset_fingerprint_version", .left = left.resultset_fingerprint_version, .right = right.resultset_fingerprint_version, .delta = metaDelta(left.resultset_fingerprint_version, right.resultset_fingerprint_version) },
        .{ .field = "transport_fingerprint_digest", .left = left.transport_fingerprint_digest, .right = right.transport_fingerprint_digest, .delta = metaDelta(left.transport_fingerprint_digest, right.transport_fingerprint_digest) },
        .{ .field = "transport_fingerprint_version", .left = left.transport_fingerprint_version, .right = right.transport_fingerprint_version, .delta = metaDelta(left.transport_fingerprint_version, right.transport_fingerprint_version) },
        .{ .field = "exec_summary_fingerprint_digest", .left = left.exec_summary_fingerprint_digest, .right = right.exec_summary_fingerprint_digest, .delta = metaDelta(left.exec_summary_fingerprint_digest, right.exec_summary_fingerprint_digest) },
        .{ .field = "exec_summary_fingerprint_version", .left = left.exec_summary_fingerprint_version, .right = right.exec_summary_fingerprint_version, .delta = metaDelta(left.exec_summary_fingerprint_version, right.exec_summary_fingerprint_version) },
        .{ .field = "context_summary_fingerprint_digest", .left = left.context_summary_fingerprint_digest, .right = right.context_summary_fingerprint_digest, .delta = metaDelta(left.context_summary_fingerprint_digest, right.context_summary_fingerprint_digest) },
        .{ .field = "context_summary_fingerprint_version", .left = left.context_summary_fingerprint_version, .right = right.context_summary_fingerprint_version, .delta = metaDelta(left.context_summary_fingerprint_version, right.context_summary_fingerprint_version) },
        .{ .field = "run_group", .left = left.run_group, .right = right.run_group, .delta = metaDelta(left.run_group, right.run_group) },
        .{ .field = "suite", .left = left.suite, .right = right.suite, .delta = metaDelta(left.suite, right.suite) },
        .{ .field = "term", .left = left.term, .right = right.term, .delta = metaDelta(left.term, right.term) },
        .{ .field = "terminal", .left = left.terminal_name, .right = right.terminal_name, .delta = metaDelta(left.terminal_name, right.terminal_name) },
        .{ .field = "transport_handshake", .left = left.transport_handshake, .right = right.transport_handshake, .delta = metaDelta(left.transport_handshake, right.transport_handshake) },
        .{ .field = "transport_handshake_latency_ns", .left = left.transport_handshake_latency_ns, .right = right.transport_handshake_latency_ns, .delta = metaDelta(left.transport_handshake_latency_ns, right.transport_handshake_latency_ns) },
        .{ .field = "transport_mode", .left = left.transport_mode, .right = right.transport_mode, .delta = metaDelta(left.transport_mode, right.transport_mode) },
        .{ .field = "transport_timeout_ms", .left = left.transport_timeout_ms, .right = right.transport_timeout_ms, .delta = metaDelta(left.transport_timeout_ms, right.transport_timeout_ms) },
    };
}

pub const Row = struct {
    status: []const u8,
    notes: []const u8,
};

/// Parses `results` into a map; skips malformed rows (legacy / lenient).
pub fn parseResultsMap(allocator: std.mem.Allocator, root: std.json.Value) !std.StringArrayHashMap(Row) {
    var map = std.StringArrayHashMap(Row).init(allocator);
    errdefer deinitMap(allocator, &map);

    const obj = switch (root) {
        .object => |o| o,
        else => return error.NotObject,
    };

    const results_val = obj.get("results") orelse return error.MissingResults;
    const arr = switch (results_val) {
        .array => |a| a,
        else => return error.BadResults,
    };

    for (arr.items) |item| {
        const row = switch (item) {
            .object => |r| r,
            else => continue,
        };
        const sid_val = row.get("spec_id") orelse continue;
        const st_val = row.get("status") orelse continue;
        const spec_id = switch (sid_val) {
            .string => |s| s,
            else => continue,
        };
        const status = switch (st_val) {
            .string => |s| s,
            else => continue,
        };
        const notes = blk: {
            const n = row.get("notes") orelse break :blk "";
            break :blk switch (n) {
                .string => |s| s,
                else => "",
            };
        };

        const owned_id = try allocator.dupe(u8, spec_id);
        errdefer allocator.free(owned_id);
        const owned_status = try allocator.dupe(u8, status);
        errdefer allocator.free(owned_status);
        const owned_notes = try allocator.dupe(u8, notes);
        errdefer allocator.free(owned_notes);

        try map.put(owned_id, .{ .status = owned_status, .notes = owned_notes });
    }

    return map;
}

/// Strict parse for `compare`: every result row must have string `spec_id` and `status`; duplicate `spec_id` values are rejected.
pub fn parseResultsMapCompare(allocator: std.mem.Allocator, root: std.json.Value) !std.StringArrayHashMap(Row) {
    var map = std.StringArrayHashMap(Row).init(allocator);
    errdefer deinitMap(allocator, &map);

    const obj = switch (root) {
        .object => |o| o,
        else => return error.NotObject,
    };

    const results_val = obj.get("results") orelse return error.MissingResults;
    const arr = switch (results_val) {
        .array => |a| a,
        else => return error.BadResults,
    };

    for (arr.items) |item| {
        const row = switch (item) {
            .object => |r| r,
            else => return error.InvalidResultRow,
        };
        const sid_val = row.get("spec_id") orelse return error.MissingSpecOrStatus;
        const st_val = row.get("status") orelse return error.MissingSpecOrStatus;
        const spec_id = switch (sid_val) {
            .string => |s| s,
            else => return error.MissingSpecOrStatus,
        };
        const status = switch (st_val) {
            .string => |s| s,
            else => return error.MissingSpecOrStatus,
        };

        if (map.get(spec_id) != null) return error.DuplicateSpecId;

        const notes = blk: {
            const n = row.get("notes") orelse break :blk "";
            break :blk switch (n) {
                .string => |s| s,
                else => "",
            };
        };

        const owned_id = try allocator.dupe(u8, spec_id);
        errdefer allocator.free(owned_id);
        const owned_status = try allocator.dupe(u8, status);
        errdefer allocator.free(owned_status);
        const owned_notes = try allocator.dupe(u8, notes);
        errdefer allocator.free(owned_notes);

        try map.put(owned_id, .{ .status = owned_status, .notes = owned_notes });
    }

    return map;
}

pub fn deinitMap(allocator: std.mem.Allocator, map: *std.StringArrayHashMap(Row)) void {
    var it = map.iterator();
    while (it.next()) |e| {
        allocator.free(e.key_ptr.*);
        allocator.free(e.value_ptr.*.status);
        allocator.free(e.value_ptr.*.notes);
    }
    map.deinit();
}

pub const DiffKind = enum {
    added,
    removed,
    changed,
    unchanged,
};

pub const DiffRow = struct {
    spec_id: []const u8,
    left_status: ?[]const u8,
    right_status: ?[]const u8,
    kind: DiffKind,

    pub fn deinit(self: *DiffRow, allocator: std.mem.Allocator) void {
        allocator.free(self.spec_id);
        if (self.left_status) |s| allocator.free(s);
        if (self.right_status) |s| allocator.free(s);
        self.* = undefined;
    }
};

pub fn diffResults(allocator: std.mem.Allocator, left: *const std.StringArrayHashMap(Row), right: *const std.StringArrayHashMap(Row)) ![]DiffRow {
    var seen = std.StringArrayHashMap(void).init(allocator);
    defer seen.deinit();

    var union_ids: std.ArrayList([]const u8) = .empty;
    defer {
        for (union_ids.items) |s| allocator.free(s);
        union_ids.deinit(allocator);
    }

    var lit = left.iterator();
    while (lit.next()) |e| {
        const k = try allocator.dupe(u8, e.key_ptr.*);
        try union_ids.append(allocator, k);
        try seen.put(e.key_ptr.*, {});
    }

    var rit = right.iterator();
    while (rit.next()) |e| {
        if (seen.get(e.key_ptr.*) != null) continue;
        const k = try allocator.dupe(u8, e.key_ptr.*);
        try union_ids.append(allocator, k);
        try seen.put(e.key_ptr.*, {});
    }

    std.mem.sort([]const u8, union_ids.items, {}, struct {
        fn lessThan(_: void, a: []const u8, b: []const u8) bool {
            return std.mem.order(u8, a, b) == .lt;
        }
    }.lessThan);

    var out: std.ArrayList(DiffRow) = .empty;
    errdefer {
        for (out.items) |*r| r.deinit(allocator);
        out.deinit(allocator);
    }

    for (union_ids.items) |id| {
        const l = left.get(id);
        const r = right.get(id);
        const kind: DiffKind = blk: {
            if (l == null and r != null) break :blk .added;
            if (l != null and r == null) break :blk .removed;
            if (l != null and r != null) {
                if (!std.mem.eql(u8, l.?.status, r.?.status)) break :blk .changed;
                break :blk .unchanged;
            }
            unreachable;
        };

        const spec_id = try allocator.dupe(u8, id);
        errdefer allocator.free(spec_id);

        const ls: ?[]const u8 = if (l) |x| try allocator.dupe(u8, x.status) else null;
        errdefer if (ls) |s| allocator.free(s);
        const rs: ?[]const u8 = if (r) |x| try allocator.dupe(u8, x.status) else null;
        errdefer if (rs) |s| allocator.free(s);

        try out.append(allocator, .{
            .spec_id = spec_id,
            .left_status = ls,
            .right_status = rs,
            .kind = kind,
        });
    }

    return try out.toOwnedSlice(allocator);
}

pub fn deinitDiffRows(allocator: std.mem.Allocator, rows: []DiffRow) void {
    for (rows) |*r| r.deinit(allocator);
    allocator.free(rows);
}

fn tdup(a: std.mem.Allocator, s: []const u8) ![]const u8 {
    return try a.dupe(u8, s);
}

test "diffRunMeta detects execution_mode mismatch" {
    const left = RunMeta{ .execution_mode = "placeholder" };
    const right = RunMeta{ .execution_mode = "protocol_stub" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("execution_mode", rows[1].field);
    try std.testing.expectEqualStrings("changed", rows[1].delta);
}

test "diffRunMeta detects transport_mode mismatch" {
    const left = RunMeta{ .transport_mode = "none" };
    const right = RunMeta{ .transport_mode = "pty_stub" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("transport_mode", rows[33].field);
    try std.testing.expectEqualStrings("changed", rows[33].delta);
}

test "diffRunMeta detects pty_experiment_open_ok mismatch" {
    const left = RunMeta{ .pty_experiment_open_ok = "true" };
    const right = RunMeta{ .pty_experiment_open_ok = "false" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("pty_experiment_open_ok", rows[14].field);
    try std.testing.expectEqualStrings("changed", rows[14].delta);
}

test "diffRunMeta detects guarded_state mismatch" {
    const left = RunMeta{ .guarded_state = "na" };
    const right = RunMeta{ .guarded_state = "scaffold_only" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("guarded_state", rows[6].field);
    try std.testing.expectEqualStrings("changed", rows[6].delta);
}

test "diffRunMeta detects pty_experiment_host_machine mismatch" {
    const left = RunMeta{ .pty_experiment_host_machine = "x86_64" };
    const right = RunMeta{ .pty_experiment_host_machine = "aarch64" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("pty_experiment_host_machine", rows[12].field);
    try std.testing.expectEqualStrings("changed", rows[12].delta);
}

test "diffRunMeta detects host_identity_release mismatch" {
    const left = RunMeta{ .host_identity_release = "6.1.0" };
    const right = RunMeta{ .host_identity_release = "6.6.0" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("host_identity_release", rows[3].field);
    try std.testing.expectEqualStrings("changed", rows[3].delta);
}

test "diffRunMeta detects run_fingerprint_digest mismatch" {
    const left = RunMeta{ .run_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" };
    const right = RunMeta{ .run_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("run_fingerprint_digest", rows[15].field);
    try std.testing.expectEqualStrings("changed", rows[15].delta);
}

test "diffRunMeta detects specset_fingerprint_digest mismatch" {
    const left = RunMeta{ .specset_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" };
    const right = RunMeta{ .specset_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("specset_fingerprint_digest", rows[17].field);
    try std.testing.expectEqualStrings("changed", rows[17].delta);
}

test "diffRunMeta detects resultset_fingerprint_digest mismatch" {
    const left = RunMeta{ .resultset_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" };
    const right = RunMeta{ .resultset_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("resultset_fingerprint_digest", rows[19].field);
    try std.testing.expectEqualStrings("changed", rows[19].delta);
}

test "diffRunMeta detects transport_fingerprint_digest mismatch" {
    const left = RunMeta{ .transport_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" };
    const right = RunMeta{ .transport_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("transport_fingerprint_digest", rows[21].field);
    try std.testing.expectEqualStrings("changed", rows[21].delta);
}

test "diffRunMeta detects exec_summary_fingerprint_digest mismatch" {
    const left = RunMeta{ .exec_summary_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" };
    const right = RunMeta{ .exec_summary_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" };
    const rows = diffRunMeta(left, right);
    try std.testing.expectEqualStrings("exec_summary_fingerprint_digest", rows[23].field);
    try std.testing.expectEqualStrings("changed", rows[23].delta);
}

test "parseRunMeta reads root host identity fields" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const text =
        \\{"host_identity_machine":"aarch64","host_identity_release":"6.6.0","host_identity_sysname":"Linux","run_fingerprint_digest":"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb","run_fingerprint_version":"1","specset_fingerprint_digest":"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc","specset_fingerprint_version":"1","resultset_fingerprint_digest":"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd","resultset_fingerprint_version":"1","transport_fingerprint_digest":"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee","transport_fingerprint_version":"1","exec_summary_fingerprint_digest":"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff","exec_summary_fingerprint_version":"1","context_summary_fingerprint_digest":"1111111111111111111111111111111111111111111111111111111111111111","context_summary_fingerprint_version":"1","transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":1}}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    const m = try parseRunMeta(a, parsed.value);
    try std.testing.expectEqualStrings("aarch64", m.host_identity_machine.?);
    try std.testing.expectEqualStrings("6.6.0", m.host_identity_release.?);
    try std.testing.expectEqualStrings("Linux", m.host_identity_sysname.?);
    try std.testing.expectEqualStrings("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", m.run_fingerprint_digest.?);
    try std.testing.expectEqualStrings("1", m.run_fingerprint_version.?);
    try std.testing.expectEqualStrings("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc", m.specset_fingerprint_digest.?);
    try std.testing.expectEqualStrings("1", m.specset_fingerprint_version.?);
    try std.testing.expectEqualStrings("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd", m.resultset_fingerprint_digest.?);
    try std.testing.expectEqualStrings("1", m.resultset_fingerprint_version.?);
    try std.testing.expectEqualStrings("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", m.transport_fingerprint_digest.?);
    try std.testing.expectEqualStrings("1", m.transport_fingerprint_version.?);
    try std.testing.expectEqualStrings("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", m.exec_summary_fingerprint_digest.?);
    try std.testing.expectEqualStrings("1", m.exec_summary_fingerprint_version.?);
    try std.testing.expectEqualStrings("1111111111111111111111111111111111111111111111111111111111111111", m.context_summary_fingerprint_digest.?);
    try std.testing.expectEqualStrings("1", m.context_summary_fingerprint_version.?);
}

test "parseRunMeta reads PTY experiment telemetry numbers" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const text =
        \\{"transport":{"guarded_opt_in":true,"guarded_state":"experiment_linux_pty","handshake":"x","handshake_latency_ns":1,"mode":"pty_guarded","pty_capability_notes":"n","pty_experiment_attempt":1,"pty_experiment_elapsed_ns":99,"pty_experiment_error":null,"pty_experiment_host_machine":"x86_64","pty_experiment_host_release":"6.1.0","pty_experiment_open_ok":true,"timeout_ms":1}}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    const m = try parseRunMeta(a, parsed.value);
    try std.testing.expectEqualStrings("1", m.pty_experiment_attempt.?);
    try std.testing.expectEqualStrings("99", m.pty_experiment_elapsed_ns.?);
    try std.testing.expectEqualStrings("x86_64", m.pty_experiment_host_machine.?);
    try std.testing.expectEqualStrings("6.1.0", m.pty_experiment_host_release.?);
}

test "parseRunMeta reads null PTY host fields for scaffold_only" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const text =
        \\{"transport":{"guarded_opt_in":true,"guarded_state":"scaffold_only","handshake":"guarded-handshake-v1","handshake_latency_ns":99,"mode":"pty_guarded","pty_capability_notes":null,"pty_experiment_attempt":null,"pty_experiment_elapsed_ns":null,"pty_experiment_error":null,"pty_experiment_host_machine":null,"pty_experiment_host_release":null,"pty_experiment_open_ok":null,"timeout_ms":30000}}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    const m = try parseRunMeta(a, parsed.value);
    try std.testing.expect(m.pty_experiment_host_machine == null);
    try std.testing.expect(m.pty_experiment_host_release == null);
}

test "parseRunMeta formats transport numeric fields" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();
    const text =
        \\{"transport":{"guarded_opt_in":false,"guarded_state":"na","handshake":null,"handshake_latency_ns":0,"mode":"none","timeout_ms":5000}}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    const m = try parseRunMeta(a, parsed.value);
    try std.testing.expectEqualStrings("none", m.transport_mode.?);
    try std.testing.expectEqualStrings("false", m.guarded_opt_in.?);
    try std.testing.expectEqualStrings("na", m.guarded_state.?);
    try std.testing.expectEqualStrings("5000", m.transport_timeout_ms.?);
    try std.testing.expectEqualStrings("0", m.transport_handshake_latency_ns.?);
}

test "parseResultsMapCompare rejects duplicate spec_id" {
    const a = std.testing.allocator;
    const text =
        \\{"results":[{"spec_id":"x","status":"a"},{"spec_id":"x","status":"b"}]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, a, text, .{});
    defer parsed.deinit();
    try std.testing.expectError(error.DuplicateSpecId, parseResultsMapCompare(a, parsed.value));
}

test "parseResultsMapCompare rejects row missing status" {
    const a = std.testing.allocator;
    const text =
        \\{"results":[{"spec_id":"x"}]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, a, text, .{});
    defer parsed.deinit();
    try std.testing.expectError(error.MissingSpecOrStatus, parseResultsMapCompare(a, parsed.value));
}

test "diffResults classifies added removed changed unchanged" {
    const a = std.testing.allocator;
    var left = std.StringArrayHashMap(Row).init(a);
    defer deinitMap(a, &left);
    var right = std.StringArrayHashMap(Row).init(a);
    defer deinitMap(a, &right);

    try left.put(try tdup(a, "gone"), .{ .status = try tdup(a, "x"), .notes = try tdup(a, "") });
    try right.put(try tdup(a, "new"), .{ .status = try tdup(a, "y"), .notes = try tdup(a, "") });
    try left.put(try tdup(a, "same"), .{ .status = try tdup(a, "ok"), .notes = try tdup(a, "") });
    try right.put(try tdup(a, "same"), .{ .status = try tdup(a, "ok"), .notes = try tdup(a, "") });
    try left.put(try tdup(a, "diff"), .{ .status = try tdup(a, "a"), .notes = try tdup(a, "") });
    try right.put(try tdup(a, "diff"), .{ .status = try tdup(a, "b"), .notes = try tdup(a, "") });

    const rows = try diffResults(a, &left, &right);
    defer deinitDiffRows(a, rows);

    try std.testing.expectEqual(@as(usize, 4), rows.len);
    try std.testing.expectEqual(DiffKind.changed, rows[0].kind);
    try std.testing.expectEqualStrings("diff", rows[0].spec_id);
    try std.testing.expectEqual(DiffKind.removed, rows[1].kind);
    try std.testing.expectEqualStrings("gone", rows[1].spec_id);
    try std.testing.expectEqual(DiffKind.added, rows[2].kind);
    try std.testing.expectEqualStrings("new", rows[2].spec_id);
    try std.testing.expectEqual(DiffKind.unchanged, rows[3].kind);
    try std.testing.expectEqualStrings("same", rows[3].spec_id);
}
