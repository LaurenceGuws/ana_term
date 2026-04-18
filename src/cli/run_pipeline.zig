const std = @import("std");
const errors = @import("../core/errors.zig");
const loader = @import("../dsl/loader.zig");
const validator = @import("../dsl/validator.zig");
const run_plan_mod = @import("../runner/run_plan.zig");
const run_execute = @import("../runner/run_execute.zig");
const TerminalInvocation = @import("../runner/terminal_invocation.zig").TerminalInvocation;
const artifact_paths = @import("../report/artifact_paths.zig");
const json_writer = @import("../report/json_writer.zig");
const markdown_writer = @import("../report/markdown_writer.zig");
const env_writer = @import("../report/env_writer.zig");
const RunContext = @import("run_context.zig").RunContext;

pub fn executeSpecPaths(allocator: std.mem.Allocator, spec_paths: []const []const u8, ctx: RunContext) u8 {
    if (spec_paths.len == 0) {
        printErr("no probe specs to run\n") catch {};
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
        const rec = run_execute.executePlaceholder(allocator, plan) catch return errors.Category.runtime_failure.exitCode();
        records.append(allocator, rec) catch return errors.Category.runtime_failure.exitCode();
    }

    const run_dir = artifact_paths.nextRunDirectory(allocator, "artifacts") catch return errors.Category.runtime_failure.exitCode();
    defer allocator.free(run_dir);

    const run_id = std.fs.path.basename(run_dir);

    _ = TerminalInvocation.init(
        if (ctx.terminal_cmd.len > 0) ctx.terminal_cmd else ctx.terminal_name,
        &.{},
        "",
    );

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
