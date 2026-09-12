const std = @import("std");

pub fn activate(x: anytype) void {
    x.turnOn();
}

const LightBulb = struct {
    pub fn turnOn(_: LightBulb) void {}
};

const Car = struct {
    pub fn turnOn(_: Car) void {}
};

const IceCream = struct {
    pub fn consume(_: IceCream) void {}
};

pub fn main() void {
    const light_bulb = LightBulb{};
    const car = Car{};
    //const ice_cream = IceCream{};

    activate(light_bulb);
    activate(car);
    //activate(ice_cream); <-- fails at compile time
}
