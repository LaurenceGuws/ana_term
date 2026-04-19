const std = @import("std");
const run_context_mod = @import("../cli/run_context.zig");
const RunContext = run_context_mod.RunContext;

pub const source_cli_override = "cli_override";
pub const source_profile = "profile";
pub const source_fallback = "fallback";

const Profile = struct {
    id: []const u8,
    cmd: []const u8,
};

fn profileMatch(terminal_name: []const u8) ?Profile {
    if (terminal_name.len == 0) return null;
    if (std.ascii.eqlIgnoreCase(terminal_name, "kitty")) return .{ .id = "kitty", .cmd = "kitty" };
    if (std.ascii.eqlIgnoreCase(terminal_name, "ghostty")) return .{ .id = "ghostty", .cmd = "ghostty" };
    if (std.ascii.eqlIgnoreCase(terminal_name, "konsole")) return .{ .id = "konsole", .cmd = "konsole" };
    if (std.ascii.eqlIgnoreCase(terminal_name, "zide-terminal")) return .{ .id = "zide-terminal", .cmd = "zide-terminal" };
    return null;
}

fn copyId(ctx: *RunContext, id: []const u8) void {
    const n = @min(id.len, run_context_mod.terminal_profile_id_cap);
    @memcpy(ctx.terminal_profile_id_buf[0..n], id[0..n]);
    ctx.terminal_profile_id_len = @intCast(n);
}

fn copyEffective(ctx: *RunContext, cmd: []const u8) void {
    const n = @min(cmd.len, run_context_mod.terminal_cmd_storage_cap);
    @memcpy(ctx.terminal_cmd_effective_buf[0..n], cmd[0..n]);
    ctx.terminal_cmd_effective_len = @intCast(n);
    ctx.terminal_cmd = ctx.terminal_cmd_effective_buf[0..n];
}

/// Fills `terminal_cmd` (effective), `terminal_cmd_source`, and profile id buffers per PH1-M33.
/// Call after CLI parse (`terminal_cmd_cli` set from `--terminal-cmd` when present).
pub fn resolveEffective(ctx: *RunContext) void {
    ctx.terminal_profile_id_len = 0;
    ctx.terminal_cmd_effective_len = 0;

    if (ctx.terminal_cmd_cli.len > 0) {
        ctx.terminal_cmd = ctx.terminal_cmd_cli;
        ctx.terminal_cmd_source = source_cli_override;
        if (profileMatch(ctx.terminal_name)) |p| {
            copyId(ctx, p.id);
        }
        return;
    }

    if (profileMatch(ctx.terminal_name)) |p| {
        copyEffective(ctx, p.cmd);
        ctx.terminal_cmd_source = source_profile;
        copyId(ctx, p.id);
        return;
    }

    copyEffective(ctx, ctx.terminal_name);
    ctx.terminal_cmd_source = source_fallback;
}

pub fn profileIdSlice(ctx: *const RunContext) []const u8 {
    return ctx.terminal_profile_id_buf[0..ctx.terminal_profile_id_len];
}

test "resolve cli_override uses argv and optional profile id" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "kitty";
    ctx.terminal_cmd_cli = "custom -e sh";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("custom -e sh", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_cli_override, ctx.terminal_cmd_source);
    try std.testing.expectEqualStrings("kitty", profileIdSlice(&ctx));
}

test "resolve profile for kitty" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "KiTTY";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("kitty", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_profile, ctx.terminal_cmd_source);
    try std.testing.expectEqualStrings("kitty", profileIdSlice(&ctx));
}

test "resolve fallback uses terminal name" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "alacritty";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("alacritty", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_fallback, ctx.terminal_cmd_source);
    try std.testing.expectEqual(@as(u8, 0), ctx.terminal_profile_id_len);
}
