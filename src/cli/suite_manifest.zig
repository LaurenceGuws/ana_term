const std = @import("std");

/// Loads `examples/smoke/baseline-linux.txt` (one repo-relative `.toml` path per line).
pub fn loadBaselineLinux(allocator: std.mem.Allocator) ![][]const u8 {
    return loadManifestFile(allocator, "examples/smoke/baseline-linux.txt");
}

pub fn loadManifestFile(allocator: std.mem.Allocator, path: []const u8) ![][]const u8 {
    const text = std.fs.cwd().readFileAlloc(allocator, path, 1024 * 1024) catch |err| switch (err) {
        error.FileTooBig => return error.OutOfMemory,
        else => |e| return e,
    };
    defer allocator.free(text);

    var list: std.ArrayList([]const u8) = .empty;
    errdefer {
        for (list.items) |p| allocator.free(p);
        list.deinit(allocator);
    }

    var iter = std.mem.splitScalar(u8, text, '\n');
    while (iter.next()) |raw| {
        const line = std.mem.trim(u8, raw, " \t\r");
        if (line.len == 0) continue;
        if (line[0] == '#') continue;
        try list.append(allocator, try allocator.dupe(u8, line));
    }

    return try list.toOwnedSlice(allocator);
}

pub fn freePathList(allocator: std.mem.Allocator, paths: [][]const u8) void {
    for (paths) |p| allocator.free(p);
    allocator.free(paths);
}
