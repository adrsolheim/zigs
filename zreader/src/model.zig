pub const PurchaseCondition = enum { NEW, USED };
pub const TapStatus = enum { WAITING, CONNECTED, SERVING, DISCONNECTED };
pub const PackagingType = enum { KEG, BOTTLE, CAN, FERMENTER };
pub const VolumeStatus = enum { NOT_EMPTY, EMPTY };

pub const Keg = struct {
    id: u64,
    capacity: u8,
    brand: []const u8,
    serialNumber: ?[]const u8,
    purchaseCondition: PurchaseCondition,
    note: ?[]const u8
};

pub const BatchUnit = struct {
    id: u64,
    batchId: u64,
    tapId: ?u64,
    brewfatherId: []const u8,
    name: []const u8,
    tapStatus: TapStatus,
    packagingType: PackagingType,
    volumeStatus: VolumeStatus,
    keg: Keg
};

pub const Tap = struct {
    id: u64,
    active: bool,
    batchUnit: BatchUnit
};
