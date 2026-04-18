const std = @import("std");

/// Returns `null` if `root` satisfies the phase-1 `run.json` contract (`docs/REPORT_FORMAT.md` + harness output); otherwise a static error description.
pub fn validateRunReport(root: std.json.Value) ?[]const u8 {
    const obj = switch (root) {
        .object => |o| o,
        else => return "expected top-level JSON object",
    };

    if (getString(obj, "schema_version") == null) return "missing or invalid schema_version (string required)";
    if (getString(obj, "run_id") == null) return "missing or invalid run_id (string required)";
    if (getString(obj, "started_at") == null) return "missing or invalid started_at (string required)";
    if (getString(obj, "ended_at") == null) return "missing or invalid ended_at (string required)";
    if (getString(obj, "platform") == null) return "missing or invalid platform (string required)";
    if (getString(obj, "term") == null) return "missing or invalid term (string required)";

    const term_o = obj.get("terminal") orelse return "missing terminal object";
    const term_obj = switch (term_o) {
        .object => |t| t,
        else => return "terminal must be a JSON object",
    };
    if (getString(term_obj, "name") == null) return "terminal.name must be a string";

    const res_o = obj.get("results") orelse return "missing results array";
    const arr = switch (res_o) {
        .array => |a| a,
        else => return "results must be a JSON array",
    };

    for (arr.items, 0..) |item, i| {
        const row = switch (item) {
            .object => |r| r,
            else => return "results entries must be objects",
        };
        if (getString(row, "spec_id") == null) return "results[].spec_id must be a string";
        if (getString(row, "status") == null) return "results[].status must be a string";
        if (getString(row, "notes") == null) return "results[].notes must be a string";
        if (row.get("observations")) |obs| {
            switch (obs) {
                .object => {},
                else => return "results[].observations must be an object",
            }
        } else return "results[].observations required";
        if (getString(row, "capture_mode") == null) return "results[].capture_mode must be a string";
        _ = i;
    }

    return null;
}

fn getString(obj: std.json.ObjectMap, key: []const u8) ?[]const u8 {
    const v = obj.get(key) orelse return null;
    return switch (v) {
        .string => |s| s,
        else => null,
    };
}

test "validateRunReport accepts minimal harness-shaped run.json" {
    const text =
        \\{"schema_version":"0.2","run_id":"run-001","started_at":"","ended_at":"","platform":"linux","term":"xterm","terminal":{"name":"t","version":""},"suite":null,"comparison_id":null,"run_group":null,"results":[{"spec_id":"p","status":"manual","notes":"","capture_mode":"manual","observations":{}}]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) == null);
}

test "validateRunReport rejects missing schema_version" {
    const text =
        \\{"run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects result row missing observations" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":{"name":"t"},"results":[{"spec_id":"p","status":"manual","notes":"","capture_mode":"manual"}]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}

test "validateRunReport rejects non-object terminal" {
    const text =
        \\{"schema_version":"0.2","run_id":"r","started_at":"","ended_at":"","platform":"linux","term":"x","terminal":"oops","results":[]}
    ;
    const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, text, .{});
    defer parsed.deinit();
    try std.testing.expect(validateRunReport(parsed.value) != null);
}
