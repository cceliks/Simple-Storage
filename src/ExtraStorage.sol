// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {SimpleStorage} from "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    function addPerson(string memory _name, uint256 _favoriteNumber) public override {
        super.addPerson(_name, _favoriteNumber + 5);
    }
}
