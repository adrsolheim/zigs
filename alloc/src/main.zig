const std = @import("std");
const Io = std.Io;


pub fn main(init: std.process.Init) !void {
    const arena: std.mem.Allocator = init.arena.allocator();

    // Accessing command line arguments:
    const args = try init.minimal.args.toSlice(arena);
    for (args) |arg| {
        std.log.info("{s} ", .{arg});
    }
    if (args.len < 2) {
        return;
    }

    const len: u64 = try std.fmt.parseInt(u64, args[1], 10);
    var list: std.ArrayList(i64) = std.array_list.Aligned(i64, null).empty;
    defer list.deinit(arena);
    std.log.info("len: {d}, list: {any}", .{len, list});

    var prng = std.Random.DefaultPrng.init(100000);
    const rand = prng.random();

    for(0..len) |_| {
        try list.append(arena, rand.int(i64));
    }

    for(list.items) |item| {
        std.log.info("{d}", .{item});
    }
    std.log.info("==== {d} items printed ====", .{list.items.len});

    //// In order to do I/O operations need an `Io` instance.
    //const io = init.io;

    //// Stdout is for the actual output of your application, for example if you
    //// are implementing gzip, then only the compressed bytes should be sent to
    //// stdout, not any debugging messages.
    //var stdout_buffer: [1024]u8 = undefined;
    //var stdout_file_writer: Io.File.Writer = .init(.stdout(), io, &stdout_buffer);
    //const stdout_writer = &stdout_file_writer.interface;

    //try alloc.printAnotherMessage(stdout_writer);

    //try stdout_writer.flush(); // Don't forget to flush!
}
