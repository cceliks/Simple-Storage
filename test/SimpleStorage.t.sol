// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage public simpleStorage;

    function setUp() public {
        simpleStorage = new SimpleStorage();
    }

    function test_AddPerson() public {
        string memory name = "Alice";
        uint256 favoriteNumber = 42;
        address testAddress = 0x1234567890123456789012345678901234567890;

        vm.prank(testAddress);
        simpleStorage.addPerson(name, favoriteNumber);

        SimpleStorage.People memory person = simpleStorage.getPerson(testAddress);

        assertEq(person.favoriteNumber, favoriteNumber);
        assertEq(person.name, name);
    }
}
