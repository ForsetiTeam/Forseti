pragma solidity ^0.4.15;

import "../dependencies/ERC20.sol";
import "../dependencies/Ownable.sol";
import "./Pool.sol";

contract PoolFactory {

  mapping (uint => address) pools;
  uint256 poolsCount;
  //uint256 depositValue;
  ERC20 forsToken;

  function PoolFactory(address _token) {
    forsToken = ERC20(_token);
    //depositValue = _depositValue;
  }

  function createPool(address _poolMaster, uint256 _depositStake, string _name) public {
    address newPool = new Pool(_poolMaster, _depositStake, _name);
    pools[poolsCount] = newPool;
    forsToken.transfer(newPool, _depositStake);
  }
}