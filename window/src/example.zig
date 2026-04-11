const std = @import("std");

const rl = @import("raylib");
const rg = @import("raygui");

pub fn drawExample(circle_x_pos: *u16, screenWidth: u16, screenHeight: u16) void {
    _ = rg.button(.init(24,24,120,30), "#191#Show message");

    rl.clearBackground(.pink);

    rl.drawText("Heisann sveisan!", 190, 200, 20, .white);
    rl.drawCircle(circle_x_pos.*, screenHeight/2, 20, .blue);
    circle_x_pos.* = (circle_x_pos.* + 1) % screenWidth;
}
