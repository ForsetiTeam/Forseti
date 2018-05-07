pragma solidity ^0.4.15;

import "../dependencies/SafeMath.sol";

contract Pool {

  using SafeMath for uint256;

  modifier onlyPoolMaster() {
    require(msg.sender == poolMaster);
    _;
  }

  struct Member {
  uint256 reputationPoints;
  address ethAddress;
  }

  address public poolMaster;
  uint256 public depositStake;
  uint256 public membersLimit;
  string public name;

  mapping (uint256 => Member) public membersId;
  mapping (uint256 => Member) public pendingMembers;
  uint256 public membersCount;
  uint256 public pendingCount;
  //Member[] pendingMembers;

  function Pool(address _poolMaster, uint256 _depositStake, string _name) public {
    name = _name;
    poolMaster = _poolMaster;
    depositStake = _depositStake;
    membersLimit = depositStake.div(1 ether);
  }

  /*
  function addNewMember(address _ethAddress)  public {
    pendingMembers.push(Member());
  }
  */

  function BecomeNewMember() public  {
    pendingMembers[pendingCount + 1] = Member(1 , msg.sender);
    pendingCount += 1;
  }

  function confirmNewMember(uint256 id) public onlyPoolMaster {
    membersId[membersCount + 1] =  pendingMembers[id];
    membersCount += 1;
    delete pendingMembers[id];
  }

  function getMembersReputation(uint256 _id) public view returns(uint256) {
    return membersId[_id].reputationPoints;
  }

  function getMembersAddress(uint256 _id) public view returns(address) {
    return membersId[_id].ethAddress;
  }

}
// need check confirmNewMember