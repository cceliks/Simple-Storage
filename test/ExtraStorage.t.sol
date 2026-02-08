// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ExtraStorage} from "../src/ExtraStorage.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract ExtraStorageTest is Test {
    function testAddPersonWithExtraStorage() public {
        ExtraStorage extraStorage = new ExtraStorage();
        string memory name = "Bob";
        uint256 favoriteNumber = 10;

        extraStorage.addPerson(name, favoriteNumber);

        SimpleStorage.People memory person = extraStorage.getPerson(address(this));
        assertEq(person.favoriteNumber, favoriteNumber + 5, "Favorite number should be incremented by 5");
        assertEq(person.name, name, "Name should match");
    }
}
