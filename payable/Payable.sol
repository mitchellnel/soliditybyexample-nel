// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Functions and addresses declared payable can receive ether into the contract

contract Payable {
    // payable addresses can receive Ether
    address payable public owner;

    // payable constructor can receive Ether {
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Function to deposit Ether into this contract
    // Call this function along with some Ether
    // The balance of this contract will be automatically updated
    function deposit() public payable {}

    // Call this function along with some Ether
    // The function will throw an error since this function is not payable
    function notPayable() public {}

    // Function to withdraw all Ether from this contract
    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint256 currBal = address(this).balance;

        // send all Ether to the owner
        // owner can receive Ether since the address of the owner is payable
        (bool success, ) = owner.call{value: currBal}("");
        require(success, "Failed to withdraw Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint256 _amount) public {
        require(msg.sender == owner, "Not owner");

        // note that _to is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}
