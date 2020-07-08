// SPDX-License-Identifier: MIT

pragma solidity ^0.6.8;
import '../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '../node_modules/@openzeppelin/contracts/math/SafeMath.sol';
import '../node_modules/@openzeppelin/contracts/utils/EnumerableMap.sol';



contract Tokenv1 is ERC20 {

   using EnumerableMap for EnumerableMap.UintToAddressMap;
   using SafeMath for uint256;

    string public constant name = "Divident Token";
    string public constant symbol = "DET";
    uint8 public constant decimals = 3;

    uint256 _totalSupply = 1000000000;

    address public owner;

    uint256 public tokenPrice;

    uint256 public constant amountOfEthereum = this.balance; 

    mapping (address => mapping (address => uint256)) allowed;

    EnumerableMap.UintToAddressMap tokensBalances;
    EnumerableMap.UintToAddressMap ethereumBalances;
 
    function Tokenv1() public {
        owner = msg.sender;
        tokensBalances.insert(owner,_totalSupply);
    }


    function totalSupply() public view returns (uint256 totalSupply) {
        totalSupply = _totalSupply;
        return totalSupply;
    }


    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _recipient, uint256 _value) public onlyPayloadSize(2 * 32){
        require(balances[msg.sender] >= _value && _value > 0);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_recipient] = balances[_recipient].add(_value);
        emit Transfer(msg.sender, _recipient, _value);
    }

    function transferFrom(address _from,address _to,uint256 _value) public {
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
        balances[_to] = balances[_to].add(_value);
        balances[_from] = balances[_from].sub(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }

    function allowance(address _spender, address _owner) public view returns (uint256 balance){
        return allowed[_owner][_spender];
    }


    receive() external payable{
        getDividents();
    }

    function getDividents() private {
        uint256 value;
        address key;
        
        tokenPrice = amountOfEthereum.div(_totalSupply);

        for(uint i = 0; i < tokensBalances.size(); i++){
            value = tokensBalances.getValueByIndex(i);
            key = tokensBalances.getKeyByIndex(i);

            ethereumBalances.insert(key, value.mul(tokenPrice));

            key.transfer(value.mul(tokenPrice));
        }
    }

    function balanceOfETH(address _owner) public view returns (uint256 balance) {
        balance = ethereumBalances.get(_owner);
        return balance;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}