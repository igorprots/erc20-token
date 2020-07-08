// SPDX-License-Identifier: MIT

pragma solidity ^0.6.8;
import '../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '../node_modules/@openzeppelin/contracts/math/SafeMath.sol';
import '../node_modules/@openzeppelin/contracts/utils/EnumerableMap.sol';



contract MyToken is ERC20 {

   using EnumerableMap for EnumerableMap.UintToAddressMap;
   using SafeMath for uint256;

    string public override name = "Divident Token";
    string public  override symbol = "DET";
    uint8 public override decimals = 3;

    uint256 _totalSupply = 1000000000;

    address public owner;

    uint256 public tokenPrice;

    uint256 public constant amountOfEthereum = balanceOf; 

    mapping (address => mapping (address => uint256)) allowed;

    EnumerableMap.UintToAddressMap tokensbalanceOf;
    EnumerableMap.UintToAddressMap ethereumbalanceOf;
 
    // function Tokenv1() public {
    //     owner = msg.sender;
    //     tokensbalanceOf.insert(owner,_totalSupply);
    // }

    modifier onlyPayloadSize(uint256 size) {
        assert(msg.data.length == size + 4);
        _;
    }

    // function totalSupply() public view returns (uint256 totalSupply) {
    //     totalSupply = _totalSupply;
    //     return totalSupply;
    // }


    // function balanceOfOf(address _owner) public view returns (uint256 balanceOf) {
    //     return balanceOf[_owner];
    // }

    // function transfer(address _recipient, uint256 _value) public onlyPayloadSize(2 * 32){
    //     require(balanceOf[msg.sender] >= _value && _value > 0);
    //     balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
    //     balanceOf[_recipient] = balanceOf[_recipient].add(_value);
    //     emit Transfer(msg.sender, _recipient, _value);
    // }

    // function transferFrom(address _from,address _to,uint256 _value) public {
    //     require(balanceOf[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
    //     balanceOf[_to] = balanceOf[_to].add(_value);
    //     balanceOf[_from] = balanceOf[_from].sub(_value);
    //     allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    //     emit Transfer(_from, _to, _value);
    // }

    // function approve(address _spender, uint256 _value) public {
    //     allowed[msg.sender][_spender] = _value;
    //     emit Approval(msg.sender, _spender, _value);
    // }

    // function allowance(address _spender, address _owner) public view returns (uint256 balanceOf){
    //     return allowed[_owner][_spender];
    // }


    receive() external payable{
        getDividents();
    }

    function getDividents() private {
        uint256 value;
        address key;
        
        tokenPrice = amountOfEthereum.div(_totalSupply);

        for(uint i = 0; i < tokensbalanceOf.size(); i++){
            value = tokensbalanceOf.getValueByIndex(i);
            key = tokensbalanceOf.getKeyByIndex(i);

            ethereumbalanceOf.insert(key, value.mul(tokenPrice));

            key.transfer(value.mul(tokenPrice));
        }
    }

    function balanceOfOfETH(address _owner) public view returns (uint256 balanceOf) {
        balanceOf = ethereumbalanceOf.get(_owner);
        return balanceOf;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}