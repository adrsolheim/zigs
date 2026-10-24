const std = @import("std");
const Server = @import("server.zig").Server;
const RequestHandler = @import("request_handler.zig").RequestHandler;


pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const static_server: Server = try Server.init(io);
    std.debug.print("Waiting for connections..\n", .{});
    var server: std.Io.net.Server = try static_server.listen();
    defer server.deinit(io);
    const connection = try server.accept(io);
    defer connection.close(io);

    std.debug.print("Connection accepted.\n", .{});
    var buffer: [1024]u8 = undefined;
    RequestHandler.handleRequest(io, connection, &buffer);
}
