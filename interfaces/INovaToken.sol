// SPDX-License-Identifier: MIT
pragma solidity 0.8.37;

interface INexusToken {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}
