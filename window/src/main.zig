const std = @import("std");

//const window = @import("window");
const rl = @import("raylib");
const rg = @import("raygui");
const cube = @import("cube.zig");

pub fn main() !void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(1);
    //--------------------------------------------------------------------------------------
    const cubeSize = 20;
    //var x: u16 = (screenWidth/2) - (cubeSize/2);  // center
    //var y: u16 = (screenHeight/2) - (cubeSize/2); // center
    var x: u16 = 0;
    var y: u16 = 0;
    var angle: u16 = 0;

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();
        cube.drawCube(cubeSize, x, y, screenWidth, screenHeight, angle);
        x = (x + 1) % screenWidth;
        y = (y + 1) % screenHeight;
        angle +%= 1;
    }
}
