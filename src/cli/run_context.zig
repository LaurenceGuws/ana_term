const std = @import("std");
const modes = @import("../capture/modes.zig");
const ExecutionMode = @import("../runner/execution_mode.zig").ExecutionMode;
const TransportMode = @import("../runner/transport_mode.zig").TransportMode;

/// Truncated copy of `uname.machine` during guarded PTY experiment (PH1-M9).
pub const pty_host_machine_cap: usize = 64;
/// Truncated copy of `uname.release` during guarded PTY experiment (PH1-M9).
pub const pty_host_release_cap: usize = 256;

pub const RunContext = struct {
    capture_mode: []const u8,
    terminal_name: []const u8,
    terminal_cmd: []const u8,
    platform: []const u8,
    suite_name: ?[]const u8,
    comparison_id: ?[]const u8,
    /// Optional batch label for grouping multiple comparisons (e.g. CI matrix key).
    run_group: ?[]const u8,
    /// When true, plan and execute in memory only (no artifact directory).
    dry_run: bool,
    /// Stricter validation when supported (PH1-M4+).
    strict: bool,
    execution_mode: ExecutionMode,
    transport_mode: TransportMode,
    /// Recorded in `run.json` → `transport.timeout_ms`.
    timeout_ms: u32,
    /// Explicit opt-in for `pty_guarded` (or set `ANA_TERM_ALLOW_GUARDED_TRANSPORT=1`).
    allow_guarded_transport: bool,
    /// Filled for non-dry-run `pty_guarded` on Linux after the minimal PTY experiment.
    pty_experiment_open_ok: ?bool,
    pty_experiment_error: ?[]const u8,
    pty_capability_notes: ?[]const u8,
    /// PH1-M8: single attempt counter for guarded PTY experiment (`1` when run; `null` in artifacts for scaffold_only).
    pty_experiment_attempt: ?u32,
    /// PH1-M8: wall-time nanoseconds for experiment block, clamped to `maxInt(i64)` for JSON.
    pty_experiment_elapsed_ns: ?u64,
    /// PH1-M9: filled at start of non-dry-run guarded PTY experiment on Linux; else length 0.
    pty_experiment_host_machine: [pty_host_machine_cap]u8,
    pty_experiment_host_machine_len: u8,
    pty_experiment_host_release: [pty_host_release_cap]u8,
    pty_experiment_host_release_len: u16,

    pub fn initDefault() RunContext {
        return .{
            .capture_mode = modes.defaultMode(),
            .terminal_name = "unknown",
            .terminal_cmd = "",
            .platform = defaultPlatformTag(),
            .suite_name = null,
            .comparison_id = null,
            .run_group = null,
            .dry_run = false,
            .strict = false,
            .execution_mode = .placeholder,
            .transport_mode = .none,
            .timeout_ms = 30_000,
            .allow_guarded_transport = false,
            .pty_experiment_open_ok = null,
            .pty_experiment_error = null,
            .pty_capability_notes = null,
            .pty_experiment_attempt = null,
            .pty_experiment_elapsed_ns = null,
            .pty_experiment_host_machine = std.mem.zeroes([pty_host_machine_cap]u8),
            .pty_experiment_host_machine_len = 0,
            .pty_experiment_host_release = std.mem.zeroes([pty_host_release_cap]u8),
            .pty_experiment_host_release_len = 0,
        };
    }

    /// Snapshot `uname` for reproducibility; call once per guarded experiment run.
    pub fn capturePtyHostSnapshot(ctx: *RunContext) void {
        const u = std.posix.uname();
        const m = std.mem.sliceTo(&u.machine, 0);
        const n_m = @min(m.len, pty_host_machine_cap);
        @memcpy(ctx.pty_experiment_host_machine[0..n_m], m[0..n_m]);
        ctx.pty_experiment_host_machine_len = @intCast(n_m);

        const r = std.mem.sliceTo(&u.release, 0);
        const n_r = @min(r.len, pty_host_release_cap);
        @memcpy(ctx.pty_experiment_host_release[0..n_r], r[0..n_r]);
        ctx.pty_experiment_host_release_len = @intCast(n_r);
    }
};

pub fn defaultPlatformTag() []const u8 {
    const builtin = @import("builtin");
    return switch (builtin.target.os.tag) {
        .linux => "linux",
        .windows => "windows",
        .macos, .ios, .tvos, .watchos => "darwin",
        else => "unknown",
    };
}

test "capturePtyHostSnapshot fills machine and release on Linux" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    var ctx = RunContext.initDefault();
    ctx.capturePtyHostSnapshot();
    try std.testing.expect(ctx.pty_experiment_host_machine_len > 0);
    try std.testing.expect(ctx.pty_experiment_host_release_len > 0);
}
