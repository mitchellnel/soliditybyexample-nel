// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Solidity supports enumerables (enums), and they are useful to model choice and keep track of
//  state

// Enums can be declared both within and outside of a contract

contract Enums {
    // enum representing shipping status
    enum ShippingStatus {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Cancelled
    }

    // the default value for an enum type variable is the first element listed in the enum
    //  definition
    // for ShippingStatus, this would be Pending
    ShippingStatus public shippingStatus;

    // returns a uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns (ShippingStatus) {
        return shippingStatus;
    }

    // update status by passing uint into input
    function set(ShippingStatus _shippingStatus) public {
        shippingStatus = _shippingStatus;
    }

    // we can update to a specific enum like this
    function cancel() public {
        shippingStatus = ShippingStatus.Cancelled;
    }

    // delete resets the enum to its default value -- 0
    function reset() public {
        delete shippingStatus;
    }
}
