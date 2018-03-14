pragma solidity ^0.4.0;


import "./DealExtension.sol";

contract Deal is DealExtension {

  address customer;
  address executor;
  bytes32 title;


  function Deal(address _customer, bytes32 _title) {
    title = _title;
    customer = _customer;
  }

  function becomeExecutor() {
    executor = msg.sender;
  }

  function finishDeal(int value) {
    changeReputation(msg.sender, value, "testCategory") ;
  }

}