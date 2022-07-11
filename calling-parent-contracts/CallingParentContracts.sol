// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Parent contracts can be called directly, or by using the keyword super

// By using the keyword super, all of the immediate parent contracts will be called

/* Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo() called");
    }

    function bar() public virtual {
        emit Log("A.bar() called");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo() called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("B.bar() called");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo() called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar() called");
        super.bar();
    }
}

contract D is B, C {
    // Try:
    // - call D.foo() and check the event logs
    //   althought D inherits A, B, and C, it only called C and then A
    // - call D.bar() and check the event logs
    //   D caleld C, then B, and finally A
    //   although super was called twice (by B and C) it only called A once

    function foo() public override(B, C) {
        super.foo();
    }

    function bar() public override(B, C) {
        super.bar();
    }
}
