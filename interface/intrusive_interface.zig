const std = @import("std");

const Animal = struct {
    speakFn: *const fn(*const Animal) void,

    fn speak(self: *const Animal) void {
        self.speakFn(self); }
};

const Dog = struct {
    name: []const u8,
    interface: Animal,

    fn init(n: []const u8) Dog {
        return .{
            .name = n,
            .interface = .{
                .speakFn = speak
            }
        };
    }

    fn speak(ptr: *const Animal) void {
        const dog: *const Dog = @fieldParentPtr("interface", ptr);
        dog.speakFn();
    }

    fn speakFn(_: *const Dog) void {
        std.debug.print("*Dog speaks*", .{});
    }
};

pub fn main() void {
    const dog: Dog = .init("test");
    var int: *const Animal = &dog.interface;
    int.speak();
}
