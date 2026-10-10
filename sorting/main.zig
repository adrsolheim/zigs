const std = @import("std");


pub fn main(init: std.process.Init) !void {
    const io: std.Io = init.io;
    const gpa = init.gpa;

    // output
    const out_file = std.Io.File.stdout();
    var out_buf: [4096]u8 = undefined;
    var writer: std.Io.File.Writer = out_file.writer(io, &out_buf);
    const output: *std.Io.Writer = &writer.interface;

    // input
    const in_file = std.Io.File.stdin();
    var in_buf: [4096]u8 = undefined;
    var reader: std.Io.File.Reader = in_file.reader(io, &in_buf);
    const input: *std.Io.Reader = &reader.interface;

    // read from stdin
    var programInput = std.ArrayList([]const u8).empty;
    defer {
        for (programInput.items) |item| {
            gpa.free(item);
        }
        programInput.deinit(gpa);
    }
    while (try input.takeDelimiter('\n')) |line| {
        const lineCopy = try gpa.dupe(u8, line);
        try programInput.append(gpa, lineCopy);
    }
    // write to stdout
    try output.print("programInput has {d} lines\n", .{programInput.items.len});
    for (programInput.items) |line| {
        try output.print("programInput: {s}\n", .{line});
    }
    try output.flush();
}

fn quicksort(_: []i64, _: std.Io) void {
    
}
