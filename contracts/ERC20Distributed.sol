// SPDX-License-Identifier: MIT

pragma solidity ^0.6.8;
import '../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol';
// import '../node_modules/@openzeppelin/contracts/math/SafeMath.sol';
import "./DistributionIterableMapping.sol";

contract ERC20Distributed is IERC20 {
    string public symbol;
    string public name;
    uint256 public decimals;
    uint256 private _totalSupply;
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowed;

    DistributionIterableMapping private ditmap;
    uint256 public totalReward;

    event DivideUpReward(uint256 reward);
    event WithdrawReward(address account, uint256 amount);

    constructor() public {
        symbol = "ME20D";
        name = "My ERC20 Dsstributed";
        decimals = 18;
        _totalSupply = 100000 * 10 ** decimals;
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);

        ditmap = new DistributionIterableMapping();
    }

    // Standart ERC20 methods
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address who) external view override returns (uint256) {
        return _balances[who];
    }

    function transfer(address to, uint256 value) external override returns (bool) {
        require(_balances[msg.sender] >= value, "Account amount is lower, than requested value");
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);

        // Insert information about new balances to map
        ditmap.insert(msg.sender, _balances[msg.sender]);
        ditmap.insert(to, _balances[to]);

        return true;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowed[owner][spender];
    }

    function transferFrom(address from, address to, uint256 value) external override returns (bool) {
        require(_balances[from] >= value, "Sender amount is lower, than requested value");
        require(_allowed[from][msg.sender] >= value, "Recipient not allowed to get requested value");
        _balances[from] -= value;
        _balances[to] += value;
        _allowed[from][msg.sender] -= value;
        emit Transfer(msg.sender, to, value);

        // Insert information about new balances to map
        ditmap.insert(from, _balances[from]);
        ditmap.insert(to, _balances[to]);

        return true;
    }

    function approve(address spender, uint256 value) external override returns (bool) {
        require(spender != address(0), "Allowed value cannot be set for zero address");
        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // Distribution methods
    function _divideUpReward() private {
        uint256 toReward = address(this).balance - totalReward;
        totalReward = address(this).balance;
        ditmap.onReward(toReward, _totalSupply);
        emit DivideUpReward(toReward);
    }

    function withdrawReward() external {
        uint256 amount = ditmap.getValueToWithdraw(msg.sender);
        totalReward -= amount;
        msg.sender.transfer(amount);

        emit WithdrawReward(msg.sender, amount);
    }

    // For sending eth
    fallback() external payable {
        _divideUpReward();
    }

    receive() external payable {
        _divideUpReward();
    }
}