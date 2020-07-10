pragma solidity ^0.6.8;

// 1. declare mapping
// 2.CRUD
// 3.Exotic mapping 1: rested mappings
// 4.Exotic mapping 2: array inside mapping

contract MyContract{

    // 1. declare mapping
    mapping(address => uint) balances;
    // mapping(address => bool) balances;
    mapping(address => mapping(address => bool)) approved;
    mapping(address => uint[]) scores;
    

    function foo(address spender) external {
        // 2-Add

        balnces[msg.sender] = 100;
        // 2-Read
        balnces[msg.sender];
        // 2-Update
        balnces[msg.sender] = 200;
        // 2Delete
        delete balnces[msg.sender];

        // 3. Default values
        balances[someAddressThatDoNotExist] => 0 //undifined in JavaScript
        // balances[someAddressThatDoNotExist] => false;

        // 4-exotic mapping 1
        approved[msg.sender][spender] = true;
        approved[msg.sender][spender];
        approved[msg.sender][spender] = false;
        delete approved[msg.sender][spender];
        
         // 4-exotic mapping 2
        // scores[msg.sender] = new uint[](2);
        scores[msg.sender].push(1);
        scores[msg.sender].push(2);
        scores[msg.sender][0];
        scores[msg.sender][0] = 10;
        delete scores[msg.sender][0];
    }
}