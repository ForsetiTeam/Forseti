pragma solidity ^0.4.0;

import "./Reputation.sol";

contract DealExtension {

  address reputationContractAddress = 0x0;
  address forsetiAddress = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
  string key;

  modifier onlyForseti {
    require(msg.sender == forsetiAddress);
    _;
  }

  function changeReputation(address userAddress, int value, string category) internal {
    Reputation(reputationContractAddress).change(userAddress, value, category);
  }

  function setReputationContractAddress(address newAddress) onlyForseti {
    reputationContractAddress = newAddress;
  }

  function test() internal returns(uint) {
    return (1);
  }
}