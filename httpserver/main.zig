const std = @import("std");
const Server = @import("server.zig").Server;


pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const static_server: Server = try Server.init(io);
    std.debug.print("Waiting for connections..\n", .{});
    var server: std.Io.net.Server = try static_server.listen();
    const connection = try server.accept(io);
    std.debug.print("Connection accepted.\n", .{});
    defer connection.close(io);
}
