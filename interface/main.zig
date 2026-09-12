const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var adder: Adder = .init();
    var addCalc = &adder.calculate;
    var subtracter: Subtracter = .init();
    var subCalc = &subtracter.calculate;

    var buffer: [4096]u8 = undefined;
    const io = init.io;
    const stdout = std.Io.File.stdout();
    var file = stdout.writer(io, &buffer);
    const writer = &file.interface;
    
    const addResult = addCalc.calculate(5, 4);
    const subResult = subCalc.calculate(5, 4);
    try writer.print("{d} + {d} = {d}\n", .{5, 4, addResult});
    try writer.print("{d} - {d} = {d}\n", .{5, 4, subResult});
    try writer.flush();
}


const Adder = struct {
    calculate: CalcInterface,

    pub fn init() Adder {
        return Adder {
            .calculate = CalcInterface {
                .calculateFn = add
            }
        };
    }

    fn add(a: u8, b: u8) u8 {
        return a + b;
    }
};

const Subtracter = struct {
    calculate: CalcInterface,

    pub fn init() Subtracter {
        return Subtracter {
            .calculate = CalcInterface {
                .calculateFn = subtract
            }
        };
    }

    fn subtract(a: u8, b: u8) u8 {
        return a - b;
    }
};

const CalcInterface = struct {
    calculateFn: *const fn (a: u8, b: u8) u8,

    pub fn calculate(self: *CalcInterface, a: u8, b: u8) u8 {
        return self.calculateFn(a, b);
    }

};
