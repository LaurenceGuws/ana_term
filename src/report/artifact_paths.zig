const std = @import("std");

/// Returns a new directory path `artifacts_root/YYYY-MM-DD/run-XXX/` (creates directories).
pub fn nextRunDirectory(allocator: std.mem.Allocator, artifact_root: []const u8) ![]const u8 {
    const ns = std.time.nanoTimestamp();
    const sec: u64 = @intCast(@divFloor(ns, std.time.ns_per_s));
    const es = std.time.epoch.EpochSeconds{ .secs = sec };

    var date_buf: [10]u8 = undefined;
    const date_slice = try formatDate(date_buf[0..], es.secs);

    const day_path = try std.fs.path.join(allocator, &.{ artifact_root, date_slice });
    defer allocator.free(day_path);

    try std.fs.cwd().makePath(day_path);

    var dir = try std.fs.cwd().openDir(day_path, .{ .iterate = true });
    defer dir.close();

    var max_run: u32 = 0;
    var it = dir.iterate();
    while (try it.next()) |e| {
        if (e.kind != .directory) continue;
        if (!std.mem.startsWith(u8, e.name, "run-")) continue;
        const n = parseRunSuffix(e.name) orelse continue;
        max_run = @max(max_run, n);
    }

    const next = max_run + 1;
    const label = try std.fmt.allocPrint(allocator, "run-{d:0>3}", .{next});
    defer allocator.free(label);

    const full = try std.fs.path.join(allocator, &.{ artifact_root, date_slice, label });
    try std.fs.cwd().makePath(full);
    return full;
}

fn formatDate(buf: []u8, unix_secs: u64) ![]const u8 {
    const es = std.time.epoch.EpochSeconds{ .secs = unix_secs };
    const yd = es.getEpochDay().calculateYearDay();
    const md = yd.calculateMonthDay();
    return try std.fmt.bufPrint(buf, "{d:0>4}-{d:0>2}-{d:0>2}", .{
        yd.year,
        md.month.numeric(),
        md.day_index + 1,
    });
}

fn parseRunSuffix(name: []const u8) ?u32 {
    const prefix = "run-";
    if (!std.mem.startsWith(u8, name, prefix)) return null;
    return std.fmt.parseUnsigned(u32, name[prefix.len..], 10) catch null;
}
