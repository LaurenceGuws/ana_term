const std = @import("std");
const errors = @import("../core/errors.zig");
const discovery = @import("../dsl/discovery.zig");
const loader = @import("../dsl/loader.zig");
const validator = @import("../dsl/validator.zig");
const run_plan_mod = @import("../runner/run_plan.zig");
const run_execute = @import("../runner/run_execute.zig");
const modes = @import("../capture/modes.zig");
const artifact_paths = @import("../report/artifact_paths.zig");
const json_writer = @import("../report/json_writer.zig");
const markdown_writer = @import("../report/markdown_writer.zig");

pub fn execute(allocator: std.mem.Allocator, argv: []const []const u8) u8 {
    var capture_mode: []const u8 = modes.defaultMode();
    var roots = std.ArrayList([]const u8).empty;
    defer roots.deinit(allocator);

    var i: usize = 0;
    while (i < argv.len) {
        if (std.mem.eql(u8, argv[i], "--capture")) {
            if (i + 1 >= argv.len) {
                printErr("--capture requires a value\n") catch {};
                return errors.Category.unknown_command.exitCode();
            }
            capture_mode = argv[i + 1];
            if (!modes.isKnown(capture_mode)) {
                printErr("invalid --capture mode\n") catch {};
                return errors.Category.invalid_spec.exitCode();
            }
            i += 2;
            continue;
        }
        if (argv[i].len > 0 and argv[i][0] == '-') {
            printErr("unknown flag\n") catch {};
            return errors.Category.unknown_command.exitCode();
        }
        roots.append(allocator, argv[i]) catch return errors.Category.runtime_failure.exitCode();
        i += 1;
    }

    const roots_slice: []const []const u8 = if (roots.items.len == 0) &[_][]const u8{"probes/smoke"} else roots.items;

    const spec_paths = discovery.discover(allocator, roots_slice) catch return errors.Category.runtime_failure.exitCode();
    defer discovery.freePaths(allocator, spec_paths);

    if (spec_paths.len == 0) {
        printErr("no .toml probe specs found\n") catch {};
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

        const plan = run_plan_mod.buildPlan(allocator, path, sid, capture_mode) catch return errors.Category.runtime_failure.exitCode();
        const rec = run_execute.executePlaceholder(allocator, plan) catch return errors.Category.runtime_failure.exitCode();
        records.append(allocator, rec) catch return errors.Category.runtime_failure.exitCode();
    }

    const run_dir = artifact_paths.nextRunDirectory(allocator, "artifacts") catch return errors.Category.runtime_failure.exitCode();
    defer allocator.free(run_dir);

    const run_id = std.fs.path.basename(run_dir);

    json_writer.writeRun(allocator, run_dir, run_id, records.items) catch return errors.Category.runtime_failure.exitCode();
    markdown_writer.writeRunSummary(allocator, run_dir, run_id, records.items) catch return errors.Category.runtime_failure.exitCode();

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
