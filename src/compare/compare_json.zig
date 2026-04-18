const std = @import("std");
const run_json = @import("run_json.zig");

/// Writes `compare.json` with lexicographically ordered object keys at each level (`schema_version` 0.2 includes `metadata_deltas`).
pub fn writeFile(
    allocator: std.mem.Allocator,
    path: []const u8,
    rows: []const run_json.DiffRow,
    left_path: []const u8,
    right_path: []const u8,
    meta_rows: []const run_json.MetaDiffRow,
) !void {
    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(allocator);

    try buf.appendSlice(allocator,
        \\{
        \\  "deltas": [
        \\
    );

    for (rows, 0..) |r, i| {
        if (i > 0) try buf.appendSlice(allocator, ",\n");
        const delta_str = switch (r.kind) {
            .added => "added",
            .removed => "removed",
            .changed => "changed",
            .unchanged => "unchanged",
        };
        try buf.appendSlice(allocator, "    {\n");
        try buf.appendSlice(allocator, "      \"delta\": ");
        try appendJsonString(&buf, allocator, delta_str);
        try buf.appendSlice(allocator, ",\n      \"left\": ");
        if (r.left_status) |s| {
            try appendJsonString(&buf, allocator, s);
        } else {
            try buf.appendSlice(allocator, "null");
        }
        try buf.appendSlice(allocator, ",\n      \"right\": ");
        if (r.right_status) |s| {
            try appendJsonString(&buf, allocator, s);
        } else {
            try buf.appendSlice(allocator, "null");
        }
        try buf.appendSlice(allocator, ",\n      \"spec_id\": ");
        try appendJsonString(&buf, allocator, r.spec_id);
        try buf.appendSlice(allocator, "\n    }");
    }

    try buf.appendSlice(allocator, "\n  ],\n  \"left\": ");
    try appendJsonString(&buf, allocator, left_path);
    try buf.appendSlice(allocator, ",\n  \"metadata_deltas\": [\n");

    for (meta_rows, 0..) |m, i| {
        if (i > 0) try buf.appendSlice(allocator, ",\n");
        try buf.appendSlice(allocator, "    {\n");
        try buf.appendSlice(allocator, "      \"delta\": ");
        try appendJsonString(&buf, allocator, m.delta);
        try buf.appendSlice(allocator, ",\n      \"field\": ");
        try appendJsonString(&buf, allocator, m.field);
        try buf.appendSlice(allocator, ",\n      \"left\": ");
        try appendJsonOpt(&buf, allocator, m.left);
        try buf.appendSlice(allocator, ",\n      \"right\": ");
        try appendJsonOpt(&buf, allocator, m.right);
        try buf.appendSlice(allocator, "\n    }");
    }

    try buf.appendSlice(allocator, "\n  ],\n  \"right\": ");
    try appendJsonString(&buf, allocator, right_path);
    try buf.appendSlice(allocator, ",\n  \"schema_version\": \"0.2\"\n}\n");

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = buf.items });
}

fn appendJsonOpt(buf: *std.ArrayList(u8), allocator: std.mem.Allocator, o: ?[]const u8) !void {
    if (o) |s| {
        try appendJsonString(buf, allocator, s);
    } else {
        try buf.appendSlice(allocator, "null");
    }
}

fn appendJsonString(buf: *std.ArrayList(u8), allocator: std.mem.Allocator, s: []const u8) !void {
    try buf.append(allocator, '"');
    for (s) |c| {
        switch (c) {
            '"' => try buf.appendSlice(allocator, "\\\""),
            '\\' => try buf.appendSlice(allocator, "\\\\"),
            '\n' => try buf.appendSlice(allocator, "\\n"),
            '\r' => try buf.appendSlice(allocator, "\\r"),
            '\t' => try buf.appendSlice(allocator, "\\t"),
            else => if (c < 0x20) {
                try buf.print(allocator, "\\u{x:0>4}", .{c});
            } else {
                try buf.append(allocator, c);
            },
        }
    }
    try buf.append(allocator, '"');
}

test "writeFile includes specset_fingerprint_digest in metadata_deltas" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const path = try std.fmt.allocPrint(std.testing.allocator, ".zig-cache/tmp/{s}/compare.json", .{tmp.sub_path[0..]});
    defer std.testing.allocator.free(path);

    const rows: []const run_json.DiffRow = &.{};
    const meta = run_json.diffRunMeta(
        .{ .specset_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" },
        .{ .specset_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" },
    );

    try writeFile(std.testing.allocator, path, rows, "a/run.json", "b/run.json", &meta);

    const text = try std.fs.cwd().readFileAlloc(std.testing.allocator, path, 1 << 20);
    defer std.testing.allocator.free(text);

    try std.testing.expect(std.mem.indexOf(u8, text, "\"field\": \"specset_fingerprint_digest\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, text, "\"delta\": \"changed\"") != null);
}

test "writeFile includes resultset_fingerprint_digest in metadata_deltas" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const path = try std.fmt.allocPrint(std.testing.allocator, ".zig-cache/tmp/{s}/compare-resultset.json", .{tmp.sub_path[0..]});
    defer std.testing.allocator.free(path);

    const rows: []const run_json.DiffRow = &.{};
    const meta = run_json.diffRunMeta(
        .{ .resultset_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" },
        .{ .resultset_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" },
    );

    try writeFile(std.testing.allocator, path, rows, "a/run.json", "b/run.json", &meta);

    const text = try std.fs.cwd().readFileAlloc(std.testing.allocator, path, 1 << 20);
    defer std.testing.allocator.free(text);

    try std.testing.expect(std.mem.indexOf(u8, text, "\"field\": \"resultset_fingerprint_digest\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, text, "\"delta\": \"changed\"") != null);
}

test "writeFile includes transport_fingerprint_digest in metadata_deltas" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const path = try std.fmt.allocPrint(std.testing.allocator, ".zig-cache/tmp/{s}/compare-transport-fp.json", .{tmp.sub_path[0..]});
    defer std.testing.allocator.free(path);

    const rows: []const run_json.DiffRow = &.{};
    const meta = run_json.diffRunMeta(
        .{ .transport_fingerprint_digest = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" },
        .{ .transport_fingerprint_digest = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb" },
    );

    try writeFile(std.testing.allocator, path, rows, "a/run.json", "b/run.json", &meta);

    const text = try std.fs.cwd().readFileAlloc(std.testing.allocator, path, 1 << 20);
    defer std.testing.allocator.free(text);

    try std.testing.expect(std.mem.indexOf(u8, text, "\"field\": \"transport_fingerprint_digest\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, text, "\"delta\": \"changed\"") != null);
}
