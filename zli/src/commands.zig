const std = @import("std");

pub const option = struct { name: []const u8, prefix: []const u8, value: ?[]const u8 = null, func: *const fn ([]const u8) void };

pub const command = struct { name: []const u8, func: *const fn ([]const option) void };

pub const functions = struct {
    pub const commands = struct {
        pub fn help(_: []const option) void {
            std.debug.print("Supported commands: help, hello. Options: -g -n\n", .{});
        }
        pub fn printHello(opts: []const option) void {
            std.debug.print("Hello ", .{});
            for (opts) |opt| {
                if (opt.value) |val| {
                    opt.func(val);
                }
            }
            std.debug.print("\n", .{});
        }
    };

    pub const options = struct {
        pub fn empty(_: []const u8) void {}
        pub fn printName(name: []const u8) void {
            std.debug.print("{s}", .{name});
        }
    };
};
