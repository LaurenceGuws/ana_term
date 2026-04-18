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

fn appendDigestVersion(canon: *std.ArrayList(u8), allocator: std.mem.Allocator, digest_hex: *const [64]u8, digest_len: u8) !void {
    try canon.print(allocator, "{s}\n1\n", .{digest_hex[0..digest_len]});
}

/// Fills `ctx.report_envelope_fingerprint_digest_*` from SHA-256 of the PH1-M19 canonical payload (`docs/REPORT_ENVELOPE_FINGERPRINT_PLAN.md`).
/// Call after `artifact_bundle_fingerprint.populate` when emitting `run.json`.
pub fn populate(ctx: *RunContext, allocator: std.mem.Allocator) !void {
    var canon: std.ArrayList(u8) = .empty;
    defer canon.deinit(allocator);

    try canon.appendSlice(allocator, "PH1-M19/report-envelope/fp/v1\n");

    try appendDigestVersion(&canon, allocator, &ctx.artifact_bundle_fingerprint_digest_hex, ctx.artifact_bundle_fingerprint_digest_len);

    try canon.appendSlice(allocator, "report:run.json:v0.2\n");

    var digest: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(canon.items, &digest, .{});

    writeHexLower(&ctx.report_envelope_fingerprint_digest_hex, &digest);
    ctx.report_envelope_fingerprint_digest_len = 64;
}
