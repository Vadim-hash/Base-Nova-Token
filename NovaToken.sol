 SPDX-License-Identifier MIT
pragma solidity 0.8.22;

contract NovaToken {
    string public constant name = Nova Base Network;
    string public constant symbol = NOVA;
    uint8 public constant decimals = 18;
    uint256 public totalSupply;

    address public owner;
    bool public isTransfersPaused;

    mapping(address = uint256) private _balances;
    mapping(address = mapping(address = uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event TokensBurned(address indexed burner, uint256 amount);
    event PauseStateChanged(bool isPaused);

    modifier onlyOwner() {
        require(msg.sender == owner, NovaToken Not authorized);
        _;
    }

    constructor(uint256 initialSupplyTokens) {
        owner = msg.sender;
        totalSupply = initialSupplyTokens  (10  uint256(decimals));
        _balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address tokenOwner, address spender) external view returns (uint256) {
        return _allowances[tokenOwner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        uint256 currentAllowance = _allowances[from][msg.sender];
        require(currentAllowance = amount, NovaToken Allowance exceeded);
        _allowances[from][msg.sender] = currentAllowance - amount;
        _transfer(from, to, amount);
        return true;
    }

    function burn(uint256 amount) external {
        require(_balances[msg.sender] = amount, NovaToken Insufficient balance to burn);
        _balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit TokensBurned(msg.sender, amount);
        emit Transfer(msg.sender, address(0), amount);
    }

    function setPaused(bool paused) external onlyOwner {
        isTransfersPaused = paused;
        emit PauseStateChanged(paused);
    }

    function airdropTokens(address[] calldata recipients, uint256 amountEach) external onlyOwner {
        uint256 totalNeeded = recipients.length  amountEach;
        require(_balances[msg.sender] = totalNeeded, NovaToken Balance too low for airdrop);

        for (uint256 i = 0; i  recipients.length; i++) {
            _transfer(msg.sender, recipients[i], amountEach);
        }
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(!isTransfersPaused, NovaToken Transfers temporarily paused);
        require(from != address(0), NovaToken Transfer from zero address);
        require(to != address(0), NovaToken Transfer to zero address);
        require(_balances[from] = amount, NovaToken Low sender balance);

        _balances[from] -= amount;
        _balances[to] += amount;
        emit Transfer(from, to, amount);
    }
}