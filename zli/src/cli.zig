const std = @import("std");
const cmd = @import("commands.zig");

const command = cmd.command;
const option = cmd.option;

pub fn exec(
    args: []const []const u8,
    supported_commands: []const command,
    supported_options: []const option,
) !void {
    const MAX_OPTIONS: usize = 10;
    if (args.len < 2) {
        std.debug.print("Params:\n", .{});
        for (supported_commands) |c| {
            std.debug.print(" {s} |", .{c.name});
        }
        std.debug.print("\n", .{});
        std.debug.print("Options:\n", .{});
        for (supported_options) |o| {
            std.debug.print(" -{s} --{s} |", .{ o.prefix, o.name });
        }
        std.debug.print("\n", .{});
        return;
    }

    // detect commands
    const user_command: []const u8 = args[1];
    var detected_command: ?command = null;
    for (supported_commands) |c| {
        if (std.mem.eql(u8, c.name, user_command)) {
            detected_command = c;
            break;
        }
    }
    const final_command = detected_command orelse return Error.UnknownCommand;
    std.debug.print("Found command: {s}\n", .{final_command.name});

    var detected_options: [MAX_OPTIONS]option = undefined;
    var options_detected: u8 = 0;

    // detect options
    var i: usize = 2;
    while (i < args.len) {
        std.debug.print("{s}", .{args[i]});
        if (args[i].len < 2 or !std.mem.startsWith(u8, args[i], "-")) {
            return Error.UnexpectedArgument;
        }
        const arg: []const u8 = args[i][1..];

        const j: usize = if (std.mem.startsWith(u8, arg, "-")) 1 else 0;
        const option_name: []const u8 = arg[j..];
        var detected_option: ?option = null;
        for (supported_options) |opt| {
            if ((option_name.len == 1 and std.mem.eql(u8, option_name, opt.prefix)) or std.mem.eql(u8, option_name, opt.name)) {
                detected_option = opt;
            }
        }
        if (detected_option == null) {
            return Error.UnknownOption;
        }
        i += 1;
        detected_options[options_detected] = detected_option.?;
        options_detected += 1;

        // set value if present
        if (i >= args.len or std.mem.startsWith(u8, args[i], "-")) {
            continue;
        }
        const option_value: []const u8 = args[i];
        detected_options[options_detected - 1].value = option_value;
        i += 1;
    }

    if (options_detected > 0) {
        std.debug.print("{d} detected options:\n", .{options_detected});
    }
    for (detected_options[0..options_detected]) |opt| {
        if (opt.value) |v| {
            std.debug.print("{s}={s}\n", .{ opt.name, v });
        } else {
            std.debug.print("{s}\n", .{opt.name});
        }
    }
}

pub const Error = error{
    UnknownCommand,
    UnknownOption,
    UnexpectedArgument,
};
