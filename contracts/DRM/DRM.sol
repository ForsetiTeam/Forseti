pragma solidity ^0.4.15;

import "../dependencies/Ownable.sol";
import "../Pools/Pool.sol";

contract DRM  {

  address disputeCreator;
  address pool;
  bytes32 argumentsHash;
  string result;

  bool disputeResolved;
  bool public votesProvided;

  uint256 blockForSeed;
  uint arbitratorsNumber;

  mapping (uint256 => address) public arbitrators;
  mapping (uint256 => bytes32) public votes;

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


  function setArbitratorsAndVotes(bytes32[] _msgHash, uint8[] _v, bytes32[] _r, bytes32[] _s) public returns(bool)  {
    for (uint i = 0; i < _msgHash.length; i++ ) {
      arbitrators[i] = validate(_msgHash[i], _v[i], _r[i], _s[i]);
      votes[i] = _msgHash[i];
    }
    votesProvided = true;
    return true;
  }

  function validate(bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) view public returns (address) {
    bool ret;
    address addr;
    bytes memory prefix = "\x19Ethereum Signed Message:\n32";
    bytes32 prefixedHash = keccak256(prefix, msgHash);

    assembly {
      let size := mload(0x40)
      mstore(size, prefixedHash)
      mstore(add(size, 32), v)
      mstore(add(size, 64), r)
      mstore(add(size, 96), s)
      ret := call(3000, 1, 0, size, 128, size, 32)
      addr := mload(size)
    }
    return addr;
  }

  function testRecovery(bytes32 h, uint8 v, bytes32 r, bytes32 s) pure public returns (address) {
    bytes memory prefix = "\x19Ethereum Signed Message:\n32";
    bytes32 prefixedHash = keccak256(prefix, h);
    address addr = ecrecover(prefixedHash, v, r, s);

    return addr;
  }


  function getResult() public view returns(string) {
    require(disputeResolved);
    return result;
  }

/*
  function checkMessage(bytes32 _message, uint8 _v, bytes32 _r, bytes32 _s) returns (bytes32) {

  }
*/
  // TO DO service reward
  //function serviceReward() {}
}
