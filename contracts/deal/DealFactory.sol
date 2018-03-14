pragma solidity ^0.4.0;

import "./Deal.sol";
import "./PermissionExtension.sol";

contract DealFactory is PermissionExtension {

  address[] activeDeals;

  function createDeal(bytes32 title) returns (address){
    address newDeal = new Deal(msg.sender, title);
    setPerm(newDeal, "changeReputation");
    return (newDeal);
  }
}