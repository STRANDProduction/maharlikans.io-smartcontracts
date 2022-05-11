// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

library STRANDCore {
    function getCurrentTimestamp() public view returns (uint) {
        return block.timestamp;
    }
}