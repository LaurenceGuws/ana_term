const modes = @import("../capture/modes.zig");
const ExecutionMode = @import("../runner/execution_mode.zig").ExecutionMode;
const TransportMode = @import("../runner/transport_mode.zig").TransportMode;

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
        };
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
