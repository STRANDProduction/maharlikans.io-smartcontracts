// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./STRANDCore.sol";

abstract contract STRANDBase {
    modifier lock(uint8 _lock) {
        require(_lock == 0, "Locked");
        _lock = 1;
        _;
        _lock = 0;
    }
}