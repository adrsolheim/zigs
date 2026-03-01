const std = @import("std");
const cli = @import("cli.zig");
const cmd = @import("commands.zig");

const command = cmd.command;
const commandFns = cmd.functions.commands;
const option = cmd.option;
const optionFns = cmd.functions.options;

pub fn main(init: std.process.Init) !void {
    const arena: std.mem.Allocator = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);

    const supported_commands = [_]command{ command{ .name = "hello", .func = commandFns.printHello }, command{ .name = "help", .func = commandFns.help } };
    const supported_options = [_]option{ option{ .name = "help", .prefix = "h", .func = optionFns.empty }, option{ .name = "greetings", .prefix = "g", .func = optionFns.printName } };

    try cli.exec(args, &supported_commands, &supported_options);
}
