const std = @import("std");

/// Writes a minimal `summary.md` placeholder (`docs/REPORT_FORMAT.md`).
pub fn writePlaceholder(allocator: std.mem.Allocator, run_dir: []const u8, run_id: []const u8) !void {
    const path = try std.fmt.allocPrint(allocator, "{s}/summary.md", .{run_dir});
    defer allocator.free(path);

    const payload = try std.fmt.allocPrint(
        allocator,
        "# Run {s}\n\n## Environment\n\n(phase-1 placeholder)\n\n## Results\n\n(none)\n",
        .{run_id},
    );
    defer allocator.free(payload);

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = payload });
}
