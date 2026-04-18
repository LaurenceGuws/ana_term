const std = @import("std");
const RunContext = @import("../cli/run_context.zig").RunContext;

fn writeHexLower(dst: *[64]u8, src: *const [32]u8) void {
    const hex = "0123456789abcdef";
    inline for (0..32) |i| {
        const b = src[i];
        dst[i * 2] = hex[b >> 4];
        dst[i * 2 + 1] = hex[b & 15];
    }
}

/// Fills `ctx.exec_summary_fingerprint_digest_*` from SHA-256 of the PH1-M15 canonical payload (`docs/EXEC_SUMMARY_FINGERPRINT_PLAN.md`).
/// Call after `transport_fingerprint.populate` when emitting `run.json`.
pub fn populate(ctx: *RunContext, allocator: std.mem.Allocator) !void {
    var canon: std.ArrayList(u8) = .empty;
    defer canon.deinit(allocator);

    try canon.appendSlice(allocator, "PH1-M15/exec-summary/fp/v1\n");
    try canon.print(allocator, "{s}\n{s}\n{s}\n{s}\n{s}\n", .{
        ctx.execution_mode.tag(),
        if (ctx.strict) "true" else "false",
        ctx.platform,
        ctx.capture_mode,
        ctx.terminal_name,
    });

    if (ctx.suite_name) |s| {
        try canon.print(allocator, "{s}\n", .{s});
    } else {
        try canon.appendSlice(allocator, "null\n");
    }
    if (ctx.comparison_id) |s| {
        try canon.print(allocator, "{s}\n", .{s});
    } else {
        try canon.appendSlice(allocator, "null\n");
    }
    if (ctx.run_group) |s| {
        try canon.print(allocator, "{s}\n", .{s});
    } else {
        try canon.appendSlice(allocator, "null\n");
    }

    try canon.print(allocator, "{s}\n{d}\n", .{ ctx.transport_mode.tag(), ctx.timeout_ms });

    var digest: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(canon.items, &digest, .{});

    writeHexLower(&ctx.exec_summary_fingerprint_digest_hex, &digest);
    ctx.exec_summary_fingerprint_digest_len = 64;
}
