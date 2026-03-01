const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    //setup executable
    const executable = b.addExecutable(.{ .name = "zli", .root_module = b.createModule(.{ .target = target, .optimize = optimize, .root_source_file = b.path("src/main.zig") }) });
    b.installArtifact(executable);
}
