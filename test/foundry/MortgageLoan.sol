// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "contracts/MortgageLoan.sol";

contract MortgageLoanTest is Test {
    MortgageLoan public mortgageLoan;
  
    // Arrange everything you need to run your tests
    function setUp() public {
        mortgageLoan = new MortgageLoan();
    }

}
