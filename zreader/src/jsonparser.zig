const std = @import("std");
const expect = std.testing.expect;
const Parsed = std.json.Parsed(Tap);

const Tap = @import("model.zig").Tap;

const tap_json: []const u8 = 
    \\{
    \\  "id": 1,
    \\  "active": true,
    \\  "batchUnit": {
    \\    "id": 1,
    \\    "batchId": 10,
    \\    "tapId": null,
    \\    "brewfatherId": "LAXI2KWZXcU2pBpzrfg6B3Uy5940vQ",
    \\    "name": "Batch",
    \\    "tapStatus": "CONNECTED",
    \\    "packagingType": "KEG",
    \\    "volumeStatus": "NOT_EMPTY",
    \\    "keg": {
    \\      "id": 1,
    \\      "capacity": 23,
    \\      "brand": "AEB",
    \\      "serialNumber": null,
    \\      "purchaseCondition": "NEW",
    \\      "note": null
    \\    }
    \\  }
    \\}
;


test "json parse tap" {
    const gpa = std.testing.allocator;
    const parse: Parsed = try std.json.parseFromSlice(
        Tap,
        gpa,
        tap_json,
        .{}
    );
    defer parse.deinit();

    const tap: Tap = parse.value;
    std.debug.print("Tap: {any}\n", .{tap});
    try expect(tap.id == 1);
}
