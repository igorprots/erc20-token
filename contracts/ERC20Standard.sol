// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

contract ERC20Standard {
    using SafeMath for uint256;
    uint256 public totalSupply;
    string public name;
    uint256 public decimals;
    string public symbol;
    uint256 public burningDate;
    uint256 length = 2;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    mapping (address => uint256) counter;
    mapping (address => bool) owners;
	mapping (address => mapping (address => bool)) ownerChoice;



	address constant own1 = 0xDB3Da15110cD37844515471f883A663D0239d174;
	address constant own2 = 0xf3CA95E256effCE14c6674641510A13449548632;



    //Fix for short address attack against ERC20
    modifier onlyPayloadSize(uint256 size) {
        assert(msg.data.length == size + 4);
        _;
    }
    modifier onlyOwner() {
		require(owners[msg.sender] == true);
		_;
	}

	function ownersBalance() public {
		owners[own1] = true;
		owners[own2] = true;
		balances[own1] = totalSupply/2;
		balances[own2] = totalSupply - balances[own1];
	}

	function isOwner(address _owner) view public  returns (bool) {
		return owners[_owner];
	}

	function isOwnerChoice(address _owner, address _newOwner) view public  returns (bool) {
		return ownerChoice[_owner][_newOwner];
	}

	function addOwner(address _newOwner) public onlyOwner  {
		require(ownerChoice[msg.sender][_newOwner] == false && owners[_newOwner] == false);
			ownerChoice[msg.sender][_newOwner] = true;
			counter[_newOwner]++;
			if (counter[_newOwner] > length/2) {
				owners[_newOwner] = true;
				length++;
				counter[_newOwner] = 0;
			}
	}

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _recipient, uint256 _value)
        public
        onlyPayloadSize(2 * 32)
    {
        require(balances[msg.sender] >= _value && _value > 0);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_recipient] = balances[_recipient].add(_value);
        emit Transfer(msg.sender, _recipient, _value);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public {
        require(
            balances[_from] >= _value &&
                allowed[_from][msg.sender] >= _value &&
                _value > 0
        );
        balances[_to] = balances[_to].add(_value);
        balances[_from] = balances[_from].sub(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }

    function allowance(address _spender, address _owner)
        public
        view
        returns (uint256 balance)
    {
        return allowed[_owner][_spender];
    }

    function burn(uint256 _value) external {
        require(now > burningDate, "Coins can't be burned now");
        require(
            balances[msg.sender] >= _value,
            "Account balance is not enought to perform coins burning"
        );
        balances[msg.sender] -= _value;
        totalSupply -= _value;
    }

    //Event which is triggered to log all transfers to this contract's event log
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    //Event which is triggered whenever an owner approves a new allowance for a spender.
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}
