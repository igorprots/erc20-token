pragma solidity ^0.6.8;

// 1. Simple example: with a pure function
// 2. Alloved example: with a struct
// 3. Using... for
// 5. Deployed vs Embedded libraries 

library MyLibrary {
    struct Player {
        uint score;
    }
    function incrementScore(Player storage _player, uint points) internal {
        _player.score += points;
    }
    // function add10(uint 10) pure public returns(uint){
    //     return a + 10;
    // }
}
// DELEGATECALL
contract MyContract {
    using MyLibrary for  MyLibrary.Player
    mapping(uint => MyLibrary.Player) players
    function foo() external {
        // MyLibrary.incrementScore(players[0], 10);
        players[0].incrementScore(10);
    }
    // function foo() external {
    //     uint result = MyLibrary.add10(10)
    // }
}