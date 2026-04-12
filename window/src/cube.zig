const std = @import("std");

const rl = @import("raylib");
const rg = @import("raygui");

var p1: rl.Vector3 = undefined;
var p2: rl.Vector3 = undefined;
var p3: rl.Vector3 = undefined;
var p4: rl.Vector3 = undefined;
var p5: rl.Vector3 = undefined;
var p6: rl.Vector3 = undefined;
var p7: rl.Vector3 = undefined;
var p8: rl.Vector3 = undefined;


pub fn drawCube(_: f16, _: f16, _: f16, _: f16, _: f16, _: f16) void {
    rl.clearBackground(.white);
    createCubeAtOrigin();
    scale(100);
    shiftCube(200, 200, 0);
    renderCube();
    //const z1: f16 = 1;
    //const z2: f16 = 1.025;


    //// front facing (z=1) - points defined clockwise
    //var p1: rl.Vector2 = .{.x=projected(z1, x + (0*cubeSize)), .y=projected(z1, y + (0*cubeSize))};
    //var p2: rl.Vector2 = .{.x=projected(z1, x + (0*cubeSize)), .y=projected(z1, y + (1*cubeSize))};
    //var p3: rl.Vector2 = .{.x=projected(z1, x + (1*cubeSize)), .y=projected(z1, y + (1*cubeSize))};
    //var p4: rl.Vector2 = .{.x=projected(z1, x + (1*cubeSize)), .y=projected(z1, y + (0*cubeSize))};
    //var p5: rl.Vector2 = .{.x=projected(z2, x + (0*cubeSize)), .y=projected(z2, y + (0*cubeSize))};
    //var p6: rl.Vector2 = .{.x=projected(z2, x + (0*cubeSize)), .y=projected(z2, y + (1*cubeSize))};
    //var p7: rl.Vector2 = .{.x=projected(z2, x + (1*cubeSize)), .y=projected(z2, y + (1*cubeSize))};
    //var p8: rl.Vector2 = .{.x=projected(z2, x + (1*cubeSize)), .y=projected(z2, y + (0*cubeSize))};
    //rotate(radians, &p1);
    //rotate(radians, &p2);
    //rotate(radians, &p3);
    //rotate(radians, &p4);
    //rotate(radians, &p5);
    //rotate(radians, &p6);
    //rotate(radians, &p7);
    //rotate(radians, &p8);
    
}

fn createCubeAtOrigin() void {
    p1 = .{.x=0, .y=0, .z=0};
    p2 = .{.x=1, .y=0, .z=0};
    p3 = .{.x=1, .y=1, .z=0};
    p4 = .{.x=0, .y=1, .z=0};
    p5 = .{.x=0, .y=0, .z=1};
    p6 = .{.x=1, .y=0, .z=1};
    p7 = .{.x=1, .y=1, .z=1};
    p8 = .{.x=0, .y=1, .z=1};

    // front side
    //rl.drawPixelV(p1, .red);
    //rl.drawPixelV(p2, .blue);
    //rl.drawPixelV(p3, .green);
    //rl.drawPixelV(p4, .orange);
    //// back side
    //rl.drawPixelV(p5, .red);
    //rl.drawPixelV(p6, .blue);
    //rl.drawPixelV(p7, .green);
    //rl.drawPixelV(p8, .orange);

}

fn renderCube() void {
    // draw front cube
    rl.drawLine3D(p1, p2, .black);
    rl.drawLine3D(p2, p3, .black);
    rl.drawLine3D(p3, p4, .black);
    rl.drawLine3D(p4, p1, .black);
    // draw back cube
    rl.drawLine3D(p5, p6, .gray);
    rl.drawLine3D(p6, p7, .gray);
    rl.drawLine3D(p7, p8, .gray);
    rl.drawLine3D(p8, p5, .gray);
    // connect the sides
    rl.drawLine3D(p1, p5, .black);
    rl.drawLine3D(p2, p6, .black);
    rl.drawLine3D(p3, p7, .black);
    rl.drawLine3D(p4, p8, .gray);
}

fn scale(factor: u16) void {
    p1.x *= factor;
    p2.x *= factor;
    p3.x *= factor;
    p4.x *= factor;
    p5.x *= factor;
    p6.x *= factor;
    p7.x *= factor;
    p8.x *= factor;

    p1.y *= factor;
    p2.y *= factor;
    p3.y *= factor;
    p4.y *= factor;
    p5.y *= factor;
    p6.y *= factor;
    p7.y *= factor;
    p8.y *= factor;

    p1.z *= factor;
    p2.z *= factor;
    p3.z *= factor;
    p4.z *= factor;
    p5.z *= factor;
    p6.z *= factor;
    p7.z *= factor;
    p8.z *= factor;
}

fn shiftCube(x: u16, y: u16, z: u16) void {
    p1.x += x;
    p2.x += x;
    p3.x += x;
    p4.x += x;
    p5.x += x;
    p6.x += x;
    p7.x += x;
    p8.x += x;

    p1.y += y;
    p2.y += y;
    p3.y += y;
    p4.y += y;
    p5.y += y;
    p6.y += y;
    p7.y += y;
    p8.y += y;

    p1.z += z;
    p2.z += z;
    p3.z += z;
    p4.z += z;
    p5.z += z;
    p6.z += z;
    p7.z += z;
    p8.z += z;
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
