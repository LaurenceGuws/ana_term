const std = @import("std");
const errors = @import("../core/errors.zig");
const loader = @import("../dsl/loader.zig");
const validator = @import("../dsl/validator.zig");
const run_plan_mod = @import("../runner/run_plan.zig");
const run_execute = @import("../runner/run_execute.zig");
const protocol_stub = @import("../runner/protocol_stub.zig");
const TerminalInvocation = @import("../runner/terminal_invocation.zig").TerminalInvocation;
const artifact_paths = @import("../report/artifact_paths.zig");
const json_writer = @import("../report/json_writer.zig");
const run_fingerprint = @import("../report/run_fingerprint.zig");
const specset_fingerprint = @import("../report/specset_fingerprint.zig");
const markdown_writer = @import("../report/markdown_writer.zig");
const env_writer = @import("../report/env_writer.zig");
const RunContext = @import("run_context.zig").RunContext;
const transport_guard_preflight = @import("../runner/transport_guard_preflight.zig");
const posix_pty = @import("../runner/posix_pty.zig");

pub fn executeSpecPaths(allocator: std.mem.Allocator, spec_paths: []const []const u8, ctx_in: RunContext) u8 {
    var ctx = ctx_in;
    if (spec_paths.len == 0) {
        printErr("no probe specs to run\n") catch {};
        return errors.Category.invalid_spec.exitCode();
    }

    if (transport_guard_preflight.preflightMessage(ctx.transport_mode, ctx.allow_guarded_transport, ctx.dry_run)) |msg| {
        printErr(msg) catch {};
        printErr("\n") catch {};
        return errors.Category.invalid_spec.exitCode();
    }

    var records = std.ArrayList(run_execute.RunRecord).empty;
    defer {
        for (records.items) |*r| r.deinit(allocator);
        records.deinit(allocator);
    }

    for (spec_paths) |path| {
        var raw = loader.loadFile(allocator, path) catch return errors.Category.runtime_failure.exitCode();
        defer raw.deinit(allocator);

        if (validator.validate(path, raw.text)) |v| {
            printViolation(v) catch {};
            return errors.Category.invalid_spec.exitCode();
        }
        const sid = validator.extractId(raw.text) orelse {
            printErr("could not parse `id` string\n") catch {};
            return errors.Category.invalid_spec.exitCode();
        };

        const plan = run_plan_mod.buildPlan(allocator, path, sid, ctx.capture_mode) catch return errors.Category.runtime_failure.exitCode();
        const rec = switch (ctx.execution_mode) {
            .placeholder => run_execute.executePlaceholder(allocator, plan) catch return errors.Category.runtime_failure.exitCode(),
            .protocol_stub => protocol_stub.executeProtocolStub(allocator, plan) catch return errors.Category.runtime_failure.exitCode(),
        };
        records.append(allocator, rec) catch return errors.Category.runtime_failure.exitCode();
    }

    if (ctx.transport_mode == .pty_guarded and !ctx.dry_run) {
        ctx.capturePtyHostSnapshot();
        ctx.pty_capability_notes = "linux /dev/ptmx grantpt unlockpt ptsname_r slave open";
        ctx.pty_experiment_attempt = 1;
        const t_start = std.time.Instant.now() catch null;
        blk: {
            var pair = posix_pty.openMinimal() catch |err| {
                ctx.pty_experiment_open_ok = false;
                ctx.pty_experiment_error = posix_pty.openErrorTag(err);
                break :blk;
            };
            defer pair.deinit();
            ctx.pty_experiment_open_ok = true;
            ctx.pty_experiment_error = null;
        }
        const elapsed_raw: ?u64 = if (t_start) |ts| blk: {
            if (std.time.Instant.now()) |te| break :blk te.since(ts) else |_| break :blk null;
        } else null;
        const cap: u64 = @intCast(std.math.maxInt(i64));
        ctx.pty_experiment_elapsed_ns = @min(elapsed_raw orelse 0, cap);
    }

    if (ctx.dry_run) {
        printStdout("dry-run: ok, planned {d} spec(s)\n", .{records.items.len}) catch return errors.Category.runtime_failure.exitCode();
        return 0;
    }

    const run_dir = artifact_paths.nextRunDirectory(allocator, "artifacts") catch return errors.Category.runtime_failure.exitCode();
    defer allocator.free(run_dir);

    const run_id = std.fs.path.basename(run_dir);

    _ = TerminalInvocation.init(
        if (ctx.terminal_cmd.len > 0) ctx.terminal_cmd else ctx.terminal_name,
        &.{},
        "",
    );

    ctx.captureHostIdentity();
    run_fingerprint.populate(&ctx, allocator, run_id, records.items) catch return errors.Category.runtime_failure.exitCode();
    specset_fingerprint.populate(&ctx, allocator, records.items) catch return errors.Category.runtime_failure.exitCode();
    json_writer.writeRun(allocator, run_dir, run_id, records.items, ctx) catch return errors.Category.runtime_failure.exitCode();
    markdown_writer.writeRunSummary(allocator, run_dir, run_id, records.items, ctx) catch return errors.Category.runtime_failure.exitCode();
    env_writer.writeEnvJson(allocator, run_dir, ctx) catch return errors.Category.runtime_failure.exitCode();

    printStdout("wrote run artifacts under {s}\n", .{run_dir}) catch return errors.Category.runtime_failure.exitCode();
    return 0;
}

fn printViolation(v: validator.Violation) !void {
    var buf: [512]u8 = undefined;
    var w = std.fs.File.stderr().writer(&buf);
    try w.interface.print("{s}: [{s}] {s}\n", .{ v.path, v.field, v.message });
    try w.interface.flush();
}

fn printErr(msg: []const u8) !void {
    var buf: [256]u8 = undefined;
    var w = std.fs.File.stderr().writer(&buf);
    try w.interface.print("{s}", .{msg});
    try w.interface.flush();
}

fn printStdout(comptime fmt: []const u8, args: anytype) !void {
    var buf: [4096]u8 = undefined;
    var w = std.fs.File.stdout().writer(&buf);
    try w.interface.print(fmt, args);
    try w.interface.flush();
}
