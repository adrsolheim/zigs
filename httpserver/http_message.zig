const std = @import("std");

const ls: [2]u8 = .{0x0D, 0x0A};   // line separator        : \r\n
const separator: [4]u8 = ls ++ ls; // header-body separator : \r\n\r\n

pub fn parseRequest(request: []const u8) !HttpRequest {
    var line_it: std.mem.SplitIterator = std.mem.splitSequence(u8, request, "\n");
}

const http_method = enum {
    GET,
    POST,
    PUT,
    DELETE,
    OPTIONS, // query supported methods
    TRACE,   // diagnostic loop-back
    CONNECT  // establish a tunnel
};

const http_version = enum {
    HTTP1_1
};

const HttpHeader = struct {
    method: http_method,
    uri: []u8,
    protocol: http_version,

    host: []u8,

    // An Allow header field MUST be present in a 405 (Method Not Allowed) response.


};
const HttpBody = struct {
    data: []u8
};

// client --> server
const HttpRequest = struct {
    header: HttpHeader,
    body: HttpBody,
};
// client <-- server
pub const HttpResponse = struct {
    header: ResponseHeader,
    data: ?[]const u8,

    pub fn format(self: *const HttpResponse, writer: *std.Io.Writer) !void {
        try self.header.format(writer);
        if (self.data != null) {
            try writer.print("{s}\r\n", .{self.data.?});
        }
    }
};
const ResponseHeader = struct {
    const protocol: []const u8 = "HTTP/1.1";

    status_code: u16,
    content_type: []const u8,
    content_length: u64,
    server: ?[]const u8,

    pub fn format(self: *const ResponseHeader, writer: *std.Io.Writer) !void {
        try writer.print("{s} {d} {s}\r\nContent-Type: {s}\r\n\r\n", .{protocol, self.status_code, statusText(self.status_code), self.content_type});
    }
};

fn statusText(status: u16) []const u8 {
    return switch(status) {
        200 => "OK",
        201 => "Created",
        202 => "Accepted",
        203 => "Non-Authorization Information",
        204 => "No Content",
        205 => "Reset Content",
        206 => "Partial Content",
        207 => "Multi-Status",
        208 => "Already Reported",
        else => "Unknown Status",
    };
}
