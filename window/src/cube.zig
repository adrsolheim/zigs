const std = @import("std");

const rl = @import("raylib");
const rg = @import("raygui");


pub fn drawCube(cubeSize: u16, x: u16, y: u16, _: u16, _: u16) void {
    rl.clearBackground(.white);
    var z: u16 = 4;

    // front facing (z=1) - points defined clockwise
    const p1: rl.Vector2 = .{.x=projected(z, x + (0*cubeSize)), .y=projected(z, y + (0*cubeSize))};
    const p2: rl.Vector2 = .{.x=projected(z, x + (0*cubeSize)), .y=projected(z, y + (1*cubeSize))};
    const p3: rl.Vector2 = .{.x=projected(z, x + (1*cubeSize)), .y=projected(z, y + (1*cubeSize))};
    const p4: rl.Vector2 = .{.x=projected(z, x + (1*cubeSize)), .y=projected(z, y + (0*cubeSize))};
    z = z+1;
    const p5: rl.Vector2 = .{.x=projected(z, x + (0*cubeSize)), .y=projected(z, y + (0*cubeSize))};
    const p6: rl.Vector2 = .{.x=projected(z, x + (0*cubeSize)), .y=projected(z, y + (1*cubeSize))};
    const p7: rl.Vector2 = .{.x=projected(z, x + (1*cubeSize)), .y=projected(z, y + (1*cubeSize))};
    const p8: rl.Vector2 = .{.x=projected(z, x + (1*cubeSize)), .y=projected(z, y + (0*cubeSize))};

    // front side
    rl.drawPixelV(p1, .red);
    rl.drawPixelV(p2, .blue);
    rl.drawPixelV(p3, .green);
    rl.drawPixelV(p4, .orange);
    // back side
    rl.drawPixelV(p5, .red);
    rl.drawPixelV(p6, .blue);
    rl.drawPixelV(p7, .green);
    rl.drawPixelV(p8, .orange);

    //draw front cube
    rl.drawLineV(p1, p2, .black);
    rl.drawLineV(p2, p3, .black);
    rl.drawLineV(p3, p4, .black);
    rl.drawLineV(p4, p1, .black);
    //draw back cube
    rl.drawLineV(p5, p6, .gray);
    rl.drawLineV(p6, p7, .gray);
    rl.drawLineV(p7, p8, .gray);
    rl.drawLineV(p8, p5, .gray);
    // connect the sides
    rl.drawLineV(p1, p5, .black);
    rl.drawLineV(p2, p6, .black);
    rl.drawLineV(p3, p7, .black);
    rl.drawLineV(p4, p8, .gray);

    // in the back (z=2)  - points defined clockwise
    //const p5: rl.Vector2 = .{0,0};
    //const p6: rl.Vector2 = .{0,1};
    //const p7: rl.Vector2 = .{1,1};
    //const p8: rl.Vector2 = .{1,0};
}

fn projected(z: u16, point: u16) u16 {
    return point/z;
}
