// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// delegatecall is a low-level function similar to call

// When contract A executes delegatecall to contract B, B's code is executed **with contract A's
//  storage, msg.sender and msg.value**

// NOTE: deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A to achieve expected behaviour
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint256 public num;
    address public sender;
    uint256 public value;

    event Response(bool success, bytes data);

    function setVars(address _contract, uint256 _num) public payable {
        // A's storage is set, B is not modified
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        emit Response(success, data);
    }
}
