const std = @import("std");


const AnimalError = error {
    JumpUnsupported,
};

const Dog = struct {
    fn speak(_: Dog) void {
        std.debug.print("*dog speaking*\n", .{});
    }

    fn jump(_: Dog) void {
        std.debug.print("*jump*\n", .{});
    }
};
const Cat = struct {
    fn speak(_: Cat) void {
        std.debug.print("*cat speaking*\n", .{});
    }
};

const Animal = union(enum) {
    dog: Dog,
    cat: Cat,

    fn speak(self: Animal) void {
        switch (self) {
            .dog => |dog| dog.speak(),
            .cat => |cat| cat.speak(),
        }
    }

    fn jump(self: Animal) AnimalError!void {
        switch (self) {
            .dog => |dog| dog.jump(),
            .cat => return AnimalError.JumpUnsupported,
        }
    }
};


pub fn main() !void {
    const animal: Animal = Animal{.cat = Cat{}};
    animal.speak();
    animal.jump() catch |err| {
        std.debug.print("Error when jumping: {any} \n", .{err});
    };
}
