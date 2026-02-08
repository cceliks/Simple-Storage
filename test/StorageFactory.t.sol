// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {StorageFactory} from "../src/StorageFactory.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract StorageFactoryTest is Test {
    StorageFactory public storageFactory;

    address user1 = address(0x1);
    address user2 = address(0x2);
    address user3 = address(0x3);

    function setUp() public {
        storageFactory = new StorageFactory();
    }

    // Test creating a SimpleStorage contract
    function testCreateSimpleStorage() public {
        address simpleStorageAddress = storageFactory.createSimpleStorage();

        assertNotEq(simpleStorageAddress, address(0), "SimpleStorage address should not be zero");
        assertEq(address(storageFactory.simpleStorageArray(0)), simpleStorageAddress, "Address should match");
    }

    // Test creating multiple SimpleStorage contracts
    function testCreateMultipleSimpleStorages() public {
        address ss1 = storageFactory.createSimpleStorage();
        address ss2 = storageFactory.createSimpleStorage();
        address ss3 = storageFactory.createSimpleStorage();

        assertNotEq(ss1, ss2, "Contracts should have different addresses");
        assertNotEq(ss2, ss3, "Contracts should have different addresses");
        assertNotEq(ss1, ss3, "Contracts should have different addresses");

        assertEq(address(storageFactory.simpleStorageArray(0)), ss1, "First address should match");
        assertEq(address(storageFactory.simpleStorageArray(1)), ss2, "Second address should match");
        assertEq(address(storageFactory.simpleStorageArray(2)), ss3, "Third address should match");
    }

    // Test adding and getting a person from StorageFactory
    function testAddAndGetPerson() public {
        string memory name = "Alice";
        uint256 favoriteNumber = 42;

        storageFactory.createSimpleStorage();

        storageFactory.sfAddPerson(0, name, favoriteNumber);

        SimpleStorage.People memory person = storageFactory.sfGetPerson(0, address(storageFactory));
        assertEq(person.favoriteNumber, favoriteNumber, "Favorite number should match");
        assertEq(person.name, name, "Name should match");
    }

    // Test adding multiple people to the same SimpleStorage
    function testAddMultiplePeopleToSameStorage() public {
        storageFactory.createSimpleStorage();

        // Add first person
        storageFactory.sfAddPerson(0, "Alice", 42);

        // Verify person (stored under StorageFactory address)
        SimpleStorage.People memory person = storageFactory.sfGetPerson(0, address(storageFactory));
        assertEq(person.name, "Alice");
        assertEq(person.favoriteNumber, 42);
    }

    // Test using different SimpleStorage instances
    function testMultipleStoragesWithPeople() public {
        storageFactory.createSimpleStorage();
        storageFactory.createSimpleStorage();

        // Add person to first storage
        storageFactory.sfAddPerson(0, "Storage1Person", 100);

        // Add person to second storage
        storageFactory.sfAddPerson(1, "Storage2Person", 200);

        // Verify they're in different storages
        SimpleStorage.People memory person1 = storageFactory.sfGetPerson(0, address(storageFactory));
        SimpleStorage.People memory person2 = storageFactory.sfGetPerson(1, address(storageFactory));

        assertEq(person1.favoriteNumber, 100);
        assertEq(person1.name, "Storage1Person");

        assertEq(person2.favoriteNumber, 200);
        assertEq(person2.name, "Storage2Person");
    }

    // Test updating a person's data
    function testUpdatePersonData() public {
        storageFactory.createSimpleStorage();

        // Add initial person
        storageFactory.sfAddPerson(0, "Alice", 42);

        SimpleStorage.People memory person = storageFactory.sfGetPerson(0, address(storageFactory));
        assertEq(person.favoriteNumber, 42);

        // Update the person
        storageFactory.sfAddPerson(0, "Alice Updated", 99);

        person = storageFactory.sfGetPerson(0, address(storageFactory));
        assertEq(person.favoriteNumber, 99);
        assertEq(person.name, "Alice Updated");
    }

    // Test retrieving non-existent person (should return empty struct)
    function testGetNonExistentPerson() public {
        storageFactory.createSimpleStorage();

        SimpleStorage.People memory person = storageFactory.sfGetPerson(0, user1);
        assertEq(person.favoriteNumber, 0);
        assertEq(keccak256(abi.encodePacked(person.name)), keccak256(abi.encodePacked("")));
    }

    // Test with empty string name
    function testAddPersonWithEmptyName() public {
        storageFactory.createSimpleStorage();

        storageFactory.sfAddPerson(0, "", 50);

        SimpleStorage.People memory person = storageFactory.sfGetPerson(0, address(storageFactory));
        assertEq(person.favoriteNumber, 50);
        assertEq(keccak256(abi.encodePacked(person.name)), keccak256(abi.encodePacked("")));
    }

    // Test with zero favorite number
    function testAddPersonWithZeroFavoriteNumber() public {
        storageFactory.createSimpleStorage();

        storageFactory.sfAddPerson(0, "Zoe", 0);

        SimpleStorage.People memory person = storageFactory.sfGetPerson(0, address(storageFactory));
        assertEq(person.favoriteNumber, 0);
        assertEq(person.name, "Zoe");
    }

    // Test with large favorite number
    function testAddPersonWithLargeFavoriteNumber() public {
        storageFactory.createSimpleStorage();

        uint256 largeNumber = type(uint256).max;
        storageFactory.sfAddPerson(0, "BigFan", largeNumber);

        SimpleStorage.People memory person = storageFactory.sfGetPerson(0, address(storageFactory));
        assertEq(person.favoriteNumber, largeNumber);
        assertEq(person.name, "BigFan");
    }
}
