// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 r = x + y;
        require(r >= x, "Safemath: addition overflow");
        return r;
    }

    function subtract(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y <= x, "Safemath: subtraction overflow");
        uint256 r = x - y;
        return r;
    }

    function multiply(uint256 x, uint256 y) internal pure returns (uint256) {
        // gas optimization
        if (x == 0 || y == 0) {
            return 0;
        }

        uint256 r = x * y;
        require(r / x == y, "SafeMath: multiplication overflow");
        return r;
    }

    function divide(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y > 0, "SafeMath: division overflow");
        uint256 r = x / y;
        return r;
    }

    function mod(uint256 x, uint256 y) internal pure returns (uint256) {
        require (y != 0, "SafeMath: module by zero");
        return x % y;
    }
}
