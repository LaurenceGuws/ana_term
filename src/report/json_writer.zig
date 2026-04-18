const std = @import("std");
const run_execute = @import("../runner/run_execute.zig");

/// Writes a minimal `run.json` placeholder (`docs/REPORT_FORMAT.md`).
pub fn writePlaceholder(allocator: std.mem.Allocator, run_dir: []const u8, run_id: []const u8) !void {
    try writeRun(allocator, run_dir, run_id, &.{});
}

/// Writes `run.json` including one entry per `RunRecord`.
pub fn writeRun(
    allocator: std.mem.Allocator,
    run_dir: []const u8,
    run_id: []const u8,
    records: []const run_execute.RunRecord,
) !void {
    const path = try std.fmt.allocPrint(allocator, "{s}/run.json", .{run_dir});
    defer allocator.free(path);

    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(allocator);

    try buf.print(allocator, "{{\n  \"schema_version\": \"0.1\",\n  \"run_id\": \"{s}\",\n  \"started_at\": \"\",\n  \"ended_at\": \"\",\n  \"platform\": \"\",\n  \"terminal\": {{\"name\": \"\"}},\n  \"term\": \"\",\n  \"results\": [\n", .{run_id});
    for (records, 0..) |r, i| {
        if (i > 0) try buf.appendSlice(allocator, ",\n");
        try buf.print(allocator,
            "    {{\"spec_id\":\"{s}\",\"status\":\"{s}\",\"notes\":\"{s}\",\"capture_mode\":\"{s}\",\"observations\":{{}}}}",
            .{ r.spec_id, r.status, r.notes, r.capture_mode },
        );
    }
    try buf.appendSlice(allocator, "\n  ]\n}\n");

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = buf.items });
}
