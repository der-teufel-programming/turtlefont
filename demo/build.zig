const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const tf_dep = b.dependency("turtlefont", .{});
    const tf_mod = tf_dep.module("turtlefont");

    const args = b.dependency("args", .{});
    const proxy_head = b.dependency("proxy_head", .{});

    const exe = b.addExecutable(.{
        .name = "demo",
        .root_module = b.createModule(.{
            .root_source_file = b.path("demo.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "turtlefont", .module = tf_mod },
                .{ .name = "args", .module = args.module("args") },
                .{ .name = "ProxyHead", .module = proxy_head.module("ProxyHead") },
            },
        }),
    });

    b.installArtifact(exe);
}
