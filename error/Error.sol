// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// An error will undo all changes made to the state during a transaction

// You can throw an error using require, revert, or assert:
// - require is used to validate inputs and conditions before execution
// - revert will immediately throw an error -- it can be used in a similar validation way to
//    require, see the example code below
// - assert is used to check for code that should never be false -- failing an assertion
//    probably means that there is a bug

contract Error {
    function testRequire(uint256 _num) public pure {
        // require should be used to validate conditions such as:
        // - inputs
        // - conditions before execution
        // - return values from calls to other functions
        require(_num > 10, "Input must be greater than 10");
    }

    function testRevert(uint256 _num) public pure {
        // revert is useful to use when the condition is complex

        // this code does the exact same thing as we do in testRequire, but using revert instead
        if (_num <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint256 public num;

    function testAssert() public view {
        // assert should only be used to test for internal errors, and to check invariants

        // here, we assert that num == 0, since it is impossible to update the value of num
        assert(num == 0);
    }

    // we can also declare custom errors
    error InsufficientBalance(uint256 balance, uint256 withdrawalAmount);

    function testCustomError(uint256 _withdrawalAmount) public view {
        uint256 bal = address(this).balance;

        if (bal < _withdrawalAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawalAmount: _withdrawalAmount
            });
        }
    }
}
