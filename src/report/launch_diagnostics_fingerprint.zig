const std = @import("std");
const RunContext = @import("../cli/run_context.zig").RunContext;
const LaunchTelemetry = @import("../runner/real_terminal_launch.zig").LaunchTelemetry;

fn writeHexLower(dst: *[64]u8, src: *const [32]u8) void {
    const hex = "0123456789abcdef";
    inline for (0..32) |i| {
        const b = src[i];
        dst[i * 2] = hex[b >> 4];
        dst[i * 2 + 1] = hex[b & 15];
    }
}

/// Fills `ctx.launch_diagnostics_fingerprint_digest_*` from SHA-256 of the PH1-M38 canonical payload.
/// Call after launch completion when emitting `run.json`.
pub fn populate(ctx: *RunContext, allocator: std.mem.Allocator) !void {
    var canon: std.ArrayList(u8) = .empty;
    defer canon.deinit(allocator);

    try canon.print(allocator, "PH1-M38/launch-diagnostics-fingerprint/v1\n", .{});

    // Diagnostics reason (string or "null")
    if (ctx.terminal_launch_diagnostics_reason_len > 0) {
        const reason = ctx.terminal_launch_diagnostics_reason_buf[0..ctx.terminal_launch_diagnostics_reason_len];
        try canon.print(allocator, "{s}\n", .{reason});
    } else {
        try canon.print(allocator, "null\n", .{});
    }

    // Diagnostics elapsed_ms (number or "null")
    if (ctx.terminal_launch_diagnostics_elapsed_ms) |ms| {
        try canon.print(allocator, "{}\n", .{ms});
    } else {
        try canon.print(allocator, "null\n", .{});
    }

    // Diagnostics signal (number or "null")
    if (ctx.terminal_launch_diagnostics_signal) |sig| {
        try canon.print(allocator, "{}\n", .{sig});
    } else {
        try canon.print(allocator, "null\n", .{});
    }

    var digest: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(canon.items, &digest, .{});

    writeHexLower(&ctx.launch_diagnostics_fingerprint_digest_hex, &digest);
    ctx.launch_diagnostics_fingerprint_digest_len = 64;
}

test "populate is deterministic for same inputs" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();

    var ctx1 = RunContext.initDefault();
    @memcpy(ctx1.terminal_launch_diagnostics_reason_buf[0..2], "ok");
    ctx1.terminal_launch_diagnostics_reason_len = 2;
    ctx1.terminal_launch_diagnostics_elapsed_ms = 100;
    ctx1.terminal_launch_diagnostics_signal = null;
    try populate(&ctx1, a);

    var ctx2 = RunContext.initDefault();
    @memcpy(ctx2.terminal_launch_diagnostics_reason_buf[0..2], "ok");
    ctx2.terminal_launch_diagnostics_reason_len = 2;
    ctx2.terminal_launch_diagnostics_elapsed_ms = 100;
    ctx2.terminal_launch_diagnostics_signal = null;
    try populate(&ctx2, a);

    try std.testing.expectEqualSlices(u8, ctx1.launch_diagnostics_fingerprint_digest_hex[0..64], ctx2.launch_diagnostics_fingerprint_digest_hex[0..64]);
}

test "populate changes when diagnostics_reason changes" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();

    var ctx1 = RunContext.initDefault();
    @memcpy(ctx1.terminal_launch_diagnostics_reason_buf[0..2], "ok");
    ctx1.terminal_launch_diagnostics_reason_len = 2;
    ctx1.terminal_launch_diagnostics_elapsed_ms = 100;
    try populate(&ctx1, a);

    var ctx2 = RunContext.initDefault();
    @memcpy(ctx2.terminal_launch_diagnostics_reason_buf[0..7], "timeout");
    ctx2.terminal_launch_diagnostics_reason_len = 7;
    ctx2.terminal_launch_diagnostics_elapsed_ms = 100;
    try populate(&ctx2, a);

    try std.testing.expect(!std.mem.eql(u8, ctx1.launch_diagnostics_fingerprint_digest_hex[0..64], ctx2.launch_diagnostics_fingerprint_digest_hex[0..64]));
}

test "populate changes when diagnostics_signal changes" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const a = arena.allocator();

    var ctx1 = RunContext.initDefault();
    @memcpy(ctx1.terminal_launch_diagnostics_reason_buf[0..7], "signaled");
    ctx1.terminal_launch_diagnostics_reason_len = 7;
    ctx1.terminal_launch_diagnostics_elapsed_ms = 100;
    ctx1.terminal_launch_diagnostics_signal = 9;
    try populate(&ctx1, a);

    var ctx2 = RunContext.initDefault();
    @memcpy(ctx2.terminal_launch_diagnostics_reason_buf[0..7], "signaled");
    ctx2.terminal_launch_diagnostics_reason_len = 7;
    ctx2.terminal_launch_diagnostics_elapsed_ms = 100;
    ctx2.terminal_launch_diagnostics_signal = 15;
    try populate(&ctx2, a);

    try std.testing.expect(!std.mem.eql(u8, ctx1.launch_diagnostics_fingerprint_digest_hex[0..64], ctx2.launch_diagnostics_fingerprint_digest_hex[0..64]));
}
