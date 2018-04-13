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

  event DRMcreate(address _diputeCreator, address _dispute);
  event resultCommited(string);

  modifier onlyPoolMaster() {
    require(msg.sender == Pool(pool).poolMaster());
    _;
  }

  function DRM(address _pool, bytes32 _argumentsHash, address _disputeCreator) public {
    DRMcreate(_disputeCreator, this);
    argumentsHash = _argumentsHash;
    pool = _pool;
    disputeCreator = _disputeCreator;
    blockForSeed = block.number + 1;
  }

  function getSeed() public view returns(bytes32) {
    return keccak256(block.blockhash(blockForSeed));
  }

  function setResult(string _result) onlyPoolMaster public {
    result = _result;
    resultCommited(result);
    disputeResolved = true;
  }

  function getResult() public view returns(string) {
    require(disputeResolved);
    return result;
  }
}
