const std = @import("std");
const posix = std.posix;
const c = std.c;

/// PH1-M31 process-level launch evidence (maps to `RunContext.terminal_launch_*`).
pub const LaunchTelemetry = struct {
    attempt: ?u32 = null,
    elapsed_ns: ?u64 = null,
    exit_code: ?u32 = null,
    ok: ?bool = null,
    err: ?[]const u8 = null,
};

pub const err_spawn_failed: []const u8 = "spawn_failed";
pub const err_timeout: []const u8 = "timeout";

fn clampJsonNs(raw: u64) u64 {
    return @min(raw, @as(u64, @intCast(std.math.maxInt(i64))));
}

/// Runs `/bin/sh -c <cmd>` with stdio discarded; polls `waitpid(WNOHANG)` until exit or `timeout_ms` elapses (then `SIGKILL`).
/// Non-Linux: returns all-null fields. Empty `cmd`: returns all-null fields.
pub fn runBoundedShellCommand(allocator: std.mem.Allocator, cmd: []const u8, timeout_ms: u32) LaunchTelemetry {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return .{};
    if (cmd.len == 0) return .{};

    const argv = [_][]const u8{ "/bin/sh", "-c", cmd };
    var child = std.process.Child.init(&argv, allocator);
    child.stdin_behavior = .Ignore;
    child.stdout_behavior = .Ignore;
    child.stderr_behavior = .Ignore;

    child.spawn() catch {
        return .{
            .attempt = 1,
            .elapsed_ns = 0,
            .exit_code = null,
            .ok = false,
            .err = err_spawn_failed,
        };
    };

    child.waitForSpawn() catch {
        return .{
            .attempt = 1,
            .elapsed_ns = 0,
            .exit_code = null,
            .ok = false,
            .err = err_spawn_failed,
        };
    };

    const pid = child.id;
    const t_start = std.time.Instant.now() catch {
        posix.kill(pid, posix.SIG.KILL) catch {};
        var st_kill: c_int = undefined;
        _ = c.waitpid(pid, &st_kill, 0);
        return .{
            .attempt = 1,
            .elapsed_ns = 0,
            .exit_code = null,
            .ok = false,
            .err = err_spawn_failed,
        };
    };

    const budget_ns = @as(u64, timeout_ms) * std.time.ns_per_ms;

    while (true) {
        var status: c_int = undefined;
        const wr = c.waitpid(pid, &status, 1); // WNOHANG
        if (wr == 0) {
            const now = std.time.Instant.now() catch {
                posix.kill(pid, posix.SIG.KILL) catch {};
                var st_clock: c_int = undefined;
                _ = c.waitpid(pid, &st_clock, 0);
                return .{
                    .attempt = 1,
                    .elapsed_ns = 0,
                    .exit_code = null,
                    .ok = false,
                    .err = err_spawn_failed,
                };
            };
            const elapsed_raw = now.since(t_start);
            if (elapsed_raw > budget_ns) {
                posix.kill(pid, posix.SIG.KILL) catch {};
                var st_to: c_int = undefined;
                _ = c.waitpid(pid, &st_to, 0);
                const el = clampJsonNs(now.since(t_start));
                return .{
                    .attempt = 1,
                    .elapsed_ns = el,
                    .exit_code = null,
                    .ok = false,
                    .err = err_timeout,
                };
            }
            std.Thread.sleep(1 * std.time.ns_per_ms);
            continue;
        }
        if (wr == -1) {
            switch (posix.errno(wr)) {
                .INTR => continue,
                else => {
                    const now_e = std.time.Instant.now() catch {
                        return .{
                            .attempt = 1,
                            .elapsed_ns = 0,
                            .exit_code = null,
                            .ok = false,
                            .err = err_spawn_failed,
                        };
                    };
                    return .{
                        .attempt = 1,
                        .elapsed_ns = clampJsonNs(now_e.since(t_start)),
                        .exit_code = null,
                        .ok = false,
                        .err = err_spawn_failed,
                    };
                },
            }
        }
        if (wr != pid) {
            const now_u = std.time.Instant.now() catch {
                return .{
                    .attempt = 1,
                    .elapsed_ns = 0,
                    .exit_code = null,
                    .ok = false,
                    .err = err_spawn_failed,
                };
            };
            return .{
                .attempt = 1,
                .elapsed_ns = clampJsonNs(now_u.since(t_start)),
                .exit_code = null,
                .ok = false,
                .err = err_spawn_failed,
            };
        }

        const now_done = std.time.Instant.now() catch unreachable;
        const elapsed_final = clampJsonNs(now_done.since(t_start));
        const ustatus: u32 = @bitCast(status);
        if (posix.W.IFEXITED(ustatus)) {
            const ec = posix.W.EXITSTATUS(ustatus);
            return .{
                .attempt = 1,
                .elapsed_ns = elapsed_final,
                .exit_code = ec,
                .ok = ec == 0,
                .err = null,
            };
        }
        return .{
            .attempt = 1,
            .elapsed_ns = elapsed_final,
            .exit_code = null,
            .ok = false,
            .err = null,
        };
    }
}

test "runBoundedShellCommand true exits 0 on Linux" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    const t = runBoundedShellCommand(std.testing.allocator, "true", 5_000);
    try std.testing.expectEqual(@as(?u32, 1), t.attempt);
    try std.testing.expect(t.elapsed_ns != null);
    try std.testing.expectEqual(@as(?u32, 0), t.exit_code);
    try std.testing.expectEqual(@as(?bool, true), t.ok);
    try std.testing.expectEqual(@as(?[]const u8, null), t.err);
}

test "runBoundedShellCommand false exits 1 on Linux" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    const t = runBoundedShellCommand(std.testing.allocator, "false", 5_000);
    try std.testing.expectEqual(@as(?u32, 1), t.attempt);
    try std.testing.expectEqual(@as(?u32, 1), t.exit_code);
    try std.testing.expectEqual(@as(?bool, false), t.ok);
}

test "runBoundedShellCommand times out sleep on Linux" {
    const builtin = @import("builtin");
    if (builtin.target.os.tag != .linux) return error.SkipZigTest;

    const t = runBoundedShellCommand(std.testing.allocator, "sleep 30", 80);
    try std.testing.expectEqual(@as(?u32, 1), t.attempt);
    try std.testing.expectEqual(@as(?u32, null), t.exit_code);
    try std.testing.expectEqual(@as(?bool, false), t.ok);
    try std.testing.expectEqual(err_timeout, t.err.?);
}
