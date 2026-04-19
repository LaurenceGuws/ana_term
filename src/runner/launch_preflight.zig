//! PH1-M35: deterministic argv[0] availability before bounded terminal launch (see `docs/LAUNCH_PREFLIGHT_PLAN.md`).

const std = @import("std");

/// Preflight not applicable (wrong OS, empty probe, or harness path that skips preflight).
pub const reason_na = "na";
/// Resolved target exists and is executable.
pub const reason_ok = "ok";
/// No candidate path or file missing.
pub const reason_missing_executable = "missing_executable";
/// Path exists but is not a regular executable file.
pub const reason_not_executable = "not_executable";

/// Result of an `argv[0]` availability probe; copied into `RunContext` for artifacts.
pub const Probe = struct {
    ok: bool,
    reason: []const u8,
    resolved_path_buf: [512]u8 = std.mem.zeroes([512]u8),
    resolved_path_len: u16 = 0,

    pub fn resolvedPathSlice(self: *const Probe) ?[]const u8 {
        if (self.resolved_path_len == 0) return null;
        return self.resolved_path_buf[0..self.resolved_path_len];
    }
};
