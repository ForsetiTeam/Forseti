pragma solidity ^0.4.15;


contract Pool {

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
  string public name;

  mapping (uint256 => Member) membersId;
  uint256 membersCount;
  //Member[] pendingMembers;

  function Pool(address _poolMaster, uint256 _depositStake, string _name) public {
    name = _name;
    poolMaster = _poolMaster;
    depositStake = _depositStake;
  }

  /*
  function addNewMember(address _ethAddress)  public {
    pendingMembers.push(Member());
  }
  */

  function addNewMember(address _ethAddress) onlyPoolMaster {
    membersId[membersCount + 1] = Member(1 , _ethAddress);
  }


}
