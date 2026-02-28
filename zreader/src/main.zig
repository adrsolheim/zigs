const std = @import("std");
const Io = std.Io;
const OpenError = Io.File.OpenError;

const zreader = @import("zreader");

pub fn main(init: std.process.Init) !void {
    // `Io` instance to do I/O operations 
    const io = init.io;
    const gpa = init.gpa;


    try writeToTerminal(io);
    try writeToFile("foo.txt", io, gpa);
}

pub fn writeToFile(fileToOpen: ?[]const u8, io: Io, allocator: std.mem.Allocator) !void {
    const defaultFileName: []const u8 = "output.txt";
    const bufferSize = if (fileToOpen) |f| f.len + 4 else defaultFileName.len;
    var fileNameBuffer: []u8 = try allocator.alloc(u8, bufferSize);
    defer allocator.free(fileNameBuffer);

    const fileName: []const u8 = if (fileToOpen) |name| blk: {
        var len: usize = name.len;
        @memcpy(fileNameBuffer[0..name.len], name);
        if (name.len > 4 and !std.mem.eql(u8, name[name.len-4..], ".txt")) {
            @memcpy(fileNameBuffer[name.len..], ".txt");
            len += 4;
        }
        break :blk fileNameBuffer[0..len];
    } else blk: {
        @memcpy(fileNameBuffer[0..defaultFileName.len], defaultFileName);
        break :blk fileNameBuffer[0..defaultFileName.len];
    };

    // handle to current working directory
    const cwd = std.Io.Dir.cwd();

    const file: std.Io.File = cwd.openFile(io, fileName, .{ .mode = .write_only } ) catch |err| switch (err) {
        OpenError.FileNotFound => blk: {
            std.debug.print("{}: Creating file..\n", .{err});
            break :blk try std.Io.Dir.cwd().createFile(io, fileName, .{ .read = true });
        },
        else => return err,
    };
    defer file.close(io);

    const lastByteInFile: u64 = file.length(io) catch 0;
    if (lastByteInFile > 0) {
        std.debug.print("{s} contains {d} bytes\n", .{fileName, lastByteInFile});
    }


    // write to file
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_file_writer: Io.File.Writer = Io.File.Writer.init(file, io, &stdout_buffer);
    try stdout_file_writer.seekTo(lastByteInFile);
    const stdout = &stdout_file_writer.interface;

    // read from stdin
    var stdin_buffer: [1024]u8 = undefined;
    var stdin_file_reader: Io.File.Reader = Io.File.Reader.init(Io.File.stdin(), io, &stdin_buffer);
    const stdin = &stdin_file_reader.interface;

    while(true) {
        const input = try stdin.takeDelimiter('\n') orelse break;
        try stdout.print("{s}\n", .{input});
    }

    try stdout.flush();    
    std.debug.print("{s} contains {d} bytes after writing\n", .{fileName, file.length(io) catch 0});
}

pub fn writeToTerminal(io: Io) !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_file_writer: Io.File.Writer = Io.File.Writer.init(Io.File.stdout(), io, &stdout_buffer);
    const stdout_writer = &stdout_file_writer.interface;

    try zreader.printAnotherMessage(stdout_writer);

    try stdout_writer.flush(); // Don't forget to flush!
}

test "simple test" {
    const gpa = std.testing.allocator;
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
    try list.append(gpa, 42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}
