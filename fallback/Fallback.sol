// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// fallback() is a function that does not take any arguments and does not return anything

// It is executed either when:
// - a function that does nto exist is called
// - or Ether is sent directly to a contract, but receive() does not exist or msg.data is empty

// fallback() has a 2300 gas limit when called by transfer or send

contract Fallback {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    event GasLeftLog(uint256 gasLeft);

    // fallback functions must be declared as external
    fallback() external payable {
        // send/transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        emit GasLeftLog(gasleft());
    }

    // helper function to check the balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // helper function to withdraw all Ether in the contract back to the owner
    function withdrawAll() public {
        uint256 currBal = address(this).balance;

        (bool success, ) = owner.call{value: currBal}("");
        require(success, "Failed to withdraw Ether");
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool success, ) = _to.call{value: msg.value}("");
        require(success, "Failed to send Ether");
    }
}
