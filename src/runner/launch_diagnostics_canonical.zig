const std = @import("std");

/// PH1-M39: Canonical forms for launch diagnostics inputs to prevent normalization drift.

/// Valid canonical reason tags (one of these values only).
pub const reason_ok: []const u8 = "ok";
pub const reason_missing_executable: []const u8 = "missing_executable";
pub const reason_not_executable: []const u8 = "not_executable";
pub const reason_spawn_failed: []const u8 = "spawn_failed";
pub const reason_timeout: []const u8 = "timeout";
pub const reason_nonzero_exit: []const u8 = "nonzero_exit";
pub const reason_signaled: []const u8 = "signaled";

/// Check if a reason string is a valid canonical form.
pub fn isValidCanonicalReason(reason: []const u8) bool {
    return std.mem.eql(u8, reason, reason_ok) or
        std.mem.eql(u8, reason, reason_missing_executable) or
        std.mem.eql(u8, reason, reason_not_executable) or
        std.mem.eql(u8, reason, reason_spawn_failed) or
        std.mem.eql(u8, reason, reason_timeout) or
        std.mem.eql(u8, reason, reason_nonzero_exit) or
        std.mem.eql(u8, reason, reason_signaled);
}

/// Check if elapsed_ms is in canonical range [0, maxInt(u32)].
pub fn isValidCanonicalElapsed(elapsed_ms: u32) bool {
    _ = elapsed_ms;
    return true; // u32 is always in valid range
}

/// Check if signal is in canonical range [1, 128] (POSIX signal numbers).
pub fn isValidCanonicalSignal(signal: u32) bool {
    return signal >= 1 and signal <= 128;
}

test "isValidCanonicalReason accepts all valid tags" {
    try std.testing.expect(isValidCanonicalReason(reason_ok));
    try std.testing.expect(isValidCanonicalReason(reason_missing_executable));
    try std.testing.expect(isValidCanonicalReason(reason_not_executable));
    try std.testing.expect(isValidCanonicalReason(reason_spawn_failed));
    try std.testing.expect(isValidCanonicalReason(reason_timeout));
    try std.testing.expect(isValidCanonicalReason(reason_nonzero_exit));
    try std.testing.expect(isValidCanonicalReason(reason_signaled));
}

test "isValidCanonicalReason rejects invalid tags" {
    try std.testing.expect(!isValidCanonicalReason(""));
    try std.testing.expect(!isValidCanonicalReason("OK"));
    try std.testing.expect(!isValidCanonicalReason("ok "));
    try std.testing.expect(!isValidCanonicalReason("unknown"));
}

test "isValidCanonicalSignal accepts valid range [1, 128]" {
    try std.testing.expect(isValidCanonicalSignal(1));
    try std.testing.expect(isValidCanonicalSignal(9));
    try std.testing.expect(isValidCanonicalSignal(128));
}

test "isValidCanonicalSignal rejects zero and out-of-range" {
    try std.testing.expect(!isValidCanonicalSignal(0));
    try std.testing.expect(!isValidCanonicalSignal(129));
    try std.testing.expect(!isValidCanonicalSignal(255));
}
