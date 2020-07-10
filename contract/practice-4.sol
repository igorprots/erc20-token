pragma solidity ^0.6.8;

// 1. Function modifier keywords (view, pure, constant) 

contract MyContract{
    uint value;

    function getValue()external view returns(uint) {
        return value;
    }
    // function getValue()external pure returns(uint) {
    //     return 1+1;
    // }

    function setValue(uint _value) external {
        value = _value;
    }
}