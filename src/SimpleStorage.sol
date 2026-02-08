// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleStorage {
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    mapping(address => People) public people;

    function addPerson(string memory _name, uint256 _favoriteNumber) public virtual {
        people[msg.sender] = People(_favoriteNumber, _name);
    }

    function getPerson(address _address) public view returns (People memory) {
        People memory person = people[_address];
        return person;
    }
}
