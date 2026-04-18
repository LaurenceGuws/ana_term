const std = @import("std");
const RunContext = @import("../cli/run_context.zig").RunContext;
const run_execute = @import("../runner/run_execute.zig");

fn writeHexLower(dst: *[64]u8, src: *const [32]u8) void {
    const hex = "0123456789abcdef";
    inline for (0..32) |i| {
        const b = src[i];
        dst[i * 2] = hex[b >> 4];
        dst[i * 2 + 1] = hex[b & 15];
    }
}

/// Fills `ctx.resultset_fingerprint_digest_*` from SHA-256 of the PH1-M13 canonical payload (`docs/RESULTSET_FINGERPRINT_PLAN.md`).
/// Call after `specset_fingerprint.populate` when emitting `run.json`.
pub fn populate(ctx: *RunContext, allocator: std.mem.Allocator, records: []const run_execute.RunRecord) !void {
    var canon: std.ArrayList(u8) = .empty;
    defer canon.deinit(allocator);

    try canon.appendSlice(allocator, "PH1-M13/resultset/fp/v1\n");
    for (records) |r| {
        try canon.print(allocator, "{s}\n{s}\n{s}\n{s}\n", .{ r.spec_id, r.status, r.capture_mode, r.notes });
    }

    var digest: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(canon.items, &digest, .{});

    writeHexLower(&ctx.resultset_fingerprint_digest_hex, &digest);
    ctx.resultset_fingerprint_digest_len = 64;
}
