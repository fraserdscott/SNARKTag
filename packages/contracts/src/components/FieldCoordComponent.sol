// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;
import "solecs/Component.sol";

struct Position {
  uint256 x;
  uint256 y;
}

contract FieldCoordComponent is Component {
  constructor(address world, uint256 id) Component(world, id) {}

  function getSchema() public pure override returns (string[] memory keys, LibTypes.SchemaValue[] memory values) {
    keys = new string[](2);
    values = new LibTypes.SchemaValue[](2);

    keys[0] = "x";
    values[0] = LibTypes.SchemaValue.UINT256;

    keys[1] = "y";
    values[1] = LibTypes.SchemaValue.UINT256;
  }

  function set(uint256 entity, Position calldata value) public {
    set(entity, abi.encode(value.x, value.y));
  }

  function getValue(uint256 entity) public view returns (Position memory) {
    (uint256 x, uint256 y) = abi.decode(getRawValue(entity), (uint256, uint256));
    return Position(x, y);
  }

  function getEntitiesWithValue(Position calldata position) public view returns (uint256[] memory) {
    return getEntitiesWithValue(abi.encode(position));
  }
}
