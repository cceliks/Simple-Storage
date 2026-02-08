// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ExtraStorage} from "../src/ExtraStorage.sol";

contract ExtraStorageScript is Script {
    ExtraStorage public extraStorage;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        extraStorage = new ExtraStorage();

        vm.stopBroadcast();
    }
}
