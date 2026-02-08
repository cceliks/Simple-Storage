// SPDX-Lİcense-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StorageFactory} from "../src/StorageFactory.sol";

contract StorageFactoryScript is Script {
    StorageFactory public storageFactory;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        storageFactory = new StorageFactory();

        vm.stopBroadcast();
    }
}
