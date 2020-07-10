pragma solidity ^0.6.8;

// 1.storage array
// 1.memory array
// 1.array arguments and return arrays from function

contract MyContract {
// 1. storage array
    uint[] myArray; //crud, create, read, delete
    // bool[] myArray

    
    function foo() external {
        myArray.push(2);
        myArray.push(3);
        // myArray.push(4);
        myArray[0]; //if[1] its myArray.push(3);

        myArray[0] = 20; //UPDATE

        delete myArray[1]; //its delete  myArray.push(3);

        for(uint i = 0; i < myArray.legth; i++) {
            myArray[i];
        }
    }

// 2. memory array
    function bar() external {
        uint[] memory newArray = new uint[](10);
        newArray[0] = 10;
        newArray[1] = 20;

        newArray[0];

        newArray[0] = 200;

        delete newArray[5];

    }

// 3. arrays in fuction

    // function fooBar(uint[] calldata myArg) external
    // function fooBar(uint[] memory myArg) public returns(uint[]) memory
    function fooBar(uint[] memory myArg) internal returns(uint[]) memory {

    }
}
  