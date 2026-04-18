const std = @import("std");
const errors = @import("../core/errors.zig");

const max_read = 4 * 1024 * 1024;

pub fn execute(allocator: std.mem.Allocator, argv: []const []const u8) u8 {
    if (argv.len < 2) {
        printErr("usage: ana_term compare <run.json|dir> <run.json|dir>\n") catch {};
        return errors.Category.unknown_command.exitCode();
    }

    var owned_a: ?[]const u8 = null;
    defer if (owned_a) |p| allocator.free(p);
    var owned_b: ?[]const u8 = null;
    defer if (owned_b) |p| allocator.free(p);

    const path_a = resolveRunJson(allocator, argv[0], &owned_a) catch return errors.Category.runtime_failure.exitCode();
    const path_b = resolveRunJson(allocator, argv[1], &owned_b) catch return errors.Category.runtime_failure.exitCode();

    const data_a = std.fs.cwd().readFileAlloc(allocator, path_a, max_read) catch {
        printErr("could not read first run.json\n") catch {};
        return errors.Category.runtime_failure.exitCode();
    };
    defer allocator.free(data_a);
    const data_b = std.fs.cwd().readFileAlloc(allocator, path_b, max_read) catch {
        printErr("could not read second run.json\n") catch {};
        return errors.Category.runtime_failure.exitCode();
    };
    defer allocator.free(data_b);

    const parsed_a = std.json.parseFromSlice(std.json.Value, allocator, std.mem.trim(u8, data_a, " \n\r\t"), .{}) catch {
        printErr("invalid JSON in first run file\n") catch {};
        return errors.Category.invalid_spec.exitCode();
    };
    defer parsed_a.deinit();
    const parsed_b = std.json.parseFromSlice(std.json.Value, allocator, std.mem.trim(u8, data_b, " \n\r\t"), .{}) catch {
        printErr("invalid JSON in second run file\n") catch {};
        return errors.Category.invalid_spec.exitCode();
    };
    defer parsed_b.deinit();

    switch (parsed_a.value) {
        .object => {},
        else => {
            printErr("first file: expected top-level JSON object\n") catch {};
            return errors.Category.invalid_spec.exitCode();
        },
    }
    switch (parsed_b.value) {
        .object => {},
        else => {
            printErr("second file: expected top-level JSON object\n") catch {};
            return errors.Category.invalid_spec.exitCode();
        },
    }

    printStdout("compare: stub OK — {s} vs {s}\n", .{ path_a, path_b }) catch return errors.Category.runtime_failure.exitCode();
    return 0;
}

fn resolveRunJson(allocator: std.mem.Allocator, target: []const u8, owned_out: *?[]const u8) ![]const u8 {
    if (std.mem.endsWith(u8, target, ".json")) return target;
    const p = try std.fs.path.join(allocator, &.{ target, "run.json" });
    owned_out.* = p;
    return p;
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
