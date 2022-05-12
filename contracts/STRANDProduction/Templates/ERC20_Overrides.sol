// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "../../../@openzeppelin/contracts/token/ERC20/ERC20.sol";

abstract contract ERC20_Overrides is ERC20 {
    // STRAND: deploy-remove
    function name() public view override returns (string memory) { return ERC20.name(); }
    // STRAND: deploy-remove
    function symbol() public view override returns (string memory) { return ERC20.symbol(); }
    // STRAND: deploy-remove
    function decimals() public view override returns (uint8) { return ERC20.decimals(); }
    // STRAND: deploy-remove
    function totalSupply() public view override returns (uint256) { return ERC20.totalSupply(); }
    // STRAND: deploy-remove
    function balanceOf(address account) public view override returns (uint256) { return ERC20.balanceOf(account); }
    // STRAND: deploy-remove
    function transfer(address to, uint256 amount) public override returns (bool) { return ERC20.transfer(to, amount); }
    // STRAND: deploy-remove
    function allowance(address owner, address spender) public view override returns (uint256) { return ERC20.allowance(owner, spender); }
    // STRAND: deploy-remove
    function approve(address spender, uint256 amount) public override returns (bool) { return ERC20.approve(spender, amount); }
    // STRAND: deploy-remove
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) { return ERC20.transferFrom(from, to, amount); }
    // STRAND: deploy-remove
    function increaseAllowance(address spender, uint256 addedValue) public override returns (bool) { return ERC20.increaseAllowance(spender, addedValue); }
    // STRAND: deploy-remove
    function decreaseAllowance(address spender, uint256 subtractedValue) public override returns (bool) { return ERC20.decreaseAllowance(spender, subtractedValue); }
    // STRAND: deploy-remove
    function _transfer(address from, address to, uint256 amount) internal override { ERC20._transfer(from, to, amount); }
    // STRAND: deploy-remove
    function _mint(address account, uint256 amount) internal override { ERC20._mint(account, amount); }
    // STRAND: deploy-remove
    function _burn(address account, uint256 amount) internal override { ERC20._burn(account, amount); }
    // STRAND: deploy-remove
    function _approve(address owner, address spender, uint256 amount) internal override { ERC20._approve(owner, spender, amount); }
    // STRAND: deploy-remove
    function _spendAllowance(address owner, address spender, uint256 amount) internal override { ERC20._spendAllowance(owner, spender, amount); }
    // STRAND: deploy-remove
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override { ERC20._beforeTokenTransfer(from, to, amount); }
    // STRAND: deploy-remove
    function _afterTokenTransfer(address from, address to, uint256 amount) internal override { ERC20._afterTokenTransfer(from, to, amount); }
}