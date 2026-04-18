const std = @import("std");
const TransportMode = @import("transport_mode.zig").TransportMode;

fn fnvRunId(run_id: []const u8) u64 {
    var h: u64 = 14695981039346656037;
    for (run_id) |c| {
        h ^= c;
        h *%= 1099511628211;
    }
    return h;
}

/// Human-readable handshake token for stub transport (deterministic per mode).
pub fn handshakeString(mode: TransportMode) ?[]const u8 {
    return switch (mode) {
        .none => null,
        .pty_stub => "stub-handshake-v1",
        .pty_guarded => null,
    };
}

/// Synthetic handshake latency in nanoseconds (`0` for `none`; FNV of `run_id` for `pty_stub`).
pub fn handshakeLatencyNs(mode: TransportMode, run_id: []const u8) u64 {
    return switch (mode) {
        .none => 0,
        .pty_stub => fnvRunId(run_id),
        .pty_guarded => 0,
    };
}
