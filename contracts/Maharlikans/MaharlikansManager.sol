// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract MaharlikansManager {

  address private _owner;
  mapping(address => address) private _referals;

  constructor() {
    _owner = msg.sender;
  }

  /**
   Sets a manager for a referal
   */
  function referalAdd(address manager, address referal) public {
    require(_referals[referal] != address(0), "Referal already has a manager assigned. Use referalChange");
    setManager(referal, manager);
  }
  /**
   Changes the manager for a referal.
   Can only be called by former manager or contract owner
   */
  function referalChange(address referal, address newManager) public {
    require(_referals[referal] == msg.sender || msg.sender == _owner, "Referal can only be changed by the current manager or contract owner");
    setManager(referal, newManager);
  }

  function setManager(address referal, address manager) private {
    require(referal != manager, "Manager must be different from referal");
    require(_referals[manager] != referal, "Recursive referal not allowed");
    _referals[referal] = manager;
  }

  function getOwner() public view returns (address) {
    return _owner;
  }
}
