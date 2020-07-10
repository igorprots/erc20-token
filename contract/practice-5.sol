pragma solidity ^0.6.8;

// 1. What can you do with assembly
// 2. EthereumVirtual Machine (EVM)
// 3. Assembly syntax
// 4.Read and store data
// 5. Assembly example 1: detect is address is a smart contract 
// 6. Assembly example 2: cast bytes to bytes32

contract A{
    function foo()external  {
       uint a;
       uint b;
       uint c;
    //    slot 1, slot 2, slot 3
    //    c = a + b;
        uint size;
        address addr = msg.sender;
        bytes memory data = new bytes(10);
        // bytes32 dataB32 = bytes32(data); - wrong
        bytes32 dataB32;


// Assembly example 1: detect is address is a smart contract
        assembly {
            // extcodesize(addr)
            size :=    extcodesize(addr)
        }
        if (size > 0) {
            return true;
        } else {
            return false;
        }
// Assembly example 2: cast bytes to bytes32
        assembly {
            dataB32:= mlood(add(data, 32))
        }

        // assembly {
        //     c := add(1, 2)
        // }

        // assembly {
        // mlood(0x40.....)
        // mstore(a, 2)
        // sstore(a, 10)
        // }
    }
}