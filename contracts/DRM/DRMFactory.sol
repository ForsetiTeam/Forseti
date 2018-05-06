pragma solidity ^0.4.15;

import './DRM.sol';

contract DRMFactory {

  mapping (address => bool) public activeDisputes;
  mapping (uint256 => address) public IdDisputes;
  uint256 public disputesCounter;

  function createDispute(address _pool, bytes32 _argumentsHash, uint _arbitratorsNumber) public {
    address newDispute = new DRM(_pool, _argumentsHash, msg.sender, _arbitratorsNumber);
    disputesCounter +=1;
    activeDisputes[newDispute] = true;
    IdDisputes[disputesCounter] = newDispute;
  }

  function closeDispute() public {
    activeDisputes[msg.sender] = false;
  }
}
