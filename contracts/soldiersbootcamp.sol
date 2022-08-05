// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract SoldiersBootcamp {
    event NewSoldier(uint soldierId, string name, uint characteristic);

    uint characteristicDigits = 16;
    uint characteristicModulus = 10 ** characteristicDigits;
   
   struct Soldier {
    string name;
    uint characteristic;
   }

    Soldier[] public soldiers;

    mapping (uint => address) public soldierToOwner;
    mapping (address => uint) ownerSoldierCount;

    function _createSoldier(string memory _name, uint _characteristic) internal {
        soldiers.push(Soldier(_name, _characteristic));
        uint id = soldiers.length -1;
        soldierToOwner[id] = msg.sender;
        ownerSoldierCount[msg.sender]++;
        emit NewSoldier(id, _name, _characteristic);
    }


    function _generateRandomCharacteristic(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % characteristicModulus;
    }

       function createRandomSoldier(string memory _name) public {
        require(ownerSoldierCount[msg.sender] == 0);
        uint randCharacteristic = _generateRandomCharacteristic(_name);
        _createSoldier(_name, randCharacteristic);
    }

}

