const std = @import("std");

pub const Row = struct {
    status: []const u8,
    notes: []const u8,
};

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
