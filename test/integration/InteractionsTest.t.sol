//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Test, console} from "lib/forge-std/src/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract IntegrationsTest is Test {
    FundMe fundMe;
    uint256 public constant STARTING_BALANCE = 10 ether;
    uint256 public constant SEND_VALUE = 5e18;
    uint256 public constant GAS_PRICE = 1;
    address USER = makeAddr("User");

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundeMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundeMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
