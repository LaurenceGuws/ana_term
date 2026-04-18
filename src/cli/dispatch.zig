const std = @import("std");

fn printStdout(comptime fmt: []const u8, args: anytype) !void {
    var buf: [4096]u8 = undefined;
    var w = std.fs.File.stdout().writer(&buf);
    try w.interface.print(fmt, args);
    try w.interface.flush();
}

fn printStderr(comptime fmt: []const u8, args: anytype) !void {
    var buf: [4096]u8 = undefined;
    var w = std.fs.File.stderr().writer(&buf);
    try w.interface.print(fmt, args);
    try w.interface.flush();
}

pub fn run(allocator: std.mem.Allocator, argv: []const []const u8) u8 {
    _ = allocator;
    if (argv.len == 0) {
        usageStderr() catch {};
        return 1;
    }
    const cmd = argv[0];
    if (std.mem.eql(u8, cmd, "list")) {
        printStdout(
            "list: placeholder — discovery wires in ANA-111+ (extra args: {d})\n",
            .{argv.len - 1},
        ) catch return 3;
        return 0;
    }
    if (std.mem.eql(u8, cmd, "run")) {
        printStdout(
            "run: placeholder — full pipeline wires in ANA-119+ (extra args: {d})\n",
            .{argv.len - 1},
        ) catch return 3;
        return 0;
    }
    if (std.mem.eql(u8, cmd, "run-suite")) {
        printStdout(
            "run-suite: placeholder — named suites deferred (extra args: {d})\n",
            .{argv.len - 1},
        ) catch return 3;
        return 0;
    }
    if (std.mem.eql(u8, cmd, "report")) {
        printStdout(
            "report: placeholder — pass path to run.json (extra args: {d})\n",
            .{argv.len - 1},
        ) catch return 3;
        return 0;
    }
    if (std.mem.eql(u8, cmd, "doctor")) {
        printStdout(
            "doctor: phase-1 scaffold OK (cwd and env checks expand later)\n",
            .{},
        ) catch return 3;
        return 0;
    }

    printStderr("unknown command: {s}\n", .{cmd}) catch {};
    return 1;
}

fn usageStderr() !void {
    var buf: [1024]u8 = undefined;
    var w = std.fs.File.stderr().writer(&buf);
    try w.interface.print(
        \\usage: ana_term <command> [args...]
        \\
        \\commands:
        \\  list        Enumerate probe specs (.toml)
        \\  run         Run specs and write artifacts
        \\  run-suite   Run a named suite (stub)
        \\  report      Validate or render report from run.json
        \\  doctor      Environment diagnostics
        \\
    , .{});
    try w.interface.flush();
}
