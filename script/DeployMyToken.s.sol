// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {MyToken} from "../src/MyToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployMyToken is Script {
    //Initial supply variable to pass to ERC20 MyToken contract
    uint256 public constant INITIAL_SUPPLY = 10000 ether;

    function run() external returns (MyToken) {
        //Start the broadcast to allow the creation of the contract
        vm.startBroadcast();

        MyToken deployedToken = new MyToken(INITIAL_SUPPLY);

        //Stop the broadcast
        vm.stopBroadcast();

        return (deployedToken);
    }
}
