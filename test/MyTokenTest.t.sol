// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {MyToken} from "../src/MyToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployMyToken} from "script/DeployMyToken.s.sol";

contract MyTokenTest is Test {
    MyToken public myToken;
    DeployMyToken deployMyToken;

    uint256 public constant STARTING_BALANCE = 10 ether;

    address bob = makeAddr("bob");
    address steve = makeAddr("steve");
    address mary = makeAddr("mary");

    function setUp() external {
        deployMyToken = new DeployMyToken();

        myToken = deployMyToken.run();

        //Transfer tokens from token contract to address
        //Reason why we use msg.sender is because the token transfer function takes 2 inputs (to, value), but that function calls the _transfer function which has 3 inputs (from, to, value) ---> the 'from' param is from msg.sender
        vm.prank(msg.sender);
        myToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        console.log("Bob balance: ", myToken.balanceOf(bob));
        assertEq(myToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testDeploymentOfMyTokenAddressNotZero() public view {
        console.log("MyToken address: ", address(myToken));
        assert(address(myToken) != address(0));
    }

    function testInitialSupply() public {
        console.log("Initial supply: ", myToken.totalSupply());
        assertEq(myToken.totalSupply(), 1000 ether);
    }

    function testAllowances() public {
        //ERC20 has transferFrom function
        //If we want the contract to keep track of how many tokens users have, then it needs to be the one to transfer the tokens from you to itself
        //For it to do this, you need to allow it to do it and not just anyone
        //It can allow users to give address X permission to spend up to A tokens on their behalf/approval
        //We want to test the allowances and the limitation of the allowed allowance of the ERC20 token contract

        uint256 initialAllowance = 1000;

        //Bob approves steve to spend tokens on her behalf
        vm.prank(bob);
        myToken.approve(steve, initialAllowance);

        //Get the amount of allowance set for Steve from the _allowances mapping by passing in the approver and the spender(approvee)
        //_allowances mapping variable is private, therefore this does not work and causes compile error(9582): Member "_allowances" not found or not visible after argument-dependent lookup in contract MyToken
        /*
        console.log(
            "Approved allowance for steve: ",
            
            myToken._allowances[bob][steve]
        );

        What we can do is use the balanceOf function in the ERC20 contract to check the current balance of the specified address/user
        */
        console.log("initial balance of steve: ", myToken.balanceOf(steve));
        console.log("initial balance of bob: ", myToken.balanceOf(bob));

        uint256 transferAmount = 500;
        vm.prank(steve);
        //Can see that the transferFrom function allows us to pass a from address and that it is not just automatically set as msg.sender like what happens in normal transfer function
        myToken.transferFrom(bob, steve, transferAmount);

        console.log("current balance of steve: ", myToken.balanceOf(steve));
        console.log("current balance of bob: ", myToken.balanceOf(bob));

        //ASSERT
        assertEq(myToken.balanceOf(steve), transferAmount);
        assertEq(myToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
    //CHATGPT
    function testTransfer() public {
        uint256 transferAmount = 100;
        vm.prank(bob);
        myToken.transfer(steve, transferAmount);
        assertEq(myToken.balanceOf(steve), transferAmount);
        assertEq(myToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
    //CHATGPT
    function testTransferFrom() public {
        uint256 transferAmount = 200;
        vm.prank(bob);
        myToken.approve(steve, transferAmount);

        //transferFrom function takes 3 inputs (from, to, value) --> however, inside the function it treats msg.sender as the 'spender' or the 'to' equivalent and will check the allowance of msg.sender
        //Therfore, we need to spoof our address to be of the spender
        vm.prank(steve);
        myToken.transferFrom(bob, steve, transferAmount);

        assertEq(myToken.balanceOf(steve), transferAmount);
        assertEq(myToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
    //CHATGPT
    function testTransferFromInsufficientAllowance() public {
        uint256 transferAmount = 1000;
        vm.prank(bob);
        myToken.approve(steve, transferAmount);
        // Trying to transfer more than the approved amount should fail
        vm.expectRevert();
        //transferFrom function takes 3 inputs (from, to, value) --> however, inside the function it treats msg.sender as the 'spender' or the 'to' equivalent and will check the allowance of msg.sender
        //Therfore, we need to spoof our address to be of the spender
        vm.prank(steve);
        myToken.transferFrom(bob, steve, transferAmount + 1);
    }

    //CHATGPT
    function testTransferFromInsufficientBalance() public {
        uint256 transferAmount = STARTING_BALANCE + 1;
        vm.prank(bob);
        myToken.approve(steve, transferAmount);
        // Trying to transfer more than the balance should fail
        vm.expectRevert();
        myToken.transferFrom(bob, steve, transferAmount);
    }

    //CHATGPT
    function testApprove() public {
        uint256 approvalAmount = 500;
        myToken.approve(steve, approvalAmount);
        assertEq(
            myToken.allowance(address(this), address(steve)),
            approvalAmount
        );
    }
    /* CHATGPT TESTS THAT USE FUNCTIONS WE DON"T HAVE
    function testDecreaseAllowance() public {
        uint256 initialApprovalAmount = 500;
        uint256 decreaseAmount = 200;
        myToken.approve(steve, initialApprovalAmount);
        myToken.decreaseAllowance(steve, decreaseAmount);
        assertEq(
            myToken.allowance(address(bob), address(steve)),
            initialApprovalAmount - decreaseAmount
        );
    }

    function testIncreaseAllowance() public {
        uint256 initialApprovalAmount = 500;
        uint256 increaseAmount = 200;
        myToken.approve(steve, initialApprovalAmount);
        myToken.increaseAllowance(steve, increaseAmount);
        assertEq(
            myToken.allowance(address(bob), address(steve)),
            initialApprovalAmount + increaseAmount
        );
    }
    
    function testBurn() public {
        uint256 burnAmount = 100;
        myToken.burn(burnAmount);
        assertEq(
            myToken.balanceOf(address(this)),
            STARTING_BALANCE - burnAmount
        );
        assertEq(myToken.totalSupply(), 1000 ether - burnAmount);
    }

    function testBurnFrom() public {
        uint256 burnAmount = 100;
        myToken.approve(address(this), burnAmount);
        myToken.burnFrom(bob, burnAmount);
        assertEq(myToken.balanceOf(bob), STARTING_BALANCE - burnAmount);
        assertEq(myToken.totalSupply(), 1000 ether - burnAmount);
    }

    */
}
