const std = @import("std");
const Io = std.Io;

const ADDRESS: []const u8 = "127.0.0.1";
const PORT: u16 = 8080;


pub fn main(init: std.process.Init) !void {
    const arena: std.mem.Allocator = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);
    for (args) |arg| {
        std.log.info("arg: {s}", .{arg});
    }
    const io = init.io;
    const address: std.Io.net.IpAddress = try std.Io.net.IpAddress.parseIp4(ADDRESS, PORT);
    var server: std.Io.net.Server = try address.listen(io, .{.reuse_address = true});
    defer server.deinit(io);
    
    while(true) {
        var connection: std.Io.net.Stream = try server.accept(io);
        defer connection.close(io);
        var rbuffer: [1024]u8 = undefined;
        var wbuffer: [1024]u8 = undefined;
        var connection_reader = connection.reader(io, &rbuffer);
        var connection_writer = connection.writer(io, &wbuffer);
        var http_server = std.http.Server.init(&connection_reader.interface, &connection_writer.interface);
        var request = try http_server.receiveHead();
        _ = try request.respond("Hello world!\n", std.http.Server.Request.RespondOptions{});
    }
    
}
