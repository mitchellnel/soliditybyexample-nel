// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* How much ether do we need to pay for a transaction? */
// We pay gas_spent * gas_price amount of ether, where:
// - gas is a unit of consumption
// - gas_spent is how much total gas is used in a transaction
// - gas_price is how much ether we are willing to pay per unit of gas

// Transactions with a higher gas price have a higher priority to be included in a block

// Unspent gas is refunded

/* Gas Limit */
// There are 2 upper bounds to the amount of gas we can spend
// - gas_limit (max amount of gas we're willing to use for your transaction, set by us)
// - block_limit (max amount of gas allowed in a block, set by the network)

contract Gas {
    uint256 public i = 0;

    // Using up all of the gas that we send in our transaction will cause our transaction to fail
    // State changes are undone
    // Gas spent is not refunded if the transaction fails
    function forever() public {
        // Infinite loop to exhaust the transaction's gas
        while (true) {
            i += 1;
        }
    }
}
