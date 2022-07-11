// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Here, we have an example of the errors in action

contract AccoutExample {
    uint256 public balance;
    uint256 public constant MAX_UINT256 = 2**256 - 1;

    function deposit(uint256 _depositAmount) public {
        uint256 oldBalance = balance;
        uint256 newBalance = balance + _depositAmount;

        // balance + _depositAmount does not overflow if balance + _depositAmount <= MAX_UINT256
        require(newBalance <= MAX_UINT256, "uint256 overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(uint256 _withdrawalAmount) public {
        uint256 oldBalance = balance;

        // balance - _withdrawalAmount does not underflow if balance >= _withdrawalAmount
        require(balance >= _withdrawalAmount, "uint256 underflow");

        if (balance < _withdrawalAmount) {
            revert("uint256 underflow");
        }

        balance -= _withdrawalAmount;

        assert(balance <= oldBalance);
    }
}
