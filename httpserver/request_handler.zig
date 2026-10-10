const std = @import("std");

pub const RequestHandler = struct {
    
    pub fn handleRequest(io: std.Io, connection: std.Io.net.Stream, buffer: []u8) !void {
        //var recv_buffer: [1024]u8 = undefined;
        //@memset(recv_buffer, 0);
        var reader: std.Io.net.Stream.Reader = connection.reader(io, buffer);
        const interface: *std.Io.Reader = &reader.interface;
        var next_line: []u8 = undefined;
        for (0 .. 8) |_| {
            next_line = try interface.takeDelimiter('\n') orelse "";
            std.debug.print("Received: {s}\n", .{next_line});
        }
    }
};
