const std = @import("std");
const run_execute = @import("../runner/run_execute.zig");
const RunContext = @import("../cli/run_context.zig").RunContext;
const transport_stub = @import("../runner/transport_stub.zig");
const run_json_validate = @import("run_json_validate.zig");
const run_fingerprint = @import("run_fingerprint.zig");

fn appendJsonEncodedString(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), bytes: []const u8) !void {
    var enc: std.io.Writer.Allocating = .init(allocator);
    defer enc.deinit();
    try std.json.Stringify.encodeJsonString(bytes, .{}, &enc.writer);
    try buf.appendSlice(allocator, enc.written());
}

/// Writes a minimal `run.json` placeholder (`docs/REPORT_FORMAT.md`).
pub fn writePlaceholder(allocator: std.mem.Allocator, run_dir: []const u8, run_id: []const u8) !void {
    var ctx = RunContext.initDefault();
    ctx.captureHostIdentity();
    try run_fingerprint.populate(&ctx, allocator, run_id, &.{});
    try writeRun(allocator, run_dir, run_id, &.{}, ctx);
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

    try buf.appendSlice(allocator, ",\n  \"host_identity_machine\": ");
    try appendJsonEncodedString(allocator, &buf, ctx.host_identity_machine[0..ctx.host_identity_machine_len]);
    try buf.appendSlice(allocator, ",\n  \"host_identity_release\": ");
    try appendJsonEncodedString(allocator, &buf, ctx.host_identity_release[0..ctx.host_identity_release_len]);
    try buf.appendSlice(allocator, ",\n  \"host_identity_sysname\": ");
    try appendJsonEncodedString(allocator, &buf, ctx.host_identity_sysname[0..ctx.host_identity_sysname_len]);

    try buf.appendSlice(allocator, ",\n  \"run_fingerprint_digest\": ");
    try appendJsonEncodedString(allocator, &buf, ctx.run_fingerprint_digest_hex[0..ctx.run_fingerprint_digest_len]);
    try buf.appendSlice(allocator, ",\n  \"run_fingerprint_version\": \"1\"");

    const guarded_opt_in = ctx.transport_mode == .pty_guarded;
    const guarded_state: []const u8 = blk: {
        if (ctx.transport_mode != .pty_guarded) break :blk "na";
        if (ctx.dry_run) break :blk "scaffold_only";
        break :blk "experiment_linux_pty";
    };

    try buf.appendSlice(allocator, ",\n  \"transport\": {\n");
    try buf.print(allocator, "    \"guarded_opt_in\": {},\n", .{guarded_opt_in});
    try buf.print(allocator, "    \"guarded_state\": \"{s}\",\n", .{guarded_state});
    try buf.appendSlice(allocator, "    \"handshake\": ");
    if (transport_stub.handshakeString(ctx.transport_mode)) |hs| {
        try buf.print(allocator, "\"{s}\"", .{hs});
    } else {
        try buf.appendSlice(allocator, "null");
    }
    const lat_ns = transport_stub.handshakeLatencyNs(ctx.transport_mode, run_id);
    try buf.print(allocator, ",\n    \"handshake_latency_ns\": {d},\n    \"mode\": \"{s}\"", .{ lat_ns, ctx.transport_mode.tag() });

    if (ctx.transport_mode == .pty_guarded) {
        try buf.appendSlice(allocator, ",\n    \"pty_capability_notes\": ");
        if (ctx.pty_capability_notes) |n| {
            try buf.print(allocator, "\"{s}\"", .{n});
        } else {
            try buf.appendSlice(allocator, "null");
        }
        try buf.appendSlice(allocator, ",\n    \"pty_experiment_attempt\": ");
        if (ctx.pty_experiment_attempt) |a| {
            try buf.print(allocator, "{d}", .{a});
        } else {
            try buf.appendSlice(allocator, "null");
        }
        try buf.appendSlice(allocator, ",\n    \"pty_experiment_elapsed_ns\": ");
        if (ctx.pty_experiment_elapsed_ns) |e| {
            try buf.print(allocator, "{d}", .{e});
        } else {
            try buf.appendSlice(allocator, "null");
        }
        try buf.appendSlice(allocator, ",\n    \"pty_experiment_error\": ");
        if (ctx.pty_experiment_error) |e| {
            try buf.print(allocator, "\"{s}\"", .{e});
        } else {
            try buf.appendSlice(allocator, "null");
        }
        const pty_host_null = std.mem.eql(u8, guarded_state, "scaffold_only");
        try buf.appendSlice(allocator, ",\n    \"pty_experiment_host_machine\": ");
        if (pty_host_null) {
            try buf.appendSlice(allocator, "null");
        } else {
            var enc: std.io.Writer.Allocating = .init(allocator);
            defer enc.deinit();
            try std.json.Stringify.encodeJsonString(
                ctx.pty_experiment_host_machine[0..ctx.pty_experiment_host_machine_len],
                .{},
                &enc.writer,
            );
            try buf.appendSlice(allocator, enc.written());
        }
        try buf.appendSlice(allocator, ",\n    \"pty_experiment_host_release\": ");
        if (pty_host_null) {
            try buf.appendSlice(allocator, "null");
        } else {
            var enc2: std.io.Writer.Allocating = .init(allocator);
            defer enc2.deinit();
            try std.json.Stringify.encodeJsonString(
                ctx.pty_experiment_host_release[0..ctx.pty_experiment_host_release_len],
                .{},
                &enc2.writer,
            );
            try buf.appendSlice(allocator, enc2.written());
        }
        try buf.appendSlice(allocator, ",\n    \"pty_experiment_open_ok\": ");
        if (ctx.pty_experiment_open_ok) |b| {
            try buf.print(allocator, "{}", .{b});
        } else {
            try buf.appendSlice(allocator, "null");
        }
    }

    try buf.print(allocator, ",\n    \"timeout_ms\": {d}\n  }}", .{ctx.timeout_ms});

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

test "writeRun JSON-encodes guarded PTY host snapshot strings" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const run_dir = try std.fmt.allocPrint(std.testing.allocator, ".zig-cache/tmp/{s}", .{tmp.sub_path[0..]});
    defer std.testing.allocator.free(run_dir);

    var ctx = RunContext.initDefault();
    ctx.platform = "linux";
    ctx.terminal_name = "t";
    ctx.transport_mode = .pty_guarded;
    ctx.dry_run = false;
    ctx.pty_capability_notes = "linux /dev/ptmx";
    ctx.pty_experiment_attempt = 1;
    ctx.pty_experiment_elapsed_ns = 0;
    ctx.pty_experiment_open_ok = true;
    ctx.pty_experiment_error = null;
    ctx.captureHostIdentity();

    const mach = "x86_64";
    const rel = "6.1.0-test";
    @memcpy(ctx.pty_experiment_host_machine[0..mach.len], mach);
    ctx.pty_experiment_host_machine_len = @intCast(mach.len);
    @memcpy(ctx.pty_experiment_host_release[0..rel.len], rel);
    ctx.pty_experiment_host_release_len = @intCast(rel.len);

    try writeRun(std.testing.allocator, run_dir, "rid-json-writer", &.{}, ctx);

    const json_path = try std.fmt.allocPrint(std.testing.allocator, "{s}/run.json", .{run_dir});
    defer std.testing.allocator.free(json_path);
    const json_text = try std.fs.cwd().readFileAlloc(std.testing.allocator, json_path, 1 << 20);
    defer std.testing.allocator.free(json_text);

    try std.testing.expect(std.mem.indexOf(u8, json_text, "\"pty_experiment_host_machine\": \"x86_64\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, json_text, "\"pty_experiment_host_release\": \"6.1.0-test\"") != null);

    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, json_text, .{});
    defer parsed.deinit();
    try std.testing.expect(run_json_validate.validateRunReport(parsed.value) == null);
}

