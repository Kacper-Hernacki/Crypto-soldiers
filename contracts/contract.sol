// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Soldiers {
    uint characteristicDigits = 16;
    uint characteristicModulus = 10 ** characteristicDigits;
   
   struct Soldier {
    string name;
    uint characteristic;
   }

    Soldier[] public soldiers;

    function _createSoldier(string memory _name, uint _characteristic) private {
        soldiers.push(Soldier(_name, _characteristic));
    }


    function _generateRandomCharacteristic(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % characteristicModulus;
    }

       function createRandomSoldier(string memory _name) public {
        uint randCharacteristic = _generateRandomCharacteristic(_name);
        _createSoldier(_name, randCharacteristic);
    }

}
