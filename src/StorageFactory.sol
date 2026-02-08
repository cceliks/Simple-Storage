// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorage() public returns (address) {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
        return address(simpleStorage);
    }

    function sfAddPerson(uint256 _simpleStorageIndex, string memory _name, uint256 _favoriteNumber) public {
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.addPerson(_name, _favoriteNumber);
    }

    function sfGetPerson(uint256 _simpleStorageIndex, address _address)
        public
        view
        returns (SimpleStorage.People memory)
    {
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorage.getPerson(_address);
    }
}
