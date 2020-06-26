// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/firstTokenProts.sol";

contract TestMetaCoin {
    function testInitialBalanceUsingDeployedContract() external {
        uint256 expected = 10000;
        MetaCoin.meta.MetaCoin(DeployedAddresses.MetaCoin());
        Assert.equal(
            meta.getBalance(msg.sender),
            expected,
            "Owner should have 10000 MetaCoin initially"
        );
    }

    function testInitialBalanceWithNewMetaCoin() external {
        MetaCoin.meta.MetaCoin();

        uint256 expected = 10000;

        Assert.equal(
            meta.getBalance(msg.sender),
            expected,
            "Owner should have 10000 MetaCoin initially"
        );
    }
}
