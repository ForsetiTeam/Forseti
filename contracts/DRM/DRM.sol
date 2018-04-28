pragma solidity ^0.4.15;

import "../dependencies/Ownable.sol";
import "../Pools/Pool.sol";

contract DRM  {

  address disputeCreator;
  address pool;
  bytes32 argumentsHash;
  string result;
  bool disputeResolved;
  uint256 blockForSeed;
  uint arbitratorsNumber;
  mapping (uint256 => address) arbitrators;
  mapping (address => bytes32) votes;

  event DRMcreate(address _diputeCreator, address _dispute);
  event resultCommited(string);

  modifier onlyPoolMaster() {
    require(msg.sender == Pool(pool).poolMaster());
    _;
  }


  function DRM(address _pool, bytes32 _argumentsHash, address _disputeCreator, uint _arbitratorsNumber) public {
    DRMcreate(_disputeCreator, this);
    argumentsHash = _argumentsHash;
    pool = _pool;
    disputeCreator = _disputeCreator;
    blockForSeed = block.number + 1;
    arbitratorsNumber = _arbitratorsNumber;
  }


  function getSeed() public view returns(bytes32) {
    return block.blockhash(blockForSeed);
  }


  function setResult(string _result) onlyPoolMaster public {
    result = _result;
    resultCommited(result);
    disputeResolved = true;
  }


  function setArbitratorsAndVotes(address[] _arbitrators) onlyPoolMaster {
    for (uint i; i < arbitratorsNumber; i++ ) {
      arbitrators[i] = _arbitrators[i];
    }
    // TO DO set arbitrators votes with ecrecover
    // need test gasLimit for this function (how much iterations could be in one transaction)
  }

  function getResult() public view returns(string) {
    require(disputeResolved);
    return result;
  }

  // TO DO service reward
  //function serviceReward() {}
}
