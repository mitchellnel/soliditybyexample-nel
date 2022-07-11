// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// We can declare and use enums in separate files

enum ShippingStatus {
    Pending,
    Shipped,
    Accepted,
    Rejected,
    Cancelled
}
