// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Events allow logging to the Ethereum blockchain

// Some use cases for events are:
// - listening for events and updating user interface
// - a cheap form of storage

contract Events {
    // event declaration
    // up to 3 parameters can be indexed
    // indexed parameters help us filter the logs bt the indexed parameter
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello, world!");
        emit Log(msg.sender, "Hello, EVM!");
        emit AnotherLog();
    }
}
