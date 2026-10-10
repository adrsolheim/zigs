const std = @import("std");
const net = std.Io.net;

pub const Server = struct {

    host: []const u8,
    port: u16,
    addr: std.Io.net.IpAddress,
    io: std.Io, 

    pub fn init(io: std.Io) !Server {
        const host: []const u8 = "127.0.0.1";
        const port: u16 = 3500;
        const addr = try std.Io.net.IpAddress.parseIp4(host, port);
        return .{
            .host = host,
            .port = port,
            .addr = addr,
            .io = io
        };
    }

    pub fn listen(self: Server) !std.Io.net.Server {
        return try self.addr.listen(self.io, net.IpAddress.ListenOptions{.mode = net.Socket.Mode.stream, .protocol = net.Protocol.tcp});
    }
};
