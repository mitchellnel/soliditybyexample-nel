// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Modifiers are code that can be run before and/or after a function call

// Modifiers can be used to:
// - restrict access
// - validate inputs
// - guard against reentrancy hacks

contract FunctionModifier {
    // we will use these variables to demonstrate how to use modifiers
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        // set the contract deployer as the owner of the contract
        owner = msg.sender;
    }

    // modifier to check that the caller is the owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");

        // underscore is a special character only used inside a function modifier, and it tells
        // Solidity to execute the rest of the code
        _;
    }

    // modifiers can take inputs
    // this modifier checks that the address passed in is not the zero address
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not a valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validAddress(_newOwner)
    {
        owner = _newOwner;
    }

    // modifiers can be called before and/or after a function, depending on where the underscore is
    // placed
    // this modifier prevents a function from being called while it is still executing
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}
