const std = @import("std");

pub const RunMeta = struct {
    platform: ?[]const u8 = null,
    term: ?[]const u8 = null,
    terminal_name: ?[]const u8 = null,
    suite: ?[]const u8 = null,
    comparison_id: ?[]const u8 = null,
    run_group: ?[]const u8 = null,
    execution_mode: ?[]const u8 = null,
};

pub const MetaDiffRow = struct {
    field: []const u8,
    left: ?[]const u8,
    right: ?[]const u8,
    delta: []const u8,
};

/// Reads identity fields from a parsed `run.json` root (slices point into the parsed document).
pub fn parseRunMeta(root: std.json.Value) RunMeta {
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
    if (obj.get("terminal")) |t| switch (t) {
        .object => |term_o| {
            m.terminal_name = readOptString(term_o, "name");
        },
        else => {},
    } else {}
    return m;
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
pub fn diffRunMeta(left: RunMeta, right: RunMeta) [7]MetaDiffRow {
    return .{
        .{ .field = "comparison_id", .left = left.comparison_id, .right = right.comparison_id, .delta = metaDelta(left.comparison_id, right.comparison_id) },
        .{ .field = "execution_mode", .left = left.execution_mode, .right = right.execution_mode, .delta = metaDelta(left.execution_mode, right.execution_mode) },
        .{ .field = "platform", .left = left.platform, .right = right.platform, .delta = metaDelta(left.platform, right.platform) },
        .{ .field = "run_group", .left = left.run_group, .right = right.run_group, .delta = metaDelta(left.run_group, right.run_group) },
        .{ .field = "suite", .left = left.suite, .right = right.suite, .delta = metaDelta(left.suite, right.suite) },
        .{ .field = "term", .left = left.term, .right = right.term, .delta = metaDelta(left.term, right.term) },
        .{ .field = "terminal", .left = left.terminal_name, .right = right.terminal_name, .delta = metaDelta(left.terminal_name, right.terminal_name) },
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
