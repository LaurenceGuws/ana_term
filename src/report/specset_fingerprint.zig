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

/// Fills `ctx.specset_fingerprint_digest_*` from SHA-256 of the PH1-M12 canonical payload (`docs/SPECSET_FINGERPRINT_PLAN.md`).
/// Call after `run_fingerprint.populate` when emitting `run.json`.
pub fn populate(ctx: *RunContext, allocator: std.mem.Allocator, records: []const run_execute.RunRecord) !void {
    var canon: std.ArrayList(u8) = .empty;
    defer canon.deinit(allocator);

    try canon.appendSlice(allocator, "PH1-M12/specset/fp/v1\n");
    if (ctx.suite_name) |sn| {
        try canon.print(allocator, "{s}\n", .{sn});
    } else {
        try canon.appendSlice(allocator, "null\n");
    }
    for (records) |r| {
        try canon.print(allocator, "{s}\n", .{r.spec_id});
    }

    var digest: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(canon.items, &digest, .{});

    writeHexLower(&ctx.specset_fingerprint_digest_hex, &digest);
    ctx.specset_fingerprint_digest_len = 64;
}
