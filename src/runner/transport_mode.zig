const std = @import("std");

/// Transport seam for a run (`docs/TRANSPORT_PLAN.md`). PH1-M5 uses stubs only.
pub const TransportMode = enum {
    none,
    pty_stub,

    pub fn tag(self: TransportMode) []const u8 {
        return switch (self) {
            .none => "none",
            .pty_stub => "pty_stub",
        };
    }

    pub fn parse(s: []const u8) ?TransportMode {
        if (std.mem.eql(u8, s, "none")) return .none;
        if (std.mem.eql(u8, s, "pty_stub")) return .pty_stub;
        return null;
    }
};
