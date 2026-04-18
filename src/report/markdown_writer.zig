const std = @import("std");
const run_execute = @import("../runner/run_execute.zig");

/// Writes a minimal `summary.md` placeholder (`docs/REPORT_FORMAT.md`).
pub fn writePlaceholder(allocator: std.mem.Allocator, run_dir: []const u8, run_id: []const u8) !void {
    try writeRunSummary(allocator, run_dir, run_id, &.{});
}

pub fn writeRunSummary(
    allocator: std.mem.Allocator,
    run_dir: []const u8,
    run_id: []const u8,
    records: []const run_execute.RunRecord,
) !void {
    const path = try std.fmt.allocPrint(allocator, "{s}/summary.md", .{run_dir});
    defer allocator.free(path);

    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(allocator);

    try buf.print(allocator, "# Run {s}\n\n## Environment\n\n(phase-1 placeholder)\n\n## Results\n\n", .{run_id});
    if (records.len == 0) {
        try buf.appendSlice(allocator, "(none)\n");
    } else {
        for (records) |r| {
            try buf.print(allocator, "- **{s}**: {s} — {s}\n", .{ r.spec_id, r.status, r.notes });
        }
    }

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = buf.items });
}
