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

    rl.setTargetFPS(120); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    const cubeSize = 100;
    var x: u16 = (screenWidth/2) - (cubeSize/2);  // center
    var y: u16 = (screenHeight/2) - (cubeSize/2); // center

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
        cube.drawCube(cubeSize, x, y, screenWidth, screenHeight);
        x += 1;
        y += 1;
    }
}
