// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {RabbitCity} from "src/RabbitCity.sol";

contract RabbitCityTest is Test {
  RabbitCity public instance;

  function setUp() public {
    address initialOwner = vm.addr(1);
    address proxy = Upgrades.deployTransparentProxy(
      "RabbitCity.sol",
      initialOwner,
      abi.encodeCall(RabbitCity.initialize, (initialOwner))
    );
    instance = RabbitCity(proxy);
  }

  function testName() public view {
    assertEq(instance.name(), "RabbitCity");
  }
}
