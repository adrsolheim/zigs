const std = @import("std");

//const window = @import("window");
const rl = @import("raylib");
const rg = @import("raygui");
const cube = @import("cube.zig");

pub fn main() !void {
    const screenWidth: u16 = 800;
    const screenHeight: u16 = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(1);
    //--------------------------------------------------------------------------------------
    const cubeSize: u16 = 20;
    //var x: u16 = (screenWidth/2) - (cubeSize/2);  // center
    //var y: u16 = (screenHeight/2) - (cubeSize/2); // center
    var x: f16 = 400;
    var y: f16 = 200;
    var angle: f16 = 0;

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
        cube.drawCube(cubeSize, x, y, screenWidth, screenHeight, std.math.degreesToRadians(angle));
        // keep positions within boundaries
        x = if ((x + 1) < screenWidth) (x + 1) else (x + 1) - screenWidth;
        y = if ((y + 1) < screenHeight) (y + 1) else (y + 1) - screenHeight;
        angle = if ((angle + 1) <= 360) (angle + 1) else (angle + 1) - 360;
    }
}
