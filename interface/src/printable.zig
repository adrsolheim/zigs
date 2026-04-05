const std = @import("std");
const io = std.Io;

pub fn printAll(writer: *io.Writer) io.Writer.Error!void {
    var jpeg: Jpeg = .init(writer, 128, 160, "RGB");
    var png: Png = .init(writer, 128, 160, "RGB");
    const printables: [2]* Printable = [2]* Printable {&jpeg.printable, &png.printable};
    for (printables) |p| {
        try p.print(p);
    }
}

const Printable = struct {
    print: *const fn(*Printable) io.Writer.Error!void,

};

const Jpeg = struct {
    writer: *io.Writer,
    printable: Printable,
    h: u8,
    w: u8,
    color_space: []const u8,

    fn print(printable: *Printable) io.Writer.Error!void {
        const self: *Jpeg = @fieldParentPtr("printable", printable);
        try self.writer.print("Jpeg(h={d}, w={d}, color_space{s})\n", .{self.h, self.w, self.color_space});
        try self.writer.flush();
    }

    pub fn init(writer: *io.Writer, h: u8, w: u8, color_space: []const u8) Jpeg {
        return Jpeg{.writer = writer,
            .printable = Printable{.print = Jpeg.print},
            .h = h,
            .w = w,
            .color_space = color_space
        };
    }
};

const Png = struct {
    writer: *io.Writer,
    printable: Printable,
    h: u8,
    w: u8,
    color_space: []const u8,

    fn print(printable: *Printable) io.Writer.Error!void {
        const self: *Png = @fieldParentPtr("printable", printable);
        try self.writer.print("Png(h={d}, w={d}, color_space{s})", .{self.h, self.w, self.color_space});
    }

    pub fn init(writer: *io.Writer, h: u8, w: u8, color_space: []const u8) Png {
        return Png{.writer = writer,
            .printable = Printable{.print = Png.print},
            .h = h,
            .w = w,
            .color_space = color_space
        };
    }
};
