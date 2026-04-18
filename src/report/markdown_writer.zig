const std = @import("std");
const run_execute = @import("../runner/run_execute.zig");
const RunContext = @import("../cli/run_context.zig").RunContext;

/// Writes a minimal `summary.md` placeholder (`docs/REPORT_FORMAT.md`).
pub fn writePlaceholder(allocator: std.mem.Allocator, run_dir: []const u8, run_id: []const u8) !void {
    try writeRunSummary(allocator, run_dir, run_id, &.{}, RunContext.initDefault());
}

pub fn writeRunSummary(
    allocator: std.mem.Allocator,
    run_dir: []const u8,
    run_id: []const u8,
    records: []const run_execute.RunRecord,
    ctx: RunContext,
) !void {
    const path = try std.fmt.allocPrint(allocator, "{s}/summary.md", .{run_dir});
    defer allocator.free(path);

    const term = std.posix.getenv("TERM") orelse "";

    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(allocator);

    try buf.print(allocator, "# Run {s}\n\n## Environment\n\n", .{run_id});
    try buf.print(allocator, "- platform: {s}\n- TERM: {s}\n- terminal (logical): {s}\n- execution_mode: {s}\n", .{ ctx.platform, term, ctx.terminal_name, ctx.execution_mode.tag() });
    if (ctx.terminal_cmd.len > 0) {
        try buf.print(allocator, "- terminal-cmd: `{s}`\n", .{ctx.terminal_cmd});
    }
    if (ctx.suite_name) |s| {
        try buf.print(allocator, "- suite: {s}\n", .{s});
    } else {
        try buf.appendSlice(allocator, "- suite: (direct run)\n");
    }
    if (ctx.comparison_id) |c| {
        try buf.print(allocator, "- comparison_id: {s}\n", .{c});
    }
    if (ctx.run_group) |g| {
        try buf.print(allocator, "- run_group: {s}\n", .{g});
    }
    try buf.appendSlice(allocator, "\n## Results\n\n");

    if (records.len == 0) {
        try buf.appendSlice(allocator, "(none)\n");
    } else {
        for (records) |r| {
            try buf.print(allocator, "- **{s}**: {s} — {s}\n", .{ r.spec_id, r.status, r.notes });
        }
    }

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = buf.items });
}
