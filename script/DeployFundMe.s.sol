//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelperConfig hc = new HelperConfig();
        address priceFeed = hc.activeNetworkConfig();
        vm.startBroadcast();
        //Mock
        FundMe fumdMe = new FundMe(priceFeed);
        vm.stopBroadcast();
        return fumdMe;
    }
}
