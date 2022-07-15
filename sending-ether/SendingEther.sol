// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// We can send Ether to other contracts by:
// - transfer (2300 gas, throws an error)
// - send (2300 gas, returns a bool)
// - call (forward all gas or set gas, returns bool)

// A contract receiving Ether must have at least one of the functions below
// - receive() external payable
// - fallback() external payable

// receive() is called if msg.data is empty, otherwise fallback() is called

// The recommended method to use as of December 2019 is **call in combination with re-entrancy
//  guard**

// We can guard againt re-entrancy by:
// - making all state changes before calling other contracts
// - using a re-entrancy guard modifier

contract ReceiveEther {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether
    // msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdrawAll() public {
        uint256 currBal = address(this).balance;

        (bool success, ) = owner.call{value: currBal}("");
        require(success, "Failed to withdraw Ether");
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // this function is no longer recommended for sending Ether
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // send returns a Boolean value indicating success or failure
        // this function is not recommended for sending Ether
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // call returns a Boolean value indicating success or failure
        // this is the current recommended method to for sending Ether
        (bool success, bytes memory data) = _to.call{value: msg.value}("");
        require(success, "Failed to send Ether");
    }
}
