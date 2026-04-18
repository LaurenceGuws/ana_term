test {
    _ = @import("report/artifact_paths.zig");
    _ = @import("report/run_json_validate.zig");
    _ = @import("compare/run_json.zig");
    _ = @import("runner/transport_guard_preflight.zig");
    _ = @import("runner/posix_pty.zig");
}
