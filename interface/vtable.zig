const std = @import("std");

const Dog = struct {

    // regular struct method
    fn speak(_: *const Dog) void {
        std.debug.print("*Dog speaks*\n", .{});
    }

    // the link between the concrete class and the interface
    fn speakOpaque(ptr: *const anyopaque) void {
        const dog: *const Dog = @ptrCast(@alignCast(ptr));
        dog.speak();
    }

    // implementing the interface
    const vtable = Animal.VTable{
        .speak = speakOpaque,
    };

    fn animal(self: *const Dog) Animal {
        return .{
            .ptr = self,
            .vtable = &vtable,
        };
    }
};

const Animal = struct {
    ptr: *const anyopaque,
    vtable: *const VTable,

    const VTable = struct {
        speak: *const fn(ptr: *const anyopaque) void,
    };

    fn speak(self: *const Animal) void {
        self.vtable.speak(self.ptr);
    }
};

pub fn main() void {
    const dog: Dog = .{};
    const animal: Animal = dog.animal();

    animal.speak();
}
