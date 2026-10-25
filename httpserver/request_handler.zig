const std = @import("std");
const http = @import("http_message.zig");
const HttpResponse = http.HttpResponse;
const HttpRequest  = http.HttpRequest;

pub const SINGLE_HEADER_LIMIT: usize = 4 * 1024;

const ClientError = error {
    BAD_REQUEST,        // 400
    HEADERS_TOO_LARGE,  // 431
    URI_TOO_LONG        // 414

};

const ServerError = error {
    INTERNAL_SERVER_ERROR,      // 500
    HTTP_VERSION_NOT_SUPPORTED, // 505
};

// 1. parse_request  --> INTERNAL_SERVER_ERROR || HttpRequest
// 2. validate       --> NOT_FOUND, NOT_SUPPORTED || void
// 3. handle_request --> HttpResponse
//  a) (optional) auth filter
//  b) map method + path to function
//  b) map result to HttpResponse


pub const RequestHandler = struct {
    
    // header_alloc -> fixedsizebufferallocator: headers are typically small and bounded in size
    // body_alloc -> heap allocator: request body can vary widely in size 
    pub fn parseRequest(io: std.Io, connection: std.Io.net.Stream, header_alloc: std.mem.Allocator, body_alloc: std.mem.Allocator) !HttpRequest {
        var buf: [SINGLE_HEADER_LIMIT]u8 = undefined;
        var reader: std.Io.net.Stream.Reader = connection.reader(io, &buf);
        const interface: *std.Io.Reader = &reader.interface;
        const request_line = interface.takeDelimiterInclusive('\n') catch |err| {
            if (err == error.StreamTooLong) {
                return ClientError.HEADERS_TOO_LARGE;
            }
            std.debug.print("Error reading request-line: {any}\n", err);
            return ServerError.INTERNAL_SERVER_ERROR;
        };

    }

    pub fn handleRequest(io: std.Io, connection: std.Io.net.Stream, buffer: []u8) void {
        readRequest(io, connection, buffer) catch |err| {
            std.debug.print("error reading request: {any}\n", .{err});
        };
        writeResponse(io, connection, buffer) catch |err| {
            std.debug.print("error sending response: {any}\n", .{err});
        };
    }

    fn parse_request(io: std.Io, connection: std.Io.net.Stream, )

    fn readRequest(io: std.Io, connection: std.Io.net.Stream, buffer: []u8) ClientError!void {
        //var recv_buffer: [1024]u8 = undefined;
        //@memset(recv_buffer, 0);
        var reader: std.Io.net.Stream.Reader = connection.reader(io, buffer);
        const interface: *std.Io.Reader = &reader.interface;

        var next_line: []u8 = interface.takeDelimiterInclusive('\n') catch |err| {
            std.debug.print("Error reading input: {any}\n", .{err});
            return ClientError.BAD_REQUEST;
        };

        while (!std.mem.startsWith(u8, next_line, "\n") and !std.mem.startsWith(u8, next_line, "\r\n")) 
            : (next_line = interface.takeDelimiterInclusive('\n') catch |err| {
                std.debug.print("Error reading input: {any}\n", .{err});
                return ClientError.BAD_REQUEST;
            }) {
            std.debug.print("Received: {s}\n", .{next_line});
            
        }
        std.debug.print("Finished reading header.", .{});
    }

    fn writeResponse(io: std.Io, connection: std.Io.net.Stream, buffer: []u8) !void {
        var writer: std.Io.net.Stream.Writer = connection.writer(io, buffer);
        const interface = &writer.interface;
        const data = "<h2>no går eg å legger meg</h2>";
        const response: HttpResponse = .{
            .header = .{
                .status_code = 200,
                .content_length = data.len,
                .content_type = "text/html; charset=utf-8",
                .server = "localhost"
            },
            .data = data[0..],
        };
        try response.format(interface);
        try interface.flush();
    }
};
