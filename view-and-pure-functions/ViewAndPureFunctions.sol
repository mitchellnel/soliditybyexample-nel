// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Getter functions can either be declared as view or pure:
// - view functions promise not to modify the state
// - pure functions promise not to read or modify the state

contract ViewAndPureFunctions {
    int256 public x = 33;

    // view functions promise not to modify the state
    function addToX(int256 y) public view returns (int256) {
        return x + y;
    }

    // pure functions promise not to read or modify the state
    function add(int256 a, int256 b) public pure returns (int256) {
        return a + b;
    }
}
