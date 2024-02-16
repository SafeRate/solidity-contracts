// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "contracts/Mortgage.sol";

contract MortgageTest is Test {
    Mortgage public mortgage;
  
    // Arrange everything you need to run your tests
    function setUp() public {
        mortgage = new Mortgage();
        mortgage.setLoanNumber(2);
    }

    function testLoanNumber() public {
        console.log("address: ", address(mortgage));
        console.log("loanNumber: ", mortgage.getLoanNumber());
        // Act
        uint loanNumber = mortgage.getLoanNumber();
        // Assert
        assertEq(loanNumber, 2);
    }
}
