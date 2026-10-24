const std = @import("std");

// might not be needed
const Token = enum {
    http_version_0_9,
    http_version_1_0,
    http_version_1_1,
    http_version_2,
    http_version_3,
    get,
    post,
    put,
    delete,
    options,
    trace,
    connect,
};
