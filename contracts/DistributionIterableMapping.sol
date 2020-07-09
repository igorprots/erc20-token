// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

library IterableMapping {
    struct Value {
        address key;
        uint256 value;
        uint256 toWithdraw;
    }

    struct IterableMap {
        mapping (address => Value) data;
        address[] keysList;
    }
}


contract DistributionIterableMapping {
    IterableMapping.IterableMap private itmap;

    function contains(address key) public view returns (bool) {
        return itmap.data[key].key == key;
    }

    function insert(address key, uint256 value) public {
        if (!contains(key)) {
            itmap.keysList.push(key);
        }

        itmap.data[key].key = key;
        itmap.data[key].value = value;
    }

    function onReward(uint256 amount, uint256 totalSupply) external {
        for(uint32 i = 0; i < itmap.keysList.length; i++) {
            address acc = itmap.keysList[i];
            itmap.data[acc].toWithdraw += amount * itmap.data[acc].value / totalSupply;
        }
    }

    function getValue(address key) external view returns (uint256) {
        return itmap.data[key].value;
    }

    function getValueToWithdraw(address key) external view returns (uint256) {
        return itmap.data[key].toWithdraw;
    }
}