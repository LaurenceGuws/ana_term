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

/// Fills `ctx.run_fingerprint_digest_*` from SHA-256 of the PH1-M11 canonical payload.
/// Call after `captureHostIdentity` when emitting `run.json`.
pub fn populate(ctx: *RunContext, allocator: std.mem.Allocator, run_id: []const u8, records: []const run_execute.RunRecord) !void {
    var canon: std.ArrayList(u8) = .empty;
    defer canon.deinit(allocator);

    try canon.print(allocator, "PH1-M11/fp/v1\n{s}\n{s}\n{s}\n{s}\n", .{
        run_id,
        ctx.platform,
        ctx.execution_mode.tag(),
        ctx.transport_mode.tag(),
    });
    try canon.print(allocator, "{s}\n{s}\n{s}\n", .{
        ctx.host_identity_machine[0..ctx.host_identity_machine_len],
        ctx.host_identity_release[0..ctx.host_identity_release_len],
        ctx.host_identity_sysname[0..ctx.host_identity_sysname_len],
    });
    for (records) |r| {
        try canon.print(allocator, "{s}\n", .{r.spec_id});
    }

    var digest: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(canon.items, &digest, .{});

    writeHexLower(&ctx.run_fingerprint_digest_hex, &digest);
    ctx.run_fingerprint_digest_len = 64;
}
