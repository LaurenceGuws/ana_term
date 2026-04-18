const std = @import("std");
const errors = @import("../core/errors.zig");
const modes = @import("../capture/modes.zig");
const suite_manifest = @import("suite_manifest.zig");
const run_pipeline = @import("run_pipeline.zig");

pub fn execute(allocator: std.mem.Allocator, argv: []const []const u8) u8 {
    if (argv.len == 0) {
        printErr("usage: ana_term run-suite <name> [--capture <mode>]\n") catch {};
        return errors.Category.unknown_command.exitCode();
    }

    const suite_name = argv[0];
    if (!std.mem.eql(u8, suite_name, "baseline-linux")) {
        printErr("unknown suite (only baseline-linux is defined)\n") catch {};
        return errors.Category.unknown_command.exitCode();
    }

    var capture_mode: []const u8 = modes.defaultMode();
    var i: usize = 1;
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
            printErr("unknown flag (terminal flags come in later tickets)\n") catch {};
            return errors.Category.unknown_command.exitCode();
        }
        printErr("unexpected positional argument\n") catch {};
        return errors.Category.unknown_command.exitCode();
    }

    const paths = suite_manifest.loadBaselineLinux(allocator) catch return errors.Category.runtime_failure.exitCode();
    defer suite_manifest.freePathList(allocator, paths);

    return run_pipeline.executeSpecPaths(allocator, paths, capture_mode);
}

fn printErr(msg: []const u8) !void {
    var buf: [512]u8 = undefined;
    var w = std.fs.File.stderr().writer(&buf);
    try w.interface.print("{s}", .{msg});
    try w.interface.flush();
}
