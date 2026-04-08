const std = @import("std");

//const window = @import("window");
const rl = @import("raylib");
const rg = @import("raygui");

pub fn main() !void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    var circle_x_pos: u16 = 0;

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
        _ = rg.button(.init(24,24,120,30), "#191#Show message");

        rl.clearBackground(.pink);

        rl.drawText("Heisann sveisan!", 190, 200, 20, .white);
        rl.drawCircle(circle_x_pos, screenHeight/2, 20, .blue);
        circle_x_pos = (circle_x_pos + 1) % screenWidth;
    }
}
