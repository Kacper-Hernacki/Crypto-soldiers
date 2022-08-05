// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;
import "./soldiersbootcamp.sol";

contract SoldiersPromotion is SoldiersBootcamp {

  function promoteAndGetSubordinate(uint _soldierId, uint _targetCharacteristic) public {
    require(msg.sender == soldierToOwner[_soldierId]);
    Soldier storage mySoldier = soldiers[_soldierId];


    _targetCharacteristic = _targetCharacteristic % characteristicModulus;
    uint newCharacteristic = (mySoldier.characteristic + _targetCharacteristic) / 2;
    _createSoldier("no name", newCharacteristic);


  }
}