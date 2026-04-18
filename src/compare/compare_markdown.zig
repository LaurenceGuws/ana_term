const std = @import("std");
const run_json = @import("run_json.zig");

pub fn writeFile(allocator: std.mem.Allocator, path: []const u8, rows: []const run_json.DiffRow, left_path: []const u8, right_path: []const u8) !void {
    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(allocator);

    try buf.appendSlice(allocator, "# Compare\n\n");
    try buf.print(allocator, "- left: `{s}`\n- right: `{s}`\n\n", .{ left_path, right_path });
    try buf.appendSlice(allocator, "| spec_id | delta | left | right |\n|---|---|---|---|\n");

    for (rows) |r| {
        const delta = switch (r.kind) {
            .added => "added",
            .removed => "removed",
            .changed => "changed",
            .unchanged => "unchanged",
        };
        const ls = r.left_status orelse "";
        const rs = r.right_status orelse "";
        try buf.print(allocator, "| `{s}` | {s} | {s} | {s} |\n", .{ r.spec_id, delta, ls, rs });
    }

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = buf.items });
}
