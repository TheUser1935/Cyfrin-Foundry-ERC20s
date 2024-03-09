// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {MyToken} from "../src/MyToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployMyToken} from "script/DeployMyToken.s.sol";

contract MyTokenTest is Test {
    MyToken myToken;

    function setUp() external {
        DeployMyToken deployMyToken = new DeployMyToken();

        myToken = deployMyToken.run();
    }

    function testDeploymentOfMyTokenAddressNotZero() public {
        console.log("MyToken address: ", address(myToken));
        assert(address(myToken) != address(0));
    }
}
