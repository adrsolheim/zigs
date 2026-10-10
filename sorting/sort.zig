const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Sorting = struct {
    ptr: *anyopaque,
    vtable: VTable,

    pub fn sort(self: *Sorting, allocator: Allocator, data: []i32) ![]i32 {
        return self.vtable.sort(self, allocator, data);
    }

    const VTable = struct {
        sort: *const fn(*anyopaque, Allocator, []i32) Allocator.Error![]i32,
    };

    
};
