const std = @import("std");
const Allocator = std.mem.Allocator;
const Sorting = @import("sort.zig").Sorting;

const InsertionSort = struct {

    fn sort(self: *InsertionSort, gpa: Allocator, data: []i32) ![]i32 {
        if (data.len == 1) {
            return data;
        }
        if (data.len == 2) {
            if (data[0] > data[1]) {
                const largest = data[0];
                data[0] = data[1];
                data[1] = largest;
            }
            return data;
        }
        // split
        var left  = try gpa.alloc(i32, data.len);
        var right = try gpa.alloc(i32, data.len);
        var l: usize = 0;
        var r: usize = 0;
        defer gpa.free(left);
        defer gpa.free(right);

        const pivot = data[0];
        for (data) |element| {
            if (element < pivot) {
                left[l] = element;
                l += 1;
            } else {
                right[r] = element;
                r += 1;
            }
        }
        // sort
        const sortedLeft  = try self.sort(gpa, left);
        const sortedRight = try self.sort(gpa, right);
        // combine
        for (sortedLeft, 0..) |element, idx| {
            data[idx] = element;
        }
        for (sortedRight, sortedLeft.len..) |element, idx| {
            data[idx] = element;
        }
        return data;

    }

    pub fn sorting(self: *InsertionSort) Sorting {
        return .{
            .ptr = self,
            .vtable = .{
                .sort = insertionSortOpaque,
            },
        };
    }

    fn insertionSortOpaque(ptr: *anyopaque, allocator: Allocator, data: []i32) ![]i32 {
        const self: *InsertionSort = @ptrCast(ptr);
        return self.sort(allocator, data);
    }
};

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    var ins = InsertionSort{};
    var sorting = ins.sorting();

    var data = [_]i32{17, 10, 20, 1, 3};

    _ = try sorting.sort(gpa, &data);
}
