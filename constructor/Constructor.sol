// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A costructor is an optional function that is executed upon contract creation

// Here are examples of how to pass arguments to constructors, and how constructors work with
//  inheritance

// Base contract X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// Base contract Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// There are 2 ways to initialise parent contract with parameters

// Pass the parameters here in the inheritance list
contract B is X("Input to X"), Y("Input to Y") {

}

// Pass the parameters in the body of the constructor
contract C is X, Y {
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// Parent constructors are always called in the order of inheritance, regardless of the order of
//  parent contracts listed in the constructor of the child contract

// Order of constructors called:
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}
