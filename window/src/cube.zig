const std = @import("std");

const rl = @import("raylib");
const rg = @import("raygui");


pub fn drawCube(cubeSize: f16, x: f16, y: f16, _: f16, _: f16, radians: f16) void {
    rl.clearBackground(.white);
    const z1: f16 = 1;
    const z2: f16 = 1.025;

    // front facing (z=1) - points defined clockwise
    var p1: rl.Vector2 = .{.x=projected(z1, x + (0*cubeSize)), .y=projected(z1, y + (0*cubeSize))};
    var p2: rl.Vector2 = .{.x=projected(z1, x + (0*cubeSize)), .y=projected(z1, y + (1*cubeSize))};
    var p3: rl.Vector2 = .{.x=projected(z1, x + (1*cubeSize)), .y=projected(z1, y + (1*cubeSize))};
    var p4: rl.Vector2 = .{.x=projected(z1, x + (1*cubeSize)), .y=projected(z1, y + (0*cubeSize))};
    var p5: rl.Vector2 = .{.x=projected(z2, x + (0*cubeSize)), .y=projected(z2, y + (0*cubeSize))};
    var p6: rl.Vector2 = .{.x=projected(z2, x + (0*cubeSize)), .y=projected(z2, y + (1*cubeSize))};
    var p7: rl.Vector2 = .{.x=projected(z2, x + (1*cubeSize)), .y=projected(z2, y + (1*cubeSize))};
    var p8: rl.Vector2 = .{.x=projected(z2, x + (1*cubeSize)), .y=projected(z2, y + (0*cubeSize))};
    rotate(radians, &p1);
    rotate(radians, &p2);
    rotate(radians, &p3);
    rotate(radians, &p4);
    rotate(radians, &p5);
    rotate(radians, &p6);
    rotate(radians, &p7);
    rotate(radians, &p8);

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

//fn projected(_: f16, point: f16) f16 {
//    return point;
//}
fn projected(z: f16, point: f16) f16 {
    return point/z;
}

fn rotate(radians: f16, vector: *rl.Vector2) void {
    const x = vector.x;
    const y = vector.y;
    vector.x = x * @cos(radians) - y * @sin(radians);
    vector.y = x * @sin(radians) + y * @cos(radians);
}
