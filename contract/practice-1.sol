pragma solidity ^0.6.8;

// 1.contract constructor
// 2.parent contract

contract MyParentContract{
   constructor(uint b) public {
       //do some stuff
   }
}

contract MyChildContact is MyParentContract {
 uint a;
 address admin;
 constructor(uint _a) MyParentContract(_b) public {
     //it can be empty
 }
}