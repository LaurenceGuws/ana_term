const std = @import("std");
const run_context_mod = @import("../cli/run_context.zig");
const RunContext = run_context_mod.RunContext;

pub const source_cli_override = "cli_override";
pub const source_profile = "profile";
pub const source_fallback = "fallback";

/// Recorded in `run.json` when a built-in executable template applies (PH1-M34).
pub const exec_template_version = "1";

pub const template_id_kitty_v1 = "kitty_exec_v1";
pub const template_id_ghostty_v1 = "ghostty_exec_v1";
pub const template_id_konsole_v1 = "konsole_exec_v1";
pub const template_id_zide_terminal_v1 = "zide_terminal_exec_v1";

/// Deterministic argv for direct exec (PH1-M34). `kitty --detach` returns quickly after forking the UI.
const argv_kitty = [_][]const u8{ "kitty", "--detach" };
const argv_ghostty = [_][]const u8{"ghostty"};
const argv_konsole = [_][]const u8{"konsole"};
const argv_zide = [_][]const u8{"zide-terminal"};

/// Built-in profile + executable template contract (PH1-M34).
pub const ProfileExecSpec = struct {
    profile_id: []const u8,
    template_id: []const u8,
    argv: []const []const u8,
};

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

/// Returns the PH1-M34 executable template for a known `--terminal` profile, if any.
pub fn profileExecSpec(terminal_name: []const u8) ?ProfileExecSpec {
    if (terminal_name.len == 0) return null;
    if (std.ascii.eqlIgnoreCase(terminal_name, "kitty")) {
        return .{ .profile_id = "kitty", .template_id = template_id_kitty_v1, .argv = &argv_kitty };
    }
    if (std.ascii.eqlIgnoreCase(terminal_name, "ghostty")) {
        return .{ .profile_id = "ghostty", .template_id = template_id_ghostty_v1, .argv = &argv_ghostty };
    }
    if (std.ascii.eqlIgnoreCase(terminal_name, "konsole")) {
        return .{ .profile_id = "konsole", .template_id = template_id_konsole_v1, .argv = &argv_konsole };
    }
    if (std.ascii.eqlIgnoreCase(terminal_name, "zide-terminal")) {
        return .{ .profile_id = "zide-terminal", .template_id = template_id_zide_terminal_v1, .argv = &argv_zide };
    }
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

test "resolve profile for ghostty" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "GhOsTTY";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("ghostty", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_profile, ctx.terminal_cmd_source);
    try std.testing.expectEqualStrings("ghostty", profileIdSlice(&ctx));
}

test "resolve profile for konsole" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "KONsole";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("konsole", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_profile, ctx.terminal_cmd_source);
    try std.testing.expectEqualStrings("konsole", profileIdSlice(&ctx));
}

test "resolve profile for zide-terminal" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "ZIDE-TERMINAL";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("zide-terminal", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_profile, ctx.terminal_cmd_source);
    try std.testing.expectEqualStrings("zide-terminal", profileIdSlice(&ctx));
}

test "resolve cli_override with unknown terminal leaves profile id empty" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "foot";
    ctx.terminal_cmd_cli = "my-term -e sh";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("my-term -e sh", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_cli_override, ctx.terminal_cmd_source);
    try std.testing.expectEqual(@as(u8, 0), ctx.terminal_profile_id_len);
}

test "resolve fallback uses terminal name" {
    var ctx = RunContext.initDefault();
    ctx.terminal_name = "alacritty";
    resolveEffective(&ctx);
    try std.testing.expectEqualStrings("alacritty", ctx.terminal_cmd);
    try std.testing.expectEqualStrings(source_fallback, ctx.terminal_cmd_source);
    try std.testing.expectEqual(@as(u8, 0), ctx.terminal_profile_id_len);
}

test "profileExecSpec kitty uses detach argv" {
    const s = profileExecSpec("KiTTY").?;
    try std.testing.expectEqualStrings("kitty", s.profile_id);
    try std.testing.expectEqualStrings(template_id_kitty_v1, s.template_id);
    try std.testing.expectEqual(@as(usize, 2), s.argv.len);
    try std.testing.expectEqualStrings("kitty", s.argv[0]);
    try std.testing.expectEqualStrings("--detach", s.argv[1]);
}

test "profileExecSpec unknown is null" {
    try std.testing.expectEqual(@as(?ProfileExecSpec, null), profileExecSpec("foot"));
}
