const std = @import("std");
const TransportMode = @import("transport_mode.zig").TransportMode;

pub fn envValueAllowsGuarded(value: ?[]const u8) bool {
    const v = value orelse return false;
    return std.mem.eql(u8, v, "1");
}

pub fn envAllowsGuarded() bool {
    return envValueAllowsGuarded(std.posix.getenv("ANA_TERM_ALLOW_GUARDED_TRANSPORT"));
}

pub fn optInAllowsGuarded(allow_flag: bool) bool {
    return allow_flag or envAllowsGuarded();
}

/// When non-null, stderr message; caller should exit with invalid-spec category.
pub fn preflightMessage(mode: TransportMode, allow_guarded_transport: bool) ?[]const u8 {
    if (mode != .pty_guarded) return null;
    if (optInAllowsGuarded(allow_guarded_transport)) return null;
    return "pty_guarded requires --allow-guarded-transport or ANA_TERM_ALLOW_GUARDED_TRANSPORT=1";
}

test "preflightMessage allows pty_guarded with flag" {
    try std.testing.expect(preflightMessage(.pty_guarded, true) == null);
}

test "preflightMessage skips non guarded modes" {
    try std.testing.expect(preflightMessage(.none, false) == null);
    try std.testing.expect(preflightMessage(.pty_stub, false) == null);
}

test "envValueAllowsGuarded" {
    try std.testing.expect(!envValueAllowsGuarded(null));
    try std.testing.expect(envValueAllowsGuarded("1"));
    try std.testing.expect(!envValueAllowsGuarded("0"));
    try std.testing.expect(!envValueAllowsGuarded(""));
}
