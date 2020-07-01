// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

import "./ERC20Standard.sol";

contract BoomToken is ERC20Standard {
    address public owner;
    constructor() public {
        owner = msg.sender;
        decimals = 0;
        totalSupply = 1000000;
        name = "BoomToken";
        symbol = "BMT";
        balances[msg.sender] = totalSupply;
        burningDate = now.add(1 days);
        emit Transfer(address(0), owner, totalSupply);
    }
}
