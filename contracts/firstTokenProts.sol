// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

import "./ERC20StandardContract.sol";

contract NewToken is ERC20Standard {
    constructor() public {
        totalSupply = 10000000000000000000000;
        name = "Boom Token";
        decimals = 18;
        symbol = "BMT";
        version = "1.0";
        balances[msg.sender] = totalSupply;
    }
}
