const std = @import("std");

/// Writes a minimal `run.json` placeholder (`docs/REPORT_FORMAT.md`).
pub fn writePlaceholder(allocator: std.mem.Allocator, run_dir: []const u8, run_id: []const u8) !void {
    const path = try std.fmt.allocPrint(allocator, "{s}/run.json", .{run_dir});
    defer allocator.free(path);

    const payload = try std.fmt.allocPrint(
        allocator,
        "{{\n  \"schema_version\": \"0.1\",\n  \"run_id\": \"{s}\",\n  \"started_at\": \"\",\n  \"ended_at\": \"\",\n  \"platform\": \"\",\n  \"terminal\": {{\"name\": \"\"}},\n  \"term\": \"\",\n  \"results\": []\n}}\n",
        .{run_id},
    );
    defer allocator.free(payload);

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = payload });
}
