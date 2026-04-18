const std = @import("std");
const run_execute = @import("../runner/run_execute.zig");
const RunContext = @import("../cli/run_context.zig").RunContext;
const transport_stub = @import("../runner/transport_stub.zig");

/// Writes a minimal `run.json` placeholder (`docs/REPORT_FORMAT.md`).
pub fn writePlaceholder(allocator: std.mem.Allocator, run_dir: []const u8, run_id: []const u8) !void {
    try writeRun(allocator, run_dir, run_id, &.{}, RunContext.initDefault());
}

/// Writes `run.json` including one entry per `RunRecord` and PH1-M2 identity fields.
pub fn writeRun(
    allocator: std.mem.Allocator,
    run_dir: []const u8,
    run_id: []const u8,
    records: []const run_execute.RunRecord,
    ctx: RunContext,
) !void {
    const path = try std.fmt.allocPrint(allocator, "{s}/run.json", .{run_dir});
    defer allocator.free(path);

    const term = std.posix.getenv("TERM") orelse "";

    var buf: std.ArrayList(u8) = .empty;
    defer buf.deinit(allocator);

    try buf.print(allocator,
        "{{\n  \"schema_version\": \"0.2\",\n  \"run_id\": \"{s}\",\n  \"platform\": \"{s}\",\n  \"term\": \"{s}\",\n  \"terminal\": {{\n    \"name\": \"{s}\",\n    \"version\": \"\"\n  }}",
        .{ run_id, ctx.platform, term, ctx.terminal_name },
    );

    if (ctx.suite_name) |s| {
        try buf.print(allocator, ",\n  \"suite\": \"{s}\"", .{s});
    } else {
        try buf.appendSlice(allocator, ",\n  \"suite\": null");
    }

    if (ctx.comparison_id) |s| {
        try buf.print(allocator, ",\n  \"comparison_id\": \"{s}\"", .{s});
    } else {
        try buf.appendSlice(allocator, ",\n  \"comparison_id\": null");
    }

    if (ctx.run_group) |s| {
        try buf.print(allocator, ",\n  \"run_group\": \"{s}\"", .{s});
    } else {
        try buf.appendSlice(allocator, ",\n  \"run_group\": null");
    }

    try buf.print(allocator, ",\n  \"execution_mode\": \"{s}\"", .{ctx.execution_mode.tag()});

    try buf.appendSlice(allocator, ",\n  \"transport\": {\n");
    try buf.appendSlice(allocator, "    \"handshake\": ");
    if (transport_stub.handshakeString(ctx.transport_mode)) |hs| {
        try buf.print(allocator, "\"{s}\"", .{hs});
    } else {
        try buf.appendSlice(allocator, "null");
    }
    const lat_ns = transport_stub.handshakeLatencyNs(ctx.transport_mode, run_id);
    try buf.print(allocator, ",\n    \"handshake_latency_ns\": {d},\n    \"mode\": \"{s}\",\n    \"timeout_ms\": {d}\n  }}", .{ lat_ns, ctx.transport_mode.tag(), ctx.timeout_ms });

    try buf.appendSlice(allocator, ",\n  \"started_at\": \"\",\n  \"ended_at\": \"\",\n  \"results\": [\n");

    for (records, 0..) |r, i| {
        if (i > 0) try buf.appendSlice(allocator, ",\n");
        try buf.print(allocator,
            "    {{\"spec_id\":\"{s}\",\"status\":\"{s}\",\"notes\":\"{s}\",\"capture_mode\":\"{s}\",\"observations\":{s}}}",
            .{ r.spec_id, r.status, r.notes, r.capture_mode, r.observations_json },
        );
    }
    try buf.appendSlice(allocator, "\n  ]\n}\n");

    try std.fs.cwd().writeFile(.{ .sub_path = path, .data = buf.items });
}
