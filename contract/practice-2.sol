pragma solidity ^0.6.8;

// 1.declare struct
// 2.CRUD
// 3.Array of struct
// 4.mapping of struct

contract MyContract {
    struct User{
        address addr;
        uint256 score;
        string name;
    }

    User[] users;
    mapping(address =>User) userList2;

    function foo(string calldata _name) external{
        User memory user1 = User(msg.sender, 0, _name);
        User memory user2 = User(msg.sender, 0, _name);
        User memory user3 = User({name: _name, score:0,addr:msg.sender});
        user3.addr;
        user3.score = 20;
        delete user1;

        users.push(user2)
        userList2[msg.sender] = User();
        
    }
}