test "writeRun escapes quotes in guarded PTY host snapshot strings" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const run_dir = try std.fmt.allocPrint(std.testing.allocator, ".zig-cache/tmp/{s}", .{tmp.sub_path[0..]});
    defer std.testing.allocator.free(run_dir);

    var ctx = RunContext.initDefault();
    ctx.platform = "linux";
    ctx.terminal_name = "t";
    ctx.transport_mode = .pty_guarded;
    ctx.dry_run = false;
    ctx.pty_capability_notes = "linux /dev/ptmx";
    ctx.pty_experiment_attempt = 1;
    ctx.pty_experiment_elapsed_ns = 0;
    ctx.pty_experiment_open_ok = true;
    ctx.pty_experiment_error = null;
    ctx.captureHostIdentity();

    const mach: []const u8 = &.{ 'a', 'b', '"', 'c' };
    @memcpy(ctx.pty_experiment_host_machine[0..mach.len], mach);
    ctx.pty_experiment_host_machine_len = @intCast(mach.len);
    const rel = "ok";
    @memcpy(ctx.pty_experiment_host_release[0..rel.len], rel);
    ctx.pty_experiment_host_release_len = @intCast(rel.len);

    try writeRun(std.testing.allocator, run_dir, "rid-json-esc", &.{}, ctx);

    const json_path = try std.fmt.allocPrint(std.testing.allocator, "{s}/run.json", .{run_dir});
    defer std.testing.allocator.free(json_path);
    const json_text = try std.fs.cwd().readFileAlloc(std.testing.allocator, json_path, 1 << 20);
    defer std.testing.allocator.free(json_text);

    try std.testing.expect(std.mem.indexOf(u8, json_text, "\"pty_experiment_host_machine\": \"ab\\\"c\"") != null);

    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, json_text, .{});
    defer parsed.deinit();
    try std.testing.expect(run_json_validate.validateRunReport(parsed.value) == null);
}
