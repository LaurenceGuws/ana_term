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

/// Fills `ctx.context_summary_fingerprint_digest_*` from SHA-256 of the PH1-M16 canonical payload (`docs/CONTEXT_SUMMARY_FINGERPRINT_PLAN.md`).
/// Call after `exec_summary_fingerprint.populate` when emitting `run.json`. Pass the same `term` string written to root `term`.
pub fn populate(ctx: *RunContext, allocator: std.mem.Allocator, term: []const u8) !void {
    var canon: std.ArrayList(u8) = .empty;
    defer canon.deinit(allocator);

    try canon.appendSlice(allocator, "PH1-M16/context-summary/fp/v1\n");
    try canon.print(allocator, "{s}\n{s}\n{s}\n", .{
        term,
        ctx.terminal_cmd,
        if (ctx.allow_guarded_transport) "true" else "false",
    });
    try canon.print(allocator, "{s}\n{s}\n{s}\n", .{
        ctx.host_identity_machine[0..ctx.host_identity_machine_len],
        ctx.host_identity_release[0..ctx.host_identity_release_len],
        ctx.host_identity_sysname[0..ctx.host_identity_sysname_len],
    });

    var digest: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(canon.items, &digest, .{});

    writeHexLower(&ctx.context_summary_fingerprint_digest_hex, &digest);
    ctx.context_summary_fingerprint_digest_len = 64;
}
