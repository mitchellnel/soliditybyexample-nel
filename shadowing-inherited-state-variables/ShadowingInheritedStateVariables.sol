// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Unlike functions, state variables cannot be overriden by re-declaring it in the child contract

// Let's learn how to correctly override inherited state variables

contract A {
    string public name = "Contract A";

    function getName() public view returns (string memory) {
        return name;
    }
}

// Shadowing is disallowed in Solidity 0.6 onwards
// This will not compile
// contract B is A {
//     string public name = "Contract B";
// }

contract C is A {
    // this is the correct way to override inherited state variables
    constructor() {
        name = "Contract C";
    }

    // C.getName() returns "Contract C"
}
