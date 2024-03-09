// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// Import the Open Zeppelin ERC20 library
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        // Mint the initial supply to the creator of the contract
        _mint(msg.sender, initialSupply);
    }
}
