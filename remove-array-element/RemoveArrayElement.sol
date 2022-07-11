// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RemoveArrayElement {
    // Here we'll demonstrate two examples of how to remove an array element

    // Note that the delete keyword does not remove an array element in the expected sense, it just
    //  sets the element at the specified index to its zero-value, but does not shorten the length
    //  of the array -- an element is still accessible at the specified index to be deleted, which
    //  is not expected behaviour

    uint256[] public arr1;
    uint256[] public arr2;

    // For arr 1, we will remove by shifting:
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []
    function removeByShifting(uint256 _index) public {
        require(_index < arr1.length, "_index out of arr1 bounds");

        for (uint256 i = _index; i < arr1.length - 1; i++) {
            arr1[i] = arr1[i + 1];
        }
        arr1.pop();
    }

    function testShiftingRemoval() public {
        arr1 = [1, 2, 3, 4, 5];
        removeByShifting(2);
        // arr1 should now be [1, 2, 4, 5]
        assert(arr1.length == 4);
        assert(arr1[0] == 1);
        assert(arr1[1] == 2);
        assert(arr1[2] == 4);
        assert(arr1[3] == 5);

        arr1 = [1];
        removeByShifting(0);
        // arr1 should now be []
        assert(arr1.length == 0);
    }

    // For arr2, we will remove by copying the last element into the index we are removing
    function removeByReplacing(uint256 _index) public {
        arr2[_index] = arr2[arr2.length - 1];
        arr2.pop();
    }

    function testReplacingRemoval() public {
        arr2 = [1, 2, 3, 4];
        removeByReplacing(1);
        // [1, 4, 3]
        assert(arr2.length == 3);
        assert(arr2[0] == 1);
        assert(arr2[1] == 4);
        assert(arr2[2] == 3);

        removeByReplacing(2);
        // [1, 4]
        assert(arr2.length == 2);
        assert(arr2[0] == 1);
        assert(arr2[1] == 4);
    }
}
