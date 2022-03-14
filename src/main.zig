const std = @import("std");

fn printErrorSet(comptime fun: anytype) void {
    const info = @typeInfo(@TypeOf(fun));
    const ret_type = info.Fn.return_type.?;

    // looks like there is currently no way to comptime create error set tables with integers
    inline for (@typeInfo(@typeInfo(ret_type).ErrorUnion.error_set).ErrorSet.?) |reterror| {
        std.debug.print("{s}\n", .{reterror.name});
        std.debug.print("{s}\n", .{@errorToInt(reterror)});
        //std.debug.print("{s}\n", .{@errorToInt(reterror)});
        //std.debug.print("{d}\n", .{@errorToInt(error.test123)});
        //std.debug.print("{s}\n", .{@typeInfo(error.test123)});
    }
    //std.debug.print("{s}\n", .{info});
    //std.debug.print("{s}\n", .{ret_type});
}
//const all_errs =
//DiskQuota
//FileTooBig
//InputOutput
//NoSpaceLeft
//AccessDenied
//BrokenPipe
//SystemResources
//OperationAborted
//NotOpenForWriting
//WouldBlock
//ConnectionResetByPeer
//Unexpected

test "printErrors" {
    printErrorSet(main);
}

pub fn main() !void {
    const stdout = std.io.getStdOut();
    try stdout.writeAll("All your codebase are belong to us.\n");
}
