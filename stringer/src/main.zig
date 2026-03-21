const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    //const arena: std.mem.Allocator = init.arena.allocator();
    //const args = try init.minimal.args.toSlice(arena);
    var utf8_view = try std.unicode.Utf8View.init("アメリカ");
    const utf8 = "アメリカ";
    std.debug.print("utf-8 string: {s}\n", .{utf8});
    std.debug.print("utf-8 string len: {d}\n", .{utf8.len});
    var utf8_view_iterator = utf8_view.iterator();
    while (utf8_view_iterator.nextCodepointSlice()) |v| {
        std.debug.print("v.len={d} v={X}\n", .{v.len, v});
    }
    const gpa = init.gpa;
    try comptimeReplace();
    try runtimeReplace(gpa);
}

pub fn comptimeReplace() !void {
    const src = "Hello";
    const needed = comptime std.mem.replacementSize(u8, src, "el", "1234");
    var buf: [needed]u8 = undefined;

    _ = std.mem.replace(u8, src, "el", "1234", buf[0..]);
    std.debug.print("Original: {s}\nReplaced: {s}\n", .{src,buf});
}

pub fn runtimeReplace(gpa: std.mem.Allocator) !void {
    const src = "Hello";
    const replaced = try std.mem.replaceOwned(u8, gpa, src, "el", "1234");
    defer gpa.free(replaced);

    std.debug.print("Original: {s}\nReplaced: {s}\n", .{src,replaced});
}
